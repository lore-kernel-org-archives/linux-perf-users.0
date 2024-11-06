Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D8201104;
	Wed,  6 Nov 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917774; cv=none; b=Kl8uSrmjpKfJm8Aa40hBBmgCp21Qexgtb5tjbFUId8EGwt3m6HDqxX4WhmrOXdjWe+nBIEcOfgf2B+JWGrfW6vljBxNwv20qM+9rCzrFpfFSaHqrbQgjhvLDCIVyH+ibo/Ap0JqjAa3hz+HWfnXKzdVRWIruD8liqCSIdN4y5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917774; c=relaxed/simple;
	bh=cbggUsgL0g7d6eIqEMVmH2E0zyO+bSJSf8lQWOyPocs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2idaCk1HHHfyHwga5IAZDGUqtT5Qx2CsCms9zisvgS3BwW2dAvVxpRAuXiyqQfURiqtkcC3WqiJ8TNOAhlMZjCRXSD6nGkt7bSXIz2FSisT9T7P1neYuSEIAz1pFDuYtgzMSc5/2phghp6pwcIhD5Mh5QeCLmu+fkuLAKBukDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apLqEX4L; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apLqEX4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730917773; x=1762453773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cbggUsgL0g7d6eIqEMVmH2E0zyO+bSJSf8lQWOyPocs=;
  b=apLqEX4LXMHvuBU5x/0gL/GxnHeTU2y5Y3LPul8ossrY1/eiCkCp8coI
   dzdPHNlQp7XYok33TFfF0Mhj/vG0ffRDBfia8exd8GU6TjKJgFCEEACOH
   Rz+ag1Iw9kkTUQr3AcFKnvdAjYfOBJawsp8y1y6cuABbl/iRa4j4YCMue
   vSMkSY5lTExEn5FFqTBf+roguObuHqpEvtFCjuquoNwGj7BMVNTgbYUft
   BSxtEj+XQtGZkUTn34k8fGt3V5f6mp92EvHdKp/tSQnpD/M0Gth7B2aVu
   28Kv9RjUhjDLZheKRRldvPXTrRmmbGlJU63bby4aJscUK8KWceyF4NGNR
   w==;
X-CSE-ConnectionGUID: cDGLapEfQNyh1MHp5h2vXA==
X-CSE-MsgGUID: CchdCiU/TYK43F8uGGs6tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="41328291"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="41328291"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:29:32 -0800
X-CSE-ConnectionGUID: u+20Jmt9SpGk1RBVEV90ZA==
X-CSE-MsgGUID: WW5hV9DoTWO/VU/MW3aWQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89277412"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:29:31 -0800
Received: from [10.212.82.230] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8CCEC20B5703;
	Wed,  6 Nov 2024 10:29:29 -0800 (PST)
Message-ID: <5d13b06f-408a-4a12-825a-67ee87b5decd@linux.intel.com>
Date: Wed, 6 Nov 2024 13:29:28 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/22] perf jevents: Add smi metric group for Intel
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
 <20240926175035.408668-4-irogers@google.com>
 <30c22df5-9815-4a73-9a12-165d9045a667@linux.intel.com>
 <CAP-5=fXvH+=OQJM9uK9eOFrFfvy3tMVE00uejWxHeCuur4ZuUg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXvH+=OQJM9uK9eOFrFfvy3tMVE00uejWxHeCuur4ZuUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-11-06 12:42 p.m., Ian Rogers wrote:
> On Wed, Nov 6, 2024 at 9:32 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
>>> Allow duplicated metric to be dropped from json files.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/pmu-events/intel_metrics.py | 21 ++++++++++++++++++++-
>>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
>>> index f875eb844c78..f34b4230a4ee 100755
>>> --- a/tools/perf/pmu-events/intel_metrics.py
>>> +++ b/tools/perf/pmu-events/intel_metrics.py
>>> @@ -2,7 +2,7 @@
>>>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>>  from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
>>>                      JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
>>> -                    MetricGroup, Select)
>>> +                    MetricGroup, MetricRef, Select)
>>>  import argparse
>>>  import json
>>>  import math
>>> @@ -56,6 +56,24 @@ def Rapl() -> MetricGroup:
>>>                       description="Running Average Power Limit (RAPL) power consumption estimates")
>>>
>>>
>>> +def Smi() -> MetricGroup:
>>> +    aperf = Event('msr/aperf/')
>>> +    cycles = Event('cycles')
>>> +    smi_num = Event('msr/smi/')
>>> +    smi_cycles = Select(Select((aperf - cycles) / aperf, smi_num > 0, 0),
>>> +                        has_event(aperf),
>>> +                        0)
>>> +    return MetricGroup('smi', [
>>> +        Metric('smi_num', 'Number of SMI interrupts.',
>>> +               Select(smi_num, has_event(smi_num), 0), 'SMI#'),
>>> +        # Note, the smi_cycles "Event" is really a reference to the metric.
>>> +        Metric('smi_cycles',
>>> +               'Percentage of cycles spent in System Management Interrupts. '
>>> +               'Requires /sys/devices/cpu/freeze_on_smi to be 1.',
>>
>> It seems not work for hybrid?
> 
> Thanks. The code is a migration of existing metrics that exist for hybrid:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=perf-tools-next#n74
> I still lack an easy way to test on hybrid, but I think fixing that
> case can be follow on work.

The metrics itself works on hybrid. But the description doesn't.
For hybrid, the location of the knob should be
/sys/devices/cpu_atom/freeze_on_smi
and
/sys/devices/cpu_core/freeze_on_smi

Maybe changes it as below?
'Requires /sys/devices/cpu*/freeze_on_smi to be 1.'

Thanks,
Kan
