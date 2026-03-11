Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA93D8110
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230378; cv=none; b=LD6Bl5C1jIrym2XgxaKaonsZ2Um7gKlVU6nMrylJ6tTTeq8dNfO2wlkvbPVPBko97NgkFZw0qi8ftXKCJyLJ9tsHpmYo5VQWgvNLDI+ohVKqyiqCJxAKzgvvTSQeD0mGGpbGsfLGHMPB+x2F3ZAMl2t5EK9kVnyf191k9guqHaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230378; c=relaxed/simple;
	bh=gHxLKLNLtW1cji7d+nB3rsYKS5Hn7R+Q5bOv4VFwznM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aqAawtiBXoCbJuhRPZoJaPIVT8FcaBhXvh/nSOWs7Zw3hmHA57sTceV/vd5ztSs6rELs50BHEGBoerwBFBuzZHpL95emCxRfn5ZZfZWkKXKlapi0dQecFrFVJhYz7j8Lhd/QKCm0+CDe/+srGxFrR90xOd8vDY2HldVYhTFOOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b7Ha8Fgf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7Ha8Fgf"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so6396537a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773230374; x=1773835174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fKwSqge0Bx3u+rCgVUQqBNe12brlVC96iC4+N0TtO+o=;
        b=b7Ha8FgfiPX6gHhG4bjE/vJsi3HB6B0IPc4bLLRAdELdnx43gIktdeDnH/bzm2huVh
         NK2DI6tiTFRVlRTdAQUZc66AyOAmhuuM9KkgDGqnWYYUuqLfKLXuODv7GKr0P9lIlwgh
         H5yL1K+AzkA1Vwz4ifgsp+Ks9KHOQoHScjOzfU0s0KStZdXtOqex7ZtXHYVxrlfE6p7k
         wQvcjKhw6jpw2lm6OpJCHwfOINRlbJiLU84FRRa0dw9hk2FT6yKeH5BQ/zbEuAPGzxNk
         3f2mk9CJFYR26onvMPifXiUGXrPBSN6FI2qtzdiYn8d8aCkPzdZIc0hm15fcg7rMf5p9
         4YTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230374; x=1773835174;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKwSqge0Bx3u+rCgVUQqBNe12brlVC96iC4+N0TtO+o=;
        b=mrgoGz/zvqJ1FkP1s9ELmIPg/xwJEzquzxofiT6SOy6ff+sqoLV4mRJ6pXw2/QjOQ7
         R1glG8Pg+duEx8qNDhfI1W8Wwqk3gvtnKrm93EW9Hm1inP84fXU/8fwgZsSlmMHsaXcA
         JEbq7OcBJoIPhAfkrkvZpLY+BTm6RmJoNz1yWpdjoKz8+GCJqANdnJuWgMKBdaUtqG1l
         ukIrCnpwbBqHw7uc9bJoaEDogtv/cpqFg8oRShK6oDGVBNhBZK00BNH/ko/fMDa4N4Jl
         tq7EqYjh9NLex0Obe11RrDUInoKC+jdnhz2g8HuQAonEIiQYVFiyxb1ywFfkLxN/M8jA
         Ibpw==
X-Forwarded-Encrypted: i=1; AJvYcCU/6Jfnkt/ah51kzd8owLZs7rh278b0wuKhk7Nc+zUQic4DcANl901pd+mW3Lgw+TL+9JcvsJ8mvb5hZ5upfcDE@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYIRt46aNccw9t/gaAl97Gexqyo5uwplzpy64VCkzc3uEd9c1
	ITW9iirrCUjeaQPwQvRPgZ2Ai13T+NXcd9le7TUJ/eI5zsK+IxK2WEG7AjQ5SqmbwqM=
X-Gm-Gg: ATEYQzzTDiLF7HoFROvvOOicbc5jIlEBYHRfqy1ysiVvpJ/oyKNt+qUIHG53uBFgldO
	EMC82hKbiLFwEYsi5Xr3qqcE0OUC9htrVBaOf9oII6LCXTcTaAdzoG/W0GoePAXH+ktBlESLxU+
	nvcXjFqNesAwyxjK//TxtdiZ+qYDxjXB45Tx7LiGDjr7Frkuje2z1Gn9oZ4F6XVgOIKWO5n8w4Y
	l7VhvKTJnjCfivsezhBBAqXXzOU63q86bIbYzxvgCIaUHMiTG0bOA7cs5s4e9VOIdgrrOI3iot4
	Y1Dfwt+HOMKbJlRE6rnpXjEJ03IAWAx7DxURbfdINWB54CTjS6ZCHLrcbJRQZYbYTFjDf9LsiDq
	SewtS1UQxHTgU4SM8SA/DBKedIhaJNHoTngFP1ZX7d+p6IISivgAg3bjL08x4Cn2PuYaSfl5neK
	js+dCE8Eo0dGHBJCa40pKlo+ObwqV0
X-Received: by 2002:a05:6402:5206:b0:65f:aecc:4f24 with SMTP id 4fb4d7f45d1cf-66319ddcba6mr1131945a12.24.1773230373721;
        Wed, 11 Mar 2026 04:59:33 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66315320df2sm484743a12.24.2026.03.11.04.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 04:59:33 -0700 (PDT)
Message-ID: <47592c2d-2b12-4d28-ae5d-9d2f68ec7186@linaro.org>
Date: Wed, 11 Mar 2026 11:59:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v6 04/19] perf: arm_pmuv3: Introduce method to partition
 the PMU
To: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260209221414.2169465-1-coltonlewis@google.com>
 <20260209221414.2169465-5-coltonlewis@google.com>
Content-Language: en-US
In-Reply-To: <20260209221414.2169465-5-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/02/2026 10:13 pm, Colton Lewis wrote:
> For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
> counters into two ranges where counters 0..HPMN-1 are accessible by
> EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
> EL2.
> 
> Create module parameter reserved_host_counters to reserve a number of
> counters for the host. This number is set at boot because the perf
> subsystem assumes the number of counters will not change after the PMU
> is probed.
> 
> Introduce the function armv8pmu_partition() to modify the PMU driver's
> cntr_mask of available counters to exclude the counters being reserved
> for the guest and record reserved_guest_counters as the maximum
> allowable value for HPMN.
> 
> Due to the difficulty this feature would create for the driver running
> in nVHE mode, partitioning is only allowed in VHE mode. In order to
> support a partitioning on nVHE we'd need to explicitly disable guest
> counters on every exit and reset HPMN to place all counters in the
> first range.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm/include/asm/arm_pmuv3.h   |  4 ++
>   arch/arm64/include/asm/arm_pmuv3.h |  5 ++
>   arch/arm64/kvm/Makefile            |  2 +-
>   arch/arm64/kvm/pmu-direct.c        | 22 +++++++++
>   drivers/perf/arm_pmuv3.c           | 78 +++++++++++++++++++++++++++++-
>   include/kvm/arm_pmu.h              |  8 +++
>   include/linux/perf/arm_pmu.h       |  1 +
>   7 files changed, 117 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm64/kvm/pmu-direct.c
> 
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
> index 2ec0e5e83fc98..154503f054886 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -221,6 +221,10 @@ static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
>   	return false;
>   }
>   
> +static inline bool has_host_pmu_partition_support(void)
> +{
> +	return false;
> +}
>   static inline bool kvm_set_pmuserenr(u64 val)
>   {
>   	return false;
> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
> index cf2b2212e00a2..27c4d6d47da31 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -171,6 +171,11 @@ static inline bool pmuv3_implemented(int pmuver)
>   		 pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
>   }
>   
> +static inline bool is_pmuv3p1(int pmuver)
> +{
> +	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P1;
> +}
> +
>   static inline bool is_pmuv3p4(int pmuver)
>   {
>   	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4;
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 3ebc0570345cc..baf0f296c0e53 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -26,7 +26,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
>   	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o \
>   	 vgic/vgic-v5.o
>   
> -kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
> +kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu-direct.o pmu.o
>   kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
>   kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
>   
> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> new file mode 100644
> index 0000000000000..74e40e4915416
> --- /dev/null
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Google LLC
> + * Author: Colton Lewis <coltonlewis@google.com>
> + */
> +
> +#include <linux/kvm_host.h>
> +
> +#include <asm/arm_pmuv3.h>
> +
> +/**
> + * has_host_pmu_partition_support() - Determine if partitioning is possible
> + *
> + * Partitioning is only supported in VHE mode with PMUv3
> + *
> + * Return: True if partitioning is possible, false otherwise
> + */
> +bool has_host_pmu_partition_support(void)
> +{
> +	return has_vhe() &&
> +		system_supports_pmuv3();
> +}
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 8d3b832cd633a..798c93678e97c 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -42,6 +42,13 @@
>   #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
>   #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
>   
> +static int reserved_host_counters __read_mostly = -1;
> +int armv8pmu_max_guest_counters = -1;
> +
> +module_param(reserved_host_counters, int, 0);
> +MODULE_PARM_DESC(reserved_host_counters,
> +		 "PMU Partition: -1 = No partition; +N = Reserve N counters for the host");
> +
>   /*
>    * ARMv8 Architectural defined events, not all of these may
>    * be supported on any given implementation. Unsupported events will
> @@ -532,6 +539,11 @@ static void armv8pmu_pmcr_write(u64 val)
>   	write_pmcr(val);
>   }
>   
> +static u64 armv8pmu_pmcr_n_read(void)
> +{
> +	return FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read());
> +}
> +
>   static int armv8pmu_has_overflowed(u64 pmovsr)
>   {
>   	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
> @@ -1309,6 +1321,61 @@ struct armv8pmu_probe_info {
>   	bool present;
>   };
>   
> +/**
> + * armv8pmu_reservation_is_valid() - Determine if reservation is allowed
> + * @host_counters: Number of host counters to reserve
> + *
> + * Determine if the number of host counters in the argument is an
> + * allowed reservation, 0 to NR_COUNTERS inclusive.
> + *
> + * Return: True if reservation allowed, false otherwise
> + */
> +static bool armv8pmu_reservation_is_valid(int host_counters)
> +{
> +	return host_counters >= 0 &&
> +		host_counters <= armv8pmu_pmcr_n_read();
> +}
> +
> +/**
> + * armv8pmu_partition() - Partition the PMU
> + * @pmu: Pointer to pmu being partitioned
> + * @host_counters: Number of host counters to reserve
> + *
> + * Partition the given PMU by taking a number of host counters to
> + * reserve and, if it is a valid reservation, recording the
> + * corresponding HPMN value in the max_guest_counters field of the PMU and
> + * clearing the guest-reserved counters from the counter mask.
> + *
> + * Return: 0 on success, -ERROR otherwise

Hi Colton,

Couple of minor nits. But this error return value isn't used by the caller.

> + */
> +static int armv8pmu_partition(struct arm_pmu *pmu, int host_counters)
> +{
> +	u8 nr_counters;
> +	u8 hpmn;
> +
> +	if (!armv8pmu_reservation_is_valid(host_counters)) {
> +		pr_err("PMU partition reservation of %d host counters is not valid", host_counters);
> +		return -EINVAL;
> +	}
> +
> +	nr_counters = armv8pmu_pmcr_n_read();
> +	hpmn = nr_counters - host_counters;
> +
> +	pmu->max_guest_counters = hpmn;
> +	armv8pmu_max_guest_counters = hpmn;

And this could be more like 'bool armv8pmu_partitioned'. PMUs will have 
different numbers of counters so it's a bit misleading to have one 
global, and the actual value isn't used either.

> +
> +	bitmap_clear(pmu->cntr_mask, 0, hpmn);
> +	bitmap_set(pmu->cntr_mask, hpmn, host_counters);
> +	clear_bit(ARMV8_PMU_CYCLE_IDX, pmu->cntr_mask);
> +
> +	if (pmuv3_has_icntr())
> +		clear_bit(ARMV8_PMU_INSTR_IDX, pmu->cntr_mask);
> +
> +	pr_info("Partitioned PMU with %d host counters -> %u guest counters", host_counters, hpmn);
> +
> +	return 0;
> +}
> +
>   static void __armv8pmu_probe_pmu(void *info)
>   {
>   	struct armv8pmu_probe_info *probe = info;
> @@ -1323,10 +1390,10 @@ static void __armv8pmu_probe_pmu(void *info)
>   
>   	cpu_pmu->pmuver = pmuver;
>   	probe->present = true;
> +	cpu_pmu->max_guest_counters = -1;
>   
>   	/* Read the nb of CNTx counters supported from PMNC */
> -	bitmap_set(cpu_pmu->cntr_mask,
> -		   0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
> +	bitmap_set(cpu_pmu->cntr_mask, 0, armv8pmu_pmcr_n_read());
>   
>   	/* Add the CPU cycles counter */
>   	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask);
> @@ -1335,6 +1402,13 @@ static void __armv8pmu_probe_pmu(void *info)
>   	if (pmuv3_has_icntr())
>   		set_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask);
>   
> +	if (reserved_host_counters >= 0) {
> +		if (has_host_pmu_partition_support())
> +			armv8pmu_partition(cpu_pmu, reserved_host_counters);
> +		else
> +			pr_err("PMU partition is not supported");
> +	}
> +
>   	pmceid[0] = pmceid_raw[0] = read_pmceid0();
>   	pmceid[1] = pmceid_raw[1] = read_pmceid1();
>   
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 24a471cf59d56..e7172db1e897d 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -47,7 +47,10 @@ struct arm_pmu_entry {
>   	struct arm_pmu *arm_pmu;
>   };
>   
> +extern int armv8pmu_max_guest_counters;
> +
>   bool kvm_supports_guest_pmuv3(void);
> +bool has_host_pmu_partition_support(void);
>   #define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
>   u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
>   void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
> @@ -117,6 +120,11 @@ static inline bool kvm_supports_guest_pmuv3(void)
>   	return false;
>   }
>   
> +static inline bool has_host_pmu_partition_support(void)
> +{
> +	return false;
> +}
> +
>   #define kvm_arm_pmu_irq_initialized(v)	(false)
>   static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
>   					    u64 select_idx)
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 52b37f7bdbf9e..1bee8c6eba46b 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -129,6 +129,7 @@ struct arm_pmu {
>   
>   	/* Only to be used by ACPI probing code */
>   	unsigned long acpi_cpuid;
> +	int		max_guest_counters;
>   };
>   
>   #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))

