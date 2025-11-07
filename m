Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408152D3A77;
	Fri,  7 Nov 2025 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762478593; cv=none; b=lVGicZc2q2ItgTzzAj75E5rk7MhuwHiOC12xRcj0gvqwoOh+DGwEVLynW8Ts5YwkyUQwhVwfdQE+boiBZgEbcukI2DAgKzNV4CnMqygxeDhhEO1bE1tNwkVm0CDtfKmHVDD441nUMND4fjJwroa/Wp0QVJYfeIYslF8lBa7LN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762478593; c=relaxed/simple;
	bh=ES8leasSqW9ZoR54YMZJSFROShAuvmBR/iWv8r5RWNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzLE2SLkcj2r5saIkRFfM6QxTskEUvwS5IQgVrJVjWXgmgQBstYriyebeR2KNzk4d9WjKu1fxi5mLZ460cowXefYXMgEu6U0WmLmKAxXqAtzYaotU3AtDODcSyU56rhlfJF6gfU2S29FyPhz3JgN6MtSJq8Hwp/4tDYQkeIX0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrIVfE1y; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrIVfE1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762478591; x=1794014591;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ES8leasSqW9ZoR54YMZJSFROShAuvmBR/iWv8r5RWNs=;
  b=MrIVfE1yVGha2SD0abOWH4g41YLMzMrzZZZIn5y2lyDXm7ZKlMBkucsR
   56BzBLhrFZy09V/WhTsun8gVnONwqrmjQIPMvpFMxn+gnRYoMq54VT4Oe
   U/tpTL5GwnNqNR8HKbqZ8dVSaom8uMtTMNbJngE5M9GX2e+tJMC3MtL97
   k62WzGJNy9DGYbUeke99U2c+jcxNDCJlKSxJkqy9JcgTBemqgsy37IveD
   W/ly2nx2ROpP03tcJ7tqMNfuYlUnDIu37QDXdVwSW3w6E7yusfioCFgPi
   r4flMTh+WMO/nR2tH/ffm2rAGY4fKv7/pw/B3kB/+DxmVtaKm/qbIpWmn
   A==;
X-CSE-ConnectionGUID: xK6WSdPRSNaXivZjiJhObw==
X-CSE-MsgGUID: m8zWjG6wT462U0LGrX8dZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="52195631"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="52195631"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 17:23:10 -0800
X-CSE-ConnectionGUID: LxrbqWnfSc+pzUnvTjOYqA==
X-CSE-MsgGUID: pNJIK9weTKqRu9hGayn3Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="187212574"
Received: from unknown (HELO [10.241.241.201]) ([10.241.241.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 17:23:10 -0800
Message-ID: <5f84fe4f-90ef-42d6-8a3a-c1f515a7832a@intel.com>
Date: Thu, 6 Nov 2025 17:23:09 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 thomas.falcon@intel.com, dapeng1.mi@linux.intel.com, xudong.hao@intel.com
References: <20251022220802.1335131-1-zide.chen@intel.com>
 <aPrktlANBHFtV52B@google.com>
 <576a7d2b-0a82-4738-8b86-507e4d841524@intel.com>
 <aP1ucJiJYBavTHV7@google.com>
 <e10d671a-eb89-4e06-a1eb-e2f12ee41d70@intel.com>
 <aQl3qfyTdAb68l1l@google.com>
 <652bf158-ba9e-4a97-b4c3-3a7f7e39fe85@intel.com>
 <aQzugcpRvOcPEEro@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aQzugcpRvOcPEEro@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/6/2025 10:52 AM, Namhyung Kim wrote:
> On Tue, Nov 04, 2025 at 11:10:44AM -0800, Chen, Zide wrote:
>>
>>
>> On 11/3/2025 7:48 PM, Namhyung Kim wrote:
>>> Hello,
>>>
>>> Sorry for the delay.
>>>
>>> On Mon, Oct 27, 2025 at 11:56:52AM -0700, Chen, Zide wrote:
>>>>
>>>>
>>>> On 10/25/2025 5:42 PM, Namhyung Kim wrote:
>>>>> On Fri, Oct 24, 2025 at 11:03:17AM -0700, Chen, Zide wrote:
>>>>>>
>>>>>>
>>>>>> On 10/23/2025 7:30 PM, Namhyung Kim wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> On Wed, Oct 22, 2025 at 03:08:02PM -0700, Zide Chen wrote:
>>>>>>>> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
>>>>>>>> unconditionally called the precise_ip fallback and moved it after the
>>>>>>>> missing-feature checks so that it could handle EINVAL as well.
>>>>>>>>
>>>>>>>> However, this introduced an issue: after disabling missing features,
>>>>>>>> the event could fail to open, which makes the subsequent precise_ip
>>>>>>>> fallback useless since it will always fail.
>>>>>>>>
>>>>>>>> For example, run the following command on Intel SPR:
>>>>>>>>
>>>>>>>> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
>>>>>>>>
>>>>>>>> Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
>>>>>>>> precise_ip == 3. It then sets attr.inherit = false, which triggers a
>>>>>>>
>>>>>>> I'm curious about this part.  Why the kernel set 'inherit = false'?  IOW
>>>>>>> how did the leader event (mem-loads-aux) succeed with inherit = true
>>>>>>> then?
>>>>>>
>>>>>> Initially, the inherit = true for both the group leader
>>>>>> (cpu/mem-loads-aux/S) and the event in question (cpu/mem-loads,ldlat=3/PS).
>>>>>>
>>>>>> When the second event fails with EINVAL, the current logic calls
>>>>>> evsel__detect_missing_features() first. Since this is a PERF_SAMPLE_READ
>>>>>> event, the inherit attribute falls back to false, according to the
>>>>>> fallback order implemented in evsel__detect_missing_features().
>>>>>
>>>>> Right, that means the kernel doesn't support PERF_SAMPLE_READ with
>>>>> inherit = true.  How did the first event succeed to open then?
>>>>
>>>> The perf tool sets PERF_SAMPLE_TID for Inherit + PERF_SAMPLE_READ
>>>> events, as implemented in commit 90035d3cd876 ("tools/perf: Allow
>>>> inherit + PERF_SAMPLE_READ when opening event").
>>>>
>>>> Meanwhile, commit 7e8b255650fc ("perf: Support PERF_SAMPLE_READ with
>>>> inherit") rejects a perf event if has_inherit_and_sample_read(attr) is
>>>> true and PERF_SAMPLE_TID is not set in attr->sample_type.
>>>>
>>>> Therefore, the first event succeeded, while the one opened in
>>>> evsel__detect_missing_features() which doesn't have PERF_SAMPLE_TID failed.
>>>
>>> Why does the first succeed and the second fail?  Don't they have the
>>> same SAMPLE_READ and SAMPLE_TID + inherit flags?
>>
>> Sorry, my previous reply wasn’t entirely accurate. The first event
>> (cpu/mem-loads-aux/S) succeeds because it’s not a precise event
>> (precise_ip == 0).
> 
> I'm not sure how it matters.  I've tested the same command line on SPR
> and got this message.  It says it failed to open because of inherit and
> SAMPE_READ.  It didn't have precise_ip too.
> 
>   $ perf record -e cpu/mem-loads-aux/S -vv true |& less
>   ...
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4 (cpu)
>     size                             136
>     config                           0x8203 (mem-loads-aux)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|READ|ID|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     enable_on_exec                   1
>     task                             1
>     sample_id_all                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 1161023  cpu 0  group_fd -1  flags 0x8
>   sys_perf_event_open failed, error -22
>   Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
>   ...
> 
> And it fell back to no-inherit and succeeded.  

On my SPR, with either kernel 6.18.0-rc4 or the older 6.17.0-rc6, my
test results are different from yours — I didn’t see any EINVAL, and
there was no fallback. :)

It’s strange, but even so, since there’s no group leader in this case, I
assume that when it falls back to non-inherit, it should pass the
following check.

        if (task && group_leader &&
            group_leader->attr.inherit != attr.inherit) {
                err = -EINVAL;
                goto err_task;
        }

> I've also found that it
> worked even with precise_ip = 3.
> 
>   $ perf record -e cpu/mem-loads-aux/PS -vv true |& less
>   ...
>   sys_perf_event_open: pid 1172834  cpu 0  group_fd -1  flags 0x8
>   sys_perf_event_open failed, error -22
>   Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4 (cpu)
>     size                             136
>     config                           0x8203 (mem-loads-aux)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|READ|ID|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     mmap                             1
>     comm                             1
>     freq                             1
>     enable_on_exec                   1
>     task                             1
>     precise_ip                       3         <<<---- here
>     sample_id_all                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 1172834  cpu 0  group_fd -1  flags 0x8 = 4
>   ...

Again, on my machine, I didn’t see EINVAL, and no fallback to
non-inherit. In my test, glc_get_event_constraints() successfully forces
this event (config == 0x8203) to fixed counter 0, so there’s no issue here.

> And it works fine on my machine.
> 
>   $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}' ls
>   ...
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.033 MB perf.data (6 samples) ]

I don't know why it works for you, but in my tests, this event:

Opening: cpu/mem-loads/PS
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu)
  size                             248
  config                           0x1cd
(mem_trans_retired.load_latency_gt_1024)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|READ|ID|PERIOD
  read_format                      ID|GROUP|LOST
  inherit                          1
  freq                             1
  precise_ip                       3
  sample_id_all                    1
  { bp_addr, config1 }             0x3
------------------------------------------------------------

It gets emptyconstraint, then it can't schedule the event on any counter
and x86_schedule_events() returns -EINVAL.

glc_get_event_constraints()
{
        struct event_constraint *c;
	
	// It gets the constraint INTEL_PLD_CONSTRAINT(0x1cd, 0xfe)
	// from intel_pebs_constraints(),
        c = icl_get_event_constraints(cpuc, idx, event);

	// When it tries to force :ppp event to fixed counter 0
        if ((event->attr.precise_ip == 3) &&
            !constraint_match(&fixed0_constraint, event->hw.config)) {

		// It happens the constrain doesn't mask fixed counter 0
                if (c->idxmsk64 & BIT_ULL(0)) {
                        return &counter0_constraint;
		
		// It gets here.
                return &emptyconstraint;
        }

        return c;
}

After that, it falls back to non-inherit, and it fails again because the
inherit attribute differs from the group leader’s. This carries over to
the precise_ip fallback path in the current code.

>>
>> The second event fails with -EINVAL because, on some platforms, events
>> with precise_ip = 3 must be scheduled on fixed counter 0, and it fails
>> if it happens that this counter is unavailable.
>>
>> In the current code, the first fallback attempt (inherit = 0) also fails
>> because the inherit attribute differs from that of the group leader
>> (first event).
> 
> So I don't understand this.  Either the first event failed due to
> inherit set or the second event should succeed with inherit.  Maybe
> there's an unknown bug or something.
> 
> Thanks,
> namhyung
> 

