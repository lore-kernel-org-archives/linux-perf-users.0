Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D322157B
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620331; cv=none; b=djT7/GTfQxZR1uCIRUGIEyIy6XMEqm2+c/9d6E7W1b4hQ5UQHxWe1mL7h/c/kyEL92WOJwW70ZMoe70GSkwQHR5xj9+AkPJiB77HdmEZauhQfsvGwCv+qKl3bozCU8/MlAZyDxjV+oqEJpX1YyRn+Cw9tDKbl2+2JObM7CoVmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620331; c=relaxed/simple;
	bh=LyU8j9GZp9xRuum/bRXxy2dTQlMz7pFMNVee6h2bY0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0NhdMMgbdi8Tr9htSOVrWEucuIHk+Rn6BRr4YG0tSrn8NdGg4r2lTm+UbcpdWYW86AbfXSOMqZa0uUkSfHkdPJ/hiTLFvRw1D6qNPER2bt55MG/1IZywxxedbQtukb6UhEBPhoDU2lrZJWjaFhfTkm2aSmksOSMJSIO02XgNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I08URDSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I08URDSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A41F00A3D;
	Tue, 21 Jul 2026 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620330;
	bh=XnRdlHu3adUb3ZiKxA614sMDE5/dvOWwXYMfviGjsc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I08URDSfQWOmln4BfsQzi8/xcZ0EymRbfTI49rZbxfzEAF7O6KRao5gOZPcvKijeK
	 3onI3q/wm/mO+bCpi7uUeZmzdYI+Dv4lZzQSvMWEThS4T2LqBDY0MWNdDMJAMZSbJn
	 kI713iHdr99GtxaUoUdCZEWb4lgZ/6lfh1GqAHyXjSNyHJTBgzuv/d3Y/QoMWG9sKP
	 FPkrwrMklOE4JgEsAmrqep5zlPbBRV+DgpFBbKzWK/ALQBM1rShixA8TnajlvlvCea
	 0A/HgYIExviS8gCobuz7wnSlqbQzPJdwwkyXmgnJd0ZOm2NF+ZIqgEkah1AzVhmvXV
	 F+M9ZVhXKJR7w==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v10 05/10] perf regs: Support x86 eGPRs/SSP sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721072707.3787848-6-dapeng1.mi@linux.intel.com>
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:52:09 +0000
Message-Id: <20260721075209.EC4A41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Hardcoded 32-byte SIMD header skip in `__evsel__parse_sample` corr=
upts parsing of future `perf.data` files containing actual SIMD data payloa=
ds.
- [High] `perf_event__synthesize_sample` fails to write the SIMD register h=
eader, leading to uninitialized memory leaks and corruption of synthesized =
events.
- [High] Silently substituting requested eGPRs with legacy XMM registers on=
 non-hardware events.
--

--- Patch [5]: [Patch v10 05/10] perf regs: Support x86 eGPRs/SSP sampling =
---
commit 8930556b90beb6ec5b6f4e43ddaf5145e6dda06d
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf regs: Support x86 eGPRs/SSP sampling

This commit adds support for sampling x86 extended GP registers (R16-R31)
and the shadow stack pointer (SSP) register. It reclaims the original XMM
registers space in the sampling masks to represent eGPRs and SSP when SIMD
sampling is supported, distinguishing them with a new abi flag.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a5b0687a3a79f..da0ad06446091 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c

[ ... ]

> @@ -1661,12 +1664,16 @@ void evsel__config(struct evsel *evsel, const str=
uct record_opts *opts,
>  	if (opts->sample_intr_regs && !evsel->no_aux_samples &&
>  	    !evsel__is_dummy_event(evsel)) {
>  		attr->sample_regs_intr =3D opts->sample_intr_regs;
> +		attr->sample_simd_regs_enabled =3D evsel__is_hardware_event(evsel) ?
> +				!!opts->sample_simd_regs_enabled : 0;

[Severity: High]
Does clearing the sample_simd_regs_enabled flag for non-hardware events
cause the kernel to misinterpret the bits as legacy XMM requests?

If a user requests sampling of eGPRs on a software event, this flag is
forcibly cleared, but the opts->sample_intr_regs bitmask is preserved.
Because eGPR definitions alias legacy XMM definitions, wouldn't the kernel
see the bits set alongside sample_simd_regs_enabled =3D 0 and dump legacy X=
MM
data instead?

The tool might then read it back without the SIMD ABI flag and print it as
XMM, silently losing the user's intent to capture eGPRs. Should the
aliasing eGPR bits be masked out from the sample_regs mask when clearing
the SIMD flag?

>  		evsel__set_sample_bit(evsel, REGS_INTR);
>  	}
> =20
>  	if (opts->sample_user_regs && !evsel->no_aux_samples &&
>  	    !evsel__is_dummy_event(evsel)) {
>  		attr->sample_regs_user |=3D opts->sample_user_regs;
> +		attr->sample_simd_regs_enabled =3D evsel__is_hardware_event(evsel) ?
> +				!!opts->sample_simd_regs_enabled : 0;

[Severity: High]
This seems to have the same aliasing issue as above where eGPR requests on
non-hardware events will be silently interpreted as legacy XMM registers.

>  		evsel__set_sample_bit(evsel, REGS_USER);
>  	}

[ ... ]

> @@ -3679,6 +3686,13 @@ int __evsel__parse_sample(struct evsel *evsel, uni=
on perf_event *event,
>  			regs->mask =3D mask;
>  			regs->regs =3D (u64 *)array;
>  			array =3D (void *)array + sz;
> +
> +			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
> +				/* Skip SIMD-regs header. */
> +				sz =3D 4 * sizeof(u64);
> +				OVERFLOW_CHECK(array, sz, max_size);
> +				array =3D (void *)array + sz;
> +			}
>  		}
>  	}

[Severity: High]
Will this hardcoded 32-byte header skip corrupt parsing for files containing
actual SIMD data payloads?

The parser unconditionally skips exactly 4 u64s for the SIMD header, but it
doesn't dynamically compute and skip the variable-length SIMD payload that
might follow it in future files. This would misalign the array pointer for
subsequent fields like STACK_USER, causing garbage reads and triggering
OVERFLOW_CHECK aborts.

[ ... ]

> @@ -3736,6 +3750,13 @@ int __evsel__parse_sample(struct evsel *evsel, uni=
on perf_event *event,
>  			regs->mask =3D mask;
>  			regs->regs =3D (u64 *)array;
>  			array =3D (void *)array + sz;
> +
> +			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
> +				/* Skip SIMD-regs header. */
> +				sz =3D 4 * sizeof(u64);
> +				OVERFLOW_CHECK(array, sz, max_size);
> +				array =3D (void *)array + sz;
> +			}
>  		}
>  	}

[Severity: High]
This appears to have the same issue with skipping the SIMD header without
handling the variable-length payload.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index b75f9dcf4dbfe..503a239b0b10f 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1527,6 +1527,8 @@ size_t perf_event__sample_event_size(const struct p=
erf_sample *sample, u64 type,
>  		if (sample->user_regs && sample->user_regs->abi) {
>  			result +=3D sizeof(u64);
>  			sz =3D hweight64(sample->user_regs->mask) * sizeof(u64);
> +			if (sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +				sz +=3D 4 * sizeof(u64);

[Severity: High]
Does perf_event__synthesize_sample() also need to be updated to write these
32 bytes?

Since perf_event__sample_event_size() allocates 32 extra bytes for the SIMD
header here, if perf_event__synthesize_sample() doesn't write them,
subsequent fields could be written 32 bytes early.

When the malformed event is parsed by __evsel__parse_sample(), the parser
will skip 32 bytes after the registers, completely missing the early-written
subsequent fields and corrupting the stream. The final 32 bytes of the event
buffer would remain uninitialized heap memory, leaking information when
emitted.

>  			result +=3D sz;
>  		} else {
>  			result +=3D sizeof(u64);
> @@ -1555,6 +1557,8 @@ size_t perf_event__sample_event_size(const struct p=
erf_sample *sample, u64 type,
>  		if (sample->intr_regs && sample->intr_regs->abi) {
>  			result +=3D sizeof(u64);
>  			sz =3D hweight64(sample->intr_regs->mask) * sizeof(u64);
> +			if (sample->intr_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +				sz +=3D 4 * sizeof(u64);

[Severity: High]
This appears to have the same issue as above, where the allocated SIMD
header bytes might not be written by perf_event__synthesize_sample().

>  			result +=3D sz;
>  		} else {
>  			result +=3D sizeof(u64);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721072707.3787=
848-1-dapeng1.mi@linux.intel.com?part=3D5
