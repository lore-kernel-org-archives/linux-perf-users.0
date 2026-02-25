Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AFF3E9590
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042029; cv=none; b=t1f150Q7Haxxq+DbOwQuRU4W+kTUa2KrlRcjZPgO7+TmC7dd1fhnaP+WEi5FcYU5DqADY6hRrPaC7R9Do85dddx/rB3FXRH3uDUnC+tvqWdhLsmQCkQwbp4NFYtoCHfWy00bgUkh1JFP155AS5LerZ9JAltkd62ntDHh/tTrjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042029; c=relaxed/simple;
	bh=yVgSWV9/7VGgEOfghkSk9PPxrIiAcQf7tWguRo0Z+L8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=bQYISeMZ5bEe9E1Nc/Q6nKt4Oq4JDe/EJ8nW7bIoIYy1uT47zcppk+A42O+nwYYAEb/dah0amA/c5afb0AIRCNhwUqGVEIsLRjGF5/Is+VYnC4eBNbZsCyfA8Cb5jcrP0nnV5feOXyizJdHf1nKJ4zhyRNw3CQkhHVsaINkDbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/ppfLTg; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/ppfLTg"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-679c52164f5so366247eaf.2
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 09:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772042026; x=1772646826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ew2bXmM44zST5RAlc0JJSXwQ90l2Cyu31bthvtKTGVI=;
        b=l/ppfLTglK/uP9soCSncM3aE4D7fCx0cXrK30GlaBHan1m0G5Nwi57EqID7b39Av2j
         ApkcURftrE8Er/spJQsGmt8jKRgPwL1cjGgJ/7X1ayikkl99i+PINDvq9bE8Q+e77ZKI
         jm7NcK5Z2j1da76gDmh6fxJttft/IHsByq6u5g/HgD9OIeMw8DNGu9rD1hUJ+3/NsLze
         5HuyVSAJEJvZYhceEsE7d8PrPhs4MBL+AAxIw7TzVsr3D2HQ32lKXFhEGJsv1mYGKsPD
         ct2C4kjx+Xdeup69xw108iaJX03cdiVFm5JuJAx+Vb6oE/IyKoOo7uDkYV3+vYVkVsd1
         7Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772042026; x=1772646826;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ew2bXmM44zST5RAlc0JJSXwQ90l2Cyu31bthvtKTGVI=;
        b=SxlArQd2kZxe6h5aiVswn8GtaaLZYj5DK/W3e722VPqcTkHaIhVXpm7tSdc0+YMszR
         zLf73DeFYvqJYJAGeQ2nb1k9S/ZX6uFDPA26U89Ih8fUYtFnSh9Psho21jIzwtpupgVZ
         FYSLBtxyekdEM/IlzibknonIqHLgnc13bjSAK8VU0yYOY0cLW1F/4Mpt7oU+ak3AbK7b
         1pb5SCckV2S41kS/ghD6QjkOuGa+6uPFW1H0kgFTDOl/K0ZdIas+CDuorNZV0jB7lOsQ
         3WoFBq5Gnozc3x3Nqiq9akcwrgOL4p0On6cIn5LTyLy4ee4mjkm9tmv9+gO4tlHsVJ4m
         QXog==
X-Forwarded-Encrypted: i=1; AJvYcCUkb7D0+/QAiJcohDQjK5i65wBOm9yvTz6sEmi38+kp4+juELkKtR8qyntHARmGX/Io3KptGfYRIAn6jx8rApJN@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtKcIlZLtdUndwgZ14CqDa00xCiNAWsjsacLcFo4SBeqOh7jm
	XYy8hUwcAy1YXviRPadc4okPZ589P2XzAxSftl+yAcnAsNodAaMBLLwyntW3Omo1+no7WgtulBy
	h18IpLwmTxh94lon6lGq84annaA==
X-Received: from japv16.prod.google.com ([2002:a02:cbb0:0:b0:5ca:f895:d034])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:162b:b0:662:ede7:fdaa with SMTP id 006d021491bc7-679c4728b8emr7327085eaf.74.1772042025601;
 Wed, 25 Feb 2026 09:53:45 -0800 (PST)
Date: Wed, 25 Feb 2026 17:53:44 +0000
In-Reply-To: <20260209221414.2169465-7-coltonlewis@google.com> (message from
 Colton Lewis on Mon,  9 Feb 2026 22:14:01 +0000)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntseaoogk7.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v6 06/19] perf: arm_pmuv3: Keep out of guest counter partition
From: Colton Lewis <coltonlewis@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Colton Lewis <coltonlewis@google.com> writes:

> If the PMU is partitioned, keep the driver out of the guest counter
> partition and only use the host counter partition.

> Define some functions that determine whether the PMU is partitioned
> and construct mutually exclusive bitmaps for testing which partition a
> particular counter is in. Note that despite their separate position in
> the bitmap, the cycle and instruction counters are always in the guest
> partition.

> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm/include/asm/arm_pmuv3.h | 18 +++++++
>   arch/arm64/kvm/pmu-direct.c      | 86 ++++++++++++++++++++++++++++++++
>   drivers/perf/arm_pmuv3.c         | 40 +++++++++++++--
>   include/kvm/arm_pmu.h            | 24 +++++++++
>   4 files changed, 164 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/include/asm/arm_pmuv3.h  
> b/arch/arm/include/asm/arm_pmuv3.h
> index 154503f054886..bed4dfa755681 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -231,6 +231,24 @@ static inline bool kvm_set_pmuserenr(u64 val)
>   }

>   static inline void kvm_vcpu_pmu_resync_el0(void) {}
> +static inline void kvm_pmu_host_counters_enable(void) {}
> +static inline void kvm_pmu_host_counters_disable(void) {}
> +
> +static inline bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
> +{
> +	return false;
> +}
> +
> +static inline u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
> +{
> +	return ~0;
> +}
> +
> +static inline u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
> +{
> +	return ~0;
> +}
> +

>   /* PMU Version in DFR Register */
>   #define ARMV8_PMU_DFR_VER_NI        0
> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 74e40e4915416..05ac38ec3ea20 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -5,6 +5,8 @@
>    */

>   #include <linux/kvm_host.h>
> +#include <linux/perf/arm_pmu.h>
> +#include <linux/perf/arm_pmuv3.h>

>   #include <asm/arm_pmuv3.h>

> @@ -20,3 +22,87 @@ bool has_host_pmu_partition_support(void)
>   	return has_vhe() &&
>   		system_supports_pmuv3();
>   }
> +
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
> +	return pmu->max_guest_counters >= 0 &&
> +		pmu->max_guest_counters <= *host_data_ptr(nr_event_counters);
> +}
> +
> +/**
> + * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved  
> counters
> + * @pmu: Pointer to arm_pmu struct
> + *
> + * Compute the bitmask that selects the host-reserved counters in the
> + * {PMCNTEN,PMINTEN,PMOVS}{SET,CLR} registers. These are the counters
> + * in HPMN..N
> + *
> + * Return: Bitmask
> + */
> +u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
> +{
> +	u8 nr_counters = *host_data_ptr(nr_event_counters);
> +
> +	if (!kvm_pmu_is_partitioned(pmu))
> +		return ARMV8_PMU_CNT_MASK_ALL;
> +
> +	return GENMASK(nr_counters - 1, pmu->max_guest_counters);
> +}
> +
> +/**
> + * kvm_pmu_guest_counter_mask() - Compute bitmask of guest-reserved  
> counters
> + * @pmu: Pointer to arm_pmu struct
> + *
> + * Compute the bitmask that selects the guest-reserved counters in the
> + * {PMCNTEN,PMINTEN,PMOVS}{SET,CLR} registers. These are the counters
> + * in 0..HPMN and the cycle and instruction counters.
> + *
> + * Return: Bitmask
> + */
> +u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
> +{
> +	return ARMV8_PMU_CNT_MASK_C & GENMASK(pmu->max_guest_counters - 1, 0);
> +}
> +

I introduced a mistake here before sending. & should be | at
least. Letting the list know in case someone wants to try running my
series.

u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
{
	if (kvm_pmu_is_partitioned(pmu))
		return ARMV8_PMU_CNT_MASK_C | GENMASK(pmu->max_guest_counters - 1, 0);

	return 0;
}

> +/**
> + * kvm_pmu_host_counters_enable() - Enable host-reserved counters
> + *
> + * When partitioned the enable bit for host-reserved counters is
> + * MDCR_EL2.HPME instead of the typical PMCR_EL0.E, which now
> + * exclusively controls the guest-reserved counters. Enable that bit.
> + */
> +void kvm_pmu_host_counters_enable(void)
> +{
> +	u64 mdcr = read_sysreg(mdcr_el2);
> +
> +	mdcr |= MDCR_EL2_HPME;
> +	write_sysreg(mdcr, mdcr_el2);
> +}
> +
> +/**
> + * kvm_pmu_host_counters_disable() - Disable host-reserved counters
> + *
> + * When partitioned the disable bit for host-reserved counters is
> + * MDCR_EL2.HPME instead of the typical PMCR_EL0.E, which now
> + * exclusively controls the guest-reserved counters. Disable that bit.
> + */
> +void kvm_pmu_host_counters_disable(void)
> +{
> +	u64 mdcr = read_sysreg(mdcr_el2);
> +
> +	mdcr &= ~MDCR_EL2_HPME;
> +	write_sysreg(mdcr, mdcr_el2);
> +}
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index b37908fad3249..6395b6deb78c2 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -871,6 +871,9 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
>   		brbe_enable(cpu_pmu);

>   	/* Enable all counters */
> +	if (kvm_pmu_is_partitioned(cpu_pmu))
> +		kvm_pmu_host_counters_enable();
> +
>   	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
>   }

> @@ -882,6 +885,9 @@ static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
>   		brbe_disable();

>   	/* Disable all counters */
> +	if (kvm_pmu_is_partitioned(cpu_pmu))
> +		kvm_pmu_host_counters_disable();
> +
>   	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
>   }

> @@ -1028,6 +1034,12 @@ static bool armv8pmu_can_use_pmccntr(struct  
> pmu_hw_events *cpuc,
>   	if (cpu_pmu->has_smt)
>   		return false;

> +	/*
> +	 * If partitioned at all, pmccntr belongs to the guest.
> +	 */
> +	if (kvm_pmu_is_partitioned(cpu_pmu))
> +		return false;
> +
>   	return true;
>   }

> @@ -1054,6 +1066,7 @@ static int armv8pmu_get_event_idx(struct  
> pmu_hw_events *cpuc,
>   	 * may not know how to handle it.
>   	 */
>   	if ((evtype == ARMV8_PMUV3_PERFCTR_INST_RETIRED) &&
> +	    !kvm_pmu_is_partitioned(cpu_pmu) &&
>   	    !armv8pmu_event_get_threshold(&event->attr) &&
>   	    test_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask) &&
>   	    !armv8pmu_event_want_user_access(event)) {
> @@ -1065,7 +1078,7 @@ static int armv8pmu_get_event_idx(struct  
> pmu_hw_events *cpuc,
>   	 * Otherwise use events counters
>   	 */
>   	if (armv8pmu_event_is_chained(event))
> -		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
> +		return armv8pmu_get_chain_idx(cpuc, cpu_pmu);
>   	else
>   		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
>   }
> @@ -1177,6 +1190,14 @@ static int armv8pmu_set_event_filter(struct  
> hw_perf_event *event,
>   	return 0;
>   }

> +static void armv8pmu_reset_host_counters(struct arm_pmu *cpu_pmu)
> +{
> +	int idx;
> +
> +	for_each_set_bit(idx, cpu_pmu->cntr_mask,  
> ARMV8_PMU_MAX_GENERAL_COUNTERS)
> +		armv8pmu_write_evcntr(idx, 0);
> +}
> +
>   static void armv8pmu_reset(void *info)
>   {
>   	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
> @@ -1184,6 +1205,9 @@ static void armv8pmu_reset(void *info)

>   	bitmap_to_arr64(&mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);

> +	if (kvm_pmu_is_partitioned(cpu_pmu))
> +		mask &= kvm_pmu_host_counter_mask(cpu_pmu);
> +
>   	/* The counter and interrupt enable registers are unknown at reset. */
>   	armv8pmu_disable_counter(mask);
>   	armv8pmu_disable_intens(mask);
> @@ -1196,11 +1220,19 @@ static void armv8pmu_reset(void *info)
>   		brbe_invalidate();
>   	}

> +	pmcr = ARMV8_PMU_PMCR_LC;
> +
>   	/*
> -	 * Initialize & Reset PMNC. Request overflow interrupt for
> -	 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
> +	 * Initialize & Reset PMNC. Request overflow interrupt for 64
> +	 * bit cycle counter but cheat in armv8pmu_write_counter().
> +	 *
> +	 * When partitioned, there is no single bit to reset only the
> +	 * host counters. so reset them individually.
>   	 */
> -	pmcr = ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C | ARMV8_PMU_PMCR_LC;
> +	if (kvm_pmu_is_partitioned(cpu_pmu))
> +		armv8pmu_reset_host_counters(cpu_pmu);
> +	else
> +		pmcr = ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C;

>   	/* Enable long event counter support where available */
>   	if (armv8pmu_has_long_event(cpu_pmu))
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index e7172db1e897d..accfcb79723c8 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -92,6 +92,12 @@ void kvm_vcpu_pmu_resync_el0(void);
>   #define kvm_vcpu_has_pmu(vcpu)					\
>   	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))

> +bool kvm_pmu_is_partitioned(struct arm_pmu *pmu);
> +u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu);
> +u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
> +void kvm_pmu_host_counters_enable(void);
> +void kvm_pmu_host_counters_disable(void);
> +
>   /*
>    * Updates the vcpu's view of the pmu events for this cpu.
>    * Must be called before every vcpu run after disabling interrupts, to  
> ensure
> @@ -228,6 +234,24 @@ static inline bool kvm_pmu_counter_is_hyp(struct  
> kvm_vcpu *vcpu, unsigned int id

>   static inline void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu) {}

> +static inline bool kvm_pmu_is_partitioned(void *pmu)
> +{
> +	return false;
> +}
> +
> +static inline u64 kvm_pmu_host_counter_mask(void *pmu)
> +{
> +	return ~0;
> +}
> +
> +static inline u64 kvm_pmu_guest_counter_mask(void *pmu)
> +{
> +	return ~0;
> +}
> +
> +static inline void kvm_pmu_host_counters_enable(void) {}
> +static inline void kvm_pmu_host_counters_disable(void) {}
> +
>   #endif

>   #endif
> --
> 2.53.0.rc2.204.g2597b5adb4-goog
