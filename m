Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A213CA81;
	Fri, 27 Sep 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727462055; cv=none; b=BvuuC+GcQoJT6sD2QB+JFLiMl+o0KxJFldv2B0tc0FGU/sX2ws2vWb0GWtp5oDiu6uakbdLzmyS64Slf/iPSmTC5Z3r/EljZFvquHgwIUf5FCE1hdhRJ/0qMYqwr906ltyVCaVD4uPnPwy/uz1glVaON1fyk+4jE9QdTFNRbir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727462055; c=relaxed/simple;
	bh=dlqW5Zm8FitfmTGFtECD8AT31bFCGQrJ6qlNba+UZV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mO2hR/6we0SA8AcmuyaH3jtPgwIU70tIxqAjo9TGO2+/RHT1HU29QgIqfcM00brg0a76OhjfWjwyA2hrxlu23ebQbkE6gxU2I5SsmkY0YZIN7grvRR0e4gQBhEhWzvk5jbFim7vyHND4O+C0TrgM7NfCocttP39NbjOAkz+AFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUyByVj6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUyByVj6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727462053; x=1758998053;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dlqW5Zm8FitfmTGFtECD8AT31bFCGQrJ6qlNba+UZV4=;
  b=hUyByVj6IyRgINIrfTtYbJHqCpi3xWXbO6FnCdGQe1BLaRd9+0WM7sPZ
   6wXemGM7eMZrXHcvRzfgS5p6Drtm42cIuxnCA7sdY0BavY0F+y/4d25PR
   Anr046YhzxE3duMlAyAVwYqu5R8NTb1841BIMexhXPkF4vfLHD6SM+vMY
   b3sJ3PAk/o3vHq1E+Mj3sl0z/ewfElI/bHP6Zg0L4sgJXQn5QKTqu1OhY
   p3PmduJJIQb+NhCbR7SN9FxFr64k64SAoqkfcJNS8HKimhDFOzpMfu4QG
   ZV4WVPm9F7TVjMTfhvb2nkR68wF7l1NFBxuvFuAS0bz7ZYr1RgM1X4r2z
   g==;
X-CSE-ConnectionGUID: 3KG002ZyTHq25qih7q1cuA==
X-CSE-MsgGUID: Ot+jEmxxRYO9HGlBPjMrkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="26748097"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="26748097"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 11:34:01 -0700
X-CSE-ConnectionGUID: hGCaFdTjRU2ETMBJ4AAm0Q==
X-CSE-MsgGUID: BJCBp5/4R/ajQ2HHluHvbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="103422840"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 11:34:00 -0700
Received: from [10.212.24.85] (kliang2-mobl1.ccr.corp.intel.com [10.212.24.85])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4131720B8DDA;
	Fri, 27 Sep 2024 11:33:58 -0700 (PDT)
Message-ID: <bbbd024c-d2df-47ea-9587-f68e5bc45962@linux.intel.com>
Date: Fri, 27 Sep 2024 14:33:57 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/22] Python generated Intel metrics
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> Generate twenty sets of additional metrics for Intel. Rapl and Idle
> metrics aren't specific to Intel but are placed here for ease and
> convenience. Smi and tsx metrics are added so they can be dropped from
> the per model json files. 

Are Smi and tsx metrics the only two metrics who's duplicate metrics in
the json files will be dropped?

It sounds like there will be many duplicate metrics in perf list, right?

Also, is it an attempt to define some architectural metrics for perf?
How do you decide which metrics should be added here?

Thanks,
Kan

> There are four uncore sets of metrics and
> eleven core metrics. Add a CheckPmu function to metric to simplify
> detecting the presence of hybrid PMUs in events. Metrics with
> experimental events are flagged as experimental in their description.
> 
> The patches should be applied on top of:
> https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/
> 
> v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase.
> v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
>     minor code cleanup changes. Drop reference to merged fix for
>     umasks/occ_sel in PCU events and for cstate metrics.
> v2. Drop the cycles breakdown in favor of having it as a common
>     metric, spelling and other improvements suggested by Kan Liang
>     <kan.liang@linux.intel.com>.
> 
> Ian Rogers (22):
>   perf jevents: Add RAPL metrics for all Intel models
>   perf jevents: Add idle metric for Intel models
>   perf jevents: Add smi metric group for Intel models
>   perf jevents: Add CheckPmu to see if a PMU is in loaded json events
>   perf jevents: Mark metrics with experimental events as experimental
>   perf jevents: Add tsx metric group for Intel models
>   perf jevents: Add br metric group for branch statistics on Intel
>   perf jevents: Add software prefetch (swpf) metric group for Intel
>   perf jevents: Add ports metric group giving utilization on Intel
>   perf jevents: Add L2 metrics for Intel
>   perf jevents: Add load store breakdown metrics ldst for Intel
>   perf jevents: Add ILP metrics for Intel
>   perf jevents: Add context switch metrics for Intel
>   perf jevents: Add FPU metrics for Intel
>   perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
>   perf jevents: Add mem_bw metric for Intel
>   perf jevents: Add local/remote "mem" breakdown metrics for Intel
>   perf jevents: Add dir breakdown metrics for Intel
>   perf jevents: Add C-State metrics from the PCU PMU for Intel
>   perf jevents: Add local/remote miss latency metrics for Intel
>   perf jevents: Add upi_bw metric for Intel
>   perf jevents: Add mesh bandwidth saturation metric for Intel
> 
>  tools/perf/pmu-events/intel_metrics.py | 1046 +++++++++++++++++++++++-
>  tools/perf/pmu-events/metric.py        |   52 ++
>  2 files changed, 1095 insertions(+), 3 deletions(-)
> 
