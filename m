Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A53E172E;
	Tue, 21 Jul 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645944; cv=none; b=sHcnvJ/uuTHMzHrugvOmQ6BVRi7xPcq65010Cui0FPpPtvnxUa7wKWBKduvK81So2nS4y6Rzg5O//1yEiwozel8z5A6B3zsw5BqEkFLcvaiNA1yeAz779ESK4z/2eZ3Mj7I4z8U2qP4LypxBduSO/CyqMurhvVjMHGLfkopLwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645944; c=relaxed/simple;
	bh=lySFQEjlfKoTDHuiizi/oHl86RY6OEHE5uMcnI0QSfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGR8L0mJGQAjm0gonnW02kpi9T1TXSvPlF8KnxniCcXtZKRhogm7Olc+WY2Qax+5IpMYAaNgJpEhbwDQW6Ve+Oz+9PpZ7BzU+yXlbSX/G7gkR3gD5cHsy8tEajYXZKDk7jM2Z51DwfpwVhk+ZWt7o/QwadLCCCBGTxz26WXiz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiO8ruG+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiO8ruG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784645942; x=1816181942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lySFQEjlfKoTDHuiizi/oHl86RY6OEHE5uMcnI0QSfA=;
  b=WiO8ruG+mFKbWloib77/jHoxRxRghI+m/DmiMBpg5obSHTWLp+w9QrYo
   AAiv58yxcvQXopf5CwetFm0BKgc0ARKxSzZH6mkgpeklcKmw5X/8mw/Xb
   ycxm2sf40JE/swrW2ithec6lJFvHN8H2VSfiUqfNojTMiAWrtQV7eUmZh
   yabqvT3HEzIrUMRdsn5GQGJtIyCx36qEFpta77PWfaWl+DKIEUOcaz9Xa
   FdIn3RWRNph5AEYucC497Un8EHBlXxaaYKg/jq3x52Jz94Cheqj8vxdnY
   X12wha9ov+IpsW8ZkxOMo/7cjMQWNLMmG1iLQlUOpz+yik7yNrTtYzzFu
   w==;
X-CSE-ConnectionGUID: IAlT9FcwTKimGqoZ6yR1rQ==
X-CSE-MsgGUID: 0VKaZ57dRWyNXCsiNKklag==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85192975"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85192975"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 07:59:01 -0700
X-CSE-ConnectionGUID: g3H+t0LEQXu9iPLzbt24zg==
X-CSE-MsgGUID: oZfbx44FTZiMtP5zzCoglg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="261348250"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 07:59:00 -0700
Message-ID: <a47f0dbc-e7a2-4d22-acfa-9d6925da1603@intel.com>
Date: Tue, 21 Jul 2026 09:58:59 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 0/8] perf/x86: Miscellaneous PMU bug fixes and
 optimizations
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


For the whole series:
Reviewed-by: Zide Chen <zide.chen@intel.com>


On 7/17/2026 3:03 AM, Dapeng Mi wrote:
> Changes since v2:
> - Patch 6/8: Fix the typo in comments (Thomas).
> - Patch 8/8: New patch which prevents drain_pebs() reentry.
> 
> Changes since v1:
> - Patch 3/7: Ensure cpuc->pmu is not the static pmu before calling
>   hybrid_pmu(cpuc->pmu) in intel_pmu_cpu_dead() (Sashiko).
> 
> This series fixes recently found x86 core PMU bugs. Most of bugs are
> found by Sashiko in reviewing the "Support SIMD/eGPRs/SSP registers 
> sampling for perf" patch-set, e.g.,
> https://lore.kernel.org/all/20260706022123.480411F000E9@smtp.kernel.org/
> https://lore.kernel.org/all/20260706021852.DE2ED1F000E9@smtp.kernel.org/
> 
> The patch 7/8 optimizes ACR handling in match_prev_assignment() and
> mitigate the performance overhead.
> 
> The patch 8/8 enhances intel_pmu_drain_pebs_buffer() to prevent
> drain_pebs() reentry.
> 
> Tests:
> Below test cases are run on Diamonds and Novalake. No issues are found.
> - Perf stat test
>   $ perf test 119
> - Perf record tests 
>   $ perf test 155
> - Perf record LBR tests
>   $ perf test 156
> 
> History:
> v2: https://lore.kernel.org/all/20260713082734.3162099-1-dapeng1.mi@linux.intel.com/ 
> v1: https://lore.kernel.org/all/20260710065128.1799838-1-dapeng1.mi@linux.intel.com/
> 
> Dapeng Mi (8):
>   perf/x86: Unregister PMI handler on PMU init failure
>   perf/x86: Free hybrid state on PMU init failure
>   perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts
>   perf/x86/intel: Unwind cpuc state if PEBS buffer setup fails
>   perf/x86: Remove stale fixed counter helper and fix hybrid PMU access
>   perf/x86/intel: Fix intel_cap handling on hybrid PMUs
>   perf/x86: Optimize ACR handling in match_prev_assignment()
>   perf/x86/intel: Prevent drain_pebs() reentry
> 
>  arch/x86/events/core.c       |  45 ++++++++++++----
>  arch/x86/events/intel/core.c | 101 ++++++++++++++++++++++++++---------
>  arch/x86/events/intel/ds.c   |   7 ---
>  arch/x86/events/perf_event.h |  12 ++---
>  4 files changed, 113 insertions(+), 52 deletions(-)
> 
> 
> base-commit: edda9051e267b7390c7ce24b1b71434414ad156e

