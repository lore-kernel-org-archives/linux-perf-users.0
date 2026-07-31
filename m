Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE393E009C
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Jul 2026 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512605; cv=none; b=NB3F6RNxfYo7BysSoMoIGyoOSKpyiPKVuur+mPvhnxPUdUTsDoJZgjQiL132yE6s6Jmh3QLw3Uy4HSqEtI5xw8bAkVHpG0UzMlZeZqhT88ryA8kd+DQJA2uJA4he9kQHUvhwo9xoGHD79g3GNJ9BmcF2PUmn5zbttLlNvPckZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512605; c=relaxed/simple;
	bh=UJXpaeLG3whVwICN9Eq/cfe6JxV328Q/raBnFjwhmA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EscaCb7l3GX/8NPzgqDHY6afmzfZd8X07WsBmnZi95D21UnO802Fm7j4vLTMrBKdFuH7l0KvFFQ/XM0QqLOzm5kt22WnfxOcrcjxqoXv7yDrYBholQUF1JqYuVJlEfgRMWKrzERpyyfUCDaf+R8U2skdn/HHmvgI1gonZ3gORMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgWIEDza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgWIEDza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE67A1F000E9;
	Fri, 31 Jul 2026 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512604;
	bh=spHVtH04B4NNjr4k7y8N0/2+BJwXBHuLFhMIW6k9Se0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZgWIEDzaUBgdhzFxjdo/gkM6DKlL8LM8yMYwnKAw28uxq/qIuMz/x4owwh9o6JXV7
	 30fwaZ8WX+ELgOohMWaRs+UrK5RlFlc8Fmu+ozSD88rFrkk19aac350IJN9c/ZoUsX
	 fA/qy/46tGCxxKY9rEJwBJF5dBrgiylW2K84xX99gMMWFLSJSRZq63ZTJg98hjA38R
	 u/Pz+xYrV1gn29Z717DPWEdAcCcP0Nm0xa7ZPfxgl/7GRU7EDjI8JSOlIO/fs99mqo
	 1HgeuZahFeJx0QAXavDW3CJauTLoCcmDaqPSbKHDN72pl+jdzLHLCMEumEvYzVP5V2
	 bZdVSqyQhMl5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/arm_cspmu: Support 64-bit programmers' model
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <2bde4469c918494e8fa04b2d297a6189ac8b7796.1785511378.git.robin.murphy@arm.com>
References: <2bde4469c918494e8fa04b2d297a6189ac8b7796.1785511378.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:43:22 +0000
Message-Id: <20260731154323.AE67A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unconditional call to `is_cycle_counter_event` causes a kernel pan=
ic when `has_ext64` is true.
- [High] Register overlap and memory corruption from unvalidated counter li=
mits in EXT64.
- [High] Vendor specific event filter callbacks in nvidia_cspmu.c hardcode =
32-bit register offsets, causing register corruption on EXT64 PMUs.
- [Medium] Hardware state corruption due to missing cleanup in EXT64 probe =
logic.
--

--- Patch [1]: [PATCH v2] perf/arm_cspmu: Support 64-bit programmers' model=
 ---
commit 277fca2f906fbe4f72926fc904d3c79baa64178d
Author: Robin Murphy <robin.murphy@arm.com>
Subject: perf/arm_cspmu: Support 64-bit programmers' model

This patch adds support for the FEAT_CSPMU_EXT64 64-bit Programmers' model
extension. It updates event configuration fields and register offsets to
handle 64-bit values appropriately while omitting fixed cycle counter
support.

> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/=
arm_cspmu.c
> index e6292021f653e..4b3d1fae00db8 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
[ ... ]
> @@ -412,6 +439,17 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu =
*cspmu)
>  		DEFAULT_IMPL_OP(event_attr_is_visible),
>  	};
> =20
> +	/*
> +	 * With 64-bit events, since our default "cycles" encoding won't work,
> +	 * and the architecture recommends against implementing it anyway, we
> +	 * choose to effectively ignore FEAT_CSPMU_CCNTR, unless a vendor
> +	 * module really wants to provide its own encoding and ops.
> +	 */
> +	if (cspmu->has_ext64) {
> +		cspmu->impl.ops.is_cycle_counter_event =3D NULL;

[Severity: High]
Will this cause a kernel panic if a vendor PMU matches the EXT64 detection
logic?

Looking at pcie_v2_pmu_validate_event() in
drivers/perf/arm_cspmu/nvidia_cspmu.c, the function pointer is dereferenced
unconditionally:

    if (cspmu->impl.ops.is_cycle_counter_event(new_ev))

If has_ext64 is true, adding an event via perf_event_open() would
dereference this NULL pointer.

> +		cspmu->impl.ops.set_cc_filter =3D NULL;
> +	}
> +
>  	/* Firmware may override implementer/product ID from PMIIDR */
>  	if (apmt_node && apmt_node->impl_id)
>  		cspmu->impl.pmiidr =3D apmt_node->impl_id;
[ ... ]
> @@ -797,26 +841,33 @@ static void arm_cspmu_event_update(struct perf_even=
t *event)
>  static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
>  					struct hw_perf_event *hwc)
>  {
> -	u32 offset =3D PMEVTYPER + (4 * hwc->idx);
> -
> -	writel(hwc->config, cspmu->base0 + offset);
> +	if (cspmu->has_ext64)
> +		writeq(hwc->config, cspmu->base0 + PMEVTYPER + (8 * hwc->idx));
> +	else
> +		writel(hwc->config, cspmu->base0 + PMEVTYPER + (4 * hwc->idx));
>  }
> =20
>  static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
>  				    const struct perf_event *event)
>  {
> -	u32 filter =3D event->attr.config1 & ARM_CSPMU_FILTER_MASK;
> -	u32 filter2 =3D event->attr.config2 & ARM_CSPMU_FILTER_MASK;
> -	u32 offset =3D 4 * event->hw.idx;
> +	u64 filter =3D arm_cspmu_filter(event);
> +	u64 filter2 =3D arm_cspmu_filter2(event);
> +	int n =3D event->hw.idx;
> =20
> -	writel(filter, cspmu->base0 + PMEVFILTR + offset);
> -	writel(filter2, cspmu->base0 + PMEVFILT2R + offset);
> +	if (cspmu->has_ext64) {
> +		writeq(filter, cspmu->base0 + PMEVFILTR + (8 * n));

[Severity: High]
Is there a risk of register overlap and memory corruption here?

The driver relies on PMCFGR_N to set num_logical_ctrs up to 256. In EXT64
mode, configuration registers use an 8-byte stride. If the number of
counters is greater than or equal to 64, this stride calculation will
overflow into global control registers like PMCFGR and PMCR at 0xE00.
Exceeding 192 counters would overflow the 4KB MMIO page entirely.

Could this use a bounds check on num_logical_ctrs when has_ext64 is true?

> +		writeq(filter2, cspmu->base0 + PMEVFILT2R + (8 * n));
> +	} else {
> +		writel(filter, cspmu->base0 + PMEVFILTR + (4 * n));
> +		writel(filter2, cspmu->base0 + PMEVFILT2R + (4 * n));
> +	}
>  }
[ ... ]
> @@ -969,6 +1020,30 @@ static int arm_cspmu_init_mmio(struct arm_cspmu *cs=
pmu)
>  		}
>  	}
> =20
> +	/*
> +	 * We can infer FEAT_CSPMU_EXT64 from PMCNTEN, or hope that anything
> +	 * that failed to get that right has at least implemented the optional
> +	 * PMDEVARCH correctly...
> +	 *
> +	 * Note that architecturally, has_ext64 *should* imply has_atomic_dword,
> +	 * but enough implementations have ignored that already that we'll just
> +	 * have to still rely on the firmware flag.
> +	 */
> +	writel(~0U, cspmu->base0 + PMCNTENCLR);
> +	writel(~0U, cspmu->base0 + PMCNTEN);
> +	if (readl(cspmu->base0 + PMCNTENCLR)) {
> +		cspmu->has_ext64 =3D true;
> +		writel(0, cspmu->base0 + PMCNTEN);
> +	} else {

[Severity: Medium]
Does the else branch lack cleanup for the PMCNTEN write?

On legacy EXT32 hardware, PMCNTEN at 0xC10 aliases to PMCNTENSET[4], which
enables counters 128-159. If the probe falls back to this else branch, it
fails to clear this register, leaving those active hardware counters
permanently enabled.

> +		u32 reg =3D readl(cspmu->base0 + PMDEVARCH);
> +
> +		if (reg & ARM_CSPMU_PMDEVARCH_PRESENT) {
> +			reg &=3D ARM_CSPMU_PMDEVARCH_ARCHPART;
> +			if (reg =3D=3D 0xaf4 || reg =3D=3D 0xaf5)
> +				cspmu->has_ext64 =3D true;
> +		}
> +	}
> +
>  	cspmu->pmcfgr =3D readl(cspmu->base0 + PMCFGR);
> =20
>  	cspmu->num_logical_ctrs =3D FIELD_GET(PMCFGR_N, cspmu->pmcfgr) + 1;
[ ... ]
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_csp=
mu/nvidia_cspmu.c
> index bac83e424d6dc..a4c1ab8867091 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -762,7 +762,7 @@ static void pcie_tgt_pmu_reset_ev_filter(struct arm_c=
spmu *cspmu,
>  	pcie_tgt_pmu_config_addr_filter(cspmu, false, base, mask, idx);
>  }
> =20
> -static u32 pcie_tgt_pmu_event_type(const struct perf_event *event)
> +static u64 pcie_tgt_pmu_event_type(const struct perf_event *event)

[Severity: High]
Could the introduction of EXT64 mode cause register corruption in the vendor
specific event filter callbacks within this file?

Functions like nv_cspmu_set_ev_filter() and pcie_tgt_pmu_set_ev_filter()
hardcode a 32-bit stride for PMEVFILTR offset calculations:

    u32 offset =3D 4 * event->hw.idx;

If an NVIDIA PMU operates in EXT64 mode, the registers require an 8-byte
stride. Using the hardcoded 32-bit stride would write to the middle of the
64-bit registers and corrupt adjacent configuration fields.

>  {
>  	return event->attr.config & NV_PCIE_TGT_EV_TYPE_MASK;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2bde4469c918494e8fa=
04b2d297a6189ac8b7796.1785511378.git.robin.murphy@arm.com?part=3D1
