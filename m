Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C443C73D9
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230448; cv=none; b=pfaFeIaG5wHw0kKfH4BKQGzlDFoAkUn8Sx28j0TC7b/xdwazij4deVPchf5Opdl35bWkq++4sSlxMPK1EGuRDffQdVenTZGfVhKmRMVrnxaF9k8Ucm0Je7+Nj3xCn4U6/OdKvSxzTZGFPikMOi9GIXjGjznxrqiq52r2570bv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230448; c=relaxed/simple;
	bh=E92Lh4tvjrSsBZrvXHil80NIkNaNGxC/VtXNxe44axA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpHXY5IlKsQEYse5CGkQoklPVv5wCQ3kkn296zGj6u2b9hwAXWSADjKyuLQxK8WY6KzNGoOn5G1lrl880lob2Qh/bR5NuJ5vGAdlB+nEpii7urVsFt95Aj1oUaPn9xJcylm3QwaO31wl4Vtlx0Se1truqdEECIcoaETqg+1zRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6wX26v9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6wX26v9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-485445e80bdso16409415e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773230444; x=1773835244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=130nMfpxEVLAWE8mJauFzxZjoerVddIIHSIrMCUq+e8=;
        b=g6wX26v9+yQvJb3F8Phow6poKPlg3nGTyaNtQdwwjFyIgN8T1fGypOfR16znLPAo8Y
         E7FIrpiPTJbS3z0AeS1WTEU8UZA1CsoJUb/ZBwliNXUEF1FCKiCvxc5yEJKqX/v7rPvn
         z3Jo/EalJ9Wc6qe4j7xrU3NiCl+qwh07n6zG4jgd4K5EXTuL05IRZvZWfkWo1UdrHX65
         2kv0K5v0dmvT8417Au+ZB6jSU3lk/8J1WoP8dtvenDMog2TeZ38wO9X8y7xdxMotdX40
         yybsDoRB2OMx1kuQKW+XZy5oAMqleMn3GChsiomjtthkdNIKPYC1nMGOWNJkJSWZ/sM/
         fNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230444; x=1773835244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=130nMfpxEVLAWE8mJauFzxZjoerVddIIHSIrMCUq+e8=;
        b=OLHh5cJoRiiwIR5udawU793J909eop7u83IpxmdVSlTqceidPC3OpCCBxx+zFLh4X9
         WX47w4aOf8ifTi4rKH2c+7m/6dagxOiDGhJ/L2ko8RKeYyg/j79oaMl7/8EeRcPwandg
         7zdB7xNEFJR8JO19zO3HWhjs2pkBAPCdvmh1Pjrxqd+a/jMnuKaOHrK1HMuKy1qebnmU
         OxkHOnJuHIoPubQAK5nvZtXOf065txvAr345bS/U5ZIdEDSrWhH00LJNMHeSZJdAaAot
         ELe2m+j5w3jjj77lvZtkkfptAK3m86uVo6r5IBIBPmj6DAO/MpCV4bHg/BjRI8TOQSQM
         SNZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU42Ok+zkc9S2+z/HZiS4B28/5xpaGP8v/xrijbnB+32+qKnFm484KsJuQLbCmApvWtSa69Ki1ujx28h8Hxfm7u@vger.kernel.org
X-Gm-Message-State: AOJu0YxREzsUZNlDUU9IfnHGByn+nz7nPluop54E7Z4AvzyX0ak8rhzK
	3MzbOhoGu3rFDxtzaJQlaE55vPOk0B7XEN2f8gpcSHXXpyQAhl6yxXyjXrRSVwHHzvI=
X-Gm-Gg: ATEYQzyGBV3wBWinw/S1Yr2ScgeyDzXn6QtO/BJ0Xu1PWPbAdyHd7H0FSEzyIi+7obY
	y46s1HYMWoI5MTFObEklKbULG7T/GlzSeX1jAWwB11iv66f2IDlI+3YisheuOw8koT56E7CGCpS
	usftXph1THJ1gxmKCpowqCyUB1DYq8vTU4PkBAkj9MRqW90Ps5c9paEbKSmi/NCgh6gq8VB2dCs
	Aija8Pgwudq2AfMfNAq6Igml60XBOldaWo3OLTL97V3rFWqDtu9eIuCQDCMP9WDWhbkuxGFRrIa
	52S3LSQ3IEjwzuyXCD9F0sTnMInNl9H7Oy7dfb9W6cYw60muJX3EeFsY0DrNSP7C0qQ+Zcr2WGm
	F6lLy4j6z3dp7uxeqNozJl4lAe0YIYH6wWZHdIh71Ra0IB5V9K01taTzgcCJ/Mp2qhl64K5qqvQ
	huHNJvrQokXWUVnoFdwc5kWspFX8Me
X-Received: by 2002:a05:600c:3b1c:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-4854b123903mr37819645e9.24.1773230443521;
        Wed, 11 Mar 2026 05:00:43 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818d37fsm6957985f8f.6.2026.03.11.05.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 05:00:43 -0700 (PDT)
Message-ID: <1e97d367-ae01-4cd2-8005-f690e6d7f72d@linaro.org>
Date: Wed, 11 Mar 2026 12:00:42 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/19] perf: arm_pmuv3: Keep out of guest counter
 partition
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
 <20260209221414.2169465-7-coltonlewis@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260209221414.2169465-7-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/02/2026 10:14 pm, Colton Lewis wrote:
> If the PMU is partitioned, keep the driver out of the guest counter
> partition and only use the host counter partition.
> 
> Define some functions that determine whether the PMU is partitioned
> and construct mutually exclusive bitmaps for testing which partition a
> particular counter is in. Note that despite their separate position in
> the bitmap, the cycle and instruction counters are always in the guest
> partition.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm/include/asm/arm_pmuv3.h | 18 +++++++
>   arch/arm64/kvm/pmu-direct.c      | 86 ++++++++++++++++++++++++++++++++
>   drivers/perf/arm_pmuv3.c         | 40 +++++++++++++--
>   include/kvm/arm_pmu.h            | 24 +++++++++
>   4 files changed, 164 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
> index 154503f054886..bed4dfa755681 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -231,6 +231,24 @@ static inline bool kvm_set_pmuserenr(u64 val)
>   }
>   
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
>   
>   /* PMU Version in DFR Register */
>   #define ARMV8_PMU_DFR_VER_NI        0
> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 74e40e4915416..05ac38ec3ea20 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -5,6 +5,8 @@
>    */
>   
>   #include <linux/kvm_host.h>
> +#include <linux/perf/arm_pmu.h>
> +#include <linux/perf/arm_pmuv3.h>
>   
>   #include <asm/arm_pmuv3.h>
>   
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
> + * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved counters
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
> + * kvm_pmu_guest_counter_mask() - Compute bitmask of guest-reserved counters
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

This should be an | instead of an & otherwise it's always zero. None of 
the passed through counters count anything with it like this, although 
the cycle counter always worked even with this issue.

I'm not sure if the selftests that you added catch this? I didn't try 
running them but seems like checking for non zero counter values is a 
very easy thing to test.



