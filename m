Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8B13B29F;
	Fri,  8 Nov 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084352; cv=none; b=GyTGYA7fxUuENmRvFaKqiP+ZaDbqHInvcY92MtqO/sxbgwdVYeMr1Huo/g11bYaGebqR1zP4Q1J6EogMJdJ9GPISTJQy1K/OI6FMkr57b2pYkE+wV9Xr4luyD2YscNaUO26lBCD/XWiejf5TGstbix90zp+XBth7B+xLviSzhuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084352; c=relaxed/simple;
	bh=xV0OvSUGkDACQ8QqM+fAvuq/njXWamSH+xeskzaIRI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKnRC6Qri/p/VZ/D0sD8A7orU6jLWAUYfWVLQxkY2Suea0DUuNK3V99xqEl7nn1j7jiDpFruU6A7cgoArZjYII1XA5qc2qJVU/oVcZLHkQjGTO2mM0mSswaL3WHHkI2EzfzPqqbKqUj85VRovAmKTDnoMPvMcmSav3kO+kz5P4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3eZivvi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3eZivvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731084350; x=1762620350;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xV0OvSUGkDACQ8QqM+fAvuq/njXWamSH+xeskzaIRI4=;
  b=Z3eZivvin8Z8jM5ZbE0KGSltSrwjXEoJubLCxUbRU+wxvZKh/bt7nS57
   Bk9L+tPSB+sItiW1pHIP7w1DQjDTAOF9Fxy9AMy51QpswY9n6W3t49VK4
   YMdPxrM7JeVzUQdY7hm7sA8Cy/o+sWFuwBAOLHshkejF1KjBPKAHmMK/T
   N+duG6IpGim7lTTDbaRy3622lhbYXg7lNBmFY4vZeXJuh/aHMQKiPcrFm
   B+8IbLCeWH/4ldLZR+4L7nQDOznxwyibll3RLVqqlLlzhfML3oZ9Guy9j
   2A3u6cFm51qLrTZIEnu/NzKwJFJvy4VuquJtei5uedLN1B6o1WTE7qa4E
   g==;
X-CSE-ConnectionGUID: FEmRhDIqQD6ftq8gL+bk2A==
X-CSE-MsgGUID: uZUc4K41RwmOOMJCE5b34Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="41592866"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="41592866"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 08:45:49 -0800
X-CSE-ConnectionGUID: LkIWXI0ERcG0hFcJBSINmA==
X-CSE-MsgGUID: hKfx5hMPRf2bVOffPwBT2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="90748742"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 08:45:49 -0800
Received: from [10.212.83.219] (kliang2-mobl1.ccr.corp.intel.com [10.212.83.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0373320B5703;
	Fri,  8 Nov 2024 08:45:46 -0800 (PST)
Message-ID: <43548903-b7c8-47c4-b1da-0258293ecbd4@linux.intel.com>
Date: Fri, 8 Nov 2024 11:45:45 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/22] perf jevents: Add ports metric group giving
 utilization on Intel
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Perry Taylor <perry.taylor@intel.com>, Samantha Alt
 <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
References: <20240926175035.408668-1-irogers@google.com>
 <20240926175035.408668-10-irogers@google.com>
 <0d48bf82-5de2-4928-bd15-1c5abfd4f087@linux.intel.com>
 <CAP-5=fWGGQh_Kwr5mWPQv6RO=o8bk2mmShJ6MjR9i1v42e0Ziw@mail.gmail.com>
 <c48a6f46-5991-40dc-abac-f66f2706c84e@linux.intel.com>
 <CAP-5=fWwts12ucSAXBHW7-Q+Asm1GUnT7tTPZ3_D5xhHMZ-8ig@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWwts12ucSAXBHW7-Q+Asm1GUnT7tTPZ3_D5xhHMZ-8ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-11-07 4:00 p.m., Ian Rogers wrote:
> On Thu, Nov 7, 2024 at 11:36 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2024-11-07 12:12 p.m., Ian Rogers wrote:
>>> On Thu, Nov 7, 2024 at 7:00 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
>>>>> The ports metric group contains a metric for each port giving its
>>>>> utilization as a ratio of cycles. The metrics are created by looking
>>>>> for UOPS_DISPATCHED.PORT events.
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>> ---
>>>>>  tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
>>>>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
>>>>> index f4707e964f75..3ef4eb868580 100755
>>>>> --- a/tools/perf/pmu-events/intel_metrics.py
>>>>> +++ b/tools/perf/pmu-events/intel_metrics.py
>>>>> @@ -1,12 +1,13 @@
>>>>>  #!/usr/bin/env python3
>>>>>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>>>>  from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
>>>>> -                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
>>>>> -                    MetricGroup, MetricRef, Select)
>>>>> +                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
>>>>> +                    Metric, MetricGroup, MetricRef, Select)
>>>>>  import argparse
>>>>>  import json
>>>>>  import math
>>>>>  import os
>>>>> +import re
>>>>>  from typing import Optional
>>>>>
>>>>>  # Global command line arguments.
>>>>> @@ -260,6 +261,33 @@ def IntelBr():
>>>>>                       description="breakdown of retired branch instructions")
>>>>>
>>>>>
>>>>> +def IntelPorts() -> Optional[MetricGroup]:
>>>>> +  pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
>>>>> +
>>>>> +  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
>>>>> +                      "CPU_CLK_UNHALTED.DISTRIBUTED",
>>>>> +                      "cycles")
>>>>> +  # Number of CPU cycles scaled for SMT.
>>>>> +  smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
>>>>> +
>>>>> +  metrics = []
>>>>> +  for x in pipeline_events:
>>>>> +    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
>>>>> +      name = x["EventName"]
>>>>> +      port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
>>>>> +      if name.endswith("_CORE"):
>>>>> +        cyc = core_cycles
>>>>> +      else:
>>>>> +        cyc = smt_cycles
>>>>> +      metrics.append(Metric(port, f"{port} utilization (higher is better)",
>>>>> +                            d_ratio(Event(name), cyc), "100%"))
>>>> The generated metric highly depends on the event name, which is very
>>>> fragile. We will probably have the same event in a new generation, but
>>>> with a different name. Long-term maintenance could be a problem.
>>>> Is there an idea regarding how to sync the event names for new generations?
>>> I agree with the idea that it is fragile, it is also strangely robust
>>> as you say, new generations will gain support if they follow the same
>>> naming convention. We have tests that load bearing metrics exists on
>>> our platforms so maybe the appropriate place to test for existence is
>>> in Weilin's metrics test.
>>>
>>>
>>>> Maybe we should improve the event generation script and do an automatic
>>>> check to tell which metrics are missed. Then we may decide if updating
>>>> the new event name, dropping the metric or adding a different metric.
>>> So I'm not sure it is a bug to not have the metric, if it were we
>>> could just throw rather than return None. We're going to run the
>>> script for every model including old models like nehalem, so I've
>>> generally kept it as None. I think doing future work on testing is
>>> probably best. It would also indicate use of the metric if people
>>> notice it missing (not that the script aims for that 🙂 ).
>> The maintenance is still a concern, even if we have a way to test it
>> out. There is already an "official" metric published in GitHub, which is
>> maintained by Intel. To be honest, I don't think there is more energy to
>> maintain these "non-official" metrics.
>>
>> I don't think it should be a bug without these metrics. So it's very
>> likely that the issue will not be addressed right away. If we cannot
>> keep these metrics updated for the future platforms, I couldn't find a
>> reason to have them.
> So I think there are a few things:
> 1) I'd like there to be a non-json infrastructure for events that can
> handle multiple models. Some failings of json are its inability to
> validate events, long lines, lack of comments, metric expression
> strings that aren't inherently sound, etc.  I'd like to make it so we
> can have json metrics for everything, ie remove the hardcoded metrics
> that play badly with event sharing, etc. Doing this by updating every
> json would be tedious and excessively noisy.
> 2) There are "official" metrics from Intel and I've worked for the
> establishment of that. That doesn't mean every Intel metric is in the
> official metrics. Servers are better served than client machines. Core
> TMA metrics are well served but uncore less so.
> 3) Are perf metrics perfect with some kind of warranty? Well no, as
> your reviews in this thread have shown SMI cost on hybrid is likely
> broken. We don't intentionally try to have broken metrics and fix them
> asap when they come up. GPLv2 has an explicit "no warranty" section.
> Now Intel have experimental and non-experimental events, we update the
> comments of metrics using those to highlight that the underlying
> events are experimental:
> https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/
> tools/perf/pmu-events/metric.py#L598
> If there are bugs in the metrics then open source, sharing and fixing
> benefits everyone.
> 4) Am I looking for energy from Intel to maintain these metrics? No.
> I'm trying to stop carrying the patches just inside of Google's tree.

Got it. Thanks for the clarification.

IIUC, the generated metrics are based on the best knowledge of
contributors. The initial source is from Google's tree. It should be the
contributor's responsibility to maintain or update the metrics.
If so, I agree that it should be a good supplement.

I would have some comments in general.
- I think we need a way to distinguish these metrics, e.g., add a
dedicated prefix. I will not be surprised if some customers bring the
metrics to Intel or other vendor's customer service, and ask why it
doesn't work on some platforms. I don't think they will get any useful
information there. The best way is to report any issues here. So we can
fix and update the metric.
- All events, no matter whether they are from the JSON file or exposed
by the kernel, have to be checked before showing the metrics. Because we
cannot guarantee the availability of an event, even for the
architectural events. We may introduce a wrapper for the Metric() to
check all the involved events. So we don't need to add the try: except
thing in each patch?
- In the perf test, it's better to ignore the errors from these metrics.
So it doesn't block things. But we can show a warning from them with
-vvv. The issue can still be found and fixed.

Thanks,
Kan
