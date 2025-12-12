Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10F28B3E7
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578347; cv=none; b=O5EURQDdKx5GXEtFOob8plyfhRRSbUhl+TRotPrmoCspXpVB5n92kmyAD3fjlR5YMY23mMsmqfxxvTOsVrpPAMaCA6wOhUq8bw4Z2ii3i+AnpEE24Xf8BxNPoLxrr/PvmvUWeJLlkgdZuGBb8V2SVtA/25AJMigbLPy0tJdJcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578347; c=relaxed/simple;
	bh=kbOpl9/EBS6WJQv34DS3/RORKeG4Tpro9hVI1b+Wo+Q=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=bPKqwl7h/K4nlCSliQ0ozC0l5PbHtxdlOnSPP3HLLKE0GbWHi0XWEPx1I3/SAwTcZKp+go6hzhY7lWgxFiLsVEno5kZwF6w/ifkiwUg5W4BeSORAJwXtnq6ss6UVfFxSee7AjiP00uyk7AQ/vmZWgY3agpHCb1YhjToRi6PSd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4AJ7w4St; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4AJ7w4St"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-65746235dd4so1243549eaf.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765578345; x=1766183145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kTtJNntNErDibGFF1qkwnsYLDpE8m9agPY4m5XiEmeI=;
        b=4AJ7w4Stxn4zo4pMPqrbCVRQNLPO1IoxYFNjdYOIEhv/GaUdKFB5aPLyWzUZmClVBA
         Movgeh+WEAiAcvYylPxGti1NOiF9oJ9TAY85B4Vj42dcTmafBIvwVxebcc7a2jCRaY+G
         Uurdw5KNm7dVA4Yfh0m2pGPgdIoD+dcd/L2DlAghJ57t4WvmjZwTYuNo1akbwnFVQtiM
         DeJcWsNiJh3Ju+JpAw7MRN5/xUtXF30gohcgNOEOhHwLYOow1m23qVddchK9+unhrlna
         JxJ/nGLSLEIo+XilhFyO+u+9V9Q+sV5ueIjSuK7crWiz9X+SBPostV7bCk91W8SaHCvS
         ImzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765578345; x=1766183145;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTtJNntNErDibGFF1qkwnsYLDpE8m9agPY4m5XiEmeI=;
        b=aEXF7ci9Q8oOQjm65eQtm0uKLLIhWwE4Hlr/kWeRjFNLpCMlyOC00T6cUJiDhklVvv
         tQFDPJV5e6UiAhM5OooFiSNvLP6Ltd09bqSrYg10pRrJFTYK3TIuaD6nzvaEERytoRGX
         rE61Rdy06xYOCLo1sJ+/knAxeCyf4eLH/AKU0zNBaAGHN2Rk1jfO2z5FZOjya21joUbH
         zo8cSb6kpLRImCINfGpKg4z+WdEQplHNdkKboyGuSujtyU0uMNsfY57fcPH1UWhau9Fd
         Shu7uvLZlUpiq9ZwGCIYob4fwG+bDy0LKGMtrewrgHzXKbklUrrT/ipuiQcs9+9TVd1B
         xoQg==
X-Forwarded-Encrypted: i=1; AJvYcCUdhEy+hQFLnCfRSqjb7cZSNkWPy+EQtcEbeHG6pEcuzedsf/7IhBGQq/R4AUl9MuYaqnUFtfDrPU07DNhw+cQ1@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSJwdd/TkMOj5Z0l3QngrGmP0UCUGZArbSYQ+aF8uLMhTJEVo
	6B1FQTWUDsEFUpZrwJ328E3V0AnnJ8Z3FBKRZ77R7se10IO6ofoBEjflR4wrmICTBUoCSSMB368
	J70lzqgRUhNIkq5b9He1THS55fQ==
X-Google-Smtp-Source: AGHT+IGhwhSlHWOdHiYNzV9FksIu24P3urR9RfAnI9PHJHO/oofMWeWBwj21tpDMdRbsZ5qCySgnl+QY1Z9IQMTNWA==
X-Received: from ioyp8.prod.google.com ([2002:a05:6602:3048:b0:948:6160:f5b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:a05:b0:659:9a49:8e64 with SMTP id 006d021491bc7-65b45253071mr1578654eaf.52.1765578344930;
 Fri, 12 Dec 2025 14:25:44 -0800 (PST)
Date: Fri, 12 Dec 2025 22:25:44 +0000
In-Reply-To: <aTidfRwYLYwTfmK_@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 14:06:53 -0800)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntecoz2v87.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 19/24] KVM: arm64: Implement lazy PMU context swaps
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oupton@kernel.org> writes:

> On Tue, Dec 09, 2025 at 08:51:16PM +0000, Colton Lewis wrote:
>> +enum vcpu_pmu_register_access {
>> +	VCPU_PMU_ACCESS_UNSET,
>> +	VCPU_PMU_ACCESS_VIRTUAL,
>> +	VCPU_PMU_ACCESS_PHYSICAL,
>> +};

> This is confusing. Even when the guest is accessing registers directly
> on the CPU I'd still call that "hardware assisted virtualization" and
> not "physical".

It was what I thought described the access pattern. Do you have another
naming suggestion?

>> +#endif /* _ASM_ARM64_KVM_TYPES_H */
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 0ab89c91e19cb..c2cf6b308ec60 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -34,7 +34,7 @@ static int cpu_has_spe(u64 dfr0)
>>    *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
>>    *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
>>    */
>> -static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>> +void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>>   {
>>   	int hpmn = kvm_pmu_hpmn(vcpu);

>> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h  
>> b/arch/arm64/kvm/hyp/include/hyp/switch.h
>> index bde79ec1a1836..ea288a712bb5d 100644
>> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
>> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
>> @@ -963,6 +963,8 @@ static bool kvm_hyp_handle_pmu_regs(struct kvm_vcpu  
>> *vcpu)
>>   	if (ret)
>>   		__kvm_skip_instr(vcpu);

>> +	kvm_pmu_set_physical_access(vcpu);
>> +
>>   	return ret;
>>   }

>> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
>> index 8d0d6d1a0d851..c5767e2ebc651 100644
>> --- a/arch/arm64/kvm/pmu-direct.c
>> +++ b/arch/arm64/kvm/pmu-direct.c
>> @@ -73,6 +73,7 @@ bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
>>   	u8 hpmn = vcpu->kvm->arch.nr_pmu_counters;

>>   	return kvm_vcpu_pmu_is_partitioned(vcpu) &&
>> +		vcpu->arch.pmu.access == VCPU_PMU_ACCESS_PHYSICAL &&
>>   		cpus_have_final_cap(ARM64_HAS_FGT) &&
>>   		(hpmn != 0 || cpus_have_final_cap(ARM64_HAS_HPMN0));
>>   }
>> @@ -92,6 +93,26 @@ u64 kvm_pmu_fgt2_bits(void)
>>   		| HDFGRTR2_EL2_nPMICNTR_EL0;
>>   }

>> +/**
>> + * kvm_pmu_set_physical_access()
>> + * @vcpu: Pointer to vcpu struct
>> + *
>> + * Reconfigure the guest for physical access of PMU hardware if
>> + * allowed. This means reconfiguring mdcr_el2 and loading the vCPU
>> + * state onto hardware.
>> + *
>> + */
>> +
>> +void kvm_pmu_set_physical_access(struct kvm_vcpu *vcpu)
>> +{
>> +	if (kvm_vcpu_pmu_is_partitioned(vcpu)
>> +	    && vcpu->arch.pmu.access == VCPU_PMU_ACCESS_VIRTUAL) {
>> +		vcpu->arch.pmu.access = VCPU_PMU_ACCESS_PHYSICAL;
>> +		kvm_arm_setup_mdcr_el2(vcpu);
>> +		kvm_pmu_load(vcpu);
>> +	}

> It isn't immediately obvious how this guards against preemption.

> Also, the general approach for these context-loading situations is to do
> a full load/put on the vCPU rather than a directed load.

Understood. Will fix.

>> +static void kvm_pmu_register_init(struct kvm_vcpu *vcpu)
>> +{
>> +	if (vcpu->arch.pmu.access == VCPU_PMU_ACCESS_UNSET)
>> +		vcpu->arch.pmu.access = VCPU_PMU_ACCESS_VIRTUAL;

> This is confusing. The zero value of the enum should be consistent with
> the "unloaded" state.

That's the way I initially wrote it but it had a problem on a different
kernel. I forget the exact issue, but I never saw the problem on
upstream so I'm happy to go back to it.

>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index f2ae761625a66..d73218706b834 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1197,6 +1197,8 @@ static bool access_pmu_evtyper(struct kvm_vcpu  
>> *vcpu, struct sys_reg_params *p,
>>   		p->regval = __vcpu_sys_reg(vcpu, reg);
>>   	}

>> +	kvm_pmu_set_physical_access(vcpu);
>> +
>>   	return true;
>>   }

>> @@ -1302,6 +1304,8 @@ static bool access_pmovs(struct kvm_vcpu *vcpu,  
>> struct sys_reg_params *p,
>>   		p->regval = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
>>   	}

>> +	kvm_pmu_set_physical_access(vcpu);
>> +
>>   	return true;
>>   }

> Aren't there a ton of other registers the guest may access before
> these two? Having generic PMU register accessors would allow you to
> manage residence of PMU registers from a single spot.

Yes but these are the only two that use the old trap handlers. I also
call set_physical_access from my fast path handler that handles all the
other registers when partitioned.

Agree on having some generic accessors which you mention in an earlier
patch.
