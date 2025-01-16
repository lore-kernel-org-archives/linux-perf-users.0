Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5622BAC6;
	Thu, 16 Jan 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042980; cv=none; b=qkaRBPa1NR99acAsyZuN1LLZyzP8xPndlgAQiQ287K7+6EwCiPoTAh3S9ERbchEWjKu1R/OSvYcAaa+aa9NPqgFYbWz4/Sqs4eM3RCYAcWClz7NcncFWT/+nwNxr1QkSW8P3+Q1KLBFyu+wbQXTqmz4TYqqvFM+NcbJoVVaI9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042980; c=relaxed/simple;
	bh=Caca4ix34F0PIzUPOigkS0pCWfGhUfoqK2wLkNjSJTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJBjKui1wYKxQQlHUtRfR9afGseuyuxCCf2vPNHocpnYY+gCTqyGttwBUxUptNU620By+Ak3Hmbko8Y2hPBa/MORA5PulgXbxAAncu6q/O9C7TClJwCVpForgKp77TiykAbv6tY7IMbvRwoLGypJX4pMyeA+mYhNgdPaS6P8xn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRemeRXX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRemeRXX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737042979; x=1768578979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Caca4ix34F0PIzUPOigkS0pCWfGhUfoqK2wLkNjSJTk=;
  b=WRemeRXXg/9VBE0chjkmP2BopbSu3rNsw3sbvD8n+NZDXmptz2FNS9pY
   DHkiksgrXbx8Crf+bMry6yeQYr0yd970gDoMkgYkSQXIn/HJuh95033DQ
   7PMVmUn9Rm4vWhfnJQGUMFVDaBeOzNt/JjN1cQju9RJ6ONPPTpUcaulMp
   +SXhEY6U8fCjkW0He/BsTKt+oYZTiR1e8P4ueWZYoNsACjmPsF0slmZ0h
   f+j+hD/9Nqd1tO98EF72OkoaB9GTgbxN3VeMiy3PI9YzhiliYUh5xerT4
   0+eXwRJSltjhPz5fluM14LVeKM0n3Q8Gy2mmc4qQZSrectsL6B55Dzce7
   A==;
X-CSE-ConnectionGUID: lo/keRBJQ+OtgytDPO8OwQ==
X-CSE-MsgGUID: wQIc6ruERmKORVM7tduivg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37321067"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37321067"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:55:51 -0800
X-CSE-ConnectionGUID: +Nep8eQJS/m1VO5hDR/oMA==
X-CSE-MsgGUID: +y2A9aSISAKB3rnqf1b+tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="105359640"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:55:50 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4EF4120B5713;
	Thu, 16 Jan 2025 07:55:48 -0800 (PST)
Message-ID: <be90e73b-eedf-4ff0-a832-b579e003cac9@linux.intel.com>
Date: Thu, 16 Jan 2025 10:55:46 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 3/3] perf/x86/intel: Support PEBS counters snapshotting
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com,
 dapeng1.mi@linux.intel.com
References: <20250115184318.2854459-1-kan.liang@linux.intel.com>
 <20250115184318.2854459-3-kan.liang@linux.intel.com>
 <20250116114751.GJ8362@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250116114751.GJ8362@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-16 6:47 a.m., Peter Zijlstra wrote:
> On Wed, Jan 15, 2025 at 10:43:18AM -0800, kan.liang@linux.intel.com wrote:
> 
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Did they really read all the various versions without spotting any of
> the problems, or are you just rubber stamping things at this point :/
> 
> Best to drop review tags after serious changes to patches.
> 

Sure.

>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
> 
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 8f218ac0d445..79a4aad5a0a3 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -94,6 +94,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
>>  
>>  DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
>>  
>> +DEFINE_STATIC_CALL_NULL(x86_pmu_late_config, x86_pmu_late_config);
> 
> So all these static call are through struct x86_pmu (hence the naming),
> but not this one ?!?

I will add it in struct x86_pmu.

> 
>>  /*
>>   * This one is magic, it will get called even when PMU init fails (because
>>   * there is no PMU), in which case it should simply return NULL.
>> @@ -1329,7 +1331,16 @@ static void x86_pmu_enable(struct pmu *pmu)
>>  		}
>>  
>>  		/*
>> -		 * step2: reprogram moved events into new counters
>> +		 * step2:
>> +		 * The late config (after counters are scheduled)
>> +		 * is required for some cases, e.g., PEBS counters
>> +		 * snapshotting. Because an accurate counter index
>> +		 * is needed.
>> +		 */
>> +		static_call_cond(x86_pmu_late_config)();
>> +
>> +		/*
>> +		 * step3: reprogram moved events into new counters
>>  		 */
>>  		for (i = 0; i < cpuc->n_events; i++) {
>>  			event = cpuc->event_list[i];
> 
> Placement and naming are weird.
> 
> These 2 loops migrate all counters that got a new place, the first loop
> taking out pre-existing counters that got a new place, the second loop
> setting up these same and new counters.
> 
> Why do the pebs config in the middle, where the least number of counters
> are set-up?
> 
> AFAICT all it really needs is cpuc->assignp[], which is unchanged
> throughout. You can call this at any time before clearing n_added,
> sticking it in the middle just seems weird.

I just tried to put it right before the x86_pmu_start(RELOAD), since the
MSR will be updated in the x86_pmu_start().
But yes, any place before it is good.

> 
> Then naming, config is typically what we do at event creation,
> x86_pmu_hw_config() like. This is not at all related, so perhaps pick a
> different name?

How about late_setup/extra_setup?

@@ -1300,6 +1300,9 @@ static void x86_pmu_enable(struct pmu *pmu)

 	if (cpuc->n_added) {
 		int n_running = cpuc->n_events - cpuc->n_added;
+
+		static_call_cond(x86_pmu_late_setup)();
+
 		/*
 		 * apply assignment obtained either from
 		 * hw_perf_group_sched_in() or x86_pmu_enable()


It can be put at the begin of the cpuc->n_added.

So perf does the late setup, and then move and start the pre-existing
and new events. Is it OK?

> 
> Bah, we're so very close between x86_pmu::{enable, disable, assign}() :/
> 
> Also, I think I found you another bug... Consider what happens to the
> counter value when we reschedule a HES_STOPPED counter, then we skip
> x86_pmu_start(RELOAD) on step2, which leave the counter value with
> 'random' crap from whatever was there last.
> 
> But meanwhile you do program PEBS to sample it. That will happily sample
> this garbage.
> 
> Hmm?

I'm not quite sure I understand the issue.

The HES_STOPPED counter should be a pre-existing counter. Just for some
reason, it's stopped, right? So perf doesn't need to re-configure the
PEBS__DATA_CFG, since the idx is not changed.

The worry is that the HES_STOPPED counter is restarted with
x86_pmu_start(0), right?

There should be 3 places which invoking the x86_pmu_start(0).
- In __perf_event_stop(). But according to the comments, it's only for
the events with AUX ring buffer. It should not be a problem for PEBS.
- Handle throttle. The event does stop(0) and then start(0). There
should be no 'random' garbage, since the counter has been stopped.
Everything should be just the same as when it's stopped.
- In the perf_adjust_freq_unthr_events(), when the period is not
adjusted, there should be no 'random' garbage as well.

Or do you mean that some 3rd party tools change the counter values while
it's stopped?

If so, I think we may force update for the pebs-counter-event-group as
below.

@@ -1517,7 +1522,8 @@ static void x86_pmu_start(struct perf_event
*event, int flags)
 	if (WARN_ON_ONCE(idx == -1))
 		return;

-	if (flags & PERF_EF_RELOAD) {
+	if (flags & PERF_EF_RELOAD ||
+		is_pebs_counter_event_group(event)) {
 		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
  		static_call(x86_pmu_set_period)(event);
 	}
@@ -1608,7 +1614,8 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 		hwc->state |= PERF_HES_STOPPED;
 	}

-	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+	if (((flags & PERF_EF_UPDATE) || is_pebs_counter_event_group(event)) &&
+	    !(hwc->state & PERF_HES_UPTODATE)) {
 		/*
 		 * Drain the remaining delta count out of a event
 		 * that we are disabling:


Thanks,
Kan
