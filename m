Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4ED1B86D9;
	Fri, 19 Jul 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407360; cv=none; b=cToy0Zv891V6dGwDWymY2R8Q8UzwiA9T5UiBCUu+KDJh9vfo0CZkmFjWJMwVoWG1aHwXtSfzWzT16xBbOVVWzeB4TlK8fqLqR+6ttzEplD7ERvyrWs15MNlCfj2kahsWFPSb8QOxPCIoQqfubnTd64Ihi7aP5n2osHgb4KjI6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407360; c=relaxed/simple;
	bh=Qt+VmxEs+FDvzjNuyOuYdjcR0F2l8yzqTdMPKDCckm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Po+pdzpHWvUWFY0uEZytPtBG+fzDtEym52cQ88wRKdFLvjbscyoVlx6SWvOMR+dWoyAfezQ+3fpVD+mnaV8/j4ocqxOnqdo39wmeQl5rfAVq7Fu2u+CW7Y83FSXpjgnOwWWNEFyQrnL5R24+aTq5g/nF8yJN/XEgQDg6Tx3jZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBcL7yYS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBcL7yYS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721407359; x=1752943359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qt+VmxEs+FDvzjNuyOuYdjcR0F2l8yzqTdMPKDCckm0=;
  b=lBcL7yYSD1fB1Lp+ak/+KB3sSyU1vuhy7/9R6nrXwQO2f9QyNxFll7CQ
   JtxTgCcgZ1EvTCcxNvRVUGsU+rxSBGalScqL7HyXhnY7DrCFk0srjvYWF
   +VcIasWhbxH318V9WMgalakuQOfqU49FPyhs6V4ks2Ts0WL+1gjUB2fsX
   w6Zs2VOT6DkmFMaxFqMzxFdvMQQMWmpvBpyIjXWM1N+vm6FZRjcCMoeir
   yMAmNzLx8hEm5nroFWRKidwGjbaNpBtx0N8b43rNFZ0flGAme7ijlr+P7
   1TRB/pI7rTTh97p9B6aCOhnzH1cwin6fJkRvlvHNtwNSJo7I7S1sNk26k
   g==;
X-CSE-ConnectionGUID: L6cJJh/HRGKSsHdKyiDN2Q==
X-CSE-MsgGUID: Hc+umCO2RUq0wwlwGyO8vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="18733627"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="18733627"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 09:42:38 -0700
X-CSE-ConnectionGUID: NlVOWgdKQ9SGAsq/92SqGA==
X-CSE-MsgGUID: yqwhxPFSQJqCW1j+mAaJOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="74391705"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 09:42:37 -0700
Received: from [10.209.176.79] (kliang2-mobl1.ccr.corp.intel.com [10.209.176.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5F56520CFED5;
	Fri, 19 Jul 2024 09:42:34 -0700 (PDT)
Message-ID: <ee3c8e75-2463-49f8-b1ba-5a68db0bae39@linux.intel.com>
Date: Fri, 19 Jul 2024 12:42:33 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] perf parse-events: Add "cpu" term to set the CPU
 an event is recorded on
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
References: <20240718003025.1486232-1-irogers@google.com>
 <20240718003025.1486232-7-irogers@google.com>
 <febefab7-7351-4bd5-a6cc-a0116248484f@linux.intel.com>
 <CAP-5=fUUcehu-C=ytHVVixOpeCYoW4oJkkj6p6W=M0HtQ2wrRA@mail.gmail.com>
 <2e76dd74-b702-4401-ade1-fc1fd1ff40ce@linux.intel.com>
 <CAP-5=fUEo=EC2iS17_2=1i76ACnHV5PCsA36c3q4TAw3QTvwTQ@mail.gmail.com>
 <803b0b0b-6250-4f63-9b80-8982f74b5ef2@linux.intel.com>
 <CAP-5=fUvA5Lmk16Zs1B6bj1OLHf9NaHhAzx7yZL9S7JGwmO0uw@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUvA5Lmk16Zs1B6bj1OLHf9NaHhAzx7yZL9S7JGwmO0uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-07-19 11:01 a.m., Ian Rogers wrote:
> On Fri, Jul 19, 2024 at 7:14 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-07-18 5:06 p.m., Ian Rogers wrote:
>>> On Thu, Jul 18, 2024 at 11:03 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024-07-18 11:12 a.m., Ian Rogers wrote:
>>>>> On Thu, Jul 18, 2024 at 7:41 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
>>>>>>> The -C option allows the CPUs for a list of events to be specified but
>>>>>>> its not possible to set the CPU for a single event. Add a term to
>>>>>>> allow this. The term isn't a general CPU list due to ',' already being
>>>>>>> a special character in event parsing instead multiple cpu= terms may
>>>>>>> be provided and they will be merged/unioned together.
>>>>>>>
>>>>>>> An example of mixing different types of events counted on different CPUs:
>>>>>>> ```
>>>>>>> $ perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1
>>>>>>>
>>>>>>>  Performance counter stats for 'system wide':
>>>>>>>
>>>>>>> CPU0              368,647      instructions/cpu=0/              #    0.26  insn per cycle
>>>>>>> CPU4        <not counted>      instructions/cpu=0/
>>>>>>> CPU5        <not counted>      instructions/cpu=0/
>>>>>>> CPU8        <not counted>      instructions/cpu=0/
>>>>>>> CPU0        <not counted>      l1d-misses [cpu]
>>>>>>> CPU4              203,377      l1d-misses [cpu]
>>>>>>> CPU5              138,231      l1d-misses [cpu]
>>>>>>> CPU8        <not counted>      l1d-misses [cpu]
>>>>>>> CPU0        <not counted>      cpu/cpu=8/
>>>>>>> CPU4        <not counted>      cpu/cpu=8/
>>>>>>> CPU5        <not counted>      cpu/cpu=8/
>>>>>>> CPU8              943,861      cpu/cpu=8/
>>>>>>> CPU0            1,412,071      cycles
>>>>>>> CPU4           20,362,900      cycles
>>>>>>> CPU5           10,172,725      cycles
>>>>>>> CPU8            2,406,081      cycles
>>>>>>>
>>>>>>>        0.102925309 seconds time elapsed
>>>>>>> ```
>>>>>>>
>>>>>>> Note, the event name of inst_retired.any is missing, reported as
>>>>>>> cpu/cpu=8/, as there are unmerged uniquify fixes:
>>>>>>> https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.com/
>>>>>>>
>>>>>>> An example of spreading uncore overhead across two CPUs:
>>>>>>> ```
>>>>>>> $ perf stat -A -e "data_read/cpu=0/,data_write/cpu=1/" -a sleep 0.1
>>>>>>>
>>>>>>>  Performance counter stats for 'system wide':
>>>>>>>
>>>>>>> CPU0               223.65 MiB  uncore_imc_free_running_0/cpu=0/
>>>>>>> CPU0               223.66 MiB  uncore_imc_free_running_1/cpu=0/
>>>>>>> CPU0        <not counted> MiB  uncore_imc_free_running_0/cpu=1/
>>>>>>> CPU1                 5.78 MiB  uncore_imc_free_running_0/cpu=1/
>>>>>>> CPU0        <not counted> MiB  uncore_imc_free_running_1/cpu=1/
>>>>>>> CPU1                 5.74 MiB  uncore_imc_free_running_1/cpu=1/
>>>>>>> ```
>>>>>>>
>>>>>>> Manually fixing the output it should be:
>>>>>>> ```
>>>>>>> CPU0               223.65 MiB  uncore_imc_free_running_0/data_read,cpu=0/
>>>>>>> CPU0               223.66 MiB  uncore_imc_free_running_1/data_read,cpu=0/
>>>>>>> CPU1                 5.78 MiB  uncore_imc_free_running_0/data_write,cpu=1/
>>>>>>> CPU1                 5.74 MiB  uncore_imc_free_running_1/data_write,cpu=1/
>>>>>>> ```
>>>>>>>
>>>>>>> That is data_read from 2 PMUs was counted on CPU0 and data_write was
>>>>>>> counted on CPU1.
>>>>>>
>>>>>> There was an effort to make the counter access from any CPU of the package.
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6a2f9035bfc27d0e9d78b13635dda9fb017ac01
>>>>>>
>>>>>> But now it limits the access from specific CPUs. It sounds like a
>>>>>> regression.
>>>>>
>>>>> Thanks Kan, I'm not sure I understand the comment.
>>>>
>>>> The flag is also applied for the uncore and RAPL.
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/events/intel/uncore.c?&id=e64cd6f73ff5a7eb4f8f759049ee24a3fe55e731
>>>>
>>>> So specifying a CPU to an uncore event doesn't make sense. If the
>>>> current CPU is in the same package as the asked CPU. The kernel will
>>>> always choose the current CPU.
>>>
>>> Ugh, that sounds sub-optimal. If I'm monitoring uncore events with
>>> cgroups CPU0 (or the first CPU in a package) is going to be loaded up
>>> with all the events and have all of the rdmsr/wrmsrs in its context
>>> switch. Perhaps we should warn and say to use BPF events.
>>>
>>> Is there a way through say ioctls to get the CPU an event is on? That
>>> way we could update the `perf stat -A` to accurately report cpus.
>>> There's also the issue that the affinity stuff is going to be off.
>>>
>>
>> I don't think there is such ioctl.
>>
>> Emphasizing the CPU ID for an uncore event seems misleading. The uncore
>> only supports per-socket counter, not per-core counter.
>> Opening/reading an counter from any CPUs on a package should be identical.
>> An accurate report of the `perf stat -A` for an uncore should use "S0".
> 
> I think it is an "elite" level trick to try to do things like balance
> context switch overhead. Putting everything on the first CPU feels
> like a scalability issue for cgroup events. BPF events work around it
> to some degree, but they are still going to put all the work on CPU0
> which could cause performance issues, latency spikes, etc. on it.

Yes, that's why the PERF_EV_CAP_READ_ACTIVE_PKG was introduced. So the
read would not be on the same CPU0.
But I'm not sure how bad it is if perf tool open/close all the uncore
events on the same default CPU0.

Thanks,
Kan
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>
>>> Thanks,
>>> Ian
>>>
>>>
>>>> Thanks,
>>>> Kan
>>>>> The overhead I was
>>>>> thinking of here is more along the lines of cgroup context switches
>>>>> (although that isn't in my example). There may be a large number of
>>>>> say memory controller events just by having 2 events for each PMU and
>>>>> then there are 10s of PMUs. By putting half of the events on 1 CPU and
>>>>> half on another, the context switch overhead is shared. That said, the
>>>>> counters don't care what cgroup is accessing memory, and users doing
>>>>> this are likely making some kind of error.
>>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>
> 
