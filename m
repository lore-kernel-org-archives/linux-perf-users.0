Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271660;
	b=37o8wqKnCWVZrrTZYdx0/GAYcte/BCHBaKDoMZaQRH0y6JGjZB083Oic780yK1MA1bo5
	 FrO+wOYmkWNTJIPVAcRJWstrmd7Zn2zrkpGCBqIaySDI2v6RQusGMhYaYaGtGdA7DDCAm
	 OkaILvWWRUMg2zOcw2oyVJ3iLpNjtWpc9LhhJemPui7/O6qPm1B2RugCx2+yGRNkpszU4
	 4TMekLTzVc3WfNR/Zso4uW9WZXZA+wtikfq4GJ7KvV5BL40I1jPqRDt/qdA4HQPjr4gih
	 ChvnCcZ4ya5+Hw6KedDy/CQPIHajOkX+jMl99SEUableTGkGShVLgQ7W1ltFPWB20ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271660;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LJlC80NBpBVZnve18vtWH9YMaEY/Vp6Z6lhxrIHLHCA=;
	b=NUwELDjKkhNfhT6ye7VEZq82iubY004EO+sRo+j7nlB3sgGG0mjSkzHjbaXds2I/psKX
	 agQ53eT6Y+wvh8arP759sSgJyd9m6rQlpyc5Fsxy8oWE1DvfM/M9bN6jEyT+9xbfPH01r
	 wv0dAvoN+IIlljEa8rCpk2vicwZTGRmXmWriNIZPwLREFIdMI+RvzJCR1SGBozNIXN16C
	 5BIvL8IuM0KD8Wkd9MUMQKL35y0gVi7wuVR9b1Duepmr79iw6mm2s3zIhUE8SnBh3juve
	 SBfnZGifuYVE/rwTkVa3/eqrwzRD3mGlRSUkI7BtcyJKhHdA3NiExd9e+Dp7NbH257A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=PX3jKVDE;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C5606A322;
	Thu, 29 Oct 2026 11:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F7C5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=PX3jKVDE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LJlC80NBpBVZnve18vtWH9YMaEY/Vp6Z6lhxrIHLHCA=; b=PX3jKVDEA9Z6ADrk4RKY2hhbtd
	nLSlStROcI38rppJJ5H62ICYJsvlfB7R7cbxjBIMR3fWlSlkub/U3QnLCpCDJSX8loGV90Qx5iv57
	jUv9lKeazBJIqrdCtrwGxQ7B8W2E4ZPnNj2eaYvik9C7IPCOdaQd9x0ojVOJ3H2gUfi9h7wpXyMfY
	ebbZroAAar5tUYvNoKSxUEgbrBCkxESf3UuMjCpniAkwYzCz5ESMEsMn9TqWfJ4+aJ9SGRrJ3Bwnz
	ZWuYDYOo3usIWuUlZF/1VKcnUEtY0s5O/PCY8PpXkSKBSqzoMizyqdbh+N4PMvOb3qJbd1q40SUr9
	kylcUfZw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNsF-0000000EXBg-1uBy;
	Thu, 29 Oct 2026 11:00:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6655A300312; Thu, 29 Oct 2026 12:00:46 +0100 (CET)
Date: Thu, 29 Oct 2026 12:00:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v5 13/18] perf/x86/intel: Refresh LBR stack for non-PEBS
 LBR events if needed
Message-ID: <20261029110046.GO1779021@noisy.programming.kicks-ass.net>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-14-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029043914.1395147-14-dapeng1.mi@linux.intel.com>

On Thu, Oct 29, 2026 at 12:39:09PM +0800, Dapeng Mi wrote:
> PEBS and non-PEBS events currently share the same LBR stack,
> cpuc->lbr_stack. In the PMI handler, the non-PEBS path refreshes the
> LBR state before the PEBS buffer is drained.
> 
> When PEBS and non-PEBS LBR events overflow in the same PMI, draining the
> PEBS buffer can overwrite the shared LBR stack with the PEBS snapshot.
> This leaves stale LBR data from the PEBS record in place, and userspace
> may observe the wrong branch stack instead of the live LBR state at PMI
> entry.
> 
> Add a lbr_need_update flag to indicate when the LBR state must be
> refreshed. If PEBS events and non-PEBS LBR events overflow in the same
> PMI, set this flag so the non-PEBS LBR event refreshes the live LBR
> state. Since the LBR state is frozen for the duration of PMI handling, it
> only needs to be read once even when multiple non-PEBS LBR events
> overflow in the same PMI.
> 
> Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 110fff65bd50..37f304a1b48c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3863,8 +3863,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  {
>  	struct perf_sample_data data;
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	int bit;
> +	bool lbr_need_update = false;
>  	int handled = 0;
> +	int bit;
>  
>  	inc_perf_irq_stat();
>  
> @@ -3929,6 +3930,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
>  		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
>  			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
> +
> +		lbr_need_update = true;
>  	}
>  
>  	/*
> @@ -3944,6 +3947,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
>  		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
>  			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
> +
> +		lbr_need_update = true;
>  	}
>  
>  	/*
> @@ -4002,8 +4007,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		 *
>  		 * The PEBS buffer has to be drained before handling the A-PMI
>  		 */
> -		if (is_pebs_counter_event_group(event))
> +		if (is_pebs_counter_event_group(event)) {
>  			static_call(x86_pmu_drain_pebs)(regs, &data);
> +			/*
> +			 * Draining the PEBS buffer can overwrite the shared
> +			 * LBR stack, so mark lbr_need_update as true.
> +			 */
> +			lbr_need_update = true;
> +		}
>  
>  		last_period = event->hw.last_period;
>  
> @@ -4012,8 +4023,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  
>  		perf_sample_data_init(&data, 0, last_period);
>  
> -		if (has_branch_stack(event))
> +		if (has_branch_stack(event)) {
> +			if (lbr_need_update) {
> +				intel_pmu_lbr_read(&cpuc->lbr_stack,
> +					cpuc->lbr_entries, cpuc->lbr_counters);
> +				lbr_need_update = false;
> +			}
>  			intel_pmu_lbr_save_brstack(&data, cpuc, event);
> +		}
>  
>  		x86_pmu_clear_perf_regs(regs);
>  		x86_pmu_update_perf_regs(event, &data, regs, false);

Or... you move intel_pmu_lbr_read() from handle_irq() into pmi_common()
after we done the PEBS things?
