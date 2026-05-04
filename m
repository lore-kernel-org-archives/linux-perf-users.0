Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70437BE8C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932590; cv=none; b=Ni9umH5d8QcDlBMpQVgBgnpN1bMYO+lt1u0FAdHuX0T48r7G41OICpUPAaRTP1K554UuDKvo0T9nxtA1TR7jC2xg0dFeVHWgOQYYWank9xJua5uGOSxfNZrzi0IF3/hjZaAHYLSH6zcvQwZeJ0oCLfBAoyHFD51XUf1mODeYCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932590; c=relaxed/simple;
	bh=yHx3iMe42mKhKT6QSQthCW5ZmeFF5OGHsbaqp9BZBW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SUI0JqoyldESy27MJaOjzh19icDEuz3IOeZT/phrOTZbb9qhYPQ6FWf+33Zoq8Q6LcgSYQ9s/W+MLtMsBQleP2cIoPKyn4lAqrPe+I5WkHM8t4cdF6fpTPjvGXksdrj1uNUIelrYUVbZjBlZgzeRh5zJ3/Wct0RgJo8OJV80GTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJWD8lBK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJWD8lBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD74C2BCB8;
	Mon,  4 May 2026 22:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777932590;
	bh=yHx3iMe42mKhKT6QSQthCW5ZmeFF5OGHsbaqp9BZBW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tJWD8lBKPfOY0t924CKsYASNaLDEjKYo/lG9W7N3jpJs5MC43uyEomchQBH5KZ8py
	 TzwhxdF56fZB+f4fDYBMS1R471l50DnWTKC4rwbSrx3BQuisz/kwlQBuU8+dpmdEUm
	 WblQvTNpmzwXFF/3Kcl7Vfy1Q9VnWoYHZkIRW27nzv78bT97Mz0CafSHaL7VMjN75o
	 PSr145RA0oz/+TEvieFBpB1ftWY59YTuptxWonwCibPpYr8uKJvc/L8SyUsZNllnig
	 YYHX7ys2+yN7aACjblPYXfuXpAudl65vSnVJViqloxbjbF6Ot3CNifQifJ5Y0a09rU
	 YiCs7r/u1Uz8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/20] KVM: arm64: Set up FGT for Partitioned PMU
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-8-coltonlewis@google.com>
References: <20260504211813.1804997-8-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:09:49 +0000
Message-Id: <20260504220950.4DD74C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Untrapping PMSELR_EL0 causes KVM's trap handlers to use a stal=
e selector index, breaking PMU emulation and event filtering.
- [High] Untrapping PMCR_EL0 reads exposes the physical counter limit (N) t=
o the guest, leading to UNDEF crashes during PMU probing.
- [High] `kvm_pmu_is_partitioned()` uses `host_data_ptr(nr_event_counters)`=
 to read the current CPU's capacity, causing preemption safety and correctn=
ess issues.
- [High] Conflicting definitions and missing forward declarations for `kvm_=
pmu_is_partitioned` break the build when KVM is disabled.
- [Low] Typo in commit message system register names.
--

commit c59f16e72b7efa37d6a241d40b8efb2151b0a1ca
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: Set up FGT for Partitioned PMU

This commit sets up fine grain traps (FGT) to avoid trapping common PMU
register accesses by the guest. It untraps several registers while keeping
others trapped for overflow tracking and event filtering.

> Untrapped:
> * PMCR_EL0
> * PMUSERENR_EL0
> * PMSELR_EL0

If PMCR_EL0 reads are untrapped, won't the guest see the host's physical
number of counters (N) instead of the restricted limit? If the guest OS
PMU driver discovers the physical N and attempts to configure counters
greater than or equal to HPMN, won't KVM's emulation inject an UNDEFINED
exception and crash the guest?

Additionally, since PMSELR_EL0 is untrapped, the guest can modify the
hardware register directly without KVM's knowledge. When KVM handles
traps for aliases like PMXEVTYPER_EL0, will it read a stale selector
index from the memory backing of PMSELR_EL0? Could this allow a guest
to bypass KVM's event filtering by desynchronizing the hardware selector
from KVM's memory backing?

[ ... ]

> PMICNTR and PMIFILTR remain trapped because KVM is not handling them
> yet.
>=20
> PMEVTYPERn remains trapped so KVM can limit which events guests can
> count, such as disallowing counting at EL2. PMCCFILTR and PMCIFILTR
> are special cases of the same.

This isn't a bug, but are PMIFILTR and PMCIFILTR typos in the commit
message? Should these be PMICFILTR and PMCCFILTR respectively?

> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_=
pmuv3.h
> index 154503f054886..42d62aa48d0a6 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -231,6 +231,10 @@ static inline bool kvm_set_pmuserenr(u64 val)
>  }
> =20
>  static inline void kvm_vcpu_pmu_resync_el0(void) {}
> +static inline bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
> +{
> +	return false;
> +}

Since struct arm_pmu is not forward-declared before its use here, could
this cause build warnings or errors in certain configurations?

[ ... ]

> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 74e40e4915416..2148bc46079c4 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c

[ ... ]

> +/**
> + * kvm_pmu_is_partitioned() - Determine if given PMU is partitioned
> + * @pmu: Pointer to arm_pmu struct
> + *
> + * Determine if given PMU is partitioned by looking at hpmn field. The
> + * PMU is partitioned if this field is less than the number of
> + * counters in the system.
> + *
> + * Return: True if the PMU is partitioned, false otherwise
> + */
> +bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
> +{
> +	if (!pmu)
> +		return false;
> +
> +	return pmu->max_guest_counters >=3D 0 &&
> +		pmu->max_guest_counters <=3D *host_data_ptr(nr_event_counters);
> +}

Because host_data_ptr() uses this_cpu_ptr_hyp_sym() and this_cpu_ptr(),
will this trigger a preemption warning if called from a preemptible
context?

Also, on big.LITTLE systems, does this compare the specific PMU's limit
against the currently executing CPU's capacity rather than the correct
capacity for that PMU?

[ ... ]

> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 95f404cdcb2df..c3987e0c01775 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h

[ ... ]

> @@ -228,6 +253,11 @@ static inline bool kvm_pmu_counter_is_hyp(struct kvm=
_vcpu *vcpu, unsigned int id
> =20
>  static inline void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu) {}
> =20
> +static inline bool kvm_pmu_is_partitioned(void *pmu)
> +{
> +	return false;
> +}

Does this fallback definition using void *pmu conflict with the one added
to arch/arm/include/asm/arm_pmuv3.h that uses struct arm_pmu *pmu? If KVM
is disabled and a driver includes both headers, could this result in a
fatal conflicting types compiler error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D7
