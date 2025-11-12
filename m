Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D502F39A0;
	Wed, 12 Nov 2025 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935286; cv=none; b=aDIoEjGEJBKZDWlwzmk0+YluN3O+YX+XayW5rQo2cu+Nl4EUozSAytI3tgXG/8mXvVCUkRD5HRJEulpfrHm/O6rXxbCFjGSzhLr6COwUCpSHXxoz9JvF8pZXM+rMAcer8BzSR+NzGfr5ZXV6/HskdsSmUP2hHcI7Aw5DDJIwWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935286; c=relaxed/simple;
	bh=WYgX0FKG9Guv3WlwIL03GDkaWzHmiAYxyETrB2n5AZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhWrmh3G/T1r/Ng6QBOzGsc3JRpT+M6B6it5TkNuRwcVw5jou/4HDRV9JorsHPLc6hBxluY6R7j3K2OKOurAKzH/d7dGSF6q/7vNPkAIXgdLUWmd4kX8oNnL3tDK3XnVnHxT+uuuNQjRmHX5x21qboJ1dNrFnLg0/N3AYWcYnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzzDQuwY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzzDQuwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762935284; x=1794471284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WYgX0FKG9Guv3WlwIL03GDkaWzHmiAYxyETrB2n5AZA=;
  b=SzzDQuwYdhAqFt6IgQxTqQkESzOxzBg/6z13fSZ+gFz+nm/lbkpTC3Gn
   UB/sYCxiRXsLmwojRboopbXP1duPVAadkuwQWXYpgACeO1b3uIXFw/8rG
   yrQQrE5jL9GJi9VqXqUcf7xWTT45rotDCBTKvlo/zAbWx2xJE9NRQ0BzJ
   DAJ7JQCrNLdgz3Zivq+MQE3B8dILQJnggWO2miG6w+aIq1dIcmkS4tbyh
   KkDZPIdzm0d2Bqp5BOxa+ATPCI/7GwWOcTg7MDxech+tVCR+GKYjqgI13
   49uGneAAihftYt1WWSaBYiHZcG7R3YB6eFnHxcnHSHAq6FTyqr1FPhZqV
   A==;
X-CSE-ConnectionGUID: zxIAFsXGTuWuK/kiCypk/A==
X-CSE-MsgGUID: 2gy5xm7lQFalbq9SqABD3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76342298"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="76342298"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:14:42 -0800
X-CSE-ConnectionGUID: Lcoj95hMRROPE7w5T72K9w==
X-CSE-MsgGUID: YDmGRiLeTpWXBRS6WNPxYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="194135220"
Received: from unknown (HELO [10.238.3.175]) ([10.238.3.175])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:14:37 -0800
Message-ID: <cc52364a-6b8b-4967-bde0-315294b9ab2d@linux.intel.com>
Date: Wed, 12 Nov 2025 16:14:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/18] perf metricgroup: Add care to picking the evsel
 for displaying a metric
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
 Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Collin Funk <collin.funk1@gmail.com>, Thomas Falcon
 <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>,
 Levi Yun <yeoreum.yun@arm.com>, Yang Li <yang.lee@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
References: <20251111040417.270945-1-irogers@google.com>
 <20251111040417.270945-2-irogers@google.com>
 <e0d29714-df04-48f9-8168-770bf05a0f7f@linux.intel.com>
 <CAP-5=fWWxbRS4D1GsPvSgr32cfCGaT68qV0Q6-FLQ90R-bhH3w@mail.gmail.com>
 <aROJF9GjJUv-w5Wg@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aROJF9GjJUv-w5Wg@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/12/2025 3:05 AM, Namhyung Kim wrote:
> On Tue, Nov 11, 2025 at 09:20:30AM -0800, Ian Rogers wrote:
>> On Tue, Nov 11, 2025 at 12:15 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>
>>> On 11/11/2025 12:04 PM, Ian Rogers wrote:
>>>> Rather than using the first evsel in the matched events, try to find
>>>> the least shared non-tool evsel. The aim is to pick the first evsel
>>>> that typifies the metric within the list of metrics.
>>>>
>>>> This addresses an issue where Default metric group metrics may lose
>>>> their counter value due to how the stat displaying hides counters for
>>>> default event/metric output.
>>>>
>>>> For a metricgroup like TopdownL1 on an Intel Alderlake the change is,
>>>> before there are 4 events with metrics:
>>>> ```
>>>> $ perf stat -M topdownL1 -a sleep 1
>>>>
>>>>  Performance counter stats for 'system wide':
>>>>
>>>>      7,782,334,296      cpu_core/TOPDOWN.SLOTS/          #     10.4 %  tma_bad_speculation
>>>>                                                   #     19.7 %  tma_frontend_bound
>>>>      2,668,927,977      cpu_core/topdown-retiring/       #     35.7 %  tma_backend_bound
>>>>                                                   #     34.1 %  tma_retiring
>>>>        803,623,987      cpu_core/topdown-bad-spec/
>>>>        167,514,386      cpu_core/topdown-heavy-ops/
>>>>      1,555,265,776      cpu_core/topdown-fe-bound/
>>>>      2,792,733,013      cpu_core/topdown-be-bound/
>>>>        279,769,310      cpu_atom/TOPDOWN_RETIRING.ALL/   #     12.2 %  tma_retiring
>>>>                                                   #     15.1 %  tma_bad_speculation
>>>>        457,917,232      cpu_atom/CPU_CLK_UNHALTED.CORE/  #     38.4 %  tma_backend_bound
>>>>                                                   #     34.2 %  tma_frontend_bound
>>>>        783,519,226      cpu_atom/TOPDOWN_FE_BOUND.ALL/
>>>>         10,790,192      cpu_core/INT_MISC.UOP_DROPPING/
>>>>        879,845,633      cpu_atom/TOPDOWN_BE_BOUND.ALL/
>>>> ```
>>>>
>>>> After there are 6 events with metrics:
>>>> ```
>>>> $ perf stat -M topdownL1 -a sleep 1
>>>>
>>>>  Performance counter stats for 'system wide':
>>>>
>>>>      2,377,551,258      cpu_core/TOPDOWN.SLOTS/          #      7.9 %  tma_bad_speculation
>>>>                                                   #     36.4 %  tma_frontend_bound
>>>>        480,791,142      cpu_core/topdown-retiring/       #     35.5 %  tma_backend_bound
>>>>        186,323,991      cpu_core/topdown-bad-spec/
>>>>         65,070,590      cpu_core/topdown-heavy-ops/      #     20.1 %  tma_retiring
>>>>        871,733,444      cpu_core/topdown-fe-bound/
>>>>        848,286,598      cpu_core/topdown-be-bound/
>>>>        260,936,456      cpu_atom/TOPDOWN_RETIRING.ALL/   #     12.4 %  tma_retiring
>>>>                                                   #     17.6 %  tma_bad_speculation
>>>>        419,576,513      cpu_atom/CPU_CLK_UNHALTED.CORE/
>>>>        797,132,597      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #     38.0 %  tma_frontend_bound
>>>>          3,055,447      cpu_core/INT_MISC.UOP_DROPPING/
>>>>        671,014,164      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #     32.0 %  tma_backend_bound
>>>> ```
>>> It looks the output of cpu_core and cpu_atom events are mixed together,
>>> like the "cpu_core/INT_MISC.UOP_DROPPING/". Could we resort the events and
>>> separate the cpu_core and cpu_atom events output? It would make the output
>>> more read-friendly. Thanks.
>> So the metrics are tagged as to not group the events:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=perf-tools-next#n117
>> Running with each metric causes the output to be:
>> ```
>> $ perf stat -M tma_bad_speculation,tma_backend_bound,tma_frontend_bound,tma_retiring
>> -a sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>>      1,615,145,897      cpu_core/TOPDOWN.SLOTS/          #      8.1 %
>> tma_bad_speculation
>>                                                   #     42.5 %
>> tma_frontend_bound       (49.89%)
>>        243,037,087      cpu_core/topdown-retiring/       #     34.5 %
>> tma_backend_bound        (49.89%)
>>        129,341,306      cpu_core/topdown-bad-spec/
>>                          (49.89%)
>>          2,679,894      cpu_core/INT_MISC.UOP_DROPPING/
>>                          (49.89%)
>>        696,940,348      cpu_core/topdown-fe-bound/
>>                          (49.89%)
>>        563,319,011      cpu_core/topdown-be-bound/
>>                          (49.89%)
>>      1,795,034,847      cpu_core/slots/
>>                          (50.11%)
>>        262,140,961      cpu_core/topdown-retiring/
>>                          (50.11%)
>>         44,589,349      cpu_core/topdown-heavy-ops/      #     14.4 %
>> tma_retiring             (50.11%)
>>        160,987,341      cpu_core/topdown-bad-spec/
>>                          (50.11%)
>>        778,250,364      cpu_core/topdown-fe-bound/
>>                          (50.11%)
>>        622,499,674      cpu_core/topdown-be-bound/
>>                          (50.11%)
>>         90,849,750      cpu_atom/TOPDOWN_RETIRING.ALL/   #      8.1 %
>> tma_retiring
>>                                                   #     17.2 %
>> tma_bad_speculation
>>        223,878,243      cpu_atom/CPU_CLK_UNHALTED.CORE/
>>        423,068,733      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #     37.8 %
>> tma_frontend_bound
>>        413,413,499      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #     36.9 %
>> tma_backend_bound
>> ```
>> so you can see that it is the effect of not grouping the events that
>> leads to the cpu_core and cpu_atom split.
>>
>> The code that does sorting/fixing/adding of events, primarily to fix
>> topdown, is parse_events__sort_events_and_fix_groups:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2030
>> but I've tried to make that code respect the incoming evsel list order
>> because if a user specifies an order then they generally expect it to
>> be respected (unless invalid or because of topdown events). For
>> --metric-only the event order doesn't really matter.
>>
>> Anyway, I think trying to fix this is out of scope for this patch
>> series, although I agree with you about the readability. The behavior
>> here matches old behavior such as:
>> ```
>> $ perf --version
>> perf version 6.16.12
>> $ perf stat -M TopdownL1 -a sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>>     11,086,754,658      cpu_core/TOPDOWN.SLOTS/          #     27.1 %
>> tma_backend_bound
>>                                                   #      7.5 %
>> tma_bad_speculation
>>                                                   #     36.5 %
>> tma_frontend_bound
>>                                                   #     28.9 %
>> tma_retiring
>>      3,219,475,010      cpu_core/topdown-retiring/
>>        820,655,931      cpu_core/topdown-bad-spec/
>>        418,883,912      cpu_core/topdown-heavy-ops/
>>      4,082,884,459      cpu_core/topdown-fe-bound/
>>      3,012,532,414      cpu_core/topdown-be-bound/
>>      1,030,171,196      cpu_atom/TOPDOWN_RETIRING.ALL/   #     17.4 %
>> tma_retiring
>>                                                   #     16.5 %
>> tma_bad_speculation
>>      1,185,093,601      cpu_atom/CPU_CLK_UNHALTED.CORE/  #     29.8 %
>> tma_backend_bound
>>                                                   #     36.4 %
>> tma_frontend_bound
>>      2,154,914,153      cpu_atom/TOPDOWN_FE_BOUND.ALL/
>>         14,988,684      cpu_core/INT_MISC.UOP_DROPPING/
>>      1,763,486,868      cpu_atom/TOPDOWN_BE_BOUND.ALL/
>>
>>        1.004103365 seconds time elapsed
>> ```
>> ie the cpu_core and cpu_atom mixing of events isn't a regression
>> introduced here. There isn't a simple fix for the ordering, as we
>> don't want to mess up the non-metric cases. I'm happy if you think
>> things can be otherwise to make a change.
> Agreed and it should be handled in a separate patch (series).  Let's fix
> problems one at a time.

It makes sense. Thanks.


>
> Thanks,
> Namhyung
>
>
