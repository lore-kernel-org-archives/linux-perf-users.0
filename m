Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9181547C0;
	Wed, 16 Apr 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832729; cv=none; b=f0lf6xaMHfk803v+VXEbS75NsCb2dch/dtez0oVp6i+Ox5ZzG7bbWybi6IgUmlGvsL/2BAZC78eO2qd3KGBs30jaPS5LSIGu9NfVCOyJnA5KYcLoFlo4LNQOqnuPzZu04cBzcSc+FeTxzA867Tgic0e43HIHBBK12rLa0noi+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832729; c=relaxed/simple;
	bh=SnOLQuJuhzY6tBls03Lca2ZUkw8w57uXybR6W83oisU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jk4yzYfArrGDBxys+FTAMPxGH0QPvhYlniddUhetgbKeMirPdDJaTjGW7yiC8kcXBd2S9wNRYb99KCRhkYfGK3p+/ayCZ6gyVQemQoDoHJEVpXmaigYZg+7f/Gt5LgluUk5uWKfXh9/7vkfbLosUKbXMcR06Dz4QP+UDGBEyl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUua5sa/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUua5sa/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744832727; x=1776368727;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SnOLQuJuhzY6tBls03Lca2ZUkw8w57uXybR6W83oisU=;
  b=aUua5sa/ciY5I+//RtS5+KwhaQXdJIGdrKe1tM96dPDd0FdcqKdLLgEP
   +439nAaUDhz0F+4hIU8edLgFLoLapdZOOHbKE26x0VpFLo5jqseMpR4e5
   FbkV/VeL5dFVYtltW28KXQ1ntitdo0CyT3IUqUtIeNbk3/UW4JXMiyEVp
   xGCopDOePL8eT9g20wGugXimgK2kyBziw19qwYsdvUabevwQNPDiaqhZF
   Np2ZNRAcZafR2tTv3FBvJ+5uTxaIjWtHhFTzVpAAj8yncCFeBZPK4xcUT
   ozylP8psD8063zURXBbVXep97IdGyEkgtSIh5ayYPC+sJJ/HGtufz7rkR
   A==;
X-CSE-ConnectionGUID: H58EIM/dTCugcF2KPdQDdg==
X-CSE-MsgGUID: ER0K8C2VTu6XOp1uM81P/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46323156"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46323156"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 12:45:27 -0700
X-CSE-ConnectionGUID: 8Fv0wGWhRs6lr3TTHEXLlQ==
X-CSE-MsgGUID: JhoB8xUjTSqFVOyAPEJuwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130535123"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 12:45:27 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5387120B5736;
	Wed, 16 Apr 2025 12:45:25 -0700 (PDT)
Message-ID: <e0b25b3e-aec0-4c43-9ab2-907186b56c71@linux.intel.com>
Date: Wed, 16 Apr 2025 15:45:24 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 12/22] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-13-dapeng1.mi@linux.intel.com>
 <20250415135323.GC4031@noisy.programming.kicks-ass.net>
 <607b1f13-1d5d-4ea7-b0ab-f4c7f4fa319b@linux.intel.com>
 <20250416153226.GC17910@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250416153226.GC17910@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-16 11:32 a.m., Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 12:31:03PM -0400, Liang, Kan wrote:
> 
>>> This can land us in EVENT_CONSTRAINT_OVERLAP territory, no?
> 
>> The dyn_constraint is a supplement of the static constraints. It doesn't
>> overwrite the static constraints.
> 
> That doesn't matter.
> 
>> In the intel_get_event_constraints(), perf always gets the static
>> constraints first. If the dyn_constraint is defined, it gets the common
>> mask of the static constraints and the dynamic constraints. All
>> constraint rules will be complied.
>>
>> 	if (event->hw.dyn_constraint != ~0ULL) {
>> 		c2 = dyn_constraint(cpuc, c2, idx);
>> 		c2->idxmsk64 &= event->hw.dyn_constraint;
>> 		c2->weight = hweight64(c2->idxmsk64);
>> 	}
> 
> Read the comment that goes with EVENT_CONSTRAINT_OVERLAP().
> 
> Suppose we have (from intel_lnc_event_constraints[]):
> 
>   INTEL_UEVENT_CONSTRAINT(0x012a, 0xf)
>   INTEL_EVENT_CONSTRAINT(0x2e, 0x3ff)
> 
> Then since the first is fully contained in the latter, there is no
> problem.
> 
> Now imagine PEBS gets a dynamic constraint of 0x3c (just because), and
> then you try and create a PEBS event along with the above two events,
> and all of a sudden you have:
> 
> 	0x000f
> 	0x003c
> 	0x03ff
> 
> And that is exactly the problem case.
> 
> Also, looking at that LNC table, please explain:
> 
>   INTEL_UEVENT_CONSTRAINT(0x01cd, 0x3fc)
> 
> that looks like the exact thing I've asked to never do, exactly because
> of the above problem :-(

I see. I think we can check the constraint table and update the overlap
bit accordingly. Similar to what we did in the
intel_pmu_check_event_constraints() for the fixed counters.

I'm thinking something as below (Just a POC, not tested.)

For the static table, set the overlap for the events that may trigger
the issue at init time.
For the dynamic constraint, add a dyn_overlap_mask to track if overlap
is required for the feature (The below only supports the branch
counters. The ACR and ARCH PEBS can be added later.) If it's required,
set a flag PERF_X86_EVENT_OVERLAP for the event when the dyn_constraint
is applied. The overlap bit will be set at runtime.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 16f8aea33243..76a03a0c28e9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3825,6 +3825,8 @@ intel_get_event_constraints(struct cpu_hw_events
*cpuc, int idx,
 		c2 = dyn_constraint(cpuc, c2, idx);
 		c2->idxmsk64 &= event->hw.dyn_constraint;
 		c2->weight = hweight64(c2->idxmsk64);+		if (event->hw.flags &
PERF_X86_EVENT_OVERLAP)
+			c2->overlap = 1;
 	}

 	return c2;
@@ -4197,6 +4199,12 @@ static inline void
intel_pmu_set_acr_caused_constr(struct perf_event *event,
 		event->hw.dyn_constraint &= hybrid(event->pmu, acr_cause_mask64);
 }

+enum dyn_overlap_bits {
+       DYN_OVERLAP_BRANCH_CNTR
+};
+
+static unsigned long dyn_overlap_mask;
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -4261,6 +4269,8 @@ static int intel_pmu_hw_config(struct perf_event
*event)
 		if (branch_sample_counters(leader)) {
 			num++;
 			leader->hw.dyn_constraint &= x86_pmu.lbr_counters;
+			if (test_bit(DYN_OVERLAP_BRANCH_CNTR, &dyn_overlap_mask);
+				leader->hw.flags |= PERF_X86_EVENT_OVERLAP;
 		}
 		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;

@@ -4270,6 +4280,8 @@ static int intel_pmu_hw_config(struct perf_event
*event)
 			if (branch_sample_counters(sibling)) {
 				num++;
 				sibling->hw.dyn_constraint &= x86_pmu.lbr_counters;
+				if (test_bit(DYN_OVERLAP_BRANCH_CNTR, &dyn_overlap_mask);
+					sibling->hw.flags |= PERF_X86_EVENT_OVERLAP;
 			}
 		}

@@ -6638,6 +6650,29 @@ static void
intel_pmu_check_event_constraints(struct event_constraint *event_con
 	if (!event_constraints)
 		return;

+	for_each_event_constraint(c, event_constraints) {
+		if (c->weight == 1 || c->overlap)
+			continue;
+
+		/*
+		 * The counter mask of an event is not a subset of
+		 * the counter mask of a constraint with an equal
+		 * or higher weight. The overlap flag must be set.
+		 */
+		for_each_event_constraint(c2, event_constraints) {
+			if ((c2->weight >= c->weight) &&
+			    (c2->idxmsk64 | c->idxmsk64) != c2->idxmsk64) {
+				c->overlap = 1;
+				break;
+			}
+		}
+
+		/* Check for the dynamic constraint */
+		if (c->weight >= HWEIGHT(x86_pmu.lbr_counters) &&
+		    (c->idxmsk64 | x86_pmu.lbr_counters) != c->idxmsk64)
+ 			__set_bit(DYN_OVERLAP_BRANCH_CNTR, &dyn_overlap_mask);
+	}
+
 	/*
 	 * event on fixed counter2 (REF_CYCLES) only works on this
 	 * counter, so do not extend mask to generic counters


Thanks,
Kan
