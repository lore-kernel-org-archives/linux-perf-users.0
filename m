Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40087378D71
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305278; cv=none; b=BdR8r12IsA7bCTmiOxP07Dv/6jltUbE7gn5GIlIRfapmXsml4s3KAUKB4apoJJE+aXqxvAkKyaRIqzCuAR1SWvEeTP6M0+YSBQIyHOiF8k8LezcJX2j0QpQkdtLXK6/ZE6D+yHjk5ZjF/wFEBwiSsbvt1h8euONkvnQmQtpU0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305278; c=relaxed/simple;
	bh=2Rht2IbyswDv9l7ZYxE3v1/5bo2aRFf6ctjIt2nb4+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cg1w6Kx25XN7AItk2U7M+PXufOogj75UK8DEi7pZ0QLvoQ3T//BJgYLbiCIQMYLsir9Jkl3lolElesfFqGCh5j0NiS1ymyVQsI/BSxzZfZ4U/mrdVI3Y6PHpxAtyikdIhwb9U8lZqlrrQVGVEyx/viGIlwcag7ylF/MzJ2+Sf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIZ+UYkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIZ+UYkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFDD1F00A3A;
	Mon,  6 Jul 2026 02:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783305276;
	bh=ikwcyWwBOYhVYmKbBbSqQg54yQGMMQPYF6FIJWpHdRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIZ+UYkDvrxinYdk5At1q0So0FM/JxNOWNc440hucIL/bLtcQFyMwziUw1edIx7c1
	 Cgq93XFyrSHDCYXZoP0mp6zWQZw6/aCOD+PMcDZl8JgH59VshU5SmzFdEpGeGXgOZ9
	 4s8T7zap4/AtTKmvxJIevIBc4TxAgBpAJ7UuKJI7grdHTR0m/EdI1YB0a5+dfCkewy
	 +E+j52XwuOP4sOoapEpZ+jIGbF1s3xhroWBOAKNSGmxQvl8aetiWKmdbYNv48IHQiS
	 rwlEL2zxtQIP248OgTEJIqDOsFPTgMlTUH6pZZg8aSmqMVc2FRAI8r6sF33wIliVoQ
	 8vngaVyastAGA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 13/24] perf: Add sampling support for SIMD registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-14-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-14-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:34:35 +0000
Message-Id: <20260706023436.5DFDD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Uninitialized, flag-gated syscall parameters are unconditionally=
 passed to and evaluated by the validation function `perf_simd_reg_validate=
()`, breaking trust boundaries.

Pre-existing issues:
- [High] The dynamic size added by PERF_SAMPLE_REGS_INTR (and exacerbated b=
y SIMD registers) bypasses the size capping applied during PERF_SAMPLE_STAC=
K_USER, leading to a U16_MAX integer overflow and ring buffer corruption.
--

commit 8a8cf6dc3b640f823c8a7990b8c46e78cd38719e
Author: Kan Liang <kan.liang@linux.intel.com>

perf: Add sampling support for SIMD registers

This commit introduces support for sampling SIMD registers during profiling
by adding new attribute fields to the perf_event_attr structure. It provides
a new output format and the PERF_SAMPLE_REGS_ABI_SIMD ABI to represent the
number and width of these registers based on user configuration.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0239864029bec..ce93c23b3a33f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8773,6 +8877,10 @@ void perf_prepare_sample(struct perf_sample_data *=
data,
>  			u64 mask =3D event->attr.sample_regs_intr;
> =20
>  			size +=3D hweight64(mask) * sizeof(u64);
> +			if (event_has_simd_regs(event)) {
> +				size +=3D perf_update_xregs_size(event, true);
> +				data->regs_intr.abi |=3D PERF_SAMPLE_REGS_ABI_SIMD;
> +			}
>  		}
> =20
>  		data->dyn_size +=3D size;

[Severity: High]
This is a pre-existing issue, but does adding this new SIMD register size
cause a buffer overrun by overflowing data->dyn_size past USHRT_MAX?

Earlier in perf_prepare_sample(), when PERF_SAMPLE_STACK_USER is processed,
perf_sample_ustack_size() caps the stack dump size so that the total dynamic
size precisely reaches USHRT_MAX.=20

Since PERF_SAMPLE_REGS_INTR is unconditionally processed after
PERF_SAMPLE_STACK_USER, adding its size (which can now be significantly
larger with SIMD registers) to data->dyn_size will exceed 65535 bytes.

Could this truncate the 16-bit header size and cause perf_output_sample()
to write far more data than was allocated in the ring buffer?

> [ ... ]
> @@ -13694,6 +13809,16 @@ static int perf_copy_attr(struct perf_event_attr=
 __user *uattr,
>  		ret =3D perf_reg_validate(attr->sample_regs_user);
>  		if (ret)
>  			return ret;
> +		ret =3D perf_simd_reg_validate(attr->sample_type,
> +					     attr->sample_simd_regs_enabled,
> +					     attr->sample_simd_vec_reg_qwords,
> +					     attr->sample_simd_vec_reg_intr,
> +					     attr->sample_simd_vec_reg_user,
> +					     attr->sample_simd_pred_reg_qwords,
> +					     attr->sample_simd_pred_reg_intr,
> +					     attr->sample_simd_pred_reg_user);
> +		if (ret)
> +			return ret;
>  	}

[Severity: Medium]
Could this pass uninitialized syscall parameters to the validation logic?

When PERF_SAMPLE_REGS_USER is set but PERF_SAMPLE_REGS_INTR is not, the user
is not required to initialize the sample_simd_vec_reg_intr or
sample_simd_pred_reg_intr fields.=20

If perf_simd_reg_validate() evaluates these uninitialized fields:

arch/x86/kernel/perf_regs.c:perf_simd_reg_validate() {
    if (!vec_mask_intr && !vec_mask_user)
        return -EINVAL;
}

Does this allow an invalid configuration where vec_mask_user is zero to
bypass validation because vec_mask_intr contains non-zero garbage data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D13
