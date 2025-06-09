Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5F8F5B;
	Mon,  9 Jun 2025 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476902; cv=none; b=HMHkRAYnrnkq9gREWwbKCUUDlUy/+yj0HTAZWICT3KnT/9NzeR6Rxp1bjEZu0P1ZFGwgRDzqqUkMtgIh3H/4JvXdzOSmaeVMjBxPthAMcjmMl7N/ByDHCBiupGatrO4bkwAX/gqBfwa6XoKCxxnp3xmEB57kedjg7Yx5uPjCpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476902; c=relaxed/simple;
	bh=Uyl90jfwRQVimqrcV7W2azhKm+fr0rX7C6zbBqrg2LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcrUwa/LP1yJdVslqhi6nK3vdPSCi2CDVGRmLo3tx+0vJ4gmSuM1mIMJJ6V9EVdszXM7ZS8bO+9zJduuqmt1nIf0MwmUjnIh3Nh2NB/ERAgv6jTnczdABIRE78Nsh1CTHTAuKxeM9X4n9dpCZJwJ+UIJ/A+irH6HNev2Jg6gqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUhhYT4L; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUhhYT4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749476901; x=1781012901;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Uyl90jfwRQVimqrcV7W2azhKm+fr0rX7C6zbBqrg2LU=;
  b=dUhhYT4LjV+ZopC9H2+sid5smeSjskicR+sWL/ZM0Rjr9Pktd+gOOjP9
   Qg3WUk1YsgYD/vKY/YiK7tCn2BPCx/uKoAbypl3F17P8CbL/t4p/pH43m
   vU6LKFx+JAjLBoLP8lXbeGyKfPFUQKeiGAUkhp75vutX5XcZmzNfy9sRn
   s4SnneeXtqCmi5ZnDDPiT19d3x56T0dvfqV220TA8SK6I0gFWtJLRl6NC
   /dbDdVd7MCxqROu82KSJUOBMTNegIehBMKZfnZkTLGkan84/T7YYoz06U
   LxscqiEEAAwJGm8e2Saj4gj/iS+/JQhMXpAHJEvSlehe0nY2ee1Xz7oV3
   w==;
X-CSE-ConnectionGUID: p97X6TylTEuu+Hj29O551w==
X-CSE-MsgGUID: cUbGmKZ7SnCTxB0xDZ7b9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="74086558"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="74086558"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 06:48:21 -0700
X-CSE-ConnectionGUID: Y+onT+SiSdefCq3yr5Eseg==
X-CSE-MsgGUID: lVMjoshyQFuwsY1KB64eTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="150349323"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 06:48:19 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A5B7020B5736;
	Mon,  9 Jun 2025 06:48:14 -0700 (PDT)
Message-ID: <e763b0bd-cb51-4a76-816d-e12e59b02214@linux.intel.com>
Date: Mon, 9 Jun 2025 09:48:12 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] perf: Fix the throttle error of some clock events
To: Leo Yan <leo.yan@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, Aishwarya TCV <aishwarya.tcv@arm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <20250606192546.915765-1-kan.liang@linux.intel.com>
 <20250609123415.GJ8020@e132581.arm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250609123415.GJ8020@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-09 8:34 a.m., Leo Yan wrote:
> Hi Kan,
> 
> On Fri, Jun 06, 2025 at 12:25:46PM -0700, kan.liang@linux.intel.com wrote:
> 
> [...]
> 
>> There may be two ways to fix it.
>> - Introduce a PMU flag to track the case. Avoid the event_stop in
>>   perf_event_throttle() if the flag is detected.
>>   It has been implemented in the
>>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
>>   The new flag was thought to be an overkill for the issue.
>> - Add a check in the event_stop. Return immediately if the throttle is
>>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
>>   method to stop the timer.
>>
>> The latter is implemented here.
>>
>> Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
>> the order the same as perf_event_unthrottle(). Except the patch, no one
>> checks the hw.interrupts in the stop(). There is no impact from the
>> order change.
>>
>> When stops in the throttle, the event should not be updated,
>> stop(event, 0).
> 
> I am confused for this conclusion. When a CPU or task clock event is
> stopped by throttling, should it also be updated? Otherwise, we will
> lose accouting for the period prior to the throttling.
> 
> I saw you exchanged with Alexei for a soft lockup issue, the reply [1]
> shows that skipping event update on throttling does not help to
> resolve the lockup issue.
> 
> Could you elaberate why we don't need to update clock events when
> throttling?
> 

This is to follow the existing behavior before the throttling fix*.
When throttling is triggered, the stop(event, 0); will be invoked.
As my understanding, it's because the period is not changed with
throttling. So we don't need to update the period.

But if the period is changed, the update is required. You may find an
example in the perf_adjust_freq_unthr_events(). In the freq mode,
stop(event, PERF_EF_UPDATE) is actually invoked for the triggered event.

For the clock event, the existing behavior before the throttling fix* is
not to invoke the stop() in throttling. It relies on the
HRTIMER_NORESTART instead. My previous throttling fix changes the
behavior. It invokes both stop() and HRTIMER_NORESTART. Now, this patch
change the behavior back.

Regarding the soft lockup issue, it's a different issue in
virtualization. It should be an old issue which is not introduced by my
throttling fix.

Thanks,
Kan

* The throttling fix is 9734e25fbf5a ("perf: Fix the throttle logic for
a group")


> Thanks,
> Leo
> 
> [1] https://lore.kernel.org/linux-perf-users/CAADnVQKRJKsG08KkEriuBQop0LgDr+c9rkNE6MUh_n3rzZoXVQ@mail.gmail.com/
> 
>> But the cpu_clock_event_stop() doesn't handle the flag.
>> In logic, it's wrong. But it didn't bring any problems with the old
>> code, because the stop() was not invoked when handling the throttle.
>> Checking the flag before updating the event.
>>
>> Reported-by: Leo Yan <leo.yan@arm.com>
>> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
>> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
>> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
>> Reported-by: Vince Weaver <vincent.weaver@maine.edu>
>> Closes: https://lore.kernel.org/lkml/4ce106d0-950c-aadc-0b6a-f0215cd39913@maine.edu/
>> Reviewed-by: Ian Rogers <irogers@google.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>
>> The patch is to fix the issue introduced by
>>
>>   9734e25fbf5a perf: Fix the throttle logic for a group
>>
>> It is still in the tip.git, I'm not sure if the commit ID is valid. So
>> the Fixes tag is not added.
>>
>> There are some discussions regarding to a soft lockup issue.
>> That is an existing issue, which are not introduced by the above change.
>> It should be fixed separately.
>> https://lore.kernel.org/lkml/CAADnVQ+Lx0HWEM8xdLC80wco3BTUPAD_2dQ-3oZFiECZMcw2aQ@mail.gmail.com/
>>
>> Changes since V3:
>> - Check before update in event_stop()
>> - Add Reviewed-by from Ian
>>
>>  kernel/events/core.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index f34c99f8ce8f..cc77f127e11a 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2656,8 +2656,8 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
>>  
>>  static void perf_event_throttle(struct perf_event *event)
>>  {
>> -	event->pmu->stop(event, 0);
>>  	event->hw.interrupts = MAX_INTERRUPTS;
>> +	event->pmu->stop(event, 0);
>>  	if (event == event->group_leader)
>>  		perf_log_throttle(event, 0);
>>  }
>> @@ -11749,7 +11749,12 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
>>  {
>>  	struct hw_perf_event *hwc = &event->hw;
>>  
>> -	if (is_sampling_event(event)) {
>> +	/*
>> +	 * The throttle can be triggered in the hrtimer handler.
>> +	 * The HRTIMER_NORESTART should be used to stop the timer,
>> +	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
>> +	 */
>> +	if (is_sampling_event(event) && (hwc->interrupts != MAX_INTERRUPTS)) {
>>  		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
>>  		local64_set(&hwc->period_left, ktime_to_ns(remaining));
>>  
>> @@ -11804,7 +11809,8 @@ static void cpu_clock_event_start(struct perf_event *event, int flags)
>>  static void cpu_clock_event_stop(struct perf_event *event, int flags)
>>  {
>>  	perf_swevent_cancel_hrtimer(event);
>> -	cpu_clock_event_update(event);
>> +	if (flags & PERF_EF_UPDATE)
>> +		cpu_clock_event_update(event);
>>  }
>>  
>>  static int cpu_clock_event_add(struct perf_event *event, int flags)
>> @@ -11882,7 +11888,8 @@ static void task_clock_event_start(struct perf_event *event, int flags)
>>  static void task_clock_event_stop(struct perf_event *event, int flags)
>>  {
>>  	perf_swevent_cancel_hrtimer(event);
>> -	task_clock_event_update(event, event->ctx->time);
>> +	if (flags & PERF_EF_UPDATE)
>> +		task_clock_event_update(event, event->ctx->time);
>>  }
>>  
>>  static int task_clock_event_add(struct perf_event *event, int flags)
>> -- 
>> 2.38.1
>>
> 

