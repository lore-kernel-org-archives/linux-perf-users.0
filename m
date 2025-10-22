Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BFB32E745;
	Wed, 22 Oct 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133771; cv=none; b=r8oedMvLldJsL5PxnHYRylTA9rXdCLPIeuat+MGLHcIH6NbQvlDTfRFjJXBRTLKb8Vws/uYBET3io4/5gQjoxTwpguCEkvCgblOM4anxvR4lIsnZjMOGyDboleyleZwyhUwFuzlVY3orxHe3HREpVHk4HgzPIJecmev5HPPT1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133771; c=relaxed/simple;
	bh=KnivbPc4Z2ekQldbY1k9O11RMbzSito1tPPROx4DQFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=km5cVottomy3XkHM9nbNFpEMiSVHoNjvtWzAEJuOA4IVSJeIyaJh9miCgRsTQMrsVjRx//sgFP9aRvsO9b+G7ckbia+Bf0tn+Av07BASjtAz5WK6+54a3LtHbw2RKj5wcvC834+1RU9JNHcgRd+FPANhEr26oE/hLSZ+TPuzsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IOL5DxkN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IOL5DxkN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l1x0AilQYrSx229yxEwfmMTRySwBVQwUcACuiygmXLk=; b=IOL5DxkNFVWR8ZUBvDwkOtu9T/
	YeWiK3NcUudIZwvh8jMf/SVNcbEGF/hs8hOJC/M73TIFIkxX4kyNDFzSbL9QTw/J7WKq3HVxW5Dtf
	C9r2XJaZFZv7tVHD8jubqmomLG4tkdW4JUiJkenpEc/XBrgeeiWpVBPhQT1dyx/mjLinrL/2J/+YL
	qQROR9qheHijjJxqdS8Q+fLXiM3XqOR1bfSPxiTNN/GcgYDnXfmAEx0R+0+gagiqQQgeXA9XHxB58
	Vlyd8jjeCRwX+Z0XwYYN0E4SuHEpID0vb75uY6fYAcHbjP3Tv449MFActqrT0ozWuQRlwuGerTE8V
	FpxYIkjg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWTX-00000000VRA-0xwD;
	Wed, 22 Oct 2025 10:53:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 08C3B30039F; Wed, 22 Oct 2025 13:49:18 +0200 (CEST)
Date: Wed, 22 Oct 2025 13:49:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v8 06/12] perf/x86/intel/ds: Factor out PEBS record
 processing code to functions
Message-ID: <20251022114917.GT3245006@noisy.programming.kicks-ass.net>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
 <20251015064422.47437-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015064422.47437-7-dapeng1.mi@linux.intel.com>

On Wed, Oct 15, 2025 at 02:44:16PM +0800, Dapeng Mi wrote:
> Beside some PEBS record layout difference, arch-PEBS can share most of
> PEBS record processing code with adaptive PEBS. Thus, factor out these
> common processing code to independent inline functions, so they can be
> reused by subsequent arch-PEBS handler.
> 
> Suggested-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/ds.c | 101 ++++++++++++++++++++++++-------------
>  1 file changed, 66 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index a80881a20321..41acbf0a11c9 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2629,6 +2629,64 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  	}
>  }
>  
> +static inline void __intel_pmu_handle_pebs_record(struct pt_regs *iregs,
> +						  struct pt_regs *regs,
> +						  struct perf_sample_data *data,
> +						  void *at, u64 pebs_status,
> +						  struct perf_event *events[],
> +						  short *counts, void **last,
> +						  setup_fn setup_sample)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct perf_event *event;
> +	int bit;
> +
> +	for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
> +		event = cpuc->events[bit];
> +
> +		if (WARN_ON_ONCE(!event) ||
> +		    WARN_ON_ONCE(!event->attr.precise_ip))
> +			continue;
> +
> +		if (counts[bit]++)
> +			__intel_pmu_pebs_event(event, iregs, regs, data,
> +					       last[bit], setup_sample);
> +
> +		last[bit] = at;
> +		/*
> +		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
> +		 * could trigger interrupt throttle and clear all event pointers of
> +		 * the group in cpuc->events[] to NULL. So snapshot the event[] before
> +		 * it could be cleared. This avoids the possible NULL event pointer
> +		 * access and PEBS record loss.
> +		 */
> +		if (counts[bit] && !events[bit])
> +			events[bit] = cpuc->events[bit];
> +	}
> +}
> +
> +static inline void
> +__intel_pmu_handle_last_pebs_record(struct pt_regs *iregs, struct pt_regs *regs,
> +				    struct perf_sample_data *data, u64 mask,
> +				    struct perf_event *events[],
> +				    short *counts, void **last,
> +				    setup_fn setup_sample)
> +{
> +	struct perf_event *event;
> +	int bit;
> +
> +	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
> +		if (!counts[bit])
> +			continue;
> +
> +		event = events[bit];
> +
> +		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
> +					    counts[bit], setup_sample);
> +	}
> +
> +}

These need to be __always_inline, like the other functions that take
setup_fn. Otherwise the compiler might decide to not inline and then it
can't constant propagate this function and we get indirect calls.


