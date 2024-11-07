Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A81198840;
	Thu,  7 Nov 2024 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008189; cv=none; b=K6aYZH8EJ9JTbbmm3gSMW49BhoaFSVxqe8q/kLgca8j8PL3iPIIhkIbk4vbFdhif5PlayPFhnD+M3hFldNKaB8EwuUIlt4xGINGWgje8dHcvnu30B7dKnTs1uXUt10wjV7KpkOmSFg0B5RT0ys/OfOekY6vLHkDEfbu5Zz7lwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008189; c=relaxed/simple;
	bh=0T7rkLI6OF/PN51xXT2uRe/Q0OtMI8cftJyvhA7pE30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwrs0Cp1IPcUGWJ2kZ/dsxfTLewk7bUylYLG2SEB4P7istNlzimWTl7NL4DAiGb5o6qN236T4Qqkmd7Hu329G3KpuZFYCrl6RjGDnUspooFazi4be3fUBGcHQW0QSpvxgNIGAmFa5RV1MWh4snX7k4Y5sc0QRDsbFMy6q9jqthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpJ7CsQw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpJ7CsQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731008187; x=1762544187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0T7rkLI6OF/PN51xXT2uRe/Q0OtMI8cftJyvhA7pE30=;
  b=jpJ7CsQwpMkwy41p0YrS1PGPvJ8E+DaZs1EhCZnHsXb15ymW7hyZ5syD
   YtwHI1R1sxv7qCjB0vOPnimfzhdu8PhZqCY5PDGZu4RDuy9/ipE8hl1nt
   Zbwbanu4l+64jZQhFz6kuDAD9lwYQ7hGfCeTASVDwqAan268MZPHWNv05
   AuwRluNmYd/4unOLcdStOUO5EaROoCbahK5MhS5zjQC+YyGlU67qIm4Kp
   Oz8KstdVU4PMcTf3w+4Lma0T2dolbS2S0tgGOWzQe/M4S0cG1qpqr0+au
   V/IZ6X4RvvRptrC4lE2A95EOe4HsoQGtvrpavkmFOBdqD8vkYASyXK+Gp
   Q==;
X-CSE-ConnectionGUID: 9OEF/qHtQOiQXFZ9LJ4zPg==
X-CSE-MsgGUID: aDH8r5S5TyCn6Mw2ZOlRCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30646430"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30646430"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 11:36:27 -0800
X-CSE-ConnectionGUID: SsaOF1ofS0qZPGJ7Uq1qnw==
X-CSE-MsgGUID: YmU79oaeRa2kfzsrjSxQTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="85309515"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 11:36:26 -0800
Received: from [10.212.68.83] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id DBF9620B5703;
	Thu,  7 Nov 2024 11:36:24 -0800 (PST)
Message-ID: <c48a6f46-5991-40dc-abac-f66f2706c84e@linux.intel.com>
Date: Thu, 7 Nov 2024 14:36:23 -0500
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWGGQh_Kwr5mWPQv6RO=o8bk2mmShJ6MjR9i1v42e0Ziw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-11-07 12:12 p.m., Ian Rogers wrote:
> On Thu, Nov 7, 2024 at 7:00 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
>>> The ports metric group contains a metric for each port giving its
>>> utilization as a ratio of cycles. The metrics are created by looking
>>> for UOPS_DISPATCHED.PORT events.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
>>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
>>> index f4707e964f75..3ef4eb868580 100755
>>> --- a/tools/perf/pmu-events/intel_metrics.py
>>> +++ b/tools/perf/pmu-events/intel_metrics.py
>>> @@ -1,12 +1,13 @@
>>>  #!/usr/bin/env python3
>>>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>>  from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
>>> -                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
>>> -                    MetricGroup, MetricRef, Select)
>>> +                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
>>> +                    Metric, MetricGroup, MetricRef, Select)
>>>  import argparse
>>>  import json
>>>  import math
>>>  import os
>>> +import re
>>>  from typing import Optional
>>>
>>>  # Global command line arguments.
>>> @@ -260,6 +261,33 @@ def IntelBr():
>>>                       description="breakdown of retired branch instructions")
>>>
>>>
>>> +def IntelPorts() -> Optional[MetricGroup]:
>>> +  pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
>>> +
>>> +  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
>>> +                      "CPU_CLK_UNHALTED.DISTRIBUTED",
>>> +                      "cycles")
>>> +  # Number of CPU cycles scaled for SMT.
>>> +  smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
>>> +
>>> +  metrics = []
>>> +  for x in pipeline_events:
>>> +    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
>>> +      name = x["EventName"]
>>> +      port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
>>> +      if name.endswith("_CORE"):
>>> +        cyc = core_cycles
>>> +      else:
>>> +        cyc = smt_cycles
>>> +      metrics.append(Metric(port, f"{port} utilization (higher is better)",
>>> +                            d_ratio(Event(name), cyc), "100%"))
>>
>> The generated metric highly depends on the event name, which is very
>> fragile. We will probably have the same event in a new generation, but
>> with a different name. Long-term maintenance could be a problem.
>> Is there an idea regarding how to sync the event names for new generations?
> I agree with the idea that it is fragile, it is also strangely robust
> as you say, new generations will gain support if they follow the same
> naming convention. We have tests that load bearing metrics exists on
> our platforms so maybe the appropriate place to test for existence is
> in Weilin's metrics test.
> 
> 
>> Maybe we should improve the event generation script and do an automatic
>> check to tell which metrics are missed. Then we may decide if updating
>> the new event name, dropping the metric or adding a different metric.
> So I'm not sure it is a bug to not have the metric, if it were we
> could just throw rather than return None. We're going to run the
> script for every model including old models like nehalem, so I've
> generally kept it as None. I think doing future work on testing is
> probably best. It would also indicate use of the metric if people
> notice it missing (not that the script aims for that 🙂 ).

The maintenance is still a concern, even if we have a way to test it
out. There is already an "official" metric published in GitHub, which is
maintained by Intel. To be honest, I don't think there is more energy to
maintain these "non-official" metrics.

I don't think it should be a bug without these metrics. So it's very
likely that the issue will not be addressed right away. If we cannot
keep these metrics updated for the future platforms, I couldn't find a
reason to have them.

Thanks,
Kan
