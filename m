Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B829B2E54DE;
	Tue, 11 Nov 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888310; cv=none; b=hsctt8FOPbW+GEPTBXDRqjUBmVNhXWxDTZjz3Ijvte5x2fktFymEoVEc7aiujQajOP0I2Ni9ULqKjW9DwDf0lgPosmkdYmICum4Eak7lG1yBgWoIltdlvECtmqHS8n+xAHvjDcfFpgbXlvfXlCXDalYIBMb2g3RcB+XYI73eS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888310; c=relaxed/simple;
	bh=nnSA4tfVh04rUX3p5cE2boYz6H70AcmJnpFrjoOh8eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmHONhDf38uyArJXrN+ENIDhciWwIJh8hi3dW8P3lyFgJ7Q6v4iqSKTSVMvP89OtoHTks9ix7K0HXmIRYsNt/faD0Iw+ZAf/q0yd/pMyLsV5+xJv61kbTplNnf59P5WzQbqQxn2OyMxdMUARsYVcHVG9xI2tMDXiN41n/5t9gdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4ZxhBHf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4ZxhBHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762888309; x=1794424309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nnSA4tfVh04rUX3p5cE2boYz6H70AcmJnpFrjoOh8eE=;
  b=Z4ZxhBHf/rDZ5kvg5m2mROiHJAJgGxA9B8hkJQRYTFgO5hdZr9XCZdZT
   VfUBoWgkNK+zLLWzpfDUByfGe/u85K6bm5QTLs40F9ShpVScrtgGyOs2y
   HvYqyK4OeL9PeCpyeQDaObOXc4s/el9IoHlBtK2Q1b9RBIiNMxSWEyAKq
   Sr/1EwLb8IiXVnWmPdlC85YWf2fEqthvjUBXBGJ9jcuxMgr551/H8Ugj3
   2ubWah3DpgQ53qYpiO+eS69yd3vciQyxwyM8QTsb0htCKcm2jUukQsz4d
   hIiGd7CZppwd/VbwMKbQsqKqymq7e3QV2+kUS/eZoCSaQOvasL9cqVn3l
   A==;
X-CSE-ConnectionGUID: e0O0nHZfTyO+TnEB7+pfSQ==
X-CSE-MsgGUID: 407R23W8QqWX6+oSOswMFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="87585382"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="87585382"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 11:11:47 -0800
X-CSE-ConnectionGUID: dn5IFtZ1RJ+lGtI7S4Q61Q==
X-CSE-MsgGUID: wOatWAS9R4ep5i9Qt1bpJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="189758567"
Received: from aksajnan-mobl1.amr.corp.intel.com (HELO [10.125.50.87]) ([10.125.50.87])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 11:11:46 -0800
Message-ID: <42bafd4d-ff6e-4529-95f7-9c4c963fc49c@intel.com>
Date: Tue, 11 Nov 2025 11:11:45 -0800
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
References: <aPrktlANBHFtV52B@google.com>
 <576a7d2b-0a82-4738-8b86-507e4d841524@intel.com>
 <aP1ucJiJYBavTHV7@google.com>
 <e10d671a-eb89-4e06-a1eb-e2f12ee41d70@intel.com>
 <aQl3qfyTdAb68l1l@google.com>
 <652bf158-ba9e-4a97-b4c3-3a7f7e39fe85@intel.com>
 <aQzugcpRvOcPEEro@google.com>
 <5f84fe4f-90ef-42d6-8a3a-c1f515a7832a@intel.com>
 <aQ5n4ML9lxY4VAxi@google.com>
 <eb41cde1-9611-4998-a82f-5d6efb80b0d1@intel.com>
 <aRLq0isFxDJlsHlL@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aRLq0isFxDJlsHlL@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/10/2025 11:50 PM, Namhyung Kim wrote:
> On Fri, Nov 07, 2025 at 02:31:23PM -0800, Chen, Zide wrote:
>>
>>
>> On 11/7/2025 1:42 PM, Namhyung Kim wrote:
>>> On Thu, Nov 06, 2025 at 05:23:09PM -0800, Chen, Zide wrote:
>>>>
>>>>
>>>> On 11/6/2025 10:52 AM, Namhyung Kim wrote:
>>>>> On Tue, Nov 04, 2025 at 11:10:44AM -0800, Chen, Zide wrote:
>>>>>>
>>>>>>
>>>>>> On 11/3/2025 7:48 PM, Namhyung Kim wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> Sorry for the delay.
>>>>>>>
>>>>>>> On Mon, Oct 27, 2025 at 11:56:52AM -0700, Chen, Zide wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 10/25/2025 5:42 PM, Namhyung Kim wrote:
>>>>>>>>> On Fri, Oct 24, 2025 at 11:03:17AM -0700, Chen, Zide wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 10/23/2025 7:30 PM, Namhyung Kim wrote:
>>>>>>>>>>> Hello,
>>>>>>>>>>>
>>>>>>>>>>> On Wed, Oct 22, 2025 at 03:08:02PM -0700, Zide Chen wrote:
>>>>>>>>>>>> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
>>>>>>>>>>>> unconditionally called the precise_ip fallback and moved it after the
>>>>>>>>>>>> missing-feature checks so that it could handle EINVAL as well.
>>>>>>>>>>>>
>>>>>>>>>>>> However, this introduced an issue: after disabling missing features,
>>>>>>>>>>>> the event could fail to open, which makes the subsequent precise_ip
>>>>>>>>>>>> fallback useless since it will always fail.
>>>>>>>>>>>>
>>>>>>>>>>>> For example, run the following command on Intel SPR:
>>>>>>>>>>>>
>>>>>>>>>>>> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
>>>>>>>>>>>>
>>>>>>>>>>>> Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
>>>>>>>>>>>> precise_ip == 3. It then sets attr.inherit = false, which triggers a
>>>>>>>>>>>
>>>>>>>>>>> I'm curious about this part.  Why the kernel set 'inherit = false'?  IOW
>>>>>>>>>>> how did the leader event (mem-loads-aux) succeed with inherit = true
>>>>>>>>>>> then?
>>>>>>>>>>
>>>>>>>>>> Initially, the inherit = true for both the group leader
>>>>>>>>>> (cpu/mem-loads-aux/S) and the event in question (cpu/mem-loads,ldlat=3/PS).
>>>>>>>>>>
>>>>>>>>>> When the second event fails with EINVAL, the current logic calls
>>>>>>>>>> evsel__detect_missing_features() first. Since this is a PERF_SAMPLE_READ
>>>>>>>>>> event, the inherit attribute falls back to false, according to the
>>>>>>>>>> fallback order implemented in evsel__detect_missing_features().
>>>>>>>>>
>>>>>>>>> Right, that means the kernel doesn't support PERF_SAMPLE_READ with
>>>>>>>>> inherit = true.  How did the first event succeed to open then?
>>>>>>>>
>>>>>>>> The perf tool sets PERF_SAMPLE_TID for Inherit + PERF_SAMPLE_READ
>>>>>>>> events, as implemented in commit 90035d3cd876 ("tools/perf: Allow
>>>>>>>> inherit + PERF_SAMPLE_READ when opening event").
>>>>>>>>
>>>>>>>> Meanwhile, commit 7e8b255650fc ("perf: Support PERF_SAMPLE_READ with
>>>>>>>> inherit") rejects a perf event if has_inherit_and_sample_read(attr) is
>>>>>>>> true and PERF_SAMPLE_TID is not set in attr->sample_type.
>>>>>>>>
>>>>>>>> Therefore, the first event succeeded, while the one opened in
>>>>>>>> evsel__detect_missing_features() which doesn't have PERF_SAMPLE_TID failed.
>>>>>>>
>>>>>>> Why does the first succeed and the second fail?  Don't they have the
>>>>>>> same SAMPLE_READ and SAMPLE_TID + inherit flags?
>>>>>>
>>>>>> Sorry, my previous reply wasn’t entirely accurate. The first event
>>>>>> (cpu/mem-loads-aux/S) succeeds because it’s not a precise event
>>>>>> (precise_ip == 0).
>>>>>
>>>>> I'm not sure how it matters.  I've tested the same command line on SPR
>>>>> and got this message.  It says it failed to open because of inherit and
>>>>> SAMPE_READ.  It didn't have precise_ip too.
>>>>>
>>>>>   $ perf record -e cpu/mem-loads-aux/S -vv true |& less
>>>>>   ...
>>>>>   ------------------------------------------------------------
>>>>>   perf_event_attr:
>>>>>     type                             4 (cpu)
>>>>>     size                             136
>>>>>     config                           0x8203 (mem-loads-aux)
>>>>>     { sample_period, sample_freq }   4000
>>>>>     sample_type                      IP|TID|TIME|READ|ID|PERIOD
>>>>>     read_format                      ID|LOST
>>>>>     disabled                         1
>>>>>     inherit                          1
>>>>>     mmap                             1
>>>>>     comm                             1
>>>>>     freq                             1
>>>>>     enable_on_exec                   1
>>>>>     task                             1
>>>>>     sample_id_all                    1
>>>>>     mmap2                            1
>>>>>     comm_exec                        1
>>>>>     ksymbol                          1
>>>>>     bpf_event                        1
>>>>>   ------------------------------------------------------------
>>>>>   sys_perf_event_open: pid 1161023  cpu 0  group_fd -1  flags 0x8
>>>>>   sys_perf_event_open failed, error -22
>>>>>   Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
>>>>>   ...
>>>>>
>>>>> And it fell back to no-inherit and succeeded.  
>>>>
>>>> On my SPR, with either kernel 6.18.0-rc4 or the older 6.17.0-rc6, my
>>>> test results are different from yours — I didn’t see any EINVAL, and
>>>> there was no fallback. :)
>>>
>>> Yep, your kernel is recent and has the following commit.
>>>
>>> 7e8b255650fcfa1d0 ("perf: Support PERF_SAMPLE_READ with inherit")
>>>
>>> My kernel is 6.6 and it rejects such a combination.  I'll test it on
>>> newer kernels later.
>>>
>>>>
>>>> It’s strange, but even so, since there’s no group leader in this case, I
>>>> assume that when it falls back to non-inherit, it should pass the
>>>> following check.
>>>>
>>>>         if (task && group_leader &&
>>>>             group_leader->attr.inherit != attr.inherit) {
>>>>                 err = -EINVAL;
>>>>                 goto err_task;
>>>>         }
>>>>
>>>>> I've also found that it
>>>>> worked even with precise_ip = 3.
>>>>>
>>>>>   $ perf record -e cpu/mem-loads-aux/PS -vv true |& less
>>>>>   ...
>>>>>   sys_perf_event_open: pid 1172834  cpu 0  group_fd -1  flags 0x8
>>>>>   sys_perf_event_open failed, error -22
>>>>>   Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
>>>>>   ------------------------------------------------------------
>>>>>   perf_event_attr:
>>>>>     type                             4 (cpu)
>>>>>     size                             136
>>>>>     config                           0x8203 (mem-loads-aux)
>>>>>     { sample_period, sample_freq }   4000
>>>>>     sample_type                      IP|TID|TIME|READ|ID|PERIOD
>>>>>     read_format                      ID|LOST
>>>>>     disabled                         1
>>>>>     mmap                             1
>>>>>     comm                             1
>>>>>     freq                             1
>>>>>     enable_on_exec                   1
>>>>>     task                             1
>>>>>     precise_ip                       3         <<<---- here
>>>>>     sample_id_all                    1
>>>>>     mmap2                            1
>>>>>     comm_exec                        1
>>>>>     ksymbol                          1
>>>>>     bpf_event                        1
>>>>>   ------------------------------------------------------------
>>>>>   sys_perf_event_open: pid 1172834  cpu 0  group_fd -1  flags 0x8 = 4
>>>>>   ...
>>>>
>>>> Again, on my machine, I didn’t see EINVAL, and no fallback to
>>>> non-inherit. In my test, glc_get_event_constraints() successfully forces
>>>> this event (config == 0x8203) to fixed counter 0, so there’s no issue here.
>>>
>>> That means your missing_features.inherit_sample_read should not be set.
>>> It's strange you have that with the recent kernels.
>>>
>>> Can you run these commands and show the output here?
>>>
>>>   $ perf record -e task-clock:S  true
>>>   $ perf evlist -v
>>
>> On 6.18.0-rc4:
>>
>> $ perf record -e task-clock:S  true
>> [ perf record: Woken up 2 times to write data ]
>> [ perf record: Captured and wrote 0.006 MB perf.data ]
>>
>> $ perf evlist -v
>> task-clock:Su: type: 1 (PERF_TYPE_SOFTWARE), size: 136, config: 0x1
>> (PERF_COUNT_SW_TASK_CLOCK), { sample_period, sample_freq }: 4000,
>> sample_type: IP|TID|TIME|READ|ID|PERIOD, read_format: ID|LOST, disabled:
>> 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq:
>> 1, enable_on_exec: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1,
>> ksymbol: 1, bpf_event: 1, build_id: 1
> 
> Thanks for sharing this.  Yep, it has the inherit bit.
> 
> I think there's a bug in the missing feature test.  Indeed, it should
> also have PERF_SAMPLE_TID for the test according to the kernel comment.
> 
> 	/*
> 	 * We do not support PERF_SAMPLE_READ on inherited events unless
> 	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
> 	 * collect per-thread samples.
> 	 * See perf_output_read().
> 	 */
> 	if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
> 		return ERR_PTR(-EINVAL);

It seems that the purpose of the inherit_sample_read fallback is to
remove the inherit attribute when both PERF_SAMPLE_READ and inherit are
present, but PERF_SAMPLE_TID is not. The new change may not be able to
accomplish this?


> 
> I'll send a patch soon.
> 
> Thanks,
> Namhyung
> 

