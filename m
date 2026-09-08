Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2035B47ACD2;
	Tue,  8 Sep 2026 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857385; cv=none; b=u0IY6PtPfprQf7yx/Wg8t9lxzQ4nng9q/BcyRZfigIziGHEfyLfyZ7CJOJYT/OfQF9+dJDoQdrmsoBKCZoialMIqoLhwe4HSZdUC6l1plIhL8v8mbPXI98FEfZ8rrKEVtIHucQ89oaHfhBec3mKnH00iNM2FZkeFPBW3Kt6ADEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857385; c=relaxed/simple;
	bh=a10j1+uGORR5NCsv5a5fchz30gQ8pvkMnklgGvkhqMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFXivORetn3SKNV7GBAT0n6a6nbR1Qm+PA2ZpMOAlILOcexBRxPu06OKDLArmCgLhGudNu4Ew7v2lZ9XAjHovFg71ZowztG36pGZ8jagsPG2AacIpC0T0eNP/GOn3qK7nCgxrXQSiRd+vkw+whJVth68Zey6kK6M/vgoQNFTXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7TkpXH6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7TkpXH6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788857381; x=1820393381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a10j1+uGORR5NCsv5a5fchz30gQ8pvkMnklgGvkhqMM=;
  b=c7TkpXH6sM5DP3OKwUaUb1YWhK906Yz0ElB0lujUCJTpqZAGZbdkYHGe
   aX0TkgyfVim5zWTIKR+qenzgfDv+IKH7rt1rdW9cYgaI6YqRSu7xhJkXI
   YVYT2iYVG9e2Skb2R4fi/NanXlavP3+YxaherP9GTI2pO9h95IJf4cLk/
   rNt9Pi3f07x4jJbFxHrVP1HqoguF4QwiNyhnTqekCY0UFREI46x779bEg
   iRwgFJmuElKq6h0txhMzhc8p5vrKsH5XsrlC47DYNMjx4fKe5dHhNhHbS
   fwBGkOilFQjJH9qkbbMwlt/9zkzvXOKPz8J9RhMxhxy0RNTaCuoxQVfFh
   A==;
X-CSE-ConnectionGUID: AXJo9JMVT2mQCuxsd2UopA==
X-CSE-MsgGUID: PhMuNqgtQp6LN8PxTYPXVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="114792614"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="114792614"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:49:38 -0700
X-CSE-ConnectionGUID: sSP10CB6S56dADztfFsYsA==
X-CSE-MsgGUID: U/PjsH+zSoeFMqAUFBAyGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="268360210"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:49:34 -0700
Message-ID: <49739797-7f6e-4723-80d1-606df19a38df@linux.intel.com>
Date: Tue, 8 Sep 2026 16:49:31 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Gennady Kupava <gennady.kupava@gmail.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The patch is only validated on Intel platforms. @Ravi may help to validate
on AMD platforms. Thanks.

On 9/8/2026 3:51 PM, Dapeng Mi wrote:
> PERF_SAMPLE_STACK_USER needs to return the user stack and user registers
> to user space when the PMI exits. Since the skid from the PEBS/IBS sample
> and PMI delivery, the PEBS/IBS register snapshot (especially IP/SP/BP)
> can diverge from the user stack at PMI return. That mismatch breaks DWARF
> unwinding.
>
> Precise sampling provides no benefit in this case, so disable PEBS/IBS
> precise sampling and allow only PMI-based sampling when
> PERF_SAMPLE_STACK_USER is requested.
>
> Reported-by: Gennady Kupava <gennady.kupava@gmail.com>
> Closes: https://lore.kernel.org/all/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com/
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Fixes: c5ebcedb566e ("perf: Add ability to attach user stack dump to sample")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/amd/ibs.c    |  3 +++
>  arch/x86/events/core.c       |  3 +++
>  arch/x86/events/perf_event.h | 19 +++++++++++++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3531f9c23b8c..c67b659d64e2 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -327,6 +327,9 @@ static int perf_ibs_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
>  
> +	if (!x86_pmu_allow_sample_user_stack(event, true))
> +		return -EINVAL;
> +
>  	/* handle exclude_{user,kernel} in the IRQ handler */
>  	if (event->attr.exclude_host || event->attr.exclude_guest ||
>  	    event->attr.exclude_idle)
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 8b3ea0adb965..ceb5038d7565 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -594,6 +594,9 @@ int x86_pmu_hw_config(struct perf_event *event)
>  		/* There's no sense in having PEBS for non sampling events: */
>  		if (!is_sampling_event(event))
>  			return -EINVAL;
> +
> +		if (!x86_pmu_allow_sample_user_stack(event, false))
> +			return -EINVAL;
>  	}
>  	/*
>  	 * check that PEBS LBR correction does not conflict with
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 71ed5b2acea2..9fbcf2bcef51 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1274,6 +1274,25 @@ static inline bool is_counter_pair(struct hw_perf_event *hwc)
>  	return hwc->flags & PERF_X86_EVENT_PAIR;
>  }
>  
> +static inline bool
> +x86_pmu_allow_sample_user_stack(struct perf_event *event, bool ibs)
> +{
> +	if (!(event->attr.sample_type & PERF_SAMPLE_STACK_USER))
> +		return true;
> +
> +	/*
> +	 * PERF_SAMPLE_STACK_USER needs to return the user stack and
> +	 * user registers to user space when the PMI exits. Since the skid
> +	 * from the PEBS/IBS sample and PMI delivery, the PEBS/IBS register
> +	 * snapshot (especially IP/SP/BP) can diverge from the user stack
> +	 * at PMI return. That mismatch breaks DWARF unwinding.
> +	 *
> +	 * Therefore, disable precise sampling for PERF_SAMPLE_STACK_USER
> +	 * and permit only PMI-based sampling for this case.
> +	 */
> +	return !(event->attr.precise_ip || ibs);
> +}
> +
>  static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
>  					  u64 enable_mask)
>  {
