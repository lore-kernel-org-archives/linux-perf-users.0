Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20B3644CB
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779477849; cv=none; b=cEUh2eobLimDF/JLUbR7jX/Srs7XfrI7FpnepeU8ABGOpz98krlz+w1BBbAcZLfJRgNM910QuPEd7VL9yXFMk0jd5ORRCmbHnegvNqhnVdHzkfnXOedUcJ2zh2AX74Ut1xpUcefRtLOpoqrx6wqmFm5DbfLSe76PV3vLaD4Y3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779477849; c=relaxed/simple;
	bh=khCS3e0FIVXeWeiydzcP28dKqZxmhf0J+NFuMZl6HnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evaG4JA9hbIEKdRFCl9k478FWlAORupDPwAEkIgr7zsh82K1M59MerBKyVoaeDaU6+uv3fEiW7wvW2jH9i+gFQUyXPtGQzYimb/0ijZU38v192vt46iLr3eApcG82rVqWlBV7089inp23Vd/cPnNsZsCfEwNg8l7sPZ/1W2n6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0HWrf5I; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0HWrf5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779477848; x=1811013848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=khCS3e0FIVXeWeiydzcP28dKqZxmhf0J+NFuMZl6HnI=;
  b=A0HWrf5IqN6kr0aRdTMGlr3GeH2tjthD4MKIeXxJWEqWva4NUp0nlFAz
   rpwu/WrxmnQgOe/FoWoIcn+L3sg0DrRYvAGr21IKQa6I54vr5MHdzxylS
   eaSGo6ehjrcEXohi92bUonqBNUR+lQTK1K2Vbr3UFb7DJYxgVbhuv6AFO
   P/+ZK+eped4NnLs9SEksgZ3RLBSm9nKeLS9IjvAKNUP54qOdIUgcaArbt
   0jptIioWTtkaSD2tWbHg9lNmevs1x8mnVfpj+2uJpYQqnBy9cc4y/Ufac
   E24y00EiHUwJoFU7tGXbwCpMBoMRURqAY2sT6ZanOINjLc5HBhVQMmeOA
   A==;
X-CSE-ConnectionGUID: vGHG0Cj2S0irnfeQL+CR4A==
X-CSE-MsgGUID: yOcWVF4PSFWWvmhHS13QSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="90986133"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="90986133"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 12:24:07 -0700
X-CSE-ConnectionGUID: pxJrCQwTSUaWyGlrFWxOTw==
X-CSE-MsgGUID: VjhZ37uKSy+T0mXxMYFL1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="245284085"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 12:24:06 -0700
Message-ID: <abd37e83-82f3-4d39-a3df-3ce76406fdbe@intel.com>
Date: Fri, 22 May 2026 14:24:05 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] perf/x86/intel/uncore: Introduce PMU flags and broken
 state
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260512233048.9577-6-zide.chen@intel.com>
 <20260514042738.80B40C2BCB7@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260514042738.80B40C2BCB7@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/13/2026 11:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] Intentionally leaking `die_refcnt` on PCI box setup failure prevents PMU unregistration, leading to a Use-After-Free.
> - [High] Global `PMU_BROKEN` state disables new event creation and breaks CPU context migration for fully functional dies.
> - [Medium] Confused lifecycle assumptions lead to contradictory error handling and dead code between PCI and MSR/MMIO PMUs.
> - [Medium] Data race between plain store and atomic bitwise operation on `pmu->flags`.
> --
> 
> commit 553c891e098baf8dc3f2b474849cc4642dfe9be6
> Author: Zide Chen <zide.chen@intel.com>
> 
> perf/x86/intel/uncore: Introduce PMU flags and broken state
> 
> This commit replaces the 'registered' field in intel_uncore_pmu with a
> 'flags' field, introducing a PMU_BROKEN flag to track box setup failures.
> If a box fails to initialize, the PMU is marked broken, which rejects new
> event assignments and skips future box setup attempts.
> 
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 617a68c1d76c3..4d31dcaf5405b 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
> 
> [ ... ]
> 
>> @@ -738,7 +738,7 @@ static int uncore_pmu_event_init(struct perf_event *event)
>>  
>>  	pmu = uncore_event_to_pmu(event);
>>  	/* no device found for this pmu */
>> -	if (!pmu->registered)
>> +	if (!uncore_pmu_available(pmu))
>>  		return -ENOENT;
> 
> Since PMU_BROKEN is a global flag across all dies and packages, if one die
> fails initialization, the entire PMU is marked broken. Does this cause
> uncore_pmu_event_init() to incorrectly reject new event assignments on fully
> functional packages?

This is by design. The PMU represents a single logical device spanning
all dies, so if any box fails initialization, the entire PMU is marked
broken to avoid partial and potentially inconsistent monitoring state.
Allowing some dies to remain active while others are broken could lead
to misleading perf data.

> 
> [ ... ]
> 
>> @@ -934,16 +934,16 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
>>  
>>  	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
>>  	if (!ret)
>> -		pmu->registered = true;
>> +		uncore_pmu_set_registered(pmu);
>>  	return ret;
>>  }
>>  
>>  static void uncore_pmu_unregister(struct intel_uncore_pmu *pmu)
>>  {
>> -	if (!pmu->registered)
>> +	if (!uncore_pmu_registered(pmu))
>>  		return;
>>  	perf_pmu_unregister(&pmu->pmu);
>> -	pmu->registered = false;
>> +	WRITE_ONCE(pmu->flags, 0);
> 
> Can this plain store data race with concurrent atomic bitwise operations?
> 
> If uncore_box_setup() executes on another CPU (e.g., probing a new failing
> die while removing a successful die), it uses the atomic read-modify-write
> instruction set_bit(PMU_BROKEN_BIT, &(pmu)->flags). Mixing plain stores and
> atomic bitwise operations on the same memory location could lead to
> clobbered updates.

Actually, I'm thinking the atomic operations are not needed at all. On
the MSR/MMIO side, CPU hotplug callbacks are serialized, so plain bit
operations are safe. For PCI PMUs, the PCI device is per-die, so there
is no way that box_setup() and pmu_unregister() will happen concurrently.

> [ ... ]
> 
>> @@ -1136,7 +1136,13 @@ static int uncore_box_setup(struct intel_uncore_pmu *pmu,
>>  
>>  	/* die_refcnt tracks online dies, not only functioning boxes. */
>>  	dies = atomic_inc_return(&pmu->die_refcnt);
>> -	uncore_box_init(box);
>> +
>> +	if (uncore_pmu_broken(pmu))
>> +		return -ENODEV;
>> +
>> +	ret = uncore_box_init(box);
>> +	if (ret)
>> +		goto err;
>>  
>>  	/* First active box registers the pmu. */
>>  	if (dies > 1)
>> @@ -1148,6 +1154,19 @@ static int uncore_box_setup(struct intel_uncore_pmu *pmu,
>>  
>>  	return 0;
>>  err:
>> +	/*
>> +	 * On failure on any box, mark the per-package PMU as broken regardless
>> +	 * of whether it was registered or not.
>> +	 *
>> +	 * Don't decrement die_refcnt to prevent any future CPU online
>> +	 * event or PCI probe, from retrying the failed PMU registration.
>> +	 *
>> +	 * Don't decrement cpu_refcnt to avoid other in-die CPUs from
>> +	 * trying to set up the PMU box again.
>> +	 *
>> +	 * Don't kfree box; MSR and MMIO boxes are freed at module exit only.
>> +	 */
> 
> Is there a risk of a use-after-free resulting from intentionally leaking
> die_refcnt here?
> 
> For PCI PMUs, the caller uncore_pci_pmu_register() executes kfree(box) on error
> and fails the PCI probe, meaning uncore_pci_remove() is never called to clean
> up this leaked reference.

You are right — in that case, uncore_pci_pmu_unregister() may not be
called if the box is NULL in uncore_pci_remove(). That said, die_refcnt
should be incremented only when pmu->boxes[die] is not NULL, for both
the PCI and MSR/MMIO cases.

In this patch, die_refcnt should be decremented if uncore_box_setup()
fails in the PCI case. There is also a pre-existing bug where die_refcnt
could be unexpectedly decremented via the uncore_bus_notify() path.


> If another successfully probed PCI box for this PMU is later removed,
> uncore_pci_pmu_unregister() decrements die_refcnt, but it will not reach 0 due
> to the earlier leak. Consequently, uncore_pmu_unregister(pmu) is skipped,
> leaving the PMU and its associated perf events active.
> 
> When uncore_pci_pmu_unregister() then frees the successful box, active
> perf_event instances could still hold event->pmu_private pointing to this freed
> box, potentially triggering a use-after-free on subsequent event reads or
> context switches.
> 
> Additionally, this comment claims MSR and MMIO boxes are freed at module exit
> only. Does this conflict with PCI PMUs which unconditionally execute kfree(box)
> on error, immediately destroying the box?

There is no conflicts here.
>> +	uncore_pmu_set_broken(pmu);
>>  	uncore_box_exit(box);
>>  	return ret;
>>  }
> 
> [ ... ]
> 
>> @@ -1483,7 +1502,8 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
>>  
>>  		if (old_cpu < 0) {
>>  			WARN_ON_ONCE(box->cpu != -1);
>> -			if (uncore_die_has_box(type, die, pmu->pmu_idx)) {
>> +			if (uncore_die_has_box(type, die, pmu->pmu_idx) &&
>> +			    !uncore_pmu_broken(pmu)) {
>>  				box->cpu = new_cpu;
>>  				cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
>>  			}
>> @@ -1493,7 +1513,7 @@ static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_cpu,
>>  		WARN_ON_ONCE(box->cpu != -1 && box->cpu != old_cpu);
>>  		box->cpu = -1;
>>  		cpumask_clear_cpu(old_cpu, &pmu->cpu_mask);
>> -		if (new_cpu < 0)
>> +		if (new_cpu < 0 || uncore_pmu_broken(pmu))
>>  			continue;
> 
> If uncore_pmu_broken(pmu) causes this to skip, does this strand active hardware
> events on offlined CPUs for fully functional dies?
> 
> The commit message states the goal is to avoid disrupting in-flight events on
> other boxes, but skipping uncore_pmu_cancel_hrtimer() and
> perf_pmu_migrate_context() here seems to break CPU context migration for those
> events.

You are right, checking the broken flag here could disrupt in-flight
events. Instead, checking box->cpu == -1 is appropriate to skip broken
boxes.

@@ -1522,9 +1522,15 @@ static void uncore_change_type_ctx(struct
intel_uncore_type *type, int old_cpu,
                }

                WARN_ON_ONCE(box->cpu != -1 && box->cpu != old_cpu);

+               if (box->cpu == -1)
+                       continue;
+
                box->cpu = -1;
                cpumask_clear_cpu(old_cpu, &pmu->cpu_mask);
-               if (new_cpu < 0 || uncore_pmu_broken(pmu))
+               if (new_cpu < 0)
                        continue;

>>  
>>  		if (!uncore_die_has_box(type, die, pmu->pmu_idx))
> 
> [ ... ]
> 
>> @@ -1573,7 +1593,7 @@ static int allocate_boxes(struct intel_uncore_type **types,
>>  		type = *types;
>>  		pmu = type->pmus;
>>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>> -			if (pmu->boxes[die])
>> +			if (pmu->boxes[die] || uncore_pmu_broken(pmu))
>>  				continue;
> 
> Is this check dead code? allocate_boxes() is exclusively used by MSR/MMIO
> PMUs, but those PMUs ignore hardware initialization failures and never call
> uncore_pmu_set_broken(pmu).

Not quite true. MSR/MMIO PMUs do not ignore hardware initialization
failures — they call uncore_pmu_set_broken() in uncore_box_setup() when
setup fails.

