Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6235A38C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938441; cv=none; b=tHVzRXA5QrEPDpYQOfaRixOBHwQHC0aQmq91VrzdQv+KtAqEI3Na56RCAIJ66P8JutLxo/l/FlD38guQ8wcrESyNNXzVdcjFgOiwigfdcuO+r5FzPkqtjxLWvJcn/KJBlX41YCwhGkB8Qx9xrBocc3mAnetVmS+T+WPEv1ISsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938441; c=relaxed/simple;
	bh=EHO0XL2s1bzgOxSGFvSf9eo9OLSAYx16svMyt81aaeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JLNiF9vwnhVveYymOAfZW8QyjWbHB9hEW7UtEiJ3ewZ3HswhH5SDD5LCir2832V6e4lZ5NGGJt563fNOQd2jJK7LitC/rhuhqDY6EeozzSmo9sE6Bb6ofYTM38CC5Z+9xjpOUxt/FZh4Wik6lXWzDict60JVtohctiASKHONV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9UViJ0z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9UViJ0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0502C2BCB8;
	Mon,  4 May 2026 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777938441;
	bh=EHO0XL2s1bzgOxSGFvSf9eo9OLSAYx16svMyt81aaeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q9UViJ0zEZ6/6vpFGR1oWqzlM/QEI+/Cf9h08h1/y+D22GxNQc0alSxL1qceaJG3s
	 qk4fpdyCwJ70b0Y99wpIY4SRUpq79Eof79ZXwatxPJ+dquKwBigujj7bJRDKNyYp/v
	 jl1crCPdZEMQp5DQLPVCIi2KPIjs/CmBAuYo45Lc2dcKs75NSL3E84vrNNrAoKDiTz
	 yxkxWaKDS8HtFVkPIsWUF2yvRn4nCy5DPjrmIXsZlQl0rOzDUWEnrsblnEbXHqrMj1
	 l31TO/SGIQUm9fjYhM0SxsH3n8KWSpSItARF18esAfPwpnMz3wvQtXFkk81DZzqLOV
	 7KFksl/SezPjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/20] KVM: arm64: Detect overflows for the
 Partitioned PMU
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-17-coltonlewis@google.com>
References: <20260504211813.1804997-17-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 23:47:20 +0000
Message-Id: <20260504234720.E0502C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Virtual PMU interrupts can be permanently lost or arbitrarily dela=
yed due to untrapped PMINTENSET_EL1 unmasking.
- [High] Undefined behavior and host state leakage when partitioned PMU has=
 0 guest counters.
- [High] The host PMU driver unconditionally overwrites the guest's PMCR_EL=
0.E state during host interrupt handling.
- [High] Hardware PMU interrupts do not wake a halted VCPU or assert KVM_RE=
Q_IRQ_PENDING, leading to missed wakeups and TOCTOU races.
- [High] kvm_pmu_part_overflow_status() incorrectly drops pending PMU inter=
rupts for migrated VMs.
- [High] Data race in PMOVSSET_EL0 read-modify-write causes lost hardware P=
MU overflows.
- [High] kvm_pmu_part_overflow_status() reads hardware registers containing=
 host state due to incomplete lazy context switching.
- [Low] Dangling function declaration for kvm_pmu_overflow_status().
--

commit a5f6bda341ad4e262b923aa705a780bcfa130602
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: Detect overflows for the Partitioned PMU

This commit calculates whether any guest counters overflowed upon VM
re-entry after a PMU interrupt, injecting an interrupt if necessary.

> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 535b4c492ff8..9693d9eb69da 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
[ ... ]
> @@ -433,3 +433,33 @@ void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u=
64 pmovsr)
> =20
>  	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=3D, govf);

Is there a data race here since __vcpu_rmw_sys_reg() is not atomic?

If kvm_pmu_handle_guest_irq() runs in hardirq context and preempts a
sysreg trap handler like access_pmovs() that is currently between
the read and write steps of __vcpu_rmw_sys_reg() for PMOVSSET_EL0:

access_pmovs()
   read PMOVSSET_EL0
   <-- hardware PMU interrupt preempts here
   ...
   write PMOVSSET_EL0

Will the trap handler overwrite the register with a stale value and
erase the hardware overflow event?

Does this missing KVM_REQ_IRQ_PENDING and vcpu kick cause missed wakeups?

Unlike the emulated PMU handler, this does not call
kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu) or kvm_vcpu_kick(vcpu). If the
hardware PMU interrupt fires while the VCPU is halted in kvm_vcpu_block(),
will KVM fail to wake it up?

>  }
> +
> +/**
> + * kvm_pmu_part_overflow_status() - Determine if any guest counters have=
 overflowed
> + * @vcpu: Pointer to struct kvm_vcpu
> + *
> + * Determine if any guest counters have overflowed and therefore an
> + * IRQ needs to be injected into the guest. If access is still free,
> + * then the guest hasn't accessed the PMU yet so we know the guest
> + * context is not loaded onto the pCPU and an overflow is impossible.
> + *
> + * Return: True if there was an overflow, false otherwise
> + */
> +bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu)
> +{
> +	struct arm_pmu *pmu;
> +	u64 mask, pmovs, pmint, pmcr;
> +	bool overflow;
> +
> +	if (vcpu->arch.pmu.access =3D=3D VCPU_PMU_ACCESS_FREE)
> +		return false;

Will this check drop pending PMU interrupts for migrated VMs?

When a VM is migrated, userspace populates the PMU state via KVM_SET_ONE_RE=
G,
but vcpu->arch.pmu.access remains VCPU_PMU_ACCESS_FREE. When KVM executes
the VCPU for the first time, kvm_pmu_update_state() calls this function,
which will return false immediately and set pmu->irq_level =3D false, dropp=
ing
the restored interrupt.

> +
> +	pmu =3D vcpu->kvm->arch.arm_pmu;
> +	mask =3D kvm_pmu_guest_counter_mask(pmu);

Can this result in undefined behavior and leak host state if the partitioned
PMU has 0 guest counters?

If a module parameter reserves all counters for the host,
pmu->max_guest_counters is 0. In kvm_pmu_guest_counter_mask(), calling
GENMASK(pmu->max_guest_counters - 1, 0) becomes GENMASK(-1, 0), evaluating =
to
~0UL. Will this include all host-reserved counters in the mask and inject
spurious PMU interrupts into the guest on host overflows?

> +	pmovs =3D __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
> +	pmint =3D read_pmintenset();

Since the guest has untrapped access to PMINTENSET_EL1 in partitioned mode,
can virtual PMU interrupts be lost or delayed?

If a guest counter overflows while its PMINTENSET bit is cleared, no hardwa=
re
interrupt fires. The host IRQ handler later clears the physical overflow bit
and moves it to the VCPU shadow register.

If the guest later writes to PMINTENSET_EL1 to unmask the interrupt, KVM is
not notified. The hardware will not assert a physical IRQ because the
physical bit is gone, and this function will not evaluate the new state
until an unrelated VM exit.

Will reading pmintenset_el1 directly from hardware read host state due to
incomplete lazy context switching?

If a VCPU is scheduled with access =3D=3D VCPU_PMU_ACCESS_FREE, kvm_pmu_loa=
d()
skips loading the guest's PMU context. If the guest accesses a trapped
register, kvm_pmu_set_guest_owned() transitions the state but does not trig=
ger
a full hardware reload. When the VCPU exits, these hardware reads will see
host state.

> +	pmcr =3D read_pmcr();

Can the host PMU driver overwrite the guest's PMCR_EL0.E state here?

If a host-reserved counter overflows, the host's armv8pmu_handle_irq()
executes and calls armv8pmu_start(), which executes:

armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E)

Will this force PMCR_EL0.E to 1 in hardware, permanently corrupting the
guest's configuration and causing KVM to evaluate (pmcr & ARMV8_PMU_PMCR_E)
as true?

> +	overflow =3D (pmcr & ARMV8_PMU_PMCR_E) && (mask & pmovs & pmint);
> +
> +	return overflow;
> +}

> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index de058a5347d1..4af8abf2dde0 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
[ ... ]
> @@ -90,6 +90,8 @@ bool kvm_set_pmuserenr(u64 val);
>  void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
>  void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
>  void kvm_vcpu_pmu_resync_el0(void);
> +bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu);
> +bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu);

This isn't a bug, but this patch leaves a dangling declaration for
kvm_pmu_overflow_status() elsewhere in the header, since the function was
renamed to kvm_pmu_emul_overflow_status() in this commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D16
