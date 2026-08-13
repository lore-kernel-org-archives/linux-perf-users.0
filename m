Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B1305693;
	Thu, 13 Aug 2026 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786583529; cv=none; b=htCx32ZwE4tRQAPPMakG4Iiyoqv8GYu5L5nUAnbYmq58EY4ZCu4ITz4xyWXobI+Ck21lYSNXzoSHEiYUcTvzncsVDAz0y5EM8VoY4ZW53QoamIf3i/idFOXDEOpR6AKdL0FJ/mg+K+zeoSiLUE1YpkZgReRdeqk104hgTqn6Jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786583529; c=relaxed/simple;
	bh=c2p0Ko7wRweMEqEAcFDEHOplLdWgcrMXy2aWgmoweUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFWk87lURmSyMXon50Wqcs4HXyMffcjcGVbDeEzlNFAX0Px3p1qZHorZXcfdVCSxBGaOa3zMF8j3QtQx1qlWt8R7pkGXN5eaCJFZz9slHvoRnT4Hr5fa2mXICpWj4V63xATxwQ+U739OYAkZo+RCPPV7XnUarCu4lY9ArHKgCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbndbDhI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbndbDhI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786583527; x=1818119527;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c2p0Ko7wRweMEqEAcFDEHOplLdWgcrMXy2aWgmoweUY=;
  b=PbndbDhIrTLHVSyCF+2Ir8hTNE9PWaia1pTAemDLBUkq1Z4Ts+q+4jg+
   kbdtugDuNKEuWESx5cpYfATy8P6uhiNYoil4yTFn24TsgkcckCLpNC6mX
   6deBPk1XtZzwT7bSMOXN6dvi/V7i8jbqMYXfo/qBKM48BAnGCNnhf1Hnd
   T+TAPRfsPzpoHOpZy0KbUlBLG8YMPcmOjYi9XOPoWBIn4IYoCptYt9KAf
   /9Z9imIluHp3G2lwIcXNa3qPl+JIh2uGcsbxbG2IaIECE7vr53HLMCPTJ
   IL++tZQ27jpOKV5kK7krhErWrHBY0FM4Nb7uZ/DA0IezPW6UwfEkVd2bD
   A==;
X-CSE-ConnectionGUID: eixco+hhSx+EBuxzjIfREQ==
X-CSE-MsgGUID: BRL2DVJ4ShuALy1BA5eGow==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="91028816"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="91028816"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 18:12:03 -0700
X-CSE-ConnectionGUID: 8IfhrGDRTVyFd49W4xvU0w==
X-CSE-MsgGUID: W0T/beFCR4GVodzJgXKEPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="265782323"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 18:11:59 -0700
Message-ID: <10abc792-cf41-477e-9864-66145747da2f@linux.intel.com>
Date: Thu, 13 Aug 2026 09:11:41 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 8/8] perf/x86/intel: Prevent drain_pebs() reentry
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-9-dapeng1.mi@linux.intel.com>
 <20260810130130.GX776954@noisy.programming.kicks-ass.net>
 <da08527f-642b-4f77-89a6-43f42e12d114@linux.intel.com>
 <20260811082256.GT48970@noisy.programming.kicks-ass.net>
 <8a1b03a0-c45e-4a86-af20-bcd15ccb7f8e@linux.intel.com>
 <20260812151827.GO776954@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260812151827.GO776954@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/12/2026 11:18 PM, Peter Zijlstra wrote:
> On Tue, Aug 11, 2026 at 06:00:43PM +0800, Mi, Dapeng wrote:
>
>>> So what specific callchain is going sideways?
>> But for the helper __intel_pmu_pebs_disable(), it seems the whole PMU is
>> not disabled, only the target counter has been stopped. Here is one call-chain.
>>
>> __perf_addr_filters_adjust()
>>   perf_event_stop()
>>     __perf_event_stop()
>>       x86_pmu_stop() (event->pmu->stop)
>>         intel_pmu_disable_event()
>>           intel_pmu_pebs_disable()
>>             __intel_pmu_pebs_disable()
>>               intel_pmu_drain_large_pebs()
>>                 intel_pmu_drain_pebs_buffer()
>>
> Right, so that needs to be included in the changelog. Also, lets target
> that more specifically.

Sure.

>
> How about something like so?

It looks good to me. Would post a new version. Thanks.


>
> ---
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index db92ded774dd..e092ef6e37f4 100644
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
> +void __intel_pmu_resume(bool pmu_enabled)
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
> index 8c0b32ffab35..c7848c4cabae 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1644,6 +1644,9 @@ static __always_inline void __intel_pmu_lbr_disable(void)
>  	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
>  }
>  
> +extern int __intel_pmu_quiesce(void);
> +extern void __intel_pmu_resume(bool pmu_enabled);
> +
>  int intel_pmu_save_and_restart(struct perf_event *event);
>  
>  struct event_constraint *
>
