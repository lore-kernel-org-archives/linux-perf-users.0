Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A9435A9C
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620225; cv=none; b=CxaIhz1orLTzONihxqtEKiOlOeojQOA3GIJ3oyPE4dP0swGHVlykRcuHF0jKvmOuIprfCQJPDGJhCqZ63ioRK3K7UQEoJ2PerC1W9CZtMBMKR1UwSqA1hVOluACHbyPcwH78Ds30CrJ1lkmSmFE6/Kq+j5+o2lSUyzffgo7MlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620225; c=relaxed/simple;
	bh=/WFWPGv9gdvmWaCUlGewKBFdxJZZLMCkL2y2BWcABLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZLg4se41xoqzWvY3iFE/riIf54/A9jbPaJ4X4dEvSsYrZOmB6H6qxDvzDY4O5zM+Eg69FefTOU5mQbgCRIV2hb+2KtanBKfs06dusvosECFI06DAB/RzImVrNjOglVvZ2XaUHtmFXRUqVwMSYfYQvhOI2sLCdphpJeB141LUCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9Ikp+p9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9Ikp+p9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961481F00A3D;
	Tue, 21 Jul 2026 07:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620212;
	bh=bzfqOWTs8dWe4FDhvP7z5ZCZcSVQ//GS1QSXAjXomkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9Ikp+p9nTCQ8892BPaFrucqz3Ex7vBLCO7bPnlk9oZMw3a8E88PbqTR8uytNLv4y
	 hmRrDZSVrQ246V3ozVbvnMaF3HCKsKIAjjYFlTIs2F/BHEZyNaqsxz220RnyRAq+Rq
	 ewLDS7YmWk/C0i2UYmI+QSmuYh0SSbXl9fir8N4PjJJV9ptfpc0Et2owr3akoQnJm3
	 QxWfsH/nQu8zZNyjdT+9aNya2l6W3YwBFAyLoCEQ+ccBZGx/QiXYtPMjpZrsJi3BPl
	 hk3xNqbCH9ip+7ySDC+85webcXunuVMpSnKatmlQDyK96Zo49yhmZAlXKFnJuY+lvO
	 jM1/9iJ0+yEBg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v10 06/10] perf regs: Support x86 SIMD registers
 sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721072707.3787848-7-dapeng1.mi@linux.intel.com>
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:50:12 +0000
Message-Id: <20260721075012.961481F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The sample parser fails to skip the SIMD register data payload, co=
rrupting subsequent sample fields.
- [Medium] Silently synchronizing SIMD register masks between intr and user=
 modes bypasses architectural capability checks.
- [Medium] Bypassing hardware event check for SIMD register sampling enable=
s it for unsupported software events.
--

--- Patch [6]: [Patch v10 06/10] perf regs: Support x86 SIMD registers samp=
ling ---
commit 511dc4506d241eccda5990483afe081741ffbdb5
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf regs: Support x86 SIMD registers sampling

This commit adds support for the SIMD register sampling format on x86 platf=
orms.
It introduces functions to retrieve register class masks, names, and length=
s for=20
both interrupt and user registers, and updates command-line parsing to hand=
le
groups like XMM, YMM, ZMM, and OPMASK.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index da0ad06446091..52249316709d7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> @@ -1669,6 +1670,16 @@ void evsel__config(struct evsel *evsel, const stru=
ct record_opts *opts,
>  		evsel__set_sample_bit(evsel, REGS_INTR);
>  	}
> =20
> +	if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &&
> +	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
> +		attr->sample_simd_regs_enabled =3D !!opts->sample_simd_regs_enabled;

[Severity: Medium]
When SIMD registers are enabled here, should there be a check to verify it =
is a
hardware event?

For regular registers, this is guarded with evsel__is_hardware_event(evsel),
but here it seems to unconditionally enable SIMD registers for software eve=
nts.
Could this cause the kernel to reject the event with -EINVAL?

> +		attr->sample_simd_vec_reg_intr =3D opts->sample_intr_vec_regs;
> +		attr->sample_simd_vec_reg_qwords =3D opts->sample_vec_reg_qwords;
> +		attr->sample_simd_pred_reg_intr =3D opts->sample_intr_pred_regs;
> +		attr->sample_simd_pred_reg_qwords =3D opts->sample_pred_reg_qwords;
> +		evsel__set_sample_bit(evsel, REGS_INTR);
> +	}

[Severity: High]
If SIMD sampling is enabled, does the parser in __evsel__parse_sample() pro=
perly
skip the SIMD data payload?

It appears that __evsel__parse_sample() only skips the 4 header elements but
misses the variable-length SIMD data array that follows:

__evsel__parse_sample() {
    ...
    if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
        /* Skip SIMD-regs header. */
        sz =3D 4 * sizeof(u64);
        OVERFLOW_CHECK(array, sz, max_size);
        array =3D (void *)array + sz;
    }
    ...
}

Will this leave the array pointer pointing at register data instead of the =
next
field (like PERF_SAMPLE_STACK_USER), potentially corrupting subsequent fiel=
ds
and failing to parse the event?

> +
>  	if (opts->sample_user_regs && !evsel->no_aux_samples &&
>  	    !evsel__is_dummy_event(evsel)) {
>  		attr->sample_regs_user |=3D opts->sample_user_regs;
> @@ -1677,6 +1688,16 @@ void evsel__config(struct evsel *evsel, const stru=
ct record_opts *opts,
>  		evsel__set_sample_bit(evsel, REGS_USER);
>  	}
> =20
> +	if ((opts->sample_user_vec_regs || opts->sample_user_pred_regs) &&
> +	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
> +		attr->sample_simd_regs_enabled =3D !!opts->sample_simd_regs_enabled;
> +		attr->sample_simd_vec_reg_user =3D opts->sample_user_vec_regs;
> +		attr->sample_simd_vec_reg_qwords =3D opts->sample_vec_reg_qwords;
> +		attr->sample_simd_pred_reg_user =3D opts->sample_user_pred_regs;
> +		attr->sample_simd_pred_reg_qwords =3D opts->sample_pred_reg_qwords;
> +		evsel__set_sample_bit(evsel, REGS_USER);
> +	}
> +
>  	if (target__has_cpu(&opts->target) || opts->sample_cpu)
>  		evsel__set_sample_bit(evsel, CPU);
> =20
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse=
-regs-options.c
> index 70a1cc90b2c13..709fcfb077a2b 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
[ ... ]
> @@ -53,26 +106,116 @@ name_to_perf_reg_mask(const char *to_match, uint64_=
t mask, int abi)
>  	return reg_mask;
>  }
> =20
> +static bool
> +name_to_simd_reg_mask(struct record_opts *opts, const char *to_match,
> +		      uint64_t mask, bool intr, bool pred)
> +{
[ ... ]
> +		/*
> +		 * sample_intr_pred_regs and sample_user_pred_regs share
> +		 * sample_pred_reg_qwords. If both are set, keep their bitmaps identic=
al.
> +		 */
> +		if (opts->sample_intr_pred_regs && opts->sample_user_pred_regs) {
> +			uint64_t max_pred_regs =3D MAX(opts->sample_intr_pred_regs,
> +						     opts->sample_user_pred_regs);
> +
> +			opts->sample_intr_pred_regs =3D max_pred_regs;
> +			opts->sample_user_pred_regs =3D max_pred_regs;
> +		}
> +	} else {
> +		opts->sample_vec_reg_qwords =3D
> +			MAX(qwords, opts->sample_vec_reg_qwords);
[ ... ]
> +		/*
> +		 * sample_intr_vec_regs and sample_user_vec_regs share
> +		 * sample_vec_reg_qwords. If both are set, keep their bitmaps identica=
l.
> +		 */
> +		if (opts->sample_intr_vec_regs && opts->sample_user_vec_regs) {
> +			uint64_t max_vec_regs =3D MAX(opts->sample_intr_vec_regs,
> +						    opts->sample_user_vec_regs);
> +
> +			opts->sample_intr_vec_regs =3D max_vec_regs;
> +			opts->sample_user_vec_regs =3D max_vec_regs;
> +		}
> +	}

[Severity: Medium]
Does synchronizing the SIMD register masks between intr and user modes bypa=
ss
architectural capability checks?

If a user specifies different sets for INTR and USER mode SIMD registers
(e.g., -I XMM --user-regs ZMM), forcing both masks to the maximum might
violate the capability check retrieved by
perf_intr_simd_reg_class_bitmap_qwords().

Will this cause perf record to pass an unsupported register bitmask and fail
with -EINVAL from the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721072707.3787=
848-1-dapeng1.mi@linux.intel.com?part=3D6
