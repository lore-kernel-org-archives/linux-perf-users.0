Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4C3B52FA;
	Wed,  1 Jul 2026 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898503; cv=none; b=Z+cvOwGMkTao5B8CeKY9eiltYsrR+AOaYcq1MM1Mnqqv+u1VrIH9eRPUbg7FEgi37KU6bM3bYdsbfeNpEbvEbDQNuokuf2ubCdhwBVr8lBhDp+i8KI1BQJpReD1Fa+nuRQHm+jxEXkzpd5EZE1yN33M4yCT+6kWqX1VaUrCex5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898503; c=relaxed/simple;
	bh=faqnTWTtcQfKTHim8oRoH2UTFBwHg8sNGDM+1wt/lp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G+oxpqNH8khw+qA879Uqf86N5cyzGTb4L9WVzq1+REn1PG84jMez9Ub7Gi8OGW2UIVvKmUdZ+kOg+eDmWyHVg2b4PnLNFbfXY4wParYNdsucOg0/iFsVsWOhQGceAmnttK5B5oxvzdCQln2aHsnWLhtsm6jzKBugh8IaOHytWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dad113SM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dad113SM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6F01F000E9;
	Wed,  1 Jul 2026 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782898501;
	bh=KERyTwkwr3x7M2tugfO07wLcOOuYVicRsU/Ed7+YXKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dad113SM+mo/3YUehAKBfbsmshcWCR7BgQzDdj4IuegOGhNaVZYXEU1LyZLn+/d64
	 mXpWoB0IYs1LTe2MWrO+eIR1kcuY7ZS5aoraffSvrwPJQfhhPdZFSf7BNgcm+PRbdw
	 Mw5tUhSj5gBuQKZKdU8r3UNnQFS+jOmur8Pr/d/0cfgmhmxTiwymyFo0ohOoDdZh7L
	 +c7xN59KLjP53QkTKdLptZZgvYV7oBwYHBcckAO0gm5C6d4Z0SGBaYpPL20/8NVXy+
	 LUH41pX+pAdWyknem+zhtJGdwF51g4Uw0bo4xlQl+cjW4DYI7D9V0myyOL+nMfTjtL
	 kLa/RVP1lLNmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 16/22] RISC-V: perf: Use config2/vendor table for
 event to counter mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260701-counter_delegation-v8-16-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-16-7909f863a645@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:35:00 +0000
Message-Id: <20260701093500.6A6F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Legacy perf tools fail to profile hardware cycle and instruction e=
vents on platforms with counter delegation, rendering fixed counters and ve=
ndor mappings unusable.
- [High] Standard hardware events (PERF_TYPE_HARDWARE) fail unconditionally=
 on platforms supporting counter delegation unless a vendor-specific event =
table is present.
- [Medium] The 64-bit `event->attr.config2` mask is truncated to a 32-bit i=
nteger `temp_mask`, causing invalid user constraints to be silently bypasse=
d.
--

commit 25bb8be42a29d054e5ce833c3ed3ff8935990ee1
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Use config2/vendor table for event to counter mapping

This commit allows platform vendors to define custom mappings between
performance events and hardware counters via the config2 attribute. Legacy
events can either map to ISA-defined fixed counters or fall back to
alternate programmable counters as specified by the platform driver.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index fcf8fbb6fd864..19d9e47504247 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -1501,24 +1503,85 @@ static int rvpmu_deleg_find_ctrs(void)
>  	return num_hw_ctr;
>  }
> =20
> +/*
> + * The json file must correctly specify counter 0 or counter 2 is availa=
ble
> + * in the counter lists for cycle/instret events. Otherwise, the drivers=
 have
> + * no way to figure out if a fixed counter must be used and pick a progr=
ammable
> + * counter if available.
> + */
>  static int get_deleg_fixed_hw_idx(struct cpu_hw_events *cpuc, struct per=
f_event *event)
>  {
> -	return -EINVAL;
> +	bool guest_events =3D event->attr.config1 & RISCV_PMU_CONFIG1_GUEST_EVE=
NTS;
> +	int idx;
> +
> +	/* event_base is 0 on the delegation path; match via the original perf =
attrs. */
> +	if (guest_events) {
> +		if (event->attr.type !=3D PERF_TYPE_HARDWARE)
> +			return -EINVAL;
> +		if (event->attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES)
> +			idx =3D 0; /* CY counter */
> +		else if (event->attr.config =3D=3D PERF_COUNT_HW_INSTRUCTIONS)
> +			idx =3D 2; /* IR counter */
> +		else
> +			return -EINVAL;
> +	} else if (event->attr.config2 & RISCV_PMU_CYCLE_FIXED_CTR_MASK) {
> +		idx =3D 0; /* CY counter */
> +	} else if (event->attr.config2 & RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK) {
> +		idx =3D 2; /* IR counter */
> +	} else {
> +		return -EINVAL;
> +	}

[Severity: High]
Does this break legacy perf tools (like 'perf stat -e cycles') on platforms
with counter delegation?

Older tools don't set config2, so legacy events without config2 set are
explicitly rejected here. The code then falls back to
get_deleg_next_hpm_hw_idx(), which excludes fixed counters:

    hw_ctr_mask =3D cmask & (~0x7) & ~(cpuc->used_hw_ctrs[0]);

If the vendor table mapped the event to a fixed counter, the mask evaluation
will result in 0, causing the allocation to fail with -EINVAL.

> +
> +	/* Take the fixed counter only if delegated and free, else fall back. */
> +	if (!(cmask & BIT(idx)) || test_bit(idx, cpuc->used_hw_ctrs))
> +		return -EINVAL;
> +
> +	return idx;
>  }
> =20
>  static int get_deleg_next_hpm_hw_idx(struct cpu_hw_events *cpuc, struct =
perf_event *event)
>  {
> -	unsigned long hw_ctr_mask =3D 0;
> +	u32 hw_ctr_mask =3D 0, temp_mask =3D 0;
> +	u32 type =3D event->attr.type;
> +	u64 config =3D event->attr.config;
> +	int ret;
> =20
> -	/*
> -	 * TODO: Treat every hpmcounter can monitor every event for now.
> -	 * The event to counter mapping should come from the json file.
> -	 * The mapping should also tell if sampling is supported or not.
> -	 */
> +	/* Select only available hpmcounters */
> +	hw_ctr_mask =3D cmask & (~0x7) & ~(cpuc->used_hw_ctrs[0]);
> +
> +	switch (type) {
> +	case PERF_TYPE_HARDWARE:
> +		temp_mask =3D current_pmu_hw_event_map[config].counter_mask;

[Severity: High]
Do standard hardware events (PERF_TYPE_HARDWARE) fail unconditionally on
platforms supporting counter delegation if a vendor-specific event table is
missing?

In rvpmu_event_map(), it appears that all non-firmware events are intercept=
ed
when counter delegation is available:

    if (riscv_pmu_cdeleg_available() && !pmu_sbi_is_fw_event(event))
        return rvpmu_cdeleg_event_map(event, econfig);

Then in rvpmu_cdeleg_event_map(), it hard-fails standard hardware events if
the vendor table is missing:

    case PERF_TYPE_HARDWARE:
        if (config >=3D PERF_COUNT_HW_MAX)
            return -EINVAL;
        if (!current_pmu_hw_event_map)
            return -ENOENT;

Without a fallback to the SBI PMU, does this completely break legacy hardwa=
re
events on new platforms that don't yet have a vendor-specific driver table?

> +		break;
> +	case PERF_TYPE_HW_CACHE:
> +		ret =3D cdeleg_pmu_event_find_cache(config, NULL, &temp_mask);
> +		if (ret)
> +			return ret;
> +		break;
> +	case PERF_TYPE_RAW:
> +		/*
> +		 * Mask off the counters that can't monitor this event (specified via =
json)
> +		 * The counter mask for this event is set in config2 via the property =
'Counter'
> +		 * in the json file or manual configuration of config2. If the config2=
 is not set,
> +		 * it is assumed all the available hpmcounters can monitor this event.
> +		 * Note: This assumption may fail for virtualization use case where th=
ey hypervisor
> +		 * (e.g. KVM) virtualizes the counter. Any event to counter mapping pr=
ovided by the
> +		 * guest is meaningless from a hypervisor perspective. Thus, the hyper=
visor doesn't
> +		 * set config2 when creating kernel counter and relies default host ma=
pping.
> +		 */
> +		if (event->attr.config2)
> +			temp_mask =3D event->attr.config2;

[Severity: Medium]
Will this silently bypass user-provided counter constraints if only bits ab=
ove
31 are set in config2?

event->attr.config2 is a u64, but temp_mask is defined as a u32. When confi=
g2
is assigned to temp_mask, the upper 32 bits are truncated. If the resulting
temp_mask evaluates to 0, it skips the constraint application entirely:

    if (temp_mask)
        hw_ctr_mask &=3D temp_mask;

Would this result in the kernel incorrectly programming the event on any
available programmable counter instead of rejecting the invalid constraint?

> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (temp_mask)
> +		hw_ctr_mask &=3D temp_mask;
> +
> +	if (!hw_ctr_mask)
> +		return -EINVAL;
> =20
> -	/* Select only hpmcounters */
> -	hw_ctr_mask =3D cmask & (~0x7);
> -	hw_ctr_mask &=3D ~(cpuc->used_hw_ctrs[0]);
>  	return __ffs(hw_ctr_mask);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-counter_de=
legation-v8-0-7909f863a645@meta.com?part=3D16
