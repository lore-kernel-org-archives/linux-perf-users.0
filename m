Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEF335DA75
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307196; cv=none; b=gBM+1wXEatrx1qez/++MQac5gQJVUp0gMohOiuZu2T45fya/Jp2xjZQ08qHhD2dFikgUbnMHtYlnHrpdkWu56lnuM4qHlYrVN1P6inxHtD3f7bu7d4RbMEkEfuWVmFTW54Yn96YaK+ehSpiUa/qjnRvAhpbumf3Os3IcXPVI54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307196; c=relaxed/simple;
	bh=wiLsUlYviO4Zw/Gj/HpSxjzJq7Zc2+mkNtw2UMaWMH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UBLHAyFgyJ6TyyHVrzceEvJZ8ENQUktM2NamqdFoZ1SRko346uBS/jLFbY6B+Bnzd6zZGLTz0Jg6SG7ko+i5J7J2Hzc6TZWfQ0Xzco3Gdr+otzpeFcN9+P7T3JHADkZQzsyK+D4P7Fi5xBBdEyU06iT6jJs1ZaCYkQlmQOajMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcTF6ACV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcTF6ACV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1AA1F00893;
	Wed, 20 May 2026 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307194;
	bh=LnJVVyG/YeFIiWwCVuCi1Gb6D2ngS6yQGaBRdCuXEtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RcTF6ACVyZCrClgzapLoK6Dg9sNXVVmqezPtnieAbmxUwfB2HX3vsHSMi/Xf/J324
	 i59fSiNX7Dluy5YPBI+AT5P3dPczm9Sp1hoRm5/gRwisDMluILCYN+BDPj4T3Eaf+O
	 39m3HT/HqTpsLKo9dQwNJ5gNWmCW0+b/kPhdzHZSPuuwccX2lpTKKv795KaAomGrVM
	 xLxUl6AaoJvqPnkbSiLX3fy1EdXD5Rfg4JWQQZYYO/oSNkhPO/pNLHXWrX1zkhoLim
	 1cujqTBhEacl4q62l7Jl5DiXpyVZd1OtJzuJvonJLUASB56rseG9sIs8LICyMyUgdJ
	 0j/t2KwjMa8kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 30/32] perf evsel: Add bounds checking to trace
 point raw data accessors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520190538.142018-31-irogers@google.com>
References: <20260520190538.142018-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 19:59:54 +0000
Message-Id: <20260520195954.9E1AA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added out_of_bounds() helper prints warnings without rate=
 limiting, which can lead to excessive log spam.
--

commit f6d9f44b46370b4bf2d18ef92c31007bb8804554
Author: Ian Rogers <irogers@google.com>

perf evsel: Add bounds checking to trace point raw data accessors

This commit adds bounds checking to tracepoint raw data accessors to prevent
out-of-bounds memory reads when parsing perf.data files. It introduces an
out_of_bounds helper to validate field offsets and sizes against the sample
raw_size. It also handles newer relative dynamic tracepoint fields and
byte-swapping for cross-endian parsing.

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

[Severity: Low]
Since perf_sample__rawptr and format_field__intval are called for every
parsed field across potentially millions of samples, could these pr_warning
calls lead to excessive log spam when parsing a corrupted file?

Would it be better to use pr_warning_once or similar rate limiting to
prevent flooding the terminal?

> +		return true;
> +	}
> +	return false;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520190538.1420=
18-1-irogers@google.com?part=3D30
