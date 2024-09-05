Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F2192D96;
	Thu,  5 Sep 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557012; cv=none; b=eXILJPz/mU8H9ig0c37xU26AIInykKYolF6bgVtDUNftYdlUWMkFkpLiTv7OHVE5U6LpyjIm4nGytYKUECjjZ6U+7WX7Ye5wQosnxm2VOBVkdpCV4duq8XpV07QWBiZ0CSyAB1l/1ffiB4uWB03918aPzeWzhi+BvIvmmqsS4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557012; c=relaxed/simple;
	bh=gcTzKj46zf/SMFLXFooTQgLJ4j06KU6IYokYRxsZK60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSsbWzFG4/fdNgOZ6lxJ5wNDuFGL4f+L978Ft7OTFlHMcrcXIIlnMsYIkFnRL0fLci9M+gN1Pq99smMdjVlaV+uiVEqnWpQdGgkwi0yAWDGmNOT9xcAKEDDsie0yAtb5e7+ZhiN+Px0xzTY2aPy1TKcAd3bdEn2j3k7ho12+gHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHfUAGzO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHfUAGzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725557011; x=1757093011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gcTzKj46zf/SMFLXFooTQgLJ4j06KU6IYokYRxsZK60=;
  b=ZHfUAGzOIzYPMfEWnB9gN4/x/XeOvbF69SR6b/Bvqu9zA1LhcLtE40fl
   MVwkqvXaPgKSfx9WHP65HbyIlbTK+OuaZ9nUr+qTSneRPtBgmLAnGqhcK
   wnlMUruWRO1C7MYdp9wPZMn+HlgYxhFOQYKahEIe0SrfhE9zfyCyH8kuz
   sKgpqRO7NcBGAxoZODxNYd9kV3SYhdE8nU0nDYxxPsK4yVXOgZo+mO4Wb
   1TIC4jbpGU9dMCPXO3wwRPyzC6eH0Y3sKYSHpZ3QB1kiOqJw2q9L/fHEV
   Tq9VuBQ46Djd5yuTwCu1WU/T08qqILqXe/umzcU3lSC8aZX9V4hkgIMiG
   w==;
X-CSE-ConnectionGUID: lTIflgWBQuGisoZfBhUUJQ==
X-CSE-MsgGUID: mrpsUsbkRoKbi4MfjhDWAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24407008"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24407008"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:23:30 -0700
X-CSE-ConnectionGUID: r/NG7K2MTu2mxlSDLqGFoQ==
X-CSE-MsgGUID: RRI8B7LzQ/+cExd8C1noog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="66241768"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:23:30 -0700
Received: from [10.212.68.73] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 16B2920B5782;
	Thu,  5 Sep 2024 10:23:28 -0700 (PDT)
Message-ID: <caba86ad-bcba-4e1e-acc4-b18d769db87d@linux.intel.com>
Date: Thu, 5 Sep 2024 13:23:27 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf mem record not getting the mem_load_aux events by default
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Zthu81fA3kLC2CS2@x1>
 <e848ad7b-bc9d-4eca-8918-0dd5a67c347e@linux.intel.com> <Zth-DBdaSXodeFqn@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Zth-DBdaSXodeFqn@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-09-04 11:34 a.m., Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 04, 2024 at 11:20:57AM -0400, Liang, Kan wrote:
>>
>>
>> On 2024-09-04 10:30 a.m., Arnaldo Carvalho de Melo wrote:
>>> Hi Kan,
>>>
>>> Recently I presented about 'perf mem record' and found that I had use
>>> 'perf record' directly as 'perf mem record' on a Intel Hybrid system
>>> wasn't selecting the required aux event:
>>>
>>>   http://vger.kernel.org/~acme/prez/lsfmm-bpf-2024/#/19
>>>
>>> The previous slides show the problem and the one above shows what worked
>>> for me.
>>>
>>> I saw this while trying to fix that:
>>>
>>> Author: Kan Liang <kan.liang@linux.intel.com>
>>> commit abbdd79b786e036e60f01b7907977943ebe7a74d
>>> Date:   Tue Jan 23 10:50:32 2024 -0800
>>>
>>>     perf mem: Clean up perf_mem_events__name()
>>>     
>>>     Introduce a generic perf_mem_events__name(). Remove the ARCH-specific
>>>     one.
>>>     
>>>     The mem_load events may have a different format. Add ldlat and aux_event
>>>     in the struct perf_mem_event to indicate the format and the extra aux
>>>     event.
>>>     
>>>     Add perf_mem_events_intel_aux[] to support the extra mem_load_aux event.
>>>     
>>>     Rename perf_mem_events__name to perf_pmu__mem_events_name.
>>>
>>> --------------------------´
>>>
>>> So there are provisions for selecting the right events, but it doesn't
>>> seem to be working when I tried, can you take a look at what I describe
>>> on those slides and see what am I doing wrong?
>>>
>>
>> If I understand the example in the slides correctly, the issue is that
>> no mem events from big core are selected when running perf mem record,
>> rather than wrong mem events are selected.
>>
>> I don't see an obvious issue. That looks like a regression of the perf
>> mem record. I will find a Alder Lake or Raptor Lake to take a deep look.
> 
> My expectation was for whatever is needed for having those events to be
> put in place, like I did manually, and indeed, limiting it to cpu_core:
> 
> taskset -c 0 \
>   perf record --weight --data \
>               --event '{cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/P}:S' \
> 	      --event cpu_core/mem-stores/ find / > /dev/null
> 
> I.e. lots of boilerplate for using 'perf mem record', we should at least
> have some sort of warning about the 'perf mem record' experience having
> to be restricted to workloads running on PMUs where it can take place,
> perhaps making 'perf mem record' to restrict the CPUs used for a session
> to be the ones with the needed resources... and we have that already:
> 
> root@number:~# perf mem record sleep 1
> Memory events are enabled on a subset of CPUs: 16-27
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.032 MB perf.data ]
> root@number:~#
> 
> But...
> 
> root@number:~# perf evlist
> cpu_atom/mem-loads,ldlat=30/P
> cpu_atom/mem-stores/P
> dummy:u
> root@number:~# perf evlist -v
> cpu_atom/mem-loads,ldlat=30/P: type: 10 (cpu_atom), size: 136, config: 0x5d0 (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x1f
> cpu_atom/mem-stores/P: type: 10 (cpu_atom), size: 136, config: 0x6d0 (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
> dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> root@number:~# 
> 
> It is not setting up the required
> 
>   --event '{cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/P}:S'
> 
> part, right?
>

Right, it's bug on ADL and RPL. The p-core of ADL and RPL requires
mem-loads-aux to work around an HW defect. So there are different
mem_events for e-core and p-core, perf_mem_events_intel[] and
perf_mem_events_intel_aux[].

Ideally, perf should initialize and set the corresponding config bit for
both mem_events. However, the current code only does it for the first
PMU, which brings trouble. The second PMU (p-core) is always ignored.

Except ADL/RPL, it doesn't impact the other hybrid machine. Because the
workaround is not required. So both e-core and p-core share the same
perf_mem_events_intel[].

The patch set to fix it has been posted. Please take a look.
https://lore.kernel.org/lkml/20240905170737.4070743-1-kan.liang@linux.intel.com/

BTW: I found a regression with perf mem record -e when I did the test.
The fix patch can also be found in the above patch set.

Thanks,
Kan

> To make this more useful perhaps we should, in addition to warning that
> is running just on those CPUs, when we specify a workload (sleep 1) in
> the above case, limit that workload to that set of CPUs so that we can
> get those mem events on all of the workload runtime?
> 
> We would just add a new warning for that behaviour, etc.
> 
> - Arnaldo
> 
