Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E931E821;
	Tue, 14 Jul 2026 05:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006517; cv=none; b=MGQe+in1GeW6B5mWrpKAvBmoAlGLc1XPBhQERWtBx7j31m5ZQRZf6/f+MdX3oYlxzkkOveWeByBBR4iO/YUM37aUvUAiL7QdSoxFlMTg3q8bFWy5f8pf1S111GiNC/uGAXGeDKkor/Jf432+YNsXVyrDfaOXprpUHf1G1z2mF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006517; c=relaxed/simple;
	bh=oSy2sg6v20EERFKR3PARIs03kRqLNw1yX5EWGHalRjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0V8kq4hpxoaOlDODQP34Fem1tF9631L/7Z6Vo6XTck0B4MLk3oYUc1liSB9YqaK4a+OYbe/uDAe5c4Nj/uz8b3JfBVTUom4xm7jO2J2029HEN7ZhshETNLrNuvtQ38Ac4HfhtQHO3yxsDkCoOl2WTZjAnDHoyh2iZu3R5I3lHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWSYrABr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWSYrABr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784006513; x=1815542513;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oSy2sg6v20EERFKR3PARIs03kRqLNw1yX5EWGHalRjw=;
  b=AWSYrABr0SydXpt1DWdALENZKLK7t6Cg2NUvWukcLaOnr7p4NQq3Aty2
   dxXNSuFJ0fsAE6QhT8hnuzL/SqGb8Q5/cV0kNaW9wECEdlilYH06MMp/N
   eguDQ4vMYeqZnlHToj+tDBPnrwfwLBJnPX6fRfIQeTSq6juXn/HycJfSN
   C5+c3A7Eyzwsa5yZZj351PbJkuKCD3y+9/pl7zZdtHyjYn/Mmd+NMQa77
   mrO73PD2ueGrD9m+bjIlywlzYP8x8UOIrlRvMnc9xgUhDLOyV4tsEhh8w
   BhyoCLArUsFIF/vY6U/wN3GTgW6G+3FHj+RYas5pz5cEc0zwLK9uEWKEm
   Q==;
X-CSE-ConnectionGUID: oazEitcFQgeg0m4gQRc5dQ==
X-CSE-MsgGUID: CAj/lwJ3STmhgkZyV1Grng==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="72144488"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="72144488"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:21:52 -0700
X-CSE-ConnectionGUID: Vdmyl5RuTbaQ0MH4m6vSlQ==
X-CSE-MsgGUID: SPNIMPsESt2lse5NHd7Tzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="252365155"
Received: from unknown (HELO [10.238.3.181]) ([10.238.3.181])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:21:48 -0700
Message-ID: <2e182845-6771-473c-a82a-bf96953b458e@linux.intel.com>
Date: Tue, 14 Jul 2026 13:21:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/12] perf vendor events intel: update
To: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de,
 mani@kernel.org, thomas.falcon@intel.com, irogers@google.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 perry.taylor@intel.com
References: <20260713181757.481164-1-ctshao@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260713181757.481164-1-ctshao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The patchset looks good to me. But It depends on this patch
https://lore.kernel.org/all/20260708053226.3776183-1-dapeng1.mi@linux.intel.com/.
Without this patch, the building on NVL would fail. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 7/14/2026 2:17 AM, Chun-Tse Shao wrote:
> Sync the Linux kernel perf PMU events with the latest upstream Intel
> perfmon repository.
>
> This patchset includes event and metric updates for Alder Lake, Alder
> Lake N, Arrow Lake, Clearwater Forest, Emerald Rapids (including IIO
> bandwidth metrics), Grand Ridge, Granite Rapids, Lunar Lake, Meteor
> Lake, Panther Lake, and Sierra Forest, as well as adding initial event
> support for Nova Lake v1.00.
>
> Chun-Tse Shao (12):
>   perf vendor events intel: Update alderlake events from 1.39 to 1.40
>   perf vendor events intel: Update alderlaken events from 1.39 to 1.40
>   perf vendor events intel: Update arrowlake events from 1.19 to 1.20
>   perf vendor events intel: Update clearwaterforest events from 1.02 to
>     1.04
>   perf vendor events intel: Update grandridge events from 1.12 to 1.13
>   perf vendor events intel: Update graniterapids events from 1.19 to
>     1.20
>   perf vendor events intel: Update lunarlake events from 1.25 to 1.26
>   perf vendor events intel: Update meteorlake events from 1.21 to 1.22
>   perf vendor events intel: Add novalake v1.00 events
>   perf vendor events intel: Update pantherlake events from 1.06 to 1.07
>   perf vendor events intel: Update sierraforest events from 1.17 to 1.18
>   perf vendor events intel: Update emeraldrapids metrics
>
>  .../arch/x86/alderlake/adl-metrics.json       |   80 +-
>  .../pmu-events/arch/x86/alderlake/cache.json  |   36 +
>  .../arch/x86/alderlake/metricgroups.json      |    2 +-
>  .../arch/x86/alderlake/pipeline.json          |    6 +-
>  .../pmu-events/arch/x86/alderlaken/cache.json |   32 +
>  .../arch/x86/arrowlake/arl-metrics.json       |  152 +-
>  .../arch/x86/arrowlake/metricgroups.json      |    2 +-
>  .../arch/x86/arrowlake/pipeline.json          |    2 +-
>  .../arch/x86/arrowlake/uncore-memory.json     |   84 +-
>  .../arch/x86/clearwaterforest/memory.json     |   33 +
>  .../arch/x86/clearwaterforest/pipeline.json   |   19 +
>  .../clearwaterforest/uncore-interconnect.json |   10 +
>  .../x86/clearwaterforest/uncore-memory.json   |    2 +-
>  .../arch/x86/emeraldrapids/emr-metrics.json   |  135 +-
>  .../arch/x86/emeraldrapids/metricgroups.json  |    2 +-
>  .../pmu-events/arch/x86/grandridge/cache.json |   25 +
>  .../arch/x86/grandridge/counter.json          |   42 -
>  .../arch/x86/grandridge/floating-point.json   |   56 +
>  .../arch/x86/grandridge/memory.json           |   57 +
>  .../arch/x86/grandridge/pipeline.json         |  140 ++
>  .../arch/x86/grandridge/uncore-memory.json    |    2 +-
>  .../arch/x86/grandridge/virtual-memory.json   |    8 +
>  .../arch/x86/graniterapids/gnr-metrics.json   |  102 +-
>  .../arch/x86/graniterapids/metricgroups.json  |    2 +-
>  .../arch/x86/graniterapids/pipeline.json      |    2 +-
>  .../arch/x86/lunarlake/lnl-metrics.json       |  142 +-
>  .../arch/x86/lunarlake/metricgroups.json      |    2 +-
>  .../arch/x86/lunarlake/pipeline.json          |    2 +-
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   21 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json |   11 +-
>  .../arch/x86/meteorlake/metricgroups.json     |    2 +-
>  .../arch/x86/meteorlake/mtl-metrics.json      |   88 +-
>  .../arch/x86/meteorlake/pipeline.json         |    4 +-
>  .../arch/x86/meteorlake/uncore-memory.json    |   84 +-
>  .../pmu-events/arch/x86/novalake/cache.json   |  749 +++++++
>  .../pmu-events/arch/x86/novalake/counter.json |   17 +
>  .../arch/x86/novalake/floating-point.json     |  452 ++++
>  .../arch/x86/novalake/frontend.json           |  600 +++++
>  .../pmu-events/arch/x86/novalake/memory.json  |  299 +++
>  .../pmu-events/arch/x86/novalake/other.json   |  144 ++
>  .../arch/x86/novalake/pipeline.json           | 1976 +++++++++++++++++
>  .../arch/x86/novalake/uncore-memory.json      |   42 +
>  .../arch/x86/novalake/virtual-memory.json     |  338 +++
>  .../arch/x86/pantherlake/pipeline.json        |    2 +-
>  .../arch/x86/sierraforest/counter.json        |   77 -
>  .../x86/sierraforest/uncore-interconnect.json |   10 +
>  .../arch/x86/sierraforest/uncore-memory.json  |    2 +-
>  47 files changed, 5615 insertions(+), 482 deletions(-)
>  delete mode 100644 tools/perf/pmu-events/arch/x86/grandridge/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/virtual-memory.json
>  delete mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/counter.json
>
