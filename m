Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCE3BBC2;
	Mon, 15 Jul 2024 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721079666; cv=none; b=YWzzBi0zKbI+hbST9Qs6Oyp3zYRtiHhnLoufmfKdBViB1pjDeUisQ01LadgmV4IpazNlzcw+PtviaZjQ530gMhgacvXMbjcExRoWH3RUnnhn1zKTYckjThHZMW3heyYiPmOr72dPRF3klpekTQEqmzMAtXrFf8W6NgtNX+QXrlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721079666; c=relaxed/simple;
	bh=PwA2652JlJnz5K9p0q2tEwhs5eV6Sq/FtsBPNbPwZsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ktra/K/82M5SNQI+LMRmutgLyycIbfZEIg2zgQwk9UzVO50Okq+XwGHWOn1zXOuHsroWyIoiOP0QAj1ePQ2/IfQdM9tHp35YH6xHSswg6D+ObCiIXpF67ILdllzEb6Q5O4dePgrn8qNYCXlGcDVg7eO5OHJKixV/4dbyEsqSYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fF4JVtLW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fF4JVtLW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721079664; x=1752615664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PwA2652JlJnz5K9p0q2tEwhs5eV6Sq/FtsBPNbPwZsg=;
  b=fF4JVtLW+nJvSxrBhs4mP/EhP2xBxx1/pL6c5gP7v5gM/vF6GiN9rRZK
   V+3koFRS91edwUStJOhCpHYG/henqVMYy/rHq1gZiLQkNcZoBU8a2UStu
   NtBvPzjH7MvefnUCYj35bSPy5fZ9ypzGQZbUFwUNmg4VJV5dFnErabHKe
   rh7CeIJmhurvmxrBg0PSFK5LpwogEf8M9cJmPCMaInVeFlvve/DwFFeUH
   2rSbEl7rIK6oT/9gnLipz8sI1cl+obH2LWkCrWmvXskQVP6RVt+jTopCZ
   +Fy2ftRBFxEOIpCk9stlUMn6A2xwR/atcxiH1Yfoc9Auv6WdJL689/TI2
   Q==;
X-CSE-ConnectionGUID: rAUt6OylQximujQbqXMXGQ==
X-CSE-MsgGUID: sfiyiyHMT4e7JgEzonkVYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="41013559"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="41013559"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 14:41:04 -0700
X-CSE-ConnectionGUID: J5GnYYHxT9eDvwEtB5ny5w==
X-CSE-MsgGUID: cca2o6NZTNWyZG47SSGLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54683053"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 14:41:04 -0700
Received: from [10.212.96.36] (kliang2-mobl1.ccr.corp.intel.com [10.212.96.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6F39420B8CD6;
	Mon, 15 Jul 2024 14:41:02 -0700 (PDT)
Message-ID: <48b4bfb0-d0c7-4d1f-9e52-06e873646366@linux.intel.com>
Date: Mon, 15 Jul 2024 17:41:01 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [perf vendor events] e2641db83f:
 perf-sanity-tests.perf_all_PMU_test.fail
To: Ian Rogers <irogers@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
 Namhyung Kim <namhyung@kernel.org>, Weilin Wang <weilin.wang@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202407101021.2c8baddb-oliver.sang@intel.com>
 <ec744c86-b73e-417a-8e3a-c07142bf37d1@linux.intel.com>
 <CAP-5=fUqGcnGvB71jHHTecLqcky6+TrFo+hWb=eBxZjxfe_m-g@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUqGcnGvB71jHHTecLqcky6+TrFo+hWb=eBxZjxfe_m-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-07-15 4:11 p.m., Ian Rogers wrote:
> On Mon, Jul 15, 2024 at 1:05 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> Hi Ian,
>>
>> On 2024-07-10 12:59 a.m., kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed "perf-sanity-tests.perf_all_PMU_test.fail" on:
>>>
>>> commit: e2641db83f18782f57a0e107c50d2d1731960fb8 ("perf vendor events: Add/update skylake events/metrics")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>
>>> [test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]
>>>
>>> in testcase: perf-sanity-tests
>>> version:
>>> with following parameters:
>>>
>>>       perf_compiler: gcc
>>>
>>>
>>>
>>> compiler: gcc-13
>>> test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory
>>>
>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>
>>>
>>> we also observed two cases which also failed on parent can pass on this commit.
>>> FYI.
>>>
>>>
>>> caccae3ce7b988b6 e2641db83f18782f57a0e107c50
>>> ---------------- ---------------------------
>>>        fail:runs  %reproduction    fail:runs
>>>            |             |             |
>>>            :6          100%           6:6     perf-sanity-tests.perf_all_PMU_test.fail
>>>            :6          100%           6:6     perf-sanity-tests.perf_all_metricgroups_test.pass
>>>            :6          100%           6:6     perf-sanity-tests.perf_all_metrics_test.pass
>>>
>>>
>>>
>>>
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202407101021.2c8baddb-oliver.sang@intel.com
>>>
>>>
>>>
>>> 2024-07-09 07:09:53 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 105
>>> 105: perf all metricgroups test                                      : Ok
>>> 2024-07-09 07:10:11 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 106
>>> 106: perf all metrics test                                           : Ok
>>> 2024-07-09 07:10:23 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 107
>>> 107: perf all libpfm4 events test                                    : Ok
>>> 2024-07-09 07:10:47 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 108
>>> 108: perf all PMU test                                               : FAILED!
>>>
>>
>> The failure is caused by the below change in the e2641db83f18.
>>
>> +    {
>> +        "BriefDescription": "This 48-bit fixed counter counts the UCLK
>> cycles",
>> +        "Counter": "FIXED",
>> +        "EventCode": "0xff",
>> +        "EventName": "UNC_CLOCK.SOCKET",
>> +        "PerPkg": "1",
>> +        "PublicDescription": "This 48-bit fixed counter counts the UCLK
>> cycles.",
>> +        "Unit": "cbox_0"
>>      }
>>
>> The other cbox events have the unit name "CBOX", while the fixed counter
>> has a unit name "cbox_0". So the events_table will maintain separate
>> entries for cbox and cbox_0.
>>
>> The perf_pmus__print_pmu_events() calculate the total number of events,
>> allocate an aliases buffer, store all the events into the buffer, sort,
>> and print all the aliases one by one.
>>
>> The problem is that the calculated total number of events doesn't match
>> the stored events on the SKL machine.
>>
>> The perf_pmu__num_events() is used to calculate the number of events. It
>> invokes the pmu_events_table__num_events() to go through the entire
>> events_table to find all events. Because of the
>> pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. So
>> the events for cbox and cbox_0 are all counted.
>>
>> When storing events into the aliases buffer, the
>> perf_pmu__for_each_event() only process the events for cbox.
>>
>> Since a bigger buffer was allocated, the last entry are all 0.
>> When printing all the aliases, null will be outputed.
>>
>> $ perf list pmu
>>
>> List of pre-defined events (to be used in -e or -M):
>>
>>   (null)                                             [Kernel PMU event]
>>   branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
>>   branch-misses OR cpu/branch-misses/                [Kernel PMU event]
>>
>>
>> I'm thinking of two ways to address it.
>> One is to only print all the stored events. The below patch can fix it.
>>
>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>> index 3fcabfd8fca1..2b2f5117ff84 100644
>> --- a/tools/perf/util/pmus.c
>> +++ b/tools/perf/util/pmus.c
>> @@ -485,6 +485,7 @@ void perf_pmus__print_pmu_events(const struct
>> print_callbacks *print_cb, void *p
>>                 perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
>>                                         perf_pmus__print_pmu_events__callback);
>>         }
>> +       len = state.index;
>>         qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>>         for (int j = 0; j < len; j++) {
>>                 /* Skip duplicates */
>>
>> The only drawback is that perf list will not show the new cbox_0 event.
>> (But the event name still works. Users can still apply perf stat -e
>> unc_clock.socket.)
>>
>> Since the cbox_0 event is only available on old machines (SKL and
>> earlier), people should already use the equivalent kernel event. It
>> doesn't sounds a big issue for me. I prefer this simple fix.
>>
>> I think the other way would be to modify the perf_pmu__for_each_event()
>> to go through all the possible PMUs.
>> It seems complicated and may impact others ARCHs (e.g., S390). I haven't
>> tried it yet.
>>
>> What do you think?
>> Do you see any other ways to address the issue?
> 
> Ugh. It seems the sizing and then iterating approach is just prone to
> keep breaking. Perhaps we can switch to realloc-ed arrays to avoid the
> need for perf_pmu__num_events, which seems to be the source of the
> problems.
> 

I think a realloc-ed array should have the same drawback as the first
way, but bad performance.
Because the pmu_add_cpu_aliases() in the perf_pmu__for_each_event() only
add the events from the first matched PMU. If we don't fix it, the
UNC_CLOCK.SOCKET of cbox_0 will never be displayed.

Thanks,
Kan
