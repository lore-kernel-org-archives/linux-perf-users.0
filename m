Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1B176AC8;
	Wed,  6 Nov 2024 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918942; cv=none; b=TUJyKtXwsteXoOsvlZnbRld2lq3hUIexae326H8WKKUKMUg7K+zdz0+kfx0LNTOVLQt58cWvNOITWTo7WMvaV/uKJcZHwf07DfhEqq6Hi+Z53ei9nPK3rRFW2lQ2pFwGtSI3ZSBXS37oSr9pPsmorQbqMItQjFnh0wpMLOf0YCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918942; c=relaxed/simple;
	bh=QrOkXuwagN049vRZ1X7BLTEuxg9ybLumQ4TS1F1Czew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDEASM8R709OPmeYYENO6kdY9WkW87aFcJlQFjxELZlxjq871WPm9wuKP2uhzQSd9Q9FmbwJXYbHFFVlVm1TbTUh8xHtPsl09FmWp5Hif2W8wL2zSCftBOD6KpbtOiY5KhMGo5O/BKgH/9H1BYQyiYjSCwceytDuYWpRbNyI2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ud/uIYQp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ud/uIYQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730918941; x=1762454941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QrOkXuwagN049vRZ1X7BLTEuxg9ybLumQ4TS1F1Czew=;
  b=Ud/uIYQpmJNdlsKbmTYGq+OtfUnf0xOWcp7Ar+qARmvuIsXfzZnvvPen
   KO/slgKitFjTHmBhU+GpepBNj6HeljvOjcQ/ifiuRe6bZwn8U9HKBgFUy
   RDBn7YCjBq+zzCEuu7MN3krJ/MXw5yonrDMhwbe+H7HrdV/qE399MQxC8
   5zUeacBlwfpefQRWuWlMzn6TbCwi7MlYgCf857pcILZbhttAEysH7v+BN
   dKi4ByFl3GAoWG9grc/zWOPk0fv8GB/Z8hH+ZrYw3ui2YLu0r2ml4kHd/
   dzBn+oIox+iAAxHWocYka4pKJHWyBDVGY+tXh7aTqeyj+y55MJVY+bTkG
   Q==;
X-CSE-ConnectionGUID: ZoJ1jvM1RKinM6wP8xFeyw==
X-CSE-MsgGUID: 29lRLtqzS4WUGuCWJCGIlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="41330843"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="41330843"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:49:00 -0800
X-CSE-ConnectionGUID: Xm3D9zLYQQGfUZbGaP4xyQ==
X-CSE-MsgGUID: iDnGPBd6RV+SNWf1xL1EzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89285647"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:49:00 -0800
Received: from [10.212.82.230] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C4F3120B5703;
	Wed,  6 Nov 2024 10:48:57 -0800 (PST)
Message-ID: <10b48a82-fd30-4dd9-a19a-976e76dd0c8d@linux.intel.com>
Date: Wed, 6 Nov 2024 13:48:56 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/22] perf jevents: Add tsx metric group for Intel
 models
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
 <20240926175035.408668-7-irogers@google.com>
 <244b4c80-2ab2-4248-b930-22fea9ed6429@linux.intel.com>
 <CAP-5=fW1dACyxesnjpMQLAgomnRH+nA1sVphbpLyCFN3A79xSQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fW1dACyxesnjpMQLAgomnRH+nA1sVphbpLyCFN3A79xSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-11-06 1:15 p.m., Ian Rogers wrote:
> On Wed, Nov 6, 2024 at 9:53 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
>>> Allow duplicated metric to be dropped from json files. Detect when TSX
>>> is supported by a model by using the json events, use sysfs events at
>>> runtime as hypervisors, etc. may disable TSX.
>>>
>>> Add CheckPmu to metric to determine if which PMUs have been associated
>>> with the loaded events.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/pmu-events/intel_metrics.py | 52 +++++++++++++++++++++++++-
>>>  1 file changed, 51 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
>>> index f34b4230a4ee..58e243695f0a 100755
>>> --- a/tools/perf/pmu-events/intel_metrics.py
>>> +++ b/tools/perf/pmu-events/intel_metrics.py
>>> @@ -1,12 +1,13 @@
>>>  #!/usr/bin/env python3
>>>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>> -from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
>>> +from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
>>>                      JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
>>>                      MetricGroup, MetricRef, Select)
>>>  import argparse
>>>  import json
>>>  import math
>>>  import os
>>> +from typing import Optional
>>>
>>>  # Global command line arguments.
>>>  _args = None
>>> @@ -74,6 +75,54 @@ def Smi() -> MetricGroup:
>>>      ], description = 'System Management Interrupt metrics')
>>>
>>>
>>> +def Tsx() -> Optional[MetricGroup]:
>>> +  pmu = "cpu_core" if CheckPmu("cpu_core") else "cpu"
>>> +  cycles = Event('cycles')
>>
>> Isn't the pmu prefix required for cycles as well?
> 
> Makes sense.
> 
>>> +  cycles_in_tx = Event(f'{pmu}/cycles\-t/')
>>> +  cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
>>> +  try:
>>> +    # Test if the tsx event is present in the json, prefer the
>>> +    # sysfs version so that we can detect its presence at runtime.
>>> +    transaction_start = Event("RTM_RETIRED.START")
>>> +    transaction_start = Event(f'{pmu}/tx\-start/')
>>
>> What's the difference between this check and the later has_event() check?
>>
>> All the tsx related events are model-specific events. We should check
>> them all before using it.
> 
> So if there is PMU in the Event name then the Event logic assumes you
> are using sysfs and doesn't check the event exists in json. As you
> say, I needed a way to detect does this model support TSX? I wanted to
> avoid a model lookup table, so I used the existence of
> RTM_RETIRED.START for a model as the way to determine if the model
> supports TSX. Once we know we have a model supporting TSX then we use
> the sysfs event name and has_event check, so that if the TSX and the
> event have been disabled the metric doesn't fail parsing.
> 
> So, the first check is a compile time check of, "does this model have
> TSX?". The "has_event" check is a runtime thing where we want to see
> if the event exists in sysfs in case the TSX was disabled say in the
> BIOS.
> 

Yes, that's sufficient.
But the "has_event" check seems very random.

For example,
>>>> +      Metric('tsx_cycles_per_transaction',
>>>> +             'Number of cycles within a transaction divided by the number of transactions.',
>>>> +             Select(cycles_in_tx / transaction_start,
>>>> +                    has_event(cycles_in_tx),
>>>> +                    0),
>>>> +             "cycles / transaction"),

I think both cycles_in_tx and transaction_start should be checked.

>>>> +      Metric('tsx_cycles_per_elision',
>>>> +             'Number of cycles within a transaction divided by the number of elisions.',
>>>> +             Select(cycles_in_tx / elision_start,
>>>> +                    has_event(elision_start),
>>>> +                    0),

This one only checks the elision_start event.

Thanks,
Kan
> Thanks,
> Ian
> 
>>
>> Thanks,
>> Kan
>>> +  except:> +    return None
>>> +
>>> +  elision_start = None
>>> +  try:
>>> +    # Elision start isn't supported by all models, but we'll not
>>> +    # generate the tsx_cycles_per_elision metric in that
>>> +    # case. Again, prefer the sysfs encoding of the event.
>>> +    elision_start = Event("HLE_RETIRED.START")
>>> +    elision_start = Event(f'{pmu}/el\-start/')
>>> +  except:
>>> +    pass
>>> +
>>> +  return MetricGroup('transaction', [
>>> +      Metric('tsx_transactional_cycles',
>>> +             'Percentage of cycles within a transaction region.',
>>> +             Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
>>> +             '100%'),
>>> +      Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
>>> +             Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
>>> +                    has_event(cycles_in_tx),
>>> +                    0),
>>> +             '100%'),
>>> +      Metric('tsx_cycles_per_transaction',
>>> +             'Number of cycles within a transaction divided by the number of transactions.',
>>> +             Select(cycles_in_tx / transaction_start,
>>> +                    has_event(cycles_in_tx),
>>> +                    0),
>>> +             "cycles / transaction"),
>>> +      Metric('tsx_cycles_per_elision',
>>> +             'Number of cycles within a transaction divided by the number of elisions.',
>>> +             Select(cycles_in_tx / elision_start,
>>> +                    has_event(elision_start),
>>> +                    0),
>>> +             "cycles / elision") if elision_start else None,
>>> +  ], description="Breakdown of transactional memory statistics")
>>> +
>>> +
>>>  def main() -> None:
>>>    global _args
>>>
>>> @@ -100,6 +149,7 @@ def main() -> None:
>>>        Idle(),
>>>        Rapl(),
>>>        Smi(),
>>> +      Tsx(),
>>>    ])
>>>
>>>
>>
> 

