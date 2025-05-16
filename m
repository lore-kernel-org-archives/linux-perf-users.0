Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B9189B80;
	Fri, 16 May 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405989; cv=none; b=jylvTGPQFhgY3A4aWwO7G/QnJlwm+9aopJjRjt3eXinsYTMJZIpn9qZG2SGdR3Qpl+nAjCJXABBxGuRBllSbn3ducy2dZ254ncUMKhynKq2NxWjkjvfY1GrBw7tex57sQGXkoGrExZKLNSEbfxniSSa94YeOhneWwtvoW4K4NkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405989; c=relaxed/simple;
	bh=aYQZZ/fxotvUcgwXlq+GHbWS05l2JDt1inCS2b8+FKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVdCeOfyCn46FTXauv12wkjjcu3dseMFnXxI0u5AutsJs6oFdcps0VRMVyxmJEmKt9SpoUkNVRgrdlVz3U6kA5rhRQ/LSZ8RMeMt7rJvP4bO1V0OlaTufojb6u73LsP3ZIDDwCsvUsrQVm71gB3A0ZnVzMAvO9yRKhz7cV+g4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hy89Ql2B; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hy89Ql2B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747405989; x=1778941989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aYQZZ/fxotvUcgwXlq+GHbWS05l2JDt1inCS2b8+FKQ=;
  b=hy89Ql2B8Oh8yvIb2pPVoysg95nUvaX7Ox+/49SEUlaiti60YRI1pWiu
   MdCvau5jUvRpsIV8xV0SXsd57sHzIL0jrGxfI/TGJ6K+EaeGke809agag
   F0uCzI3ruQimY38zlLUvTH518kzg+GjAeDxEuZLITEcXmAH7nOI6UeVbH
   oinyqSq35S4323/UaghDT5/GxzhLrfyqYBGE5U68oSx5AnIpZuO6jy+Xx
   v57MQZ+eBajPLdwgYX5M7l6xpt0vseFxpyP+j5hKjYMhJ1BC2+7j1OORD
   yvSIOooHDxRY/LXwCa8FGhrrGhJuNPtEhdoR/PuE6Vsp9/hfW6Usd3sDt
   g==;
X-CSE-ConnectionGUID: IeexyeDsQOaxC+aPFNRyLg==
X-CSE-MsgGUID: yA95Czh7TkO58t9IpPQePQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49255585"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49255585"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 07:33:08 -0700
X-CSE-ConnectionGUID: memuGYkjTWS4iVnevWgJdg==
X-CSE-MsgGUID: 36kBbGyESc2yjJOJjmQkOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="138455990"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 07:33:07 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7A01A20B5736;
	Fri, 16 May 2025 07:33:05 -0700 (PDT)
Message-ID: <bdd3f129-18c6-4dae-95be-847d13938e2f@linux.intel.com>
Date: Fri, 16 May 2025 10:33:04 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/15] perf: Fix the throttle logic for a group
To: Leo Yan <leo.yan@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
 <20250514151401.2547932-2-kan.liang@linux.intel.com>
 <20250515094300.GC412060@e132581.arm.com>
 <4a44b8cb-7c73-4926-8b9f-1f63929ea48f@linux.intel.com>
 <20250516125146.GE412060@e132581.arm.com>
 <b0d1b369-3d1a-47a5-befe-9c723ed5bb79@linux.intel.com>
 <20250516141739.GG412060@e132581.arm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250516141739.GG412060@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-16 10:17 a.m., Leo Yan wrote:
> On Fri, May 16, 2025 at 09:28:07AM -0400, Liang, Kan wrote:
> 
> [...]
> 
>>> Just a minor suggestion. Seems to me, the parameter "start" actually
>>> means "only_enable_sibling". For more readable, the function can be
>>> refine as:
>>>
>>> static void perf_event_unthrottle_group(struct perf_event *event,
>>>                                         bool only_enable_sibling)
>>> {
>>> 	struct perf_event *sibling, *leader = event->group_leader;
>>>
>>> 	perf_event_unthrottle(leader,
>>>                 only_enable_sibling ? leader != event : true);
>>>         ...
>>> }
>>>
>>
>> It should work for the perf_adjust_freq_unthr_events(), which only start
>> the leader.
> 
>> But it's possible that the __perf_event_period() update a
>> sibling, not leader.
> 
> Should not perf_event_unthrottle_group() always enable sibling events?
>

No. __perf_event_period() can reset the period of a sibling event. I
know it sounds weird, but it's doable.


> The only difference is how the leader event to be enabled.  It can be
> enabled in perf_event_unthrottle_group() in period mode, or in
> frequency mode due to a new period value is generated, the leader
> event is enabled in perf_adjust_freq_unthr_events() or in
> __perf_event_period().
> 
> This is why I suggested to rename the flag to only_enable_sibling:
> 
>   true: only enable sibling events
>   false: enable all events (leader event and sibling events)
> 
> Or, we can rename the flag as "skip_start_event", means to skip
> enabling the event specified in the argument.

The name "skip_start_event" sounds good to me. I will use it in V3.

Thanks,
Kan>
>> I think I can check the name to bool event_has_start.
>> Is the name OK?
> 
> I am still confused for the naming "event_has_start" :)
> 
> What exactly does it mean?
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index a270fcda766d..b1cb07fa9c18 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2749,13 +2749,13 @@ static void perf_event_throttle(struct
>> perf_event *event)
>>  	perf_log_throttle(event, 0);
>>  }
>>
>> -static void perf_event_unthrottle_group(struct perf_event *event, bool
>> start)
>> +static void perf_event_unthrottle_group(struct perf_event *event, bool
>> event_has_start)
>>  {
>>  	struct perf_event *sibling, *leader = event->group_leader;
>>
>> -	perf_event_unthrottle(leader, leader != event || start);
>> +	perf_event_unthrottle(leader, event_has_start ? leader != event : true);
>>  	for_each_sibling_event(sibling, leader)
>> -		perf_event_unthrottle(sibling, sibling != event || start);
>> +		perf_event_unthrottle(sibling, event_has_start ? sibling != event :
>> true);
>>  }
>>
>>  static void perf_event_throttle_group(struct perf_event *event)
>> @@ -4423,7 +4423,7 @@ static void perf_adjust_freq_unthr_events(struct
>> list_head *event_list)
>>
>>  		if (hwc->interrupts == MAX_INTERRUPTS) {
>>  			perf_event_unthrottle_group(event,
>> -				!event->attr.freq || !event->attr.sample_freq);
>> +				(event->attr.freq && event->attr.sample_freq));
>>  		}
>>
>>  		if (!event->attr.freq || !event->attr.sample_freq)
>> @@ -6466,7 +6466,7 @@ static void __perf_event_period(struct perf_event
>> *event,
>>  		 * while we already re-started the event/group.
>>  		 */
>>  		if (event->hw.interrupts == MAX_INTERRUPTS)
>> -			perf_event_unthrottle_group(event, false);
>> +			perf_event_unthrottle_group(event, true);
>>  		perf_pmu_enable(event->pmu);
> 
> The logic in the updated code is correct for me.
> 
> Thanks,
> Leo
> 

