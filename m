Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75042ED856
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057161; cv=none; b=MUjHjFtuCJ+HFsAMacLETWqNnlCAVb9qvvyfqhZBJPr2zHe+UdZEt4pfxoWf+Djp9OZOQh8SATOLJHaSeROFMugVXSrsVs7f8bSOATRg23A8QusuV52nB7Q3AOutrRS+wJdYp6E2TavubIqnXXmXbG33JFs/1xN4v1Rm9a2xmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057161; c=relaxed/simple;
	bh=Dbw6vfXTIcPD2nnOiddnC76ZVYtHdIwQERNCs5CZ+AM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=e+fwUw1yQIKK93C/ZLQ3inrVLybbvsyQJO7KBOxP7GDZ9+EwHptU7An5j2ZxC/2lsH/HHFMKBOrgMt5/3KCRIU56dXN/LsAM/mO9bZ1S8SeuyZqiSTYWE2Jm3HpogkXoBJDOShdx7/5oZ2o9bDex+I4fuM/IUHOoulfdMZU9mSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=chb2zHM+; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chb2zHM+"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-72e90e6e171so77202a34.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 13:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751057159; x=1751661959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vCwkQeNvJFmRc91Gk8T3YA4HoLg8Wg847EVfC3MKwm0=;
        b=chb2zHM+qpJUEpMnCwyd8NgEPi3M4Ase/rKhFoV8lM32AdG14FlUUe6DfvAZOvc/Yt
         jZ1DbLscucMS+714pHT7VFfu1Svu+TdttzFkenolTXjezC8oVDkyn8D4bHNhHMlCfb3y
         0hlTPQ5vMzdMQdE9bKa5rNPsZXXQ88fhFnS3ViEttyCZvouSPxhhX31ZOMHfhBkki2KD
         0LRlkOj1dDoEa61My54K+pJvyNuba7HOpVs5nXvveIihUTPzArWZa31RfKHKFAy/+voL
         Z0ixic/1sOJxNl5BjUEE0fd34UbYS29rzWfw5Iacj8De2j4JCLKIB/xfpeLXfszw3YWM
         o1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751057159; x=1751661959;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCwkQeNvJFmRc91Gk8T3YA4HoLg8Wg847EVfC3MKwm0=;
        b=tpO1QiPHKY9dphkWjeo5ytffhDteOxEiSq79plhL75f8k3U5RZcOS79iNt3wZCCm6o
         OyJqhtoYNGYzG8CIw7Cpwsdscq6VXh7FUCo+a8B6baXrPWr5GRV19Jl2qIbfWP5dsjPy
         UKz1SHdloidOBPseA92ofBEtFRtcEzahtYkPOEOPg60VKyZbB7kY7by9tTOKVjpHhYWt
         g06axe4PU1MZsqJr2wrk7OHwiQI/7jn4ikTju9PirnKbXCLVP9pDhDn9aK7w73OCHk3B
         UsTiRMOzdnhHLhrJrSy/s8YbuwzNN7E+PTNc7gKUbZ2P52pQ4vxB6r/RTIHLWBvpQ8V/
         4phg==
X-Forwarded-Encrypted: i=1; AJvYcCXJtxd8+k23MZRP1c8rtVCfqdWUlFMMKhyUTgMHyEbu+Gcc/csDsOahmn54cZq+k57VRrriLQl58HA/hqQgEkqs@vger.kernel.org
X-Gm-Message-State: AOJu0YxDxCnD9kCtvt4ImdOFO0rab3V9SJ3HxLzAzdBThHm9D7194XNX
	EEeSBPtcpo0g9YdWKK0LiDN2hBtwR6rK09ltcDgFS1ZazpVOS/dc1RjpiGq3M8E8jDRvI9WCx7A
	v/xcirWMgMiL9I3B1bZdRiaC01Q==
X-Google-Smtp-Source: AGHT+IH2HpfAlrvSBQPMk62/RIc0nWzkxCoCzJycTm56dna3SUVLdeLNxUVR8JHlvZrOyIvBaFCfMBXjvOwVdkFbjg==
X-Received: from otbby6.prod.google.com ([2002:a05:6830:6086:b0:72c:10e4:a953])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:2710:b0:727:4356:9f07 with SMTP id 46e09a7af769-73afc67b661mr3036914a34.14.1751057158815;
 Fri, 27 Jun 2025 13:45:58 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:45:57 +0000
In-Reply-To: <86plepb54f.wl-maz@kernel.org> (message from Marc Zyngier on Fri,
 27 Jun 2025 16:01:36 +0100)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntbjq89am2.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 10/22] KVM: arm64: Set up FGT for Partitioned PMU
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	oliver.upton@linux.dev, mizhang@google.com, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	shuah@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Marc Zyngier <maz@kernel.org> writes:

> On Thu, 26 Jun 2025 21:04:46 +0100,
> Colton Lewis <coltonlewis@google.com> wrote:

>> In order to gain the best performance benefit from partitioning the
>> PMU, utilize fine grain traps (FEAT_FGT and FEAT_FGT2) to avoid
>> trapping common PMU register accesses by the guest to remove that
>> overhead.

>> There should be no information leaks between guests as all these
>> registers are context swapped by a later patch in this series.

>> Untrapped:
>> * PMCR_EL0
>> * PMUSERENR_EL0
>> * PMSELR_EL0
>> * PMCCNTR_EL0
>> * PMINTEN_EL0
>> * PMEVCNTRn_EL0

>> Trapped:
>> * PMOVS_EL0
>> * PMEVTYPERn_EL0
>> * PMCCFILTR_EL0
>> * PMICNTR_EL0
>> * PMICFILTR_EL0

>> PMOVS remains trapped so KVM can track overflow IRQs that will need to
>> be injected into the guest.

>> PMICNTR remains trapped because KVM is not handling that yet.

>> PMEVTYPERn remains trapped so KVM can limit which events guests can
>> count, such as disallowing counting at EL2. PMCCFILTR and PMCIFILTR
>> are the same.

> I'd rather you explain why it is safe not to trap the rest.

Okay, I will reverse my explanation.


>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/include/asm/kvm_pmu.h        | 23 ++++++++++
>>   arch/arm64/kvm/hyp/include/hyp/switch.h | 58 +++++++++++++++++++++++++
>>   arch/arm64/kvm/pmu-part.c               | 32 ++++++++++++++
>>   3 files changed, 113 insertions(+)

>> diff --git a/arch/arm64/include/asm/kvm_pmu.h  
>> b/arch/arm64/include/asm/kvm_pmu.h
>> index 6328e90952ba..73b7161e3f4e 100644
>> --- a/arch/arm64/include/asm/kvm_pmu.h
>> +++ b/arch/arm64/include/asm/kvm_pmu.h
>> @@ -94,6 +94,21 @@ u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
>>   void kvm_pmu_host_counters_enable(void);
>>   void kvm_pmu_host_counters_disable(void);

>> +#if !defined(__KVM_NVHE_HYPERVISOR__)
>> +bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
>> +bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
>> +#else
>> +static inline bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>>   /*
>>    * Updates the vcpu's view of the pmu events for this cpu.
>>    * Must be called before every vcpu run after disabling interrupts, to  
>> ensure
>> @@ -133,6 +148,14 @@ static inline u64 kvm_pmu_get_counter_value(struct  
>> kvm_vcpu *vcpu,
>>   {
>>   	return 0;
>>   }
>> +static inline bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>> +static inline bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>>   static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
>>   					     u64 select_idx, u64 val) {}
>>   static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
>> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h  
>> b/arch/arm64/kvm/hyp/include/hyp/switch.h
>> index 825b81749972..47d2db8446df 100644
>> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
>> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
>> @@ -191,6 +191,61 @@ static inline bool cpu_has_amu(void)
>>                  ID_AA64PFR0_EL1_AMU_SHIFT);
>>   }

>> +/**
>> + * __activate_pmu_fgt() - Activate fine grain traps for partitioned PMU
>> + * @vcpu: Pointer to struct kvm_vcpu
>> + *
>> + * Clear the most commonly accessed registers for a partitioned
>> + * PMU. Trap the rest.
>> + */
>> +static inline void __activate_pmu_fgt(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_cpu_context *hctxt = host_data_ptr(host_ctxt);
>> +	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
>> +	u64 set;
>> +	u64 clr;
>> +
>> +	set = HDFGRTR_EL2_PMOVS
>> +		| HDFGRTR_EL2_PMCCFILTR_EL0
>> +		| HDFGRTR_EL2_PMEVTYPERn_EL0;
>> +	clr = HDFGRTR_EL2_PMUSERENR_EL0
>> +		| HDFGRTR_EL2_PMSELR_EL0
>> +		| HDFGRTR_EL2_PMINTEN
>> +		| HDFGRTR_EL2_PMCNTEN
>> +		| HDFGRTR_EL2_PMCCNTR_EL0
>> +		| HDFGRTR_EL2_PMEVCNTRn_EL0;
>> +
>> +	update_fgt_traps_cs(hctxt, vcpu, kvm, HDFGRTR_EL2, clr, set);
>> +
>> +	set = HDFGWTR_EL2_PMOVS
>> +		| HDFGWTR_EL2_PMCCFILTR_EL0
>> +		| HDFGWTR_EL2_PMEVTYPERn_EL0;
>> +	clr = HDFGWTR_EL2_PMUSERENR_EL0
>> +		| HDFGWTR_EL2_PMCR_EL0
>> +		| HDFGWTR_EL2_PMSELR_EL0
>> +		| HDFGWTR_EL2_PMINTEN
>> +		| HDFGWTR_EL2_PMCNTEN
>> +		| HDFGWTR_EL2_PMCCNTR_EL0
>> +		| HDFGWTR_EL2_PMEVCNTRn_EL0;
>> +
>> +	update_fgt_traps_cs(hctxt, vcpu, kvm, HDFGWTR_EL2, clr, set);
>> +
>> +	if (!cpus_have_final_cap(ARM64_HAS_FGT2))
>> +		return;
>> +
>> +	set = HDFGRTR2_EL2_nPMICFILTR_EL0
>> +		| HDFGRTR2_EL2_nPMICNTR_EL0;
>> +	clr = 0;
>> +
>> +	update_fgt_traps_cs(hctxt, vcpu, kvm, HDFGRTR2_EL2, clr, set);
>> +
>> +	set = HDFGWTR2_EL2_nPMICFILTR_EL0
>> +		| HDFGWTR2_EL2_nPMICNTR_EL0;
>> +	clr = 0;
>> +
>> +	update_fgt_traps_cs(hctxt, vcpu, kvm, HDFGWTR2_EL2, clr, set);

> This feels wrong. There should be one place to populate the FGTs that
> apply to a guest as set from the host, not two or more.

> There is such a construct in the SME series, and maybe you could have
> a look at it, specially if the trap configuration is this static.

> 	M.

> --
> Without deviation from the norm, progress is not possible.

I'm assuming you are referring to Mark Brown's series [1], specifically
patches 5 and 18 and I see what you mean.

You are probably thinking configuration should happen from
sys_regs.c:kvm_calculate_traps or thereabout and should be setting bits
in the existing kvm->arch.fgt array.

Correct me if I'm mistaken.

[1]  
https://lore.kernel.org/kvm/20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org/
