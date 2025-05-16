Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD45219E0;
	Fri, 16 May 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402092; cv=none; b=dN76cG4oL7QePs6ezamm5GbR8Q5AMW22FhY0W5KAJ83WjlneVmzj2uZllWP6Gmht2ZkmfcCXikfzJeZXOd4wOzIOgTwLs3Y4eZwRDjqbmMSoPJajdL4vAmapxOwF84xI/lksSYiXw82f9z8FEHIhmU0RqZhqLxSbEPE9NxurfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402092; c=relaxed/simple;
	bh=G6CMzWauq5+AzogSdJMeQVmUl+TKhUo8l0EXfMlhalY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fp9IKSajqf/jJMTdDjS51wp8vOkP8i6cf6VWoB29KV42Xc4NlIw/0U2qzxSI2JIjpi6D2kiVpSFbmks5vJlBx+mn2kacl5TmBoSa0qY4l37O7SAWIeuWRbOHjKglArUTkmw7dI05ypO8MVYJKtphtOmOCFqREoKRS/fOOGi3qZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4Vi/6ly; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4Vi/6ly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747402091; x=1778938091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G6CMzWauq5+AzogSdJMeQVmUl+TKhUo8l0EXfMlhalY=;
  b=k4Vi/6ly2k1Qql8LVHzqqFZa7oLbWZhOm2GrOlxe4ap6nJ+oQN2B0yjU
   b4tQRR2nzn7EgQyjv1phMM56PN9RKJSsIMC4R31H68RgnWlmhbD0iC/qi
   6hxHRYP+5I/ODYNH+/QStyO+qHp0DNKBDCmkyJTtw7AY43vdMhoP1hjuF
   uKq+QaGj46VNDjzdRbnqrb/Y9jyhujSoJYl/xsn9GW7GM8ay9T1wQPKOj
   JL0Od3oUTYJPlMkcMOdVVrL/O/vFjHh39/QuSNL7+WY9a7nu8Dsl0SZQl
   T8Rj9cKh4Gzc7xDzdzTfJKsHT1bRQUn/4XVb4kxCgEsAwA/ae7FO4eLTd
   g==;
X-CSE-ConnectionGUID: pNqcDumXRTK+8L4iBLs+Vg==
X-CSE-MsgGUID: jRrlq64rTIuvogVR9UcIig==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="53045832"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53045832"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 06:28:10 -0700
X-CSE-ConnectionGUID: NkgiRhwHQbiqQX9YY7ptUw==
X-CSE-MsgGUID: GxJFaurSSN+30mOuiqx8eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143936128"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 06:28:10 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id CBC5220B5736;
	Fri, 16 May 2025 06:28:08 -0700 (PDT)
Message-ID: <b0d1b369-3d1a-47a5-befe-9c723ed5bb79@linux.intel.com>
Date: Fri, 16 May 2025 09:28:07 -0400
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250516125146.GE412060@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-16 8:51 a.m., Leo Yan wrote:
> On Thu, May 15, 2025 at 08:55:05AM -0400, Liang, Kan wrote:
> 
> [...]
> 
>>>> +static void perf_event_unthrottle_group(struct perf_event *event, bool start)
>>>> +{
>>>> +	struct perf_event *sibling, *leader = event->group_leader;
>>>> +
>>>> +	perf_event_unthrottle(leader, leader != event || start);
>>>> +	for_each_sibling_event(sibling, leader)
>>>> +		perf_event_unthrottle(sibling, sibling != event || start);
>>>
>>> Seems to me that the condition "leader != event || start" is bit tricky
>>> (similarly for the check "sibling != event || start").
>>>
>>> If a session sets the frequency (with option -F in perf tool), the
>>> following flow is triggered:
>>>
>>>   perf_adjust_freq_unthr_events()
>>>     `> perf_event_unthrottle_group(event, false);
>>>
>>> The argument "start" is false, so all sibling events will be enabled,
>>> but the event pointed by the "event" argument remains disabled.  
>>
>> Right. Because the following code will adjust the period of the event
>> and start it.
>> The PMU is disabled at the moment. There is no difference in starting
>> the leader first or the member first.
> 
> Thanks for explaination. In the case above, as you said, all events will
> be enabled either in perf_event_unthrottle_group() or in
> perf_adjust_freq_unthr_events() with a recalculated period.
> 
> Just a minor suggestion. Seems to me, the parameter "start" actually
> means "only_enable_sibling". For more readable, the function can be
> refine as:
> 
> static void perf_event_unthrottle_group(struct perf_event *event,
>                                         bool only_enable_sibling)
> {
> 	struct perf_event *sibling, *leader = event->group_leader;
> 
> 	perf_event_unthrottle(leader,
>                 only_enable_sibling ? leader != event : true);
>         ...
> }
> 

It should work for the perf_adjust_freq_unthr_events(), which only start
the leader. But it's possible that the __perf_event_period() update a
sibling, not leader.

I think I can check the name to bool event_has_start.
Is the name OK?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a270fcda766d..b1cb07fa9c18 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2749,13 +2749,13 @@ static void perf_event_throttle(struct
perf_event *event)
 	perf_log_throttle(event, 0);
 }

-static void perf_event_unthrottle_group(struct perf_event *event, bool
start)
+static void perf_event_unthrottle_group(struct perf_event *event, bool
event_has_start)
 {
 	struct perf_event *sibling, *leader = event->group_leader;

-	perf_event_unthrottle(leader, leader != event || start);
+	perf_event_unthrottle(leader, event_has_start ? leader != event : true);
 	for_each_sibling_event(sibling, leader)
-		perf_event_unthrottle(sibling, sibling != event || start);
+		perf_event_unthrottle(sibling, event_has_start ? sibling != event :
true);
 }

 static void perf_event_throttle_group(struct perf_event *event)
@@ -4423,7 +4423,7 @@ static void perf_adjust_freq_unthr_events(struct
list_head *event_list)

 		if (hwc->interrupts == MAX_INTERRUPTS) {
 			perf_event_unthrottle_group(event,
-				!event->attr.freq || !event->attr.sample_freq);
+				(event->attr.freq && event->attr.sample_freq));
 		}

 		if (!event->attr.freq || !event->attr.sample_freq)
@@ -6466,7 +6466,7 @@ static void __perf_event_period(struct perf_event
*event,
 		 * while we already re-started the event/group.
 		 */
 		if (event->hw.interrupts == MAX_INTERRUPTS)
-			perf_event_unthrottle_group(event, false);
+			perf_event_unthrottle_group(event, true);
 		perf_pmu_enable(event->pmu);
 	}
 }

Thanks,
Kan

