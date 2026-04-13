Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A27381B1C
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776056205; cv=none; b=Ydx2B+h0UpI2ZLlWlkcFLtFV6h4M+WuGWjsDdp2bnO2T8LQ/FlhOQVhqs1dnZ7+RnT1CEwpdcRbFbnlLR7lti2kfgF6AxOzddnqJ6ZTP9Bffxfls85R6+WCt5d0sHS9fcG1BJAHgMMp5dGQQG1EZMMYiWea9yQmTmqUyXdxj47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776056205; c=relaxed/simple;
	bh=5kf7RgTH0WPvmO64CjiIJvq98vHfsWYiLBxA5u/0h1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gANzal611CzGj6j1ifZCqGHzDB8AZcUd0EApPBWbP3c5vd7mNHScpCmSML0F1/0G0TTGfZ5AHGVBBRHNZ3gKDCyREbyEytTNwQWS8KlaJYZ3LrIpzK07ireUC/sJIY4V7qDxgx2m52vG1x36eKqANpqW+PyRaPrd30kQ/pznAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umVT60Vl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umVT60Vl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41244C116C6;
	Mon, 13 Apr 2026 04:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776056205;
	bh=5kf7RgTH0WPvmO64CjiIJvq98vHfsWYiLBxA5u/0h1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=umVT60Vl6mxd1cMcMnrv1A3JNEUJ2Pe0huNs9cjnUfpmAlqIilgwfz8ixGCXVPF8R
	 upEH1gCSmHXIB8jvBfRPHcLBj+d137vTbmu4TcRGHBgEjLaqZsB0s6xetbTmHvRcXd
	 NfPm0Kc2FVv4ZrIkttbAZwkuKUWcMjs5DwA/qBO+IclZMzMECHPF7NRlLUdSbL9al3
	 boYtlTMoRBkOIO2DARjmAfyDKfDv/myM3eIC4GnbqdlrZ/1I1bzdkhFxIH9gdCIUzO
	 4ESe/BfkSWadH5p5lXgDRuwnS/lYtyYa2Vqn+6/98s4euDYbMpSZiWEc28exB2GejT
	 cBhhA61kTc07Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 31/33] perf evsel: Add bounds checking to trace
 point raw data accessors
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-32-irogers@google.com>
References: <20260413041143.1736055-32-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 04:56:44 +0000
Message-Id: <20260413045645.41244C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The `out_of_bounds` helper uses `pr_warning()` instead of a rate=
-limited logging function, which will cause a denial of service (console fl=
ooding) when processing malformed trace data.
--

commit f063887da379b6999ed28dc220458791de834acf
Author: Ian Rogers <irogers@google.com>

perf evsel: Add bounds checking to trace point raw data accessors

This commit adds bounds checking to prevent tracepoint fields from reading
out of bounds. It also fixes handling of dynamic tracepoint fields when
endianness varies by byte swapping the data.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index bb48568b8101a..713a250c73740 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3700,22 +3700,63 @@ struct tep_format_field *evsel__common_field(stru=
ct evsel *evsel, const char *na
>  	return tp_format ? tep_find_common_field(tp_format, name) : NULL;
>  }
> =20
> +static bool out_of_bounds(const struct tep_format_field *field, int offs=
et, int size, u32 raw_size)
> +{
> +	if (offset < 0) {
> +		pr_warning("Negative trace point field offset %d in %s\n",
> +			   offset, field->name);
> +		return true;
> +	}
> +	if (size < 0) {
> +		pr_warning("Negative trace point field size %d in %s\n",
> +			   size, field->name);
> +		return true;
> +	}
> +	if ((u32)offset + (u32)size > raw_size) {
> +		pr_warning("Out of bound tracepoint field (%s) offset %d size %d in %u=
\n",
> +			   field->name, offset, size, raw_size);

Could this cause console flooding if the trace data is malformed?

Since perf_sample__rawptr() and format_field__intval() are called per-field
for every sample in the trace, and a typical perf.data file can contain
millions of samples, using unconditional logging like pr_warning() might fl=
ood
the console.

Would it be better to use a rate-limited or once-per-run logging function
such as pr_warning_once() here to avoid making the tool unresponsive?

> +		return true;
> +	}
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D31
