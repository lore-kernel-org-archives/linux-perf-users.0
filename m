Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2692271468;
	Thu, 26 Feb 2026 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092075; cv=none; b=hgZi+RaAgfZK9g8BcBTGvW7vCTeiItuFiPyL5tC/arVEkDwA8sdvj+6iqeNlPUXA8d6UfFfs0jxQnbCxz+t95IO484zvCDmwAEq8lJHpz0N+GNr+RdHEmQw2A2mWUs6ZkGzDykaPr9ZVkj+MbQfLAAIykikpe9MJGRM7NnpHkNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092075; c=relaxed/simple;
	bh=PZki8hNUEHquNo3JLVEWb5xu2BxpQBQKC7pXQjsB1ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H8ZMMLl9ObrHAOqAm7iG6ir2tT0zIAEwLTs1u+BP4EVqamvSpIUEI+AH+zRjQn8cJZHGBSoaYRRIbQvwzQGh+gpINkVMk7FCqw29Jgi/wED0ec8n5kKfWNk8wAA24HMj/DtrrlMG4Zy23v45sTumrySBDZtyxT26ms+IYLHyD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JH9LrXHn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JH9LrXHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772092073; x=1803628073;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PZki8hNUEHquNo3JLVEWb5xu2BxpQBQKC7pXQjsB1ms=;
  b=JH9LrXHnm57E2Auq5cS0T6ot2N8+n4yFVBZOWsK2O+9DRIMyagm7rPnR
   qTVE/GsooTmKF86ZYQOwJ1I2BH7u1EDAGpZWkqKHottjb3RtZ/+ArdfZ3
   U3gN8sXTquSHdKl84ZgXC9jGoMVY0XdfV2AZP8YAkwMAKnG14kk2tBeGs
   xoSRG1oW78jyUSOJzyQK0odOAqLKd4CDL0YLEvMI8s4hd1FXPmQNRCIxF
   xWnPv97RSqDZ+xYl3n4vS36hjoiuRf4tA5NnrizcyKpvDf6zKfIqBJD0Y
   P9ujoZ5vAhTuJOYeNiKYW2gR6+Iw9rJ+oIiZWaGtNtTNBCHKqcSziduM8
   g==;
X-CSE-ConnectionGUID: pMP6vg0vSV6y8FKLEbwigA==
X-CSE-MsgGUID: 7O4UX5DOQT+cltT7wYZtkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73248782"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73248782"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 23:47:52 -0800
X-CSE-ConnectionGUID: tWWguRjwRuyUyxwgGTnJKg==
X-CSE-MsgGUID: 7nR23q9pTA6oaO1wVXmV2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="215599931"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 23:47:49 -0800
Message-ID: <3744f216-e11d-43ba-9e44-b7cb61c2a20e@linux.intel.com>
Date: Thu, 26 Feb 2026 15:47:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] perf vendor events intel: Update alderlake
 events from 1.35 to 1.37
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260226045301.459948-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260226045301.459948-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The whole patch-set looks good to me. Building the patches on Sapphire
rapids and Arrowlake, no issue is found. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 2/26/2026 12:52 PM, Ian Rogers wrote:
> The updated events were published in:
> https://github.com/intel/perfmon/commit/632936400cfc5978c7b4519c865c137de523bfdd
> https://github.com/intel/perfmon/commit/a96d6bf4b50d6ce31e2ffd0be8d13022d07ae319
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../pmu-events/arch/x86/alderlake/cache.json  | 27 +++-----
>  .../arch/x86/alderlake/frontend.json          | 18 +++++
>  .../arch/x86/alderlake/pipeline.json          | 66 +++++++++++++++++--
>  .../pmu-events/arch/x86/alderlaken/cache.json | 27 +++-----
>  .../arch/x86/alderlaken/pipeline.json         | 60 +++++++++++++++--
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  4 +-
>  6 files changed, 152 insertions(+), 50 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
> index be15a7f83717..5d0d824f3e7e 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
> @@ -876,105 +876,97 @@
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 128 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 128. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x80",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 128 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 16 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 16. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x10",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 16 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 256 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 256. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x100",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 256 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 32 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 32. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x20",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 32 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 4 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 4. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x4",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 4 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 512 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 512. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x200",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 512 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 64 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 64. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x40",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 64 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 8 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 8. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x8",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 8 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
>          "Unit": "cpu_atom"
> @@ -1030,12 +1022,11 @@
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of stores uops retired. Counts with or without PEBS enabled.",
> +        "BriefDescription": "Counts the number of stores uops retired.",
>          "Counter": "0,1,2,3,4,5",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
> -        "PublicDescription": "Counts the number of stores uops retired. Counts with or without PEBS enabled. If PEBS is enabled and a PEBS record is generated, will populate PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x6",
>          "Unit": "cpu_atom"
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
> index ff3b30c2619a..11fc853f2d0b 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
> @@ -327,6 +327,24 @@
>          "UMask": "0x4",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "ICACHE_TAG.STALLS_INUSE",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x83",
> +        "EventName": "ICACHE_TAG.STALLS_INUSE",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x10",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "ICACHE_TAG.STALLS_ISB",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x83",
> +        "EventName": "ICACHE_TAG.STALLS_ISB",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x8",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "Cycles Decode Stream Buffer (DSB) is delivering any Uop",
>          "Counter": "0,1,2,3",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> index 57a8c78cdc49..80cad3c49d20 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> @@ -244,6 +244,15 @@
>          "UMask": "0xfb",
>          "Unit": "cpu_atom"
>      },
> +    {
> +        "BriefDescription": "Counts the number of near indirect JMP branch instructions retired.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.INDIRECT_JMP",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xef",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.INDIRECT_CALL",
>          "Counter": "0,1,2,3,4,5",
> @@ -464,6 +473,15 @@
>          "UMask": "0x2",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the number of mispredicted near indirect JMP branch instructions retired.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.INDIRECT_JMP",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xef",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.INDIRECT_CALL",
>          "Counter": "0,1,2,3,4,5",
> @@ -573,7 +591,7 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
> +        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD]",
>          "Counter": "Fixed counter 1",
>          "EventName": "CPU_CLK_UNHALTED.CORE",
>          "PublicDescription": "Counts the number of core cycles while the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time. This event uses fixed counter 1.",
> @@ -582,7 +600,7 @@
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of unhalted core clock cycles.",
> +        "BriefDescription": "Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0x3c",
>          "EventName": "CPU_CLK_UNHALTED.CORE_P",
> @@ -651,7 +669,7 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency. (Fixed event)",
> +        "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles at TSC frequency.",
>          "Counter": "Fixed counter 2",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is not affected by core frequency changes and increments at a fixed frequency that is also used for the Time Stamp Counter (TSC). This event uses fixed counter 2.",
> @@ -689,7 +707,7 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
> +        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE]",
>          "Counter": "Fixed counter 1",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time.  This event uses fixed counter 1.",
> @@ -707,7 +725,7 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Counts the number of unhalted core clock cycles.",
> +        "BriefDescription": "Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0x3c",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_P",
> @@ -875,7 +893,7 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Counts the total number of instructions retired. (Fixed event)",
> +        "BriefDescription": "Fixed Counter: Counts the total number of instructions retired.",
>          "Counter": "Fixed counter 0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "Counts the total number of instructions that retired. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. This event continues counting during hardware interrupts, traps, and inside interrupt handlers. This event uses fixed counter 0. Available PDIST counters: 32",
> @@ -1273,6 +1291,42 @@
>          "UMask": "0x20",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the number of CLFLUSH, CLWB, and CLDEMOTE instructions retired.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xe0",
> +        "EventName": "MISC_RETIRED1.CL_INST",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0xff",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of LFENCE instructions retired.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xe0",
> +        "EventName": "MISC_RETIRED1.LFENCE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of accesses to KeyLocker cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xe1",
> +        "EventName": "MISC_RETIRED2.KEYLOCKER_ACCESS",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x10",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of misses to KeyLocker cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xe1",
> +        "EventName": "MISC_RETIRED2.KEYLOCKER_MISS",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x11",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Cycles stalled due to no store buffers available. (not including draining form sync).",
>          "Counter": "0,1,2,3,4,5,6,7",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
> index 76a841675337..1f97a4dc6fb1 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
> @@ -246,98 +246,90 @@
>          "UMask": "0x82"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 128 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 128. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x80",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 128 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 16 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 16. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x10",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 16 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 256 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 256. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x100",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 256 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 32 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 32. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x20",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 32 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 4 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 4. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x4",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 4 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 512 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 512. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x200",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 512 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 64 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 64. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x40",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 64 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5"
>      },
>      {
> -        "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 8 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
> +        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 8. Only counts with PEBS enabled.",
>          "Counter": "0,1",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x8",
> -        "PublicDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 8 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. If a PEBS record is generated, will populate the PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5"
>      },
> @@ -387,12 +379,11 @@
>          "UMask": "0x12"
>      },
>      {
> -        "BriefDescription": "Counts the number of stores uops retired. Counts with or without PEBS enabled.",
> +        "BriefDescription": "Counts the number of stores uops retired.",
>          "Counter": "0,1,2,3,4,5",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
> -        "PublicDescription": "Counts the number of stores uops retired. Counts with or without PEBS enabled. If PEBS is enabled and a PEBS record is generated, will populate PEBS Latency and PEBS Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x6"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> index d650cbd48c1f..a13851071624 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> @@ -108,6 +108,14 @@
>          "SampleAfterValue": "200003",
>          "UMask": "0xfb"
>      },
> +    {
> +        "BriefDescription": "Counts the number of near indirect JMP branch instructions retired.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.INDIRECT_JMP",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xef"
> +    },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.INDIRECT_CALL",
>          "Counter": "0,1,2,3,4,5",
> @@ -225,6 +233,14 @@
>          "SampleAfterValue": "200003",
>          "UMask": "0xfb"
>      },
> +    {
> +        "BriefDescription": "Counts the number of mispredicted near indirect JMP branch instructions retired.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.INDIRECT_JMP",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xef"
> +    },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.INDIRECT_CALL",
>          "Counter": "0,1,2,3,4,5",
> @@ -278,7 +294,7 @@
>          "UMask": "0xfe"
>      },
>      {
> -        "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
> +        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD]",
>          "Counter": "Fixed counter 1",
>          "EventName": "CPU_CLK_UNHALTED.CORE",
>          "PublicDescription": "Counts the number of core cycles while the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time. This event uses fixed counter 1.",
> @@ -286,7 +302,7 @@
>          "UMask": "0x2"
>      },
>      {
> -        "BriefDescription": "Counts the number of unhalted core clock cycles.",
> +        "BriefDescription": "Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0x3c",
>          "EventName": "CPU_CLK_UNHALTED.CORE_P",
> @@ -303,7 +319,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency. (Fixed event)",
> +        "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles at TSC frequency.",
>          "Counter": "Fixed counter 2",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is not affected by core frequency changes and increments at a fixed frequency that is also used for the Time Stamp Counter (TSC). This event uses fixed counter 2.",
> @@ -320,7 +336,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
> +        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE]",
>          "Counter": "Fixed counter 1",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time.  This event uses fixed counter 1.",
> @@ -328,7 +344,7 @@
>          "UMask": "0x2"
>      },
>      {
> -        "BriefDescription": "Counts the number of unhalted core clock cycles.",
> +        "BriefDescription": "Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0x3c",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_P",
> @@ -336,7 +352,7 @@
>          "SampleAfterValue": "2000003"
>      },
>      {
> -        "BriefDescription": "Counts the total number of instructions retired. (Fixed event)",
> +        "BriefDescription": "Fixed Counter: Counts the total number of instructions retired.",
>          "Counter": "Fixed counter 0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "Counts the total number of instructions that retired. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. This event continues counting during hardware interrupts, traps, and inside interrupt handlers. This event uses fixed counter 0. Available PDIST counters: 32",
> @@ -426,6 +442,38 @@
>          "SampleAfterValue": "1000003",
>          "UMask": "0x1"
>      },
> +    {
> +        "BriefDescription": "Counts the number of CLFLUSH, CLWB, and CLDEMOTE instructions retired.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xe0",
> +        "EventName": "MISC_RETIRED1.CL_INST",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0xff"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of LFENCE instructions retired.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xe0",
> +        "EventName": "MISC_RETIRED1.LFENCE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of accesses to KeyLocker cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xe1",
> +        "EventName": "MISC_RETIRED2.KEYLOCKER_ACCESS",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of misses to KeyLocker cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xe1",
> +        "EventName": "MISC_RETIRED2.KEYLOCKER_MISS",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x11"
> +    },
>      {
>          "BriefDescription": "Counts the number of issue slots in a UMWAIT or TPAUSE instruction where no uop issues due to the instruction putting the CPU into the C0.1 activity state. For Tremont, UMWAIT and TPAUSE will only put the CPU into C0.1 activity state (not C0.2 activity state)",
>          "Counter": "0,1,2,3,4,5",
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index 149bbe7abaf5..9370722dc564 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -1,6 +1,6 @@
>  Family-model,Version,Filename,EventType
> -GenuineIntel-6-(97|9A|B7|BA|BF),v1.35,alderlake,core
> -GenuineIntel-6-BE,v1.35,alderlaken,core
> +GenuineIntel-6-(97|9A|B7|BA|BF),v1.37,alderlake,core
> +GenuineIntel-6-BE,v1.37,alderlaken,core
>  GenuineIntel-6-C[56],v1.14,arrowlake,core
>  GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
>  GenuineIntel-6-(3D|47),v30,broadwell,core
