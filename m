Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46566DDC1;
	Tue, 13 May 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147674; cv=none; b=dsjfbmYB9HKmMzVOn3+3YzNoQo8uM/xIK8z9hmSJDaOxwqLb71aVoZcXqcQRwa5xamv4OUgIZadH3flxdISSmPD98lNU6rrxDxgp5yjESJmKLZgUiu9ZcHh777SuHulsW2Sdmy1Zp3w+t3WbQA3ExR3lIZzBFfFF9r141aINYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147674; c=relaxed/simple;
	bh=BQjI8sVsd7xw/lEsQI5+iqUXOxBF4QG93zsWLyiXcaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhwUgHKXPuWJpY7903vr3Ti6Oqqx+osTDj8pwk402qpY6f2hvwBt63lhXEMHpTT6rGLZExOufL+jeHl8H3eny47j5kRK85sYn6oLISxj5Almk5zoRHgxXFMv9znZDR+CwSLvViULgWc/jPyqFOm+b8Aj9l9LHnp6zdIEEEgg/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0+hw4W+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0+hw4W+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747147673; x=1778683673;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BQjI8sVsd7xw/lEsQI5+iqUXOxBF4QG93zsWLyiXcaI=;
  b=I0+hw4W+OTVT5EdT5IsYGog7xLO8ALk5K3xyjbG+DJgWs3rxwWYXw9nl
   LE8+h8nCjVGc3CGHld4s/+H6U/+oZlIqqljTreyP7nr4gEzIUHLyKY/A6
   y8LYXEv4CgKug76m15ml2l2IwQ93fpQx9y2T/ykAce/+ZCn1igYRODV0E
   iWKVvnC2H0UCbNqE991wwPgDWWqTzpLFhJaqmzX6H7W3rgW59e49wLOul
   0O5zZWWuGbzvLpAJMaDEdWG5Flk0DImTmLZyfwfQ3+Ia90kC4WFSIW6g9
   mE3HjfQSWaTzGFoe/7fWcoeBGQunvmKr6Bf2pV3vmcW43eGfKI+CKjfdf
   Q==;
X-CSE-ConnectionGUID: cahlHzccQkOi1tca3lIisg==
X-CSE-MsgGUID: PKj1txZvQ+2tm0T0MUgQIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59634706"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="59634706"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:47:52 -0700
X-CSE-ConnectionGUID: BSmbKkeFTZa2TT7BvFJbmA==
X-CSE-MsgGUID: niDLJLACTUWv0KYHeQpSww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="137764533"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 07:47:52 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1B84020B5736;
	Tue, 13 May 2025 07:47:50 -0700 (PDT)
Message-ID: <28569544-204a-45c3-a907-a0b3ae76812c@linux.intel.com>
Date: Tue, 13 May 2025 10:47:48 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/15] perf: Fix the throttle logic for a group
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, namhyung@kernel.org, irogers@google.com,
 mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
 <20250506164740.1317237-2-kan.liang@linux.intel.com>
 <20250513094155.GD25763@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250513094155.GD25763@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-13 5:41 a.m., Peter Zijlstra wrote:
> On Tue, May 06, 2025 at 09:47:26AM -0700, kan.liang@linux.intel.com wrote:
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index a84abc2b7f20..eb0dc871f4f1 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2734,6 +2734,38 @@ void perf_event_disable_inatomic(struct perf_event *event)
>>  static void perf_log_throttle(struct perf_event *event, int enable);
>>  static void perf_log_itrace_start(struct perf_event *event);
>>  
>> +static void perf_event_group_unthrottle(struct perf_event *event, bool start_event)
>> +{
>> +	struct perf_event *leader = event->group_leader;
>> +	struct perf_event *sibling;
>> +
>> +	if (leader != event || start_event)
>> +		leader->pmu->start(leader, 0);
>> +	leader->hw.interrupts = 0;
>> +
>> +	for_each_sibling_event(sibling, leader) {
>> +		if (sibling != event || start_event)
>> +			sibling->pmu->start(sibling, 0);
>> +		sibling->hw.interrupts = 0;
>> +	}
>> +
>> +	perf_log_throttle(leader, 1);
>> +}
>> +
>> +static void perf_event_group_throttle(struct perf_event *event)
>> +{
>> +	struct perf_event *leader = event->group_leader;
>> +	struct perf_event *sibling;
>> +
>> +	leader->hw.interrupts = MAX_INTERRUPTS;
>> +	leader->pmu->stop(leader, 0);
>> +
>> +	for_each_sibling_event(sibling, leader)
>> +		sibling->pmu->stop(sibling, 0);
>> +
>> +	perf_log_throttle(leader, 0);
>> +}
> 
> Urgh, this seems inconsistent at best.
> 
>  - unthrottle will set interrupts to 0 for the whole group
>  - throttle will set interrupts for leader
>    while the old code would set interrupts for event.
>  - interrupts was written with event stopped, while now you consistently
>    write when started
>  - both now issue perf_log_throttle() on leader, whereas previously it
>    was issued on event.
> 
> IOW
> 
> before:				after:
>  event stops			 leader MAX_INTERRUPTS
>  event MAX_INTERRUPTS		 event group stops
>  event logs			 leader logs
> 
>  event 0			 event group 0
>  event starts			 event group starts
>  event logs			 leader logs
> 
> Like said, a rather inconsistent and random collection of things.
> 
> 
> 
> What's wrong with something simple like:
> 
> static void perf_event_throttle(struct perf_event *event, bool start)
> {
> 	event->hw.interrupts = 0;
> 	if (start)
> 		event->pmu->start(event, 0);
> 	perf_log_throttle(event, 1);
> }
> 
> static void perf_event_unthrottle(struct perf_event *event)
> {
> 	event->pmu->stop(event, 0);
> 	event->hw.interrupts = MAX_INTERRUPTS;
> 	perf_log_throttle(event, 0);
> }

I think the name is reversed. An event/group should be stopped when
throttle.

> 
> static void perf_event_throttle_group(struct perf_event *event, bool start)
> {
> 	struct perf_event *sibling, *leader = event->group_leader;
> 
> 	perf_event_throttle(leader, start);
> 	for_each_sibling_event(sibling, leader)
> 		perf_event_throttle(sibling, start);
> }
> 
> static void perf_event_unthrottle_group(struct perf_event *event)
> {
> 	struct perf_event *sibling, *leader = event->group_leader;
> 
> 	perf_event_unthrottle(leader);
> 	for_each_sibling_event(sibling, leader)
> 		perf_event_unthrottle(sibling);
> }
> 
> That way:
> 
> before:				after:
>  event stops			 event group stops
>  event MAX_INTERRUPTS		 event group MAX_INTERRUPTS
>  event logs			 event group logs
> 
>  event 0			 event group 0
>  event starts			 event group starts
>  event logs			 event group logs
> 
> All that was done before is still done - no change in behaviour for
> event. Its just that the rest of the group is now taken along for the
> ride.

Except the naming, the change looks good to me.
I will update it in V2. Thanks.

> 
>> @@ -6421,14 +6451,6 @@ static void __perf_event_period(struct perf_event *event,
>>  	active = (event->state == PERF_EVENT_STATE_ACTIVE);
>>  	if (active) {
>>  		perf_pmu_disable(event->pmu);
>> -		/*
>> -		 * We could be throttled; unthrottle now to avoid the tick
>> -		 * trying to unthrottle while we already re-started the event.
>> -		 */
>> -		if (event->hw.interrupts == MAX_INTERRUPTS) {
>> -			event->hw.interrupts = 0;
>> -			perf_log_throttle(event, 1);
>> -		}
>>  		event->pmu->stop(event, PERF_EF_UPDATE);
>>  	}
>>  
>> @@ -6436,6 +6458,12 @@ static void __perf_event_period(struct perf_event *event,
>>  
>>  	if (active) {
>>  		event->pmu->start(event, PERF_EF_RELOAD);
>> +		/*
>> +		 * We could be throttled; unthrottle now to avoid the tick
>> +		 * trying to unthrottle while we already re-started the event.
>> +		 */
>> +		if (event->group_leader->hw.interrupts == MAX_INTERRUPTS)
>> +			perf_event_group_unthrottle(event, false);
>>  		perf_pmu_enable(event->pmu);
>>  	}
>>  }
> 
> This change seems random. Also, note that I'm kicking myself for the
> total lack of useful information in commit 1e02cd40f151.
> 
> Notably, we're calling this from event_function_call(), this means we're
> having IRQs disabled and are running on the events CPU. How can we
> interact with the tick?

The commit bad7192b842c indicates that an event should be start
immediately once the period is force-reset. If perf does so for a
throttled event, the MAX_INTERRUPTS must be cleared. Otherwise, in the
next tick, the start will be invoked. At least, for x86, there will be a
WARN when perf starts an non-stop event.

I moved the code down a little bit so the events in a group could start
all together. But I think it's possible that the member event is
force-reset. So the start of the leader may not be invoked first. But it
should be OK, since the PMU is disabled.

Thanks,
Kan

