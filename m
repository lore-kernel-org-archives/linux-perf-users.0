Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E337F8C7
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933138; cv=none; b=AqdvXdNFdIY+9l4qJl5drremkwMFrmLz9ZcocgI1B56JPN8FKPPoKo2z4h9FKMrJJDUgPGsnOdrNGO4jK+yWKBaG/cD5lWZSg9w8BVx13H7BguGEP2ktM+hr82c4R/lIFVOUWr/+9JMI/kNsvjswH5MdeCdqLBcxWqTeLvHwGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933138; c=relaxed/simple;
	bh=k6awz5AIhd9VVexzjGn39H+cbMy7beoR2+itSmGpjI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vEFQI7MHdjPruBtPjGpCjcWBsvU8xyw7VqkdcqIudot7F4H5ijRZBUpOhJTjhC4LORIiB7gv9Kv/6JitgAAzCp28GcO/bsfEX0VsIuiCLW1TvKeSBeoNtdwxlEeGyIWq2HHFLRxwtfepxpXZ7hHvjGZG42V2r/SkjxvstXQ+pAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f744aYA7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f744aYA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22931C2BCB8;
	Mon,  4 May 2026 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777933138;
	bh=k6awz5AIhd9VVexzjGn39H+cbMy7beoR2+itSmGpjI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=f744aYA7kjZ6SWCfXS9Dem17kCDhkd5ioP8zpiNYx+dAj286A76LDOvir3eKwBSVd
	 oHfE/Dp+TSHhSGq5tKoDuCl+YWug9UHfNytJl48hAc6uIMHIjEVJdNqlAme28ceJRX
	 T5uSZNKhD5JNNImzRpaWoPY/+gdwBh6ChOCGG9jmJ4PAOgKInSy0PvT3Bt/M7T2GCN
	 wWgXSdZTLfK33IG58b6k4R4/QlPdOHJzIStA1TAgTcC+lWSvjT2nQCqkyQUn1b2OM7
	 Lb4wJHS4N+l8X/tEF3xtVkrXh0omfEFmLf07n7SrtJgqvYcNJrDQPTa5SPFyVoM2r2
	 lJCVaOcArJOUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/20] perf: arm_pmuv3: Handle IRQs for Partitioned
 PMU guest counters
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-16-coltonlewis@google.com>
References: <20260504211813.1804997-16-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:18:57 +0000
Message-Id: <20260504221858.22931C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Non-atomic read-modify-write race on `PMOVSSET_EL0` corrupts guest=
 PMU state.
- [High] Guest PMU interrupts are permanently dropped if they fire while th=
e vCPU is scheduled out.
- [High] Missing KVM request fails to inject virtual PMU interrupts into th=
e guest.
- [High] Pending or polled guest PMU overflow flags are silently lost durin=
g vCPU context switches.
--

commit a0dad1aa1988f327f4127d17e8307aeadf9dd34d
Author: Colton Lewis <coltonlewis@google.com>

perf: arm_pmuv3: Handle IRQs for Partitioned PMU guest counters

Because ARM hardware is not yet capable of direct PPI injection into
guests, guest counters will still trigger interrupts that need to be
handled by the host PMU interrupt handler. Clear the overflow flags in
hardware to handle the interrupt as normal, but the virtual overflow
register for later injecting the interrupt into the guest.

[ ... ]

> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 881cea5117515..535b4c492ff80 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -411,3 +411,25 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
>  	kvm_pmu_set_guest_counters(pmu, 0);
>  	preempt_enable();
>  }

Does this code need to save the guest's hardware overflow flags from
pmovsclr_el0 into the vCPU memory context when it is scheduled out?

If a guest counter overflows but the vCPU is preempted before the PMU IRQ
is delivered, or if the guest is intentionally polling the counters with
interrupts disabled, the hardware overflow bit remains set. Because this
function doesn't save the active hardware state, could the overflow be
lost across the context switch?

Also, should this function clear the hardware registers (pmcntenclr_el0
and pmintenclr_el1) to stop the guest counters? If they continue running
while the physical CPU executes host tasks, they can overflow and trigger
a physical PMU interrupt while the vCPU is scheduled out.

> +
> +/**
> + * kvm_pmu_handle_guest_irq() - Record IRQs in guest counters
> + * @pmu: PMU to check for overflows
> + * @pmovsr: Overflow flags reported by driver
> + *
> + * Set overflow flags in guest-reserved counters in the VCPU register
> + * for the guest to clear later.
> + */
> +void kvm_pmu_handle_guest_irq(struct arm_pmu *pmu, u64 pmovsr)
> +{
> +	struct kvm_vcpu *vcpu =3D kvm_get_running_vcpu();
> +	u64 mask =3D kvm_pmu_guest_counter_mask(pmu);
> +	u64 govf =3D pmovsr & mask;
> +
> +	write_pmovsclr(govf);
> +
> +	if (!vcpu)
> +		return;

If the counters continue running while the vCPU is scheduled out, can
a physical PMU interrupt fire when kvm_get_running_vcpu() is NULL?

Since the handler clears the physical overflow flag via write_pmovsclr()
but immediately returns here without saving the overflow state to the
vCPU memory backing store, are guest PMU interrupts permanently dropped
in this scenario?

> +
> +	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=3D, govf);

Could this non-atomic read-modify-write corrupt the guest PMU state?

kvm_pmu_handle_guest_irq() executes in hardirq context, while KVM FGT trap
handlers execute in KVM process context with local IRQs enabled. If a
physical PMU interrupt preempts the vCPU thread while it is in the middle
of a process-context read-modify-write on PMOVSSET_EL0, the hardirq
handler's modification could be completely overwritten and lost when the
interrupted trap handler writes back its stale value.

Additionally, since this executes unconditionally even if govf =3D=3D 0,
could it create a non-atomic read/write cycle that blindly clobbers the
trap handler's concurrent modifications?

Finally, how does KVM know to inject the virtual PMU interrupt? Should
there be a call to kvm_make_request(KVM_REQ_PMU, vcpu) here? Without a
vCPU request to evaluate and route virtual interrupts to the VGIC, the
KVM run loop will re-enter the guest without asserting the vPPI, and the
guest will remain unaware of the overflow until an unrelated VM exit
occurs.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D15
