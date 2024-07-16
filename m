Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877431E498;
	Tue, 16 Jul 2024 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134381; cv=none; b=WFgn1O7Q3jDUyEmFwy6bLeQ5y9YdnJ231OVu/RMj2WtGbKrso+orCyecILp5617WiOL8R16UygI0MM546nsdhNp8X1uCcOnrVuiDsv6KCtn9Od86g7IJXup8jUe70Ko/CU9/XgKN6ckIF1SKUoY3jq+M7VnxAh6jCF5dXZRA/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134381; c=relaxed/simple;
	bh=SSgUscryii1clarjrDEuWe0oAR9tIv+UZaWDyL8CiQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQt78nawFzrl1/c2nLVjy26npLPElNY+gGkXoINw/TLer51ck+XQGc0fbhjgWD2atpDzlMuCZnpM1n2wpIkmDDKWXNlKqo9T3+c5P5aYPbfBdWmco7C4r3pyfFQZ7Mpk+ztbg0UHJ66jkx76E5uuHbO3xhi8fDZJQw63qv2wXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0fDHM7m; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0fDHM7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721134380; x=1752670380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SSgUscryii1clarjrDEuWe0oAR9tIv+UZaWDyL8CiQM=;
  b=m0fDHM7meuyiqw5PIdfQXzrC0QrPVscaW7Vpvl7zHoeodfi/cnZrAvoB
   cENFF0I9CI/jw1p372cV0zVJ0ojLe+qTGjROGd3Z/CB0DqltE/Gr0tE0z
   GH7NvVKe4QJnDk+dkeIWd4XoyQCGhrwBBLl0IWK9cjRvw7b9LrCv/5vqW
   K3AjDuil8/QWYy9kslgk2V1TO1is6zOEvdRG4y0+hUE6DtJ/Ll4Cu2vZ3
   KtMfjkQmYcPO/sPjXwLBiUFhYKDWLxORuFueYV65fuKSOTOmjWy0/q3ME
   guCvIAtZloG3Rgk8DSqaNpmMVvg6S7ryKhuSya65Kko2KXqI6sXVpuPxM
   A==;
X-CSE-ConnectionGUID: s91ENogjSdSlErRHlfCFCA==
X-CSE-MsgGUID: aF9ib/P1QC+3QPPwW5+osw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18700718"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18700718"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 05:52:59 -0700
X-CSE-ConnectionGUID: CyQTy01RQ4S4qOmeiA/5sA==
X-CSE-MsgGUID: 9koCZ61vTuW6piZp7MQsJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="50062034"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 05:52:59 -0700
Received: from [10.213.174.231] (kliang2-mobl1.ccr.corp.intel.com [10.213.174.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4883E20B8CD6;
	Tue, 16 Jul 2024 05:52:57 -0700 (PDT)
Message-ID: <7491af6f-7be8-4a7a-8f48-249d26440bbc@linux.intel.com>
Date: Tue, 16 Jul 2024 08:52:55 -0400
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
 <48b4bfb0-d0c7-4d1f-9e52-06e873646366@linux.intel.com>
 <CAP-5=fV2YTD5ZWcZgYN+cX7atdoiM2G2=xN=c_q5UmXyQzEkRQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fV2YTD5ZWcZgYN+cX7atdoiM2G2=xN=c_q5UmXyQzEkRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-07-15 5:48 p.m., Ian Rogers wrote:
> On Mon, Jul 15, 2024 at 2:41 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-07-15 4:11 p.m., Ian Rogers wrote:
>>> On Mon, Jul 15, 2024 at 1:05 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>> Hi Ian,
>>>>
>>>> On 2024-07-10 12:59 a.m., kernel test robot wrote:
>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>> kernel test robot noticed "perf-sanity-tests.perf_all_PMU_test.fail" on:
>>>>>
>>>>> commit: e2641db83f18782f57a0e107c50d2d1731960fb8 ("perf vendor events: Add/update skylake events/metrics")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>>>
>>>>> [test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]
>>>>>
>>>>> in testcase: perf-sanity-tests
>>>>> version:
>>>>> with following parameters:
>>>>>
>>>>>       perf_compiler: gcc
>>>>>
>>>>>
>>>>>
>>>>> compiler: gcc-13
>>>>> test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory
>>>>>
>>>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>>>
>>>>>
>>>>> we also observed two cases which also failed on parent can pass on this commit.
>>>>> FYI.
>>>>>
>>>>>
>>>>> caccae3ce7b988b6 e2641db83f18782f57a0e107c50
>>>>> ---------------- ---------------------------
>>>>>        fail:runs  %reproduction    fail:runs
>>>>>            |             |             |
>>>>>            :6          100%           6:6     perf-sanity-tests.perf_all_PMU_test.fail
>>>>>            :6          100%           6:6     perf-sanity-tests.perf_all_metricgroups_test.pass
>>>>>            :6          100%           6:6     perf-sanity-tests.perf_all_metrics_test.pass
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>>> the same patch/commit), kindly add following tags
>>>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>> | Closes: https://lore.kernel.org/oe-lkp/202407101021.2c8baddb-oliver.sang@intel.com
>>>>>
>>>>>
>>>>>
>>>>> 2024-07-09 07:09:53 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 105
>>>>> 105: perf all metricgroups test                                      : Ok
>>>>> 2024-07-09 07:10:11 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 106
>>>>> 106: perf all metrics test                                           : Ok
>>>>> 2024-07-09 07:10:23 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 107
>>>>> 107: perf all libpfm4 events test                                    : Ok
>>>>> 2024-07-09 07:10:47 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 108
>>>>> 108: perf all PMU test                                               : FAILED!
>>>>>
>>>>
>>>> The failure is caused by the below change in the e2641db83f18.
>>>>
>>>> +    {
>>>> +        "BriefDescription": "This 48-bit fixed counter counts the UCLK
>>>> cycles",
>>>> +        "Counter": "FIXED",
>>>> +        "EventCode": "0xff",
>>>> +        "EventName": "UNC_CLOCK.SOCKET",
>>>> +        "PerPkg": "1",
>>>> +        "PublicDescription": "This 48-bit fixed counter counts the UCLK
>>>> cycles.",
>>>> +        "Unit": "cbox_0"
>>>>      }
>>>>
>>>> The other cbox events have the unit name "CBOX", while the fixed counter
>>>> has a unit name "cbox_0". So the events_table will maintain separate
>>>> entries for cbox and cbox_0.
>>>>
>>>> The perf_pmus__print_pmu_events() calculate the total number of events,
>>>> allocate an aliases buffer, store all the events into the buffer, sort,
>>>> and print all the aliases one by one.
>>>>
>>>> The problem is that the calculated total number of events doesn't match
>>>> the stored events on the SKL machine.
>>>>
>>>> The perf_pmu__num_events() is used to calculate the number of events. It
>>>> invokes the pmu_events_table__num_events() to go through the entire
>>>> events_table to find all events. Because of the
>>>> pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. So
>>>> the events for cbox and cbox_0 are all counted.
>>>>
>>>> When storing events into the aliases buffer, the
>>>> perf_pmu__for_each_event() only process the events for cbox.
>>>>
>>>> Since a bigger buffer was allocated, the last entry are all 0.
>>>> When printing all the aliases, null will be outputed.
>>>>
>>>> $ perf list pmu
>>>>
>>>> List of pre-defined events (to be used in -e or -M):
>>>>
>>>>   (null)                                             [Kernel PMU event]
>>>>   branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
>>>>   branch-misses OR cpu/branch-misses/                [Kernel PMU event]
>>>>
>>>>
>>>> I'm thinking of two ways to address it.
>>>> One is to only print all the stored events. The below patch can fix it.
>>>>
>>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>>> index 3fcabfd8fca1..2b2f5117ff84 100644
>>>> --- a/tools/perf/util/pmus.c
>>>> +++ b/tools/perf/util/pmus.c
>>>> @@ -485,6 +485,7 @@ void perf_pmus__print_pmu_events(const struct
>>>> print_callbacks *print_cb, void *p
>>>>                 perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
>>>>                                         perf_pmus__print_pmu_events__callback);
>>>>         }
>>>> +       len = state.index;
>>>>         qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>>>>         for (int j = 0; j < len; j++) {
>>>>                 /* Skip duplicates */
>>>>
>>>> The only drawback is that perf list will not show the new cbox_0 event.
>>>> (But the event name still works. Users can still apply perf stat -e
>>>> unc_clock.socket.)
>>>>
>>>> Since the cbox_0 event is only available on old machines (SKL and
>>>> earlier), people should already use the equivalent kernel event. It
>>>> doesn't sounds a big issue for me. I prefer this simple fix.
>>>>
>>>> I think the other way would be to modify the perf_pmu__for_each_event()
>>>> to go through all the possible PMUs.
>>>> It seems complicated and may impact others ARCHs (e.g., S390). I haven't
>>>> tried it yet.
>>>>
>>>> What do you think?
>>>> Do you see any other ways to address the issue?
>>>
>>> Ugh. It seems the sizing and then iterating approach is just prone to
>>> keep breaking. Perhaps we can switch to realloc-ed arrays to avoid the
>>> need for perf_pmu__num_events, which seems to be the source of the
>>> problems.
>>>
>>
>> I think a realloc-ed array should have the same drawback as the first
>> way, but bad performance.
>> Because the pmu_add_cpu_aliases() in the perf_pmu__for_each_event() only
>> add the events from the first matched PMU. If we don't fix it, the
>> UNC_CLOCK.SOCKET of cbox_0 will never be displayed.
> 
> Ok, but I don't think we need to optimize `perf list` for speed. Fwiw,
> I think this was the fix for the last bug in this code:
> https://lore.kernel.org/r/20240511003601.2666907-1-irogers@google.com

That seems a different issue.
The root cause of this issue should be that different methods are used
between calculating the total number of events and adding the events.
A realloc-ed array should just hide the problem. There will still be an
issue if anyone use the pair of perf_pmu__num_events() and
pmu_add_cpu_aliases() somewhere else later.

It looks like the difference is introduced from the commit 	e3edd6cf6399
("perf pmu-events: Reduce processed events by passing PMU").

The pmu_events_table__for_each_event() stops immediately once a pmu is
set. But for uncore, especially this case, the method is wrong and
mismatch what perf does in the perf_pmu__num_events().

The below patch can fix it.

diff --git a/tools/perf/pmu-events/jevents.py
b/tools/perf/pmu-events/jevents.py
index ac9b7ca41856..97a3b018f865 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -923,7 +923,7 @@ int pmu_events_table__for_each_event(const struct
pmu_events_table *table,
 			continue;

 		ret = pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data);
-		if (pmu || ret)
+		if (ret)
 			return ret;
 	}
 	return 0;

The event can be displayed by the perf list pmu with the patch.

$ perf list pmu | grep -A 1 clock.socket
   unc_clock.socket
        [This 48-bit fixed counter counts the UCLK cycles. Unit:
uncore_cbox_0
& perf test "perf all PMU test"
  107: perf all PMU test                                               : Ok

I will send the patch shortly.

Thanks,
Kan
