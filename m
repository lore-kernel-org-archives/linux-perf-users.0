Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997626ED3C;
	Mon,  8 Jun 2026 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933574; cv=none; b=W/w+vjDG5uPHB+apGVqXlB834yLGTK2D6pcJKxqTeCstskiPc7/ady9bKmrbDgIvr+iQcYfZrVkMxZ4rcFMjak/BUnMxb0pJxo49LvhsVIQLx1h6U/x5udt+6qDsODRGjX/9NtE3Jec/dDu6kOMke7JhowgeGyHdliepoztRkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933574; c=relaxed/simple;
	bh=TR48feHB7pndFSwuomxYyRBTuclHwZOZh4jbQkOhIRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9i6eKBngMckSibfez+JleQwC4oyiy+G19l6mFvn0pMVf+2tIyxLcSdzFAxMX4xKLEh1On5Ufb94VJ9kRBbARH2Sx91qDTl8VJFUhZ2zQtn6vLJubKau8jN+kVJR3hWvCU85wGf1WHfleQLVoQdaYjhCDqHdbCo+pF9mVjTeVPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLWnto/0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLWnto/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780933572; x=1812469572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TR48feHB7pndFSwuomxYyRBTuclHwZOZh4jbQkOhIRk=;
  b=YLWnto/0sMDhW3it9GSVGZfhgnZw6X5i/857AdYnFLWjpY0FEtNtsVGo
   fXphnqQTShCPMYsZm7cpWitcU1A0GckgLRF5dSZ6TWlvCA/a4oOhV+aKR
   4YQju0ikrhNuJ3CgnJAtmVF9V1fzQ27F/JLxQfcunZ0FNZZgIIgzaYhsn
   O8gn/A9skC6ojZJwPZbUmPtYqQAM9PtpwRodriEIj2iwN1WqfEkgUmDW7
   gQa3V2+EGmSsF68StMXcODtNy/glg2LhX87L7iVs8DKGlKzPPLCYnxjc6
   8KWIPcMHdU7h/GR9i3X0Zzklbif+10Opxn5dTZDwppk1g0RGDCN0il1rq
   g==;
X-CSE-ConnectionGUID: YnSk9V6WSOWr2ueJrE02xA==
X-CSE-MsgGUID: kuB5wOSbSsKNiHQdS6MA8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81647425"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81647425"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:46:11 -0700
X-CSE-ConnectionGUID: 5wm2flJqQPGpI2NrIjHeZw==
X-CSE-MsgGUID: B+HFWzrKSAKHtUqC5pcMrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="243146340"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:46:10 -0700
Message-ID: <17cc1e8c-84ed-459e-8b8b-dd1d52261105@intel.com>
Date: Mon, 8 Jun 2026 10:46:09 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] perf/x86/intel: Drop fixed-counter PEBS constraints
 for baseline PEBS
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <64abd498-8ce2-45fa-b41e-c95aa0bc8b40@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/7/2026 9:46 PM, Mi, Dapeng wrote:
> 
> On 6/6/2026 4:32 AM, Chen, Zide wrote:
>>
>> On 6/4/2026 8:11 PM, Dapeng Mi wrote:
>>> On SPR guests where pebs_baseline is not advertised, running:
>>>
>>> $ ./perf record -e cpu/event=0x00,umask=0x01,i\
>>> 	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1
>>>
>>> can trigger:
>>>
>>> unchecked MSR access error: WRMSR to 0x3f1 ... in\
>>> 	 intel_pmu_pebs_enable_all()
>>>
>>> Root cause:
>>> SPR-specific PEBS constraints allow fixed-counter scheduling,
>>> for example INST_RETIRED.PREC_DIST on fixed counter 0. In guests without
>>> pebs_baseline, KVM does not support PEBS sampling on fixed counters,
>>> so enabling such events reaches an invalid MSR programming path.
>>>
>>> Fix:
>>> Drop fixed-counter entries from the PEBS constraint table. Without
>>> pebs_baseline, those fixed-counter PEBS events now resolve to empty
>>> constraints and are not scheduled/enabled, avoiding the warning and the
>>> broken guest PEBS path.
>> Seems this exposes a more general issue: constraints derived from
>> host capabilities may not be applicable to a guest, since the guest may
>> only has a subset of the host capabilities.
>>
>> For example, an event could be constrained to GP counter 7, while that
>> counter is not exposed to the guest. Currently this is not gated and
>> failures may only surface later during event programming.
> 
> Yes, but just for these pre-defined static constraints, it won't really
> cause issue. If an event is constrained to GP counter 7 but there is no
> such counter, then the event won't be really scheduled and enabled on the
> counter. 

In this hypothetical case, currently the guest perf driver assumes GP7
is available, schedules and programs the event, until the hypervisor
yells, right?


>>
>> Instead of dropping the constraints, should we validate counter
>> availability in intel_pebs_constraints() or
>> intel_get_event_constraints(), etc., and in a more generic way?
> 
> Yes, this is actually what the previous version did. In previous version,
> we would leverage the dynamic constraints to limit the events additionally,
> but just think twice, it's not best and simplest way to handle this issue.
> It needs to allocate extra memory to store the dynamic constraints.

I vote for dynamic constraints to resolve this issue in a generic way.
Can we make use of the existing cpuc->constraint_list to do this?
>>
>>
>>> This is safe because, in pebs_baseline-capable cases, PEBS constraint
>>> lookup already falls back to non-PEBS constraints when needed, and
>>> fixed-counter constraints are effectively shared there.
>> Can it really be removed without any consequences?
>>
>> If it is architecturally required that INST_RETIRED.PREC_DIST must run
>> on fixed counter 0, then the constraint should be preserved. I think.
> 
> "INST_RETIRED.PREC_DIST" would still be constrained to fixed counter 0 by
> the non-PEBS constraints, like the below constraints in corresponding
> intel_icl_event_constraints[].
> 
> ```
> 
> static struct event_constraint intel_icl_event_constraints[] = {
>     FIXED_EVENT_CONSTRAINT(0x00c0, 0),    /* INST_RETIRED.ANY */
>     FIXED_EVENT_CONSTRAINT(0x01c0, 0),    /* old INST_RETIRED.PREC_DIST */
>     FIXED_EVENT_CONSTRAINT(0x0100, 0),    /* pseudo INST_RETIRED.ANY */
> 
>    ......
> 
> ```
> 
> Currently as long as the PMU support PMU_FL_PEBS_ALL flag (adaptive PEBS
> and arch-PEBS), if an event can't find the corresponding constraints for
> PEBS constraints table, then it would fallback to the non-PEBS constraints,
> like below code in intel_pebs_constraints() shows,
> 
> ```
> 
>     /*
>      * Extended PEBS support
>      * Makes the PEBS code search the normal constraints.
>      */
>     if (x86_pmu.flags & PMU_FL_PEBS_ALL)
>         return NULL;
> 
> ```
> 
> If PMU doesn't support PMU_FL_PEBS_ALL flag on adaptive PEBS or arch-PEBS
> hardware base, just like what currently KVM guest does, the PEBS
> functionality is actually broken, and PEBS events should not be enabled.
> 
> Thanks.
> 
> 
>>
>>
>>> Reported-by: Yi Lai <yi1.lai@intel.com>
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> ---
>>>  arch/x86/events/intel/ds.c | 13 -------------
>>>  1 file changed, 13 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>>> index cb72af9b61ce..5db15a92017a 100644
>>> --- a/arch/x86/events/intel/ds.c
>>> +++ b/arch/x86/events/intel/ds.c
>>> @@ -1447,10 +1447,6 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
>>>  };
>>>  
>>>  struct event_constraint intel_icl_pebs_event_constraints[] = {
>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x100000000ULL),	/* old INST_RETIRED.PREC_DIST */
>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
>>> -
>>>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
>>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
>>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
>>> @@ -1473,9 +1469,6 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
>>>  };
>>>  
>>>  struct event_constraint intel_glc_pebs_event_constraints[] = {
>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>>> -
>>>  	INTEL_FLAGS_EVENT_CONSTRAINT(0xc0, 0xfe),
>>>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xfe),
>>>  	INTEL_PSD_CONSTRAINT(0x2cd, 0x1),
>>> @@ -1500,9 +1493,6 @@ struct event_constraint intel_glc_pebs_event_constraints[] = {
>>>  };
>>>  
>>>  struct event_constraint intel_lnc_pebs_event_constraints[] = {
>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>>> -
>>>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
>>>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
>>>  
>>> @@ -1534,9 +1524,6 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
>>>  };
>>>  
>>>  struct event_constraint intel_pnc_pebs_event_constraints[] = {
>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>>> -
>>>  	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0xfc),
>>>  	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
>>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */

