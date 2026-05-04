Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6A37B00C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932160; cv=none; b=T5n+GYQDmu3VcDWMvuZJxUmtILLAQbjhH/9jSQQdJ++yK/s4WYaqh1ftC5NyqlbNItZDbJcHFSczvLBAYVWFOImw67Whrx+i5U+ZVL/YR3jsnVlnpj9bJdDKuawAzgQ5Y8oqWL7jykomjRblfZbAQ6mNEGDYMQ26NhnLGQnDaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932160; c=relaxed/simple;
	bh=IakCmuN5qd6yEc9hk9EtmDfONQEqproLQtlY4ySj2gM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SEBdwn0qxeOXCYmmzl+wzgalkrf7Sg4mHaXwcnyrMZ242qgHc6R7GjumMhfLg8Sm2CE9oCbPRJnT0tbqVLjSte68zj1TPcqUU3E7clqvGfJBmls5dpBAa3XS3dlHaWVTd42GjAvSGk5Hbvf1Q/cE9p5mRQR28o5jABtLPU2Hddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUkrSmvH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUkrSmvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B185AC2BCB9;
	Mon,  4 May 2026 22:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777932160;
	bh=IakCmuN5qd6yEc9hk9EtmDfONQEqproLQtlY4ySj2gM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rUkrSmvHKOUPmsdH1RXDHmpLtAWYmmY4MAnv4DpBSvYcNwOLj6wTNr2Pej1hgMIUj
	 32m2+SNjX9FuK+/o8ySFhGybXfr06YC+pu7eXqCjyWBe6DwhNb0ZcYC7qs81Gfduts
	 eRMKJaOhz4Ijmj929ysOH2AVHccXC5VJbtuuwYSlZqqSqcYi501s4J8nzwtjdoNmfX
	 pMQGg/9IY9QTgZ6IBGFsBPSJzIQatKGKE2/5jQ2dZA2xBNrfMhQP1t8kMw70f2Dg7z
	 jPS+Su9utqoyPZiqgjAX0oNrvA6+p8l1Kn1bqej1++2ERiqq1HxULADXxZg3WaKUvw
	 /hvd/ONTT2g+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/20] KVM: arm64: Set up MDCR_EL2 to handle a
 Partitioned PMU
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-10-coltonlewis@google.com>
References: <20260504211813.1804997-10-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:02:39 +0000
Message-Id: <20260504220239.B185AC2BCB9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Unconditionally setting MDCR_EL2.HPME forces host PMU counters on,=
 breaking the host's ability to globally disable them.
- [High] Setting MDCR_EL2.HPMD and MDCR_EL2.HCCD unconditionally disables h=
ost profiling at EL2, blinding `perf` to the VHE host kernel.
- [High] kvm_pmu_hpmn() fails to fall back to max_guest_counters when HPMN0=
 is unsupported, breaking host partitioning.
- [High] Unsafe per-CPU data access with preemption enabled causes TOCTOU r=
aces and UNPREDICTABLE state on heterogeneous CPUs.
- [High] Desynchronized vcpu_on_unsupported_cpu() checks grant the guest un=
trapped access to the physical PMU of unsupported CPUs.
--

commit 2fa21e7add3769fb81de901ba24477b380914693
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: Set up MDCR_EL2 to handle a Partitioned PMU

This commit configures MDCR_EL2 to support PMU partitioning by calculating =
the
appropriate HPMN value and configuring coarse and fine-grained traps. It al=
so
enables host PMU counting and sets filtering bits for the PMU hardware.

> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 3ad6b7c6e4ba7..0ab89c91e19cb 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -36,20 +36,43 @@ static int cpu_has_spe(u64 dfr0)
>   */
>  static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>  {
> +	int hpmn =3D kvm_pmu_hpmn(vcpu);
> +
>  	preempt_disable();

Does calling kvm_pmu_hpmn() before preempt_disable() cause a Time-of-Check =
to
Time-of-Use race here?

kvm_pmu_hpmn() uses host_data_ptr(nr_event_counters), which accesses
per-CPU data. If the thread migrates, could KVM program MDCR_EL2.HPMN
using the counter value from the wrong physical CPU?

[ ... ]

> -	vcpu->arch.mdcr_el2 =3D FIELD_PREP(MDCR_EL2_HPMN,
> -					 *host_data_ptr(nr_event_counters));
> +	vcpu->arch.mdcr_el2 =3D FIELD_PREP(MDCR_EL2_HPMN, hpmn);
>  	vcpu->arch.mdcr_el2 |=3D (MDCR_EL2_TPM |
>  				MDCR_EL2_TPMS |
>  				MDCR_EL2_TTRF |
>  				MDCR_EL2_TPMCR |
>  				MDCR_EL2_TDRA |
> -				MDCR_EL2_TDOSA);
> +				MDCR_EL2_TDOSA |
> +				MDCR_EL2_HPME);

Does unconditionally setting MDCR_EL2.HPME force the host PMU counters on?

When PMU partitioning is active, MDCR_EL2.HPME becomes the global enable for
the host partition. If KVM forces this to 1 while the vCPU is loaded, does
the host PMU driver lose the ability to globally stop its counters, for
example during counter reprogramming or overflow IRQ handling?

> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
> +		/*
> +		 * Filtering these should be redundant because we trap
> +		 * all the TYPER and FILTR registers anyway and ensure
> +		 * they filter EL2, but set the bits if they are here.
> +		 */
> +		if (is_pmuv3p1(read_pmuver()))
> +			vcpu->arch.mdcr_el2 |=3D MDCR_EL2_HPMD;
> +		if (is_pmuv3p5(read_pmuver()))
> +			vcpu->arch.mdcr_el2 |=3D MDCR_EL2_HCCD;

The commit message states these bits are set to ensure nothing in the guest
counts at EL2. Do these bits actually apply to the host partition rather th=
an
the guest?

According to the ARM Architecture Reference Manual, when partitioned, the
guest counters are already prohibited from counting at EL2, while HPMD and
HCCD apply to the host partition counters. Does setting these bits permanen=
tly
disable the host's own counters from profiling at EL2?

> +		/*
> +		 * Take out the coarse grain traps if we are using
> +		 * fine grain traps.
> +		 */
> +		if (kvm_vcpu_pmu_use_fgt(vcpu))
> +			vcpu->arch.mdcr_el2 &=3D ~(MDCR_EL2_TPM | MDCR_EL2_TPMCR);
> +
> +	}

Can this grant the guest untrapped access to the physical PMU on unsupported
CPUs?

If a vCPU is on an unsupported CPU, kvm_pmu_hpmn() returns the host's maxim=
um
counters, effectively disabling the partition. However, kvm_vcpu_pmu_use_fg=
t()
does not check vcpu_on_unsupported_cpu(). Will it return true and clear the
trap bits here, allowing direct hardware access to the PMU?

> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 2148bc46079c4..63ac72910e4b5 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c

[ ... ]

> +u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
> +{
> +	u8 nr_guest_cntr =3D vcpu->kvm->arch.nr_pmu_counters;
> +
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)
> +	    && !vcpu_on_unsupported_cpu(vcpu)
> +	    && (cpus_have_final_cap(ARM64_HAS_HPMN0) || nr_guest_cntr > 0))
> +		return nr_guest_cntr;
> +
> +	return *host_data_ptr(nr_event_counters);
> +}

The commit message states this will fall back to max_guest_counters if need=
ed
when partitioned but unable to set the implied HPMN value. Does the
implementation miss this fallback?

If the conditions fail (for instance, nr_guest_cntr is 0 on hardware without
HPMN0), it returns the total number of host counters instead of
max_guest_counters. Will setting HPMN to the maximum counters destroy the h=
ost
partition and cause the host's reserved counters to silently stop?

> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
> index ee2f0f7e61bcf..8c10ad05661bc 100644
> --- a/arch/arm64/kvm/pmu.c
> +++ b/arch/arm64/kvm/pmu.c
> @@ -542,6 +542,13 @@ u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
>  	if (cpus_have_final_cap(ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS))
>  		return 1;
> =20
> +	/*
> +	 * If partitioned then we are limited by the max counters in
> +	 * the guest partition.
> +	 */
> +	if (kvm_pmu_is_partitioned(arm_pmu))
> +		return arm_pmu->max_guest_counters;
> +

Can this be called with preemption enabled?

kvm_arm_pmu_get_max_counters() can be called from userspace ioctls. Since
kvm_pmu_is_partitioned() evaluates host_data_ptr(), does this create a race
condition with per-CPU data access similar to the one in
kvm_arm_setup_mdcr_el2()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D9
