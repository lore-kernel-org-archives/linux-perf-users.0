Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE71E5B9A;
	Tue,  9 Jun 2026 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965396; cv=none; b=Eca2XUUJ0MnAQRA+ut5zhXxhAx9eBNLdZ0uF2zQqeMWNn3L7/lyRKU2D1Y/oRONL9UK/Hr6aPuzAyxzIEuK2jaxhl4QVVcDWjybTR+X0cp7QRyhiPYqt8GP5m0iq751Yec5L5y5h5Cn3oedohv/u7nQ9sOuYwuJnnYX4fw680Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965396; c=relaxed/simple;
	bh=u669k2vBoLHwAQ/6Q028Jwr/IOzPjDmLWazmXx6KOUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icqw2RGRSnqxEpKo1oDcHTwxeguCh9/s5XDF7hgQPfMi5DV9eVIB51M4aj8CLhEKcMGSEpLArH/5nroqDILhCiHve755P2FFK7tIxw+S8/nCclcDF3H+BkuhV+/DUvRkrYCdGy0JjceFQ6HnXPVZug2md3vqDXwKV4wsmjsI6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVBpEGTZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVBpEGTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780965395; x=1812501395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u669k2vBoLHwAQ/6Q028Jwr/IOzPjDmLWazmXx6KOUo=;
  b=jVBpEGTZGF4ZU++nBWg0fjhSje2BiX+M++uFTe5p7TM3FvvHnpHfMXMJ
   wm+q0T5D+tUPTkORp5+7+vIZuOXW8rWEssyUR2zMaboXpPD6iCt9GH1de
   PsnJLAnpwx7JpJgKh/Xc4Ynx+4i+fwjaiV4AbGPnRP5/VPdGjAvJ4mX8Y
   c2gEX+ODKwZ3pbLV13HMvZ1VPkLdKNHEG23ViiiY109hZKcPVKDKjujnY
   jESA7SYoJmpNq44XRKkmQsRE2ZGrRvRJhlvF4HVUmQwsF4YuzmIWhXLtd
   NtPrVUyqtZ55ZycJEIiitYWLlWy95O2QqDnEoUXVmXk46hAXSLZ99RYqp
   w==;
X-CSE-ConnectionGUID: C2F+GeJrQQeEN5oYHnCOlQ==
X-CSE-MsgGUID: lfXMlOS6QOOhjeXF5LJZPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81570093"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81570093"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 17:36:34 -0700
X-CSE-ConnectionGUID: LtdDrWOHSZ+5aj0MbmYc2g==
X-CSE-MsgGUID: SiSybKOGSYqcQucp8LhhEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245797455"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 17:36:30 -0700
Message-ID: <0c69e8c7-ce5b-4f39-a68a-1721bf883c88@linux.intel.com>
Date: Tue, 9 Jun 2026 08:36:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] perf/x86/intel: Drop fixed-counter PEBS constraints
 for baseline PEBS
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Yi Lai <yi1.lai@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
 <20260605011136.2043393-8-dapeng1.mi@linux.intel.com>
 <350ebaf7-91b1-4550-be4d-a07a96c4a955@intel.com>
 <64abd498-8ce2-45fa-b41e-c95aa0bc8b40@linux.intel.com>
 <17cc1e8c-84ed-459e-8b8b-dd1d52261105@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <17cc1e8c-84ed-459e-8b8b-dd1d52261105@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/8/2026 11:46 PM, Chen, Zide wrote:
>
> On 6/7/2026 9:46 PM, Mi, Dapeng wrote:
>> On 6/6/2026 4:32 AM, Chen, Zide wrote:
>>> On 6/4/2026 8:11 PM, Dapeng Mi wrote:
>>>> On SPR guests where pebs_baseline is not advertised, running:
>>>>
>>>> $ ./perf record -e cpu/event=0x00,umask=0x01,i\
>>>> 	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1
>>>>
>>>> can trigger:
>>>>
>>>> unchecked MSR access error: WRMSR to 0x3f1 ... in\
>>>> 	 intel_pmu_pebs_enable_all()
>>>>
>>>> Root cause:
>>>> SPR-specific PEBS constraints allow fixed-counter scheduling,
>>>> for example INST_RETIRED.PREC_DIST on fixed counter 0. In guests without
>>>> pebs_baseline, KVM does not support PEBS sampling on fixed counters,
>>>> so enabling such events reaches an invalid MSR programming path.
>>>>
>>>> Fix:
>>>> Drop fixed-counter entries from the PEBS constraint table. Without
>>>> pebs_baseline, those fixed-counter PEBS events now resolve to empty
>>>> constraints and are not scheduled/enabled, avoiding the warning and the
>>>> broken guest PEBS path.
>>> Seems this exposes a more general issue: constraints derived from
>>> host capabilities may not be applicable to a guest, since the guest may
>>> only has a subset of the host capabilities.
>>>
>>> For example, an event could be constrained to GP counter 7, while that
>>> counter is not exposed to the guest. Currently this is not gated and
>>> failures may only surface later during event programming.
>> Yes, but just for these pre-defined static constraints, it won't really
>> cause issue. If an event is constrained to GP counter 7 but there is no
>> such counter, then the event won't be really scheduled and enabled on the
>> counter. 
> In this hypothetical case, currently the guest perf driver assumes GP7
> is available, schedules and programs the event, until the hypervisor
> yells, right?

If the guest doesn't support GP7, then the event won't be really scheduled
and enabled eventually. The function intel_pmu_check_event_constraints()
would bitwised & all constraints with the counters mask. If there is no
intersection, the event won't be scheduled on any counter.

```

static void intel_pmu_check_event_constraints(struct event_constraint
*event_constraints,
                          u64 cntr_mask,
                          u64 fixed_cntr_mask,
                          u64 intel_ctrl)
{

......

c->idxmsk64 &= cntr_mask | (fixed_cntr_mask << INTEL_PMC_IDX_FIXED);
c->weight = hweight64(c->idxmsk64);

}

```


>
>
>>> Instead of dropping the constraints, should we validate counter
>>> availability in intel_pebs_constraints() or
>>> intel_get_event_constraints(), etc., and in a more generic way?
>> Yes, this is actually what the previous version did. In previous version,
>> we would leverage the dynamic constraints to limit the events additionally,
>> but just think twice, it's not best and simplest way to handle this issue.
>> It needs to allocate extra memory to store the dynamic constraints.
> I vote for dynamic constraints to resolve this issue in a generic way.
> Can we make use of the existing cpuc->constraint_list to do this?

Yes, this is what the previous version did. But currently
cpuc->constraint_list is only allocated when pmu version >= 6, so we have
to allocate the cpuc->constraint_list for all the cases that doesn't
support PMU_FL_PEBS_ALL. However PMU_FL_PEBS_ALL is set in multiple places,
it won't be easy to find a good place to allocate the
cpuc->constraint_list. It needs to introduce some ugly changes ...

Besides, it's still not the way to solve the issue as its root. Since these
PEBS constraints are unnecessary, why not to delete them and fix it as its
root?

Thanks.


>>>
>>>> This is safe because, in pebs_baseline-capable cases, PEBS constraint
>>>> lookup already falls back to non-PEBS constraints when needed, and
>>>> fixed-counter constraints are effectively shared there.
>>> Can it really be removed without any consequences?
>>>
>>> If it is architecturally required that INST_RETIRED.PREC_DIST must run
>>> on fixed counter 0, then the constraint should be preserved. I think.
>> "INST_RETIRED.PREC_DIST" would still be constrained to fixed counter 0 by
>> the non-PEBS constraints, like the below constraints in corresponding
>> intel_icl_event_constraints[].
>>
>> ```
>>
>> static struct event_constraint intel_icl_event_constraints[] = {
>>     FIXED_EVENT_CONSTRAINT(0x00c0, 0),    /* INST_RETIRED.ANY */
>>     FIXED_EVENT_CONSTRAINT(0x01c0, 0),    /* old INST_RETIRED.PREC_DIST */
>>     FIXED_EVENT_CONSTRAINT(0x0100, 0),    /* pseudo INST_RETIRED.ANY */
>>
>>    ......
>>
>> ```
>>
>> Currently as long as the PMU support PMU_FL_PEBS_ALL flag (adaptive PEBS
>> and arch-PEBS), if an event can't find the corresponding constraints for
>> PEBS constraints table, then it would fallback to the non-PEBS constraints,
>> like below code in intel_pebs_constraints() shows,
>>
>> ```
>>
>>     /*
>>      * Extended PEBS support
>>      * Makes the PEBS code search the normal constraints.
>>      */
>>     if (x86_pmu.flags & PMU_FL_PEBS_ALL)
>>         return NULL;
>>
>> ```
>>
>> If PMU doesn't support PMU_FL_PEBS_ALL flag on adaptive PEBS or arch-PEBS
>> hardware base, just like what currently KVM guest does, the PEBS
>> functionality is actually broken, and PEBS events should not be enabled.
>>
>> Thanks.
>>
>>
>>>
>>>> Reported-by: Yi Lai <yi1.lai@intel.com>
>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>> ---
>>>>  arch/x86/events/intel/ds.c | 13 -------------
>>>>  1 file changed, 13 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>>>> index cb72af9b61ce..5db15a92017a 100644
>>>> --- a/arch/x86/events/intel/ds.c
>>>> +++ b/arch/x86/events/intel/ds.c
>>>> @@ -1447,10 +1447,6 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
>>>>  };
>>>>  
>>>>  struct event_constraint intel_icl_pebs_event_constraints[] = {
>>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x100000000ULL),	/* old INST_RETIRED.PREC_DIST */
>>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
>>>> -
>>>>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
>>>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
>>>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
>>>> @@ -1473,9 +1469,6 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
>>>>  };
>>>>  
>>>>  struct event_constraint intel_glc_pebs_event_constraints[] = {
>>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>>>> -
>>>>  	INTEL_FLAGS_EVENT_CONSTRAINT(0xc0, 0xfe),
>>>>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xfe),
>>>>  	INTEL_PSD_CONSTRAINT(0x2cd, 0x1),
>>>> @@ -1500,9 +1493,6 @@ struct event_constraint intel_glc_pebs_event_constraints[] = {
>>>>  };
>>>>  
>>>>  struct event_constraint intel_lnc_pebs_event_constraints[] = {
>>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>>>> -
>>>>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
>>>>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
>>>>  
>>>> @@ -1534,9 +1524,6 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
>>>>  };
>>>>  
>>>>  struct event_constraint intel_pnc_pebs_event_constraints[] = {
>>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>>>> -
>>>>  	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0xfc),
>>>>  	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
>>>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
