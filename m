Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82436C9CC
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932093; cv=none; b=s5hHVhrTGfzpGCv/sN6Gbl2/Tzed3DrE7EkBFjwFd39uvfzxhxHdaA/vj7ug9aN55q0CCWbveT2utRI7uUL80dKfgxuq9/EjF9Nop7Us8OwMt3d4qn9zaY+5w8QK68wcjwyMj0H6f2d9AO3niKve4KyDBxof2+QtSZVsEj5Yk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932093; c=relaxed/simple;
	bh=TTBDXo7fAFtjCDbM1qI+SbQ79WKQl5xzAITJSsDQY/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ne+ZAxRLFoORoFlvapGnRktzToJQk2rJfq3nIwNizkgQyl8+2lPhZnGTYug05phParqUiCYjQKkdqe9VdCfsVERLn7eC5ASEMoXgSLmqvS3cTnUsMVzHspulPGbX+5jPn5s5u5ovt6em+URJTbk4pQNG5pXVJWrr5n3RwkpwBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el/Hz9R1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el/Hz9R1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1701C2BCB8;
	Mon,  4 May 2026 22:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777932092;
	bh=TTBDXo7fAFtjCDbM1qI+SbQ79WKQl5xzAITJSsDQY/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=el/Hz9R1j3P2ZN/ckJMAjDrls2xJerP9A3aC/o9F00f7El98wN8f3WdntzOplbbIs
	 ap5nI+3KQYs4O1SBKx3in+w2ETnUogMQ66dG1Qo2Z3KjL7v9cPuMIkJkjOwTKz8i/+
	 d1hocUH0hsclXXM1k/AvZ8Yb6+ec4gmT22HogApdgNVsly+FNPrODRD9dPCyeQaaMA
	 fUTusOd1lKfwsvGs1rFnY9Yo9oTGXWqO5xK7AYYyDjioijIjMNmA/9FH6ZUTE9tpRT
	 dfWVXQTWdH0zy5tzhNIRFIVJLlLOv6D/MkRNUnNLAZoFz3OQLCeCne4PWjE0DOg+fI
	 GhfGXsHMC3GDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/20] KVM: arm64: Context swap Partitioned PMU guest
 registers
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-11-coltonlewis@google.com>
References: <20260504211813.1804997-11-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:01:32 +0000
Message-Id: <20260504220132.C1701C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] kvm_pmu_put() clobbers the guest's PMSELR_EL0 register by reading =
it after a loop that mutates it.
- [High] Missing ISB instruction after writing PMSELR_EL0 violates ARM arch=
itecture requirements.
- [High] kvm_pmu_put() clobbers read-only virtual PMCR_EL0 fields and fails=
 to restore the host's PMCR_EL0.
- [High] Hardware PMU counter overflows (PMOVSSET_EL0) occurring without gu=
est interrupts enabled are permanently lost.
- [High] kvm_pmu_guest_counter_mask() incorrectly uses the hardware maximum=
 instead of the vCPU's configured counter limit.
- [High] Guest PMU counters and interrupts are left enabled in hardware whe=
n switching back to the host.
- [Medium] GENMASK macros produce undefined behavior and invalid masks when=
 calculating 0-length counter sets.
--

commit cbcf45d4a902a24d3f32262cdbec6312af24a97d
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: Context swap Partitioned PMU guest registers

Save and restore newly untrapped registers that can be directly
accessed by the guest when the PMU is partitioned.

> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 63ac72910e4b5..360d022d918d5 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c

[ ... ]

> @@ -98,3 +99,171 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
> +u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
> +{
> +	u8 nr_counters =3D *host_data_ptr(nr_event_counters);
> +
> +	if (kvm_pmu_is_partitioned(pmu))
> +		return GENMASK(nr_counters - 1, pmu->max_guest_counters);

Does this cause a regression where the GENMASK macro evaluates to an invalid
all-ones mask on ARM64 if nr_counters equals pmu->max_guest_counters?

> +
> +	return ARMV8_PMU_CNT_MASK_ALL;
> +}
> +
> +/**
> + * kvm_pmu_guest_counter_mask() - Compute bitmask of guest-reserved coun=
ters

[ ... ]

> +u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
> +{
> +	if (kvm_pmu_is_partitioned(pmu))
> +		return ARMV8_PMU_CNT_MASK_C | GENMASK(pmu->max_guest_counters - 1, 0);

Could this mask incorrectly include host-owned counters if a VM is configur=
ed
with fewer counters than the physical maximum? It appears to use the
hardware maximum instead of the vCPU's configured counter limit.

Also, does this trigger the same GENMASK undefined behavior regression as
above if pmu->max_guest_counters is 0?

> +
> +	return 0;
> +}
> +
> +/**
> + * kvm_pmu_load() - Load untrapped PMU registers

[ ... ]

> +void kvm_pmu_load(struct kvm_vcpu *vcpu)
> +{

[ ... ]

> +	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
> +		val =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);
> +
> +		if (i =3D=3D ARMV8_PMU_CYCLE_IDX) {
> +			write_sysreg(val, pmccntr_el0);
> +		} else {
> +			write_sysreg(i, pmselr_el0);
> +			write_sysreg(val, pmxevcntr_el0);

Should there be a synchronization event between writing pmselr_el0 and
accessing pmxevcntr_el0? The ARMv8 architecture requires an isb instruction
here to prevent the pipeline from reordering the access and targeting the
previously selected counter.

> +		}
> +	}
> +
> +	val =3D __vcpu_sys_reg(vcpu, PMSELR_EL0);
> +	write_sysreg(val, pmselr_el0);
> +
> +	/* Save only the stateful writable bits. */
> +	val =3D __vcpu_sys_reg(vcpu, PMCR_EL0);
> +	mask =3D ARMV8_PMU_PMCR_MASK &
> +		~(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C);
> +	write_sysreg(val & mask, pmcr_el0);

Will overwriting the physical pmcr_el0 here silently cause a regression for
host PMU functionality? It looks like the host's original pmcr_el0 is never
restored when switching back to unpartitioned mode in kvm_pmu_put.

> +
> +	/*
> +	 * When handling these:
> +	 * 1. Apply only the bits for guest counters (indicated by mask)
> +	 * 2. Use the different registers for set and clear
> +	 */
> +	mask =3D kvm_pmu_guest_counter_mask(pmu);
> +
> +	/* Clear the hardware overflow flags so there is no chance of
> +	 * creating spurious interrupts. The hardware here is never
> +	 * the canonical version anyway.
> +	 */
> +	write_sysreg(mask, pmovsclr_el0);

Since kvm_pmu_put does not seem to read and save the hardware pmovsset_el0
register on VM exit, does clearing it here mean that any untrapped counter
overflows that occurred without guest interrupts enabled are permanently
lost?

> +
> +	val =3D __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> +	write_sysreg(val & mask, pmcntenset_el0);
> +	write_sysreg(~val & mask, pmcntenclr_el0);

[ ... ]

> +void kvm_pmu_put(struct kvm_vcpu *vcpu)
> +{

[ ... ]

> +	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
> +		if (i =3D=3D ARMV8_PMU_CYCLE_IDX) {
> +			val =3D read_sysreg(pmccntr_el0);
> +		} else {
> +			write_sysreg(i, pmselr_el0);
> +			val =3D read_sysreg(pmxevcntr_el0);

Is a synchronization event needed here as well, similar to the logic in
kvm_pmu_load?

> +		}
> +
> +		__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + i, val);
> +	}
> +
> +	val =3D read_sysreg(pmselr_el0);
> +	__vcpu_assign_sys_reg(vcpu, PMSELR_EL0, val);

Does this regression clobber the guest's pmselr_el0 state? The loop directly
above mutates the hardware pmselr_el0 register. Reading it immediately after
the loop would save the last loop index accessed instead of the guest's
programmed value.

> +
> +	val =3D read_sysreg(pmcr_el0);
> +	__vcpu_assign_sys_reg(vcpu, PMCR_EL0, val);

Could this blindly overwrite the read-only fields of the virtual pmcr_el0
(like N, IMP, IDCODE) with the host's physical values?

> +
> +	/* Mask these to only save the guest relevant bits. */
> +	mask =3D kvm_pmu_guest_counter_mask(pmu);
> +
> +	val =3D read_sysreg(pmcntenset_el0);
> +	__vcpu_assign_sys_reg(vcpu, PMCNTENSET_EL0, val & mask);
> +
> +	val =3D read_sysreg(pmintenset_el1);
> +	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);

Since partitioned vPMUs do not use host perf events, does this leave the
guest's hardware counters and interrupts active while the CPU executes
host code? This regression might leak host execution counts into the guest's
virtual counters and generate spurious overflow interrupts on the host.

> +
> +	preempt_enable();
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D10
