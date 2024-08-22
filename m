Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CC2C87A;
	Thu, 22 Aug 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339933; cv=none; b=WhKze+T2sMhCO0pfyqSq5W/0oWY9gir/q7h41Yw3PK9k//mdem68v55fRA4kx0M/lUCkRtzX0+0F+Rn/QqEzlh3h77n6jJLZ9IExWwv3+9qHX7fDO4MIssgWbZIRTQ+Sf/WeyaGDDVjNoZFZUH6Ds+h8JNRyTU8j/bUqLIJHX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339933; c=relaxed/simple;
	bh=YyfGO78CAwcZoLYK5WysriOso1HPKdlX6tstLpHk1hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ax4drUHQTNcf94/LtQrmTSqJgKCPMeb80LE0yXsVJZRddtQzwtAkRvmld7ppmoDr3DWbL3QKybdFv6vc/SeRT7za9o3z5W55gPz/2xs4CzjXb9JzOAOESgdmKHCpxPSWwEd20Ifdgs4bF0QoPp3dV49p7PPER2SXGBhc8DBaV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvFp6zfj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvFp6zfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724339931; x=1755875931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YyfGO78CAwcZoLYK5WysriOso1HPKdlX6tstLpHk1hc=;
  b=GvFp6zfjBSz/6aT4NYuZQ0r71NY9NqRqQyquZOnRM88KDBojRXbtGHHR
   wZng86nCUp4bm/Li4fyks2WLP4Y7zoEQ8nGFwX3P42l1pYSj4m2CW95dU
   dXQP5jH7FqqcioMyIQSKhKvbF+2ty/unjLLcV/MNqtkSABuIsGfOVfZtl
   dY9cTtQsGVBJ/kSAu2CVkCQtiojXq/f8uMRxeFfc9/vjV6HcTtjLmNSXl
   uU741wyu46EHcnZ4sWaZ8y4AQLo6gYIP+JLpkAq/0G6Bpo60BrK82nKRD
   LaKwUb0z83fNxYBYWK8tTf81Sadnq/psdjrKsV24BJtnrvht6Z4WfFWRN
   w==;
X-CSE-ConnectionGUID: skbYCdYVQEOiAjuGzQAxMQ==
X-CSE-MsgGUID: FOHQBikbR0u5LnhbEORn7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22287380"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22287380"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:18:50 -0700
X-CSE-ConnectionGUID: gVcd2Tb+R6CFy5pi61C96g==
X-CSE-MsgGUID: R2BlqlgZTmeE77PC6vVQZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="92230600"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:18:50 -0700
Received: from [10.212.65.115] (kliang2-mobl1.ccr.corp.intel.com [10.212.65.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F396220CFED7;
	Thu, 22 Aug 2024 08:18:46 -0700 (PDT)
Message-ID: <961ff6d6-a9b3-4329-9a22-6934ca152318@linux.intel.com>
Date: Thu, 22 Aug 2024 11:18:45 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Event parsing fixes
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Yang Jihong <yangjihong@bytedance.com>,
 Colin Ian King <colin.i.king@gmail.com>, Andi Kleen <ak@linux.intel.com>,
 Ze Gao <zegao2021@gmail.com>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Yicong Yang
 <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240822132506.1468090-1-james.clark@linaro.org>
 <db095820-58a7-4b40-a12a-04b2f82cf903@linux.intel.com>
 <CAP-5=fX632gBrCG6Z+oQGkk=daFcrGM605t_2H1Jo20sVwvtqQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fX632gBrCG6Z+oQGkk=daFcrGM605t_2H1Jo20sVwvtqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-08-22 11:10 a.m., Ian Rogers wrote:
> On Thu, Aug 22, 2024 at 7:32 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-08-22 9:24 a.m., James Clark wrote:
>>> I rebased this one and made some other fixes so that I could test it,
>>> so I thought I'd repost it here in case it's helpful. I also added a
>>> new test.
>>>
>>> But for the testing it all looks ok.
>>>
>>> There is one small difference where it now shows "stalled-cycles-..."
>>> as <not supported> events, when before it just didn't show them at all when
>>> they weren't supported:
>>>
>>>   $ perf stat -- true
>>>
>>>   Performance counter stats for 'true':
>>>
>>>               0.66 msec task-clock                       #    0.384 CPUs utilized
>>>                  0      context-switches                 #    0.000 /sec
>>>                  0      cpu-migrations                   #    0.000 /sec
>>>                 52      page-faults                      #   78.999 K/sec
>>>      <not counted>      cpu_atom/instructions/                                                  (0.00%)
>>>            978,399      cpu_core/instructions/           #    1.02  insn per cycle
>>>      <not counted>      cpu_atom/cycles/                                                        (0.00%)
>>>            959,722      cpu_core/cycles/                 #    1.458 GHz
>>>    <not supported>      cpu_atom/stalled-cycles-frontend/
>>>    <not supported>      cpu_core/stalled-cycles-frontend/
>>>
>>
>> Intel didn't support the events for a very long time. It would impact
>> many existing generations and all future generations.
>> The current method is to hide the non-exist events. The TopdownL1 is an
>> example. If it doesn't exist in the json file, perf stat will not
>> display it.
>> I don't think it's a good idea to disclose non-exist events in the perf
>> stat default.
>>
>> The <not supported> doesn't help here, since there could be many reasons
>> that the perf tool fails to open a counter. It just provides a
>> misleading message for an event that never existed.
> 
> The list of "default" events, not metrics, similarly has "<not
> supported>" in many configurations with "-dd" or "-ddd" on AMD. I'm
> not sure the set of default events, at different detail levels, is
> necessarily the best. The default events can also be a source of
> multiplexing, for example, showing branch miss rate alongside topdown
> metrics. Anyway, for the "<not supported>" we should probably be able
> to tweak should_skip_zero_counter that is in stat-display.c and tag
> these default events as "skippable".

The "skippable" should be fine as long as it's completely hidden.

BTW: The stalled-cycles-backend should be similar to the
stalled-cycles-frontend, but it isn't shown in the example. Is the
stalled-cycles-backend event missed?

Thanks,
Kan
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>> I don't think that's a big deal though and could probably be fixed up
>>> later if we really want to.
>>>
>>> Tested on Raptor Lake, Juno, N1, Ampere (with the DSU cycles PMU) and
>>> I also faked an Apple M on Juno.
>>>
>>> Changes since v3:
>>>
>>>   * Rebase onto perf-tools-next 6236ebe07
>>>   * Fix Intel TPEBS counting mode test
>>>   * Fix arm-spe build
>>>   * Add support for DT devices in stat test
>>>   * Add a new test for hybrid perf stat default arguments
>>>
>>> Ian Rogers (5):
>>>   perf evsel: Add alternate_hw_config and use in evsel__match
>>>   perf stat: Uniquify event name improvements
>>>   perf stat: Remove evlist__add_default_attrs use strings
>>>   perf evsel x86: Make evsel__has_perf_metrics work for legacy events
>>>   perf evsel: Remove pmu_name
>>>
>>> James Clark (2):
>>>   perf test: Make stat test work on DT devices
>>>   perf test: Add a test for default perf stat command
>>>
>>>  tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
>>>  tools/perf/arch/x86/util/evlist.c             |  74 +----
>>>  tools/perf/arch/x86/util/evsel.c              |  35 ++-
>>>  tools/perf/builtin-diff.c                     |   6 +-
>>>  tools/perf/builtin-stat.c                     | 291 +++++++-----------
>>>  tools/perf/tests/parse-events.c               |   2 +-
>>>  tools/perf/tests/shell/stat.sh                |  33 +-
>>>  .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
>>>  tools/perf/util/evlist.c                      |  46 +--
>>>  tools/perf/util/evlist.h                      |  12 -
>>>  tools/perf/util/evsel.c                       |  28 +-
>>>  tools/perf/util/evsel.h                       |  22 +-
>>>  tools/perf/util/metricgroup.c                 |   4 +-
>>>  tools/perf/util/parse-events.c                |  58 ++--
>>>  tools/perf/util/parse-events.h                |   8 +-
>>>  tools/perf/util/parse-events.y                |   2 +-
>>>  tools/perf/util/pmu.c                         |   6 +-
>>>  tools/perf/util/pmu.h                         |   2 +-
>>>  tools/perf/util/stat-display.c                | 101 ++++--
>>>  tools/perf/util/stat-shadow.c                 |  14 +-
>>>  tools/perf/util/stat.c                        |   2 +-
>>>  21 files changed, 348 insertions(+), 413 deletions(-)
>>>
> 
