Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC354B8DF3
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688802; cv=none; b=HaFKwVGq3N81gnoa+5LSCC+krflz150sfcMbpvgORZhoAyn3n9yyIm55dMik074ftslMf2zAjc5z87RLhbd0eyT+pZacyg2BAsCbJ1m9geX3HDP9PkJlZRgVYnyUavAbxWjCnYvLM27SSIiMuFXDTrfSREg6VcdgsDbCbCIV2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688802; c=relaxed/simple;
	bh=DF/bygSl3cDDycJ2Ugws7VZCB4Iv+wUBlutvu8Rlldo=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Qw/hLJdSA5iEUWnBq52BauHfxQtP+oOxE1KasH2VxRnoJvRb3msNwxIo3HC8IlIV6p2RTr47Dmx4uvG1JeocI7bpuDXoWFJUbEaoGJ6IfAbEXmSBMpYWQGKRUfl011KfYe6j6jIzw3qle54EEyNzQuJykhwwIIodET/6k0yuS4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kb4MwRlR; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kb4MwRlR"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7dce1e67fccso9015538a34.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778688800; x=1779293600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mkKg2AH9OzqTbzmtz3KJKgeEvCZA8Yl8G/ANzbR9O64=;
        b=kb4MwRlROc/OMo77duzI4vWqz63ibQ371lvB1hSk2ApfAgRAi9/3BOCRgheXCll4Wv
         yNsh+1I41jAIB1/B+Ik4ngeDN5d2m4IIHg0vMCG6IZzy7wJ7BrX9VMNRB9FSLvKC9N5A
         +NEEcLkWIH/67Za6/n5c+sGWvXI1Nmw245dtW8ZedA59fO4J5UFGydudWgh0Xg3C4Mvq
         zjCfnSwRi3YFygr7v86v7FR9XhHevR2ZIvaFxxDnzoDNVKo3PD4/7UMy9MF99Bt2LeFj
         t9246tuWSIi8GBF8yirSKHa2LlxoOYNUvRcK37WZepgIVgoxdszQ3fI3sPY1tm/WbJOc
         bp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688800; x=1779293600;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkKg2AH9OzqTbzmtz3KJKgeEvCZA8Yl8G/ANzbR9O64=;
        b=JfV/CvHF0+w76ijG0slRhMP/gBqD8n6TEiBF3oC96jGMhzLFnpBwT7xpNw1nLLrHdS
         sR+Vb2+rEdRDtcIm6PdHEM12i2h2flvZPB3BAS9kFg9+hFUjjX/XumcFf9PZeJ/wzEwJ
         IW/MrJ1HBg9Jpq0Eo8UJfxxtQceGkswwIo874to6MDYPM6ZNChMKW1OesI4kjyAwTUxB
         83cIYPyZLCNbUCyL0o8okwx2Er5ZrdL6x79VTLd075J7yYkmVoWZZTmOrTgNn5Vfy0zQ
         /h9bcGGyrtZ4l8aLimMDoPMMq+tFQ9BJNDSrVe271CvA+aCEb3cb3mCTWD565c0y/70B
         H0pw==
X-Forwarded-Encrypted: i=1; AFNElJ99se3AqC3HFICLMOrJ4VLwKau1PX0jYVu8rEqjTMRF1Pggtc+veKfAFxkqULRS2S+AZYQlUVHaYcfEsixOLvNa@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqOeKKHB/UMyTqwXjM1i/+KVuZ9f2fAhYaJ7VIfReSsAm6mFC
	sQDqFiera+Oa7MXU/1u9UwnWtLo+++KRlboUNvgEkXlaLmiGQk+xVx4Qc6k8Y3eyZ2DMVNDVeSW
	BtqkAaAo3YwGsOek/bT0/tYNO1Q==
X-Received: from ioro2.prod.google.com ([2002:a05:6602:2982:b0:96b:5f81:a45f])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:1525:b0:696:17a7:498c with SMTP id 006d021491bc7-69b78dd26b8mr2142761eaf.30.1778688799667;
 Wed, 13 May 2026 09:13:19 -0700 (PDT)
Date: Wed, 13 May 2026 16:13:18 +0000
In-Reply-To: <485b8846-13d7-4d31-abf1-686d2516f772@linaro.org> (message from
 James Clark on Mon, 11 May 2026 15:51:39 +0100)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt5x4rcmox.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v7 06/20] perf: arm_pmuv3: Add method to partition the PMU
From: Colton Lewis <coltonlewis@google.com>
To: James Clark <james.clark@linaro.org>
Cc: alexandru.elisei@arm.com, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

James Clark <james.clark@linaro.org> writes:

> On 04/05/2026 10:17 pm, Colton Lewis wrote:
>> For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
>> counters into two ranges where counters 0..HPMN-1 are accessible by
>> EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
>> EL2.

>> Create a module parameter reserved_host_counters to reserve a number
>> of counters for the host. Counters not reserved for the host may be
>> used by a guest VM when the PMU is partitioned.

>> Add the function armv8pmu_partition() to check the validity of the
>> reservation and record a partition has happened and the maximum
>> allowable value for HPMN.

>> Due to the difficulty this feature would create for the driver running
>> in nVHE mode, partitioning is only allowed in VHE mode. In order to
>> support a partitioning on nVHE we'd need to explicitly disable guest
>> counters on every exit and reset HPMN to place all counters in the
>> first range.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>    arch/arm/include/asm/arm_pmuv3.h   |  4 ++
>>    arch/arm64/include/asm/arm_pmuv3.h |  5 ++
>>    arch/arm64/kvm/Makefile            |  2 +-
>>    arch/arm64/kvm/pmu-direct.c        | 22 +++++++++
>>    drivers/perf/arm_pmuv3.c           | 77 ++++++++++++++++++++++++++++--
>>    include/kvm/arm_pmu.h              |  8 ++++
>>    include/linux/perf/arm_pmu.h       |  2 +
>>    7 files changed, 115 insertions(+), 5 deletions(-)
>>    create mode 100644 arch/arm64/kvm/pmu-direct.c

>> diff --git a/arch/arm/include/asm/arm_pmuv3.h  
>> b/arch/arm/include/asm/arm_pmuv3.h
>> index 2ec0e5e83fc98..154503f054886 100644
>> --- a/arch/arm/include/asm/arm_pmuv3.h
>> +++ b/arch/arm/include/asm/arm_pmuv3.h
>> @@ -221,6 +221,10 @@ static inline bool kvm_pmu_counter_deferred(struct  
>> perf_event_attr *attr)
>>    	return false;
>>    }

>> +static inline bool has_host_pmu_partition_support(void)
>> +{
>> +	return false;
>> +}
>>    static inline bool kvm_set_pmuserenr(u64 val)
>>    {
>>    	return false;
>> diff --git a/arch/arm64/include/asm/arm_pmuv3.h  
>> b/arch/arm64/include/asm/arm_pmuv3.h
>> index cf2b2212e00a2..27c4d6d47da31 100644
>> --- a/arch/arm64/include/asm/arm_pmuv3.h
>> +++ b/arch/arm64/include/asm/arm_pmuv3.h
>> @@ -171,6 +171,11 @@ static inline bool pmuv3_implemented(int pmuver)
>>    		 pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
>>    }

>> +static inline bool is_pmuv3p1(int pmuver)
>> +{
>> +	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P1;
>> +}
>> +
>>    static inline bool is_pmuv3p4(int pmuver)
>>    {
>>    	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4;
>> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
>> index 3ebc0570345cc..baf0f296c0e53 100644
>> --- a/arch/arm64/kvm/Makefile
>> +++ b/arch/arm64/kvm/Makefile
>> @@ -26,7 +26,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o  
>> pvtime.o \
>>    	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o \
>>    	 vgic/vgic-v5.o

>> -kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
>> +kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu-direct.o pmu.o
>>    kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
>>    kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o

>> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
>> new file mode 100644
>> index 0000000000000..74e40e4915416
>> --- /dev/null
>> +++ b/arch/arm64/kvm/pmu-direct.c
>> @@ -0,0 +1,22 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2025 Google LLC
>> + * Author: Colton Lewis <coltonlewis@google.com>
>> + */
>> +
>> +#include <linux/kvm_host.h>
>> +
>> +#include <asm/arm_pmuv3.h>
>> +
>> +/**
>> + * has_host_pmu_partition_support() - Determine if partitioning is  
>> possible
>> + *
>> + * Partitioning is only supported in VHE mode with PMUv3
>> + *
>> + * Return: True if partitioning is possible, false otherwise
>> + */
>> +bool has_host_pmu_partition_support(void)
>> +{
>> +	return has_vhe() &&
>> +		system_supports_pmuv3();
>> +}
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index 7ff3139dda893..6e447227d801f 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -42,6 +42,13 @@
>>    #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
>>    #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED

>> +static int reserved_host_counters __read_mostly = -1;
>> +bool armv8pmu_is_partitioned;
>> +
>> +module_param(reserved_host_counters, int, 0);
>> +MODULE_PARM_DESC(reserved_host_counters,
>> +		 "PMU Partition: -1 = No partition; +N = Reserve N counters for the  
>> host");
>> +
>>    /*
>>     * ARMv8 Architectural defined events, not all of these may
>>     * be supported on any given implementation. Unsupported events will
>> @@ -532,6 +539,11 @@ static void armv8pmu_pmcr_write(u64 val)
>>    	write_pmcr(val);
>>    }

>> +static u64 armv8pmu_pmcr_n_read(void)
>> +{
>> +	return FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read());
>> +}
>> +
>>    static int armv8pmu_has_overflowed(u64 pmovsr)
>>    {
>>    	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
>> @@ -1312,6 +1324,54 @@ struct armv8pmu_probe_info {
>>    	bool present;
>>    };

>> +/**
>> + * armv8pmu_reservation_is_valid() - Determine if reservation is allowed
>> + * @host_counters: Number of host counters to reserve
>> + *
>> + * Determine if the number of host counters in the argument is an
>> + * allowed reservation, 0 to NR_COUNTERS inclusive.
>> + *
>> + * Return: True if reservation allowed, false otherwise
>> + */
>> +static bool armv8pmu_reservation_is_valid(int host_counters)
>> +{
>> +	return host_counters >= 0 &&
>> +		host_counters <= armv8pmu_pmcr_n_read();
>> +}
>> +
>> +/**
>> + * armv8pmu_partition() - Partition the PMU
>> + * @pmu: Pointer to pmu being partitioned
>> + * @host_counters: Number of host counters to reserve
>> + *
>> + * Partition the given PMU by taking a number of host counters to
>> + * reserve and, if it is a valid reservation, recording the
>> + * corresponding HPMN value in the max_guest_counters field of the PMU  
>> and
>> + * clearing the guest-reserved counters from the counter mask.
>> + *
>> + * Return: 0 on success, -ERROR otherwise
>> + */
>> +static int armv8pmu_partition(struct arm_pmu *pmu, int host_counters)
>> +{
>> +	u8 nr_counters;
>> +	u8 hpmn;
>> +
>> +	if (!armv8pmu_reservation_is_valid(host_counters)) {
>> +		pr_err("PMU partition reservation of %d host counters is not valid",  
>> host_counters);
>> +		return -EINVAL;
>> +	}
>> +
>> +	nr_counters = armv8pmu_pmcr_n_read();
>> +	hpmn = nr_counters - host_counters;
>> +
>> +	pmu->max_guest_counters = hpmn;
>> +	armv8pmu_is_partitioned = true;
>> +
>> +	pr_info("Partitioned PMU with %d host counters -> %u guest counters",  
>> host_counters, hpmn);
>> +
>> +	return 0;
>> +}
>> +
>>    static void __armv8pmu_probe_pmu(void *info)
>>    {
>>    	struct armv8pmu_probe_info *probe = info;
>> @@ -1326,17 +1386,26 @@ static void __armv8pmu_probe_pmu(void *info)

>>    	cpu_pmu->pmuver = pmuver;
>>    	probe->present = true;
>> +	cpu_pmu->max_guest_counters = -1;

>>    	/* Read the nb of CNTx counters supported from PMNC */
>> -	bitmap_set(cpu_pmu->cntr_mask,
>> -		   0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
>> +	bitmap_set(cpu_pmu->hw_cntr_mask, 0, armv8pmu_pmcr_n_read());

>>    	/* Add the CPU cycles counter */
>> -	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask);
>> +	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->hw_cntr_mask);

>>    	/* Add the CPU instructions counter */
>>    	if (pmuv3_has_icntr())
>> -		set_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask);
>> +		set_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->hw_cntr_mask);
>> +
>> +	bitmap_copy(cpu_pmu->cntr_mask, cpu_pmu->hw_cntr_mask,  
>> ARMPMU_MAX_HWEVENTS);
>> +
>> +	if (reserved_host_counters >= 0) {
>> +		if (has_host_pmu_partition_support())
>> +			armv8pmu_partition(cpu_pmu, reserved_host_counters);
>> +		else
>> +			pr_err("PMU partition is not supported");
>> +	}

>>    	pmceid[0] = pmceid_raw[0] = read_pmceid0();
>>    	pmceid[1] = pmceid_raw[1] = read_pmceid1();
>> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
>> index 24a471cf59d56..95f404cdcb2df 100644
>> --- a/include/kvm/arm_pmu.h
>> +++ b/include/kvm/arm_pmu.h
>> @@ -47,7 +47,10 @@ struct arm_pmu_entry {
>>    	struct arm_pmu *arm_pmu;
>>    };

>> +extern bool armv8pmu_is_partitioned;
>> +
>>    bool kvm_supports_guest_pmuv3(void);
>> +bool has_host_pmu_partition_support(void);
>>    #define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >=  
>> VGIC_NR_SGIS)
>>    u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
>>    void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx,  
>> u64 val);
>> @@ -117,6 +120,11 @@ static inline bool kvm_supports_guest_pmuv3(void)
>>    	return false;
>>    }

>> +static inline bool has_host_pmu_partition_support(void)
>> +{
>> +	return false;
>> +}
>> +
>>    #define kvm_arm_pmu_irq_initialized(v)	(false)
>>    static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
>>    					    u64 select_idx)
>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>> index 52b37f7bdbf9e..f7b000bb3eca8 100644
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -109,6 +109,7 @@ struct arm_pmu {
>>    	 */
>>    	int		(*map_pmuv3_event)(unsigned int eventsel);
>>    	DECLARE_BITMAP(cntr_mask, ARMPMU_MAX_HWEVENTS);
>> +	DECLARE_BITMAP(hw_cntr_mask, ARMPMU_MAX_HWEVENTS);

> I think this needs a comment or a clearer name. Both cntr_mask and
> hw_cntr_mask are used in KVM and the PMU driver and it's not immediately
> obvious what the difference is.

I will clarify this. The goal was for hw_cntr_mask to be the unmodified
reference point to restore cntr_mask later.
