Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6929C33F
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898432; cv=none; b=fUX9ZgjJvBIWuZl+dgXiZDb1JUu5oEAeGUhKk4/pDYcZBCnqI5IOTyxrBmMnpgGWnnCuzbWzOk6ucF3JUhoMCNzgUylSYygn+xh8NwtFhjESfqN6d3q0hCP1LrThZcrVJluAXnJliOFnYIferYwvPx4H8UgRX9MVnnRND07AqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898432; c=relaxed/simple;
	bh=FRhQocRIRqQbd+7vmW+kx+EQAnfALpxy9cPXSUP4kMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k8jMCKkZ4Thhck3FZLCzqc41lpeDvqa/IGHM9eZgQp2LnQedi3igdWJqtVpHSdsQV9qEITAAX/zvTmYK+GrQmjGWV1PsVJ4MYLVycevovmQPEkMGvdTmUo1BDxp215jb6WxSNdJThFgoqC6VPFFB2nhatxzI8dyHBdvJdoV7nXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh9pvtOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh9pvtOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610F31F00893;
	Mon,  8 Jun 2026 06:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780898428;
	bh=idfh1GcpYWoFw9xqgxOlJerVWJdXXWBvOvRVlbWJWRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bh9pvtOdn2hMtrE0mV5lG/TUwdxrfSylE+G3v3hvHaXdla6VTAl3oq/nlQBterLn/
	 GibcOcmYpYkgnJOCOgoWTeG4hxzdZo4Nzu2V15tTAx/mF4spMiSJvMVNxN1Xtkw03C
	 ZixxqMhwM6AXLij04z+gwK4dHmObFmUAZQulOBTPfUcPdrQltjhE7IMRAd1MHdt97p
	 el3usRd9Yd2AK7XqkSQznfrwB+bqYs+a1FN1+zLeLBQF8cOj9fnWW22noVhyX3u5cT
	 ZEZmyJ8kygdZZqSWXM7+ixKY6iZgOzEm+UAieImkoWNGvcfTBGUgAB38aZ8Ar/3/YB
	 2bPTp9IJmxvsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 3/5] perf inject/aslr: Implement sample address
 remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608054841.3856224-4-irogers@google.com>
References: <20260608054841.3856224-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 06:00:26 +0000
Message-Id: <20260608060027.610F31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `PERF_SAMPLE_CPU` payload is blindly copied with `COPY_U64()`, fai=
ling to unpack and repack the 32-bit `cpu` and `res` fields, leading to dat=
a corruption on cross-endian hosts.
--

commit e3128f8fdbd9617d2687dd070d7cac54eeaa5333
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Implement sample address remapping

This commit adds sample address remapping logic to the ASLR tool. It handles
parsing sample events, remapping IPs, ADDRs, callchains, and branch stacks.
It also aims to preserve cross-endian compatibility by properly unpacking a=
nd
repacking the sequential 32-bit layouts into host endianness.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
[ ... ]
> @@ -616,13 +671,415 @@ static int aslr_tool__process_sample(const struct =
perf_tool *tool,
[ ... ]
> +	if (sample_type & PERF_SAMPLE_TID) {
> +		union {
> +			u64 val64;
> +			u32 val32[2];
> +		} u;
> +
> +		if (CHECK_BOUNDS(1, 1)) {
> +			ret =3D -EFAULT;
> +			goto out_put;
> +		}
> +		u.val32[0] =3D sample->pid;
> +		u.val32[1] =3D sample->tid;
> +		out_array[j++] =3D u.val64;
> +		i++;
> +	}
> +	if (sample_type & PERF_SAMPLE_TIME)
> +		COPY_U64(); /* time */
> +	if (sample_type & PERF_SAMPLE_ADDR)
> +		REMAP_U64(sample->addr);
> +	if (sample_type & PERF_SAMPLE_ID)
> +		COPY_U64(); /* id */
> +	if (sample_type & PERF_SAMPLE_STREAM_ID)
> +		COPY_U64(); /* stream_id */
> +	if (sample_type & PERF_SAMPLE_CPU)
> +		COPY_U64(); /* cpu, res */

[Severity: High]
Will this corrupt the CPU ID on cross-endian hosts?

When the perf core reads the input file, it byte-swaps all 64-bit payload
fields into host endianness. For PERF_SAMPLE_CPU, which consists of two
32-bit fields (cpu and res), this 64-bit byte-swap incorrectly reverses the
two fields.

The code correctly unpacks and repacks PERF_SAMPLE_TID using a union to
safely recover its two 32-bit fields, but uses a blind COPY_U64() here for
PERF_SAMPLE_CPU in aslr_tool__process_sample().

When the injected output file is written natively in host endianness, this
incorrectly-swapped 64-bit value is permanently saved. Later, when the new
profile is parsed, it will read the originally empty res field into data->c=
pu,
corrupting the CPU ID.

Should PERF_SAMPLE_CPU be unpacked and repacked similarly to PERF_SAMPLE_TI=
D?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608054841.3856=
224-1-irogers@google.com?part=3D3
