Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B5634F48D
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773355174; cv=none; b=cFQ63rffPmgHvwJs0ZytmxtJPxivWSqwFq9ZktBw4UGYASPIKXsvrLtE6HDLlsED1zc+tIGFv91V0zLLPVjNYfDFGTLWP/v5DQ+W9DVH0OOvliQbLia8UFYpZpHklN6qF1kPKS1+CdscXY01dmG3H4LG51F+dDiZ6/FK/lvQ4O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773355174; c=relaxed/simple;
	bh=uK5x8e36cBtKTp4Zgmsqull9lgG1uXg1oR7aeNNQMMc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OtqFFKUdYOyriFQIEmmiz9FXdLArXWBnPEdJs5r4CR5mTAJAKu/iWtL1M9JT4b0qcYIfH0j868G6dgA+JFvp75lHbIgd3/57a1hgFSyzWP5PRyhkUSX1cPhepcAhsEn5hvslVJXVaxX9ZmKF9nlzfsIW+IdyhCOgDDcmHBjd9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khjj+2te; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khjj+2te"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-4172c136f7bso14301813fac.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773355172; x=1773959972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ze4zxD1+bgXLnmCcgE7F5EkAVz6+P8Y6KbhF09qoxxs=;
        b=khjj+2teFVRJeyIcgihIdgsSXT6jvcJlQkB7m8BASj51BmZTbJtUkEwGdi6zhIyfct
         iGn+Qp7zCjP+1ntl/MS1s4j0dmI2TSVT1eTEpSDYTkBTl5dr3kaA0Kt1/yPk3EwKQjh8
         W6ryQLk+T6Jt6c9geONbGrRqhymU4TUwU6puhJ0GJRSKiyKO67r64aWLvFjAb4p/R9Vv
         s4BJUENGeulbFvy1PND0tc1jOF07Yuqezk/OAFgSG8nLWFOffnvqpI4k9KNfdr5pKoVB
         Xn9Yr9PnAvYLJuKPKjqysMxfI5OgLxw3EeslegLuAcP9x9iHX0Yq1+QcfH6SB+BZguRG
         u0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773355172; x=1773959972;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze4zxD1+bgXLnmCcgE7F5EkAVz6+P8Y6KbhF09qoxxs=;
        b=c0v1OP4Jpf3RMCiAgMUnnn7qwxlinkDq3bBrufmiwfsIPN2MwKJJwUFbf4pRFyttMf
         lfkxLLOdizEMQ+YVC3IWbl714WzHat2zb+ici7OKDzSygjB1XWNBQc+B5qFmc1GIELUe
         hDnzN8IKmTz1TopMP+F0+I5kCZ/7r2foi7X9TrLrPHvrFyLnn6hDsm+WW5jWsilBWX+D
         jaEfpq1R5rD/kXRCZBjx+3GGOQUR6mc+KRhcwrn0PP4CKLP6fyDSg/cEb17cBZq0XUJe
         ndeaso5yBSPf6KA+7GFlM2N6mB8KGm6q51GhZGWxVJisUnHYKb4NEI2GoNtiedRhHky8
         WaZg==
X-Forwarded-Encrypted: i=1; AJvYcCU4/LDAsOkGc+FPzFaKsy8k2UzZCyOBkUGtv/JdeVpuShXbILQlLOaXRRfN41ASRPSXHqWF3IFwPIJcae2FUGs0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vNIteOZX5yqCt2r7HWhV6YQui7Y7YiFDFjX0pnAVCoF6jh/L
	bYzeWYP11Wttmwo34u1XfYACSrO/n8aKUIbaXcHd8X2W+Fd238/mc/Yf/wYjxobJvqNWHE2p1QS
	kHGTA/0QmBFTJigzoBDttmGi9xw==
X-Received: from iobdo19.prod.google.com ([2002:a05:6602:4613:b0:95a:608d:8cf8])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:210b:b0:674:911:98fa with SMTP id 006d021491bc7-67bdaa85b4dmr742343eaf.64.1773355171523;
 Thu, 12 Mar 2026 15:39:31 -0700 (PDT)
Date: Thu, 12 Mar 2026 22:39:30 +0000
In-Reply-To: <68a93eb5-24df-4b73-bd1e-798dc32b7e86@linaro.org> (message from
 James Clark on Wed, 11 Mar 2026 12:01:26 +0000)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntbjgsoeot.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v6 11/19] KVM: arm64: Context swap Partitioned PMU guest registers
From: Colton Lewis <coltonlewis@google.com>
To: James Clark <james.clark@linaro.org>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

James Clark <james.clark@linaro.org> writes:

> On 09/02/2026 10:14 pm, Colton Lewis wrote:
>> Save and restore newly untrapped registers that can be directly
>> accessed by the guest when the PMU is partitioned.

>> * PMEVCNTRn_EL0
>> * PMCCNTR_EL0
>> * PMSELR_EL0
>> * PMCR_EL0
>> * PMCNTEN_EL0
>> * PMINTEN_EL1

>> If we know we are not partitioned (that is, using the emulated vPMU),
>> then return immediately. A later patch will make this lazy so the
>> context swaps don't happen unless the guest has accessed the PMU.

>> PMEVTYPER is handled in a following patch since we must apply the KVM
>> event filter before writing values to hardware.

>> PMOVS guest counters are cleared to avoid the possibility of
>> generating spurious interrupts when PMINTEN is written. This is fine
>> because the virtual register for PMOVS is always the canonical value.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>    arch/arm64/kvm/arm.c        |   2 +
>>    arch/arm64/kvm/pmu-direct.c | 123 ++++++++++++++++++++++++++++++++++++
>>    include/kvm/arm_pmu.h       |   4 ++
>>    3 files changed, 129 insertions(+)

>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 620a465248d1b..adbe79264c032 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -635,6 +635,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int  
>> cpu)
>>    		kvm_vcpu_load_vhe(vcpu);
>>    	kvm_arch_vcpu_load_fp(vcpu);
>>    	kvm_vcpu_pmu_restore_guest(vcpu);
>> +	kvm_pmu_load(vcpu);
>>    	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
>>    		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);

>> @@ -676,6 +677,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>>    	kvm_timer_vcpu_put(vcpu);
>>    	kvm_vgic_put(vcpu);
>>    	kvm_vcpu_pmu_restore_host(vcpu);
>> +	kvm_pmu_put(vcpu);
>>    	if (vcpu_has_nv(vcpu))
>>    		kvm_vcpu_put_hw_mmu(vcpu);
>>    	kvm_arm_vmid_clear_active();
>> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
>> index f2e6b1eea8bd6..b07b521543478 100644
>> --- a/arch/arm64/kvm/pmu-direct.c
>> +++ b/arch/arm64/kvm/pmu-direct.c
>> @@ -9,6 +9,7 @@
>>    #include <linux/perf/arm_pmuv3.h>

>>    #include <asm/arm_pmuv3.h>
>> +#include <asm/kvm_emulate.h>

>>    /**
>>     * has_host_pmu_partition_support() - Determine if partitioning is  
>> possible
>> @@ -163,3 +164,125 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)

>>    	return *host_data_ptr(nr_event_counters);
>>    }
>> +
>> +/**
>> + * kvm_pmu_load() - Load untrapped PMU registers
>> + * @vcpu: Pointer to struct kvm_vcpu
>> + *
>> + * Load all untrapped PMU registers from the VCPU into the PCPU. Mask
>> + * to only bits belonging to guest-reserved counters and leave
>> + * host-reserved counters alone in bitmask registers.
>> + */
>> +void kvm_pmu_load(struct kvm_vcpu *vcpu)
>> +{
>> +	struct arm_pmu *pmu;
>> +	unsigned long guest_counters;
>> +	u64 mask;
>> +	u8 i;
>> +	u64 val;
>> +
>> +	/*
>> +	 * If we aren't guest-owned then we know the guest isn't using
>> +	 * the PMU anyway, so no need to bother with the swap.
>> +	 */
>> +	if (!kvm_vcpu_pmu_is_partitioned(vcpu))
>> +		return;
>> +
>> +	preempt_disable();
>> +
>> +	pmu = vcpu->kvm->arch.arm_pmu;
>> +	guest_counters = kvm_pmu_guest_counter_mask(pmu);
>> +
>> +	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
>> +		val = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);
>> +
>> +		write_sysreg(i, pmselr_el0);
>> +		write_sysreg(val, pmxevcntr_el0);

> This needs to have a special case for ARMV8_PMU_CYCLE_IDX because you
> can't use pmxevcntr_el0 to read or write PMCCNTR_EL0:

> D24.5.22:

>     SEL 0b11111      Select the cycle counter, PMCCNTR_EL0:

>                      MRS and MSR of PMXEVCNTR_EL0 are CONSTRAINED
>                      UNPREDICTABLE.

> There are 3 separate instances of the same thing in the patches. I was
> getting undefined instruction errors on my Radxa O6 board until they
> were all fixed.

Looks like it. I had a special case on a previous iteration but someone
suggested I could get rid of it by iterating the mask.

I missed that the cycle counter was CONSTRAINED UNPREDICTABLE.
