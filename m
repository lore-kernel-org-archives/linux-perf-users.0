Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B73DA5C4
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369897; cv=none; b=CJptkF8qbrSEixrVxS2hqd5A3zA6KglRIlZ0IJMNeikHLPXIscAo8RMDjNkYlA9fZV9n+Mk0SZWFFh9VAoLrj9U6HpZsNtfbmLm0487V6Lpr2Ns96UvsCl2nRtdaQ5UAHkgvvylZZOjpfCDaC5YEssqhfm0/YiFm5iAvoNgnIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369897; c=relaxed/simple;
	bh=b62HgJ8w/wGoFZZZKP7DMQHxSmW9dL9JLRAFLZvw+Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LB1hKkI/tdpozpuJBf8OBf8YIUhfB2Srsbmn6NbKsCDLtXVJlRMRExvoZHjq9fuq2L6P5uNNMoTRFZJ0qZxTudHkTuUe7CP9MfUhIM+vS4mZSq+MRMcRn/vemjJsQlYLi37x2K+6y73yUCJUrQQAvsn0uIJ5BJ1YVzNMyW5DuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zon+3ibo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zon+3ibo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777369896; x=1808905896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b62HgJ8w/wGoFZZZKP7DMQHxSmW9dL9JLRAFLZvw+Tw=;
  b=Zon+3iboaMjAqIgFrkmnoHVpgc8MSDSYldJiV+Wxdty74IDxvfEdaI45
   GGKysWkMwfEcgTCsJl2v9HAP+sB0Mn/MabSAJlUP25+RLwKXExR6OSpnm
   mfCXmF5iFRYTdK6aV9aDwSwOXEZU1LkQrrY+7/ss5xCuDyK/SyWzZg+iX
   AoIz4WcbvN777BAxWK4YYdFAw34qQV3TzEiluiWb1aCfMaqVOyx/Q90rI
   SwyndnNH85bW92WC7YCN7jkMx040S30s+hhawKtqbAZE8kDd2dH5OZ2OV
   LO+uqH0ly4BeIdSqM6JiSALUEdzpkF71u1vtO+V7vh0LD0y3AAQ4nHi7X
   Q==;
X-CSE-ConnectionGUID: 9LRpeEcVQueZlPvqyimmUw==
X-CSE-MsgGUID: LlaHj08xTAuVjs2EocRSGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77303922"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77303922"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:51:35 -0700
X-CSE-ConnectionGUID: HaS/xTEhStiZ22T/hOG2qw==
X-CSE-MsgGUID: gO4APW8XTaqB7dDXuYWOig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238938241"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:51:34 -0700
Message-ID: <4e48eacf-484e-4cbc-aa95-47c9ded1161c@linux.intel.com>
Date: Tue, 28 Apr 2026 17:51:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/4] perf/x86/intel: Improve validation and
 configuration of ACR masks
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260427085513.3728672-2-dapeng1.mi@linux.intel.com>
 <20260427101337.5FB32C19425@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260427101337.5FB32C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/27/2026 6:13 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [High] The ACR feature incorrectly maps logical sibling indices from user space to physical array indices in `event_list`, which silently corrupts the configuration if any sibling is disabled.
> - [High] The updated ACR hardware configuration (`hw.config1`) is not synchronized to the PMU hardware register if the event itself does not change counters, leaving the hardware state stale.
> - [Low] The patch uses a complex and brittle hardware counter bitmask to verify group membership instead of simply checking array bounds.
> --
>
> commit 0bc290b3247e55dbfb3b7cee24f6926da6f5adfb
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Subject: perf/x86/intel: Improve validation and configuration of ACR masks
>
> This commit addresses several issues with user space ACR mask validation and
> configuration. It calculates an index bitmap for each ACR group to drop invalid
> user-space mask bits, avoids early returns on invalid bits, and explicitly
> clears stale hardware ACR masks.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index d9488ade0f8e..dafa233dd757 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>> @@ -3332,23 +3332,41 @@ static void intel_pmu_enable_event(struct perf_event *event)
>>  static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
>>  {
>>  	struct perf_event *event, *leader;
>> -	int i, j, idx;
>> +	int i, j, k, bit, idx;
>> +	u64 group_mask;
>>  
>>  	for (i = 0; i < cpuc->n_events; i++) {
>>  		leader = cpuc->event_list[i];
>>  		if (!is_acr_event_group(leader))
>>  			continue;
>>  
>> -		/* The ACR events must be contiguous. */
>> +		/* Find the last event of the ACR group. */
>>  		for (j = i; j < cpuc->n_events; j++) {
>>  			event = cpuc->event_list[j];
>>  			if (event->group_leader != leader->group_leader)
>>  				break;
>> -			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
>> -				if (i + idx >= cpuc->n_events ||
>> -				    !is_acr_event_group(cpuc->event_list[i + idx]))
>> -					return;
>> -				__set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1);
>> +		}
>> +
>> +		/* Figure out the group indices bitmap. */
>> +		group_mask = 0;
>> +		for (k = i; k < j; k++)
>> +			group_mask |= BIT_ULL(cpuc->assign[k]);
> Since x86_schedule_events() guarantees strictly unique hardware counters for
> all concurrently active core PMU events, a counter is present in group_mask if
> and only if its index falls within [i, j).
>
> Given that idx = i + bit guarantees idx >= i, is it possible to simplify this
> by just checking if idx >= j instead of constructing and checking the
> group_mask?

Yes, since the ACR events must be continuous, we can directly check the
event indices. The code can be simplified to this.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 013e6e02706d..f38cf245a894 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3343,7 +3343,6 @@ static void intel_pmu_acr_late_setup(struct
cpu_hw_events *cpuc)
 {
        struct perf_event *event, *leader;
        int i, j, k, bit, idx;
-       u64 group_mask;

        for (i = 0; i < cpuc->n_events; i++) {
                leader = cpuc->event_list[i];
@@ -3357,11 +3356,6 @@ static void intel_pmu_acr_late_setup(struct
cpu_hw_events *cpuc)
                                break;
                }

-               /* Figure out the group indices bitmap. */
-               group_mask = 0;
-               for (k = i; k < j; k++)
-                       group_mask |= BIT_ULL(cpuc->assign[k]);
-
                /*
                 * Translate the user-space ACR mask (attr.config2) into
the physical
                 * counter bitmask (hw.config1) for each ACR event in the
group.
@@ -3372,9 +3366,8 @@ static void intel_pmu_acr_late_setup(struct
cpu_hw_events *cpuc)
                        event->hw.config1 = 0;
                        for_each_set_bit(bit, (unsigned long
*)&event->attr.config2, X86_PMC_IDX_MAX) {
                                idx = i + bit;
-                               if (idx >= cpuc->n_events ||
-                                   !(BIT_ULL(cpuc->assign[idx]) &
group_mask) ||
-                                   !is_acr_event_group(cpuc->event_list[idx]))
+                               /* Event index of ACR group must locate in
[i, j). */
+                               if (idx >= j ||
!is_acr_event_group(cpuc->event_list[idx]))
                                        continue;
                                __set_bit(cpuc->assign[idx], (unsigned long
*)&event->hw.config1);
                        }


>
>> +
>> +		/*
>> +		 * Translate the user-space ACR mask (attr.config2) into the physical
>> +		 * counter bitmask (hw.config1) for each ACR event in the group.
>> +		 * NOTE: ACR event contiguity is guaranteed by intel_pmu_hw_config().
>> +		 */
>> +		for (k = i; k < j; k++) {
>> +			event = cpuc->event_list[k];
>> +			event->hw.config1 = 0;
> If Event A moves to a new counter but Event B itself does not move,
> match_prev_assignment() would evaluate to true for Event B, and
> x86_pmu_start() would be skipped.
>
> Does this mean the updated hw.config1 for Event B is never written to the
> physical hardware MSR, breaking the Auto Counter Reload functionality?

Yeah, this is indeed a potential issue. Suppose the simplest fix would be
to make match_prev_assignment() return false for ACR events.

Maybe like this.

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc7ef2e..e766621f9449 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1294,13 +1294,16 @@ int x86_perf_rdpmc_index(struct perf_event *event)
        return event->hw.event_base_rdpmc;
 }

-static inline int match_prev_assignment(struct hw_perf_event *hwc,
+static inline int match_prev_assignment(struct perf_event *event,
                                        struct cpu_hw_events *cpuc,
                                        int i)
 {
+       struct hw_perf_event *hwc = &event->hw;
+
        return hwc->idx == cpuc->assign[i] &&
-               hwc->last_cpu == smp_processor_id() &&
-               hwc->last_tag == cpuc->tags[i];
+              hwc->last_cpu == smp_processor_id() &&
+              hwc->last_tag == cpuc->tags[i] &&
+              !is_acr_event_group(event);
 }

 static void x86_pmu_start(struct perf_event *event, int flags);
@@ -1346,7 +1349,7 @@ static void x86_pmu_enable(struct pmu *pmu)
                         * - no other event has used the counter since
                         */
                        if (hwc->idx == -1 ||
-                           match_prev_assignment(hwc, cpuc, i))
+                           match_prev_assignment(event, cpuc, i))
                                continue;

                        /*
@@ -1367,7 +1370,7 @@ static void x86_pmu_enable(struct pmu *pmu)
                        event = cpuc->event_list[i];
                        hwc = &event->hw;

-                       if (!match_prev_assignment(hwc, cpuc, i))
+                       if (!match_prev_assignment(event, cpuc, i))
                                x86_assign_hw_event(event, cpuc, i);
                        else if (i < n_running)
                                continue;

>
>> +			for_each_set_bit(bit, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
>> +				idx = i + bit;
> User space provides the ACR mask (attr.config2) using absolute logical bit
> indices (e.g., bit 0 = leader, bit 1 = first sibling). However,
> collect_events() skips events that are in PERF_EVENT_STATE_OFF.
>
> If an earlier sibling is disabled, it is not added to event_list, causing all
> subsequent active siblings to shift down in the array.
>
> Does idx point to the wrong event in the active array if any sibling is
> disabled? Should the mask resolve against the logical sibling_list rather
> than the compressed active array?

In theory, it's indeed an issue, but it could be hard to trigger in real
application. The events in ACR group are interdependent and disabling any
event would break the expected behavior of the ACR sampling and user should
not disable any event in the ACR group. Even though some non-leader member
is disabled, the above acr_mask validation code would filter out the
invalid bits in most of cases.

It's unfeasible to parse the counter indices against cpuc->events[] which
is in HW counters order. It's hard to figure out an ACR events group base
on the cpuc->events[]. It looks there is not an easy way to thoroughly fix
this issue. Since the issue would be hard to happen in reality, I would
just add a "FIXME" to highlight the risk. 

Thanks.


>
>> +				if (idx >= cpuc->n_events ||
>> +				    !(BIT_ULL(cpuc->assign[idx]) & group_mask) ||
>> +				    !is_acr_event_group(cpuc->event_list[idx]))
>> +					continue;
>> +				__set_bit(cpuc->assign[idx], (unsigned long *)&event->hw.config1);
>>  			}
>>  		}
