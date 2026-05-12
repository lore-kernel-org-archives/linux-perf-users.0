Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE27081A;
	Tue, 12 May 2026 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561897; cv=none; b=nVTRH3Tzq1ShYj64lucmTZ4ZW+vjccjt3B4ddXvYGfSCGZkygp16IKF1Us8mUkxehaQA3nfFGOBCJcpORnot9CjcYtmWVXVCl8Uk+7Iy33bM6WUzb+2TUwuhJd8mZ4CW9nEo0niJAEYkMoXwdjWyZm8OMP7VWepdVahwOvajlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561897; c=relaxed/simple;
	bh=Rq3A9TpzV4PfaUjtKb6pd+c7T9xiNyXzG4S0qXGPM+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXGoUj7/FQNiKRPlsyytIVNOFAwqqsihDXb7vQX4LbS3JwBu63Zd7IlwAing7KHUHVoDJbNmPDZUlLSnMJpfhwWzwCZSOt6R8n836bofug60SZNZD9lVUVMP6AylIdyyv2JAxJZp9p5OW2zcyOzkjz8qz/EHI4qHovBjMAxSo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dV8xaSlz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dV8xaSlz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778561897; x=1810097897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rq3A9TpzV4PfaUjtKb6pd+c7T9xiNyXzG4S0qXGPM+8=;
  b=dV8xaSlzM4WNpzVzjRR7zOWpHcxCnMB+mUwYB51o5lvMnYTjAkkmjmWC
   vGDsM2p5u5jQaqAyGNvuV5gZJLmO5jXOQvmUH+2RhhA/VvED2tne+CYHB
   wU+cBGCJhZbJeroN4PLb7/8609xKFlQSi3JTmxRJMRzVyEqAiouxSXkQ5
   VVXoLwsGrs4AkXHSCCXPRZ3aDyjsuWrGLDwSTfd3Yj2//NrFNGl3oBH2v
   rr1ufiLmO728sxZATfE5ufMqqRlXGrdb6FXxCvwb0+0E/zWATi939/IEO
   6+CNGsAVKFx9UaiCuooS+f3cq0KB2jqKEtO31uu/7Uy0DCPpT4X8o438w
   A==;
X-CSE-ConnectionGUID: 4iHGATx+QIW0FZ/exM/5NA==
X-CSE-MsgGUID: CiFXx6fRT5ivT/aHjfRGOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79484122"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79484122"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:58:16 -0700
X-CSE-ConnectionGUID: +TrmWw19S72nTd2Gp0SdXQ==
X-CSE-MsgGUID: gqOwbWe6RwyGo7byWtraPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234994028"
Received: from unknown (HELO [10.238.3.169]) ([10.238.3.169])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:58:11 -0700
Message-ID: <0fbd4abc-a767-4dfe-91e4-f40a17ab707d@linux.intel.com>
Date: Tue, 12 May 2026 12:58:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] perf/x86/intel: Invert names of
 intel_ctrl_{guest,host}_mask
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Stephane Eranian <eranian@google.com>
References: <20260508231353.406465-1-seanjc@google.com>
 <20260508231353.406465-6-seanjc@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260508231353.406465-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/9/2026 7:13 AM, Sean Christopherson wrote:
> Rename intel_ctrl_{guest,host}_mask to intel_ctrl_exclude_{host,guest}_mask
> to more accurately capture what they actually track.  Specifically, an
> event that is excluded from the guest is NOT guaranteed to count in the
> host, and vice versa, as it legal (albeit bizarre) to configure an event to
> exclude both the host and the guest, i.e. to not count at all.
>
> Subjectively (though anyone who disagrees is wrong), aligning with
> perf_event_attr.exclude_{guest,host} also makes all related code much
> easier to follow.
>
> No functional change intended.
>
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 22 +++++++++++-----------
>  arch/x86/events/intel/lbr.c  |  2 +-
>  arch/x86/events/perf_event.h |  4 ++--
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index e9f5a6143e71..7f7c7927b70b 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2535,7 +2535,7 @@ static void __intel_pmu_enable_all(int added, bool pmi)
>  	}
>  
>  	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL,
> -	       intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
> +	       intel_ctrl & ~cpuc->intel_ctrl_exclude_host_mask);
>  
>  	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask)) {
>  		struct perf_event *event =
> @@ -2733,9 +2733,9 @@ static inline void intel_set_masks(struct perf_event *event, int idx)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
>  	if (event->attr.exclude_host)
> -		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
> +		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_host_mask);
>  	if (event->attr.exclude_guest)
> -		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
> +		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_guest_mask);
>  	if (event_is_checkpointed(event))
>  		__set_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
>  }
> @@ -2744,8 +2744,8 @@ static inline void intel_clear_masks(struct perf_event *event, int idx)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
> -	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
> -	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
> +	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_host_mask);
> +	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_guest_mask);
>  	__clear_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
>  }
>  
> @@ -3473,7 +3473,7 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
>  				      struct perf_sample_data *data)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	u64 guest_pebs_idxs = cpuc->pebs_enabled & ~cpuc->intel_ctrl_host_mask;
> +	u64 guest_pebs_idxs = cpuc->pebs_enabled & ~cpuc->intel_ctrl_exclude_guest_mask;
>  	struct perf_event *event = NULL;
>  	int bit;
>  
> @@ -5013,8 +5013,8 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  	global_ctrl = (*nr)++;
>  	arr[global_ctrl] = (struct perf_guest_switch_msr){
>  		.msr = MSR_CORE_PERF_GLOBAL_CTRL,
> -		.host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
> -		.guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
> +		.host = intel_ctrl & ~cpuc->intel_ctrl_exclude_host_mask,
> +		.guest = intel_ctrl & ~cpuc->intel_ctrl_exclude_guest_mask & ~pebs_mask,
>  	};
>  
>  	if (!x86_pmu.ds_pebs)
> @@ -5051,8 +5051,8 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  	 * in the guest, and (d) _are_ excluded from counting in the host.
>  	 */
>  	guest_pebs_mask = pebs_mask & intel_ctrl & kvm_pmu->pebs_enable &
> -			  ~cpuc->intel_ctrl_host_mask &
> -			  cpuc->intel_ctrl_guest_mask;
> +			  ~cpuc->intel_ctrl_exclude_guest_mask &
> +			  cpuc->intel_ctrl_exclude_host_mask;
>  
>  	/*
>  	 * Disable counters where the guest PMC is different than the host PMC
> @@ -5068,7 +5068,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  	 *        What exactly goes wrong if guest and host are using PEBS is
>  	 *        unknown.
>  	 */
> -	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> +	if (pebs_mask & ~cpuc->intel_ctrl_exclude_host_mask)
>  		guest_pebs_mask = 0;
>  
>  	/*
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 72f2adcda7c6..1298049246d7 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -713,7 +713,7 @@ static inline bool vlbr_exclude_host(void)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
>  	return test_bit(INTEL_PMC_IDX_FIXED_VLBR,
> -		(unsigned long *)&cpuc->intel_ctrl_guest_mask);
> +		(unsigned long *)&cpuc->intel_ctrl_exclude_host_mask);
>  }
>  
>  void intel_pmu_lbr_enable_all(bool pmi)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fad87d3c8b2c..cc0aeeb34eb5 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -339,8 +339,8 @@ struct cpu_hw_events {
>  	/*
>  	 * Intel host/guest exclude bits
>  	 */
> -	u64				intel_ctrl_guest_mask;
> -	u64				intel_ctrl_host_mask;
> +	u64				intel_ctrl_exclude_host_mask;
> +	u64				intel_ctrl_exclude_guest_mask;

This looks much straightforward. 

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>  	struct perf_guest_switch_msr	guest_switch_msrs[X86_PMC_IDX_MAX];
>  
>  	/*
