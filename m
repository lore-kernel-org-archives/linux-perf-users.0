Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69543F0B5
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675110; cv=none; b=oez9xbhSAGUDK3bqACGQt15VRCFNGaMLYmNLltUOQIdMLgWroHk3xhRXyMhCjB1jHmKSMWqVS7LEN9V2cXCHx9NgT9etNfCPhyLJIB6wTVKrIU2l0bSlyevBk4xBeY0m4cb5yEfJ+WnjRmhiFEdnKU9IDvb8AcQHEGLmxx0H/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675110; c=relaxed/simple;
	bh=/d5+Ct9ll6b1HxibJ3keb46nwT+WlmFOnNHUX+rzbEg=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=NBP9BySBnfv2udzbE27m5uZGMHZ5Ac5hvLfQZd3QynzMpZ0lUwqFdg7CJ4pZEBLSZMArD8eSpQqR0TwKcP5lM+PuD2w3j2BcPVkzWWdLktL63y+LFe4zDpxVTTp8KZYGVTGvQk4H63XupBWR/+qPtByYNS5XOt9+BmPLthmIeys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5IQ0mI5; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5IQ0mI5"
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4909b046dabso18926690b6e.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 16:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675107; x=1785279907; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QYXaYDgqkJqtd2+svQngfiSlGiL9bXTJTobnSbO9Md4=;
        b=i5IQ0mI5ow3rt/MdeDTWnA4Jx4dvXGk7jJGPB76OJ7HSEZW4Mfe0B/Df9RWAp/S07y
         fz1hcFzcFyP/dupBfHHr0y0VYp9eUjZamCzE31wgD5UNMOiHrQNP+o9ocmD9sK1u6pJB
         vC2mYinL1x5TIVDtctyIOOvozhJ2omAhZrnRZUEtw4sOhlFfOJ95JgU8hKJappQ7hvR8
         9Cod5hXVLHmcaaU87et6NjC2nzd936rvkkcFZe9uIF+mkoLl82rxVyVIAvX5wsjxU5TZ
         cVvzS5umgy9cEvNoAboaNDXfaUYkOxfUSTBlKi2GZiXxLT4RCp5zZ9WpHG2HY8j18NE4
         RiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675107; x=1785279907;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYXaYDgqkJqtd2+svQngfiSlGiL9bXTJTobnSbO9Md4=;
        b=QdLeiEJjrLMK9YlP4CGy6NJbx8+ssRfEOhhQR4gYGXxeY4vmAIFk5CJsRQrGf1aEnE
         cg8Bh4hyWvrz7ZxyygmtKm0SnMD09WF4jisoYmbhmBhwn5jHi4wdQkFb12g6VWJp6Jp0
         Lm/GdMEjBWYxU/88XvbQLsER92h3F6byHE05SSsEZCzxwIHb5LJRPhYKiaqAB+2NYti1
         P/TCL6DXPevw0wjYpuSach315dTn1qVmdEeCP9G+NtM3oKxJxgCNqQWF077VCc13kc4M
         2MZdGeyZy9ML6WY4Zzmg91oKRIPM3m6zROCpTS/mdr3rQuyQR6rI+tVjfcYa0ucgM+Zr
         eWaA==
X-Forwarded-Encrypted: i=1; AHgh+RpHgmvCU158x7ZsCExvnWw0uHntkxhDCIevV/jQ1nVZloh46PHMclbKDN9yOnS6RAeBQEKAkLCST36RTTII6ma5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3xcvzDf2trL/ILSmKMAFQnu6TuV3j0RbD4vG4fOkaXBjtjIUG
	6pQR9RtMlyDy3jNxgEpCoOy4b/OxkilpmBaV3Vg9BTrZuxEItuEhH86fYTY/xdIo1WDcz6ZCmrW
	xDXiUzbUHm0u3bj/thXzlTu/CWw==
X-Received: from iowx7.prod.google.com ([2002:a05:6602:1607:b0:9a8:4cf8:3078])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1719:b0:495:f230:a340 with SMTP id 5614622812f47-4a4d049ce3emr10719954b6e.28.1784675106606;
 Tue, 21 Jul 2026 16:05:06 -0700 (PDT)
Date: Tue, 21 Jul 2026 23:05:06 +0000
In-Reply-To: <3fc867c3-67a0-4fdd-b871-f2ba4d642f1f@linaro.org> (message from
 James Clark on Mon, 20 Jul 2026 17:46:37 +0100)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt8q7454gt.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 11/21] KVM: arm64: Context swap Partitioned PMU guest registers
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

> On 12/06/2026 20:28, Colton Lewis wrote:
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
>>    arch/arm/include/asm/arm_pmuv3.h |   4 +
>>    arch/arm64/kvm/arm.c             |   2 +
>>    arch/arm64/kvm/pmu-direct.c      | 183 +++++++++++++++++++++++++++++++
>>    include/kvm/arm_pmu.h            |  16 +++
>>    4 files changed, 205 insertions(+)


> [...]

>> +
>> +/**
>> + * kvm_pmu_put() - Put untrapped PMU registers
>> + * @vcpu: Pointer to struct kvm_vcpu
>> + *
>> + * Put all untrapped PMU registers from the VCPU into the PCPU. Mask
>> + * to only bits belonging to guest-reserved counters and leave
>> + * host-reserved counters alone in bitmask registers.
>> + */
>> +void kvm_pmu_put(struct kvm_vcpu *vcpu)
>> +{
>> +	struct arm_pmu *pmu;
>> +	unsigned long guest_counters;
>> +	unsigned long flags;
>> +	u64 mask;
>> +	u8 i;
>> +	u64 val;
>> +
>> +	/*
>> +	 * If we aren't guest-owned then we know the guest is not
>> +	 * accessing the PMU anyway, so no need to bother with the
>> +	 * swap.
>> +	 */
>> +	if (!kvm_pmu_is_partitioned(vcpu->kvm))
>> +		return;
>> +
>> +	preempt_disable();
>> +
>> +	pmu = vcpu->kvm->arch.arm_pmu;
>> +	guest_counters = kvm_pmu_guest_counter_mask(pmu);
>> +
>> +	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
>> +		if (i == ARMV8_PMU_CYCLE_IDX)
>> +			val = read_pmccntr();
>> +		else
>> +			val = read_pmevcntrn(i);
>> +
>> +		__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + i, val);
>> +	}
>> +
>> +	val = read_sysreg(pmselr_el0);
>> +	__vcpu_assign_sys_reg(vcpu, PMSELR_EL0, val);
>> +
>> +	val = read_sysreg(pmcr_el0);
>> +	__vcpu_assign_sys_reg(vcpu, PMCR_EL0, val);
>> +
>> +	/* Mask these to only save the guest relevant bits. */
>> +	mask = kvm_pmu_guest_counter_mask(pmu);
>> +
>> +	val = read_sysreg(pmcntenset_el0);
>> +	__vcpu_assign_sys_reg(vcpu, PMCNTENSET_EL0, val & mask);
>> +
>> +	val = read_sysreg(pmintenset_el1);
>> +	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
>> +
>> +	/* Save pending guest hardware overflows. */
>> +	local_irq_save(flags);
>> +	val = read_sysreg(pmovsset_el0);
>> +	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, val & mask);
>> +	write_sysreg(val & mask, pmovsclr_el0);
>> +	local_irq_restore(flags);
>> +
>> +	/* Stop guest counters and disable interrupts in hardware. */
>> +	write_sysreg(mask, pmcntenclr_el0);
>> +	write_sysreg(mask, pmintenclr_el1);
>> +
>> +	kvm_pmu_set_guest_counters(pmu, 0);

> Hi Colton,

> This function doesn't get added until "KVM: arm64: Apply dynamic guest
> counter reservations" a few commits later.

> kvm_pmu_guest_counter_mask() is also used in a commit before it's added.

My bad. I'll correct that.
