Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DA3A1CF8;
	Thu, 24 Sep 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239516; cv=none; b=VvMv2sLYVSm2RJ0+4S23L5Z00VQElmUqWEdk0qfblSIeUxRUMhWGj4oWz2yF6XTcdu6bRggy7lXewUiZjz1DrUnYPkhxQLk/KARY8VW5Cc3SoBX2q70Sz++Cs34/idQvwztQXUW+BfdDReRUHLwVK9UkDTLtRl9BfoNMei+QImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239516; c=relaxed/simple;
	bh=j6G7YOQ6n+c/coe0S38Y7TX7nSF/fyiUrvHp3qQliQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CkspV7sWonHt7PeCPlAuqtWBRiEy3Q6fxe1Xe01WfMji5gZWMopoPJc7WAPwVClXtvhgYLHP+0Oy8yQiqrpd3SB+qsFdeh1r3RbjC1ERlM1ooJE4zttXOu9UnzE4aLL2kXOy2jeN8wLGAxZ2K5gakXwVZr++KmXDDdldK9nvcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dklU1spW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dklU1spW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790239513; x=1821775513;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=j6G7YOQ6n+c/coe0S38Y7TX7nSF/fyiUrvHp3qQliQs=;
  b=dklU1spWHLtHgL3IhfeKhJCsQww8QHUETkjKq8MADpI3jaRVyJLOCJP+
   dpetfL4JTxdrQGZNfCaW1WAdOJyBf8iKt9r6nKzvJz4ceH8SAQekEE8Eh
   YUsLzLynFhkAJ4prmAztzLgFRJJ1z9HCC2MISDFj8NoC+ddznb1B+ruVE
   MJmjJxvAKk00ibCwNKVexcZOyeIvTyHG7UcrID5BifP+IPHIXpw18fgyx
   uT7I71beu4m+G36TZJ0BJyk9U8axZtFbsLS4DNsShxum+GmAoNNXd9FXe
   pntKMKeT61iuM8ueyo0R6gWR/vqiR8c9q97qurAw8rDWo2jHMmVMkPuJc
   w==;
X-CSE-ConnectionGUID: fqAo1E+PRt6LxZdyvGIO7w==
X-CSE-MsgGUID: P9nBLJNkRZu58l/o7ez2QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90125465"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90125465"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 01:45:12 -0700
X-CSE-ConnectionGUID: okoscoZOQaGfakII2yr3+g==
X-CSE-MsgGUID: EzHoc2fuRkO6mhWdM3UJmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273162529"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 01:45:05 -0700
Message-ID: <62b7efe9-e15c-439f-9b6f-920a96b71868@linux.intel.com>
Date: Thu, 24 Sep 2026 16:45:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/21] perf vendor events intel: update
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260924053645.3555041-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The whole patch series looks good to me. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 9/24/2026 1:36 PM, Ian Rogers wrote:
> Sync the Linux kernel perf PMU event json with the latest upstream
> Intel perfmon repository. The updates were created by running:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
>
> Ian Rogers (21):
>   perf vendor events intel: Update alderlake events from 1.40 to 1.41
>   perf vendor events intel: Update alderlaken events from 1.40 to 1.41
>   perf vendor events intel: Update arrowlake events from 1.20 to 1.21
>   perf vendor events intel: Update broadwell metrics to TMA 5.2
>   perf vendor events intel: Update cascadelakex metrics to TMA 5.2
>   perf vendor events intel: Update emeraldrapids events from 1.24 to
>     1.25
>   perf vendor events intel: Update graniterapids events from 1.20 to
>     1.21
>   perf vendor events intel: Update haswell metrics to TMA 5.2
>   perf vendor events intel: Update icelake events to 1.25 and TMA
>     metrics to 5.2
>   perf vendor events intel: Update icelakex events to 1.31 and TMA
>     metrics to 5.2
>   perf vendor events intel: Update ivybridge metrics to TMA 5.2
>   perf vendor events intel: Update ivytown metrics to TMA 5.2
>   perf vendor events intel: Update jaketown metrics to TMA 5.2
>   perf vendor events intel: Update meteorlake events from 1.22 to 1.23
>   perf vendor events intel: Update novalake events from 1.00 to 1.04
>   perf vendor events intel: Update pantherlake events from 1.07 to 1.08
>   perf vendor events intel: Update rocketlake events from 1.04 to 1.06
>   perf vendor events intel: Update sandybridge metrics to TMA 5.2
>   perf vendor events intel: Update sapphirerapids events from 1.39 to
>     1.40
>   perf vendor events intel: Update skylake metrics to TMA 5.2
>   perf vendor events intel: Update tigerlake events to 1.20 and TMA
>     metrics to 5.2
>
>  .../pmu-events/arch/x86/alderlake/cache.json  |   4 +-
>  .../pmu-events/arch/x86/alderlake/memory.json |  13 +
>  .../pmu-events/arch/x86/alderlake/other.json  |  10 +
>  .../arch/x86/alderlake/pipeline.json          |   6 +-
>  .../pmu-events/arch/x86/alderlaken/cache.json |   4 +-
>  .../pmu-events/arch/x86/arrowlake/other.json  |  19 +
>  .../arch/x86/arrowlake/pipeline.json          |   8 +-
>  .../arch/x86/broadwell/bdw-metrics.json       |  51 +-
>  .../arch/x86/broadwell/metricgroups.json      |   3 +-
>  .../arch/x86/broadwellde/bdwde-metrics.json   |  49 +-
>  .../arch/x86/broadwellde/metricgroups.json    |   3 +-
>  .../arch/x86/broadwellx/bdx-metrics.json      |  63 +--
>  .../arch/x86/broadwellx/metricgroups.json     |   3 +-
>  .../arch/x86/cascadelakex/clx-metrics.json    |  94 ++--
>  .../arch/x86/cascadelakex/metricgroups.json   |   3 +-
>  .../arch/x86/emeraldrapids/cache.json         |   2 +-
>  .../arch/x86/emeraldrapids/memory.json        |  35 ++
>  .../arch/x86/emeraldrapids/other.json         |   9 +
>  .../arch/x86/emeraldrapids/pipeline.json      |  10 +-
>  .../arch/x86/emeraldrapids/uncore-io.json     |  53 +-
>  .../arch/x86/graniterapids/other.json         |   9 +
>  .../arch/x86/graniterapids/pipeline.json      |   6 +-
>  .../arch/x86/graniterapids/uncore-cache.json  |  10 +
>  .../arch/x86/graniterapids/uncore-io.json     |  12 +
>  .../arch/x86/haswell/hsw-metrics.json         |  49 +-
>  .../arch/x86/haswell/metricgroups.json        |   3 +-
>  .../arch/x86/haswellx/hsx-metrics.json        |  61 +--
>  .../arch/x86/haswellx/metricgroups.json       |   3 +-
>  .../arch/x86/icelake/icl-metrics.json         |  84 ++-
>  .../pmu-events/arch/x86/icelake/memory.json   |  24 +
>  .../arch/x86/icelake/metricgroups.json        |   2 +-
>  .../pmu-events/arch/x86/icelake/other.json    |   9 +
>  .../pmu-events/arch/x86/icelake/pipeline.json |   9 +-
>  .../arch/x86/icelakex/icx-metrics.json        | 101 ++--
>  .../pmu-events/arch/x86/icelakex/memory.json  |  24 +
>  .../arch/x86/icelakex/metricgroups.json       |   2 +-
>  .../pmu-events/arch/x86/icelakex/other.json   |   9 +
>  .../arch/x86/icelakex/pipeline.json           |   7 +-
>  .../arch/x86/ivybridge/ivb-metrics.json       |  51 +-
>  .../arch/x86/ivybridge/metricgroups.json      |   3 +-
>  .../arch/x86/ivytown/ivt-metrics.json         |  63 +--
>  .../arch/x86/ivytown/metricgroups.json        |   3 +-
>  .../arch/x86/jaketown/jkt-metrics.json        |  41 +-
>  .../arch/x86/jaketown/metricgroups.json       |   3 +-
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  26 +-
>  .../pmu-events/arch/x86/meteorlake/other.json |  10 +
>  .../arch/x86/meteorlake/pipeline.json         |   6 +-
>  .../pmu-events/arch/x86/novalake/cache.json   | 498 ++++++++++++++++-
>  .../arch/x86/novalake/floating-point.json     | 405 ++++++++++++++
>  .../arch/x86/novalake/frontend.json           | 147 ++++-
>  .../pmu-events/arch/x86/novalake/memory.json  |  24 +
>  .../pmu-events/arch/x86/novalake/other.json   | 213 ++++++++
>  .../arch/x86/novalake/pipeline.json           | 504 +++++++++++++++++-
>  .../arch/x86/novalake/virtual-memory.json     | 173 ++++++
>  .../arch/x86/pantherlake/other.json           |  10 +
>  .../arch/x86/pantherlake/pipeline.json        |   6 +-
>  .../arch/x86/rocketlake/memory.json           |  24 +
>  .../arch/x86/rocketlake/metricgroups.json     |   2 +-
>  .../pmu-events/arch/x86/rocketlake/other.json |   9 +
>  .../arch/x86/rocketlake/pipeline.json         |   9 +-
>  .../arch/x86/rocketlake/rkl-metrics.json      |  84 ++-
>  .../arch/x86/sandybridge/metricgroups.json    |   3 +-
>  .../arch/x86/sandybridge/snb-metrics.json     |  35 +-
>  .../arch/x86/sapphirerapids/cache.json        |   2 +-
>  .../arch/x86/sapphirerapids/memory.json       |  35 ++
>  .../arch/x86/sapphirerapids/metricgroups.json |   2 +-
>  .../arch/x86/sapphirerapids/other.json        |   9 +
>  .../arch/x86/sapphirerapids/pipeline.json     |  10 +-
>  .../arch/x86/sapphirerapids/spr-metrics.json  |  93 ++--
>  .../arch/x86/sapphirerapids/uncore-io.json    |  53 +-
>  .../arch/x86/skylake/metricgroups.json        |   3 +-
>  .../arch/x86/skylake/skl-metrics.json         |  59 +-
>  .../arch/x86/skylakex/metricgroups.json       |   3 +-
>  .../arch/x86/skylakex/skx-metrics.json        |  94 ++--
>  .../arch/x86/tigerlake/metricgroups.json      |   2 +-
>  .../pmu-events/arch/x86/tigerlake/other.json  |   9 +
>  .../arch/x86/tigerlake/pipeline.json          |   7 +-
>  .../arch/x86/tigerlake/tgl-metrics.json       |  82 +--
>  78 files changed, 2896 insertions(+), 785 deletions(-)
>
