Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2FF31F99A
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780869372; cv=none; b=gH++1sGYqc66e6AxU0OtbZ30tVea5rJV6Ekler6HMIvlKtkiljN7CNhrpu+0/fDQpbRsFbKRsiiH7/a/vIqnbmzJtP1MfPqUr3Nfk0rkAD95B1nqCPL0qBcg5rBhl01/kjbEytQaaVtjUtuGooR6pppbcvJfk8yGfS1Nod+jVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780869372; c=relaxed/simple;
	bh=N5ssFHxXyThqZSQOD9n3U+cIE9R2DYR0m08fbfkx42U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uPnB6QMjfUOMGLloFtzPBM/8ZxQV1PttHIbvhsf3EbPla+LR62SK45hImkxYYsw5bzxzzP6CADk8oYVnhVud3yjjHy2QPvRvuwJUdXyl0FF+K6/7GxNTU0AWGgf7bFF8Iix0mlWRpLdy7FvmPswMQ6eisfEQuLeFy+hML8A9brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBT7gFFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBT7gFFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07911F00893;
	Sun,  7 Jun 2026 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780869371;
	bh=sM5xJiDLmP2rctHEnf/cP/TsUprnaoTNujpMe+Za7Q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QBT7gFFxgQzWJI31oRSONw2KQwbrxho5C9LH1yqOTlyLJXNBmt4BAScggkwnE5u0q
	 DGFT1ctdftkfucN+ud/q39YtPt2Z73l9dkuloWPzPq4dzb38k4Gse89Bf4vvdTHsYi
	 ezkczqE0z9JlaqU4ZNf8GdGTQcJsKCDXp0yqQKNC2XWZCc28G8kiXk6E77pph465cC
	 y8DJA1ZqikYwSMC3wLfhEJ9V20Fo9SiFhS/MJr9KJe7vBosv9QP5NDxsloWGasaB9s
	 eKg4MQCHbB42BYKBnTjxInci/Pi4yPsKWrC6MUIEn4T845esyiepOiZd6pXduOHTcc
	 0f7niMfyD/r7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 3/5] perf inject/aslr: Implement sample address
 remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607213700.3563842-4-irogers@google.com>
References: <20260607213700.3563842-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 21:56:10 +0000
Message-Id: <20260607215610.D07911F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect byte-swapping logic corrupts cross-endian ASLR injection=
 output and map lookups.
--

commit 6c75b55c8896e5addaf1feb2b5e93b62c2cc71dd
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Implement sample address remapping

Add the sample address remapping logic to the ASLR tool. This patch
implements aslr_tool__process_sample, which parses sample events,
remaps IPs, ADDRs, callchains, and branch stacks using the mappings
collected from metadata events.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index e45f68c604937..03944677ddfcc 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c

[ ... ]

> @@ -602,13 +657,413 @@ static int aslr_tool__process_sample(const struct =
perf_tool *tool,

[ ... ]

> +#define REMAP_U64(addr_field) \
> +	do { \
> +		u64 remapped; \
> +		if (CHECK_BOUNDS(1, 1)) { \
> +			ret =3D -EFAULT; \
> +			goto out_put; \
> +		} \
> +		remapped =3D aslr_tool__remap_address(aslr, thread, cpumode, addr_fiel=
d); \
> +		if (orig_needs_swap) \
> +			remapped =3D bswap_64(remapped); \
> +		out_array[j++] =3D remapped; \
> +		i++; \
> +	} while (0)

[Severity: High]
Since perf_session__process_event() applies perf_event__all64_swap() to
PERF_RECORD_SAMPLE payloads, converting all 64-bit words in
event->sample.array to native endianness before the tool processes them,
will applying bswap_64() here write a corrupted foreign-endian address into
the output buffer?

The output perf.data file is emitted with a native header, so downstream
readers wouldn't know to swap these values back.

[ ... ]

> +		for (u64 cntr =3D 0; cntr < nr; cntr++) {
> +			if (CHECK_BOUNDS(1, 1)) {
> +				ret =3D -EFAULT;
> +				goto out_put;
> +			}
> +			addr =3D in_array[i++];
> +			if (addr >=3D PERF_CONTEXT_MAX) {
> +				out_array[j++] =3D orig_needs_swap ? bswap_64(addr) : addr;

[Severity: High]
Could this logic result in callchain context markers being incorrectly swap=
ped
to foreign endianness before they are written to the output event buffer?

[ ... ]

> +	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> +		u64 nr;
> +
> +		if (CHECK_BOUNDS(1, 1)) {
> +			ret =3D -EFAULT;
> +			goto out_put;
> +		}
> +		nr =3D in_array[i];
> +		COPY_U64();
> +
> +		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)
> +			COPY_U64(); /* hw_idx */
> +
> +		if (nr > (ULLONG_MAX / 3)) {
> +			ret =3D -EFAULT;
> +			goto out_put;
> +		}
> +		if (nr * 3 > max_i - i || nr * 3 > max_j - j) {
> +			ret =3D -EFAULT;
> +			goto out_put;
> +		}
> +		for (u64 cntr =3D 0; cntr < nr; cntr++) {
> +			u64 from =3D in_array[i++];
> +			u64 to =3D in_array[i++];
> +
> +			if (orig_needs_swap) {
> +				from =3D bswap_64(from);
> +				to =3D bswap_64(to);
> +			}
> +
> +			from =3D aslr_tool__remap_address(aslr, thread, sample->cpumode, from=
);
> +			to =3D aslr_tool__remap_address(aslr, thread, sample->cpumode, to);

[Severity: High]
If the from and to addresses are swapped to foreign endianness before calli=
ng
aslr_tool__remap_address(), wouldn't this pass invalid addresses to the thr=
ead
map lookup, causing it to silently fail and bypass ASLR remapping for branch
stacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607213700.3563=
842-1-irogers@google.com?part=3D3
