Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886315696E;
	Fri, 17 Jan 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129819; cv=none; b=EIjuhZeHbgqUZTpAXP84VmolaRMQz/nR0TPi4mCrV3+PDZwJlQ4CwYlIw8pX5t1ylbaKMRluT4qsKqo4SBKGAC1hgsugybGKayOT0LgZptiUGJZBChMLd5ZvIxmO7s8RTL0HOWtlXwylVg92FzKSl5gdf2+eoW/LiHrkPsyCFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129819; c=relaxed/simple;
	bh=2DF3I5ADTzr2vulySgOe7Nh62/QVqlUSIlEVA6L38wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X1pHWmMgNfVTWkeLUoo2BrM/3M14S25l5ezWF5iEbNwy2M8kLpx4oCE2UnvKV0l7jNkDo3M7yQ5k6+m2dUFEJxRKyy8Ewjbjb4dYOiOtCErAZn25suY9LZq6xf10AZASaXJ35jmqUP3vBG2mr9lULc3gO3tdyiSbkXsh+FigL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ie8Zp9hl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ie8Zp9hl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737129817; x=1768665817;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2DF3I5ADTzr2vulySgOe7Nh62/QVqlUSIlEVA6L38wI=;
  b=Ie8Zp9hlnPToLH5fXbtcUvFKFKgW6MSNG2KlkoIVtr9cHpcxcpL52WnO
   2yT0QVhzWhK5gIXl5ArTO7RZcMQPeKpIoCkDVxFOb9iG0nHXmF/65o0rJ
   vZJeQwxz+TXYaT0pD6yq5sWBtr7UASwKcIc33kgf54gTZLjwYOFgMj++M
   Ee8/CR4UT+9QJWWiesKlIcHnADuXzwICIGqYtKhwkvNnV8B+SneZNyrne
   XcJOYWapxn7cuuwjgsQZ8mqLbwOH1sLoi9jnFFif3SVldKBkajnnsPU6I
   8Li6fV30/qEF2okRWI6PG0ciEnBtDHk4k14q/FSo6BwdW7ciNrp6yj3kE
   Q==;
X-CSE-ConnectionGUID: 3FXvRUMHR4mefBuXlclGKA==
X-CSE-MsgGUID: /8Ppa8+CT0uDgxgSctU8Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="41238175"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="41238175"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 08:03:36 -0800
X-CSE-ConnectionGUID: cisACPYiT/q7OXXp0aWWXA==
X-CSE-MsgGUID: 7E/fbI0qRmmj7oigexYWlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="129096210"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 08:03:36 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 26F7F20B5713;
	Fri, 17 Jan 2025 08:03:34 -0800 (PST)
Message-ID: <10984553-bf84-4bff-9129-4b31815e38d6@linux.intel.com>
Date: Fri, 17 Jan 2025 11:03:33 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] Intel vendor events and TMA 5.01 metrics
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
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
References: <20250116064355.344245-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250116064355.344245-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-16 1:43 a.m., Ian Rogers wrote:
> Update the Intel vendor events to the latest.
> Update the metrics to TMA 5.01.
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
> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com> and
> Weilin Wang <weilin.wang@intel.com> for helping get this patch series
> together.
> 
> v2: Fix hybrid and Co-authored-by tag issues reported by
>     Arnaldo. Updates to Lunarlake and Meteorlake events. Addition of
>     Clearwaterforest.

Thanks Ian!

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
> Ian Rogers (23):
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
> 
>  .../arch/x86/alderlake/adl-metrics.json       | 3637 ++++++++++---
>  .../pmu-events/arch/x86/alderlake/cache.json  |  292 +-
>  .../arch/x86/alderlake/floating-point.json    |   19 +-
>  .../arch/x86/alderlake/frontend.json          |   19 -
>  .../pmu-events/arch/x86/alderlake/memory.json |   32 +-
>  .../arch/x86/alderlake/metricgroups.json      |   10 +-
>  .../pmu-events/arch/x86/alderlake/other.json  |   92 +-
>  .../arch/x86/alderlake/pipeline.json          |  127 +-
>  .../arch/x86/alderlake/virtual-memory.json    |   33 +
>  .../arch/x86/alderlaken/adln-metrics.json     |   83 +-
>  .../pmu-events/arch/x86/alderlaken/cache.json |  227 +-
>  .../arch/x86/alderlaken/floating-point.json   |   17 +-
>  .../arch/x86/alderlaken/memory.json           |   20 +
>  .../pmu-events/arch/x86/alderlaken/other.json |   81 +-
>  .../arch/x86/alderlaken/pipeline.json         |   97 +-
>  .../arch/x86/alderlaken/virtual-memory.json   |   30 +
>  .../arch/x86/arrowlake/arl-metrics.json       | 4597 ++++++++++++++++
>  .../pmu-events/arch/x86/arrowlake/cache.json  | 1471 ++++++
>  .../arch/x86/arrowlake/floating-point.json    |  532 ++
>  .../arch/x86/arrowlake/frontend.json          |  609 +++
>  .../pmu-events/arch/x86/arrowlake/memory.json |  387 ++
>  .../arch/x86/arrowlake/metricgroups.json      |  150 +
>  .../pmu-events/arch/x86/arrowlake/other.json  |  279 +
>  .../arch/x86/arrowlake/pipeline.json          | 2307 +++++++++
>  .../arch/x86/arrowlake/uncore-cache.json      |   20 +
>  .../x86/arrowlake/uncore-interconnect.json    |   47 +
>  .../arch/x86/arrowlake/uncore-memory.json     |  142 +
>  .../arch/x86/arrowlake/uncore-other.json      |   10 +
>  .../arch/x86/arrowlake/virtual-memory.json    |  522 ++
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
>  .../arch/x86/broadwellx/bdx-metrics.json      |  344 +-
>  .../pmu-events/arch/x86/broadwellx/cache.json |   10 +-
>  .../arch/x86/broadwellx/frontend.json         |    4 +-
>  .../arch/x86/broadwellx/memory.json           |    6 +-
>  .../arch/x86/broadwellx/metricgroups.json     |    5 +
>  .../arch/x86/broadwellx/pipeline.json         |   10 +-
>  .../arch/x86/broadwellx/uncore-cache.json     |   28 +-
>  .../x86/broadwellx/uncore-interconnect.json   |   36 +-
>  .../arch/x86/broadwellx/uncore-memory.json    |    1 +
>  .../arch/x86/cascadelakex/clx-metrics.json    |  767 +--
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
>  .../arch/x86/emeraldrapids/emr-metrics.json   | 1036 ++--
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
>  .../arch/x86/graniterapids/cache.json         |  110 +-
>  .../arch/x86/graniterapids/counter.json       |    2 +-
>  .../arch/x86/graniterapids/frontend.json      |   24 +-
>  .../arch/x86/graniterapids/gnr-metrics.json   | 2311 +++++++++
>  .../arch/x86/graniterapids/memory.json        |  121 +-
>  .../arch/x86/graniterapids/metricgroups.json  |  145 +
>  .../arch/x86/graniterapids/other.json         |   99 +
>  .../arch/x86/graniterapids/pipeline.json      |   40 +-
>  .../arch/x86/graniterapids/uncore-cache.json  |   14 +-
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
>  .../arch/x86/icelake/icl-metrics.json         |  849 +--
>  .../pmu-events/arch/x86/icelake/memory.json   |   13 +-
>  .../arch/x86/icelake/metricgroups.json        |   10 +-
>  .../pmu-events/arch/x86/icelake/pipeline.json |   30 +-
>  .../arch/x86/icelake/uncore-interconnect.json |   76 -
>  .../arch/x86/icelake/uncore-other.json        |    2 +-
>  .../arch/x86/icelake/virtual-memory.json      |   18 +
>  .../pmu-events/arch/x86/icelakex/cache.json   |   41 +-
>  .../arch/x86/icelakex/frontend.json           |   17 -
>  .../arch/x86/icelakex/icx-metrics.json        |  852 +--
>  .../pmu-events/arch/x86/icelakex/memory.json  |   13 +-
>  .../arch/x86/icelakex/metricgroups.json       |   10 +-
>  .../arch/x86/icelakex/pipeline.json           |   30 +-
>  .../pmu-events/arch/x86/lunarlake/cache.json  | 1322 ++++-
>  .../arch/x86/lunarlake/floating-point.json    |  484 ++
>  .../arch/x86/lunarlake/frontend.json          |  654 ++-
>  .../arch/x86/lunarlake/lnl-metrics.json       | 4611 +++++++++++++++++
>  .../pmu-events/arch/x86/lunarlake/memory.json |  262 +-
>  .../arch/x86/lunarlake/metricgroups.json      |  150 +
>  .../pmu-events/arch/x86/lunarlake/other.json  |  496 +-
>  .../arch/x86/lunarlake/pipeline.json          | 2104 +++++++-
>  .../arch/x86/lunarlake/uncore-memory.json     |   18 +
>  .../arch/x86/lunarlake/virtual-memory.json    |  428 ++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   42 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json |  109 +-
>  .../arch/x86/meteorlake/frontend.json         |   30 +-
>  .../arch/x86/meteorlake/memory.json           |   22 +-
>  .../arch/x86/meteorlake/metricgroups.json     |   10 +-
>  .../arch/x86/meteorlake/mtl-metrics.json      | 3818 +++++++++++---
>  .../pmu-events/arch/x86/meteorlake/other.json |   54 +
>  .../arch/x86/meteorlake/pipeline.json         |   89 +-
>  .../pmu-events/arch/x86/rocketlake/cache.json |   34 +-
>  .../arch/x86/rocketlake/frontend.json         |   17 -
>  .../arch/x86/rocketlake/memory.json           |   13 +-
>  .../arch/x86/rocketlake/metricgroups.json     |   10 +-
>  .../arch/x86/rocketlake/pipeline.json         |   30 +-
>  .../arch/x86/rocketlake/rkl-metrics.json      |  849 +--
>  .../x86/rocketlake/uncore-interconnect.json   |   10 -
>  .../arch/x86/rocketlake/uncore-other.json     |    2 +-
>  .../arch/x86/rocketlake/virtual-memory.json   |   18 +
>  .../arch/x86/sapphirerapids/cache.json        |   30 +-
>  .../arch/x86/sapphirerapids/frontend.json     |   19 -
>  .../arch/x86/sapphirerapids/memory.json       |   15 +-
>  .../arch/x86/sapphirerapids/metricgroups.json |   10 +-
>  .../arch/x86/sapphirerapids/pipeline.json     |   23 -
>  .../arch/x86/sapphirerapids/spr-metrics.json  |  968 ++--
>  .../arch/x86/sapphirerapids/uncore-io.json    |  138 +-
>  .../arch/x86/sierraforest/counter.json        |    2 +-
>  .../arch/x86/sierraforest/other.json          |   20 +
>  .../arch/x86/sierraforest/pipeline.json       |    3 +-
>  .../arch/x86/sierraforest/srf-metrics.json    |  308 +-
>  .../arch/x86/sierraforest/uncore-cache.json   |   28 +-
>  .../x86/sierraforest/uncore-interconnect.json |   87 +
>  .../arch/x86/sierraforest/uncore-io.json      |  280 +-
>  .../arch/x86/sierraforest/uncore-memory.json  |  122 +-
>  .../arch/x86/sierraforest/uncore-power.json   |   98 +
>  .../arch/x86/skylake/metricgroups.json        |    9 +-
>  .../arch/x86/skylake/skl-metrics.json         |  684 ++-
>  .../arch/x86/skylakex/metricgroups.json       |    9 +-
>  .../arch/x86/skylakex/skx-metrics.json        |  740 +--
>  .../arch/x86/skylakex/uncore-cache.json       |   60 +-
>  .../x86/skylakex/uncore-interconnect.json     |   11 -
>  .../pmu-events/arch/x86/tigerlake/cache.json  |   45 +-
>  .../arch/x86/tigerlake/frontend.json          |   17 -
>  .../pmu-events/arch/x86/tigerlake/memory.json |   13 +-
>  .../arch/x86/tigerlake/metricgroups.json      |   10 +-
>  .../arch/x86/tigerlake/pipeline.json          |   30 +-
>  .../arch/x86/tigerlake/tgl-metrics.json       |  745 +--
>  .../x86/tigerlake/uncore-interconnect.json    |    4 +-
>  .../arch/x86/tigerlake/uncore-other.json      |    2 +-
>  .../arch/x86/tigerlake/virtual-memory.json    |   18 +
>  169 files changed, 38371 insertions(+), 8097 deletions(-)
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
>  create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-other.json
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

