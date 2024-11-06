Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01740204932;
	Wed,  6 Nov 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914368; cv=none; b=pVjpiKAVJqPKz5qiwd+5b9ehyE8ACjGTtVBTS6URWMeZzAVMVaBPnVSeGpjCISK5U4L2aqSS9UcRyBb/TTDTCVlLZ+jfxfQR4ZHVW1fCwrRXRAmfshKUnEFYvUe048MVH+xrt/RWMsBPux22qijuDxCMlYSzIYlJ75R5ledAdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914368; c=relaxed/simple;
	bh=yt+QqUmEt1w7XSHumooDG7+gE/q8Cm20S03bW9MyURM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uXI6O5W7bVfKynOWmLXzn9u4ivMecyyQKZlf1vLZzgwjTjIMx26+/TlGpViifuJ2w5nvcRKhMp1mm7TiScGkIlsByay3vO41oUF9sP5pmhIcui+lRuF5yYfjmQtWMg1C6H5qwE77ZVQ91VANTHIY4yuHCBPhPHUu065MAuF7Xpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ck51gHui; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ck51gHui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730914366; x=1762450366;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=yt+QqUmEt1w7XSHumooDG7+gE/q8Cm20S03bW9MyURM=;
  b=Ck51gHuiue1fE4XcxUSBw3LP1MPrtzXKhfmPWVN9CTDDTNoaeGWTd7hg
   fUnoStnmgp5+ridFMN5blMXGKO1WqKhCIz496d9U0sC5sQZMroXsCebbT
   v22isHyNdwZfvRAtb9sx+NPyQm3pLAKwo61ZxC+J94GXSV45L8DvT54ZN
   AOty6jttgC1COQ7sw4NkgUrYiqVjuEYbT7+icV3CHZlKRr1KzlF2NkHKX
   IRAZEDhdUCWX7DX8wvEVZxHIL75p4hmK9SUxXdIn7vh/uWwG5Gi1FKLeN
   Q83dZpIl+y7MAsebDC1khW06vcBNId9T97O3qlUTUijqMglB6rKJfgFBi
   Q==;
X-CSE-ConnectionGUID: xtfxZ87CQDyX3V/bLMfkng==
X-CSE-MsgGUID: B5JC8WdFS0mZCc6TqPzyVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30135394"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="30135394"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:32:43 -0800
X-CSE-ConnectionGUID: n193XzngQ5m/d1wTf/OA/w==
X-CSE-MsgGUID: Eu+0uK5bQ9G1qLKDDrizKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="115465987"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:32:43 -0800
Received: from [10.212.82.230] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F402C20B5703;
	Wed,  6 Nov 2024 09:32:40 -0800 (PST)
Message-ID: <30c22df5-9815-4a73-9a12-165d9045a667@linux.intel.com>
Date: Wed, 6 Nov 2024 12:32:39 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/22] perf jevents: Add smi metric group for Intel
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
 <20240926175035.408668-4-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240926175035.408668-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> Allow duplicated metric to be dropped from json files.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index f875eb844c78..f34b4230a4ee 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
>                      JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
> -                    MetricGroup, Select)
> +                    MetricGroup, MetricRef, Select)
>  import argparse
>  import json
>  import math
> @@ -56,6 +56,24 @@ def Rapl() -> MetricGroup:
>                       description="Running Average Power Limit (RAPL) power consumption estimates")
>  
>  
> +def Smi() -> MetricGroup:
> +    aperf = Event('msr/aperf/')
> +    cycles = Event('cycles')
> +    smi_num = Event('msr/smi/')
> +    smi_cycles = Select(Select((aperf - cycles) / aperf, smi_num > 0, 0),
> +                        has_event(aperf),
> +                        0)
> +    return MetricGroup('smi', [
> +        Metric('smi_num', 'Number of SMI interrupts.',
> +               Select(smi_num, has_event(smi_num), 0), 'SMI#'),
> +        # Note, the smi_cycles "Event" is really a reference to the metric.
> +        Metric('smi_cycles',
> +               'Percentage of cycles spent in System Management Interrupts. '
> +               'Requires /sys/devices/cpu/freeze_on_smi to be 1.',

It seems not work for hybrid?

Thanks,
Kan
> +               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
> +    ], description = 'System Management Interrupt metrics')
> +
> +
>  def main() -> None:
>    global _args
>  
> @@ -81,6 +99,7 @@ def main() -> None:
>    all_metrics = MetricGroup("", [
>        Idle(),
>        Rapl(),
> +      Smi(),
>    ])
>  
>  

