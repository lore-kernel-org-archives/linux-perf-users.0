Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25126A1CC;
	Tue, 20 May 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759530; cv=none; b=SgKqGgrMUQrEGiNGflYC04TI7U/+W4AlW8TYnYG8VihZx7FEpU/zNltHl+kWdavaTYSszC1jZw/YHegTfHGtEbIpFWIglVLyxA6jXiAF/9ojgHkyG0aLFDvHOd9xYTnLATIgXB8Bj+VdLxQhTVkhRLypbfqqjP3I/kpPaHwbjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759530; c=relaxed/simple;
	bh=2m5zn8UGpDXLkEP1kMEnT4ipR3FUe9IKaZfpADLI8DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiFK7BKb4PI55MkLORGdltlbQLBy/zHy37w7nbChtll/tcpMtvTj30f8ZgxXjVmFqHLOqIMujVIY2mugJTg5QR09f0PcLvp/1raA2MoyW2PD3atGQupOGNKwh3/cJZgTDf+Hg8nCMwSAFyZ2aHTQWIBGUNt/VYYcrYFWkbhZNAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqEuqm9N; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqEuqm9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747759528; x=1779295528;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2m5zn8UGpDXLkEP1kMEnT4ipR3FUe9IKaZfpADLI8DU=;
  b=CqEuqm9NHB/zSChD3fG07oRt5FhIEvJw4BxoKj/Wt+mWtyqmZhLL17WT
   qg0Bi72TvwxfQgw97l4/jByQ/tshOo/5IE1TnCkBmgXe3ZPM9XQrCZ8+n
   jgkGiWtZetdG6HQPGaZc6QoDsAB5fQvRuRaO61Im2N67Kt/EDIQR/wRrD
   K+usJYiqtv3zXa3AQpjwZAeuqfdt2ly+65gayDeONyH9eZv9dxYzWNVjE
   kzi13zVhcsnHYGB9ivabWbqVFFbOpaRLGlfCWV2BEfvA4Awerg8Od1KFa
   kIG7x3CrP7U/OjpeO/LJkmYd3XYZ/+EtVRY2cqVAxzDYffl1spbkOsDKm
   Q==;
X-CSE-ConnectionGUID: GTYIkCnnQR2TgZFqQuzfNw==
X-CSE-MsgGUID: o4j2Lhy4RyGIB3qFLqpDVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="48822342"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48822342"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 09:45:27 -0700
X-CSE-ConnectionGUID: vKh2UPJtTpKbChH0XxNSAg==
X-CSE-MsgGUID: J5D+VUrxRGeNis7RNldSng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139787863"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 09:45:27 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9F69A20B5736;
	Tue, 20 May 2025 09:45:25 -0700 (PDT)
Message-ID: <1fcdbfa7-5d99-4337-a473-eb711f27b8a3@linux.intel.com>
Date: Tue, 20 May 2025 12:45:24 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250515181417.491401-1-irogers@google.com>
 <96c8fae8-b8f9-4094-b03a-9dba3ca234c2@linux.intel.com>
 <CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com>
 <aCoUMOVRjCr_t0ae@google.com>
 <CAP-5=fXnvRLiGmV7rr2H8A2Hj7HDE9m+B6Qn0areRXBhz-tK+Q@mail.gmail.com>
 <aCviJJpEYKt8wYEk@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <aCviJJpEYKt8wYEk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-05-19 10:00 p.m., Namhyung Kim wrote:
> On Sun, May 18, 2025 at 10:45:52AM -0700, Ian Rogers wrote:
>> On Sun, May 18, 2025 at 10:09 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>>
>>> Hello,
>>>
>>> On Thu, May 15, 2025 at 03:35:41PM -0700, Ian Rogers wrote:
>>>> On Thu, May 15, 2025 at 2:01 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>
>>>>> On 2025-05-15 2:14 p.m., Ian Rogers wrote:
>>>>>> On graniterapids the cache home agent (CHA) and memory controller
>>>>>> (IMC) PMUs all have their cpumask set to per-socket information. In
>>>>>> order for per NUMA node aggregation to work correctly the PMUs cpumask
>>>>>> needs to be set to CPUs for the relevant sub-NUMA grouping.
>>>>>>
>>>>>> For example, on a 2 socket graniterapids machine with sub NUMA
>>>>>> clustering of 3, for uncore_cha and uncore_imc PMUs the cpumask is
>>>>>> "0,120" leading to aggregation only on NUMA nodes 0 and 3:
>>>>>> ```
>>>>>> $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep 1
>>>>>>
>>>>>>  Performance counter stats for 'system wide':
>>>>>>
>>>>>> N0        1    277,835,681,344      UNC_CHA_CLOCKTICKS
>>>>>> N0        1     19,242,894,228      UNC_M_CLOCKTICKS
>>>>>> N3        1    277,803,448,124      UNC_CHA_CLOCKTICKS
>>>>>> N3        1     19,240,741,498      UNC_M_CLOCKTICKS
>>>>>>
>>>>>>        1.002113847 seconds time elapsed
>>>>>> ```
>>>>>>
>>>>>> By updating the PMUs cpumasks to "0,120", "40,160" and "80,200" then
>>>>>> the correctly 6 NUMA node aggregations are achieved:
>>>>>> ```
>>>>>> $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep 1
>>>>>>
>>>>>>  Performance counter stats for 'system wide':
>>>>>>
>>>>>> N0        1     92,748,667,796      UNC_CHA_CLOCKTICKS
>>>>>> N0        0      6,424,021,142      UNC_M_CLOCKTICKS
>>>>>> N1        0     92,753,504,424      UNC_CHA_CLOCKTICKS
>>>>>> N1        1      6,424,308,338      UNC_M_CLOCKTICKS
>>>>>> N2        0     92,751,170,084      UNC_CHA_CLOCKTICKS
>>>>>> N2        0      6,424,227,402      UNC_M_CLOCKTICKS
>>>>>> N3        1     92,745,944,144      UNC_CHA_CLOCKTICKS
>>>>>> N3        0      6,423,752,086      UNC_M_CLOCKTICKS
>>>>>> N4        0     92,725,793,788      UNC_CHA_CLOCKTICKS
>>>>>> N4        1      6,422,393,266      UNC_M_CLOCKTICKS
>>>>>> N5        0     92,717,504,388      UNC_CHA_CLOCKTICKS
>>>>>> N5        0      6,421,842,618      UNC_M_CLOCKTICKS
>>>>>
>>>>> Is the second coloum  the number of units?
>>>>> If so, it's wrong.
>>>>>
>>>>> On my GNR with SNC-2, I observed the similar issue.
>>>>>
>>>>> $ sudo ./perf stat -e 'UNC_M_CLOCKTICKS' --per-node -a sleep 1
>>>>>  Performance counter stats for 'system wide':
>>>>>
>>>>> N0        0      6,405,811,284      UNC_M_CLOCKTICKS
>>>>> N1        1      6,405,895,988      UNC_M_CLOCKTICKS
>>>>> N2        0      6,152,906,692      UNC_M_CLOCKTICKS
>>>>> N3        1      6,063,415,630      UNC_M_CLOCKTICKS
>>>>>
>>>>> It's supposed to be 4?
>>>>
>>>> Agreed it is weird, but it is what has historically been displayed.
>>>> The number is the aggregation number:
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat-display.c?h=perf-tools-next#n307
>>>> which comes from:
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat-display.c?h=perf-tools-next#n135
>>>> which comes from:
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.c?h=perf-tools-next#n435
>>>> However, I think it is missing updates from:
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.c?h=perf-tools-next#n526
>>>> but there is a comment there saying "don't increase aggr.nr for
>>>> aliases" and all the uncore events are aliases. I don't understand
>>>> what the aggregation number is supposed to be, it is commented as
>>>> "number of entries (CPUs) aggregated":
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.h?h=perf-tools-next#n26
>>>> it would seem to make sense in the CHA case with SNC3 and 42 evsels
>>>> per NUMA node that the value should be 42. Maybe Namhyung (who did the
>>>> evsel__merge_aggr_counters clean up) knows why it is this way but in
>>>> my eyes it just seems like something that has been broken for a long
>>>> time.
>>>
>>> I think it's the number of aggregated entries (FDs?).
>>>
>>> For core events, it's the number of CPUs for the given aggregation as it
>>> collects from all CPUs.  But it'd be confusing with uncore events which
>>> have cpumask to collect data from a few CPUs.
>>>
>>> On my laptop, --per-socket gives different numbers depending on the
>>> events/PMUs.
>>>
>>> For core events, it's 4.
>>>
>>>   $ sudo ./perf stat -a --per-socket -e cycles sleep 1
>>>
>>>    Performance counter stats for 'system wide':
>>>
>>>   S0        4        225,297,257      cycles
>>>
>>>          1.002581995 seconds time elapsed
>>>
>>> While uncore events give 1.
>>>
>>>   $ sudo ./perf stat -a --per-socket -e unc_mc0_rdcas_count_freerun sleep 1
>>>
>>>    Performance counter stats for 'system wide':
>>>
>>>   S0        1         23,665,510      unc_mc0_rdcas_count_freerun
>>>
>>>          1.002148012 seconds time elapsed
>>
>> I think we're agreeing. I wonder that the intent of the aggregation
>> number is to make it so that you can work out an average from the
>> aggregated count. So for core PMUs you divide the count by the
>> aggregation number and get the average count per core (CPU?). If we're
>> getting an aggregated count of say uncore memory controller events
>> then it would make sense to me that we show the aggregated total and
>> the aggregation count is the number of memory controller PMUs, so we
>> can have an average per memory controller. This should line up with
>> using the number of file descriptors.
> 
> Sounds right.
> 
>>
>> I think this isn't the current behavior, on perf v6.12:
>> ```
>> $ sudo perf stat --per-socket -e data_read -a sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>> S0        1           2,484.96 MiB  data_read
>>
>>        1.001365319 seconds time elapsed
>>
>> $ sudo perf stat -A -e data_read -a sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>> CPU0             1,336.48 MiB  data_read [uncore_imc_free_running_0]
>> CPU0             1,337.06 MiB  data_read [uncore_imc_free_running_1]
>>
>>        1.001049096 seconds time elapsed
>> ```
>> so the aggregation number shows 1 but 2 events were aggregated together.
> 
> Ugh.. right.  Merging uncore PMU instances can add more confusion. :(
> 
>>
>> I think computing the aggregation number in the stat code is probably
>> wrong. The value should be constant for an evsel and aggr_cpu_id, it's
>> just computing it for an aggr_cpu_id is a pain due to needing topology
>> and/or PMU information. The code is ripe for refactoring. I'd prefer
>> not to do it as part of this change though which is altering a
>> particular Intel Granite Rapids issue.
> 
> That's ok.  Just one more TODO items..
> 

Sounds good to me as well.

For this patch, I've verified it with SNC-2. The rest looks good to me.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
