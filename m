Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDEB29BD8C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933425; cv=none; b=D3drArHSjevxcg0lTdpLy1ug1q6vYwyIbhfKF2Zf/2JGLgTxTeNRhuG3nX1+TXhs1kFyeuQVChrnmTzz7OINgsOFcB67btWIc/+UgREwFdjyy7AhuQ7+DDkqsOyGi7kKza8vS1RhZfT1cRwOxArRFCxRKw6vgTYX0kZdKCvejNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933425; c=relaxed/simple;
	bh=1Kgi+bPxW0SjLDOZFAxvHK7jZ4cNmGvBNsD8v4fr8JM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=np3HSfQFZx75kSavnuTIerspFR18m76ReHv5zdtzRGPENa6yFfEyhIMpFo5FRyvIbnT0pV7Tsfu9WoZrXyl4yG5DBmcg01mOJxMk98snr0hitwf0ooFg2CqPIgU28cxkvy8/Lr5zvbPBFxBEw6nFc6ga2Bi1kjFYnEmF+dLke+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJHiy2n4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJHiy2n4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F12C2BCB8;
	Mon,  4 May 2026 22:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777933425;
	bh=1Kgi+bPxW0SjLDOZFAxvHK7jZ4cNmGvBNsD8v4fr8JM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nJHiy2n4szfVfRtGc2oNQZXsaCgP7Rqm+RtFsJLi8SazLwZXolj8erBuvgln3+aKZ
	 6qT+Od7qpNpJnK/k1ATsGRtb9BDQ3pQzZApEcq0wiXDGqg9sLmjdQbOSGvg4PGJ7C2
	 BSI2NC7BTfa46CT1FooAMjKHrk2GV2nzpQNMCirGZjLU3oBzEJrFGSkFuS7TDGuTLG
	 fg6tlniN/xeNzReiKv93GgBqsTzYGQ95haZPg216oi/fjcYLK4p6ajwWxA4Pk2yG6B
	 8boNMzx9X5cOsvTrHGgCMsSlIdhq6pRcBXfxuWTrnIHdlMEgqoNoimyyIAAtw1MaqG
	 xJrAtJDZiuPaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/20] KVM: arm64: Add vCPU device attr to partition
 the PMU
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-18-coltonlewis@google.com>
References: <20260504211813.1804997-18-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:23:44 +0000
Message-Id: <20260504222344.C8F12C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION modifies VM-wide state withou=
t checking if the VM has already run, allowing state corruption.
- [High] get_user() reads a 32-bit unsigned int directly into a 1-byte bool=
, leading to truncation bugs and failing to enforce strict UAPI input valid=
ation.
- [Medium] kvm_arm_pmu_v3_has_attr() unconditionally advertises support for=
 the KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION attribute even when the host hard=
ware does not support it.
- [Low] Mismatched kernel-doc comments for kvm_vcpu_pmu_is_partitioned() an=
d kvm_pmu_partition_enable().
--

commit d9172235a5a8d816682a8078c38e635415737a2b
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: Add vCPU device attr to partition the PMU

This commit introduces a new PMU device attribute to enable partitioned
PMU support for a VM. The capability can be configured before the vCPU star=
ts,
provided PMUv3 and VHE are supported and the host driver has reserved
counters.

> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 9693d9eb69daa..47fd143cf4ac7 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -44,8 +44,8 @@ bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
>  }
> =20
>  /**
> - * kvm_vcpu_pmu_is_partitioned() - Determine if given VCPU has a partiti=
oned PMU
> - * @vcpu: Pointer to kvm_vcpu struct
> + * kvm_pmu_is_partitioned() - Determine if given VCPU has a partitioned =
PMU
> + * @kvm: Pointer to kvm_vcpu struct
>   *
>   * Determine if given VCPU has a partitioned PMU by extracting that
>   * field and passing it to :c:func:`kvm_pmu_is_partitioned`

This isn't a bug, but the function name and parameter in the kernel-doc
block don't match the actual function signature below:

> @@ -55,7 +55,36 @@ bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
>  bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)

[ ... ]

> +/**
> + * kvm_pmu_partition_enable() - Enable/disable partition flag
> + * @kvm: Pointer to vcpu
> + * @enable: Whether to enable or disable
> + *
> + * If we want to enable the partition, the guest is free to grab
> + * hardware by accessing PMU registers. Otherwise, the host maintains
> + * control.
> + */
> +void kvm_pmu_partition_enable(struct kvm *kvm, bool enable)

This isn't a bug, but the comment describes @kvm as a pointer to a vcpu,
while the function takes a pointer to struct kvm.

> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
> index f1c66ce678840..add5e7da830b2 100644
> --- a/arch/arm64/kvm/pmu.c
> +++ b/arch/arm64/kvm/pmu.c
[ ... ]
> @@ -759,6 +759,19 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, s=
truct kvm_device_attr *attr)
> =20
>  		return kvm_arm_pmu_v3_set_nr_counters(vcpu, n);
>  	}
> +	case KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION: {
> +		unsigned int __user *uaddr =3D (unsigned int __user *)(long)attr->addr;
> +		bool enable;
> +
> +		if (get_user(enable, uaddr))
> +			return -EFAULT;

Is it possible for the get_user() call to truncate the value being read?

Since uaddr is cast to unsigned int __user *, the inline assembly inside
get_user() will load a 32-bit value from userspace. However, the output
variable enable is a 1-byte bool. If userspace passes a value like 256
(0x100), the lowest byte is 0, which could incorrectly result in false.

Additionally, should we explicitly check that the input value is exactly
0 or 1? Accepting any arbitrary value here burns the upper 31 bits and
prevents repurposing them for future flags without breaking backward
compatibility.

> +
> +		if (!has_kvm_pmu_partition_support())
> +			return -EPERM;
> +
> +		kvm_pmu_partition_enable(kvm, enable);
> +		return 0;
> +	}

Could this sequence result in concurrent state modification?

In a multi-vCPU VM, if userspace initializes and starts running vCPU 0, it
could subsequently invoke this ioctl on an uninitialized vCPU 1. Since
kvm_arm_pmu_v3_set_attr() only checks if the individual vCPU is initialized:

	if (vcpu->arch.pmu.created)
		return -EBUSY;

and KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION modifies VM-wide state without
calling kvm_vm_has_ran_once(kvm), the PMU partition mode could be altered
while vCPU 0 is already running.

[ ... ]

> @@ -798,6 +811,7 @@ int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu, st=
ruct kvm_device_attr *attr)
>  	case KVM_ARM_VCPU_PMU_V3_FILTER:
>  	case KVM_ARM_VCPU_PMU_V3_SET_PMU:
>  	case KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS:
> +	case KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION:
>  		if (kvm_vcpu_has_pmu(vcpu))
>  			return 0;
>  	}

Will this advertise the partition capability even when the host hardware
does not support it?

The has_attr handler returns 0 based solely on kvm_vcpu_has_pmu(vcpu), but
the set_attr handler requires has_kvm_pmu_partition_support() to be true. If
userspace relies on KVM_HAS_DEVICE_ATTR to probe capabilities, it might
incorrectly attempt to configure the feature and receive an unexpected -EPE=
RM.
Should this return -ENXIO if has_kvm_pmu_partition_support() is false?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D17
