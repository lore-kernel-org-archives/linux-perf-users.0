Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF5392825;
	Fri, 18 Sep 2026 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789773122; cv=none; b=nu0jxcDTHYiTy+onkZlVOmOWA+nRtH/oXQvqHzKM5AbGyat3yQCHGqN/AqSLOJUesTNtgEgNYUSUji5NImiNNqq1fIt3L8N1jpK5pUgHZiUgckqwA4f/DgZwPuXMzISMLY0yA+bNt0KPpfOXY+KSlPsinsTXdui9SvyLxjb7TxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789773122; c=relaxed/simple;
	bh=jNpv0Dc6jq+CH9Xd87NYoawvyDvLw/ftLVTNgnXN9os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2GzL/vO5BpulK6Jjuq5xP2m3jHXhSW8b1XZ0im155fGwtgeZm/1FjeGezEaSUXV264vSwi9OIvHG04pSDWanUNJCXuaDtPA0rRxVxOXH4TKP2d2x5gTBcVBREaReuH5DOejSCK6CCKUsXqeV90R+vHbWZNvbG+E7fBDXaK+fV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPfWINkr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPfWINkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789773120; x=1821309120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jNpv0Dc6jq+CH9Xd87NYoawvyDvLw/ftLVTNgnXN9os=;
  b=gPfWINkrAtjba9ls9tz26OgrrvwcxV3GTkyg3R5+UAQbH4KRRuOwg77z
   L3BbkTJgASuTG/wHqFAiCIrGFPZzgY2c14KBJtywSpprixrBWGJDHoiPr
   AWyB8nIHmARiaDwECsHTOA89XPXvSde4k5IJhTeKZNwCBPHTMRRGj617f
   hIXNktEwSDbWiJ/oWi+kUL6b8FQJynAdEMwR7/x8ifWLoas+P2Z+w/rRM
   HkEZuNpsFYFiN1ueU2J1ZugLHTLKJ1vO5yf6na96jPdXqJAheU2PejDSf
   k0pLBLQEa+UxfVBFRlRGBp8gytCFpCH1W/8a4RbaegNIK14A7YUROmMJt
   Q==;
X-CSE-ConnectionGUID: V0wIm5FaQNuy/H2CjPv+Eg==
X-CSE-MsgGUID: B4JutdvHTziyuSpMaZTJyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="92815199"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="92815199"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 16:11:59 -0700
X-CSE-ConnectionGUID: 3Y7id3g6QGS/SuQ8snpaWw==
X-CSE-MsgGUID: D+AYuOoRQJOp21duuj54XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="279831421"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 16:11:56 -0700
Message-ID: <03e0a2e6-b033-40c1-affc-baa4fe79febe@linux.intel.com>
Date: Sat, 19 Sep 2026 07:11:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf topdown: Don't require config1==0 for a slots event
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Zide Chen <zide.chen@intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 thomas.falcon@intel.com, xudong.hao@intel.com
References: <20260916202740.257376-1-zide.chen@intel.com>
 <CAP-5=fV7mJEx27OQra2yaTegwRdzFUYohivFHFBvwD0cdb3=SQ@mail.gmail.com>
 <aq2bV6oH8OT5tk4d@x2>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aq2bV6oH8OT5tk4d@x2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/19/2026 4:13 AM, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 16, 2026 at 02:22:45PM -0700, Ian Rogers wrote:
>> On Wed, Sep 16, 2026 at 1:37 PM Zide Chen <zide.chen@intel.com> wrote:
>>> arch_is_topdown_slots() requires config1 == 0, so it misidentified
>>> "cpu/slots,metrics_clear=1/" as not being the slots event, and an
>>> additional slots event gets inserted, which fails event scheduling
>>> since the group now needs two fixed counter 3.
>>>
>>>   $ perf stat -e "{cpu/slots,metrics_clear=1/,cpu/topdown-retiring/}" -- sleep 1
>>>   WARNING: events were regrouped to match PMUs
>>>        <not counted>      slots
>>>      <not supported>      cpu/slots,metrics_clear=1/
>>>        <not counted>      cpu/topdown-retiring/
>>>
>>> Drop the config1 == 0 check from arch_is_topdown_slots(). This is
>>> safe: config1 has no bearing on the event's identifying config value
>>> (TOPDOWN_SLOTS, 0x0400).
>>>
>>> The attr.type == PERF_TYPE_RAW check is what actually matters: only the
>>> core PMU is registered with PERF_TYPE_RAW, and on x86, 0x400 is
>>> guaranteed to be slots event on core CPU.
>>>
>>> arch_is_topdown_metrics() keeps its own config1 == 0 check, since
>>> genuine metrics events have no "metrics_clear" and config1 remains 0.
>>>
>>> Add a test verifying that an explicit "slots,metrics_clear=1" event in
>>> a group does not trigger an extra slots event injection.
>>>
>>> Fixes: 5b546de9cc17 ("perf topdown: Use attribute to see an event is a topdown metic or slots")
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> Reviewed-by: Ian Rogers <irogers@google.com>
>>
>> Note, there's a Sashiko warning about a potentially missing #include
>> for musl compatibility that maybe you or Arnaldo could address.
> Merging, will look add address that comment,

@Arnaldo, Zide posted the v2 patch to address the Sashiko comments.
https://lore.kernel.org/all/20260917181016.381994-1-zide.chen@intel.com/

You may directly merge that patch. :) 

Thanks.


>
> Thanks,
>
> - Arnaldo
>  
>> Thanks,
>> Ian
>>
>>> ---
>>>  tools/perf/arch/x86/tests/topdown.c | 28 ++++++++++++++++++++++++++++
>>>  tools/perf/arch/x86/util/topdown.c  |  3 +--
>>>  2 files changed, 29 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
>>> index 2b6f47ce4932..b1ce9f83db00 100644
>>> --- a/tools/perf/arch/x86/tests/topdown.c
>>> +++ b/tools/perf/arch/x86/tests/topdown.c
>>> @@ -229,10 +229,38 @@ static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unu
>>>         return TEST_OK;
>>>  }
>>>
>>> +/*
>>> + * An explicit "slots,metrics_clear=1" event is still the slots event and
>>> + * must not cause an extra slots event to be injected into the group.
>>> + */
>>> +static int test__x86_topdown_metrics_clear(struct test_suite *test __maybe_unused,
>>> +                                          int subtest __maybe_unused)
>>> +{
>>> +       struct perf_pmu *pmu;
>>> +       char event_str[128];
>>> +       int ret;
>>> +
>>> +       if (!topdown_sys_has_perf_metrics())
>>> +               return TEST_OK;
>>> +
>>> +       pmu = perf_pmus__find_by_type(PERF_TYPE_RAW);
>>> +       if (!pmu || !perf_pmu__has_format(pmu, "metrics_clear"))
>>> +               return TEST_OK;
>>> +
>>> +       snprintf(event_str, sizeof(event_str),
>>> +                "{%s/slots,metrics_clear=1/,%s/topdown-retiring/}",
>>> +                pmu->name, pmu->name);
>>> +       ret = test_sort(event_str, 2, 1);
>>> +       TEST_ASSERT_EQUAL("explicit metrics_clear slots event isn't duplicated", ret, TEST_OK);
>>> +
>>> +       return TEST_OK;
>>> +}
>>> +
>>>  static struct test_case x86_topdown_tests[] = {
>>>         TEST_CASE("topdown events", x86_topdown),
>>>         TEST_CASE("topdown sorting", x86_topdown_sorting),
>>>         TEST_CASE("topdown slots injection", x86_topdown_slots_injection),
>>> +       TEST_CASE("topdown metrics_clear no extra slots", x86_topdown_metrics_clear),
>>>         { .name = NULL, }
>>>  };
>>>
>>> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
>>> index bafd285119d7..64bc64e335a2 100644
>>> --- a/tools/perf/arch/x86/util/topdown.c
>>> +++ b/tools/perf/arch/x86/util/topdown.c
>>> @@ -37,8 +37,7 @@ bool topdown_sys_has_perf_metrics(void)
>>>  bool arch_is_topdown_slots(const struct evsel *evsel)
>>>  {
>>>         return evsel->core.attr.type == PERF_TYPE_RAW &&
>>> -              evsel->core.attr.config == TOPDOWN_SLOTS &&
>>> -              evsel->core.attr.config1 == 0;
>>> +              evsel->core.attr.config == TOPDOWN_SLOTS;
>>>  }
>>>
>>>  bool arch_is_topdown_metrics(const struct evsel *evsel)
>>> --
>>> 2.55.0
>>>
