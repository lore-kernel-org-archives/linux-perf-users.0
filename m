Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FF232B108
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051534; cv=none; b=gW3hMQKpFNUWaS00BnQzuyEgD5FWdJeuRRf06BAZquaa10TT+CoGeEgBWC9D+CqDoPqi8K05TwkZJ5qV3xqkl3q4Mt5zK3MoqtJmrSiuR4IoAe8KHRpZJZOc52M56X0OiZfinP8JUZTiy4u4nu7lUACwow+dKk9FFz9Ct1n/Tpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051534; c=relaxed/simple;
	bh=0YJQNkT92GVSwns4fA6TQ9KSISXCVYRGpPp6Gidq2+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h4f7I9/WxN5NI93MZcW2dRAfBWJUoxvEUtihhPxq3LXgsgInaDr9M6wNkVNqjKK2e0J0Fy8k35igdZWkrXbnVYEK9BDPb8X0WG7a0WW4+Gc9bA1qH2oMG0+og9sCqYI6ssaajhla7u6Kj+oWOo9gaMSb2ns6WWsx8C/8iqspq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1bOiWYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1bOiWYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9D11F00893;
	Fri, 29 May 2026 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780051532;
	bh=evO6V+QUCyka3j0P1z2lVVcfeuYA+wSIJ6ma+UPwFvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1bOiWYJqV7+2YmYNfxd+pOZY2DwOt8+8T/har667MtdGHfdep8RNYC7bKo8cUpsc
	 vHcWY7w/07nfsoSrf2z4gLd+La9+3nvHKINISXXueEhYwaNZXqkGk5Om8jBrd4ZYyf
	 kCJbkXLvxMTgv3lH7DF5xhN7AzplW0QzkTy9eiN7HXtloZhQvh99ffAYewXChSY8yg
	 ZbZX2/ZxUpTCI84HUo9DJ1YILt3aqTIo8avaqOBdQwMEqHWr40lA5Ddb3rnE+cIPvS
	 GexrFW/P3gIjXOzyz7oEBXmlq7UleUsb/yfuZ4c0QFv/5P4oN4jvEy8W4+inNvL2JM
	 SlMJbkAzPBCbA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 3/5] perf regs: Support x86 SIMD registers sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529082451.591783-4-dapeng1.mi@linux.intel.com>
References: <20260529082451.591783-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 10:45:32 +0000
Message-Id: <20260529104532.CE9D11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Parsing of `--intr-regs` and `--user-regs` with multiple options=
 is order-dependent, preventing intended combination of General Purpose (GP=
) and SIMD registers.
- [Medium] Specifying only SIMD registers (e.g., `--intr-regs=3Dxmm` withou=
t GP registers) leaves the general-purpose register mask as 0, causing the =
kernel to reject the event configuration with `-EINVAL`.
- [Low] The `sample_simd_regs_enabled` field is omitted from `perf_event_at=
tr__fprintf()`.
--

commit 03a81994cf381ee1d67a41deb452833fc73a023e
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf regs: Support x86 SIMD registers sampling

This patch adds support for the newly introduced SIMD register sampling
format by adding functions to support parsing and sampling x86 SIMD/PRED
registers.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1c856a2ecc6ec..cd62af14a4f54 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c

[ ... ]

> @@ -1594,6 +1595,16 @@ void evsel__config(struct evsel *evsel, const stru=
ct record_opts *opts,
>  		evsel__set_sample_bit(evsel, REGS_INTR);
>  	}
> =20
> +	if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &&
> +	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
> +		attr->sample_simd_regs_enabled =3D !!opts->sample_simd_regs_enabled;
> +		attr->sample_simd_vec_reg_intr =3D opts->sample_intr_vec_regs;
> +		attr->sample_simd_vec_reg_qwords =3D opts->sample_vec_reg_qwords;
> +		attr->sample_simd_pred_reg_intr =3D opts->sample_intr_pred_regs;
> +		attr->sample_simd_pred_reg_qwords =3D opts->sample_pred_reg_qwords;
> +		evsel__set_sample_bit(evsel, REGS_INTR);
> +	}

[Severity: Medium]
Will specifying only SIMD registers (e.g., perf record --intr-regs=3Dxmm)
leave the general-purpose register mask as 0?

If opts->sample_intr_regs is 0, attr->sample_regs_intr remains 0. However,
setting the REGS_INTR bit here causes the kernel validation function
(perf_reg_validate()) to unconditionally return -EINVAL because the sample
type bit is set but the corresponding GP register mask is 0.

> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse=
-regs-options.c
> index 70a1cc90b2c13..26d560a486c85 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c

[ ... ]

> @@ -53,22 +106,96 @@ name_to_perf_reg_mask(const char *to_match, uint64_t=
 mask, int abi)

[ ... ]

>  	/*
> -	 * cannot set it twice
> +	 * Non-SIMD registers cannot be set twice.
> +	 * SIMD registers can be set multiple times, but only the register
> +	 * class with largest length (qwords) is sampled.
>  	 */
>  	if (*mode)
>  		return -1;

[Severity: Medium]
Does the order of options affect whether they are parsed successfully?

If SIMD registers are parsed first (e.g., -I xmm), *mode is left as 0,
which allows a subsequent GP register option like -I ax to be parsed
successfully.

However, if GP registers are parsed first (e.g., -I ax), *mode is set to
a non-zero value, which triggers this failure check when -I xmm is
evaluated. Does this prevent intended combinations of GP and SIMD registers
from working consistently?

> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/=
perf_event_attr_fprintf.c
> index 741c3d657a8b6..c6b8e53e06fd1 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -362,6 +362,12 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_e=
vent_attr *attr,
>  	PRINT_ATTRf(aux_start_paused, p_unsigned);
>  	PRINT_ATTRf(aux_pause, p_unsigned);
>  	PRINT_ATTRf(aux_resume, p_unsigned);
> +	PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
> +	PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
> +	PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
> +	PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
> +	PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
> +	PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
> =20
>  	return ret;
>  }

[Severity: Low]
Does this also need to print the sample_simd_regs_enabled field?

This patch adds several new SIMD-related fields to struct perf_event_attr,
but sample_simd_regs_enabled is missing here. Could this prevent developers
from verifying whether the tool correctly enabled SIMD sampling when inspec=
ting
configurations via debug commands like perf record -vvv?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529082451.5917=
83-1-dapeng1.mi@linux.intel.com?part=3D3
