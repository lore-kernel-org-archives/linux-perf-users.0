Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E528002B
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780813679; cv=none; b=G12C8mkvqRl0gzTvocWGKk4A7G5ixSyX6o1B5mQ4xOwqJiSC4GgVpt3fxpdi7tFA6WkBT1hXXIMRg1HEMcrhAOFhTJpKueE2cloD0aDcenuZXZuoHsCnTcXF7MOSZU+wVlmSPQKEZgIJ4crU9nNzaQFqyzlYHeXrGOq1rZz4vPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780813679; c=relaxed/simple;
	bh=O5S706OsFKF8NnprAgpyDs6JDN/PcZMLZx09BGj/G5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Leiytp8G8y4gyT8p5+0FnWlU7tjKOqsdKPYl0OyOF3ujA2QWswTEH+gpMXnbUAtgNGiqX8+ttY6Y43iK09LWqz7bmeDFbcXz4hsuFJV0E6xhbrcDjeuFOWcf/VslGnHcTYL9UfPMZdUDTsPSm8HeQRvPUHifkc74MA2zACWdwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9eTdPH+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9eTdPH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6426E1F00893;
	Sun,  7 Jun 2026 06:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780813677;
	bh=qvNeLshDIKjVvVkGAVtzMxVMCIb8Ip+OovNNbc8aw1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9eTdPH+b0ujamE7xx3OluFUC6L/Cf1NFdSPqdF06aO0m8f/qI/uegQtbQwPaFUBY
	 3BC88RDxNReUeKO623tXVt+H3+Q7KppsC4R4me0rcClgQLUPgT/EvnwiYqqetXiAV3
	 6UbqSKAsGPHzWMbZ/cW7OefCiRoKJBXs2uYUUJd204Cjk8OFgDYb4nQt+sSE/uZ7mK
	 gfLCMybTdnVMSXVDCd7xQQGoRmAyEE0cDLNHbPZyNcxK+zCNAmBPAJuYLCclQcza6a
	 mHyd9YsjO5JyE2xoBr5RfGOQfLleS4nZH9u7WQu1yy8HkcMcT+pwy4KkV/cNXiqRxD
	 IFt3yX2i65t4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 3/5] perf inject/aslr: Implement sample address
 remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607060933.3274263-4-irogers@google.com>
References: <20260607060933.3274263-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 06:27:56 +0000
Message-Id: <20260607062757.6426E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect double byte-swapping of already natively-swapped 64-bit =
array fields corrupts cross-endian parsing and address remapping.
- [High] The entire sample event is dropped if it includes branch stack cou=
nters, silently breaking profiles collected with LBR counters.
--

commit 99425ccaa2ec1a33c2b9f564c32b12db661696fe
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Implement sample address remapping
   =20
Add the sample address remapping logic to the ASLR tool. This patch
implements aslr_tool__process_sample, which parses sample events,
remaps IPs, ADDRs, callchains, and branch stacks using the mappings
collected from metadata events.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 2c5fafbe5d846..8980599b0158f 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c

[ ... ]

> @@ -599,13 +654,428 @@ static int aslr_tool__process_sample(const struct =
perf_tool *tool,
>  {

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

[Severity: High]
Does this code incorrectly double byte-swap the remapped addresses?

The perf core framework, perf_event__all64_swap(), already byte-swaps the
entire PERF_RECORD_SAMPLE array payload to host endianness before passing
it to the tool callbacks.

By calling bswap_64() again in aslr_tool__process_sample when orig_needs_sw=
ap
is true, won't this mix host and file endianness in the out_array, corrupti=
ng
the output perf.data layout and breaking cross-endian parsing downstream?

> +		out_array[j++] =3D remapped; \
> +		i++; \
> +	} while (0)

[ ... ]

> +	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> +		u64 nr;
> +
> +		if (CHECK_BOUNDS(1, 1)) {
> +			ret =3D -EFAULT;
> +			goto out_put;
> +		}
> +		nr =3D in_array[i];
> +		if (orig_needs_swap)
> +			nr =3D bswap_64(nr);

[Severity: High]
Can this double-swapping of the nr counter cause parsing loops to fail?

Since in_array[i] is already in host endianness, wouldn't swapping it back
into file endianness produce a massive integer value for nr?

> +		out_array[j++] =3D in_array[i++];

[ ... ]

> +	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> +		u64 nr;
> +
> +		if (CHECK_BOUNDS(1, 1)) {
> +			ret =3D -EFAULT;
> +			goto out_put;
> +		}
> +		nr =3D in_array[i];
> +		if (orig_needs_swap)
> +			nr =3D bswap_64(nr);

[Severity: High]
Similarly, could swapping nr here cause the branch stack iteration bounds
checks to unconditionally return -EFAULT and drop the event?

> +		out_array[j++] =3D in_array[i++];

[ ... ]

> +		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)=
 {
> +			if (nr > max_i - i || nr > max_j - j) {
> +				ret =3D -EFAULT;
> +				goto out_put;
> +			}
> +			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
> +			i +=3D nr;
> +			j +=3D nr;
> +			/* TODO: confirm branch counters don't leak ASLR information. */
> +			pr_debug("Dropping sample branch counters as possible ASLR leak\n");
> +			ret =3D 0;
> +			goto out_put;

[Severity: High]
Does this logic silently discard the entire sample event when branch
counters are present?

By executing ret =3D 0 and jumping to out_put in aslr_tool__process_sample,
the delegate->sample invocation is bypassed.

Won't this break profiles collected with LBR counters (e.g. perf record -b)
by completely dropping all branch stack counter samples instead of just
omitting the specific fields?

> +		}
> +	}

[ ... ]

> +	if (sample_type & PERF_SAMPLE_STACK_USER) {
> +		u64 size;
> =20
> -	return delegate->sample(delegate, event, sample, machine);
> +		if (CHECK_BOUNDS(1, 1)) {
> +			ret =3D -EFAULT;
> +			goto out_put;
> +		}
> +		size =3D in_array[i];
> +		if (orig_needs_swap)
> +			size =3D bswap_64(size);

[Severity: High]
Could double-swapping the PERF_SAMPLE_STACK_USER size corrupt the payload
boundaries?

Like the nr values above, swapping the already host-endian size might trigg=
er
a bounds failure in the subsequent u64_words bounds check.

> +		out_array[j++] =3D in_array[i++];
> +		if (size > 0) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607060933.3274=
263-1-irogers@google.com?part=3D3
