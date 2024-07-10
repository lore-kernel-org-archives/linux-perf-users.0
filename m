Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1AC12C499;
	Wed, 10 Jul 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604460; cv=none; b=X33plsX5NaAZc2qOvG0VUxrFx1UMT0x0tPtEz9afPwE6MAjdNXruE8VJrgPlNj4Zb7nioKLloYVrlv48JPVvtqMlPuZ8q5yJZapJl2Spwekf2+AHXi5PXxidLduykMk9riZgPXggOws4CWbZ0FFeAcy5MKXCTeTtI7IUL+JO9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604460; c=relaxed/simple;
	bh=wTNaCzQeAjoPakOOv8uIlK8luV4rUAiOTA3zbmhBNvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5tOm1hlHtzT2dYtFlB0eB4cbRHYVCORYr4UEvCbnv78RZrMCBqGujZgcorTJQ9wP2BupfxK1Kvc0N+DyFYRRfK8DheTuIunH2gi5sCPqLvgeajWauZZZVU57mP6smQmH2Yj79TRytZ6wOxlq6umpG6G/aduXpz/2XiPK2EbL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+Y2IPM2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+Y2IPM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720604459; x=1752140459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wTNaCzQeAjoPakOOv8uIlK8luV4rUAiOTA3zbmhBNvA=;
  b=a+Y2IPM2XF8TvRLZBti77f/tdfjCywZWnc0oh5BWVpmLaF3q3XLCXoGu
   HOXfvj6diLTv9R7MXZVFUFe4UO96aljXEm297tcKRM98rlibhk6Hs6ZtH
   EhXaJnu3hR56BtgrUNwWkSmkEZRQLY9+VhRNT0QVsVvLPhybsdgsfFlEm
   zZpsmkICCNA6pjt8VnAKog2EIn11AWI6lQmXb9S5YfT+6WOh9EbAlKGvK
   36c2sC/kygbpBdInSu7iIJVbC6Ly5Z9Z2NFPSIVeewiKC3v6VUeGTleMQ
   tkcZyi46K2E52PqmdfKYED5j2lO7Mb+HJiyc1vojJeBmRAKyUXo7Ylpia
   w==;
X-CSE-ConnectionGUID: +uH7ClSnT/y9b1OMql869g==
X-CSE-MsgGUID: WP1YX+m9Qsa7Eh6kJ46RUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="29072493"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="29072493"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 02:40:58 -0700
X-CSE-ConnectionGUID: s497tvC7R8KQ5ARufG9K0g==
X-CSE-MsgGUID: 29VnYLwkRGqbwnzWR9lDJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="79320936"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 02:40:54 -0700
Message-ID: <afea2a93-0769-4ce5-ab59-2693d2d2f344@linux.intel.com>
Date: Wed, 10 Jul 2024 17:40:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 3/5] perf x86/topdown: Don't move topdown metrics
 events when sorting events
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
 <20240708144204.839486-4-dapeng1.mi@linux.intel.com>
 <CAP-5=fVPb4JGR3RxfPBGrihrra8bFzdJfFt2iASSs2xHOy=U4g@mail.gmail.com>
 <4d39856e-396d-4a48-9ca3-2e1a574f50d7@linux.intel.com>
 <CAP-5=fW65kxuABBJVAzKwoyBWW92_jkndWgY+4u9s3OGj_UkEg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fW65kxuABBJVAzKwoyBWW92_jkndWgY+4u9s3OGj_UkEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/10/2024 6:37 AM, Ian Rogers wrote:
> On Mon, Jul 8, 2024 at 9:18 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 7/8/2024 11:08 PM, Ian Rogers wrote:
>>> On Mon, Jul 8, 2024 at 12:40 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>>>> when running below perf command, we say error is reported.
>>>>
>>>> perf record -e "{slots,instructions,topdown-retiring}:S" -vv -C0 sleep 1
>>>>
>>>> ------------------------------------------------------------
>>>> perf_event_attr:
>>>>   type                             4 (cpu)
>>>>   size                             168
>>>>   config                           0x400 (slots)
>>>>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>>>>   read_format                      ID|GROUP|LOST
>>>>   disabled                         1
>>>>   sample_id_all                    1
>>>>   exclude_guest                    1
>>>> ------------------------------------------------------------
>>>> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>>>> ------------------------------------------------------------
>>>> perf_event_attr:
>>>>   type                             4 (cpu)
>>>>   size                             168
>>>>   config                           0x8000 (topdown-retiring)
>>>>   { sample_period, sample_freq }   4000
>>>>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>>>>   read_format                      ID|GROUP|LOST
>>>>   freq                             1
>>>>   sample_id_all                    1
>>>>   exclude_guest                    1
>>>> ------------------------------------------------------------
>>>> sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
>>>> sys_perf_event_open failed, error -22
>>>>
>>>> Error:
>>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-retiring).
>>>>
>>>> The reason of error is that the events are regrouped and
>>>> topdown-retiring event is moved to closely after the slots event and
>>>> topdown-retiring event needs to do the sampling, but Intel PMU driver
>>>> doesn't support to sample topdown metrics events.
>>>>
>>>> For topdown metrics events, it just requires to be in a group which has
>>>> slots event as leader. It doesn't require topdown metrics event must be
>>>> closely after slots event. Thus it's a overkill to move topdown metrics
>>>> event closely after slots event in events regrouping and furtherly cause
>>>> the above issue.
>>>>
>>>> Thus delete the code that moving topdown metrics events to fix the
>>>> issue.
>>> I think this is wrong. The topdown events may not be in a group, such
>>> cases can come from metrics due to grouping constraints, and so they
>>> must be sorted together so that they may be gathered into a group to
>>> avoid the perf event opens failing for ungrouped topdown events. I'm
>>> not understanding what these patches are trying to do, if you want to
>>> prioritize the event for leader sampling why not modify it to compare
>> Per my understanding, this change doesn't break anything. The events
>> regrouping can be divided into below several cases.
>>
>> a. all events in a group
>>
>> perf stat -e "{instructions,topdown-retiring,slots}" -C0 sleep 1
>> WARNING: events were regrouped to match PMUs
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>         15,066,240      slots
>>          1,899,760      instructions
>>          2,126,998      topdown-retiring
>>
>>        1.045783464 seconds time elapsed
>>
>> In this case, slots event would be adjusted as the leader event and all
>> events are still in same group.
>>
>> b. all events not in a group
>>
>> perf stat -e "instructions,topdown-retiring,slots" -C0 sleep 1
>> WARNING: events were regrouped to match PMUs
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>          2,045,561      instructions
>>         17,108,370      slots
>>          2,281,116      topdown-retiring
>>
>>        1.045639284 seconds time elapsed
>>
>> In this case, slots and topdown-retiring are placed into a group and slots
>> is the group leader. instructions event is outside the group.
>>
>> c. slots event in group but topdown metric events outside the group
>>
>> perf stat -e "{instructions,slots},topdown-retiring"  -C0 sleep 1
>> WARNING: events were regrouped to match PMUs
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>         20,323,878      slots
>>          2,634,884      instructions
>>          3,028,656      topdown-retiring
>>
>>        1.045076380 seconds time elapsed
>>
>> In this case, topdown-retiring event is placed into previous group and
>> slots is adjusted to leader event.
>>
>> d. multiple event groups
>>
>> perf stat -e "{instructions,slots},{topdown-retiring}"  -C0 sleep 1
>> WARNING: events were regrouped to match PMUs
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>         26,319,024      slots
>>          2,427,791      instructions
>>          2,683,508      topdown-retiring
>>
>>        1.045495830 seconds time elapsed
>>
>> In this case, the two groups are merged to one group and slots event is
>> adjusted as leader.
>>
>> The key point of this patch is that it's unnecessary to move topdown
>> metrics events closely after slots event. It's a overkill since Intel core
>> PMU driver doesn't require that. Intel PMU driver just requires topdown
>> metrics events are in a group where slots event is the group leader, and
>> worse the movement for topdown metrics events causes the issue in the
>> commit message mentioned.
>>
>> This patch doesn't block to regroup topdown metrics event. It just removes
>> the unnecessary movement for topdown metrics events.
> But you will get the same behavior because of the non-arch dependent
> force group index - I guess you don't care as the sample read only
> happens when you have a group.
>
> I'm thinking of cases like (which admittedly is broken):
> ```
> $ perf stat -e "{slots,instructions},cycles,topdown-fe-bound" -a sleep 0.1
> [sudo] password for irogers:
>
> Performance counter stats for 'system wide':
>
>     2,589,345,900      slots
>       852,492,838      instructions
>       583,525,372      cycles
>   <not supported>      topdown-fe-bound
>
>       0.103930790 seconds time elapsed
> ```

I run the upstream code (commit 73e931504f8e0d42978bfcda37b323dbbd1afc08)
without this patchset, I see same issue.

perf stat -e "{slots,instructions},cycles,topdown-fe-bound" -a sleep 0.1

 Performance counter stats for 'system wide':

       262,448,922      slots
        29,630,373      instructions
        43,891,902      cycles
   <not supported>      topdown-fe-bound

       0.150369560 seconds time elapsed

#perf -v
perf version 6.10.rc6.g73e931504f8e

This issue is not caused by this patchset.

> As the slots event is grouped there's no force group index on it, we
> want to shuffle the topdown-fe-bound into the group so we want it to
> compare as less than cycles - ie we're comparing topdown events with
> non topdown events and trying to shuffle the topdown events first.

Current evlist__cmp() won't really swap the order of cycles and
topdown-fe-bound.

if (lhs_sort_idx != rhs_sort_idx)
        return lhs_sort_idx - rhs_sort_idx;

When comparing cycles and topdown-fe-bound events, lhs_sort_idx is 2 and
rhs_sort_idx is 3, so the swap won't happen.

So the event sequence after sorting is still "slots, instructions ,cycles,
topdown-fe-bound". Both cycles and topdown-fe-bound events won't be placed
into the group.


>
> Thanks,
> Ian
>
>
>
>>> first?
>>>
>>> Thanks,
>>> Ian
>>>
>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>> ---
>>>>  tools/perf/arch/x86/util/evlist.c | 5 -----
>>>>  1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>>>> index 332e8907f43e..6046981d61cf 100644
>>>> --- a/tools/perf/arch/x86/util/evlist.c
>>>> +++ b/tools/perf/arch/x86/util/evlist.c
>>>> @@ -82,11 +82,6 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>>>>                         return -1;
>>>>                 if (arch_is_topdown_slots(rhs))
>>>>                         return 1;
>>>> -               /* Followed by topdown events. */
>>>> -               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>>>> -                       return -1;
>>>> -               if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
>>>> -                       return 1;
>>>>         }
>>>>
>>>>         /* Default ordering by insertion index. */
>>>> --
>>>> 2.40.1
>>>>
