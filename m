Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D9193077;
	Wed, 28 May 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443875; cv=none; b=RKG3nf10h4pfJL8qNB4LRx2XI4uYkxc7ZKodSwBlqIcMMDErzVP+EF8ornQpNLGmOdqZVv3iq+gEpdZrZl+BdfiJ904HfQWPZjlP4PNdDuYWFtTdrs3GE3kcybqmauOT8r2M1E7YUpO5m6DxqDHrL9DLms2e0AaKM+tMu+/sjyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443875; c=relaxed/simple;
	bh=9T3VdjKsbwgRUKbVfMomhv/3y3RaeBPwP61+a85Jvu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4l9WAYf9YkFs5I3LU6Bk+QQOzojlyG87hAWz2L9H8ZxZI3sgevEn9ve6PJrxNiE2qUeZXW2GaxB4i6Pm7q2sQuCgUJVimr6lns5wp8ub7zZHVMWw52CV6qotcphM/igZc/treLOzzgR9cwYLRdyA0Q7t/F0CTY7QPqmMjkYwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOHPwUen; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOHPwUen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748443873; x=1779979873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9T3VdjKsbwgRUKbVfMomhv/3y3RaeBPwP61+a85Jvu0=;
  b=BOHPwUenJjAtttr2XY4G9HiHniEW/2ueyq8nv/l2h85zeZyUj71UxJbX
   zF3pu6Xc0nOxmvz7n6eG0p8NczuzNySBZ/XKly5EjaJKhtXdDm8oq1rq7
   bYWGrD+3zeCywquTHn9PXMsHWcjXvT9GkYTEMfIESaVKc/PLna08uSLE9
   US3y7kYAHS3TWLO1nG2MMmXwFCwZ8uDZ/ydXR1zexplI6vfRIl5w+nqDl
   mOUGH85nk74djV4GefrqDZtATqFD/66EHY7kwsv3GIe+AFm8CY+6lk8yR
   p3mtez1JI6yTwn/LZ+j6A5ZYXynhR2XvBUYP8BwY6/fcyVxL8rWq7apdS
   A==;
X-CSE-ConnectionGUID: NejjY1QiRfWmUpjuXuGReQ==
X-CSE-MsgGUID: hfgS80IFT7ixfmVxbvp+RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50173643"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="50173643"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:51:13 -0700
X-CSE-ConnectionGUID: OcoufsNVTBaBWLFswdGitQ==
X-CSE-MsgGUID: bIti5BAFR4+073oJMosWhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="144235207"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:51:13 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E839620B5736;
	Wed, 28 May 2025 07:51:11 -0700 (PDT)
Message-ID: <ef09af0b-f6d4-4d41-b658-93c9b72485ce@linux.intel.com>
Date: Wed, 28 May 2025 10:51:10 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 01/16] perf: Fix the throttle logic for a group
To: Leo Yan <leo.yan@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, Aishwarya.TCV@arm.com
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-2-kan.liang@linux.intel.com>
 <20250527161656.GJ2566836@e132581.arm.com>
 <44e1c864-a6e1-41a8-9f11-0ea25999131c@linux.intel.com>
 <20250528102801.GK2566836@e132581.arm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250528102801.GK2566836@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-28 6:28 a.m., Leo Yan wrote:
> On Tue, May 27, 2025 at 03:30:06PM -0400, Liang, Kan wrote:
> 
> [...]
> 
>> There may be two ways to fix it.
>> - Add a check of MAX_INTERRUPTS in the event_stop. Return immediately if
>> the stop is invoked by the throttle.
>> - Introduce a PMU flag to track the case. Avoid the event_stop in
>> perf_event_throttle() if the flag is detected.
>>
>> The latter looks more generic. It may be used if there are other cases
>> that want to avoid the stop. So the latter is implemented as below.
> 
> Yes.  I agreed the fix below is more general and confirmed it can fix
> the observed issue.
> 
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 947ad12dfdbe..66f02f46595c 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -303,6 +303,7 @@ struct perf_event_pmu_context;
>>  #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
>>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>>  #define PERF_PMU_CAP_AUX_PAUSE			0x0200
>> +#define PERF_PMU_CAP_NO_THROTTLE_STOP		0x0400
>>
>>  /**
>>   * pmu::scope
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 8327ab0ee641..596597886d96 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2655,7 +2655,8 @@ static void perf_event_unthrottle(struct
>> perf_event *event, bool start)
>>
>>  static void perf_event_throttle(struct perf_event *event)
>>  {
>> -	event->pmu->stop(event, 0);
>> +	if (!(event->pmu->capabilities & PERF_PMU_CAP_NO_THROTTLE_STOP))
>> +		event->pmu->stop(event, 0);
> 
> A background info is that even a PMU event is not stopped when
> throttling, we still need to re-enable it.  This is why we don't do
> particualy handling for PERF_PMU_CAP_NO_THROTTLE_STOP in
> perf_event_unthrottle().
> 
> Maybe it is deserved add a comment for easier understanding.

Sure. A formal patch has been sent. Please take a look.
https://lore.kernel.org/lkml/20250528144823.2996185-1-kan.liang@linux.intel.com/

Thanks,
Kan>
> Thanks,
> Leo
> 
>>  	event->hw.interrupts = MAX_INTERRUPTS;
>>  	perf_log_throttle(event, 0);
>>  }
>> @@ -11846,7 +11847,8 @@ static int cpu_clock_event_init(struct
>> perf_event *event)
>>  static struct pmu perf_cpu_clock = {
>>  	.task_ctx_nr	= perf_sw_context,
>>
>> -	.capabilities	= PERF_PMU_CAP_NO_NMI,
>> +	.capabilities	= PERF_PMU_CAP_NO_NMI |
>> +			  PERF_PMU_CAP_NO_THROTTLE_STOP,
>>  	.dev		= PMU_NULL_DEV,
>>
>>  	.event_init	= cpu_clock_event_init,
>> @@ -11928,7 +11930,8 @@ static int task_clock_event_init(struct
>> perf_event *event)
>>  static struct pmu perf_task_clock = {
>>  	.task_ctx_nr	= perf_sw_context,
>>
>> -	.capabilities	= PERF_PMU_CAP_NO_NMI,
>> +	.capabilities	= PERF_PMU_CAP_NO_NMI |
>> +			  PERF_PMU_CAP_NO_THROTTLE_STOP,
>>  	.dev		= PMU_NULL_DEV,
>>
>>  	.event_init	= task_clock_event_init,
>>
>>
>> Thanks,
>> Kan
>>
>>
> 

