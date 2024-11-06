Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825FE20514F;
	Wed,  6 Nov 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912525; cv=none; b=epnWUIcl5mp3jZHzIi6SCEwcJQF2R2nkxyXIT3O0JycO/KSoCAN1ZKlY1Lv8hmeHj06ndMu21I9/kopVZW4oMwEQlBTInNYXKc7jh+sBAnzez0yxxBG16nKndBS2L5k+m2+nD4TyoMUZ1bUKKC/uRik11btddMmUppuDLnzvxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912525; c=relaxed/simple;
	bh=zCXWyEVldkd9KNzFKA2eZUdeCgmR3MFPxkTievOg+tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oqxpdh/aiKICgkyPd1RdvOsB3ZpBjTmzDf/El2yku85fAENuJmaiNFlo4hrKaINbOfvkukbqLlCaXhs5/QizTWCLmZodOXjzHo8ROul6bhbXm93xkqIY2S8JRQkgyTDMnR46o3VODRuRjnmNsVDy6r4diYw0ndVeURTqZFvztrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAnxO6mK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAnxO6mK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730912524; x=1762448524;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=zCXWyEVldkd9KNzFKA2eZUdeCgmR3MFPxkTievOg+tY=;
  b=WAnxO6mKrrDgFmKwGc7yLWHdKjhFcsGJybnvD9nxUmcsruCy2j/jMBV/
   dzWhsbW22i3ai4KlHR0PrSOMLdE5so+V0zgCO491ZfEjx8LK9WXNM3P34
   Q8y00w92WpWB3KYc4WHzdVhQGnYYKm3eh9TgW9hz+PLaQT2X4NYbssRap
   e2zzvJLI6d3sZCVx862klUzp2SrFUzo+teWG3V+DtOrxPV9xGOVhNb1ii
   hQDetxxR0u86yrHi5HHV5LczQoEORZptY5lmCUvN7XDSBq6wJDApGhpNA
   DYcP9eh9w1UNbWEN+7UcfWiujt93cefCev3fHmLHdPH4xU6Dp5RFIOXRx
   Q==;
X-CSE-ConnectionGUID: FXcahGssTs6Ry0dMiVdJcA==
X-CSE-MsgGUID: HgjF2itFTrmIO6TgXHcBbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30901917"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30901917"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:02:03 -0800
X-CSE-ConnectionGUID: 7ak/XTZtQjWlStfORYySYA==
X-CSE-MsgGUID: A0BgLoLeTcCFccYCUB2mzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89238194"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:02:02 -0800
Received: from [10.212.82.230] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 95DCC20B5703;
	Wed,  6 Nov 2024 09:02:00 -0800 (PST)
Message-ID: <452ec98c-b715-4e11-a605-0d6a1aafb91d@linux.intel.com>
Date: Wed, 6 Nov 2024 12:01:59 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/22] perf jevents: Add idle metric for Intel models
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240926175035.408668-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> Compute using the msr PMU the percentage of wallclock cycles where the
> CPUs are in a low power state.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index 58e23eb48312..f875eb844c78 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -1,7 +1,8 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> -from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
> -                    LoadEvents, Metric, MetricGroup, Select)
> +from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
> +                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
> +                    MetricGroup, Select)
>  import argparse
>  import json
>  import math
> @@ -11,6 +12,16 @@ import os
>  _args = None
>  interval_sec = Event("duration_time")
>  
> +def Idle() -> Metric:
> +  cyc = Event("msr/mperf/")
> +  tsc = Event("msr/tsc/")
> +  low = max(tsc - cyc, 0)
> +  return Metric(
> +      "idle",
> +      "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
> +      d_ratio(low, tsc), "100%")

I'm not sure if the metrics is correct, especially considering the mperf
is a R/W register. If someone clear the mperf, the restuls must be wrong.

Thanks,
Kan

> +
> +
>  def Rapl() -> MetricGroup:
>    """Processor power consumption estimate.
>  
> @@ -68,6 +79,7 @@ def main() -> None:
>    LoadEvents(directory)
>  
>    all_metrics = MetricGroup("", [
> +      Idle(),
>        Rapl(),
>    ])
>  

