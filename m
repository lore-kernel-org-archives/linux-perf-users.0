Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4B377023;
	Wed, 12 Aug 2026 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502251; cv=none; b=svE+cClWfA5UKUC06IfQWcQg8X6T9KX+zBRNgXU4t0FWmHzrqRzJlCFg5f2AgE0V/W0T8EMW2Cs9+PwdGijRwcDfp1ZvHW2GXlIlAVwOlI/YK1mnG0EgeutPTYfWP6i5PhD2Ff23j9ly82+y2YRJg9DrU4bKtslqDpFe4w4aIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502251; c=relaxed/simple;
	bh=GdkPLOtjWMOa5mf8kZ+ghm6/2oIvcTPO3ovu6XzA378=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWI8+D8mnWoHjog504+D5eY+3xAJtI5nKQeQ2qO0/PNe2K7KChxrtInlBZWCTE0UJ1ANGenDxh0AOGZS79ktqrlZhSK9cFwPMoyUotX4+KtlKiOLpWE6y8ZTGoT8lXb1tBFHIB/3GR6KykQTiYN7tS9JgIzgo3lvd2tdwXs3CT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imoPrOdi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imoPrOdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786502249; x=1818038249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GdkPLOtjWMOa5mf8kZ+ghm6/2oIvcTPO3ovu6XzA378=;
  b=imoPrOdiLlynQPhlyALQm2Oc5/djNM7ugrbn5JslabvTfCiYvY0duB32
   ulvWZTLQ6SeYIic85tHVk7nQ52VsLdbb4disWjT5/MV/zPiBJ0YtpuI/B
   pocegLo0yzCURRaON2lQ03M36wET81f2h+Qk5BYc2e1/tph2Ojgk2iF/z
   CVc5W8VLCrkif4J6qTWD3vaVUwtiCmLYFiVsZnzQINqOVsiB7XeCnptVB
   LEGF0ZSqI1Cwg8YxITCJZZLAa4D4eYaGX32jbQ0Cgqtxm9zDUaB+IDkh/
   zkI0t46UY/K52npkIdqL9EYyrV1jTUXKl2D/lmwRaQfYY6FEO3jQceruN
   g==;
X-CSE-ConnectionGUID: BVH/MzCdS/CmFlnR/Thzew==
X-CSE-MsgGUID: XdP6T8S3RGKaaypiDqQ8pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="112591215"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="112591215"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 19:37:28 -0700
X-CSE-ConnectionGUID: j26j+WB5ShSzH0eKLs1eOw==
X-CSE-MsgGUID: xeiBoKeNQ/6xPwQwaTcVdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="259240812"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 19:37:23 -0700
Message-ID: <7078a9e7-6493-42b0-b297-ce174effdfb3@linux.intel.com>
Date: Wed, 12 Aug 2026 10:37:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf/x86: Add x86_pmu::print_debug
To: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Petr Tesarik <ptesarik@suse.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <cover.1786010408.git.sandipan.das@amd.com>
 <fc6ff612d26c2f5b0f015d9fac309cc58e913c1f.1786010408.git.sandipan.das@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <fc6ff612d26c2f5b0f015d9fac309cc58e913c1f.1786010408.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/6/2026 6:03 PM, Sandipan Das wrote:
> perf_event_print_debug() dumps the global control and status MSRs
> whenever x86_pmu.version >= 2, reading registers that exist only on
> Intel-compatible PMUs. This is not safe since x86_pmu.version is not
> Intel-specific and is now set by other vendors whose global registers
> use different addresses.
>
> As a first step, split perf_event_print_debug() in two. The register
> dump moves into a new common helper, x86_pmu_print_debug(), leaving
> perf_event_print_debug() to handle the preamble and dispatch to an
> optional x86_pmu::print_debug method. This lets each vendor-specific
> PMU dump its own global state before chaining into the common helper.
> PMUs that do not implement the method, such as those with
> x86_pmu.version < 2, get the common helper alone.
>
> No functional change intended.
>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/events/core.c       | 29 ++++++++++++++++++++++-------
>  arch/x86/events/perf_event.h |  4 ++++
>  2 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index af0b67ffb43d..17dc53a62378 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1557,7 +1557,7 @@ static void x86_pmu_start(struct perf_event *event, int flags)
>  	perf_event_update_userpage(event);
>  }
>  
> -void perf_event_print_debug(void)
> +void x86_pmu_print_debug(int cpu)
>  {
>  	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
>  	unsigned long *cntr_mask, *fixed_cntr_mask;
> @@ -1566,17 +1566,11 @@ void perf_event_print_debug(void)
>  	u64 pebs, debugctl;
>  	int cpu, idx;
>  
> -	guard(irqsave)();
> -
> -	cpu = smp_processor_id();
>  	cpuc = &per_cpu(cpu_hw_events, cpu);
>  	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
>  	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
>  	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
>  
> -	if (!*(u64 *)cntr_mask)
> -		return;
> -
>  	if (x86_pmu.version >= 2) {
>  		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>  		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
> @@ -1622,6 +1616,27 @@ void perf_event_print_debug(void)
>  	}
>  }
>  
> +void perf_event_print_debug(void)
> +{
> +	struct cpu_hw_events *cpuc;
> +	unsigned long *cntr_mask;
> +	int cpu;
> +
> +	guard(irqsave)();
> +
> +	cpu = smp_processor_id();
> +	cpuc = &per_cpu(cpu_hw_events, cpu);
> +	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
> +
> +	if (!*(u64 *)cntr_mask)
> +		return;
> +
> +	if (x86_pmu.print_debug)
> +		x86_pmu.print_debug(cpu);
> +	else
> +		x86_pmu_print_debug(cpu);

The logic looks good, but better change this to the static_call() just like
other x86_pmu callbacks. It eliminates the branch prediction cost. Thanks.


> +}
> +
>  void x86_pmu_stop(struct perf_event *event, int flags)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index a8afea8d38f0..465bf513bb82 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1052,6 +1052,8 @@ struct x86_pmu {
>  	int				num_hybrid_pmus;
>  	struct x86_hybrid_pmu		*hybrid_pmu;
>  	enum intel_cpu_type (*get_hybrid_cpu_type)	(void);
> +
> +	void (*print_debug)(int cpu);
>  };
>  
>  struct x86_perf_task_context_opt {
> @@ -1316,6 +1318,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
>  
>  void x86_pmu_show_pmu_cap(struct pmu *pmu);
>  
> +void x86_pmu_print_debug(int cpu);
> +
>  static inline int x86_pmu_num_counters(struct pmu *pmu)
>  {
>  	return hweight64(hybrid(pmu, cntr_mask64));
