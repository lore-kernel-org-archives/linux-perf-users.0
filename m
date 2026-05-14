Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17FD3DEAC0
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749807; cv=none; b=o/F0TQ+dmdDhk/ylblJoT1PZZNKsCmKZ3j6OKGsZgJkpJ7ZVhmtakdLFylwNtx04PuT87VqEF0I5lH/7fK7RhFHVu3ERPLdJGE9Mz7XuPL7NxrjO25juqcvPHlFcOzC6Aca7tbcQr9UKhoRO0U6cRoh8XaZcyDWCG2gEpfp32jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749807; c=relaxed/simple;
	bh=C3Lb5cvFAMNlyCIVl8ipWcR3gjPB2vdBwhDFk2jz4H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIVdIIU+0Kwkva63F2xXif2AqDQmvMIB4h5YoEvfVWHqFGrW+QeU4haZkXdHvJ81+33iJMFf00Flqs7sAJETHRXQhS4ZSsZ3ExXaMjsOq8MqCx9G95hGMzgoKpOoqdD7jeNO8cK1KmFW7T3wSAqgsrp5Kg3hhqFqO5aLXQHrjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUaaeNab; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUaaeNab"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so128513055e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778749804; x=1779354604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zJBoYCXvN5LO7DBit1Ku7VesIuEtdWFZWxNt6CCQH0=;
        b=NUaaeNab7oLY0hdE+In7wT4Mp52ctILg34IevAQUIqU+F5Bn5Kp2Y5M8YFecG+dywY
         OHQuIdMqUpv3MTgXjrCcTxBwgl92Z4G7XKUFkRxUFrdhsahSDqixjTDjbDboOOwy0Fzu
         0/Ld+P7GUDmBnQGRO6L0x3yNE8oBcqB/iJ9+c+EWt5E3a1ROGvmyYLekT3YTbw7kt8d6
         S1H4gQdfZiA17GOBdeVJYRyBVYam19M3PBXSDwzBc11fPdBQPbsHd+ytklHMoalPGEQo
         gdgOoBZt7FCpoAVjhfKrgu1/nwolVDgoExTNfgxcgkBA4m81UIcyuzXkSHVo2gFvW9mV
         faSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778749804; x=1779354604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zJBoYCXvN5LO7DBit1Ku7VesIuEtdWFZWxNt6CCQH0=;
        b=TCOqcA216koM+ODlys+zdnQv2AzDoEifetaYV4cofjKOTT3ycLYtFU71J/cp+fHUFS
         bCVG6GP0KcLDzG/Ja1KSASXYTmVsOnxxm4adJPl18vuZpXxu6+4c4Qs9YYa9AHC/UIcj
         ZK78OQZxqZINtssewXRPn8T6PS2Wv8KxE2QMWfUxlbHLieFIesPLisx277SP5gJBohLL
         VCZpDkNbz1z1ohrqn1V//wc6yTxxf5M2nsDQRvWcSnF6CObwlnSvys9+WeQZhZLaQdJ6
         5KVRdnP8jsyB1O/FM1I+WKr5cjCxEeEpLkTIZGgDZ44EMaa2UocrX+P3oxmlJ7zrhvOn
         1Cvw==
X-Forwarded-Encrypted: i=1; AFNElJ/Gk+yPehOa2/h0CR5x2KErCqTLTVwU+fFwfI2+7vw27dVag6N74EAN9ohNQcxlbbLAwr4AwEYnFrHtGdsN5NCb@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdVKpNE5DUYh/MYI+uI80uuY1pZiwL+CtRhyH7pr8jRTmiWGr
	QwQ8UpN81Dh7FLfnGlZufCDIghwUGY1+jPphsfA5XTTQ63jRbMbitM/tyO48m8A8hsA=
X-Gm-Gg: Acq92OEAB0HjN1TGzGW3qEP5mZHwrUwsqz0qHSE18WHi4Dg9cSkH8lPnlckfNBQcbxT
	BpwTV6M1xt+FQAWuNaDreWJLOK/YNN7Z71TODsnUqAAxe4TDOK54CHJUk1R/pnLGvIpVZRWDQUD
	7KPMxv0vzf4aaSEWSV2g5937wE1yBIRSmx1AJ76DH8ClVLfbd+BPHHc6wND/EJDnaHg0/fZwKpu
	w7jSlTtIHjTuaASWYm3Soohqs4GeY+V7rz41PWnIeDNRH5IAdQKV3RTrRZxgapuyHQH90QTuDfM
	69SNLhwNjmqB/Kdqa/AcR4FMM2JQqvEfV3gHEMRlHP6wX4svIftDs9VhIKAxhBsSQqS0DkJdaSK
	gV2ASnA9XDzaL/MMdYhA+Ao091pYimwbUp7CpsVvaKVx9GB9hELh/ZxcMw/RK2AtHqZP6Kyj9WU
	uIC7y5Hdv8+C3mvgVbZantvKao43Pr
X-Received: by 2002:a05:600c:19d1:b0:48e:8499:4be0 with SMTP id 5b1f17b1804b1-48fdc714b8amr23783895e9.15.1778749804059;
        Thu, 14 May 2026 02:10:04 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb2788eesm34097965e9.7.2026.05.14.02.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 02:10:03 -0700 (PDT)
Message-ID: <66797cb2-18f7-4782-9370-68d0c10c35f4@linaro.org>
Date: Thu, 14 May 2026 10:10:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/20] KVM: arm64: Apply dynamic guest counter
 reservations
To: Colton Lewis <coltonlewis@google.com>
Cc: alexandru.elisei@arm.com, pbonzini@redhat.com, corbet@lwn.net,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org
References: <gsntzf23b6m2.fsf@coltonlewis-kvm.c.googlers.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <gsntzf23b6m2.fsf@coltonlewis-kvm.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/05/2026 5:45 pm, Colton Lewis wrote:
> James Clark <james.clark@linaro.org> writes:
> 
>> On 04/05/2026 10:18 pm, Colton Lewis wrote:
>>> Apply dynamic guest counter reservations by checking if the requested
>>> guest mask collides with any events the host has scheduled and calling
>>> pmu_perf_resched_update() with a hook that updates the mask of
>>> available counters in between schedule out and schedule in.
> 
>>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>>> ---
>>>    arch/arm64/kvm/pmu-direct.c  | 69 ++++++++++++++++++++++++++++++++ 
>>> ++++
>>>    include/linux/perf/arm_pmu.h |  1 +
>>>    2 files changed, 70 insertions(+)
> 
>>> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
>>> index 2252d3b905db9..14cc419dbafad 100644
>>> --- a/arch/arm64/kvm/pmu-direct.c
>>> +++ b/arch/arm64/kvm/pmu-direct.c
>>> @@ -100,6 +100,73 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
>>>        return *host_data_ptr(nr_event_counters);
>>>    }
> 
>>> +/* Callback to update counter mask between perf scheduling */
>>> +static void kvm_pmu_update_mask(struct pmu *pmu, void *data)
>>> +{
>>> +    struct arm_pmu *arm_pmu = to_arm_pmu(pmu);
>>> +    unsigned long *new_mask = data;
>>> +
>>> +    bitmap_copy(arm_pmu->cntr_mask, new_mask, ARMPMU_MAX_HWEVENTS);
>>> +}
>>> +
>>> +/**
>>> + * kvm_pmu_set_guest_counters() - Handle dynamic counter reservations
>>> + * @cpu_pmu: struct arm_pmu to potentially modify
>>> + * @guest_mask: new guest mask for the pmu
>>> + *
>>> + * Check if guest counters will interfere with current host events and
>>> + * call into perf_pmu_resched_update if a reschedule is required.
>>> + */
>>> +static void kvm_pmu_set_guest_counters(struct arm_pmu *cpu_pmu, u64 
>>> guest_mask)
>>> +{
>>> +    struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
>>> +    DECLARE_BITMAP(guest_bitmap, ARMPMU_MAX_HWEVENTS);
>>> +    DECLARE_BITMAP(new_mask, ARMPMU_MAX_HWEVENTS);
>>> +    bool need_resched = false;
>>> +
>>> +    bitmap_from_arr64(guest_bitmap, &guest_mask, ARMPMU_MAX_HWEVENTS);
>>> +    bitmap_copy(new_mask, cpu_pmu->hw_cntr_mask, ARMPMU_MAX_HWEVENTS);
>>> +
>>> +    if (guest_mask) {
>>> +        /* Subtract guest counters from available host mask */
>>> +        bitmap_andnot(new_mask, new_mask, guest_bitmap, 
>>> ARMPMU_MAX_HWEVENTS);
>>> +
>>> +        /* Did we collide with an active host event? */
>>> +        if (bitmap_intersects(cpuc->used_mask, guest_bitmap, 
>>> ARMPMU_MAX_HWEVENTS)) {
>>> +            int idx;
>>> +
>>> +            need_resched = true;
>>> +            cpuc->host_squeezed = true;
>>> +
>>> +            /* Look for pinned events that are about to be preempted */
>>> +            for_each_set_bit(idx, guest_bitmap, ARMPMU_MAX_HWEVENTS) {
>>> +                if (test_bit(idx, cpuc->used_mask) && cpuc- 
>>> >events[idx] &&
>>> +                    cpuc->events[idx]->attr.pinned) {
>>> +                    pr_warn_ratelimited("perf: Pinned host event 
>>> squeezed out by KVM guest PMU partition\n");
> 
>> Hi Colton,
> 
>> I get "perf: Pinned host event squeezed out by KVM guest PMU partition"
>> even with arm_pmuv3.reserved_host_counters=3 for example. I would have
>> expected any non zero value to stop the warning.
> 
>> I think armv8pmu_get_single_idx() needs to be changed to allocate from
>> the high end host counters first. A more complicated option would be
>> checking to see if there are any non-pinned counters in the host
>> reserved half when a new pinned counter is opened, then swapping the
>> places of the new pinned and existing non-pinned counters so pinned
>> always prefer being put into the host half. But it's probably not worth
>> doing that.
> 
>> James
> 
> 
> I agree it makes the most sense to allocate from the top, but I'm happy
> the basic idea works.
> 

Another thing I forgot to mention is that even with the ratelimited 
warning, this spams the logs any time the host and guest are both using 
the PMU and I'm not sure how useful that is.

>>> +                    break;
>>> +                }
>>> +            }
>>> +        }
>>> +    } else {
>>> +        /*
>>> +         * Restoring to hw_cntr_mask.
>>> +         * Only resched if we previously squeezed an event.
>>> +         */
>>> +        if (cpuc->host_squeezed) {
>>> +            need_resched = true;
>>> +            cpuc->host_squeezed = false;
>>> +        }
>>> +    }
>>> +
>>> +    if (need_resched) {
>>> +        /* Collision: run full perf reschedule */
>>> +        perf_pmu_resched_update(&cpu_pmu->pmu, kvm_pmu_update_mask, 
>>> new_mask);
>>> +    } else {
>>> +        /* Host was never using guest counters anyway */
>>> +        bitmap_copy(cpu_pmu->cntr_mask, new_mask, ARMPMU_MAX_HWEVENTS);
>>> +    }
>>> +}
>>> +
>>>    /**
>>>     * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved 
>>> counters
>>>     * @pmu: Pointer to arm_pmu struct
>>> @@ -218,6 +285,7 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
> 
>>>        pmu = vcpu->kvm->arch.arm_pmu;
>>>        guest_counters = kvm_pmu_guest_counter_mask(pmu);
>>> +    kvm_pmu_set_guest_counters(pmu, guest_counters);
>>>        kvm_pmu_apply_event_filter(vcpu);
> 
>>>        for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
>>> @@ -319,5 +387,6 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
>>>        val = read_sysreg(pmintenset_el1);
>>>        __vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
> 
>>> +    kvm_pmu_set_guest_counters(pmu, 0);
>>>        preempt_enable();
>>>    }
>>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>>> index f7b000bb3eca8..63f88fec5e80f 100644
>>> --- a/include/linux/perf/arm_pmu.h
>>> +++ b/include/linux/perf/arm_pmu.h
>>> @@ -75,6 +75,7 @@ struct pmu_hw_events {
> 
>>>        /* Active events requesting branch records */
>>>        unsigned int        branch_users;
>>> +    bool host_squeezed;
>>>    };
> 
>>>    enum armpmu_attr_groups {

