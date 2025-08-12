Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885C28EA72;
	Tue, 12 Aug 2025 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956818; cv=none; b=Jw3ATpIllridUm1FyTtZxqFgiYxaZ7hxddqfLCHRYYXTyhAYD5jKOIiAMZbNmddrlkvX9bDn5QNO+jKz4zwksYL9jaa72MQfLG4g1CpkaSySqpg0msqyV28kb1e08VW7iCdfp+3BnrQ9X9eneHOQk2tmqoM5Cvowgpe0V8PAVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956818; c=relaxed/simple;
	bh=JKSS5BhhnouCxp94xQ9hwJyMDXsBN6DcFUARmFsQeK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwUks/uY5L6jJSnuVmy7FtrPYKZCxVFYq5+Dy5VYF4om6EkAC726ccnWf+nKiL8ZYcbkakX0P+nPspJC12mopja6erFbyKC0Ci7Hja3/kDN4iOcgnHtoqKoFJ2qPZW49u2HC1pCEipYBccyJ3/HwoHi9bJCHpUNzH/sYJZEFc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/x1B/D5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/x1B/D5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754956817; x=1786492817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JKSS5BhhnouCxp94xQ9hwJyMDXsBN6DcFUARmFsQeK0=;
  b=D/x1B/D5qd5lyE9qr/Lzyeapxx/v4hoX4S97ipFQqdYObzX9Jv4uzCc+
   qHsp+7/RrHtS6PC0kZZ42Ep5Jk0wkq4jLT/Y1YhktDPoq5hUewOsHegdM
   I5z+3q7rkDwZ+ueeIYxGgX1OqYRsxGvDAusI7GXaHtIvulzSKAm/wCY5M
   /D81daOp+uh63YEAT4AJerSENhzg40F+xFfENKRy5a5Wm1Wlmlir2EJGq
   0qJtDbXAdCLpajRPU/tn8rz429JdKrg3HXrlPGtfaZemxmrqFQcOcRL70
   kSFFary8QKFogVqMX+xWcJ7X8OWz4CGPtstxcKyLmHMbuGLPVKgE7c+3x
   Q==;
X-CSE-ConnectionGUID: IHxzdF7ySNOgG+4WtX4jkA==
X-CSE-MsgGUID: yurOA08iQeG2khHBm8hgCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68592842"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68592842"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 17:00:16 -0700
X-CSE-ConnectionGUID: 7iLeg3hORT2dJ4onOUtL+A==
X-CSE-MsgGUID: bH/qdpoeQYisIC0QF+LT8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166340782"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 17:00:16 -0700
Received: from [10.124.35.105] (kliang2-mobl1.ccr.corp.intel.com [10.124.35.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0F1FE20B571C;
	Mon, 11 Aug 2025 17:00:15 -0700 (PDT)
Message-ID: <8c32c5be-02a4-4f4c-9a81-1afe649e88bb@linux.intel.com>
Date: Mon, 11 Aug 2025 17:00:14 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 6/6] perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into
 INTEL_FIXED_BITS_MASK
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
 <20250811090034.51249-7-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250811090034.51249-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-11 2:00 a.m., Dapeng Mi wrote:
> ICL_FIXED_0_ADAPTIVE is missed to be added into INTEL_FIXED_BITS_MASK,
> add it and opportunistically refine fixed counter enabling code.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>  arch/x86/events/intel/core.c      | 10 +++-------
>  arch/x86/include/asm/perf_event.h |  6 +++++-
>  arch/x86/kvm/pmu.h                |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index cdd10370ed95..1a91b527d3c5 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2849,8 +2849,8 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct hw_perf_event *hwc = &event->hw;
> -	u64 mask, bits = 0;
>  	int idx = hwc->idx;
> +	u64 bits = 0;
>  
>  	if (is_topdown_idx(idx)) {
>  		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> @@ -2889,14 +2889,10 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
>  
>  	idx -= INTEL_PMC_IDX_FIXED;
>  	bits = intel_fixed_bits_by_idx(idx, bits);
> -	mask = intel_fixed_bits_by_idx(idx, INTEL_FIXED_BITS_MASK);
> -
> -	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip) {
> +	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip)
>  		bits |= intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
> -		mask |= intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
> -	}
>  

This changes the behavior. The mask will always include the ADAPTIVE bit
even on a platform which doesn't support adaptive pebs.
The description doesn't mention why it's OK.

Thanks,
Kan> -	cpuc->fixed_ctrl_val &= ~mask;
> +	cpuc->fixed_ctrl_val &= ~intel_fixed_bits_by_idx(idx, INTEL_FIXED_BITS_MASK);
>  	cpuc->fixed_ctrl_val |= bits;
>  }
>  
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index f8247ac276c4..49a4d442f3fc 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -35,7 +35,6 @@
>  #define ARCH_PERFMON_EVENTSEL_EQ			(1ULL << 36)
>  #define ARCH_PERFMON_EVENTSEL_UMASK2			(0xFFULL << 40)
>  
> -#define INTEL_FIXED_BITS_MASK				0xFULL
>  #define INTEL_FIXED_BITS_STRIDE			4
>  #define INTEL_FIXED_0_KERNEL				(1ULL << 0)
>  #define INTEL_FIXED_0_USER				(1ULL << 1)
> @@ -48,6 +47,11 @@
>  #define ICL_EVENTSEL_ADAPTIVE				(1ULL << 34)
>  #define ICL_FIXED_0_ADAPTIVE				(1ULL << 32)
>  
> +#define INTEL_FIXED_BITS_MASK					\
> +	(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |		\
> +	 INTEL_FIXED_0_ANYTHREAD | INTEL_FIXED_0_ENABLE_PMI |	\
> +	 ICL_FIXED_0_ADAPTIVE)
> +
>  #define intel_fixed_bits_by_idx(_idx, _bits)			\
>  	((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
>  
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index ad89d0bd6005..103604c4b33b 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -13,7 +13,7 @@
>  #define MSR_IA32_MISC_ENABLE_PMU_RO_MASK (MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL |	\
>  					  MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
>  
> -/* retrieve the 4 bits for EN and PMI out of IA32_FIXED_CTR_CTRL */
> +/* retrieve a fixed counter bits out of IA32_FIXED_CTR_CTRL */
>  #define fixed_ctrl_field(ctrl_reg, idx) \
>  	(((ctrl_reg) >> ((idx) * INTEL_FIXED_BITS_STRIDE)) & INTEL_FIXED_BITS_MASK)
>  

