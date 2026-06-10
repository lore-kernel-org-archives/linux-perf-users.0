Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2821CA02;
	Wed, 10 Jun 2026 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081454; cv=none; b=hBW1ou4C0+11gqsFApH553ys/l1kJem63uOnxV36hyJfoFCPhI+Ppv1qbqu9wxzw0bu50BUdqYrsckS58FzKkLBESJNeYiDrG7FgYHdUTB+PJe0X2LM7I4WE6cSCmaB/0znSjO0o8ppgwRYeNNhjYQZnSKUUASWmSCps+BHNvHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081454; c=relaxed/simple;
	bh=i1gcldGTtQKfClZF6lHPzebxU5tvhV88z86jZdXp6eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qt+BbuUV4hlHWw9EBwExSOiQLMsIeI+Q4ghCKeyR9X5o/ny2EtcqUDViRKlKNNKF3f2XSA3DeVcd+d/ifvhUF4VcRmeRyAH73j6uwNMI+Fyh5J3sYmUjiJelHVNlwvPc1AYQYJMQOvyC92vBTmh+f3IgSM2cib0A7H4IoaOYxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpDgNg5W; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpDgNg5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781081453; x=1812617453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i1gcldGTtQKfClZF6lHPzebxU5tvhV88z86jZdXp6eQ=;
  b=mpDgNg5WYg6eKWH0lXaq7ju8yUc9bN46ifuGXKRI7NGjifdVEfSQyJiT
   ZVXP+hggYfCoHghWGdr33TB+RZNYhZQpbxnQ1AR45qsCdWKQpTzvJs+zt
   WavanwO4i0HO6PZw2AIyG0eKdFuYLl3Jdvo3fPPvLXiApP08Stvz8g5PF
   IDzpTevoSvNzHqDG9iQayPZxEABwOJlU/ORmch2+slV2xGkdydeXk/Kxb
   q3bu2VoNN1v7+t4f70yhzpKeUOWrb1g6WFy0UObLoUQbGfYBeMPnYfU3L
   LwRAuY+3W8+dTGSY0vLLxHOCeh01ktPgey09PTLTR8UyiVJ2wZktnq62v
   Q==;
X-CSE-ConnectionGUID: L+mIlrzqQ96+OnY5AIa4NA==
X-CSE-MsgGUID: 7cwEvKV5Qn6oO8Y1YOGNuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="107303963"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="107303963"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 01:50:52 -0700
X-CSE-ConnectionGUID: Hk8VJTPkQ0uzB3rthCTpmA==
X-CSE-MsgGUID: YvvxHHm4Tai4xPuh+5Rsaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251030848"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 01:50:49 -0700
Message-ID: <b3485f13-039d-44d9-af02-5cea084ca304@linux.intel.com>
Date: Wed, 10 Jun 2026 16:50:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 7/9] perf/x86/intel: Drop fixed-counter PEBS
 constraints for baseline PEBS
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Yi Lai <yi1.lai@intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-8-dapeng1.mi@linux.intel.com>
 <20260610082051.GF49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260610082051.GF49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/10/2026 4:20 PM, Peter Zijlstra wrote:
> On Tue, Jun 09, 2026 at 01:02:20PM +0800, Dapeng Mi wrote:
>> On SPR guests where pebs_baseline is not advertised, running:
>>
>> $ ./perf record -e cpu/event=0x00,umask=0x01,i\
>> 	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1
>>
>> can trigger:
>>
>> unchecked MSR access error: WRMSR to 0x3f1 ... in\
>> 	 intel_pmu_pebs_enable_all()
>>
>> Root cause:
>> SPR-specific PEBS constraints allow fixed-counter scheduling,
>> for example INST_RETIRED.PREC_DIST on fixed counter 0. In guests without
>> pebs_baseline, KVM does not support PEBS sampling on fixed counters,
>> so enabling such events reaches an invalid MSR programming path.
>>
>> Fix:
>> Drop fixed-counter entries from the PEBS constraint table. Without
>> pebs_baseline, those fixed-counter PEBS events now resolve to empty
>> constraints and are not scheduled/enabled, avoiding the warning and the
>> broken guest PEBS path.
>>
>> This is safe because, in pebs_baseline-capable cases, PEBS constraint
>> lookup already falls back to non-PEBS constraints when needed, and
>> fixed-counter constraints are effectively shared there.
> I am confused, this works outside of KVM? (It appears to work fine on my
> spr).. so removing this to fix some guest only issue seems wrong.

The reason that it works on bare metal is currently the constraint lookup
would fallback into non-PEBS constraints if there is no matched entry in
the PEBS constraints as long as the PEBS supports sampling on all counters
including fixed counters (what the flag "PMU_FL_PEBS_ALL" indicates), like
the below code shows.

```

struct event_constraint *intel_pebs_constraints(struct perf_event *event)
{
    struct event_constraint *pebs_constraints = hybrid(event->pmu,
pebs_constraints);
    struct event_constraint *c;

    if (!event->attr.precise_ip)
        return NULL;

    if (pebs_constraints) {
        for_each_event_constraint(c, pebs_constraints) {
            if (constraint_match(c, event->hw.config)) {
                event->hw.flags |= c->flags;
                return c;
            }
        }
    }

    /*
     * Extended PEBS support
     * Makes the PEBS code search the normal constraints.
     */
    if (x86_pmu.flags & PMU_FL_PEBS_ALL)
        return NULL;

    return &emptyconstraint;
}

static struct event_constraint *
__intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
                struct perf_event *event)
{
    struct event_constraint *c;

    c = intel_vlbr_constraints(event);
    if (c)
        return c;

    c = intel_bts_constraints(event);
    if (c)
        return c;

    c = intel_shared_regs_constraints(cpuc, event);
    if (c)
        return c;

    c = intel_pebs_constraints(event);
    if (c)
        return c;

    return x86_get_event_constraints(cpuc, idx, event);
}

```

if intel_pebs_constraints() can't find the matched entry from PEBS
constraints and PMU_FL_PEBS_ALL is set, NULL would be returned and it would
lead to fallback the non-PEBS constraints lookup.

From Icelake starts, regardless of the extended PEBS or the arch-PEBS, all
counters including the fixed counters support PEBS  sampling and the
flag PMU_FL_PEBS_ALL would set by default.

Since the non-PEBS constraints contain the similar fixed counter
constraints, the fixed counter events would still be correctly scheduled on
the fixed counters.

for example, here is the fixed counter constraints in
intel_icl_event_constraints[],

```

static struct event_constraint intel_icl_event_constraints[] = {
    FIXED_EVENT_CONSTRAINT(0x00c0, 0),    /* INST_RETIRED.ANY */
    FIXED_EVENT_CONSTRAINT(0x01c0, 0),    /* old INST_RETIRED.PREC_DIST */
    FIXED_EVENT_CONSTRAINT(0x0100, 0),    /* pseudo INST_RETIRED.ANY */
    FIXED_EVENT_CONSTRAINT(0x003c, 1),    /* CPU_CLK_UNHALTED.CORE */
    FIXED_EVENT_CONSTRAINT(0x0200, 1),    /* pseudo CPU_CLK_UNHALTED.THREAD */
    FIXED_EVENT_CONSTRAINT(0x0300, 2),    /* pseudo CPU_CLK_UNHALTED.REF_TSC */
    FIXED_EVENT_CONSTRAINT(0x0400, 3),    /* pseudo TOPDOWN.SLOTS */

    ......

```

>
>
>> Reported-by: Yi Lai <yi1.lai@intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/ds.c | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index cb72af9b61ce..5db15a92017a 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1447,10 +1447,6 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
>>  };
>>  
>>  struct event_constraint intel_icl_pebs_event_constraints[] = {
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x100000000ULL),	/* old INST_RETIRED.PREC_DIST */
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
>> -
>>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
>> @@ -1473,9 +1469,6 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
>>  };
>>  
>>  struct event_constraint intel_glc_pebs_event_constraints[] = {
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>> -
>>  	INTEL_FLAGS_EVENT_CONSTRAINT(0xc0, 0xfe),
>>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xfe),
>>  	INTEL_PSD_CONSTRAINT(0x2cd, 0x1),
>> @@ -1500,9 +1493,6 @@ struct event_constraint intel_glc_pebs_event_constraints[] = {
>>  };
>>  
>>  struct event_constraint intel_lnc_pebs_event_constraints[] = {
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>> -
>>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
>>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
>>  
>> @@ -1534,9 +1524,6 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
>>  };
>>  
>>  struct event_constraint intel_pnc_pebs_event_constraints[] = {
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>> -
>>  	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0xfc),
>>  	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
>> -- 
>> 2.34.1
>>
