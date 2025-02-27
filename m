Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008B270047;
	Thu, 27 Feb 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665214; cv=none; b=hSpJL7+LbWmOCSUg54dJNuP8D7EN9a0D96ToH54g0iGbMOt5F1ILDdDd/DRpjAV/LotXbmsJtg0yIM9bvEK1o9PhvrQA6EZrBoX/sw8o+VUJp5Ru+lLPaHRctqkRSJun4CPQ1OGGTWue/QISBOlZ/fHzzFTcHrk2Fvgm60u+5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665214; c=relaxed/simple;
	bh=42WdhgXhdDMPXhJ4DI29Tw36HeAU88JIQbz7zLd0iqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lE5pDothkzhLHflXKOowP5lWG8kJJgcCJ8mZfYXn6ebnQETVEM2wmBOYudF1yOZQAIqdffnsV/tCvHt1tdqPJPfo73PQWRygsvr7wkPrlcGjXM4zHYjokt2ZyaOBBYJTWLsyU1k1LA/N0KZdqpO+T10z2cXD59L/Ur9I7JXRHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUER0pru; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUER0pru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665212; x=1772201212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=42WdhgXhdDMPXhJ4DI29Tw36HeAU88JIQbz7zLd0iqQ=;
  b=KUER0pru0AOon9chZQZOI8ts7jfnDECsuemFwrFDPbJrcWlzbIZLNv+g
   zVRafDQzVX0hq0mu6LhBVHM25DC40VbjGVPPy9ZajTIn22b0S4v9BglPL
   OqgiRCnJHOsq6C7BNhF+txfzAKlvLTdZ9TFkUW+Qat4VIPuKkOroWUqJ7
   P2PYlaS6Ncpqf/Hc6JuTxxbmkWNvZJ5EgVJa9OFhM3BVxvZRiOmt2HNLa
   x+HvrCFwHL1A1UFAifSqCApjCef9uN9vgvkJ9968+W49kJk7j/iYl50sK
   tOMY7ggVezH1Otya1TGcKRrunUZv/jJ++FL8OIv7NMNz5WLzvGmZm2XSH
   w==;
X-CSE-ConnectionGUID: ZhOuLE8sQkOWebt0vlN6iw==
X-CSE-MsgGUID: Z97zpZdxTXKgPOd0YE7HeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41752955"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41752955"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:49 -0800
X-CSE-ConnectionGUID: kMdXKLKDTRGPJH9PLlHl8A==
X-CSE-MsgGUID: gZIzw05fTxGpUaQSHKHAbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="122151921"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:48 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 679FB20B5713;
	Thu, 27 Feb 2025 06:06:46 -0800 (PST)
Message-ID: <afdc5b07-9795-4049-8941-c2e3d2bbaa87@linux.intel.com>
Date: Thu, 27 Feb 2025 09:06:45 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 13/24] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-14-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250218152818.158614-14-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-18 10:28 a.m., Dapeng Mi wrote:
> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
> sampling and precise distribution PEBS sampling. Thus PEBS constraints
> should be dynamically configured base on these counter and precise
> distribution bitmap instead of defining them statically.
> 
> Update event dyn_constraint base on PEBS event precise level.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 6 ++++++
>  arch/x86/events/intel/ds.c   | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 472366c3db22..c777e0531d40 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4033,6 +4033,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		return ret;
>  
>  	if (event->attr.precise_ip) {
> +		struct arch_pebs_cap pebs_cap = hybrid(event->pmu, arch_pebs_cap);
> +
>  		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
>  			return -EINVAL;
>  
> @@ -4046,6 +4048,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		}
>  		if (x86_pmu.pebs_aliases)
>  			x86_pmu.pebs_aliases(event);
> +
> +		if (x86_pmu.arch_pebs)
> +			event->hw.dyn_constraint = event->attr.precise_ip >= 3 ?
> +						   pebs_cap.pdists : pebs_cap.counters;
>  	}

The dyn_constraint is only required when the counter mask is different.
I think the pebs_cap.counters should be very likely the same as the
regular counter mask. Maybe something as below (not test).

	if (x86_pmu.arch_pebs) {
		u64 cntr_mask = event->attr.precise_ip >= 3 ?
				pebs_cap.pdists : pebs_cap.counters;
		if (cntr_mask != hybrid(event->pmu, intel_ctrl))
			event->hw.dyn_constraint = cntr_mask;
	}


Thanks,
Kan
>  
>  	if (needs_branch_stack(event)) {
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 519767fc9180..615aefb4e52e 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2948,6 +2948,7 @@ static void __init intel_arch_pebs_init(void)
>  	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
>  	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
>  	x86_pmu.pebs_capable = ~0ULL;
> +	x86_pmu.flags |= PMU_FL_PEBS_ALL;
>  
>  	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
>  	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;

