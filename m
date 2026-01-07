Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0281F9F70;
	Wed,  7 Jan 2026 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748017; cv=none; b=KZUPPyE0wMExwy8NCGs2qYk2nJ3ypf280phGq/RfVhPHkppZ15jckvKR5zOkekfOsF/vGhdLYd8eCq0wdhbelr/dTLOwWWEavfbZflmCVtpj67IlXRY/qYkMBsWUlumXNz8f5rWOia744Vkv6Hc+tBDfAcwEY64Rnxpbeiq7Pfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748017; c=relaxed/simple;
	bh=Pwb1sUUoKZW6YO5IHblpVUIzsLaH2y6g3Nw9Wd75mHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7/yabB1iTIcMsu5fllDhR/ITmMdSgqXQinjKnL8LAB1bsOnhFtS013MvcHlPAEhc4GhXhRdpJv/TMjjXfkKXRkgG685Nh0yJIhis5auPoVLZJDaR/Wu4EiSXYyyS5qIWD3e+vqlrdv1VyIAULIew50XB1oWnTIzA+VD/2YeA5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRGVhUkW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRGVhUkW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767748015; x=1799284015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pwb1sUUoKZW6YO5IHblpVUIzsLaH2y6g3Nw9Wd75mHI=;
  b=SRGVhUkWmBjhxKqIj0IltU+mjuF2nApKmVtrAR1FVaIuIhLSKKya7XNG
   P9+MSsCUjp8Z2CYb92P2qf9NMj8pMN3AUzLe/fv9COwm6f8N8BvMIlver
   /JWDJw1fv2uZF25OcVbA7iDB3B/4OKZT5I8U1H4NLqGsPjro8x6AV9794
   dQ4bG9zD98UqTtVO0drYNMj/xDN1eHmBaE0wi5gl01ZGPOPcQrE99ghfa
   874m/MED8OIL3ibo1HDOUsIeK49cSDZVjuY3qOZfMYPHm8iiAGMI1Cx/E
   hX8Zyghlvxp77ODD5nLQoFtwqfvVMalFVLQPrpVeyXf+YGSxmWcMxNixl
   A==;
X-CSE-ConnectionGUID: Us4HNuqqQOWH+pl42bTYWw==
X-CSE-MsgGUID: 4qjH5R7hRT229s3HwL/aPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69019500"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69019500"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 17:06:55 -0800
X-CSE-ConnectionGUID: mdAOQ3UYQ72ckBcFPbcb/g==
X-CSE-MsgGUID: ISPvefs9RA2nd0ZoZ3hFJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207849361"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 17:06:52 -0800
Message-ID: <cf4e38dc-6141-4a28-9d5c-b13ab5d2d390@linux.intel.com>
Date: Wed, 7 Jan 2026 09:06:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Enable core PMU for DMR and NVL
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Not sure if you have a chance to review this patch-set? Thanks a lot.


On 11/20/2025 1:34 PM, Dapeng Mi wrote:
> This patch-set enables core PMU functionalities for Diamond Rapids (DMR)
> and Nova Lake (NVL). 
>
> Comparing with previous platforms, there are 3 main changes on core PMU
> functionalities.
>
> 1. Introduce OFF-MODULE RESPONSE (OMR) facility to replace Off-Core
> Response (OCR) facility
>
> Legacy microarchitectures used the OCR facility to evaluate off-core and
> multi-core off-module transactions. The properly renamed, OMR facility,
> improves the OCR capability for scalable coverage of new memory systems
> of multi-core module systems.
>
> Along with the introduction of OMR, 4 equivalent MSRs (OFFMODULE_RSP_0 ~
> OFFMODULE_RSP_3) are introduced to specify attributes of the off-module
> transaction and the legacy 2 OFFCORE_RSP MSRs are retired.
>
> For more details about OMR events and OFFMODULE_RSP_x MSRs, please refer
> to the section 16.1 "OFF-MODULE RESPONSE (OMR) FACILITY" in latest ISE[1]
> documentation.
>
> 2. New PEBS data source encoding layout
>
> Diamond Rapids and Nova Lake include PEBS Load Latency and Store Latency
> support similar to previous platforms but with a different data source
> encoding layout.
>
> Briefly speaking, the new data source encoding is determined by bit[8] of
> memory auxiliary info field. The bit[8] indicates whether a L2 cache miss
> occurs for a memory load or store instruction. If bit[8] is 0, it
> signifies no L2 cache miss, and bits[7:0] specify the exact cache data
> source (up to the L2 cache level). If bit[8] is 1, bits[7:0] represents
> the OMR encoding, indicating the specific L3 cache or memory region
> involved in the memory access.
>
> A significant enhancement for OMR encoding is the ability to provide
> up to 8 fine-grained memory regions in addition to the cache region,
> offering more detailed insights into memory access regions.
>
> For more details about the new data source layout, please refer to the
> section 16.2 "PEBS LOAD LATENCY AND STORE LATENCY FACILITY" in latest
> ISE documentation.
>
> 3. Support "rdpmc user disable" feature
>
> Currently executing RDPMC when CPL > 0 is allowed if the CR4.PCE flag
> (performance-monitoring counter enable) is set. This introduces a
> security risk that any user space process can read the count of any PMU
> counter even though the counter belongs to a system-wide event as long
> as CR4.PCE = 1.
>
> To mitigate this security risk, the rdpmc user disable feature is
> introduced to provide per-counter rdpmc control.
>
> 'rdpmc user disable' introduces a new bit "RDPMC_USR_DISABLE" to manage
> if the counter can be read in user space by leveraging rdpmc instruction
> for each GP and fixed counter.
>
> The details are
> - New RDPMC_USR_DISABLE bit in each EVNTSELx[37] MSR to indicate counter
>   can't be read by RDPMC in ring 3.
> - New RDPMC_USR_DISABLE bits in bits 33,37,41,45,etc.,
>   in IA32_FIXED_CTR_CTRL MSR for fixed counters 0-3, etc.
> - On RDPMC for counter x, use select to choose the final counter value:
>   If (!CPL0 && RDPMC_USR_DISABLE[x] == 1 ) ? 0 : counter_value
> - RDPMC_USR_DISABLE is enumerated by CPUID.0x23.0.EBX[2].
>
> For more details about "rdpmc user disable", please refer to chapter 15
> "RDPMC USER DISABLE" in latest ISE.
>
> This patch-set adds support for these 3 new changes or features. Besides
> the DMR and NVL specific counter constraints are supported together.
>
> Tests:
>
> The below tests pass on DMR and NVL (both P-core and E-core).
>  a) Perf counting tests pass.
>  b) Perf sampling tests pass.
>  c) Perf PEBS based sampling tests pass.
>  d) "rdpmc user disable" functionality tests pass.
>
> Ref:
>
> ISE (version 60): https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html 
>
> Dapeng Mi (7):
>   perf/x86/intel: Support newly introduced 4 OMR MSRs for DMR & NVL
>   perf/x86/intel: Add support for PEBS memory auxiliary info field in
>     DMR
>   perf/x86/intel: Add core PMU support for DMR
>   perf/x86/intel: Add support for PEBS memory auxiliary info field in
>     NVL
>   perf/x86/intel: Add core PMU support for Novalake
>   perf/x86: Replace magic numbers with macros for attr_rdpmc
>   perf/x86/intel: Add rdpmc-user-disable support
>
>  .../sysfs-bus-event_source-devices-rdpmc      |  40 ++
>  arch/x86/events/core.c                        |  28 +-
>  arch/x86/events/intel/core.c                  | 352 +++++++++++++++++-
>  arch/x86/events/intel/ds.c                    | 261 +++++++++++++
>  arch/x86/events/intel/p6.c                    |   2 +-
>  arch/x86/events/perf_event.h                  |  26 ++
>  arch/x86/include/asm/msr-index.h              |   5 +
>  arch/x86/include/asm/perf_event.h             |   8 +-
>  include/uapi/linux/perf_event.h               |  27 +-
>  tools/include/uapi/linux/perf_event.h         |  27 +-
>  10 files changed, 751 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
>
>
> base-commit: 9929dffce5ed7e2988e0274f4db98035508b16d9
