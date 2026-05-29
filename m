Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15E33F8AA;
	Fri, 29 May 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045594; cv=none; b=VQhr8OSlVlqH4bTQxoC3higi1iismEg+k7i42KiSJDmalf3kEkZiXDMh1ZeslQLBr6qSPv7wU1S2muUqou/2uieEhPOE/rUgS+pI1JhWXUjQrmTDmIgiFv7bUkJ+TBxmEzX8ttzgyQLwg4/QXimlHNWva1Kdcr06TBsmjPHFTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045594; c=relaxed/simple;
	bh=egq93kQ7WlNg19RdmCRAKuLYiYtcAFwNSYG/ymjwyKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KRry7SosMaN66uZiAOngwVcJxsd9H6YN9zLiLd4bA1MAIDg27Lvq0zy4d0Aw+zpRWkeX3SWfEJJeA2miaHldZruIul15IK7vM0rzra0O7ZYVQcyjWGu1YtjhRYJFACHzpln2FtCjGig3IJdV25ZLS4R0XUbPC0r54rwUmnBtGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlyZaxdD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlyZaxdD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780045594; x=1811581594;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=egq93kQ7WlNg19RdmCRAKuLYiYtcAFwNSYG/ymjwyKo=;
  b=BlyZaxdDTVnim6zm3PczQa/FvuKAEeAtORzoU9oSoUzHeffoggjxw/mp
   7WgbrldomX+65/RakBaLiY63asAb4A2/lJZU91bsL5+KOu9ZlmJI7DcXq
   YjnBbMs6AWDbSFlIrdJp/WFYMbRX0DhQAjomiM0YiTxCPzPqUy5PFIaqK
   JndQ+kRPCSbnBMT/4+SsvtfgYKxWSJUItl/idRd1v1xGYeppPnnl52WxC
   eN7Xu3JnxiV6SGHFNJVGgtkyIJ2RICSNAqeRH8BFc9cUDnlmryJdceNgQ
   581ZHzkhoP3b/D3cCjd19p+P+xe3jXJnW84MG5jYkPt0OFirQx5+vU3IL
   w==;
X-CSE-ConnectionGUID: om+AAiFBTd+vzjGv6UB0eA==
X-CSE-MsgGUID: plsvJUAiRu6wXctL4uDoig==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92007278"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92007278"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 02:06:33 -0700
X-CSE-ConnectionGUID: FFaSmgrrSq+Aq24+M+e9nQ==
X-CSE-MsgGUID: +2GKzwgGSBS1auDfX/7vHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246814973"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 02:06:29 -0700
Message-ID: <86b48040-adb2-41da-995e-2f2333bf9c49@linux.intel.com>
Date: Fri, 29 May 2026 17:06:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/12] perf vendor events intel: update
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20260529045155.311805-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The whole patchset looks good to me. Thanks for updating these event lists.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 5/29/2026 12:51 PM, Ian Rogers wrote:
> Sync with the latest perfmon events from:
> https://github.com/intel/perfmon
> by running the script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> and copying the resulting json and mapfile.csv changes into the perf
> tree.
>
> Ian Rogers (12):
>   perf vendor events intel: Update alderlake events from 1.37 to 1.39
>   perf vendor events intel: Update alderlaken events from 1.37 to 1.39
>   perf vendor events intel: Update arrowlake events from 1.16 to 1.17
>   perf vendor events intel: Update clearwaterforest events and metrics
>     from 1.00 to 1.02
>   perf vendor events intel: Update emeraldrapids events from 1.21 to
>     1.23
>   perf vendor events intel: Update grandridge events from 1.11 to 1.12
>   perf vendor events intel: Update graniterapids events from 1.17 to
>     1.18
>   perf vendor events intel: Update lunarlake events from 1.21 to 1.22
>   perf vendor events intel: Update meteorlake events from 1.20 to 1.21
>   perf vendor events intel: Update pantherlake events from 1.04 to 1.05
>   perf vendor events intel: Update sapphirerapids events from 1.36 to
>     1.39
>   perf vendor events intel: Update sierraforest events from 1.15 to 1.17
>
>  .../pmu-events/arch/x86/alderlake/cache.json  |   85 +
>  .../pmu-events/arch/x86/alderlake/memory.json |   64 +
>  .../arch/x86/alderlake/pipeline.json          |   54 +
>  .../arch/x86/alderlake/virtual-memory.json    |    9 +
>  .../pmu-events/arch/x86/alderlaken/cache.json |   50 +
>  .../arch/x86/alderlaken/memory.json           |   57 +
>  .../arch/x86/alderlaken/pipeline.json         |   48 +
>  .../arch/x86/alderlaken/virtual-memory.json   |    8 +
>  .../pmu-events/arch/x86/arrowlake/cache.json  |   53 +
>  .../arch/x86/arrowlake/floating-point.json    |    9 +
>  .../arch/x86/arrowlake/pipeline.json          |   48 +-
>  .../arch/x86/clearwaterforest/cache.json      |  525 ++-
>  .../arch/x86/clearwaterforest/counter.json    |   79 +-
>  .../x86/clearwaterforest/cwf-metrics.json     |  310 ++
>  .../x86/clearwaterforest/floating-point.json  |  191 +
>  .../arch/x86/clearwaterforest/frontend.json   |  226 ++
>  .../arch/x86/clearwaterforest/memory.json     |   92 +
>  .../arch/x86/clearwaterforest/other.json      |   20 +
>  .../arch/x86/clearwaterforest/pipeline.json   |  829 +++-
>  .../x86/clearwaterforest/uncore-cache.json    | 3413 +++++++++++++++++
>  .../arch/x86/clearwaterforest/uncore-cxl.json |   31 +
>  .../clearwaterforest/uncore-interconnect.json | 1625 ++++++++
>  .../arch/x86/clearwaterforest/uncore-io.json  | 1925 ++++++++++
>  .../x86/clearwaterforest/uncore-memory.json   |  883 +++++
>  .../x86/clearwaterforest/uncore-power.json    |  109 +
>  .../x86/clearwaterforest/virtual-memory.json  |   94 +
>  .../arch/x86/emeraldrapids/cache.json         |   18 +
>  .../pmu-events/arch/x86/grandridge/cache.json |   56 +
>  .../arch/x86/grandridge/floating-point.json   |    8 +
>  .../arch/x86/grandridge/frontend.json         |   64 +
>  .../arch/x86/grandridge/pipeline.json         |   15 +
>  .../arch/x86/grandridge/uncore-io.json        |   15 +-
>  .../arch/x86/grandridge/uncore-memory.json    |   32 +-
>  .../arch/x86/graniterapids/cache.json         |    9 +
>  .../pmu-events/arch/x86/lunarlake/cache.json  |   20 +
>  .../arch/x86/lunarlake/pipeline.json          |    9 +
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   24 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json |   55 +
>  .../arch/x86/meteorlake/floating-point.json   |   63 +
>  .../arch/x86/meteorlake/memory.json           |   64 +
>  .../arch/x86/meteorlake/pipeline.json         |  158 +
>  .../arch/x86/meteorlake/virtual-memory.json   |    9 +
>  .../arch/x86/pantherlake/cache.json           |  152 +-
>  .../arch/x86/pantherlake/frontend.json        |   60 +
>  .../arch/x86/pantherlake/memory.json          |   29 +
>  .../arch/x86/pantherlake/other.json           |   10 +
>  .../arch/x86/pantherlake/pipeline.json        |  231 +-
>  .../arch/x86/sapphirerapids/cache.json        |   27 +
>  .../arch/x86/sierraforest/cache.json          |   49 +
>  .../arch/x86/sierraforest/floating-point.json |   64 +
>  .../arch/x86/sierraforest/memory.json         |   57 +
>  .../arch/x86/sierraforest/pipeline.json       |  156 +
>  .../arch/x86/sierraforest/virtual-memory.json |    8 +
>  53 files changed, 12195 insertions(+), 104 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/cwf-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cxl.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-io.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-power.json
>
