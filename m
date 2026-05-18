Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25938911E
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127957; cv=none; b=Hv/+XV3mVgyOt6A5rLpZ168OEm+/sPmlivLPnx3E41wPfEMPGSvI9hOlFVE2knCuQklQ2azu73YPCllaA5nWpuk9lDU7gtb7HTe6mnkMOPzhvaLBuGJg1pD8U7XUWzKqYg6VLvx691cUiXdxb4q84bLBJfSWRsK7hMckVK9+ThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127957; c=relaxed/simple;
	bh=4V94P25+wTzz8lm9iRU+uaLEqprlQdE99aPXt7ed914=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WU41BP3hxFwob7fFklZ1gRO9JTCGY6/hpcsQLkdutKpTbgfurq7BJ4oBh2/tcdjwOdpAYHUi3+TW0SbrEgHFTYBfF286tesEbGIPySsdQOiOfFNQFmw/RJZsuZFlRrD3MX8JeyxMPTkrQdYm8lBOVcWtl4uP94T2TYu8rhmE71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQyAESdf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQyAESdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BABC2BCB7;
	Mon, 18 May 2026 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779127957;
	bh=4V94P25+wTzz8lm9iRU+uaLEqprlQdE99aPXt7ed914=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rQyAESdfS8lzODqcFu+Sst6NdHQwh6GBa+ZdCWGSksUK3PKDDZsAVcXBXgVDuBzUt
	 +ei+QLXixXFc8K733xvJVqG8Dw/Eo7JSsWLbZf43HVtOKSIPgl7D0MtIKPkcwuYHTn
	 5RQXxHRf3Dp53yShBc1ZL6CJaKG0n1MatzQe1e4jMW5EovgsceLbcsqRgZoXnXL8F4
	 QU5Vae+a+iyd/L5SricrxDzpSyzG/apJqv/luARTop3Hl0HlEJHQVjZubO1iIgSfVC
	 hzjvuzCA35uz4EYjM5xHd6Zjiybc+ddlLncQa1HIPP9rkrULCx03p/UoYieuYKai5G
	 uofioA3nxnUJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518171231.2834947-3-irogers@google.com>
References: <20260518171231.2834947-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 18:12:36 +0000
Message-Id: <20260518181236.B3BABC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added event size validation in `perf_event__repipe_att=
r` is executed after a memory copy and is vulnerable to integer overflow on=
 32-bit architectures.
--

commit d1753b02b3fecbf4dd36f4b01ecfc58131e9bfb4
Author: Ian Rogers <irogers@google.com>
perf inject: Fix itrace branch stack synthesis

This commit fixes several issues when synthesizing branch stacks from AUX
data using perf inject --itrace=3DL. It corrects missing branch stack flags,
resolves memory leaks, and adds size validation to prevent buffer overflows
and parse failures.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5f06ee1c14a08..862e178491053 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -231,7 +242,30 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
>  	if (!inject->output.is_pipe)
>  		return 0;
> =20
> -	return perf_event__repipe_synth(tool, event);
> +	if (!inject->itrace_synth_opts.set)
> +		return perf_event__repipe_synth(tool, event);
> +
> +	memset(&attr, 0, sizeof(attr));
> +	memcpy(&attr, &event->attr.attr,
> +	       min_t(size_t, sizeof(attr), (size_t)event->attr.attr.size));

Could this result in an out-of-bounds read from the event buffer if a
malformed event provides a large attr.size but a very small header.size?

The size validation check happens just after this memcpy. Would it be safer
to move the event->header.size check before the memcpy?

> +
> +	if (event->header.size < sizeof(event->header) + event->attr.attr.size)=
 {
> +		pr_err("Attribute event size %u is too small\n", event->header.size);
> +		return -EINVAL;
> +	}

On 32-bit architectures, can the addition of sizeof(event->header) and
event->attr.attr.size overflow if the provided attr.size is exceptionally
large (like 0xFFFFFFF8)?

If it wraps around to a small value, it seems it would bypass this check
entirely and cause an underflow in the n_ids calculation below, potentially
leading to out-of-bounds memory accesses in perf_event__synthesize_attr().

> +	n_ids =3D event->header.size - sizeof(event->header) - event->attr.attr=
.size;
> +	n_ids /=3D sizeof(u64);
> +	ids =3D perf_record_header_attr_id(event);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518171231.2834=
947-1-irogers@google.com?part=3D2
