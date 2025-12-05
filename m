Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0D325496;
	Fri,  5 Dec 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938398; cv=none; b=k2FU7NLLRGt3hrn5ytoz7LfU0/9mmTWjcd7FgOlazr2519+O4JTjcHFy55NIqFQwSfz/lVsJx3FUrtoN0n7UKgqZdwcdJolY0i20z63JrC/cFOFcsVz+gcqJOaYlCMSkqEgRzKbSdRReeiyNE1gGREd4rnUsmDNK4Dxt+TfWuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938398; c=relaxed/simple;
	bh=xxVvjcUtkVRp7x6xp4mzA5/HS3QFr78oZEPUTRca59I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4K1KPlTM43ayNvdPeIBauof7vHEbkTqxm8HqefFH7/yfuzjp0AITStGggaElP70f71T5CyhpP3kYrptPUgmVPOgf4yrdb/o4GRHY2cAw8N3Dg4AsIiYMxf5v7hIVgiGv4RbgOJkHpiSTWmauwVIWN6R2v3ChuG0i3frnQNWw7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uS03fCAB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uS03fCAB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UqHH9JXi4uMJsuL5gORrWrDfDuKfuRVg+UVBEruSwYo=; b=uS03fCABHxwmoaevhNE7Gs0snJ
	fUD5m5dp9LoWuc7Vp3n2KW5kNKshVqfX5ALDr+KSC9rasDXM63CMfD7IHU82z1xn+cBjRfgdGbN7G
	mpYlxnab9slVryV+OprTR4+QgkpPiJ8VB1pQPh54aXQkNd1knLLLAAouO5U1g0EQP6FVJm/bRAGeT
	19eEzxXwNRDleHjwsN+5Y2/hWEIJoui1D52YNYc+V4fS5nKHEhjXR4Q5FQvHXsQhDyf9sLocS0is8
	FUE3q8vphYeyXu30IP/Sd+L6ylx7jBffUgAmd7dn/HXnKKWMQGru92L/YhEbyOPYEOrCUXhZMAfXd
	9K6N9+8w==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRV65-00000005hbP-2TMP;
	Fri, 05 Dec 2025 12:39:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E0DF30027B; Fri, 05 Dec 2025 13:39:40 +0100 (CET)
Date: Fri, 5 Dec 2025 13:39:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v5 16/19] perf/x86: Activate back-to-back NMI detection
 for arch-PEBS induced NMIs
Message-ID: <20251205123940.GY2528459@noisy.programming.kicks-ass.net>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-17-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203065500.2597594-17-dapeng1.mi@linux.intel.com>

On Wed, Dec 03, 2025 at 02:54:57PM +0800, Dapeng Mi wrote:
> When two or more identical PEBS events with the same sampling period are
> programmed on a mix of PDIST and non-PDIST counters, multiple
> back-to-back NMIs can be triggered.

This is a hardware defect -- albeit a fairly common one.


> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index da48bcde8fce..a130d3f14844 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3351,8 +3351,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  	 */
>  	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
>  				 (unsigned long *)&status)) {
> -		handled++;
> -		static_call(x86_pmu_drain_pebs)(regs, &data);
> +		handled += static_call(x86_pmu_drain_pebs)(regs, &data);
>  
>  		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
>  		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))

Note that the old code would return handled++, while the new code:

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index a01c72c03bd6..c7cdcd585574 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2759,7 +2759,7 @@ __intel_pmu_pebs_events(struct perf_event *event,
>  	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
>  }
>  
> -static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
> +static int intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct debug_store *ds = cpuc->ds;
> @@ -2768,7 +2768,7 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
>  	int n;
>  
>  	if (!x86_pmu.pebs_active)
> -		return;
> +		return 0;
>  
>  	at  = (struct pebs_record_core *)(unsigned long)ds->pebs_buffer_base;
>  	top = (struct pebs_record_core *)(unsigned long)ds->pebs_index;
> @@ -2779,22 +2779,24 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
>  	ds->pebs_index = ds->pebs_buffer_base;
>  
>  	if (!test_bit(0, cpuc->active_mask))
> -		return;
> +		return 0;
>  
>  	WARN_ON_ONCE(!event);
>  
>  	if (!event->attr.precise_ip)
> -		return;
> +		return 0;
>  
>  	n = top - at;
>  	if (n <= 0) {
>  		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>  			intel_pmu_save_and_restart_reload(event, 0);
> -		return;
> +		return 0;
>  	}
>  
>  	__intel_pmu_pebs_events(event, iregs, data, at, top, 0, n,
>  				setup_pebs_fixed_sample_data);
> +
> +	return 0;
>  }
>  
>  static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64 mask)
> @@ -2817,7 +2819,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
>  	}
>  }
>  
> -static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
> +static int intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct debug_store *ds = cpuc->ds;
> @@ -2830,7 +2832,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  	u64 mask;
>  
>  	if (!x86_pmu.pebs_active)
> -		return;
> +		return 0;
>  
>  	base = (struct pebs_record_nhm *)(unsigned long)ds->pebs_buffer_base;
>  	top = (struct pebs_record_nhm *)(unsigned long)ds->pebs_index;
> @@ -2846,7 +2848,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  
>  	if (unlikely(base >= top)) {
>  		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
> -		return;
> +		return 0;
>  	}
>  
>  	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
> @@ -2931,6 +2933,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  						setup_pebs_fixed_sample_data);
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static __always_inline void
> @@ -2984,7 +2988,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
>  
>  }
>  
> -static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
> +static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
>  {
>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>  	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
> @@ -2997,7 +3001,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  	u64 mask;
>  
>  	if (!x86_pmu.pebs_active)
> -		return;
> +		return 0;
>  
>  	base = (struct pebs_basic *)(unsigned long)ds->pebs_buffer_base;
>  	top = (struct pebs_basic *)(unsigned long)ds->pebs_index;
> @@ -3010,7 +3014,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  
>  	if (unlikely(base >= top)) {
>  		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
> -		return;
> +		return 0;
>  	}
>  
>  	if (!iregs)
> @@ -3032,9 +3036,11 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  
>  	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
>  					    setup_pebs_adaptive_sample_data);
> +
> +	return 0;
>  }

will now return handled+=0 for all these. Which is a change in
behaviour. Also:

> -static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
> +static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>  				      struct perf_sample_data *data)
>  {
>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
> @@ -3044,13 +3050,14 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>  	struct x86_perf_regs perf_regs;
>  	struct pt_regs *regs = &perf_regs.regs;
>  	void *base, *at, *top;
> +	u64 events_bitmap = 0;
>  	u64 mask;
>  
>  	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
>  
>  	if (unlikely(!index.wr)) {
>  		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
> -		return;
> +		return 0;
>  	}
>  
>  	base = cpuc->pebs_vaddr;
> @@ -3089,6 +3096,7 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>  
>  		basic = at + sizeof(struct arch_pebs_header);
>  		pebs_status = mask & basic->applicable_counters;
> +		events_bitmap |= pebs_status;
>  		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
>  					       pebs_status, counts, last,
>  					       setup_arch_pebs_sample_data);
> @@ -3108,6 +3116,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>  	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
>  					    counts, last,
>  					    setup_arch_pebs_sample_data);
> +
	/*
	 * Comment that explains the arch pebs defect goes here.
	 */
> +	return hweight64(events_bitmap);
>  }
