Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B23FD135
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510984; cv=none; b=BfzlyLJRQ8CgjIn3SBew6wIvcWgaQw29aNEVgBHFLfdXVmkudyxnK95QEe93nZ2dN3Os0qPAfv1Hl9kjXgXlZpmzHQYPcuwhBlLgL8g+jEiVGQUR/yjSJauXsZ6izmh2bcly572drj1/kp7W7XemWoAEHY0RCygNZ9OJYa6Lto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510984; c=relaxed/simple;
	bh=gMZcBmHoLH5063KYF9NKsy9Tpdrk0FyoPinO83KeiGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nb5PJr6xw/JVQUoeEOaw7kFC08FSe2ClWkVkO0BPBQW+xvIhViBb3BSt7Spgi5Szv1iWoOWVXtdH7f57rCZs6B8PVWaEkex57krkBuF+meKmj5pUw0VAeLXtaizcttsQ6ld+1XFmajBpvSzy9L22mrquVVUReTTGOBCuxkyi1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ViGST4HI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViGST4HI"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e5624c053so2488904f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778510979; x=1779115779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6uflrulgEFIn9x44XDb2ne6l2kjOQ5bKLrwMyk01QUg=;
        b=ViGST4HIk3bqHQpVU1NidNJgHUA7QR/K7zLAxKPbGDovJXBv6frHXSZSafPu3XfoN5
         eVcUWw+NOOzJJ0TWepVR+XhsG+hVDlgynlhz1GDLKwwJVITQjkjQpmt698kFrNTh0Rom
         p5PumOiWWzMLdPFsgmsDagw2TMsDOxghxUrJ70SCfd76lQ1n0O+GS7HdWrpM9WcBocuH
         SSqYSsK8SEcox/L/J2IrFTW77UoPSH51yr7wUagNTM/jaBue0c5KuuhhKsjeZty18ahW
         2fBYVX8iyj5cwLCnDvSocnjAZpZ/s40w+G7KYWQDQGDZ4gNHTR1XxTMTq58VIkLIEpwK
         9hPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510979; x=1779115779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uflrulgEFIn9x44XDb2ne6l2kjOQ5bKLrwMyk01QUg=;
        b=gmrgtkomUKBylg9Qs7qp4q9Cd8YpK/Nu8YoDgbDTqL6ee1+4zth76nD59+ppqDV7BO
         RO3EsGy/5qTarD02Mhph9ukd71T/53lRTfTH79Dw9alKYa+/w2Ai02u85txq2y8DbV0A
         1kC5OCWWWWn7l+K2fGJ09E39xK7FML3SKQbxhKuUV4s/RkH1PezwVhcce/40YkClr7DF
         uVSJ0OG779RW4IOXDNPSu9UPH3AEEzXhsfnNKGUpk3fxHZBUk5F2ULLdS0JGJCdm8Ov3
         HxUbj+qGnt9PL31Vi0ShhPRPDEsnYxsu/NBryDIgK5MIPcnEYznj2bWPNZc57Z7YcW4h
         37iA==
X-Forwarded-Encrypted: i=1; AFNElJ9N8jWutA4JRy6Br747C2Zo34T+URVOXZXM6Ag1lIpV9ZPr8A4jTzj89N63Q+/yqIsTNeem+ApgebNPv4M+ZH/1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4+6TqG+nN9SHF3gD6HubGIJW6LYuhYRcMXIbkVYa250b3uyZT
	vv/uMLO+Xp+NV+tyhKSeR3upKOr9L0ohVh1NDXPG4CRvTdJ1bGlbgk8fhCjt8IpiAYU=
X-Gm-Gg: Acq92OEaiJ1r+TEMlqn3kHJkVyGhRMzc+xp9zp1DXTXb66s4Vy5HxUHbRPDqNXst7yE
	KsaP42l1sXA2fFLAGskYoBm50w7muSUcXpddCeGhupzsicZmfbNz+q5hQp2hs7eMiVvzpHdny4V
	zuovNXIp7TVsA2fx5TGJwAnCMAc27es2EW8COkzQi51zKfAuFpDrI77ppHvequX+g5fVFQMD7m1
	SC46eJyy4c8crNjr5x+uc3+KHRKB9PPz+/dZzK+iG+3qq5Bv75/unPdTQcSyuJinaYSyn+caPxb
	gxNuPWuKkas17oK0We7n6C8m1yjyyULmGE8+CIBpcf8UQn3/P5NPFDklZvXSjJov2SQAQc0ZCjL
	ZM6UefITnLrTw5PWFlWw3ZAN+33CuvOd9D87RQLCC+rEUHtB62hU+7ZjbqhmJ4uXam+nTy53xup
	MVI7/Ry4cm+/iBc2m+16dyvmZ9PKW4YD8EZ7opsZc4EtK+c5IyTQ==
X-Received: by 2002:a05:600c:33a9:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-48e51e0bb9amr250632005e9.1.1778510979404;
        Mon, 11 May 2026 07:49:39 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e5516sm293146665e9.7.2026.05.11.07.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 07:49:38 -0700 (PDT)
Message-ID: <ad02327b-01b6-4ed9-b9bb-e2c6ed4b2890@linaro.org>
Date: Mon, 11 May 2026 15:49:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/20] KVM: arm64: Context swap Partitioned PMU guest
 registers
To: Colton Lewis <coltonlewis@google.com>
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
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org
References: <20260504211813.1804997-1-coltonlewis@google.com>
 <20260504211813.1804997-11-coltonlewis@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260504211813.1804997-11-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/05/2026 10:18 pm, Colton Lewis wrote:
> Save and restore newly untrapped registers that can be directly
> accessed by the guest when the PMU is partitioned.
> 
> * PMEVCNTRn_EL0
> * PMCCNTR_EL0
> * PMSELR_EL0
> * PMCR_EL0
> * PMCNTEN_EL0
> * PMINTEN_EL1
> 
> If we know we are not partitioned (that is, using the emulated vPMU),
> then return immediately. A later patch will make this lazy so the
> context swaps don't happen unless the guest has accessed the PMU.
> 
> PMEVTYPER is handled in a following patch since we must apply the KVM
> event filter before writing values to hardware.
> 
> PMOVS guest counters are cleared to avoid the possibility of
> generating spurious interrupts when PMINTEN is written. This is fine
> because the virtual register for PMOVS is always the canonical value.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm/include/asm/arm_pmuv3.h |   4 +
>   arch/arm64/kvm/arm.c             |   2 +
>   arch/arm64/kvm/pmu-direct.c      | 169 +++++++++++++++++++++++++++++++
>   include/kvm/arm_pmu.h            |  16 +++
>   4 files changed, 191 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
> index 42d62aa48d0a6..eebc89bdab7a1 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -235,6 +235,10 @@ static inline bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
>   {
>   	return false;
>   }
> +static inline u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
> +{
> +	return ~0;
> +}
>   
>   /* PMU Version in DFR Register */
>   #define ARMV8_PMU_DFR_VER_NI        0
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 410ffd41fd73a..a942f2bc13fc4 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -680,6 +680,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>   		kvm_vcpu_load_vhe(vcpu);
>   	kvm_arch_vcpu_load_fp(vcpu);
>   	kvm_vcpu_pmu_restore_guest(vcpu);
> +	kvm_pmu_load(vcpu);
>   	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
>   		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
>   
> @@ -721,6 +722,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>   	kvm_timer_vcpu_put(vcpu);
>   	kvm_vgic_put(vcpu);
>   	kvm_vcpu_pmu_restore_host(vcpu);
> +	kvm_pmu_put(vcpu);
>   	if (vcpu_has_nv(vcpu))
>   		kvm_vcpu_put_hw_mmu(vcpu);
>   	kvm_arm_vmid_clear_active();
> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 63ac72910e4b5..360d022d918d5 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -9,6 +9,7 @@
>   #include <linux/perf/arm_pmuv3.h>
>   
>   #include <asm/arm_pmuv3.h>
> +#include <asm/kvm_emulate.h>
>   
>   /**
>    * has_host_pmu_partition_support() - Determine if partitioning is possible
> @@ -98,3 +99,171 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
>   
>   	return *host_data_ptr(nr_event_counters);
>   }
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
> +	if (kvm_pmu_is_partitioned(pmu))
> +		return GENMASK(nr_counters - 1, pmu->max_guest_counters);
> +
> +	return ARMV8_PMU_CNT_MASK_ALL;
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
> +	if (kvm_pmu_is_partitioned(pmu))
> +		return ARMV8_PMU_CNT_MASK_C | GENMASK(pmu->max_guest_counters - 1, 0);
> +
> +	return 0;
> +}

Minor nit: slightly inconsistent use of types. Returns a u64 but doesn't 
use GENMASK_ULL and is also usually saved into a long when it's called.

