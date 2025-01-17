Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692619CC27
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2025 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153636; cv=none; b=Tzu9jJvjYYUMYIZaErX46jnuH3Qmpc8XN7bAEBlgk4V1fjQbelmLYFvyox+T37a+85k9/KckuEkQ0BCsEZYR/PQCVISodNRT9AbuAk9CQMABJsmxcI00s2vyV2r6YnAPesHoE6vYwJeZxXkN3BuSwWrGKCa7piG9LXTJkBLv1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153636; c=relaxed/simple;
	bh=oqjWDgvWXKvb7jk038J0DJ3z5i15MaZ79AtpOnl2TgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ931tx4UBevYQK3NRPY8D28rATGXU5dw/SaCbMr8g81PScCMDB2FTtqOFEEuJi5nk3O/fb39zYfrATbbmw0cjNybLeypC6EsZnrJA8Kg12DwwQqK6shX9kwjWcnyYZDwLfLksR7jUFgfH/AQBiq3dyHa6SdllX507ixE/vwQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHXEfaE3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHXEfaE3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737153632; x=1768689632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oqjWDgvWXKvb7jk038J0DJ3z5i15MaZ79AtpOnl2TgA=;
  b=KHXEfaE3oJJMe5Sc1d7zrMG7icX7qgtoPemGvqd2WShvbGn7SLtdRKPS
   RYakz3er16BNuC/seS4p6ARa229kp3t7YMKDMlzzMwxgRo3C8FVZEA83p
   xq/9mABd1Ve2njdYUiqbdUxxN2MVnBtC7ALmOSvrLktQpm55t+J3xAwwC
   aeM0vP0KtWpGtqXLg95ZK5jn2jP/CyJJThz8c8c347dYM290dU1Yclicm
   Iry4W9ydw38d0SnkB2OnzR0ekW4+uHXqRiQDoUUzlhqRascwSn+kBt1Dm
   rDAdjYyRBetL2V8BiQvlzNvO6yNsvFSVWkOR5blzenvrt29cHAG3y7CHW
   A==;
X-CSE-ConnectionGUID: NqzowrT6TUihqwxG43CGXg==
X-CSE-MsgGUID: SoQbaufVRxCKWfjbtb9Avg==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37482714"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37482714"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 14:40:31 -0800
X-CSE-ConnectionGUID: O9WxfIabQbSzaI5I14Yvjg==
X-CSE-MsgGUID: HI9W+HqITv2ka19VT0kCsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109988934"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.109.191])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 14:40:29 -0800
Date: Fri, 17 Jan 2025 16:40:25 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org, Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Subject: Re: [PATCH v13 7/7] drm/xe/pmu: Add GT C6 events
Message-ID: <4k2afkamwpucxyap3hgklwpgh2p7an5ebdgyqixkyipye6o2ze@y6dext5dg5tb>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
 <20250116230718.82460-8-lucas.demarchi@intel.com>
 <Z4qk8qv1_VyV8W80@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z4qk8qv1_VyV8W80@intel.com>

On Fri, Jan 17, 2025 at 01:44:02PM -0500, Rodrigo Vivi wrote:
>On Thu, Jan 16, 2025 at 03:07:18PM -0800, Lucas De Marchi wrote:
>> From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>>
>> Provide a PMU interface for GT C6 residency counters. The implementation
>> is ported over from the i915 PMU code. Residency is provided in units of
>> ms(like sysfs entry in - /sys/class/drm/card0/device/tile0/gt0/gtidle).
>>
>> Sample usage and output:
>>
>> 	$ perf list | grep gt-c6
>> 	  xe_0000_00_02.0/gt-c6-residency/                   [Kernel PMU event]
>>
>> 	$ tail /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency*
>> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency <==
>> 	event=0x01
>>
>> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency.unit <==
>> 	ms
>>
>> 	$ perf stat -e xe_0000_00_02.0/gt-c6-residency,gt=0/ -I1000
>> 	#           time             counts unit events
>> 	     1.001196056              1,001 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
>> 	     2.005216219              1,003 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
>>
>> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>>
>> Besides the rebase, that changed a lot how the event was added,
>> here is a summary of other changes:
>>
>> - Use xe_pm_runtime_get_if_active() when reading
>>   xe_gt_idle_residency_msec() as there's not guarantee it will not be
>>   suspended anymore by the time it reads the counter
>>
>> - Drop sample[] from the pmu struct and only use the prev/counter from
>>   the perf_event struct. This avoids mixing the counter reported to 2
>>   separate clients.
>>
>> - Drop time ktime helpers and just use what's provided by
>>   include/linux/ktime.h
>>
>>  drivers/gpu/drm/xe/xe_pmu.c | 56 +++++++++++++++++++++++++++++++------
>>  1 file changed, 48 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
>> index c2af82ec3f793..37df9d3cc110c 100644
>> --- a/drivers/gpu/drm/xe/xe_pmu.c
>> +++ b/drivers/gpu/drm/xe/xe_pmu.c
>> @@ -11,6 +11,7 @@
>>  #include "xe_device.h"
>>  #include "xe_force_wake.h"
>>  #include "xe_gt_clock.h"
>> +#include "xe_gt_idle.h"
>>  #include "xe_gt_printk.h"
>>  #include "xe_mmio.h"
>>  #include "xe_macros.h"
>> @@ -117,16 +118,50 @@ static int xe_pmu_event_init(struct perf_event *event)
>>  	return 0;
>>  }
>>
>> -static u64 __xe_pmu_event_read(struct perf_event *event)
>> +static u64 read_gt_c6_residency(struct xe_pmu *pmu, struct xe_gt *gt, u64 prev)
>>  {
>> -	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
>> +	struct xe_device *xe = gt_to_xe(gt);
>> +	unsigned long flags;
>> +	ktime_t t0;
>> +	s64 delta;
>> +
>> +	if (xe_pm_runtime_get_if_active(xe)) {
>> +		u64 val = xe_gt_idle_residency_msec(&gt->gtidle);
>> +
>> +		xe_pm_runtime_put(xe);
>> +
>> +		return val;
>> +	}
>> +
>> +	/*
>> +	 * Estimate the idle residency by looking at the time the device was
>> +	 * suspended: should be good enough as long as the sampling frequency is
>> +	 * 2x or more than the suspend frequency.
>> +	 */
>> +	raw_spin_lock_irqsave(&pmu->lock, flags);
>> +	t0 = pmu->suspend_timestamp[gt->info.id];
>> +	raw_spin_unlock_irqrestore(&pmu->lock, flags);
>
>I believe we should simply avoid the patch 4 and this block and use
>xe_pm_runtime_get(xe) instead of the if_active variant.

downside is that gpu is going to be awaken because we are monitoring it.

>
>I'm afraid this won't be a good estimative since this mix 2 different wakes
>of 2 different IP blocks... the runtime pm is for the entire device, while
>in runtime active the GTs can be sleeping in GT-C6.

in runtime active we can read the counter without making the debug tool
(perf) disrupt the device state. Idea here is that when it's on runtime
pm suspended it also counts as gt-c6 since it's stronger than that.
device suspended implies gt-6, so we count that since suspended.

>
>or did we get some deadlock risk on that scenario?

I don't think there's a deadlock... there's just the undesired behavior
of "when perf is running, the device is never suspended" - and since we
have plans to integrate perf with tools like gputop/qmassa/etc, it means
it will never suspend "when users are looking at it".

It's definitely simpler, if acceptable: "when looking at gt-c6, the
device will never suspend". We can also start with the simpler one and
split the more complex scenario with a patch on top, too.

>perhaps we should get runtime pm in upper layers when using PMU?

we'd need to do it when enabling/disabling the event. It should be
possible, yes. We can't do it on the read call though since we'd need to
make that synchronously.

Lucas De Marchi

>
>> +
>> +	delta = ktime_ms_delta(ktime_get(), t0);
>> +
>> +	return prev + delta;
>> +}
>> +
>> +static u64 __xe_pmu_event_read(struct perf_event *event, u64 prev)
>> +{
>> +	struct xe_pmu *pmu = container_of(event->pmu, typeof(*pmu), base);
>> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
>>  	struct xe_gt *gt = event_to_gt(event);
>> -	u64 val = 0;
>>
>>  	if (!gt)
>> -		return 0;
>> +		return prev;
>> +
>> +	switch (config_to_event_id(event->attr.config)) {
>> +	case XE_PMU_EVENT_GT_C6_RESIDENCY:
>> +		return read_gt_c6_residency(pmu, gt, prev);
>> +	}
>>
>> -	return val;
>> +	return prev;
>>  }
>>
>>  static void xe_pmu_event_update(struct perf_event *event)
>> @@ -136,10 +171,11 @@ static void xe_pmu_event_update(struct perf_event *event)
>>
>>  	prev = local64_read(&hwc->prev_count);
>>  	do {
>> -		new = __xe_pmu_event_read(event);
>> +		new = __xe_pmu_event_read(event, prev);
>>  	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
>>
>> -	local64_add(new - prev, &event->count);
>> +	if (new > prev)
>> +		local64_add(new - prev, &event->count);
>>  }
>>
>>  static void xe_pmu_event_read(struct perf_event *event)
>> @@ -162,7 +198,7 @@ static void xe_pmu_enable(struct perf_event *event)
>>  	 * for all listeners. Even when the event was already enabled and has
>>  	 * an existing non-zero value.
>>  	 */
>> -	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event));
>> +	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event, 0));
>>  }
>>
>>  static void xe_pmu_event_start(struct perf_event *event, int flags)
>> @@ -267,6 +303,10 @@ static const struct attribute_group pmu_events_attr_group = {
>>
>>  static void set_supported_events(struct xe_pmu *pmu)
>>  {
>> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
>> +
>> +	if (!xe->info.skip_guc_pc)
>> +		pmu->supported_events |= BIT_ULL(XE_PMU_EVENT_GT_C6_RESIDENCY);
>>  }
>>
>>  /**
>> --
>> 2.48.0
>>
