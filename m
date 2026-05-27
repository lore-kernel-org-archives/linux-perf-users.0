Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C533644DE;
	Wed, 27 May 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909026; cv=none; b=iAKdaNERpuiu/CsiMB87UNWXldtX+zSo1xqfUl7kAmLpsVewxJoMmyb2J1PV5XX8ef46s2kgsIcEv9I+qcoa0krKV9XHk38G7gIpFci+UY52UdGK/ioKg1zayENMRoBg5+pDYyoVZsw+gN2o8fF245mgpa3lxgSFa7su+Uk+zpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909026; c=relaxed/simple;
	bh=sDy65VXpI0480GwaDK5gTrn9Jq4MN/tchC/ReXwJYA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWc2OfRu9K9c1VgWVlEwJAeKP3Of9/wSSp/rdolUOZE54n28WlehfpagaMf5VsCEwYq9DAidZvc75CMCZKujYN9v/al9YWQnXs045GPeeUA4VSyagTeefV2TQJuNPVdm4S3uaNcn1DBIN7ZuAgILgm8AY/HzyN4uPp7oBb09FTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBmhLWjG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBmhLWjG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779909025; x=1811445025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sDy65VXpI0480GwaDK5gTrn9Jq4MN/tchC/ReXwJYA4=;
  b=fBmhLWjG1966wbsjmonzkttcGCF+dt7tVqcYjK62gg4/nd4Q6mNv7ptw
   R+DxhU3fl0Khy9NyBCMqe95oe+p+BNTb0V3zHG0LcLBb0ptJyHZAF5cE+
   sVoaufkusf37m5tHo5Hp4k7gs67XUZjP4aeqWW3k2J+ezNaNDQd+JFkVi
   2U8zEfjgCSmV48Uym7Fgnw88G1n4vMr7H7k//7q1NbFtaGBD7aAHv0eWZ
   Md4wDYlyVDqsglvDhkI6/eGphGotqv4qNlr/S+tcaM201c2UR27lsxTi3
   ztK0Taojl7ehdTVz6vI414voPFPGtUFsHFi2/RfKGlTZ7C9wLBfSzh8Su
   w==;
X-CSE-ConnectionGUID: 7BvcvWarQyS6ESlHotII5A==
X-CSE-MsgGUID: M0pVoLPnTNaFF/RDd/B1Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80806928"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80806928"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:10:24 -0700
X-CSE-ConnectionGUID: bd/v6tYaSuSezL9SyPTBVw==
X-CSE-MsgGUID: m/+z08aBT0C0g1+2zcGitQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="242176621"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:10:22 -0700
Message-ID: <f3b6f7f1-df15-4e72-a1d8-ca72abdca561@intel.com>
Date: Wed, 27 May 2026 14:10:21 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] perf stat: Fix uncore metric scaling across
 aggregation modes
To: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 james.clark@linaro.org, sandipan.das@amd.com, leo.yan@arm.com,
 thomas.falcon@intel.com, yang.lee@linux.alibaba.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260521201505.124690-1-ctshao@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260521201505.124690-1-ctshao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/2026 3:15 PM, Chun-Tse Shao wrote:
> This series fixes a scaling issue for metrics (like lpm_miss_lat) across
> different runtime aggregation modes.
> 
> Uncore metrics currently use `source_count` to scale events. However,
> `source_count` returns the total uncore unit count regardless of the
> selected aggregation mode. When evaluating metrics in different
> aggregation mode other than `--per-socket`, this incorrectly divides
> aggregated uncore events against the total uncore count rather than the
> uncores belonging to the aggregation, leading to wrong metric results.
> 
> To fix this, we:
> 1. Introduce the aggr_nr() keyword to the metric parser, which
> dynamically resolves to the active units in the current aggregation
> group (`gr->nr`).
> 
> 2. Update the python metrics to use `aggr_nr` instead of `source_count`,
> ensuring correct scaling across all runtime aggregation boundaries.
> 
> Before the fix (incorrect low latency in global mode):
>   $ perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
>   {"ns  lpm_miss_lat_rem" : "122.8", "ns  lpm_miss_lat_loc" : "114.5"}
>   $ perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
>   {"socket" : "S0", "ns  lpm_miss_lat_rem" : "232.1", "ns  lpm_miss_lat_loc" : "278.2"}
>   {"socket" : "S1", "ns  lpm_miss_lat_rem" : "233.9", "ns  lpm_miss_lat_loc" : "257.5"}
> 
> After the fix (correct scaled latency in all aggregation modes):
>   $ perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
>   {"ns  lpm_miss_lat_rem" : "231.7", "ns  lpm_miss_lat_loc" : "245.0"}
>   $ perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
>   {"socket" : "S0", "ns  lpm_miss_lat_rem" : "238.3", "ns  lpm_miss_lat_loc" : "249.4"}
>   {"socket" : "S1", "ns  lpm_miss_lat_rem" : "259.1", "ns  lpm_miss_lat_loc" : "253.1"}
> 
> v3:
>   Fixed based on Sashiko review:
>   - Removed the unnecessary, copied `redefined-builtin` pylint-disable
>     comment from `aggr_nr` definition inside `metric.py`.
> 
> v2: lore.kernel.org/20260521035941.3860145-1-ctshao@google.com
>   Fixed based on Sashiko review:
>   - Fixed `aggr_nr` setting when an uncore event fails to run
>     (counts.run == 0) to explicitly set it to 0 instead of defaulting to
>     1.
>   - Accumulated `aggr_nr` when multiple unmerged PMU events are
>     associated with the same metric ID to prevent incorrect scaling
>     across active sockets.
>   - Removed unused `List` import from `typing` in `intel_metrics.py`.
> 
> v1: lore.kernel.org/20260520180032.3045144-1-ctshao@google.com
> 
> Chun-Tse Shao (2):
>   perf stat: Add aggr_nr metric parser support
>   perf stat: Use aggr_nr scaling for Intel uncore miss latency metrics
> 
>  tools/perf/pmu-events/intel_metrics.py |  6 +++---
>  tools/perf/pmu-events/metric.py        |  9 +++++++--
>  tools/perf/util/expr.c                 | 26 ++++++++++++++++++++++----
>  tools/perf/util/expr.h                 |  6 +++++-
>  tools/perf/util/expr.l                 |  1 +
>  tools/perf/util/expr.y                 | 24 +++++++++++++++++-------
>  tools/perf/util/stat-shadow.c          |  6 +++++-
>  7 files changed, 60 insertions(+), 18 deletions(-)
> 
> --
> 2.54.0.746.g67dd491aae-goog

Tested the series on Intel CPUs.

Tested-by: Zide Chen <zide.chen@intel.com>


