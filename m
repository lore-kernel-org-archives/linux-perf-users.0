Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27417C79;
	Thu,  7 Nov 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991622; cv=none; b=l14oueGUqhLPHSyHMuiHBIUrNmQtk7+l0gw9WR5Obf1tQccOoYQKGQqMDjuC7XItzpTI7AlakIEdIQOnVtZprYhoEEvKUNSaBfPD3YFQzngW1JLsaudB2FdvnDgeWX2PwbI8oZ3M2Bzh+mTHUZtL0rGKf8xgwowbaBuuLweeDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991622; c=relaxed/simple;
	bh=nq6mA8FP/r9Hre+aEuczFlIzcjp4EaPQOSBwpWXRKxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eEr0dEkPwYI/8ASMc2bj8qJ7p041MkujzNYLb7eAQUuaYU9x2chAICYXP48PRYuMUqk7ou8IvsgSgIsGbJQwB+X9Y1vMs8L1Bfe4Ey+NBAKuiEFgV0tsuvEfHgSRttpyWngIPcvuVvj1pSb94NCXs0UK9LkhtPnzoBWHGMtRrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETow1Yc3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETow1Yc3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730991621; x=1762527621;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=nq6mA8FP/r9Hre+aEuczFlIzcjp4EaPQOSBwpWXRKxk=;
  b=ETow1Yc3ARjxkyT6UWFyctUPW2TYJkLBjY5Pv/0Gq4ivJZuOZcl81BaZ
   W+23bkGHfSBslnR7nFrbvfQmtSr6IPWW0eCns9AvefSdr1PhHIhNsyOsp
   pGt37aGzbKis4/O952t5gbc1+W8we/7rTd/VfK0KRzmf0XQ1D3dyyA7lJ
   o5nDE3aeBLyOieb2bVpHQcstB0tqmZ2SwEA6RnpSz7RXEcA25PBEAzVco
   wWToTEe+hZhfV3qMMDqpQdTvZL8fHAjWBhWwQOVL7ZMGwgpX2D1j0vfjw
   WLgZgDrDkkh0o8go5o6bxAbI+nJZ16u79K9MfgDT5DszBDDwmENRWhnmG
   g==;
X-CSE-ConnectionGUID: wd33VvbGQ+W3TPZ+kXXNRw==
X-CSE-MsgGUID: CrOmihOBToynmGhmKelFRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34762026"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="34762026"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 07:00:18 -0800
X-CSE-ConnectionGUID: 4OpBz/8sQw2SOjZ3U/iHQA==
X-CSE-MsgGUID: ubpHNa87REWNWPZdPhIODw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="108381934"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 07:00:18 -0800
Received: from [10.212.68.83] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9476820B5703;
	Thu,  7 Nov 2024 07:00:15 -0800 (PST)
Message-ID: <0d48bf82-5de2-4928-bd15-1c5abfd4f087@linux.intel.com>
Date: Thu, 7 Nov 2024 10:00:14 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/22] perf jevents: Add ports metric group giving
 utilization on Intel
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
 <20240926175035.408668-10-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240926175035.408668-10-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> The ports metric group contains a metric for each port giving its
> utilization as a ratio of cycles. The metrics are created by looking
> for UOPS_DISPATCHED.PORT events.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index f4707e964f75..3ef4eb868580 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -1,12 +1,13 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
> -                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
> -                    MetricGroup, MetricRef, Select)
> +                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
> +                    Metric, MetricGroup, MetricRef, Select)
>  import argparse
>  import json
>  import math
>  import os
> +import re
>  from typing import Optional
>  
>  # Global command line arguments.
> @@ -260,6 +261,33 @@ def IntelBr():
>                       description="breakdown of retired branch instructions")
>  
>  
> +def IntelPorts() -> Optional[MetricGroup]:
> +  pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
> +
> +  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
> +                      "CPU_CLK_UNHALTED.DISTRIBUTED",
> +                      "cycles")
> +  # Number of CPU cycles scaled for SMT.
> +  smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
> +
> +  metrics = []
> +  for x in pipeline_events:
> +    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
> +      name = x["EventName"]
> +      port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
> +      if name.endswith("_CORE"):
> +        cyc = core_cycles
> +      else:
> +        cyc = smt_cycles
> +      metrics.append(Metric(port, f"{port} utilization (higher is better)",
> +                            d_ratio(Event(name), cyc), "100%"))


The generated metric highly depends on the event name, which is very
fragile. We will probably have the same event in a new generation, but
with a different name. Long-term maintenance could be a problem.
Is there an idea regarding how to sync the event names for new generations?

Maybe we should improve the event generation script and do an automatic
check to tell which metrics are missed. Then we may decide if updating
the new event name, dropping the metric or adding a different metric.

Thanks,
Kan

> +  if len(metrics) == 0:
> +    return None
> +
> +  return MetricGroup("ports", metrics, "functional unit (port) utilization -- "
> +                     "fraction of cycles each port is utilized (higher is better)")
> +
> +
>  def IntelSwpf() -> Optional[MetricGroup]:
>    ins = Event("instructions")
>    try:
> @@ -352,6 +380,7 @@ def main() -> None:
>        Smi(),
>        Tsx(),
>        IntelBr(),
> +      IntelPorts(),
>        IntelSwpf(),
>    ])
>  

