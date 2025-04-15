Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69872DFA5C;
	Tue, 15 Apr 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742877; cv=none; b=sDn/Dz8/qBXh9zhs3T9JaJsYEMPl6ZgTJ1OGaLw+PjLzxXP+gjJERluhmCEBsctLod3v6JAJsURXxVe32i0LrF1bUk3VD+/7sP/uw+1V34C4f1NR4k2opoa5pc71gs1Jph6bHACv43hoJqx8b9rtMNKTZEHwNWqa9kpsWcSxlJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742877; c=relaxed/simple;
	bh=YRPucbupLv7L5SQpYXNvK++dZcGdDzry0G1tMgy83bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF9VGRAyNHElrAb7mNeEgKcp8AvRi65Gurnz3eNIRcrwJyjYE4ip2v1+v4OGxBvnxP7YskKSQZM+eHZsDf14HhZvQoU2N7z2PoVkY+y8stUeed5/nfpz8lsUYVHQWGxuoA/JapagxB8jiC1NL5furx+EQR0MibeekOseK1hjQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zukc0bSq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zukc0bSq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744742876; x=1776278876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YRPucbupLv7L5SQpYXNvK++dZcGdDzry0G1tMgy83bY=;
  b=Zukc0bSqf5jwjzqiRe837zmYmH0SVZ6HV3LphOcGTlR7v8DpOi2xAnW9
   ID7Pnl95gtgbJ79kpPjU7Sp/OmvhlgycdMxTC7MUX49BRiJ75CE/huQ5V
   /t7epEyuvIXWZQnJKkFEMFjovpusUs5GRzkwToJw4tF6hN/b5G40jYzgN
   cXhJ9oyK9YM6n7Cf5W5tsmZZE2khCyqaWbS/JcCgQlC645RgpdOCKhel7
   Vyit0oj2Fo7R9tuVCF550FMunB6YzCZytJkVksSx0dp/DVSb4/rr2KINZ
   uXu9l6uLNWplFvqz0S4HyiITGUuep589NMMtmnk0hGt4gwuLSS3byZaZu
   A==;
X-CSE-ConnectionGUID: V/4b/0T8R8mlrKyGzaceTg==
X-CSE-MsgGUID: E9mLeemkRieIJVIisTsjWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50068837"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="50068837"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 11:47:55 -0700
X-CSE-ConnectionGUID: 6fKp7qaMQ16foLRw6GfU6Q==
X-CSE-MsgGUID: 8kiuUIteQvqhDtaAUM8dHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="161162047"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 11:47:55 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 380A320B5736;
	Tue, 15 Apr 2025 11:47:53 -0700 (PDT)
Message-ID: <7666eeaf-930c-4c4b-bcb8-9767feff10f6@linux.intel.com>
Date: Tue, 15 Apr 2025 14:47:51 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel: Don't clear perf metrics overflow bit
 unconditionally
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415104135.318169-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250415104135.318169-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-15 6:41 a.m., Dapeng Mi wrote:
> The below code would always unconditionally clear other status bits like
> perf metrics overflow bit once PEBS buffer overflows.
> 
>         status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
> 
> This is incorrect. Perf metrics overflow bit should be cleared only when
> fixed counter 3 in PEBS counter group. Otherwise perf metrics overflow
> could be missed to handle.
> 
> Closes: https://lore.kernel.org/all/20250225110012.GK31462@noisy.programming.kicks-ass.net/
> Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

For the two patches,

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0ceaa1b07019..c6f69ce3b2b3 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3140,7 +3140,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	int bit;
>  	int handled = 0;
> -	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
>  
>  	inc_irq_stat(apic_perf_irqs);
>  
> @@ -3184,7 +3183,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		handled++;
>  		x86_pmu_handle_guest_pebs(regs, &data);
>  		static_call(x86_pmu_drain_pebs)(regs, &data);
> -		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
>  
>  		/*
>  		 * PMI throttle may be triggered, which stops the PEBS event.
> @@ -3195,6 +3193,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		 */
>  		if (pebs_enabled != cpuc->pebs_enabled)
>  			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> +
> +		/*
> +		 * Above PEBS handler (PEBS counters snapshotting) has updated fixed
> +		 * counter 3 and perf metrics counts if they are in counter group,
> +		 * unnecessary to update again.
> +		 */
> +		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
> +		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
> +			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
>  	}
>  
>  	/*
> @@ -3214,6 +3221,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
>  	}
>  
> +	status &= hybrid(cpuc->pmu, intel_ctrl);
> +
>  	/*
>  	 * Checkpointed counters can lead to 'spurious' PMIs because the
>  	 * rollback caused by the PMI will have cleared the overflow status
> 
> base-commit: 5c3627b6f0595f1ec27e6f5df903bd072e9b9136

