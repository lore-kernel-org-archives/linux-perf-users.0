Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D913D528;
	Tue, 18 Jun 2024 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718648; cv=none; b=GsogldADWA9LA6vWh3vNJK2QkpXlIeSrKuEH1ZF8MID0j1QLpNBwyOyjtx9EOXAwVn6PYUobGX0En2mMiS7H436rhRy0wk8vxTR99+/yYxOlKqCsgibsfhtnOkJtKd4nz3n1fy/ePJRBmEqX8uoGikReDxsx4JsUrV9c1aMcmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718648; c=relaxed/simple;
	bh=LU15fUddMM3dUbDdB7NcHg9JIBLooP3bVfUs3el0e+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xcga9cf0LOib5xRyPeca2F6knEvejCwx659yBhheqyfgZJYyRVZW3VfzYbt1RrX+xyAa9+fiBGzzowK3PCBGlasMr+y32awCw7d5uL6zjRglJlh+bh0rzx2yDF5oiJ/5wbiQ741hXkmtX/aptJVGb5OFVE2sc4+bTt5gUX2Kro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbYQiPbN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbYQiPbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718718646; x=1750254646;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LU15fUddMM3dUbDdB7NcHg9JIBLooP3bVfUs3el0e+s=;
  b=NbYQiPbNBRG/gE7HeMF5U9QbH20QQrsywlJOFQ5D1k+aR91th18XCLJf
   fuEfvFzCmYMgbB3FwjlxGjLzgGbmSk2lRsP2zEnMDDlFT+dojYn4Mkyk+
   ZSyGBuOPqU79zWP6BLncnuw9hRxrLeqQIJXb3hOUkvsZxKddVRjJ0XsGu
   tqAaVtaBFWYESYJpDXU0PdLEeC68LmncFLInHOJszULoqIR5Qr44yVVpy
   GwzOypeqpIHmgHZLK/tEANznAIy7VxdbjzUPoXIgL6wbrLeT8uY1/aBUS
   NJtqB6T4d75TJBlGiglqVvt9B4xwPRP+UtLtnUzqRViNn9hneEM9CJvlY
   g==;
X-CSE-ConnectionGUID: cqOR8yZeSuSr03mw4li+wQ==
X-CSE-MsgGUID: CAqK7vooS0Og49dXEBqV7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="27012318"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="27012318"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:50:45 -0700
X-CSE-ConnectionGUID: siiZ+cgIQtCyQv/3s+at0A==
X-CSE-MsgGUID: 6uJ8wVlDTU+bv8nXrWH+Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41402451"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:50:45 -0700
Received: from [10.212.26.15] (kliang2-mobl1.ccr.corp.intel.com [10.212.26.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 09C2F20B5703;
	Tue, 18 Jun 2024 06:50:42 -0700 (PDT)
Message-ID: <6f7c0793-ad1d-4778-9174-b9cb37cb9829@linux.intel.com>
Date: Tue, 18 Jun 2024 09:50:41 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/37] Update Intel perf vendor events
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Weilin Wang <weilin.wang@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>
References: <20240614230146.3783221-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240614230146.3783221-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-14 7:01 p.m., Ian Rogers wrote:
> Update Intel perf vendor events from:
> https://github.com/intel/perfmon
> Adds new events and updates TMA metrics to v4.8.
> Add counter and experimental event tags.
> 
> Co-authored-by: Weilin Wang <weilin.wang@intel.com>
> Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
>

Except the typo, the rest looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> Ian Rogers (37):
>   perf vendor events: Update alderlake events/metrics
>   perf vendor events: Update alderlaken events/metrics
>   perf vendor events: Add bonnell counter information
>   perf vendor events: Update broadwell metrics add event counter
>     information
>   perf vendor events: Update broadwellde metrics add event counter
>     information
>   perf vendor events: Update broadwellx metrics add event counter
>     information
>   perf vendor events: Update cascadelakex events/metrics
>   perf vendor events: Update elkhartlake events
>   perf vendor events: Add/update emeraldrapids events/metrics
>   perf vendor events: Add goldmont counter information
>   perf vendor events: Add goldmontplus counter information
>   perf vendor events: Update/add grandridge events/metrics
>   perf vendor events: Update grandridge events and add counter
>     information
>   perf vendor events: Add haswell counter information
>   perf vendor events: Update haswellx metrics add event counter
>     information
>   perf vendor events: Add/update icelake events/metrics
>   perf vendor events: Add/update icelakex events/metrics
>   perf vendor events: Update ivybridge metrics add event counter
>     information
>   perf vendor events: Update ivytown metrics add event counter
>     information
>   perf vendor events: Update jaketown metrics add event counter
>     information
>   perf vendor events: Add knightslanding counter information
>   perf vendor events: Add lunarlake counter information
>   perf vendor events: Update meteorlake events and add counter
>     information
>   perf vendor events: Add nehalemep counter information
>   perf vendor events: Add nehalemex counter information
>   perf vendor events: Add/update rocketlake events/metrics
>   perf vendor events: Update sandybridge metrics add event counter
>     information
>   perf vendor events: Add/update sapphirerapids events/metrics
>   perf vendor events: Add/update sierraforest events/metrics
>   perf vendor events: Add silvermont counter information
>   perf vendor events: Add/update skylake events/metrics
>   perf vendor events: Add/update skylakex events/metrics
>   perf vendor events: Add snowridgex counter information
>   perf vendor events: Add/update tigerlake events/metrics
>   perf vendor events: Add westmereep-dp counter information
>   perf vendor events: Add westmereep-sp counter information
>   perf vendor events: Add westmereex counter information
> 
>  .../arch/x86/alderlake/adl-metrics.json       |  988 +++--
>  .../pmu-events/arch/x86/alderlake/cache.json  |  184 +-
>  .../arch/x86/alderlake/floating-point.json    |   20 +
>  .../arch/x86/alderlake/frontend.json          |   56 +-
>  .../pmu-events/arch/x86/alderlake/memory.json |   44 +
>  .../arch/x86/alderlake/metricgroups.json      |   23 +-
>  .../pmu-events/arch/x86/alderlake/other.json  |   37 +
>  .../arch/x86/alderlake/pipeline.json          |  214 +
>  .../x86/alderlake/uncore-interconnect.json    |   19 +
>  .../arch/x86/alderlake/uncore-memory.json     |   25 +
>  .../arch/x86/alderlake/uncore-other.json      |    1 +
>  .../arch/x86/alderlake/virtual-memory.json    |   26 +
>  .../arch/x86/alderlaken/adln-metrics.json     |  658 ++-
>  .../pmu-events/arch/x86/alderlaken/cache.json |   50 +-
>  .../arch/x86/alderlaken/floating-point.json   |    2 +
>  .../arch/x86/alderlaken/frontend.json         |    3 +
>  .../arch/x86/alderlaken/memory.json           |   11 +
>  .../arch/x86/alderlaken/metricgroups.json     |   21 +-
>  .../pmu-events/arch/x86/alderlaken/other.json |   13 +
>  .../arch/x86/alderlaken/pipeline.json         |   80 +
>  .../x86/alderlaken/uncore-interconnect.json   |   19 +
>  .../arch/x86/alderlaken/uncore-memory.json    |   25 +
>  .../arch/x86/alderlaken/uncore-other.json     |    1 +
>  .../arch/x86/alderlaken/virtual-memory.json   |    6 +
>  .../pmu-events/arch/x86/bonnell/cache.json    |   93 +
>  .../pmu-events/arch/x86/bonnell/counter.json  |    7 +
>  .../arch/x86/bonnell/floating-point.json      |   32 +
>  .../pmu-events/arch/x86/bonnell/frontend.json |   11 +
>  .../pmu-events/arch/x86/bonnell/memory.json   |   19 +
>  .../pmu-events/arch/x86/bonnell/other.json    |   56 +
>  .../pmu-events/arch/x86/bonnell/pipeline.json |   44 +
>  .../arch/x86/bonnell/virtual-memory.json      |   15 +
>  .../arch/x86/broadwell/bdw-metrics.json       |   80 +-
>  .../pmu-events/arch/x86/broadwell/cache.json  |  275 ++
>  .../arch/x86/broadwell/counter.json           |   22 +
>  .../arch/x86/broadwell/floating-point.json    |   22 +
>  .../arch/x86/broadwell/frontend.json          |   28 +
>  .../pmu-events/arch/x86/broadwell/memory.json |  240 ++
>  .../arch/x86/broadwell/metricgroups.json      |   11 +
>  .../pmu-events/arch/x86/broadwell/other.json  |    4 +
>  .../arch/x86/broadwell/pipeline.json          |  137 +
>  .../arch/x86/broadwell/uncore-cache.json      |   24 +
>  .../x86/broadwell/uncore-interconnect.json    |    7 +
>  .../arch/x86/broadwell/uncore-other.json      |   10 -
>  .../arch/x86/broadwell/virtual-memory.json    |   38 +
>  .../arch/x86/broadwellde/bdwde-metrics.json   |   80 +-
>  .../arch/x86/broadwellde/cache.json           |   76 +
>  .../arch/x86/broadwellde/counter.json         |   42 +
>  .../arch/x86/broadwellde/floating-point.json  |   22 +
>  .../arch/x86/broadwellde/frontend.json        |   28 +
>  .../arch/x86/broadwellde/memory.json          |   39 +
>  .../arch/x86/broadwellde/metricgroups.json    |   11 +
>  .../arch/x86/broadwellde/other.json           |    4 +
>  .../arch/x86/broadwellde/pipeline.json        |  137 +
>  .../arch/x86/broadwellde/uncore-cache.json    |  382 ++
>  .../x86/broadwellde/uncore-interconnect.json  |   70 +
>  .../arch/x86/broadwellde/uncore-io.json       |   62 +
>  .../arch/x86/broadwellde/uncore-memory.json   |  322 ++
>  .../arch/x86/broadwellde/uncore-power.json    |   57 +
>  .../arch/x86/broadwellde/virtual-memory.json  |   38 +
>  .../arch/x86/broadwellx/bdx-metrics.json      |  128 +-
>  .../pmu-events/arch/x86/broadwellx/cache.json |   88 +
>  .../arch/x86/broadwellx/counter.json          |   57 +
>  .../arch/x86/broadwellx/floating-point.json   |   22 +
>  .../arch/x86/broadwellx/frontend.json         |   28 +
>  .../arch/x86/broadwellx/memory.json           |   58 +
>  .../arch/x86/broadwellx/metricgroups.json     |   11 +
>  .../pmu-events/arch/x86/broadwellx/other.json |    4 +
>  .../arch/x86/broadwellx/pipeline.json         |  137 +
>  .../arch/x86/broadwellx/uncore-cache.json     |  399 ++
>  .../x86/broadwellx/uncore-interconnect.json   |  454 ++
>  .../arch/x86/broadwellx/uncore-io.json        |   62 +
>  .../arch/x86/broadwellx/uncore-memory.json    |  326 ++
>  .../arch/x86/broadwellx/uncore-power.json     |   57 +
>  .../arch/x86/broadwellx/virtual-memory.json   |   38 +
>  .../arch/x86/cascadelakex/cache.json          | 1245 ++++++
>  .../arch/x86/cascadelakex/clx-metrics.json    |  310 +-
>  .../arch/x86/cascadelakex/counter.json        |   52 +
>  .../arch/x86/cascadelakex/floating-point.json |   16 +
>  .../arch/x86/cascadelakex/frontend.json       |   49 +
>  .../arch/x86/cascadelakex/memory.json         |  743 ++++
>  .../arch/x86/cascadelakex/metricgroups.json   |   13 +
>  .../arch/x86/cascadelakex/other.json          |  168 +
>  .../arch/x86/cascadelakex/pipeline.json       |  104 +-
>  .../arch/x86/cascadelakex/uncore-cache.json   | 2293 ++++++++++
>  .../x86/cascadelakex/uncore-interconnect.json | 2536 ++++++++++++
>  .../arch/x86/cascadelakex/uncore-io.json      |  703 ++++
>  .../arch/x86/cascadelakex/uncore-memory.json  |  985 +++++
>  .../arch/x86/cascadelakex/uncore-power.json   |   50 +
>  .../arch/x86/cascadelakex/virtual-memory.json |   28 +
>  .../arch/x86/elkhartlake/cache.json           |  101 +
>  .../arch/x86/elkhartlake/counter.json         |    7 +
>  .../arch/x86/elkhartlake/floating-point.json  |    3 +
>  .../arch/x86/elkhartlake/frontend.json        |    9 +
>  .../arch/x86/elkhartlake/memory.json          |   40 +
>  .../arch/x86/elkhartlake/other.json           |   61 +
>  .../arch/x86/elkhartlake/pipeline.json        |   60 +
>  .../arch/x86/elkhartlake/virtual-memory.json  |   31 +
>  .../arch/x86/emeraldrapids/cache.json         |  159 +-
>  .../arch/x86/emeraldrapids/counter.json       |   82 +
>  .../arch/x86/emeraldrapids/emr-metrics.json   | 2186 ++++++++++
>  .../x86/emeraldrapids/floating-point.json     |   28 +
>  .../arch/x86/emeraldrapids/frontend.json      |   50 +
>  .../arch/x86/emeraldrapids/memory.json        |   50 +
>  .../arch/x86/emeraldrapids/metricgroups.json  |  137 +
>  .../arch/x86/emeraldrapids/other.json         |   43 +
>  .../arch/x86/emeraldrapids/pipeline.json      |  133 +
>  .../arch/x86/emeraldrapids/uncore-cache.json  | 1288 ++++++
>  .../arch/x86/emeraldrapids/uncore-cxl.json    |  110 +
>  .../emeraldrapids/uncore-interconnect.json    | 1427 +++++++
>  .../arch/x86/emeraldrapids/uncore-io.json     |  743 ++++
>  .../arch/x86/emeraldrapids/uncore-memory.json |  742 ++++
>  .../arch/x86/emeraldrapids/uncore-power.json  |   49 +
>  .../x86/emeraldrapids/virtual-memory.json     |   20 +
>  .../pmu-events/arch/x86/goldmont/cache.json   |  103 +
>  .../pmu-events/arch/x86/goldmont/counter.json |    7 +
>  .../arch/x86/goldmont/floating-point.json     |    3 +
>  .../arch/x86/goldmont/frontend.json           |    8 +
>  .../pmu-events/arch/x86/goldmont/memory.json  |    3 +
>  .../pmu-events/arch/x86/goldmont/other.json   |    5 +
>  .../arch/x86/goldmont/pipeline.json           |   40 +
>  .../arch/x86/goldmont/virtual-memory.json     |    7 +
>  .../arch/x86/goldmontplus/cache.json          |  101 +
>  .../arch/x86/goldmontplus/counter.json        |    7 +
>  .../arch/x86/goldmontplus/floating-point.json |    3 +
>  .../arch/x86/goldmontplus/frontend.json       |    8 +
>  .../arch/x86/goldmontplus/memory.json         |    3 +
>  .../arch/x86/goldmontplus/other.json          |    5 +
>  .../arch/x86/goldmontplus/pipeline.json       |   42 +
>  .../arch/x86/goldmontplus/virtual-memory.json |   18 +
>  .../pmu-events/arch/x86/grandridge/cache.json |   97 +-
>  .../arch/x86/grandridge/counter.json          |   42 +
>  .../arch/x86/grandridge/floating-point.json   |   54 +-
>  .../arch/x86/grandridge/frontend.json         |    5 +-
>  .../arch/x86/grandridge/grr-metrics.json      |  849 ++++
>  .../arch/x86/grandridge/memory.json           |   13 +-
>  .../arch/x86/grandridge/metricgroups.json     |   23 +
>  .../pmu-events/arch/x86/grandridge/other.json |   15 +-
>  .../arch/x86/grandridge/pipeline.json         |   97 +-
>  .../arch/x86/grandridge/uncore-cache.json     |  267 ++
>  .../x86/grandridge/uncore-interconnect.json   |   30 +
>  .../arch/x86/grandridge/uncore-io.json        |  181 +
>  .../arch/x86/grandridge/uncore-memory.json    |   66 +
>  .../arch/x86/grandridge/uncore-power.json     |    1 +
>  .../arch/x86/grandridge/virtual-memory.json   |   17 +
>  .../arch/x86/graniterapids/cache.json         |  825 ++++
>  .../arch/x86/graniterapids/counter.json       |   77 +
>  .../x86/graniterapids/floating-point.json     |  242 ++
>  .../arch/x86/graniterapids/frontend.json      |  469 ++-
>  .../arch/x86/graniterapids/memory.json        |  175 +-
>  .../arch/x86/graniterapids/other.json         |  150 +-
>  .../arch/x86/graniterapids/pipeline.json      | 1009 ++++-
>  .../arch/x86/graniterapids/uncore-cache.json  | 3674 +++++++++++++++++
>  .../arch/x86/graniterapids/uncore-cxl.json    |   31 +
>  .../graniterapids/uncore-interconnect.json    | 1849 +++++++++
>  .../arch/x86/graniterapids/uncore-io.json     | 1901 +++++++++
>  .../arch/x86/graniterapids/uncore-memory.json |  449 ++
>  .../arch/x86/graniterapids/uncore-power.json  |   11 +
>  .../x86/graniterapids/virtual-memory.json     |  159 +
>  .../pmu-events/arch/x86/haswell/cache.json    |   94 +
>  .../pmu-events/arch/x86/haswell/counter.json  |   22 +
>  .../arch/x86/haswell/floating-point.json      |   10 +
>  .../pmu-events/arch/x86/haswell/frontend.json |   29 +
>  .../arch/x86/haswell/hsw-metrics.json         |   66 +-
>  .../pmu-events/arch/x86/haswell/memory.json   |   60 +
>  .../arch/x86/haswell/metricgroups.json        |   11 +
>  .../pmu-events/arch/x86/haswell/other.json    |    4 +
>  .../pmu-events/arch/x86/haswell/pipeline.json |  130 +
>  .../arch/x86/haswell/uncore-cache.json        |   33 +
>  .../arch/x86/haswell/uncore-interconnect.json |    6 +
>  .../arch/x86/haswell/uncore-other.json        |    1 +
>  .../arch/x86/haswell/virtual-memory.json      |   49 +
>  .../pmu-events/arch/x86/haswellx/cache.json   |   97 +
>  .../pmu-events/arch/x86/haswellx/counter.json |   57 +
>  .../arch/x86/haswellx/floating-point.json     |   10 +
>  .../arch/x86/haswellx/frontend.json           |   29 +
>  .../arch/x86/haswellx/hsx-metrics.json        |  114 +-
>  .../pmu-events/arch/x86/haswellx/memory.json  |   67 +
>  .../arch/x86/haswellx/metricgroups.json       |   11 +
>  .../pmu-events/arch/x86/haswellx/other.json   |    4 +
>  .../arch/x86/haswellx/pipeline.json           |  130 +
>  .../arch/x86/haswellx/uncore-cache.json       |  398 ++
>  .../x86/haswellx/uncore-interconnect.json     |  448 ++
>  .../arch/x86/haswellx/uncore-io.json          |   59 +
>  .../arch/x86/haswellx/uncore-memory.json      |  325 ++
>  .../arch/x86/haswellx/uncore-power.json       |   62 +
>  .../arch/x86/haswellx/virtual-memory.json     |   49 +
>  .../pmu-events/arch/x86/icelake/cache.json    |  109 +
>  .../pmu-events/arch/x86/icelake/counter.json  |   17 +
>  .../arch/x86/icelake/floating-point.json      |   13 +
>  .../pmu-events/arch/x86/icelake/frontend.json |   41 +-
>  .../arch/x86/icelake/icl-metrics.json         |  308 +-
>  .../pmu-events/arch/x86/icelake/memory.json   |   44 +
>  .../arch/x86/icelake/metricgroups.json        |   13 +
>  .../pmu-events/arch/x86/icelake/other.json    |   27 +
>  .../pmu-events/arch/x86/icelake/pipeline.json |   94 +
>  .../arch/x86/icelake/uncore-interconnect.json |   34 +-
>  .../arch/x86/icelake/uncore-other.json        |    1 +
>  .../arch/x86/icelake/virtual-memory.json      |   20 +
>  .../pmu-events/arch/x86/icelakex/cache.json   |  106 +
>  .../pmu-events/arch/x86/icelakex/counter.json |   57 +
>  .../arch/x86/icelakex/floating-point.json     |   13 +
>  .../arch/x86/icelakex/frontend.json           |   38 +
>  .../arch/x86/icelakex/icx-metrics.json        |  340 +-
>  .../pmu-events/arch/x86/icelakex/memory.json  |   45 +
>  .../arch/x86/icelakex/metricgroups.json       |   13 +
>  .../pmu-events/arch/x86/icelakex/other.json   |   52 +
>  .../arch/x86/icelakex/pipeline.json           |   92 +
>  .../arch/x86/icelakex/uncore-cache.json       | 2149 +++++++++-
>  .../x86/icelakex/uncore-interconnect.json     | 3344 +++++++++++++++
>  .../arch/x86/icelakex/uncore-io.json          | 1829 ++++++++
>  .../arch/x86/icelakex/uncore-memory.json      |  338 ++
>  .../arch/x86/icelakex/uncore-power.json       |   51 +
>  .../arch/x86/icelakex/virtual-memory.json     |   22 +
>  .../pmu-events/arch/x86/ivybridge/cache.json  |  104 +
>  .../arch/x86/ivybridge/counter.json           |   17 +
>  .../arch/x86/ivybridge/floating-point.json    |   17 +
>  .../arch/x86/ivybridge/frontend.json          |   30 +
>  .../arch/x86/ivybridge/ivb-metrics.json       |   68 +-
>  .../pmu-events/arch/x86/ivybridge/memory.json |   19 +
>  .../arch/x86/ivybridge/metricgroups.json      |   11 +
>  .../pmu-events/arch/x86/ivybridge/other.json  |    4 +
>  .../arch/x86/ivybridge/pipeline.json          |  126 +
>  .../arch/x86/ivybridge/uncore-cache.json      |   25 +
>  .../x86/ivybridge/uncore-interconnect.json    |    9 +
>  .../arch/x86/ivybridge/virtual-memory.json    |   18 +
>  .../pmu-events/arch/x86/ivytown/cache.json    |  118 +
>  .../pmu-events/arch/x86/ivytown/counter.json  |   52 +
>  .../arch/x86/ivytown/floating-point.json      |   17 +
>  .../pmu-events/arch/x86/ivytown/frontend.json |   30 +
>  .../arch/x86/ivytown/ivt-metrics.json         |   68 +-
>  .../pmu-events/arch/x86/ivytown/memory.json   |   41 +
>  .../arch/x86/ivytown/metricgroups.json        |   11 +
>  .../pmu-events/arch/x86/ivytown/other.json    |    4 +
>  .../pmu-events/arch/x86/ivytown/pipeline.json |  126 +
>  .../arch/x86/ivytown/uncore-cache.json        |  349 ++
>  .../arch/x86/ivytown/uncore-interconnect.json |  385 ++
>  .../arch/x86/ivytown/uncore-io.json           |   61 +
>  .../arch/x86/ivytown/uncore-memory.json       |  198 +
>  .../arch/x86/ivytown/uncore-power.json        |   74 +
>  .../arch/x86/ivytown/virtual-memory.json      |   20 +
>  .../pmu-events/arch/x86/jaketown/cache.json   |  123 +
>  .../pmu-events/arch/x86/jaketown/counter.json |   52 +
>  .../arch/x86/jaketown/floating-point.json     |   15 +
>  .../arch/x86/jaketown/frontend.json           |   32 +
>  .../arch/x86/jaketown/jkt-metrics.json        |   24 +-
>  .../pmu-events/arch/x86/jaketown/memory.json  |   35 +
>  .../arch/x86/jaketown/metricgroups.json       |   11 +
>  .../pmu-events/arch/x86/jaketown/other.json   |    6 +
>  .../arch/x86/jaketown/pipeline.json           |  127 +
>  .../arch/x86/jaketown/uncore-cache.json       |  205 +
>  .../x86/jaketown/uncore-interconnect.json     |  207 +
>  .../arch/x86/jaketown/uncore-io.json          |   36 +
>  .../arch/x86/jaketown/uncore-memory.json      |   51 +
>  .../arch/x86/jaketown/uncore-power.json       |   39 +
>  .../arch/x86/jaketown/virtual-memory.json     |   16 +
>  .../arch/x86/knightslanding/cache.json        |  213 +
>  .../arch/x86/knightslanding/counter.json      |   37 +
>  .../x86/knightslanding/floating-point.json    |    3 +
>  .../arch/x86/knightslanding/frontend.json     |    7 +
>  .../arch/x86/knightslanding/memory.json       |  101 +
>  .../arch/x86/knightslanding/pipeline.json     |   45 +
>  .../arch/x86/knightslanding/uncore-cache.json |  421 ++
>  .../arch/x86/knightslanding/uncore-io.json    |   24 +
>  .../x86/knightslanding/uncore-memory.json     |   14 +
>  .../x86/knightslanding/virtual-memory.json    |    7 +
>  .../pmu-events/arch/x86/lunarlake/cache.json  |   20 +
>  .../arch/x86/lunarlake/frontend.json          |    3 +
>  .../pmu-events/arch/x86/lunarlake/memory.json |   15 +
>  .../pmu-events/arch/x86/lunarlake/other.json  |    6 +
>  .../arch/x86/lunarlake/pipeline.json          |   36 +
>  .../arch/x86/lunarlake/virtual-memory.json    |    6 +
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   34 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json |  223 +-
>  .../arch/x86/meteorlake/floating-point.json   |   86 +-
>  .../arch/x86/meteorlake/frontend.json         |   69 +-
>  .../arch/x86/meteorlake/memory.json           |   62 +-
>  .../pmu-events/arch/x86/meteorlake/other.json |   19 +-
>  .../arch/x86/meteorlake/pipeline.json         |  300 +-
>  .../arch/x86/meteorlake/uncore-cache.json     |    2 +
>  .../x86/meteorlake/uncore-interconnect.json   |    8 +
>  .../arch/x86/meteorlake/uncore-memory.json    |   16 +
>  .../arch/x86/meteorlake/uncore-other.json     |    1 +
>  .../arch/x86/meteorlake/virtual-memory.json   |   37 +
>  .../pmu-events/arch/x86/nehalemep/cache.json  |  320 ++
>  .../arch/x86/nehalemep/counter.json           |    7 +
>  .../arch/x86/nehalemep/floating-point.json    |   28 +
>  .../arch/x86/nehalemep/frontend.json          |    3 +
>  .../pmu-events/arch/x86/nehalemep/memory.json |   67 +
>  .../pmu-events/arch/x86/nehalemep/other.json  |   18 +
>  .../arch/x86/nehalemep/pipeline.json          |  109 +
>  .../arch/x86/nehalemep/virtual-memory.json    |   13 +
>  .../pmu-events/arch/x86/nehalemex/cache.json  |  315 ++
>  .../arch/x86/nehalemex/counter.json           |    7 +
>  .../arch/x86/nehalemex/floating-point.json    |   28 +
>  .../arch/x86/nehalemex/frontend.json          |    3 +
>  .../pmu-events/arch/x86/nehalemex/memory.json |   67 +
>  .../pmu-events/arch/x86/nehalemex/other.json  |   18 +
>  .../arch/x86/nehalemex/pipeline.json          |  109 +
>  .../arch/x86/nehalemex/virtual-memory.json    |   13 +
>  .../pmu-events/arch/x86/rocketlake/cache.json |  109 +
>  .../arch/x86/rocketlake/counter.json          |   17 +
>  .../arch/x86/rocketlake/floating-point.json   |   13 +
>  .../arch/x86/rocketlake/frontend.json         |   41 +-
>  .../arch/x86/rocketlake/memory.json           |   44 +
>  .../arch/x86/rocketlake/metricgroups.json     |   13 +
>  .../pmu-events/arch/x86/rocketlake/other.json |   27 +
>  .../arch/x86/rocketlake/pipeline.json         |   94 +
>  .../arch/x86/rocketlake/rkl-metrics.json      |  308 +-
>  .../x86/rocketlake/uncore-interconnect.json   |   28 +-
>  .../arch/x86/rocketlake/uncore-other.json     |    1 +
>  .../arch/x86/rocketlake/virtual-memory.json   |   20 +
>  .../arch/x86/sandybridge/cache.json           |  173 +
>  .../arch/x86/sandybridge/counter.json         |   17 +
>  .../arch/x86/sandybridge/floating-point.json  |   15 +
>  .../arch/x86/sandybridge/frontend.json        |   32 +
>  .../arch/x86/sandybridge/memory.json          |   37 +
>  .../arch/x86/sandybridge/metricgroups.json    |   11 +
>  .../arch/x86/sandybridge/other.json           |    6 +
>  .../arch/x86/sandybridge/pipeline.json        |  128 +
>  .../arch/x86/sandybridge/snb-metrics.json     |   24 +-
>  .../arch/x86/sandybridge/uncore-cache.json    |   25 +
>  .../x86/sandybridge/uncore-interconnect.json  |    9 +
>  .../arch/x86/sandybridge/virtual-memory.json  |   16 +
>  .../arch/x86/sapphirerapids/cache.json        |  161 +-
>  .../arch/x86/sapphirerapids/counter.json      |   82 +
>  .../x86/sapphirerapids/floating-point.json    |   28 +
>  .../arch/x86/sapphirerapids/frontend.json     |   50 +
>  .../arch/x86/sapphirerapids/memory.json       |   50 +
>  .../arch/x86/sapphirerapids/metricgroups.json |   13 +
>  .../arch/x86/sapphirerapids/other.json        |   48 +
>  .../arch/x86/sapphirerapids/pipeline.json     |  133 +
>  .../arch/x86/sapphirerapids/spr-metrics.json  |  411 +-
>  .../arch/x86/sapphirerapids/uncore-cache.json | 1244 ++++++
>  .../arch/x86/sapphirerapids/uncore-cxl.json   |  110 +
>  .../sapphirerapids/uncore-interconnect.json   | 1427 +++++++
>  .../arch/x86/sapphirerapids/uncore-io.json    |  679 +++
>  .../x86/sapphirerapids/uncore-memory.json     |  742 ++++
>  .../arch/x86/sapphirerapids/uncore-power.json |   49 +
>  .../x86/sapphirerapids/virtual-memory.json    |   20 +
>  .../arch/x86/sierraforest/cache.json          |   97 +-
>  .../arch/x86/sierraforest/counter.json        |   77 +
>  .../arch/x86/sierraforest/floating-point.json |   54 +-
>  .../arch/x86/sierraforest/frontend.json       |    5 +-
>  .../arch/x86/sierraforest/memory.json         |   13 +-
>  .../arch/x86/sierraforest/metricgroups.json   |   23 +
>  .../arch/x86/sierraforest/other.json          |   15 +-
>  .../arch/x86/sierraforest/pipeline.json       |   97 +-
>  .../arch/x86/sierraforest/srf-metrics.json    |  927 +++++
>  .../arch/x86/sierraforest/uncore-cache.json   |  549 ++-
>  .../arch/x86/sierraforest/uncore-cxl.json     |   21 +
>  .../x86/sierraforest/uncore-interconnect.json |  267 ++
>  .../arch/x86/sierraforest/uncore-io.json      |  267 ++
>  .../arch/x86/sierraforest/uncore-memory.json  |   66 +
>  .../arch/x86/sierraforest/uncore-power.json   |    1 +
>  .../arch/x86/sierraforest/virtual-memory.json |   17 +
>  .../pmu-events/arch/x86/silvermont/cache.json |   77 +
>  .../arch/x86/silvermont/counter.json          |    7 +
>  .../arch/x86/silvermont/floating-point.json   |    1 +
>  .../arch/x86/silvermont/frontend.json         |    8 +
>  .../arch/x86/silvermont/memory.json           |    1 +
>  .../pmu-events/arch/x86/silvermont/other.json |    2 +
>  .../arch/x86/silvermont/pipeline.json         |   34 +
>  .../arch/x86/silvermont/virtual-memory.json   |    7 +
>  .../pmu-events/arch/x86/skylake/cache.json    |  250 ++
>  .../pmu-events/arch/x86/skylake/counter.json  |   22 +
>  .../arch/x86/skylake/floating-point.json      |   10 +
>  .../pmu-events/arch/x86/skylake/frontend.json |   49 +
>  .../pmu-events/arch/x86/skylake/memory.json   |  131 +
>  .../arch/x86/skylake/metricgroups.json        |   13 +
>  .../pmu-events/arch/x86/skylake/other.json    |    2 +
>  .../pmu-events/arch/x86/skylake/pipeline.json |  103 +-
>  .../arch/x86/skylake/skl-metrics.json         |  196 +-
>  .../arch/x86/skylake/uncore-cache.json        |   23 +
>  .../arch/x86/skylake/uncore-interconnect.json |    8 +
>  .../arch/x86/skylake/uncore-other.json        |   10 -
>  .../arch/x86/skylake/virtual-memory.json      |   28 +
>  .../pmu-events/arch/x86/skylakex/cache.json   |  155 +
>  .../pmu-events/arch/x86/skylakex/counter.json |   52 +
>  .../arch/x86/skylakex/floating-point.json     |   13 +
>  .../arch/x86/skylakex/frontend.json           |   49 +
>  .../pmu-events/arch/x86/skylakex/memory.json  |  115 +
>  .../arch/x86/skylakex/metricgroups.json       |   13 +
>  .../pmu-events/arch/x86/skylakex/other.json   |   15 +
>  .../arch/x86/skylakex/pipeline.json           |  104 +-
>  .../arch/x86/skylakex/skx-metrics.json        |  310 +-
>  .../arch/x86/skylakex/uncore-cache.json       | 2274 ++++++++++
>  .../x86/skylakex/uncore-interconnect.json     | 2521 +++++++++++
>  .../arch/x86/skylakex/uncore-io.json          |  703 ++++
>  .../arch/x86/skylakex/uncore-memory.json      |  804 ++++
>  .../arch/x86/skylakex/uncore-power.json       |   50 +
>  .../arch/x86/skylakex/virtual-memory.json     |   28 +
>  .../pmu-events/arch/x86/snowridgex/cache.json |  101 +
>  .../arch/x86/snowridgex/counter.json          |   47 +
>  .../arch/x86/snowridgex/floating-point.json   |    3 +
>  .../arch/x86/snowridgex/frontend.json         |    9 +
>  .../arch/x86/snowridgex/memory.json           |   40 +
>  .../pmu-events/arch/x86/snowridgex/other.json |   61 +
>  .../arch/x86/snowridgex/pipeline.json         |   60 +
>  .../arch/x86/snowridgex/uncore-cache.json     | 1548 ++++++-
>  .../x86/snowridgex/uncore-interconnect.json   | 1403 +++++++
>  .../arch/x86/snowridgex/uncore-io.json        | 1743 ++++++++
>  .../arch/x86/snowridgex/uncore-memory.json    |  103 +
>  .../arch/x86/snowridgex/uncore-power.json     |   51 +
>  .../arch/x86/snowridgex/virtual-memory.json   |   31 +
>  .../pmu-events/arch/x86/tigerlake/cache.json  |   73 +
>  .../arch/x86/tigerlake/counter.json           |   17 +
>  .../arch/x86/tigerlake/floating-point.json    |   13 +
>  .../arch/x86/tigerlake/frontend.json          |   41 +-
>  .../pmu-events/arch/x86/tigerlake/memory.json |   24 +
>  .../arch/x86/tigerlake/metricgroups.json      |   13 +
>  .../pmu-events/arch/x86/tigerlake/other.json  |    4 +
>  .../arch/x86/tigerlake/pipeline.json          |   95 +
>  .../arch/x86/tigerlake/tgl-metrics.json       |  198 +-
>  .../x86/tigerlake/uncore-interconnect.json    |   19 +
>  .../arch/x86/tigerlake/uncore-memory.json     |    6 +
>  .../arch/x86/tigerlake/uncore-other.json      |    1 +
>  .../arch/x86/tigerlake/virtual-memory.json    |   20 +
>  .../arch/x86/westmereep-dp/cache.json         |  282 ++
>  .../arch/x86/westmereep-dp/counter.json       |    7 +
>  .../x86/westmereep-dp/floating-point.json     |   28 +
>  .../arch/x86/westmereep-dp/frontend.json      |    3 +
>  .../arch/x86/westmereep-dp/memory.json        |   69 +
>  .../arch/x86/westmereep-dp/other.json         |   28 +
>  .../arch/x86/westmereep-dp/pipeline.json      |  111 +
>  .../x86/westmereep-dp/virtual-memory.json     |   21 +
>  .../arch/x86/westmereep-sp/cache.json         |  321 ++
>  .../arch/x86/westmereep-sp/counter.json       |    7 +
>  .../x86/westmereep-sp/floating-point.json     |   28 +
>  .../arch/x86/westmereep-sp/frontend.json      |    3 +
>  .../arch/x86/westmereep-sp/memory.json        |   67 +
>  .../arch/x86/westmereep-sp/other.json         |   28 +
>  .../arch/x86/westmereep-sp/pipeline.json      |  111 +
>  .../x86/westmereep-sp/virtual-memory.json     |   18 +
>  .../pmu-events/arch/x86/westmereex/cache.json |  320 ++
>  .../arch/x86/westmereex/counter.json          |    7 +
>  .../arch/x86/westmereex/floating-point.json   |   28 +
>  .../arch/x86/westmereex/frontend.json         |    3 +
>  .../arch/x86/westmereex/memory.json           |   68 +
>  .../pmu-events/arch/x86/westmereex/other.json |   28 +
>  .../arch/x86/westmereex/pipeline.json         |  111 +
>  .../arch/x86/westmereex/virtual-memory.json   |   21 +
>  442 files changed, 76139 insertions(+), 2883 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/bonnell/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/counter.json
>  delete mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/goldmont/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-power.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/haswell/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelake/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/nehalemep/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/nehalemex/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/silvermont/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/skylake/counter.json
>  delete mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/westmereep-dp/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/westmereep-sp/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/westmereex/counter.json
> 
