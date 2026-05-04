Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C883337B03B
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932406; cv=none; b=YPdamifMq/CMN8Kbmljai7USRbtQ3wQQYfOHlWGfa+mBni7t1iwJ4HIhlOErQXydBG23cO91YRvZAuFliq08gy2HggNOTfvCcBl+JWssqXc8e3BiK/m0w/4zTUhZPSv6Gb918+nuxq9zOVrkT4Eb6l9AKFMizaKAxiW3tyXAjIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932406; c=relaxed/simple;
	bh=8uYILBNGP4Bqbpvmjzaojr1jo53tWQgQSaYFZALv5u4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EB7GDCMeygp1TmEmP5keCxKAXFSZrhxcnrDLlgtJAkLe+wrrkSTm2QG2oTR65u4UZeFBcb3aqmSbZmRCb/Bd1qRemAra3xqzMWD3a1Ij5eBPmsmJzLQL6Rp6vP4S6Oa9F1J63aHH9scHIj60RGDpXjV/7eHd4ARdL2uPErnjXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyJkShmj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyJkShmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD8DC2BCB8;
	Mon,  4 May 2026 22:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777932406;
	bh=8uYILBNGP4Bqbpvmjzaojr1jo53tWQgQSaYFZALv5u4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DyJkShmjzcD/c5rJmo6DlDRWGwyeirv7h05bsyuB/1yCMkG5dKQESuZ/tw+ugfRuo
	 MIIwoDVjJ6BpZJgs28myrjw9V/fgGLDcZ+tN4JW9LI15pncL1CygmhXyzMG1ihi7nK
	 /2S6P3Vvp9uSYhlGdgjnOJPZO3fD8VZu3OUilQ8KXMqj2tQcOfbAc5ieoy015Bk1M2
	 woI8SNjEHF/wCbQRs8QPgeBD1JCTvlgIhXOKA/244znmKslLmBRU5qAltM1/S+uPvA
	 Y6cOM80W12SFET4RKUN9CETjQGi3Yrbr5cIRAGH4EuuhA7x5cvyG2I1Yx1jsXBHk5Q
	 mf4WBZvwlCjFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/20] KVM: arm64: Add Partitioned PMU register trap
 handlers
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-9-coltonlewis@google.com>
References: <20260504211813.1804997-9-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:06:45 +0000
Message-Id: <20260504220646.3CD8DC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Guest PMCR_EL0 writes directly trigger hardware reset at host =
privilege level, clearing host PMU counters.
- [High] Unmasked reads of PMCNTENSET_EL0 and PMINTENSET_EL1 leak host PMU =
configuration to the guest.
- [High] Race condition and data corruption due to hardware PMU registers b=
eing accessed without disabling IRQs or preemption.
- [High] Architectural violation: Missing instruction synchronization barri=
er (ISB) between PMSELR_EL0 write and PMXEVCNTR_EL0 access.
- [Medium] Nested virtualization boundary bypass in `pmu_read_pmcr`.
- [Low] Dead code and brittle logic: Unused `reg` variable in `access_pmu_e=
vtyper` relies on implicit enum layout.
--

commit 6a28050b2477f91b45c9d48b5b98d954e310fb44
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: Add Partitioned PMU register trap handlers

We may want a partitioned PMU but not have FEAT_FGT to untrap the
specific registers that would normally be untrapped. Add handling for
those trapped register accesses that does the right thing if the PMU
is partitioned.

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 0a8e8ee69cd00..cc3d1804ab200 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c

[ ... ]

> @@ -1016,6 +1032,29 @@ static bool pmu_access_event_counter_el0_disabled(=
struct kvm_vcpu *vcpu)
>  	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_ER | ARMV8_PMU=
_USERENR_EN);
>  }
> =20
> +static void pmu_write_pmcr(struct kvm_vcpu *vcpu, u64 val)
> +{
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
> +		write_sysreg(val, pmcr_el0);
> +		return;
> +	}
> +
> +	kvm_pmu_handle_pmcr(vcpu, val);
> +}

Since KVM sysreg trap handlers execute at EL2 in VHE mode, does writing the
guest's value directly to pmcr_el0 allow a guest to reset all host PMU
counters?

According to the ARM Architecture Reference Manual, writing PMCR_EL0.P =3D =
1 or
PMCR_EL0.C =3D 1 from EL2 unconditionally resets all event counters or the =
cycle
counter respectively, bypassing MDCR_EL2.HPMN isolation.

> +
> +static u64 pmu_read_pmcr(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
> +		return u64_replace_bits(
> +			read_sysreg(pmcr_el0),
> +			vcpu->kvm->arch.nr_pmu_counters,
> +			ARMV8_PMU_PMCR_N);
> +	}
> +
> +	return kvm_vcpu_read_pmcr(vcpu);
> +
> +}

Does this hardcoded replacement of the N field with
vcpu->kvm->arch.nr_pmu_counters ignore L1's nested virtualization limits?

The standard KVM read path in kvm_vcpu_read_pmcr() recalculates the N field
based on nested state to restrict counters for an L2 guest.

[ ... ]

> @@ -1128,6 +1184,44 @@ static int set_pmu_evcntr(struct kvm_vcpu *vcpu, c=
onst struct sys_reg_desc *r,
>  	return 0;
>  }
> =20
> +static void pmu_write_evcntr(struct kvm_vcpu *vcpu, u64 val, u64 idx)
> +{
> +	u64 pmselr;
> +
> +	if (!kvm_vcpu_pmu_is_partitioned(vcpu)) {
> +		kvm_pmu_set_counter_value(vcpu, idx, val);
> +		return;
> +	}
> +
> +	if (idx =3D=3D ARMV8_PMU_CYCLE_IDX) {
> +		write_sysreg(val, pmccntr_el0);
> +		return;
> +	}
> +
> +	pmselr =3D read_sysreg(pmselr_el0);
> +	write_sysreg(idx, pmselr_el0);
> +	write_sysreg(val, pmxevcntr_el0);
> +	write_sysreg(pmselr, pmselr_el0);
> +}

Are preemption and local IRQs enabled here?

If a host Performance Monitoring Interrupt (PMI) fires between setting
pmselr_el0 and accessing pmxevcntr_el0, couldn't the host PMU driver modify
pmselr_el0 to service its own counter, causing KVM to access the wrong
counter when it resumes?

Also, is an instruction synchronization barrier (ISB) required between
writing pmselr_el0 and accessing pmxevcntr_el0?

The ARM Architecture Reference Manual requires a context synchronization ev=
ent
after writing to a selector register before accessing multiplexed registers
like pmxevcntr_el0.

> +
> +static u64 pmu_read_evcntr(struct kvm_vcpu *vcpu, u64 idx)
> +{
> +	u64 pmselr;
> +	u64 val;
> +
> +	if (!kvm_vcpu_pmu_is_partitioned(vcpu))
> +		return kvm_pmu_get_counter_value(vcpu, idx);
> +
> +	if (idx =3D=3D ARMV8_PMU_CYCLE_IDX)
> +		return read_sysreg(pmccntr_el0);
> +
> +	pmselr =3D read_sysreg(pmselr_el0);
> +	write_sysreg(idx, pmselr_el0);
> +	val =3D read_sysreg(pmxevcntr_el0);
> +	write_sysreg(pmselr, pmselr_el0);
> +	return val;
> +}

The same questions regarding preemption, local IRQs, and the missing ISB
apply here when reading pmxevcntr_el0.

[ ... ]

> +static void pmu_write_evtyper(struct kvm_vcpu *vcpu, u64 val, u64 idx)
> +{
> +	u64 mask;
> +
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
> +		mask =3D kvm_pmu_evtyper_mask(vcpu->kvm);
> +		__vcpu_assign_sys_reg(vcpu, PMEVTYPER0_EL0 + idx, val & mask);
> +		return;
> +	}
> +
> +	kvm_pmu_set_counter_event_type(vcpu, val, idx);
> +	kvm_vcpu_pmu_restore_guest(vcpu);
> +}

Does PMEVTYPER0_EL0 + idx assume a specific enum layout to reach PMCCFILTR_=
EL0
when idx is ARMV8_PMU_CYCLE_IDX (31)?

[ ... ]

> @@ -1191,7 +1305,7 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcp=
u, struct sys_reg_params *p,
> =20
>  	if (r->CRn =3D=3D 9 && r->CRm =3D=3D 13 && r->Op2 =3D=3D 1) {
>  		/* PMXEVTYPER_EL0 */
> -		idx =3D SYS_FIELD_GET(PMSELR_EL0, SEL, __vcpu_sys_reg(vcpu, PMSELR_EL0=
));
> +		idx =3D SYS_FIELD_GET(PMSELR_EL0, SEL, pmu_read_pmselr(vcpu));
>  		reg =3D PMEVTYPER0_EL0 + idx;
>  	} else if (r->CRn =3D=3D 14 && (r->CRm & 12) =3D=3D 12) {
>  		idx =3D ((r->CRm & 3) << 3) | (r->Op2 & 7);
> @@ -1207,12 +1321,10 @@ static bool access_pmu_evtyper(struct kvm_vcpu *v=
cpu, struct sys_reg_params *p,
>  	if (!pmu_counter_idx_valid(vcpu, idx))
>  		return false;
> =20
> -	if (p->is_write) {
> -		kvm_pmu_set_counter_event_type(vcpu, p->regval, idx);
> -		kvm_vcpu_pmu_restore_guest(vcpu);
> -	} else {
> -		p->regval =3D __vcpu_sys_reg(vcpu, reg);
> -	}
> +	if (p->is_write)
> +		pmu_write_evtyper(vcpu, p->regval, idx);
> +	else
> +		p->regval =3D pmu_read_evtyper(vcpu, idx);

Is the reg variable computed above now completely unused in this function?

[ ... ]

> +static u64 pmu_read_pmcnten(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu))
> +		return read_sysreg(pmcntenset_el0);
> +
> +	return __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> +}
> +
>  static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params =
*p,
>  			   const struct sys_reg_desc *r)
>  {
> @@ -1246,40 +1387,58 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu,=
 struct sys_reg_params *p,
>  	mask =3D kvm_pmu_accessible_counter_mask(vcpu);
>  	if (p->is_write) {
>  		val =3D p->regval & mask;
> -		if (r->Op2 & 0x1)
> -			/* accessing PMCNTENSET_EL0 */
> -			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, |=3D, val);
> -		else
> -			/* accessing PMCNTENCLR_EL0 */
> -			__vcpu_rmw_sys_reg(vcpu, PMCNTENSET_EL0, &=3D, ~val);
> -
> -		kvm_pmu_reprogram_counter_mask(vcpu, val);
> +		pmu_write_pmcnten(vcpu, val, r->Op2 & 0x1);
>  	} else {
> -		p->regval =3D __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> +		p->regval =3D pmu_read_pmcnten(vcpu);
>  	}
> =20
>  	return true;
>  }

Since KVM executes at EL2, does reading pmcntenset_el0 directly return the
global PMU state, including enable bits for host-owned counters (indices >=
=3D
HPMN)?

Without applying kvm_pmu_accessible_counter_mask(vcpu) to the result in the
read path, it appears to expose host PMU activity to the guest.

[ ... ]

> +static u64 pmu_read_pminten(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu))
> +		return read_sysreg(pmintenset_el1);
> +
> +	return __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
> +}
> +
>  static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params =
*p,
>  			   const struct sys_reg_desc *r)
>  {
> -	u64 mask =3D kvm_pmu_accessible_counter_mask(vcpu);
> +	u64 val, mask;
> =20
>  	if (check_pmu_access_disabled(vcpu, 0))
>  		return false;
> =20
> +	mask =3D kvm_pmu_accessible_counter_mask(vcpu);
>  	if (p->is_write) {
> -		u64 val =3D p->regval & mask;
> +		val =3D p->regval & mask;
> =20
> -		if (r->Op2 & 0x1)
> -			/* accessing PMINTENSET_EL1 */
> -			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, |=3D, val);
> -		else
> -			/* accessing PMINTENCLR_EL1 */
> -			__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, &=3D, ~val);
> +		pmu_write_pminten(vcpu, val, r->Op2 & 0x1);
>  	} else {
> -		p->regval =3D __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
> +		p->regval =3D pmu_read_pminten(vcpu);
>  	}
> =20
>  	return true;
>  }

Similarly, does reading pmintenset_el1 directly leak host PMU interrupt
configuration to the guest without applying the mask?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D8
