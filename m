Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E232064FF;
	Wed,  6 Nov 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912942; cv=none; b=J5DMHdOBMyjjY8AgsmhWEZjJmfkGxFTc0LXyyLGT4H7hGtGkGbVn48E0dyOf3E7643ilq12K+gQSACA23rKXTrbE5Hyoxbo3RbUDxrICWFUi8NObfJtPnGwkHx3zzrmpF/pR3nHwJpr9CjrhW3nolEfCZ4G0Lk6MGybS3dZNUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912942; c=relaxed/simple;
	bh=jdDBuQ/io0RAwH8i8QYi2WqvPZGMUC8zmXe5Gdh6TPY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=m9uyPOd31l2sIxYUcETNrioiwa/L3h7cDDiKfVU889//mmKax/16h86vy6z6h956Aionw7r6qRSFQ5wkOQUqfhOq7sku/xESbg6upKrQfwFIj9/c9L+S5SYPoBKa8koBe9Es5DqTw8WubfdoAn0NR6Kk4aUgzuuMZhgj5tf1v3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtmkdDS0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtmkdDS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730912941; x=1762448941;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=jdDBuQ/io0RAwH8i8QYi2WqvPZGMUC8zmXe5Gdh6TPY=;
  b=jtmkdDS0DYffxwUSgGbYPMEoJBBG9ickfLhN4QTfcyt2BEK3xaErhCjE
   hZ/rDUN6cV0W1CkP01qaLVGumjcDyCzsIIxLTDMxtR5oMYujpQq68O2GL
   KZxVoA+6Q7eaDmnXXBC3tXIfsusDWH/eu5a+5u0VrZhLCw5PycX+Ll849
   90Ksd4V5VWG65kzTngWN0eiTFaCvVopM4KVXEpSEbXIvKI7Tiip2pSf06
   EUUy7nxIsBb/ToEomJLIMJH76IoeUe04tqSEj0OL0uAOiNh4Bko1EHqjs
   l7tQo9i2zav1dwo2MyyGzvtqmC1Ix0HhrJ1l8J8fSuAc4vHpqz4VQT2MG
   w==;
X-CSE-ConnectionGUID: U3lnfHcnRleQ/PCE9NcVsw==
X-CSE-MsgGUID: ANneXoMTRru6M+L34FTpKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30881681"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30881681"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:09:01 -0800
X-CSE-ConnectionGUID: kCtS4L9HT42XQyTuopVynQ==
X-CSE-MsgGUID: W3MUBwIQRYS8JNN+Hli7dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="84817570"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:08:59 -0800
Received: from [10.212.82.230] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8819620B5703;
	Wed,  6 Nov 2024 09:08:57 -0800 (PST)
Message-ID: <365e34e3-929e-4b28-b0f2-ddcbaa09294a@linux.intel.com>
Date: Wed, 6 Nov 2024 12:08:56 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/22] perf jevents: Add idle metric for Intel models
From: "Liang, Kan" <kan.liang@linux.intel.com>
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
 <20240926175035.408668-3-irogers@google.com>
 <452ec98c-b715-4e11-a605-0d6a1aafb91d@linux.intel.com>
Content-Language: en-US
In-Reply-To: <452ec98c-b715-4e11-a605-0d6a1aafb91d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-11-06 12:01 p.m., Liang, Kan wrote:
> 
> 
> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
>> Compute using the msr PMU the percentage of wallclock cycles where the
>> CPUs are in a low power state.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>  tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
>> index 58e23eb48312..f875eb844c78 100755
>> --- a/tools/perf/pmu-events/intel_metrics.py
>> +++ b/tools/perf/pmu-events/intel_metrics.py
>> @@ -1,7 +1,8 @@
>>  #!/usr/bin/env python3
>>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>> -from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
>> -                    LoadEvents, Metric, MetricGroup, Select)
>> +from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
>> +                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
>> +                    MetricGroup, Select)
>>  import argparse
>>  import json
>>  import math
>> @@ -11,6 +12,16 @@ import os
>>  _args = None
>>  interval_sec = Event("duration_time")
>>  
>> +def Idle() -> Metric:
>> +  cyc = Event("msr/mperf/")
>> +  tsc = Event("msr/tsc/")
>> +  low = max(tsc - cyc, 0)
>> +  return Metric(
>> +      "idle",
>> +      "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
>> +      d_ratio(low, tsc), "100%")
> 

The mperf and aperf can be enumerated. It's better to check it before
using it, has_event(mperf).

Thanks,
Kan

> I'm not sure if the metrics is correct, especially considering the mperf
> is a R/W register. If someone clear the mperf, the restuls must be wrong.
> 
> Thanks,
> Kan
> 
>> +
>> +
>>  def Rapl() -> MetricGroup:
>>    """Processor power consumption estimate.
>>  
>> @@ -68,6 +79,7 @@ def main() -> None:
>>    LoadEvents(directory)
>>  
>>    all_metrics = MetricGroup("", [
>> +      Idle(),
>>        Rapl(),
>>    ])
>>  
> 
> 

