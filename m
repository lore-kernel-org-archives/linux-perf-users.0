Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CB395AC5;
	Mon, 10 Aug 2026 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352802; cv=none; b=Jb6EtjwyrYBF+v5kUFMW1PwiWcPLueyE7/Estgf+G7IeM7aEq/gK0X3/R8J95RWLlytaXXjZiw3yin08EM5l+bU3rvJzZV1ZcH0M7eSK0rkqZZNMEN7PkhNKfPq8yuhXj4YYjbxqBDoxH6oVdQRw7HftTthNHbUdTirIvFgGdYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352802; c=relaxed/simple;
	bh=2VBI8Ye+kUAyuJcNDfmXV9DH67xMFrL1ESlE5SwQvRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE3KbnqjyBuDGH2gOPUyaiBze249tOlMxvlzDtJeA8nIC7p2sT2c+/G6/0ABx+pDdvwRxNNwKnXONMAoMJabCNuadYZ7RGhIFIoYMR7vc0fVz8mqdjW/6QQNfXf/WOacrEQExepPQ9Va0DOEoy5aZHWEkwrqpQuMJE39OfVBQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hd0k95gY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hd0k95gY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786352801; x=1817888801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2VBI8Ye+kUAyuJcNDfmXV9DH67xMFrL1ESlE5SwQvRM=;
  b=hd0k95gYhmXAlGVFUToJCS1gC/CbUl8CLnGd4tWpxOJJJJwTQwPEEVgp
   zKdwwEqOM8mE3I7QSFt9bAwNjkiy1yKG1c2DEnSepmsAZjw0WhfLaWFUt
   daIW+4vuLpiL+UsT325yr5AGRLi7PENDRmJ1uoEhLZZAD72OatZfMseRc
   9JasYAgjCZSjnRW5hDdG+zcW1d1Aiz26lSk0xmls1MVgi2SEaSnBcRw2f
   lQL+ipOkWkZPjwV49l72FIUTQja9L0Bj3HpDIa6oC87QZc4Xay7j5Oxmo
   dW5hCCG4FCSGSTRPATylDzKwFRT2lwqQWue4oaFBNMo5zq8DKs00NnW/C
   w==;
X-CSE-ConnectionGUID: 2y24zEp5RF2A7y5aAHFqmA==
X-CSE-MsgGUID: YyQMmEhCSouPEyiOOzgnjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98011816"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="98011816"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:06:41 -0700
X-CSE-ConnectionGUID: KE0Z0N3FR5ilSsPFc4PeAw==
X-CSE-MsgGUID: 2eh0zkiJRQ2qsrr4x8XkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="259126499"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:06:36 -0700
Message-ID: <9311dc1b-91d9-47bb-8b23-da78ee4cd8fc@linux.intel.com>
Date: Mon, 10 Aug 2026 17:06:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 0/8] perf/x86: Miscellaneous PMU bug fixes and
 optimizations
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Peter,

Kindly ping. Could you please review this bug fixing patch series? The
changes in this series suppose to be low risky. 

This series is a preceding patchset of the "Support SIMD/eGPRs/SSP
registers sampling for perf" patch series.
https://lore.kernel.org/all/20260721062506.3745816-1-dapeng1.mi@linux.intel.com/

Thanks.

On 7/17/2026 4:03 PM, Dapeng Mi wrote:
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
