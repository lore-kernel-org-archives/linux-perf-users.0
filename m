Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E6433CB;
	Mon, 27 Jan 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994040; cv=none; b=oBSAOCgZflmV9FHkTX8PBcMpAX91z1FCF3HS7LVdiGcDMDy7dbM8viV+k8ZtFhkslWBhk1qMicjXj8sIafO76LOAu4GRb2zwJYlh/M2yr/8xEDwS+4wh1s1zndwF1A+/qGabYs8YOiitS3UzHdbEKCFZjfZEfgWnXfNSq23hPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994040; c=relaxed/simple;
	bh=Tx4wLNQFH7gc/g1zYRgdMHI1g56pnmIStkrSAuQK4F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhFju+OqttTx25tBoXc1pMCH9XbDn13cOS5LZHZihO9Nem3RRw5KV8I70AOSImPFe/0TbM1YWplaVq0pfClINy0byuGeCrvE0IKZRFRfz7STUHeZN/tOwQvf7eTQyi9Gfiw8h2a2UERuPfAUSJVB6k6TE9OtHKeaLB5oTWdIrxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2Anbbkt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2Anbbkt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737994038; x=1769530038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tx4wLNQFH7gc/g1zYRgdMHI1g56pnmIStkrSAuQK4F4=;
  b=G2AnbbktH4hxoWaqPR/ReSl9Xs8m0dOQpJBxY3m8wanEwM3EjFxCFbNX
   ZLkIqMiNBhEnhri0miQ3HqOh8Fm+Qzxzt+GMuOs3/g9NTymh2Sj0ZWCO4
   aPqrx9pq4k0SqrVakWVCVQZNfPZyX70VTtvu2C29zDJlIEIUWzEGVlXtJ
   icq+mP4iyGVghRiSNqJ9ykpRkeHeRWgR5TBtxlCCmTlx7XA0kmdLb4yn0
   dzafHej7oi5WOQEKYXJYBj4Lo/I1Ane3BZRXqf38LYGzhmJh7G0RTxmOS
   qfPT42xeavnwQW5YemcaN5rP3EwvAL/ddgi7UzN/CVjZm9EmbEN0dwiup
   A==;
X-CSE-ConnectionGUID: xEdLhiqARiiA7qrd3I7mmg==
X-CSE-MsgGUID: +HHU/AO8RneaVpZTPj1Sjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="42215407"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="42215407"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 08:07:17 -0800
X-CSE-ConnectionGUID: HhMfvcNTTrahC9gYT7vcHQ==
X-CSE-MsgGUID: TzEE0HHOSCuLE6g4YZ7fng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112493834"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 08:07:17 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9994820B5713;
	Mon, 27 Jan 2025 08:07:15 -0800 (PST)
Message-ID: <f198c454-ff7c-42eb-80f8-45bc4b94210d@linux.intel.com>
Date: Mon, 27 Jan 2025 11:07:14 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] perf/x86/intel: Setup PEBS constraints base on
 counter & pdist map
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-12-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250123140721.2496639-12-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-23 9:07 a.m., Dapeng Mi wrote:
> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
> sampling and precise distribution PEBS sampling. Thus PEBS constraints
> can be dynamically configured base on these counter and precise
> distribution bitmap instead of defining them statically.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
>  arch/x86/events/intel/ds.c   |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 7775e1e1c1e9..0f1be36113fa 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3728,6 +3728,7 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  			    struct perf_event *event)
>  {
>  	struct event_constraint *c1, *c2;
> +	struct pmu *pmu = event->pmu;
>  
>  	c1 = cpuc->event_constraint[idx];
>  
> @@ -3754,6 +3755,25 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  		c2->weight = hweight64(c2->idxmsk64);
>  	}
>  
> +	if (x86_pmu.arch_pebs && event->attr.precise_ip) {
> +		u64 pebs_cntrs_mask;
> +		u64 cntrs_mask;
> +
> +		if (event->attr.precise_ip >= 3)
> +			pebs_cntrs_mask = hybrid(pmu, arch_pebs_cap).pdists;
> +		else
> +			pebs_cntrs_mask = hybrid(pmu, arch_pebs_cap).counters;
> +
> +		cntrs_mask = hybrid(pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED |
> +			     hybrid(pmu, cntr_mask64);
> +
> +		if (pebs_cntrs_mask != cntrs_mask) {
> +			c2 = dyn_constraint(cpuc, c2, idx);
> +			c2->idxmsk64 &= pebs_cntrs_mask;
> +			c2->weight = hweight64(c2->idxmsk64);
> +		}
> +	}

The pebs_cntrs_mask and cntrs_mask wouldn't be changed since the machine
boot. I don't think it's efficient to calculate them every time.

Maybe adding a local pebs_event_constraints_pdist[] and update both
pebs_event_constraints[] and pebs_event_constraints_pdist[] with the
enumerated mask at initialization time.

Update the intel_pebs_constraints() to utilize the corresponding array
according to the precise_ip.

The above may be avoided.

Thanks,
Kan

> +
>  	return c2;
>  }
>  
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 2f2c6b7c801b..a573ce0e576a 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2941,6 +2941,7 @@ static void __init intel_arch_pebs_init(void)
>  	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
>  	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
>  	x86_pmu.pebs_capable = ~0ULL;
> +	x86_pmu.flags |= PMU_FL_PEBS_ALL;
>  }
>  
>  /*

