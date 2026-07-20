Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64809443318
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566009; cv=none; b=Mb84Cz0+kY0u8lngi62M60ig4IGE7tf+tK1rv1RsRfalmXNhHcKOiJQFD6gGOCafVxluBXfBCW16VwJFAed3C3AK/5AIaScsY0CHNyQcj7eyov6E+yg5W98fQpxj218vidZxpBdtM8mlcmo65BC610XJKjUj5MZPUKR8oUT1J+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566009; c=relaxed/simple;
	bh=XIao6mIlaKS8X9ZP1wVKDebqhjcSXIh5nEXgFPo3CXA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FwvPvkF9WEJU/MQM/EKMKzUaKfZ5WECcD8wXOVtMvy40sKlihR6NMJeoKTRIk5+lD3nKlU75yAswpdJSjbrHTElmVEyZbTwZZhVdJnrBEHs6Nep5MEPyQav9qvQjyYDwMpeRReFdi6qvbsVSO++wBr0GxcRu231DL8nyUcDf+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zz3aiimX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zz3aiimX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so19325565e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784566000; x=1785170800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMSpywKxqagrBACgJFmPd3iIfkAUv2kJob+ZiosLjg0=;
        b=Zz3aiimXdOmo2nDQFnSZTGpYrpkvLYaCOqhV8wBwqSbYlBYFggbZ1ZqM/3rinXhiud
         oOdVOZgohGfIHZVpmJBPKNgAbsF/5m9YxnIe7G8JAYK3hp05THXNzJnFAxf8ikjMVNp/
         R/lr4GDBfof8gy/ln3GmzgrIrRMJk4Es8qa26MpZxcE0xp/nMULTWmPP6kZHDJndYdlm
         aST8OtabW4KpWo9s1BEVbeWCSMOfYugdPAO8NvzPfIM16auApnUZvWxBgik+QCPVu6F7
         HsDi9sEWgTQQ/P7VmWcQCiwjMmpo1EJFUtErnPU7uafL+GOa5vIfPQGTHDD/UVtBJigv
         Z66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566000; x=1785170800;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMSpywKxqagrBACgJFmPd3iIfkAUv2kJob+ZiosLjg0=;
        b=XnXkw3XWWrfHbBBIxQs1W0wMfrVBUrdW4OXXzYkbMBPKy5m1Gult8YgBTIeJK6uer1
         x7Kj6IIBa+n/HGU/pkFgPFGuTfjnqlJQlx+LCKc7zrBwMeqdLvOYYZBiKTTNLEducKra
         KyqCLic/n6RzbDTkVlnoHHg4eE9G6StBVPiZRG8O0N96U8r1S8PH65WW2QmEFCvw3wYx
         sAb+cK2HtGAuHETr5bdqsMafVRqbk3C0DJbAW0s4p7s9WtNoMVXzGPysdYNYENQMFFJ+
         J0e2FekijyxtcmvnI9DqeEQMiC0EDDrD415Ca9ib/2FU+iNB0qn0r/bjAIxhn8aE3g6F
         CgWw==
X-Forwarded-Encrypted: i=1; AHgh+RpzZ8mmElbgApcAsKmuEGYP6ipFD5I3IaRJHaF5D1Za9gSUiLGbQ3mdOCJyuQCwENqV8tcmCWFTkOknOVpq5qIf@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQhg4srlrFG5IXOUH2Pz70AhhGUvu0GI8x9JyOnGj5mYOy5oW
	QYKbkFdjabPGrwBN8eWVfgLipNRy6Z0o5klEMtcUxjnNADyWBIrdog84qMlPnFwvkI8=
X-Gm-Gg: AR+sD13iaOL1NLdNorfSS/Fte+urVm9aBvrhszo7HBefDNWbmNPjaP8WpBPHpQ0Gqkg
	lcfTqav+A7SSnKF4iOYIo/XpalK2zxXLOVJYctbAl+AKbSXmTbqyj0qjmUVlTHX9eMq+gg5eseL
	pGfsXRms0GU0/nFyTMmM2Wky/WpaQfc7yoQo4pDRZSMcxUDD/iWPNlRyMoCvGLMWnlBaXGSrRn4
	NL7wglE7mJyMKvx9Sam9HrIpY33G7zrQqL4qDdckrO606vlROjCnxrhDzUiG1ndQAntAsH7ge3F
	V9YBHQecDyri0uisXBbJ1u6W0C664pgeXIcDfqURcCkmrNjPglre15ATgjPlU3lkckJvLoAPnAI
	Fn2NtBhdXz4DoX5K14TYQYRcJq41jfXaoACuRsD2duSmabuJJLueaKyVsR3opCwxP4p/jOdCsoE
	sSe68DhKk=
X-Received: by 2002:a05:6000:4310:b0:47d:ecaa:3f97 with SMTP id ffacd0b85a97d-47f6233db68mr17307845f8f.45.1784566000150;
        Mon, 20 Jul 2026 09:46:40 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e496afsm32530307f8f.1.2026.07.20.09.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 09:46:39 -0700 (PDT)
Message-ID: <3fc867c3-67a0-4fdd-b871-f2ba4d642f1f@linaro.org>
Date: Mon, 20 Jul 2026 17:46:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Clark <james.clark@linaro.org>
Subject: Re: [PATCH 11/21] KVM: arm64: Context swap Partitioned PMU guest
 registers
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
References: <20260612192909.1153907-1-coltonlewis@google.com>
 <20260612192909.1153907-12-coltonlewis@google.com>
Content-Language: en-US
In-Reply-To: <20260612192909.1153907-12-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2026 20:28, Colton Lewis wrote:
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
>   arch/arm64/kvm/pmu-direct.c      | 183 +++++++++++++++++++++++++++++++
>   include/kvm/arm_pmu.h            |  16 +++
>   4 files changed, 205 insertions(+)
> 

[...]

> +
> +/**
> + * kvm_pmu_put() - Put untrapped PMU registers
> + * @vcpu: Pointer to struct kvm_vcpu
> + *
> + * Put all untrapped PMU registers from the VCPU into the PCPU. Mask
> + * to only bits belonging to guest-reserved counters and leave
> + * host-reserved counters alone in bitmask registers.
> + */
> +void kvm_pmu_put(struct kvm_vcpu *vcpu)
> +{
> +	struct arm_pmu *pmu;
> +	unsigned long guest_counters;
> +	unsigned long flags;
> +	u64 mask;
> +	u8 i;
> +	u64 val;
> +
> +	/*
> +	 * If we aren't guest-owned then we know the guest is not
> +	 * accessing the PMU anyway, so no need to bother with the
> +	 * swap.
> +	 */
> +	if (!kvm_pmu_is_partitioned(vcpu->kvm))
> +		return;
> +
> +	preempt_disable();
> +
> +	pmu = vcpu->kvm->arch.arm_pmu;
> +	guest_counters = kvm_pmu_guest_counter_mask(pmu);
> +
> +	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
> +		if (i == ARMV8_PMU_CYCLE_IDX)
> +			val = read_pmccntr();
> +		else
> +			val = read_pmevcntrn(i);
> +
> +		__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + i, val);
> +	}
> +
> +	val = read_sysreg(pmselr_el0);
> +	__vcpu_assign_sys_reg(vcpu, PMSELR_EL0, val);
> +
> +	val = read_sysreg(pmcr_el0);
> +	__vcpu_assign_sys_reg(vcpu, PMCR_EL0, val);
> +
> +	/* Mask these to only save the guest relevant bits. */
> +	mask = kvm_pmu_guest_counter_mask(pmu);
> +
> +	val = read_sysreg(pmcntenset_el0);
> +	__vcpu_assign_sys_reg(vcpu, PMCNTENSET_EL0, val & mask);
> +
> +	val = read_sysreg(pmintenset_el1);
> +	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
> +
> +	/* Save pending guest hardware overflows. */
> +	local_irq_save(flags);
> +	val = read_sysreg(pmovsset_el0);
> +	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, val & mask);
> +	write_sysreg(val & mask, pmovsclr_el0);
> +	local_irq_restore(flags);
> +
> +	/* Stop guest counters and disable interrupts in hardware. */
> +	write_sysreg(mask, pmcntenclr_el0);
> +	write_sysreg(mask, pmintenclr_el1);
> +
> +	kvm_pmu_set_guest_counters(pmu, 0);

Hi Colton,

This function doesn't get added until "KVM: arm64: Apply dynamic guest 
counter reservations" a few commits later.

kvm_pmu_guest_counter_mask() is also used in a commit before it's added.

