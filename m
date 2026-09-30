Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E955013C9
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782137; cv=none; b=OWf8RMEF+nNxQmdqBoHVeBt8Ymh5aKxc9c9W+vJCk4hOjRNbLN0gqsM9/LG8cj9W7XZXPcR2heciCRGex7DKRReHRrYS3rWN6cWHPZRm5stn77TLNEN+4bh/IHdEHgkGakKsPc8WjWSq3oIpIZ1XQVeAO+2NlK6eQ3zEkSJyCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782137; c=relaxed/simple;
	bh=buw7eilKhVYBpVzHXoFXBKSXA87LBruo6Br9DLlJ1Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a98AvDY5hVpxDqzBocMHCKhcCi7H8x1tAaG3cRQy7WScgsUFCISrBaefxVq6cWHl5AITL3pcZkIFT6+ObQOrvSuSPApmo79C75V/4CY7ke5FzV4DU/mtuBMMUhXc7DcgDmEWKBI9Y0bILkShBdezow72wfTTaKjlww1c7Ig0bfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jsiDjkf/; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsiDjkf/"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb91ecaccso2883765a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790782119; x=1791386919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GQ41yj00/XNv9YnqFd8MxyPQ2Or7W/eiTKmLpRiCxws=;
        b=jsiDjkf/cU+nwHRtIWEBcIVKe7nh5e42us7XxZDWebjPwMshfwuiyEc7N5eKph2JJf
         N4LExnNHmGDgULHQ/Mwtp226DIbaJNO70v9ogT4bqLVSI70GD7puhUqRhYGlLkvP4Lrl
         Jv3qp88H6yxry5g/BSzv0GC6IdlYTdRrWEgHAQlyw9OmC22Z4WGVjHTVei4FaGEyYxfh
         kCIv5ij+1fJNqFiH16MJwvvPsK40dIPrCDtv0FDErfR1ekEPmO5UMjba59q9IMuWVni3
         jRGCbmx8CWfr7h9n/1QxLYO5QSHTkwEIcq5V670r1CAg0o4nK/gzC2EKBaZWE3brQNK1
         kKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790782119; x=1791386919;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GQ41yj00/XNv9YnqFd8MxyPQ2Or7W/eiTKmLpRiCxws=;
        b=rkfzmi3Bt3RB/5xQm4zzFYscl64p7/Ip+5MEXMolIBpLLOYCaGmxDL8cOCM7qjWJkU
         zpBJQ4nVDRE6ZGLaob+TTEv/9k4B5ZvMXGRsKyV7Zo01HWzUHR2UbTKJ8g4Ai+LUcWip
         7cazGm34ahom/0Xib5y7VWKciscb5Hd6JUrQuD3HR+Z+abmCAyO6z7KAXn2PHqwn6sgm
         LDtWisQKYg4KuM3j3qrvnSiEZixbM530wAltrxxNG4bfBBbs3LsWbZjlZGt8doz77Sa5
         UNOgifhhAb5MM0RQh/QBN0vjUykpzg1uV0OPDRBdbKhfIb2EZQPWXVFI8Aelp86sDj13
         oBbA==
X-Forwarded-Encrypted: i=1; AKwUvBwGvTzbtpvTVjXBwu+HJl9JtiLQysinOH6bF/r915Criv6WoBoQUVqcWQzEGDKPkTeIVrYdlrOVrnVeH2m65LAJ@vger.kernel.org
X-Gm-Message-State: AFq9FYKvSiPSiuQwjDgLKReu9UnCqyrEvrEack2mBHs2evb0WHoOVFTf
	NG+3S/fOmlxQVCC7PWFkIp9nmmbwYoHXrLl3G0h5GKjnqLWE0jw+TW2gk7AXV3YJNks=
X-Gm-Gg: AYBFou1Qx8dy2Ghzzh/iOHotCSUOjO1uxVtvL3B3JhZSADp/9z2N0zj0OqL9IIn7Iji
	xi2H1Rabp45sNmHjc0ybEoAnYtQC8tcWFoTzsqD91pWz9lqsD6PnOfis6MR4c+UUKJphdbiiyi4
	VU0Mal+wdwWBrjlu9jl3LbsxEsWTRWUIA/moYuykzRo+rbbiOeHVJ+frRwMY+SQ8RO6wsKKK0kI
	HKMztI89GMS4ePdLg7C4WuEyOauOZ1NqRgBgDZL17ZYZEVzScOkcR3jr42v+f4P6o6CHo+kKUy9
	U6DqtzVxNo5xlTqpU6KqdiKYFM3FNgYHEbKZzgEfDANIDX0q3pLIjkr5eUhX2Pw4BWytsaUK3xq
	XexYJH+H0mbfedfxpsxIm/gUnCVct3P2qllmCnwh0ABliN6g3fE3deN8+IDftWVlMIs/Nes3/+i
	Ql8XMpuQCgD1EOZOxBnkV4vjQ+yvEN98BE5X7T8MC8CMRa0KmjQk1lQFDx7JTmXYG1bZMqNPwco
	4Q=
X-Received: by 2002:a05:6402:4543:b0:6ab:bafd:260e with SMTP id 4fb4d7f45d1cf-6ae199672d1mr1029959a12.44.1790782119271;
        Wed, 30 Sep 2026 08:28:39 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae156a2082sm1010321a12.30.2026.09.30.08.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 08:28:38 -0700 (PDT)
Message-ID: <f54b9ea6-48b1-4f6c-92cc-b0a9249c2fb0@linaro.org>
Date: Wed, 30 Sep 2026 16:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/22] KVM: arm64: Apply dynamic guest counter
 reservations
To: Colton Lewis <coltonlewis@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Zide Chen <zide.chen@intel.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Mingwei Zhang <mizhang@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20260924172928.2110956-1-coltonlewis@google.com>
 <20260924172928.2110956-17-coltonlewis@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260924172928.2110956-17-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/09/2026 18:29, Colton Lewis wrote:
> Reserve and release guest PMU counters dynamically during vCPU load and
> put rather than statically at VM creation.
> 
> Add kvm_pmu_set_guest_counters() in arch/arm64/kvm/pmu-direct.c, called
> from kvm_pmu_load() and kvm_pmu_put(). When the requested guest counter
> mask collides with active host events in cpuc->used_mask (or when
> releasing counters after squeezing a host event), invoke
> perf_pmu_resched_update() with kvm_pmu_update_mask() to update the
> per-CPU cpuc->cntr_mask between scheduling host events out and back in;
> otherwise update cpuc->cntr_mask directly with interrupts disabled.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm64/kvm/pmu-direct.c  | 77 ++++++++++++++++++++++++++++++++++++
>   include/linux/perf/arm_pmu.h |  1 +
>   2 files changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index a22c9258c2452..31d5afc44f36e 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c
> @@ -115,6 +115,77 @@ u64 kvm_pmu_direct_pmcr_read(struct kvm_vcpu *vcpu)
>   		ARMV8_PMU_PMCR_N);
>   }
>   
> +/* Callback to update counter mask between perf scheduling */
> +static void kvm_pmu_update_mask(struct pmu *pmu, void *data)
> +{
> +	struct arm_pmu *arm_pmu = to_arm_pmu(pmu);
> +	struct pmu_hw_events *cpuc = this_cpu_ptr(arm_pmu->hw_events);
> +	unsigned long *new_mask = data;
> +
> +	bitmap_copy(cpuc->cntr_mask, new_mask, ARMPMU_MAX_HWEVENTS);
> +}
> +
> +/**
> + * kvm_pmu_set_guest_counters() - Handle dynamic counter reservations
> + * @cpu_pmu: struct arm_pmu to potentially modify
> + * @guest_mask: new guest mask for the pmu
> + *
> + * Check if guest counters will interfere with current host events and
> + * call into perf_pmu_resched_update if a reschedule is required.
> + */
> +static void kvm_pmu_set_guest_counters(struct arm_pmu *cpu_pmu, u64 guest_mask)
> +{
> +	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
> +	DECLARE_BITMAP(guest_bitmap, ARMPMU_MAX_HWEVENTS);
> +	DECLARE_BITMAP(new_mask, ARMPMU_MAX_HWEVENTS);
> +	unsigned long flags;
> +	bool need_resched = false;
> +
> +	bitmap_from_arr64(guest_bitmap, &guest_mask, ARMPMU_MAX_HWEVENTS);
> +	bitmap_copy(new_mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
> +
> +	local_irq_save(flags);
> +	if (guest_mask) {
> +		/* Subtract guest counters from available host mask */
> +		bitmap_andnot(new_mask, new_mask, guest_bitmap, ARMPMU_MAX_HWEVENTS);
> +
> +		/* Did we collide with an active host event? */
> +		if (bitmap_intersects(cpuc->used_mask, guest_bitmap, ARMPMU_MAX_HWEVENTS)) {
> +			int idx;
> +
> +			need_resched = true;
> +			cpuc->host_squeezed = true;
> +
> +			/* Look for pinned events that are about to be preempted */
> +			for_each_set_bit(idx, guest_bitmap, ARMPMU_MAX_HWEVENTS) {
> +				if (test_bit(idx, cpuc->used_mask) && cpuc->events[idx] &&
> +				    cpuc->events[idx]->attr.pinned) {
> +					pr_warn_once("perf: Pinned host event squeezed out by KVM guest PMU partition\n");

If you enable pseudo-NMIs, watchdog_hardlockup_enable() installs the 
watchdog using a pinned PMU event. If host userspace also has a pinned 
event on the mandatory 1 PMU counter assigned to the host, then a guest 
could potentially squeeze out the watchdog.

I'm wondering if we need to prioritise kernel owned events? Or we just 
treat them the same as any other event, and with PMU partitioning assume 
they can't be guaranteed to be running? I feel like you would expect a 
watchdog to be a bit more than best effort though, especially if there 
was always a guaranteed counter available to put it on.

I didn't follow it through completely, but it also looks like if the 
event gets squeezed it would enter an error state and then never be 
re-enabled, even after the guest stops running.

Note, that I think the current ordering means that the watchdog won't 
actually get squeezed out because it's created first. But I don't think 
we can rely on the ordering as a strong guarantee, and it might get 
broken by refactoring in the future.


> +					break;
> +				}
> +			}
> +		}
> +	} else {
> +		/*
> +		 * Restoring to full mask.
> +		 * Only resched if we previously squeezed an event.
> +		 */
> +		if (cpuc->host_squeezed) {
> +			need_resched = true;
> +			cpuc->host_squeezed = false;
> +		}
> +	}
> +	if (!need_resched)
> +		/* Host was never using guest counters anyway */
> +		bitmap_copy(cpuc->cntr_mask, new_mask, ARMPMU_MAX_HWEVENTS);
> +	local_irq_restore(flags);
> +
> +	if (need_resched) {
> +		/* Collision: run full perf reschedule */
> +		perf_pmu_resched_update(&cpu_pmu->pmu, kvm_pmu_update_mask, new_mask);
> +	}
> +}
> +
>   /**
>    * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved counters
>    *
> @@ -255,6 +326,7 @@ static void kvm_pmu_apply_event_filter(struct kvm_vcpu *vcpu)
>    */
>   void kvm_pmu_load(struct kvm_vcpu *vcpu)
>   {
> +	struct arm_pmu *pmu;
>   	unsigned long guest_counters;
>   	u64 mask;
>   	u8 i;
> @@ -269,7 +341,9 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
>   
>   	preempt_disable();
>   
> +	pmu = vcpu->kvm->arch.arm_pmu;
>   	guest_counters = kvm_vcpu_pmu_guest_counter_mask(vcpu);
> +	kvm_pmu_set_guest_counters(pmu, guest_counters);
>   	kvm_pmu_apply_event_filter(vcpu);
>   
>   	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
> @@ -329,6 +403,7 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
>    */
>   void kvm_pmu_put(struct kvm_vcpu *vcpu)
>   {
> +	struct arm_pmu *pmu;
>   	unsigned long guest_counters;
>   	unsigned long flags;
>   	u64 mask;
> @@ -345,6 +420,7 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
>   
>   	preempt_disable();
>   
> +	pmu = vcpu->kvm->arch.arm_pmu;
>   	guest_counters = kvm_vcpu_pmu_guest_counter_mask(vcpu);
>   	mask = guest_counters;
>   
> @@ -395,5 +471,6 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
>   	write_sysreg(val & mask, pmovsclr_el0);
>   	local_irq_restore(flags);
>   
> +	kvm_pmu_set_guest_counters(pmu, 0);
>   	preempt_enable();
>   }
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index be1e345e99a77..45658273ffa86 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -76,6 +76,7 @@ struct pmu_hw_events {
>   
>   	/* Active events requesting branch records */
>   	unsigned int		branch_users;
> +	bool host_squeezed;
>   };
>   
>   enum armpmu_attr_groups {

