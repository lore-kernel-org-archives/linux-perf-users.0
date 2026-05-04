Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950B3290C8
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932782; cv=none; b=czQK53csb3zW/9288FbJ1N7+j7MtBECzbjAw993weZ+ITNySkPW1uKA/pdj96jQba7uzWBdp8DzWJuCYRl7hOfO7Srwq2Kcp+qkROd1HIS8zJZ5xtw/MuV6Jm2ez6fOYjiDRCuTKiKS6+avdABNzYVzOQXcJ4jKxT4NQNWssSbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932782; c=relaxed/simple;
	bh=ZZOBbXd7fMyOAjKeyBwJlFe6PKHKy6W0RIYJxswWOm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=isrZStfTr81CKD3oNVws46bDjUI4xbDwRauyPZZ60fGyYOvLGqxlqMEljtKuvl9lcwm8Lw3T90wlQq9r3AZZZzrq5eGwxVzY94mWJxX/Sue5b3arlGnyb0TYA6CwXe+pSn+VvcbS+1LS7tmF3RaCMjvlbEp0G+/MWpSsGQFPHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKoIcsWz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKoIcsWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25B4C2BCB8;
	Mon,  4 May 2026 22:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777932782;
	bh=ZZOBbXd7fMyOAjKeyBwJlFe6PKHKy6W0RIYJxswWOm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bKoIcsWzbwFghgadKK5IHoNIU/F9PSgOkWgWJ8ZVRM2n/6SusLs6A+v88NgzR2cZc
	 tVaVuKA6RkoC+BTbe+Pc2YL9mru0qRG3Z8+Dkiz46IR+wkG8oOZs/EDAfNNaZPc2qc
	 UdmiWnGki6T8QSK0RFu5Pf25iDdMLIau5gtNK3C1jass1Tag14YG/wgVirhVg+Bg5q
	 pRwHtqgRAPv5DRtJ3Tnks44OjfEcqJ0/F75sh3iDffpguBj7HK60EOYXUnsvI9I4Sp
	 n8ZIr/CRs9txZcnz8+O0Gqlv91lb85yfdenyNA+oZrnSdTnobSNwyh7D1s8S83H4PE
	 cl3+K0csmBYPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/20] KVM: arm64: Implement lazy PMU context swaps
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-15-coltonlewis@google.com>
References: <20260504211813.1804997-15-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:13:00 +0000
Message-Id: <20260504221301.A25B4C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Transitioning the PMU to GUEST_OWNED fails to load the guest's=
 virtual PMU state into the hardware registers, leading to an information l=
eak and state corruption.
- [High] PMU read accessors directly read from hardware registers when the =
PMU is in the FREE state, leaking host PMU state to the guest.
- [High] Restoring PMU registers via userspace during live migration fails =
to transition the vCPU to GUEST_OWNED, leaving restored counters inert.
- [High] `pmu_write_evtyper` fails to update the physical hardware register=
, causing guest event configurations to be ignored.
- [High] Direct hardware register manipulation in `pmu_write_evcntr` and `p=
mu_read_evcntr` lacks preemption protection, interacting with a bug in `kvm=
_pmu_put` to cause state corruption.
--

commit 62dcf0081f7f3437442e2756f69cc3188de056f1
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: Implement lazy PMU context swaps

This commit implements a simple state machine for PMU register access to=20
avoid the cost of context swapping for guests that never touch the PMU. The=
=20
PMU starts as free and transitions to guest-owned only when a guest accesse=
s=20
the PMU registers.

> diff --git a/arch/arm64/include/asm/kvm_types.h b/arch/arm64/include/asm/=
kvm_types.h
> index 9a126b9e2d7c9..4e39cbc80aa0b 100644
> --- a/arch/arm64/include/asm/kvm_types.h
> +++ b/arch/arm64/include/asm/kvm_types.h
> @@ -4,5 +4,9 @@
> =20
>  #define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
> =20
> -#endif /* _ASM_ARM64_KVM_TYPES_H */
> +enum vcpu_pmu_register_access {
> +	VCPU_PMU_ACCESS_FREE,
> +	VCPU_PMU_ACCESS_GUEST_OWNED,
> +};

How does this state machine handle PMU registers being restored via userspa=
ce
during live migration?

If userspace restores PMU registers via KVM_SET_ONE_REG, the sysreg setters
update the in-memory vCPU state but do not appear to call
kvm_pmu_set_guest_owned() or transition the state away from
VCPU_PMU_ACCESS_FREE.

When the migrated VM resumes execution, kvm_pmu_load() might ignore the PMU
context, leaving any previously running counters inert until the guest
explicitly performs a new PMU write.

> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 14cc419dbafad..881cea5117515 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
[ ... ]
> @@ -278,7 +297,8 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
>  	 * If we aren't guest-owned then we know the guest isn't using
>  	 * the PMU anyway, so no need to bother with the swap.
>  	 */
> -	if (!kvm_vcpu_pmu_is_partitioned(vcpu))
> +	if (!kvm_vcpu_pmu_is_partitioned(vcpu) ||
> +	    vcpu->arch.pmu.access !=3D VCPU_PMU_ACCESS_GUEST_OWNED)
>  		return;
> =20
>  	preempt_disable();

If the PMU is in the VCPU_PMU_ACCESS_FREE state, do the PMU read accessors
directly read from hardware registers?

If a guest reads a PMU register before performing any writes, the state
remains free. Because this check skips loading the guest context, could the
read accessors execute read_sysreg() on the physical hardware and return the
host's PMU state to the guest?

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index cc3d1804ab200..e4840d93a769f 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1035,6 +1035,7 @@ static bool pmu_access_event_counter_el0_disabled(s=
truct kvm_vcpu *vcpu)
>  static void pmu_write_pmcr(struct kvm_vcpu *vcpu, u64 val)
>  {
>  	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
> +		kvm_pmu_set_guest_owned(vcpu);
>  		write_sysreg(val, pmcr_el0);
>  		return;
>  	}

Does transitioning the PMU to VCPU_PMU_ACCESS_GUEST_OWNED here also require
loading the guest's virtual PMU state into the hardware registers?

When kvm_pmu_set_guest_owned() is called, it configures mdcr_el2 to allow
direct guest access but fails to invoke kvm_pmu_load(). Since the initial
vCPU entry skipped loading the PMU, the physical registers might still
contain the host's PMU state.

Could this allow the guest to read uninitialized hardware registers? Also,
upon preemption, kvm_pmu_put() might read these host values and overwrite t=
he
guest's saved memory context.

[ ... ]
> @@ -1193,6 +1195,8 @@ static void pmu_write_evcntr(struct kvm_vcpu *vcpu,=
 u64 val, u64 idx)
>  		return;
>  	}
> =20
> +	kvm_pmu_set_guest_owned(vcpu);
> +
>  	if (idx =3D=3D ARMV8_PMU_CYCLE_IDX) {
>  		write_sysreg(val, pmccntr_el0);
>  		return;

Is there a preemption issue when manipulating hardware registers directly
here? This problem wasn't introduced by this patch, but it significantly
impacts the PMU logic.

In pmu_write_evcntr(), the code modifies pmselr_el0 to select a counter ind=
ex
before writing to pmxevcntr_el0. Since KVM sysreg handlers run with preempt=
ion
enabled, if preemption occurs mid-sequence, kvm_pmu_put() iterates over gue=
st
counters, using and clobbering pmselr_el0.

It appears kvm_pmu_put() fails to read and save the original pmselr_el0 bef=
ore
its loop, instead saving the highest guest counter index at the end. When t=
he
task resumes, kvm_pmu_load() restores this highest index to pmselr_el0.
Execution resumes in pmu_write_evcntr(), which might then write to
pmxevcntr_el0, inadvertently mutating the highest guest counter instead of
the intended idx.

[ ... ]
> @@ -1281,6 +1285,7 @@ static void pmu_write_evtyper(struct kvm_vcpu *vcpu=
, u64 val, u64 idx)
>  	u64 mask;
> =20
>  	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
> +		kvm_pmu_set_guest_owned(vcpu);
>  		mask =3D kvm_pmu_evtyper_mask(vcpu->kvm);
>  		__vcpu_assign_sys_reg(vcpu, PMEVTYPER0_EL0 + idx, val & mask);
>  		return;
>  	}

Does this sequence fail to update the physical hardware register?

The code updates the guest's event configuration in the memory array using
__vcpu_assign_sys_reg(), but omits writing the value to the physical
pmxevtyper_el0 register.

Since KVM does not invoke kvm_pmu_load() after returning from a sysreg trap,
could the active hardware counter continue counting its previous event inst=
ead
of the newly configured one?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D14
