Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6517083D;
	Tue, 28 May 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911706; cv=none; b=D2kOMKBzn2phQZ0dsgQRd2sGwyiuJWbMbB8PxTrQrZVGkfTVp+dqUnNdbQuDcZhoTSTnAgGaxIf6yEO7fwKng+iWyXK+HacZGUXt6AzrM+Nnyw+b/xLT5WOwAxPoCKb9hKdwOrvL7heafBrvokvBZvIwg9QQtoSO3a03FDjERaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911706; c=relaxed/simple;
	bh=Z7nFPpYM6hif/EXLtJYN/0vbm58dmn5PpXh4Pb2kSQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgK9pQHnfJ2ww8rmQUV7RHjffWm/pfhvXW095u9icfRC6xRIO0y7AsKI2QatrzNq44EHvgaPIjYf17BDgjC4OYoLZHV2OyALNbIBbwefPwhWI3R+6U2mN1ZB+sPQNlQyi7wFCIGjhm0rGe3qYDb0pfgUl4G5g8zK66V0oLh7uq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0EmNdjR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0EmNdjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716911704; x=1748447704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z7nFPpYM6hif/EXLtJYN/0vbm58dmn5PpXh4Pb2kSQM=;
  b=m0EmNdjRDP3QABqwXXmqdmxxz6xVkMdz9qCEow8HrJTY69yrgYuAKa2u
   QCTUk5Rl3jx3bGCG/MegYjkbkWa4jYl7ByicVUZFBDdZ2xNJBTk4Kk5I3
   rd5c1l6x56VFEH4vTs5z89HbTIJ+uxLcdlb85gahhcBM3It46WKL15NeH
   /MO3WkMZmCZ3tB/q34j2HRjpB0Iyr+zJ5c64PYAi7uGTEjufv+gc3tYL2
   q6xTnFfpqP6vPVlARAMdNaJMQnR/665aM7+VlJwgFwhKkXtj3WhEbF1P/
   4TsNqpd7eHN2iG7S6cXiKV1SgpC6sKiEMYUw/0gV6xdYFRw9VQwaehny0
   Q==;
X-CSE-ConnectionGUID: tqtl5WW+Rxi/fSgzad5T2w==
X-CSE-MsgGUID: p5iT773yTuWQ/gWYab51/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13489097"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13489097"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 08:55:03 -0700
X-CSE-ConnectionGUID: 00SyhGZTQYu9g9X1/N1A2g==
X-CSE-MsgGUID: UP/HehqHSe+XmvhfnWHsQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35099690"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 08:55:03 -0700
Received: from [10.209.183.246] (kliang2-mobl1.ccr.corp.intel.com [10.209.183.246])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A77222078A10;
	Tue, 28 May 2024 08:55:01 -0700 (PDT)
Message-ID: <97818e63-051f-4fcf-8c20-75730c08e98a@linux.intel.com>
Date: Tue, 28 May 2024 11:55:00 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf record: add a shortcut for metrics
To: Artem Savkov <asavkov@redhat.com>, Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org
References: <20240527101519.356342-1-asavkov@redhat.com> <ZlS8pc39t2c1WFye@x1>
 <ZlS9M1vcxZ3Qsx_B@x1> <ZlTCvelaGVb6lCia@x1> <ZlTG-kPuYUyHLQZ2@x1>
 <CAP-5=fWmmtagTVfacFZgdhughvU--Dz0=jkoqFB8CP1Qd3o3Yw@mail.gmail.com>
 <20240528115703.GB449511@alecto.usersys.redhat.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240528115703.GB449511@alecto.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-05-28 7:57 a.m., Artem Savkov wrote:
> On Mon, May 27, 2024 at 10:01:37PM -0700, Ian Rogers wrote:
>> On Mon, May 27, 2024 at 10:46 AM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>>>
>>> On Mon, May 27, 2024 at 02:28:32PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> On Mon, May 27, 2024 at 02:04:54PM -0300, Arnaldo Carvalho de Melo wrote:
>>>>> On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Melo wrote:
>>>>>> On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
>>>>>>> Add -M/--metrics option to perf-record providing a shortcut to record
>>>>>>> metrics and metricgroups. This option mirrors the one in perf-stat.
>>>>
>>>>>>> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>>>>> Signed-off-by: Artem Savkov <asavkov@redhat.com>
>>>
>>>> How did you test this?
>>>
>>>> The idea, from my notes, was to be able to have extra columns in 'perf
>>>> report' with things like IPC and other metrics, probably not all metrics
>>>> will apply. We need to find a way to find out which ones are OK for that
>>>> purpose, for instance:
>>>
>>> One that may make sense:
>>>
>>> root@number:~# perf record -M tma_fb_full
>>> ^C[ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 3.846 MB perf.data (21745 samples) ]
>>>
>>> root@number:~# perf evlist
>>> cpu_core/CPU_CLK_UNHALTED.THREAD/
>>> cpu_core/L1D_PEND_MISS.FB_FULL/
>>> dummy:u
>>> root@number:~#
>>>
>>> But then we need to read both to do the math, maybe something like:
>>>
>>> root@number:~# perf record -e '{cpu_core/CPU_CLK_UNHALTED.THREAD/,cpu_core/L1D_PEND_MISS.FB_FULL/}:S'
>>> ^C[ perf record: Woken up 40 times to write data ]
>>> [ perf record: Captured and wrote 14.640 MB perf.data (219990 samples) ]
>>>
>>> root@number:~# perf script | head
>>>     cc1plus 1339704 [000] 36028.995981:  2011389 cpu_core/CPU_CLK_UNHALTED.THREAD/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
>>>     cc1plus 1339704 [000] 36028.995981:    26231   cpu_core/L1D_PEND_MISS.FB_FULL/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
>>>     cc1plus 1340011 [001] 36028.996008:  2004568 cpu_core/CPU_CLK_UNHALTED.THREAD/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
>>>     cc1plus 1340011 [001] 36028.996008:    20113   cpu_core/L1D_PEND_MISS.FB_FULL/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
>>>       clang 1340462 [002] 36028.996043:  2007356 cpu_core/CPU_CLK_UNHALTED.THREAD/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms])
>>>       clang 1340462 [002] 36028.996043:    23481   cpu_core/L1D_PEND_MISS.FB_FULL/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms])
>>>     cc1plus 1339622 [003] 36028.996066:  2004148 cpu_core/CPU_CLK_UNHALTED.THREAD/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
>>>     cc1plus 1339622 [003] 36028.996066:    31935   cpu_core/L1D_PEND_MISS.FB_FULL/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
>>>          as 1340513 [004] 36028.996097:  2005052 cpu_core/CPU_CLK_UNHALTED.THREAD/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.kallsyms])
>>>          as 1340513 [004] 36028.996097:    45084   cpu_core/L1D_PEND_MISS.FB_FULL/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.kallsyms])
>>> root@number:~#
>>>
>>> root@number:~# perf report --stdio -F +period | head -20
>>> # To display the perf.data header info, please use --header/--header-only options.
>>> #
>>> #
>>> # Total Lost Samples: 0
>>> #
>>> # Samples: 219K of events 'anon group { cpu_core/CPU_CLK_UNHALTED.THREAD/, cpu_core/L1D_PEND_MISS.FB_FULL/ }'
>>> # Event count (approx.): 216528524863
>>> #
>>> #         Overhead                Period  Command    Shared Object      Symbol
>>> # ................  ....................  .........  .................  ....................................
>>> #
>>>      4.01%   1.09%  8538169256  39826572  podman     [kernel.kallsyms]  [k] native_queued_spin_lock_slowpath
>>>      1.35%   1.17%  2863376078  42829266  cc1plus    cc1plus            [.] 0x00000000003f6bcc
>>>      0.94%   0.78%  1990639149  28408591  cc1plus    cc1plus            [.] 0x00000000003f6be4
>>>      0.65%   0.17%  1375916283   6109515  podman     [kernel.kallsyms]  [k] _raw_spin_lock_irqsave
>>>      0.61%   0.99%  1304418325  36198834  cc1plus    [kernel.kallsyms]  [k] get_mem_cgroup_from_mm
>>>      0.52%   0.42%  1103054030  15427418  cc1plus    cc1plus            [.] 0x0000000000ca6c69
>>>      0.51%   0.17%  1094200572   6299289  podman     [kernel.kallsyms]  [k] psi_group_change
>>>      0.42%   0.41%   893633315  14778675  cc1plus    cc1plus            [.] 0x00000000018afafe
>>>      0.42%   1.29%   887664793  47046952  cc1plus    [kernel.kallsyms]  [k] asm_exc_page_fault
>>> root@number:~#
>>>
>>> That 'tma_fb_full' metric then would be another column, calculated from
>>> the sampled components of its metric equation:
>>>
>>> root@number:~# perf list tma_fb_full | head
>>>
>>> Metric Groups:
>>>
>>> MemoryBW: [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
>>>   tma_fb_full
>>>        [This metric does a *rough estimation* of how often L1D Fill Buffer
>>>         unavailability limited additional L1D miss memory access requests to
>>>         proceed]
>>>
>>> TopdownL4: [Metrics for top-down breakdown at level 4]
>>> root@number:~#
>>>
>>> This is roughly what we brainstormed, to support metrics in other tools
>>> than 'perf stat' but we need to check the possibilities and limitations
>>> of such an idea, hopefully this discussion will help with that,
>>
>> Putting metrics next to code in perf report/annotate sounds good to
>> me, opening all events from a metric as if we want to sample on them
>> less so.
> 
> The idea was to record whatever data was asked on record step and
> provide the list of all metrics that can be calculated out of that data
> in perf report, e.g. you could record tma_info_thread_ipc but report
> will suggest both it and tma_info_thread_cpi.
>

Do you mean that sample all the events in a metrics, and report both
samples and its metrics calculation result in the report?
That doesn't work for all the metrics.

- For the topdown related metrics, especially on ICL and later
platforms, the perf metrics feature is used by default. It doesn't
support sampling.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/topdown.txt?#n293
- Some PMUs which doesn't support sampling as well, e.g., uncore, Power,
MSR.
- There are some SW events, e.g.,duration_time, you may don't want to do
sampling

You probable need to introduce a flag to ignore those metrics in perf
record.

>> We don't have metrics working with `perf stat record`, I
>> think Kan may have volunteered for that, but it seems like something
>> more urgent than expanding `perf record`. Presumably the way the
>> metric would be recorded for that could also benefit this effort.
>>
>> If you look at the tma metrics a number of them have a "Sample with".
>> For example:
>> ```
>> $ perf list -v
>> ...
>>   tma_branch_mispredicts
>>        [This metric represents fraction of slots the CPU has wasted
>> due to Branch Misprediction.
>>         These slots are either wasted by uops fetched from an
>> incorrectly speculated program path;
>>         or stalls when the out-of-order part of the machine needs to
>> recover its state from a
>>         speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES.
>> Related metrics:
>>         tma_info_bad_spec_branch_misprediction_cost,tma_info_bottleneck_mispredictions,
>>         tma_mispredicts_resteers]
>> ...
>> ```
>> It could be logical for `perf record -M tma_branch_mispredicts ...` to
>> be translated to `perf record -e BR_MISP_RETIRED.ALL_BRANCHES ...`
>> rather than to do any form of counting.
> 
> Thanks for the pointer, I'll see how this could be done.

It sounds more reasonable to me that we can sample some typical events,
and read the other members in the metrics. So we can put metrics next to
the code in perf report/annotate as Ian mentioned. It could also address
limits of some metrics, especially for the topdown related metrics.
(But I'm not sure if the "Sample with" can give you the right hints. I
will ask around internally.)

But there is also some limits for the sampling read. Everything has to
be in a group. That could be a problem for some big metrics.
Thanks,
Kan
