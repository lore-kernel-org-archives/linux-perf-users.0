Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA6205E11;
	Wed,  6 Nov 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915583; cv=none; b=oN2Lm7aBL9gSsu81qO5AGaBW4sv0CefULHBGANNvGOEnzOkMSsUNzRKOJRYNL0Ih/31DiLOAJFEF8Ck+5xHkWZPDgVr3/dYoNvbijilosivLQcFCBVorujbsNgoRPKCJStXo0vf2Pduc5qRL0fy2kLGDzVxrb1AYnolOfjxBYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915583; c=relaxed/simple;
	bh=hI5g072hwyeIma5XJ1a6SD58g7lhAxNM4XIWHVAuGN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yii7b7aAeiwjj0zh6R5t5+9+08mytTdhGNctzK26/5py20U7Irx+jJ08OR5pmmdbL1swNxL0KnpN+1Ix7AIue1cayfmI7NT7R/TJIUT5B8EAWBpP0Kbvh8mVKM0uQHBiFTefhtojRweyPUefCZXvIISL0r2PRM+dCWfvvsycfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DF+meZZN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DF+meZZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730915582; x=1762451582;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=hI5g072hwyeIma5XJ1a6SD58g7lhAxNM4XIWHVAuGN4=;
  b=DF+meZZN9kTt10F08fFjNk+gY2yTtNcBFlCQAIUTmnXLuLo2dW32j8Dl
   ParJM2xRTppQrhvVNMuP6ZApU4zV7qpC/i6dYX8+4FMBBgL4cPkc/3C2c
   KaJnoCkGQd7pX/ngzEin8mRlRmmjpVI4+trXfQZzj9fdWox1eIxiL9hgD
   EFWuyv5y7BPxyM+F4NMd8DsI4iSRzVnlQQRgHLZV3inNyFHn+TVfZ33sN
   oREdTNcM8oizAH+7fDV1PK+tsPUb/ig9i7jj8kIyi5DD2f9J7wHDbykFL
   JHeptxZoiToU9/nNWTRnA4klAU6t1dcUb7/QwBbKf93cSgMsBU0CVWK9s
   Q==;
X-CSE-ConnectionGUID: BvUxMyT2RIuPqzNxiRq7Yg==
X-CSE-MsgGUID: oVs67PILQHa2SMXIX1JbCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="34508431"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="34508431"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:53:01 -0800
X-CSE-ConnectionGUID: eb2KSZ/AS+mBYMbhDjrXUg==
X-CSE-MsgGUID: ay4pzBApS9OUG1m5EtDkfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="84203631"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:53:00 -0800
Received: from [10.212.82.230] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 509E820B5703;
	Wed,  6 Nov 2024 09:52:58 -0800 (PST)
Message-ID: <244b4c80-2ab2-4248-b930-22fea9ed6429@linux.intel.com>
Date: Wed, 6 Nov 2024 12:52:56 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/22] perf jevents: Add tsx metric group for Intel
 models
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Perry Taylor <perry.taylor@intel.com>, Samantha Alt
 <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
References: <20240926175035.408668-1-irogers@google.com>
 <20240926175035.408668-7-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240926175035.408668-7-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> Allow duplicated metric to be dropped from json files. Detect when TSX
> is supported by a model by using the json events, use sysfs events at
> runtime as hypervisors, etc. may disable TSX.
> 
> Add CheckPmu to metric to determine if which PMUs have been associated
> with the loaded events.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 52 +++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index f34b4230a4ee..58e243695f0a 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -1,12 +1,13 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> -from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
> +from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
>                      JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
>                      MetricGroup, MetricRef, Select)
>  import argparse
>  import json
>  import math
>  import os
> +from typing import Optional
>  
>  # Global command line arguments.
>  _args = None
> @@ -74,6 +75,54 @@ def Smi() -> MetricGroup:
>      ], description = 'System Management Interrupt metrics')
>  
>  
> +def Tsx() -> Optional[MetricGroup]:
> +  pmu = "cpu_core" if CheckPmu("cpu_core") else "cpu"
> +  cycles = Event('cycles')

Isn't the pmu prefix required for cycles as well?

> +  cycles_in_tx = Event(f'{pmu}/cycles\-t/')
> +  cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
> +  try:
> +    # Test if the tsx event is present in the json, prefer the
> +    # sysfs version so that we can detect its presence at runtime.
> +    transaction_start = Event("RTM_RETIRED.START")
> +    transaction_start = Event(f'{pmu}/tx\-start/')

What's the difference between this check and the later has_event() check?

All the tsx related events are model-specific events. We should check
them all before using it.

Thanks,
Kan
> +  except:> +    return None
> +
> +  elision_start = None
> +  try:
> +    # Elision start isn't supported by all models, but we'll not
> +    # generate the tsx_cycles_per_elision metric in that
> +    # case. Again, prefer the sysfs encoding of the event.
> +    elision_start = Event("HLE_RETIRED.START")
> +    elision_start = Event(f'{pmu}/el\-start/')
> +  except:
> +    pass
> +
> +  return MetricGroup('transaction', [
> +      Metric('tsx_transactional_cycles',
> +             'Percentage of cycles within a transaction region.',
> +             Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
> +             '100%'),
> +      Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
> +             Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
> +                    has_event(cycles_in_tx),
> +                    0),
> +             '100%'),
> +      Metric('tsx_cycles_per_transaction',
> +             'Number of cycles within a transaction divided by the number of transactions.',
> +             Select(cycles_in_tx / transaction_start,
> +                    has_event(cycles_in_tx),
> +                    0),
> +             "cycles / transaction"),
> +      Metric('tsx_cycles_per_elision',
> +             'Number of cycles within a transaction divided by the number of elisions.',
> +             Select(cycles_in_tx / elision_start,
> +                    has_event(elision_start),
> +                    0),
> +             "cycles / elision") if elision_start else None,
> +  ], description="Breakdown of transactional memory statistics")
> +
> +
>  def main() -> None:
>    global _args
>  
> @@ -100,6 +149,7 @@ def main() -> None:
>        Idle(),
>        Rapl(),
>        Smi(),
> +      Tsx(),
>    ])
>  
>  

