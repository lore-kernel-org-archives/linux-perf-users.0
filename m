Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4A23909F;
	Wed, 20 Aug 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705330; cv=none; b=uVZGYQT4kXJS8oXSp/3UFSwjdQ0b54/yFiwZSTiHJ/Vi+y0hr7NnsQnbpGg7JaOnyYnuA+mNCsANmpjaGLRXXuXwR3NYgfXNSURnYo+uZQKZEgyQ17cWTRrerHdpAL4OUS1EeWrGR5G56iciXW4OatcrfkyphBtqDBgMRqGbnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705330; c=relaxed/simple;
	bh=u4cz0/Jg88zHekFCSPtNxdSQvC0Z4lDL+vo4+ZSkMP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuBBF3EUi2cFdjf+OTFFMFkgkZE2REgb81wAlQmxqYOt7nlPsMJ9nR1pMNkSjo9lGSp5jmlIy8eJo6ie2adaVYRDfJyoLEM2upotLVkPVA0MNuI0VoWzTan7Vdmg9Ibr4o8nPxttF15AxxAYpNyHLWHjSfBQjTz/Fl4YSyD0n+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VinTsglG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VinTsglG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755705329; x=1787241329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u4cz0/Jg88zHekFCSPtNxdSQvC0Z4lDL+vo4+ZSkMP4=;
  b=VinTsglGTW/x9bsPiCxdTcosTxxAXUu9iIZbwRq6Low5AK+Np5W+Kb5P
   6kjOT50PCk5/sqVKTQjachiSZo0RsonXASDy0JS9p2fi7/p8/Cqeg3smH
   sEeTa7F93ZU9NObnCrFgwFdNJ0MHBKUUWcHx1Yg6p0iJD/Ouw2zCiFBjD
   oY+GUSSWHg0+epAAKS4RulTH1jKYEdunZES/FdMx4aBRsfJlxebdrk1dU
   +PeICfgbBz0x+VHwb9IhgjwgjPGfNE/CQiF4vI9gw12VhaEM9W/IVERAF
   kb0Fpj8o9C64gF7h5ruOLR2VZCTPiNA29hC6TfEjdA0XkzcgeHecx8lZm
   g==;
X-CSE-ConnectionGUID: mdDvMKi2STWl//aEKeFPoQ==
X-CSE-MsgGUID: cxlLtoAVRny8wBiUsdQicw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68574638"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="68574638"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:55:28 -0700
X-CSE-ConnectionGUID: wS8bhdH3QV6HFepL58dCHA==
X-CSE-MsgGUID: hIRKA2xQSBq9Y2DC/j6EhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168075288"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:55:28 -0700
Received: from [10.246.144.138] (kliang2-mobl1.ccr.corp.intel.com [10.246.144.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E835A20B571C;
	Wed, 20 Aug 2025 08:55:25 -0700 (PDT)
Message-ID: <75fbe025-214f-4b2c-8077-a8dbfa34a5c2@linux.intel.com>
Date: Wed, 20 Aug 2025 08:55:24 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 0/7] x86 perf bug fixes and optimization
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-19 7:30 p.m., Dapeng Mi wrote:
> Changes:
>   v2 -> v3:
>   * Rebase to latest tip perf/core tree.
>   * Rewrite commit message to explain why NULL access happens and
>     refine code (Patch 3/7)
>   * Refine commit message of patch 6/7
>   * Dump counters bitmap instead of absolute counter in boot message
>     (patch 7/7)
> 
>   v1 -> v2:
>   * Rebase to 6.17-rc1.
>   * No code changes.
> 
> Tests:
>   * Run perf stats/record commands on Intel Sapphire Rapids platform, no
>     issue is found.
> 
> History:
>   v2: https://lore.kernel.org/all/20250811090034.51249-1-dapeng1.mi@linux.intel.com/ 
>   v1:
>   * Patch 1/6: https://lore.kernel.org/all/20250606111606.84350-1-dapeng1.mi@linux.intel.com/
>   * Patch 2/6: https://lore.kernel.org/all/20250529080236.2552247-1-dapeng1.mi@linux.intel.com/
>   * Patch 3/6: https://lore.kernel.org/all/20250718062602.21444-1-dapeng1.mi@linux.intel.com/
>   * Patches 4-6/6: https://lore.kernel.org/all/20250717090302.11316-1-dapeng1.mi@linux.intel.com/
> 
> Dapeng Mi (7):
>   perf/x86/intel: Use early_initcall() to hook bts_init()
>   perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
>   perf/x86: Check if cpuc->events[*] pointer exists before accessing it
>   perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
>   perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to
>     BIT_ULL(48)
>   perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into
>     INTEL_FIXED_BITS_MASK
>   perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap()
>

The series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
>  arch/x86/events/core.c                 | 16 +++++++++-------
>  arch/x86/events/intel/bts.c            |  2 +-
>  arch/x86/events/intel/core.c           | 21 +++++++++------------
>  arch/x86/events/intel/ds.c             | 10 ++++++++++
>  arch/x86/include/asm/msr-index.h       | 14 ++++++++------
>  arch/x86/include/asm/perf_event.h      |  8 ++++++--
>  arch/x86/kvm/pmu.h                     |  2 +-
>  tools/arch/x86/include/asm/msr-index.h | 14 ++++++++------
>  8 files changed, 52 insertions(+), 35 deletions(-)
> 
> 
> base-commit: 448f97fba9013ffa13f5dd82febd18836b189499

