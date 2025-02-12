Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3424C68E;
	Wed, 12 Feb 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379089; cv=none; b=RMx+UszHzKeSmmp89YN4PAzLsGtnTV3/Gne3IPAaoB0kAlU70UsNupPe9gJRiFgUIeme688172Ft24UpbersrGbBVSFOcfG+QvXnAKlWuIvsubLcZ2a1GQ67BOSV8/QRVgvMKRccIFC1TSZ2flcroNAQWGy4r1VkOthOmQG1vBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379089; c=relaxed/simple;
	bh=oK897G+AWztsU/oCRV2/0rESCUwLt/auN70euH7SM5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pn1CS97m0qlSN/IgxvDkGic1vv2QlQuhf8YgIGJZ5FOhrgf/DbGKG3LNQ8zw86FWg69viUsIlxeBiik83IYQ5o6Ed9JOlGlFEttHimQ3zvYayr5SYrkEBh9xOMZJhNFjhlPro2k/sVt8wmT/7VkSXO3D4QNHSgqLb2ir6W8bxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrD9s3fx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrD9s3fx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739379088; x=1770915088;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=oK897G+AWztsU/oCRV2/0rESCUwLt/auN70euH7SM5M=;
  b=PrD9s3fxrb/rv8G7A2JP6+c8POWJdOxhn2hZ6qv+qhMAztEKaryUki2/
   82rzcWjtbi4BEqMnKFC45wGSKAHhuAC2rSlkdPYQeDo3azlKNOJ34Hcri
   p3w8vBKviTYpYlHAq3LL6GJAstgTJGyu5R5iFpjOzFhtwKo3QT1BE9jVF
   altT5bOY5QJOlSd18PrDbH/TMTAyDl7LJWAtKF8tquPDgE6ABy+0H8G3K
   X8s58AhjJhKTEjc1c3CApkphySHOsLHDTXiHfzaolYIjREXlzdMSKko/O
   AVhxvUdKFHWEF5uKmmYnO6nUCgPWManmUinCSln/3PP1eGV/AjY083Ylr
   Q==;
X-CSE-ConnectionGUID: dGtMC92FTPyU4SlmApQ6+w==
X-CSE-MsgGUID: Mh2f3a1pSduj5oLHGesoMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39282430"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="39282430"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:51:25 -0800
X-CSE-ConnectionGUID: vg2edcX3QUWNFqhDlFKKiA==
X-CSE-MsgGUID: YHfSiDdJQvuIqw1aDMFlAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="112646138"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:51:25 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 92E1720B5713;
	Wed, 12 Feb 2025 08:51:22 -0800 (PST)
Message-ID: <7f17ddbe-6552-4702-acf3-f6fb3c2903c8@linux.intel.com>
Date: Wed, 12 Feb 2025 11:51:21 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/24] Intel vendor events and TMA 5.02 metrics
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>,
 Thomas Falcon <thomas.falcon@intel.com>
References: <20250211213031.114209-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250211213031.114209-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-11 4:30 p.m., Ian Rogers wrote:
> Update the Intel vendor events to the latest.
> Update the metrics to TMA 5.02.
> Add Arrowlake and Clearwaterforest support.
> Add metrics for LNL and GNR.
> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
> 
> The perf json was generated using the script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> with the generated json being in:
> https://github.com/intel/perfmon/tree/main/scripts/perf
> 
> Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
> Weilin Wang <weilin.wang@intel.com>, Kan Liang
> <kan.liang@linux.intel.com> and Thomas Falcon
> <thomas.falcon@intel.com> for helping get this patch series together.
> 

Thanks Ian!

I run the tests on Arrow Lake. Everything looks good.
Other patches looks good as well.

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> v8: Fix cpu_atom metrics with spaces in their names, pick up Thomas'
>     fix for UNC_CLOCK.SOCKET on MTL and ARL. Note the spaces issue is
>     already covered by the perf all metrics test.
> v7: Missing Default metric group for TopdownL1 on ARL, LNL and MTL.
> v6: Add Default metric groups for new models (Kan). Fix TSC and
>     C-State metrics (Tom). Bump TMA number from 5.01 to 5.02.
> v5: Remove Valkyrie metrics mistakenly added on atom. Ensure "perf all
>     metrics test" doesn't skip for missing events.
> v4: Fix TSC events on hybrid mistakenly specifying the core PMU
>     inhibiting the use of the msr PMU.
> v3: Fixes for hybrid metrics that were missing PMU. Update to the
>     latest events.
> v2: Fix hybrid and Co-authored-by tag issues reported by
>     Arnaldo. Updates to Lunarlake and Meteorlake events. Addition of
>     Clearwaterforest.
> 
> Ian Rogers (24):
>   perf vendor events: Update Alderlake events/metrics
>   perf vendor events: Update AlderlakeN events/metrics
>   perf vendor events: Add Arrowlake events/metrics
>   perf vendor events: Update Broadwell events/metrics
>   perf vendor events: Update BroadwellDE events/metrics
>   perf vendor events: Update BroadwellX events/metrics
>   perf vendor events: Update CascadelakeX events/metrics
>   perf vendor events: Add Clearwaterforest events
>   perf vendor events: Update EmeraldRapids events/metrics
>   perf vendor events: Update GrandRidge events/metrics
>   perf vendor events: Update/add Graniterapids events/metrics
>   perf vendor events: Update Haswell events/metrics
>   perf vendor events: Update HaswellX events/metrics
>   perf vendor events: Update Icelake events/metrics
>   perf vendor events: Update IcelakeX events/metrics
>   perf vendor events: Update/add Lunarlake events/metrics
>   perf vendor events: Update Meteorlake events/metrics
>   perf vendor events: Update Rocketlake events/metrics
>   perf vendor events: Update Sapphirerapids events/metrics
>   perf vendor events: Update Sierraforest events/metrics
>   perf vendor events: Update Skylake metrics
>   perf vendor events: Update SkylakeX events/metrics
>   perf vendor events: Update Tigerlake events/metrics
>   perf test stat_all_metrics: Ensure missing events fail test
> 
>  .../arch/x86/alderlake/adl-metrics.json       |  914 +++---
>  .../pmu-events/arch/x86/alderlake/cache.json  |  292 +-
>  .../arch/x86/alderlake/floating-point.json    |   19 +-
>  .../arch/x86/alderlake/frontend.json          |   19 -
>  .../pmu-events/arch/x86/alderlake/memory.json |   32 +-
>  .../arch/x86/alderlake/metricgroups.json      |   10 +-
>  .../pmu-events/arch/x86/alderlake/other.json  |   92 +-
>  .../arch/x86/alderlake/pipeline.json          |  127 +-
>  .../arch/x86/alderlake/virtual-memory.json    |   33 +
>  .../arch/x86/alderlaken/adln-metrics.json     |   85 +-
>  .../pmu-events/arch/x86/alderlaken/cache.json |  227 +-
>  .../arch/x86/alderlaken/floating-point.json   |   17 +-
>  .../arch/x86/alderlaken/memory.json           |   20 +
>  .../pmu-events/arch/x86/alderlaken/other.json |   81 +-
>  .../arch/x86/alderlaken/pipeline.json         |   97 +-
>  .../arch/x86/alderlaken/virtual-memory.json   |   30 +
>  .../arch/x86/arrowlake/arl-metrics.json       | 2749 +++++++++++++++++
>  .../pmu-events/arch/x86/arrowlake/cache.json  | 1491 +++++++++
>  .../arch/x86/arrowlake/floating-point.json    |  532 ++++
>  .../arch/x86/arrowlake/frontend.json          |  609 ++++
>  .../pmu-events/arch/x86/arrowlake/memory.json |  387 +++
>  .../arch/x86/arrowlake/metricgroups.json      |  150 +
>  .../pmu-events/arch/x86/arrowlake/other.json  |  279 ++
>  .../arch/x86/arrowlake/pipeline.json          | 2308 ++++++++++++++
>  .../arch/x86/arrowlake/uncore-cache.json      |   20 +
>  .../x86/arrowlake/uncore-interconnect.json    |   47 +
>  .../arch/x86/arrowlake/uncore-memory.json     |  160 +
>  .../{haswell => arrowlake}/uncore-other.json  |    2 +-
>  .../arch/x86/arrowlake/virtual-memory.json    |  522 ++++
>  .../arch/x86/broadwell/bdw-metrics.json       |  312 +-
>  .../pmu-events/arch/x86/broadwell/cache.json  |   10 +-
>  .../arch/x86/broadwell/frontend.json          |    4 +-
>  .../pmu-events/arch/x86/broadwell/memory.json |    8 +-
>  .../arch/x86/broadwell/metricgroups.json      |    5 +
>  .../arch/x86/broadwell/pipeline.json          |   10 +-
>  .../arch/x86/broadwellde/bdwde-metrics.json   |  256 +-
>  .../arch/x86/broadwellde/cache.json           |   10 +-
>  .../arch/x86/broadwellde/frontend.json        |    4 +-
>  .../arch/x86/broadwellde/memory.json          |    6 +-
>  .../arch/x86/broadwellde/metricgroups.json    |    5 +
>  .../arch/x86/broadwellde/pipeline.json        |   10 +-
>  .../arch/x86/broadwellde/uncore-cache.json    |   28 +-
>  .../x86/broadwellde/uncore-interconnect.json  |   16 +-
>  .../arch/x86/broadwellx/bdx-metrics.json      |  344 ++-
>  .../pmu-events/arch/x86/broadwellx/cache.json |   10 +-
>  .../arch/x86/broadwellx/frontend.json         |    4 +-
>  .../arch/x86/broadwellx/memory.json           |    6 +-
>  .../arch/x86/broadwellx/metricgroups.json     |    5 +
>  .../arch/x86/broadwellx/pipeline.json         |   10 +-
>  .../arch/x86/broadwellx/uncore-cache.json     |   28 +-
>  .../x86/broadwellx/uncore-interconnect.json   |   36 +-
>  .../arch/x86/broadwellx/uncore-memory.json    |    1 +
>  .../arch/x86/cascadelakex/clx-metrics.json    |  767 +++--
>  .../arch/x86/cascadelakex/metricgroups.json   |    9 +-
>  .../arch/x86/cascadelakex/uncore-cache.json   |   60 +-
>  .../x86/cascadelakex/uncore-interconnect.json |   11 -
>  .../arch/x86/clearwaterforest/cache.json      |  144 +
>  .../arch/x86/clearwaterforest/counter.json    |    7 +
>  .../arch/x86/clearwaterforest/frontend.json   |   18 +
>  .../arch/x86/clearwaterforest/memory.json     |   22 +
>  .../arch/x86/clearwaterforest/other.json      |   22 +
>  .../arch/x86/clearwaterforest/pipeline.json   |  113 +
>  .../x86/clearwaterforest/virtual-memory.json  |   29 +
>  .../arch/x86/emeraldrapids/cache.json         |   28 +-
>  .../arch/x86/emeraldrapids/emr-metrics.json   |  976 +++---
>  .../arch/x86/emeraldrapids/frontend.json      |   19 -
>  .../arch/x86/emeraldrapids/memory.json        |   15 +-
>  .../arch/x86/emeraldrapids/metricgroups.json  |   10 +-
>  .../arch/x86/emeraldrapids/pipeline.json      |   23 -
>  .../arch/x86/emeraldrapids/uncore-io.json     |  218 +-
>  .../arch/x86/grandridge/grr-metrics.json      |  284 +-
>  .../arch/x86/grandridge/pipeline.json         |    3 +-
>  .../arch/x86/grandridge/uncore-cache.json     |    4 +-
>  .../x86/grandridge/uncore-interconnect.json   |   60 +
>  .../arch/x86/grandridge/uncore-io.json        |  214 +-
>  .../arch/x86/grandridge/uncore-memory.json    |    2 +-
>  .../arch/x86/graniterapids/cache.json         |  130 +-
>  .../arch/x86/graniterapids/counter.json       |   24 +-
>  .../arch/x86/graniterapids/frontend.json      |   24 +-
>  .../arch/x86/graniterapids/gnr-metrics.json   | 2325 ++++++++++++++
>  .../arch/x86/graniterapids/memory.json        |  121 +-
>  .../arch/x86/graniterapids/metricgroups.json  |  145 +
>  .../arch/x86/graniterapids/other.json         |  109 +
>  .../arch/x86/graniterapids/pipeline.json      |   40 +-
>  .../arch/x86/graniterapids/uncore-cache.json  |   48 +-
>  .../arch/x86/graniterapids/uncore-cxl.json    |    2 -
>  .../graniterapids/uncore-interconnect.json    |   87 +
>  .../arch/x86/graniterapids/uncore-io.json     |  280 +-
>  .../arch/x86/graniterapids/uncore-memory.json |  122 +-
>  .../arch/x86/graniterapids/uncore-power.json  |   98 +
>  .../arch/x86/haswell/hsw-metrics.json         |  260 +-
>  .../pmu-events/arch/x86/haswell/memory.json   |    2 +-
>  .../arch/x86/haswell/metricgroups.json        |    5 +
>  .../arch/x86/haswellx/hsx-metrics.json        |  296 +-
>  .../arch/x86/haswellx/metricgroups.json       |    5 +
>  .../arch/x86/haswellx/uncore-cache.json       |   28 +-
>  .../x86/haswellx/uncore-interconnect.json     |   38 +-
>  .../pmu-events/arch/x86/icelake/cache.json    |   34 +-
>  .../pmu-events/arch/x86/icelake/frontend.json |   17 -
>  .../arch/x86/icelake/icl-metrics.json         |  849 ++---
>  .../pmu-events/arch/x86/icelake/memory.json   |   13 +-
>  .../arch/x86/icelake/metricgroups.json        |   10 +-
>  .../pmu-events/arch/x86/icelake/pipeline.json |   30 +-
>  .../arch/x86/icelake/uncore-interconnect.json |   76 -
>  .../arch/x86/icelake/uncore-other.json        |    2 +-
>  .../arch/x86/icelake/virtual-memory.json      |   18 +
>  .../pmu-events/arch/x86/icelakex/cache.json   |   41 +-
>  .../arch/x86/icelakex/frontend.json           |   17 -
>  .../arch/x86/icelakex/icx-metrics.json        |  852 ++---
>  .../pmu-events/arch/x86/icelakex/memory.json  |   13 +-
>  .../arch/x86/icelakex/metricgroups.json       |   10 +-
>  .../arch/x86/icelakex/pipeline.json           |   30 +-
>  .../pmu-events/arch/x86/lunarlake/cache.json  | 1352 +++++++-
>  .../arch/x86/lunarlake/floating-point.json    |  484 +++
>  .../arch/x86/lunarlake/frontend.json          |  654 +++-
>  .../arch/x86/lunarlake/lnl-metrics.json       | 2730 ++++++++++++++++
>  .../pmu-events/arch/x86/lunarlake/memory.json |  262 +-
>  .../arch/x86/lunarlake/metricgroups.json      |  150 +
>  .../pmu-events/arch/x86/lunarlake/other.json  |  496 ++-
>  .../arch/x86/lunarlake/pipeline.json          | 2105 +++++++++++--
>  .../arch/x86/lunarlake/uncore-memory.json     |   36 +
>  .../arch/x86/lunarlake/virtual-memory.json    |  428 +++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   42 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json |  109 +-
>  .../arch/x86/meteorlake/frontend.json         |   30 +-
>  .../arch/x86/meteorlake/memory.json           |   22 +-
>  .../arch/x86/meteorlake/metricgroups.json     |   10 +-
>  .../arch/x86/meteorlake/mtl-metrics.json      | 1048 ++++---
>  .../pmu-events/arch/x86/meteorlake/other.json |   54 +
>  .../arch/x86/meteorlake/pipeline.json         |   89 +-
>  .../arch/x86/meteorlake/uncore-other.json     |    2 +-
>  .../pmu-events/arch/x86/rocketlake/cache.json |   34 +-
>  .../arch/x86/rocketlake/frontend.json         |   17 -
>  .../arch/x86/rocketlake/memory.json           |   13 +-
>  .../arch/x86/rocketlake/metricgroups.json     |   10 +-
>  .../arch/x86/rocketlake/pipeline.json         |   30 +-
>  .../arch/x86/rocketlake/rkl-metrics.json      |  849 ++---
>  .../x86/rocketlake/uncore-interconnect.json   |   10 -
>  .../arch/x86/rocketlake/uncore-other.json     |    2 +-
>  .../arch/x86/rocketlake/virtual-memory.json   |   18 +
>  .../arch/x86/sapphirerapids/cache.json        |   30 +-
>  .../arch/x86/sapphirerapids/frontend.json     |   19 -
>  .../arch/x86/sapphirerapids/memory.json       |   15 +-
>  .../arch/x86/sapphirerapids/metricgroups.json |   10 +-
>  .../arch/x86/sapphirerapids/pipeline.json     |   23 -
>  .../arch/x86/sapphirerapids/spr-metrics.json  |  908 +++---
>  .../arch/x86/sapphirerapids/uncore-io.json    |  138 +-
>  .../arch/x86/sierraforest/cache.json          |  130 +-
>  .../arch/x86/sierraforest/counter.json        |   24 +-
>  .../arch/x86/sierraforest/frontend.json       |    8 +
>  .../arch/x86/sierraforest/other.json          |   20 +
>  .../arch/x86/sierraforest/pipeline.json       |   46 +-
>  .../arch/x86/sierraforest/srf-metrics.json    |  308 +-
>  .../arch/x86/sierraforest/uncore-cache.json   |   61 +-
>  .../arch/x86/sierraforest/uncore-cxl.json     |    2 -
>  .../x86/sierraforest/uncore-interconnect.json |   87 +
>  .../arch/x86/sierraforest/uncore-io.json      |  280 +-
>  .../arch/x86/sierraforest/uncore-memory.json  |  122 +-
>  .../arch/x86/sierraforest/uncore-power.json   |   98 +
>  .../arch/x86/skylake/metricgroups.json        |    9 +-
>  .../arch/x86/skylake/skl-metrics.json         |  684 ++--
>  .../arch/x86/skylakex/metricgroups.json       |    9 +-
>  .../arch/x86/skylakex/skx-metrics.json        |  740 +++--
>  .../arch/x86/skylakex/uncore-cache.json       |   60 +-
>  .../x86/skylakex/uncore-interconnect.json     |   11 -
>  .../pmu-events/arch/x86/tigerlake/cache.json  |   45 +-
>  .../arch/x86/tigerlake/frontend.json          |   17 -
>  .../pmu-events/arch/x86/tigerlake/memory.json |   13 +-
>  .../arch/x86/tigerlake/metricgroups.json      |   10 +-
>  .../arch/x86/tigerlake/pipeline.json          |   30 +-
>  .../arch/x86/tigerlake/tgl-metrics.json       |  745 +++--
>  .../x86/tigerlake/uncore-interconnect.json    |    4 +-
>  .../arch/x86/tigerlake/uncore-other.json      |    2 +-
>  .../arch/x86/tigerlake/virtual-memory.json    |   18 +
>  tools/perf/tests/shell/stat_all_metrics.sh    |    8 +-
>  175 files changed, 30283 insertions(+), 7275 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-memory.json
>  rename tools/perf/pmu-events/arch/x86/{haswell => arrowlake}/uncore-other.json (90%)
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/virtual-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/virtual-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/lnl-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/uncore-memory.json
> 

