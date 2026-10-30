Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793325250;
	b=f7kv1r29uxOfuYWQ0LYQCMMP4mf7ae2NbLpETBHrRT88fobaQyhJM3gIJcdp/aSCboiR
	 dH4qILcsbdJKOqCI2f6TV91UZwyDTUuYfRNVEX/yQ4JTzr5ra26t0eLNr3MFSVdLVuO0t
	 MoaB74ong+8MYkHTdKJBiyUdb8pscv9fF7kAYZebuFXhxWV3BRtSon681JIQ5SVva3+2k
	 EDKmKKU6q40pFpwxR3UsvHiOMDPhiHeGlZ9XhN5mmpnWE4Z4pyXV/ZfwyX5n+1l3rVG/Z
	 KbnQXu2k/Xk9OWDs3JTmkEV3bUhM8Ch1GW50fg2Xdkni/q1XiWhXJ/Ta2g9yI9Gw3dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793325250;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wjYBg1Q3ywUgJOXezyyx9SMfSiikbjh5B+4doKRv9VM=;
	b=PmCI0NsJC4mLV6CFA+EPmqG2+VR8ACQdwjz0CH7Uth22a+HFMpyJ9uZ/1Hz+k58vUKp6
	 eR5HcK7BhUuse8EIpxLW4/2elPjYFs683iaamdoBuElztdL0jYSzB2CH+epoEvaNVQD75
	 YZPyVPzQUiB+NqEgMh7lX30gBxmHqBPcNsmpr9vvIDGw4WAe2e2xFP5iJO7KHScOl8U3X
	 0Weum1NYV75I/8EBCc3XuGQDV19RspJjzJn1+IhL9oZLJlNfvmvsRFMCHc7N/CEWiHJjB
	 feWTVUPYHsxYjKWGcVd/kuvuua+4DwVraCRp2KwZUi1dxas0ftv6jwwTzXWbrzNghDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TCKeH0vy;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC6606A31A;
	Fri, 30 Oct 2026 01:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCC6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TCKeH0vy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793325250; x=1824861250;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=REeXOz4sxQCQ6S4TlzCm7TyFzr3t4SgdXimPEAI77bo=;
  b=TCKeH0vy/zKy25PvDbwZAkaDkwnEUxRRegqsuvwNhOy8sOr/wtP+PQ8Y
   DRfFgpla16UHW9EAVYtsrqk2xk560X/P1G/osgk30KN/uOyPoUtuutg6N
   BWhp8UzEYgv7y1I2IfqIb86a8CqoJElJUlSYq1YUYwCT85C0e78zQD+hE
   JY7uNfF1SKjYso/JtH+xwJA0YxzKEIRhi4qtvvq74O8M7yF6h1wJ4EAMe
   IZJJcq9Q3n5HSWiW/egWTQYQPamjgogqeT6sFFw3J3H7v3x8oGig6Bj9w
   ullr4swX/JnHeRKYmJVxdv9D8uCSdEo2geEJwAl0LBMuxvzzyUSTLW7KF
   w==;
X-CSE-ConnectionGUID: 9+MgzHF7SC6VlwBlP63PBw==
X-CSE-MsgGUID: nxp8oCDhReK8NgUCbUtA3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2113422"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2113422"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:54:09 -0700
X-CSE-ConnectionGUID: aLxr/I6SQ+ePb8eOrTnCrA==
X-CSE-MsgGUID: l+X3zpCqTdyIzQScZZqcrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5427760"
Received: from unknown (HELO [10.238.2.61]) ([10.238.2.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:54:04 -0700
Message-ID: <16441880-1831-4741-ac90-02e5f662435d@linux.intel.com>
Date: Fri, 30 Oct 2026 09:54:02 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 13/18] perf/x86/intel: Refresh LBR stack for non-PEBS
 LBR events if needed
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-14-dapeng1.mi@linux.intel.com>
 <20261029110046.GO1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261029110046.GO1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/29/2026 7:00 PM, Peter Zijlstra wrote:
> On Thu, Oct 29, 2026 at 12:39:09PM +0800, Dapeng Mi wrote:
>> PEBS and non-PEBS events currently share the same LBR stack,
>> cpuc->lbr_stack. In the PMI handler, the non-PEBS path refreshes the
>> LBR state before the PEBS buffer is drained.
>>
>> When PEBS and non-PEBS LBR events overflow in the same PMI, draining the
>> PEBS buffer can overwrite the shared LBR stack with the PEBS snapshot.
>> This leaves stale LBR data from the PEBS record in place, and userspace
>> may observe the wrong branch stack instead of the live LBR state at PMI
>> entry.
>>
>> Add a lbr_need_update flag to indicate when the LBR state must be
>> refreshed. If PEBS events and non-PEBS LBR events overflow in the same
>> PMI, set this flag so the non-PEBS LBR event refreshes the live LBR
>> state. Since the LBR state is frozen for the duration of PMI handling, it
>> only needs to be read once even when multiple non-PEBS LBR events
>> overflow in the same PMI.
>>
>> Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 23 ++++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 110fff65bd50..37f304a1b48c 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3863,8 +3863,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  {
>>  	struct perf_sample_data data;
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> -	int bit;
>> +	bool lbr_need_update = false;
>>  	int handled = 0;
>> +	int bit;
>>  
>>  	inc_perf_irq_stat();
>>  
>> @@ -3929,6 +3930,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
>>  		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
>>  			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
>> +
>> +		lbr_need_update = true;
>>  	}
>>  
>>  	/*
>> @@ -3944,6 +3947,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
>>  		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
>>  			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
>> +
>> +		lbr_need_update = true;
>>  	}
>>  
>>  	/*
>> @@ -4002,8 +4007,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  		 *
>>  		 * The PEBS buffer has to be drained before handling the A-PMI
>>  		 */
>> -		if (is_pebs_counter_event_group(event))
>> +		if (is_pebs_counter_event_group(event)) {
>>  			static_call(x86_pmu_drain_pebs)(regs, &data);
>> +			/*
>> +			 * Draining the PEBS buffer can overwrite the shared
>> +			 * LBR stack, so mark lbr_need_update as true.
>> +			 */
>> +			lbr_need_update = true;
>> +		}
>>  
>>  		last_period = event->hw.last_period;
>>  
>> @@ -4012,8 +4023,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  
>>  		perf_sample_data_init(&data, 0, last_period);
>>  
>> -		if (has_branch_stack(event))
>> +		if (has_branch_stack(event)) {
>> +			if (lbr_need_update) {
>> +				intel_pmu_lbr_read(&cpuc->lbr_stack,
>> +					cpuc->lbr_entries, cpuc->lbr_counters);
>> +				lbr_need_update = false;
>> +			}
>>  			intel_pmu_lbr_save_brstack(&data, cpuc, event);
>> +		}
>>  
>>  		x86_pmu_clear_perf_regs(regs);
>>  		x86_pmu_update_perf_regs(event, &data, regs, false);
> Or... you move intel_pmu_lbr_read() from handle_irq() into pmi_common()
> after we done the PEBS things?

Yes, I ever tried to do that, but I found it would break the PEBS LBR
sampling on the platforms prior to ICE LAKE. The PEBS doesn't support
snapshot LBR stack on these old platforms, so PMI handler has to snapshot
the LBR stack before draining the PEBS buffer.

See below code in setup_pebs_fixed_sample_data().

    /*
     * v3 supplies an accurate time stamp, so we use that
     * for the time stamp.
     *
     * We can only do this for the default trace clock.
     */
    if (x86_pmu.intel_cap.pebs_format >= 3)
        setup_pebs_time(event, data, pebs->tsc);

    perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);


Thanks.


