Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A97498913;
	Wed,  9 Sep 2026 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952161; cv=none; b=l9UbHnRoqbjpoD45xLgEZcVqgZ09xlBvzB0eSgjNfsq5rD2i7Jnxol+sbJW7JYjgR399RHQT9Wk6QBZ7QUC2l6tikEFPzmpw2lI2ETLP1Pwkwx9HHu4B5pT0EFMTPy7A1YzMfvl7ZslvnQ6m/CxGPa4ODp0GyCZsTYtNVc3SIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952161; c=relaxed/simple;
	bh=abi+/R1e6E+9aPYOuEIPi75GEQP4y+dpDIaoNPwN0LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHv5BKfgewuxD52Mw2eKO2oz0NpQtD1AcZ1iTo16+zeVjjPfbfa+ajU8RDMP8f6ZcY8+3bNspBvEI9vMuQ4D2THIJvayABWSbRb9QVGGQgV4OVEfsJm4IEhaJxEay+HA3juqP4v9x5f9UO2TcS9xye3uvLF5YIvuRMTcZ8Mhcbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPFdHj32; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPFdHj32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788952159; x=1820488159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=abi+/R1e6E+9aPYOuEIPi75GEQP4y+dpDIaoNPwN0LU=;
  b=dPFdHj326CkD2wqk/ztyxVgU9MmI4g4aDcbpEfHjISk4BemetpnWypLy
   QK9kUlidHik1Alhh25kLQC3bujhQiG6AJf9ZY5NZsbK5Xu14o1zMbou1N
   blhaVfZX+keabtjkPPKkYkBdoUS+fX2W7tVFP/lyJB27ZxGAfG1qMaviO
   zmyyCCsFloiMsk9eaxV4iYaIYi1ZEbqveuyKSAzy9c14oB8bBjYreC8ow
   7attIDWR3WEYChzF0E7zpqdEREnvbMbCYW10etcYzLhUvW3GUkfSeciyu
   8uB1JXQRsJlnuuMnHXhufsjATUKNBaKrrY04wlgBS3VXgdHmg1gVVlmUP
   Q==;
X-CSE-ConnectionGUID: INMS3SCgTX68KKXZGFcang==
X-CSE-MsgGUID: LgNU9gnDTmu/Syej/QD3ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106891239"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106891239"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 04:09:18 -0700
X-CSE-ConnectionGUID: 0fboeuVlQ6qz8NzGOu0B7g==
X-CSE-MsgGUID: ScdIAudqT825YavfGZKC/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="269531793"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 04:09:14 -0700
Message-ID: <d6ccff7d-df31-4308-b60b-8ec5f630415e@linux.intel.com>
Date: Wed, 9 Sep 2026 19:09:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] perf/x86/intel: Prevent drain_pebs() reentry
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260813064346.335458-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260813064346.335458-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Could you please review and queue this patch if it's good enough? This
version addresses your comments. Thanks.


On 8/13/2026 2:43 PM, Dapeng Mi wrote:
> The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
> not be reentered. If so, one instance may observe stale buffer state and
> potentially access out-of-bound memory.
>
> Most invocations happen in NMI context, which naturally prevents reentry.
> However, drain_pebs() is also reachable from process context via
> intel_pmu_drain_pebs_buffer().
>
> In those paths, the PMU is often already disabled, but not guaranteed.
> For example, __intel_pmu_pebs_disable() only disables the target counter,
> so other active counters can still raise a PMI and interrupt an in-flight
> drain_pebs(). Here is an example,
>
> __perf_addr_filters_adjust()
>   perf_event_stop()
>     __perf_event_stop()
>       x86_pmu_stop() (event->pmu->stop)
>         intel_pmu_disable_event()
>           intel_pmu_pebs_disable()
>             __intel_pmu_pebs_disable()
>               intel_pmu_drain_large_pebs()
>                 intel_pmu_drain_pebs_buffer()
>
> Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
> use them in intel_pmu_drain_large_pebs() to disable the full PMU
> around the intel_pmu_drain_pebs_buffer() call, preventing reentry.
>
> Also add a warning in intel_pmu_drain_pebs_buffer() when the full PMU is
> not disabled.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>
> v2: Move __intel_pmu_quiesce()/__intel_pmu_resume() pair into
> intel_pmu_drain_large_pebs() instead of guarding all drain_pebs()
> callbacks. (Peter)
>
> v1: https://lore.kernel.org/all/20260717080342.1879573-9-dapeng1.mi@linux.intel.com/
>
>  arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++---------
>  arch/x86/events/intel/ds.c   |  8 +++++++-
>  arch/x86/events/perf_event.h |  3 +++
>  3 files changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index f6ee1819864e..1cdb52c0aad5 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3125,6 +3125,27 @@ static void intel_pmu_del_event(struct perf_event *event)
>  		this_cpu_ptr(&cpu_hw_events)->n_late_setup--;
>  }
>  
> +int __intel_pmu_quiesce(void)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int pmu_enabled = cpuc->enabled;
> +
> +	cpuc->enabled = 0;
> +	if (pmu_enabled)
> +		intel_pmu_disable_all();
> +
> +	return pmu_enabled;
> +}
> +
> +void __intel_pmu_resume(int pmu_enabled)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	cpuc->enabled = pmu_enabled;
> +	if (pmu_enabled)
> +		intel_pmu_enable_all(0);
> +}
> +
>  static int icl_set_topdown_event_period(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -3316,16 +3337,13 @@ static void intel_pmu_read_event(struct perf_event *event)
>  	if (event->hw.flags & (PERF_X86_EVENT_AUTO_RELOAD | PERF_X86_EVENT_TOPDOWN) ||
>  	    is_pebs_counter_event_group(event)) {
>  		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -		bool pmu_enabled = cpuc->enabled;
> +		int pmu_enabled;
>  
>  		/* Only need to call update_topdown_event() once for group read. */
>  		if (is_metric_event(event) && (cpuc->txn_flags & PERF_PMU_TXN_READ))
>  			return;
>  
> -		cpuc->enabled = 0;
> -		if (pmu_enabled)
> -			intel_pmu_disable_all();
> -
> +		pmu_enabled = __intel_pmu_quiesce();
>  		/*
>  		 * If the PEBS counters snapshotting is enabled,
>  		 * the topdown event is available in PEBS records.
> @@ -3334,10 +3352,7 @@ static void intel_pmu_read_event(struct perf_event *event)
>  			static_call(intel_pmu_update_topdown_event)(event, NULL);
>  		else
>  			intel_pmu_drain_pebs_buffer();
> -
> -		cpuc->enabled = pmu_enabled;
> -		if (pmu_enabled)
> -			intel_pmu_enable_all(0);
> +		__intel_pmu_resume(pmu_enabled);
>  
>  		return;
>  	}
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index e86e4ba91e1b..54890dda0589 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1242,8 +1242,11 @@ int intel_pmu_drain_bts_buffer(void)
>  
>  void intel_pmu_drain_pebs_buffer(void)
>  {
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct perf_sample_data data;
>  
> +	WARN_ON_ONCE(cpuc->enabled);
> +
>  	static_call(x86_pmu_drain_pebs)(NULL, &data);
>  }
>  
> @@ -1864,8 +1867,11 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
>  static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
>  {
>  	if (cpuc->n_pebs == cpuc->n_large_pebs &&
> -	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
> +	    cpuc->n_pebs != cpuc->n_pebs_via_pt) {
> +		int enabled = __intel_pmu_quiesce();
>  		intel_pmu_drain_pebs_buffer();
> +		__intel_pmu_resume(enabled);
> +	}
>  }
>  
>  static void __intel_pmu_pebs_enable(struct perf_event *event)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fa381110f7a7..84495279079a 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1638,6 +1638,9 @@ static __always_inline void __intel_pmu_lbr_disable(void)
>  	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
>  }
>  
> +extern int __intel_pmu_quiesce(void);
> +extern void __intel_pmu_resume(int pmu_enabled);
> +
>  int intel_pmu_save_and_restart(struct perf_event *event);
>  
>  struct event_constraint *
>
> base-commit: 917d558b151cad5b05991e5eaee22efab33525ca
