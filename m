Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DF1E5B97;
	Thu, 10 Apr 2025 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273253; cv=none; b=STbuVoyILE9YznoCqbpik9kuRvQkpoDQP65bXjyDzR/70yqwDA2AIR7hHvwZ+9DsxYD1hDXs0MkBR8+rvDodXlFOIOVoTrq/+Ztottgcx5Zgb8BMn7Z6CVvwraRkCAUryTCtvobzN/bgmqYJmi8Ebliq9RA4YNs0pMeYBCGFANU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273253; c=relaxed/simple;
	bh=NGxJ2FOdGMwObbZ+2eqxlkE72FqyzJ1KPrHQUt3vriw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqqrlhDoDveGMapHDSXVIxxx0a2emAzhX6lgL5hE9A+w/Ag8S/QvKlwIPcVzR4M8wVKGnD9BhJp2wUxUrk0LKSxRFyxwBpw8xfiDgQXZCtzh3EhFaa1pugsqC6TqFSVsu/IT6bYLi5aTu0auH2bybFK+cs7F0MzHppBVZgW9Us4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cYa0l1sO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cYa0l1sO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WV77EhH4hDFXDVQ1m6gRrLTzOdaQIgHBHDPhiIr1dLw=; b=cYa0l1sOzUI+6xq5lqNd4MW7Ex
	hftamejjB6pU1WUb1c2yrBT3y57ndhLjGwaf3rsXNrSK1kn9TiHs63fnYji7sARIQcx1uw3a6BAK3
	sNPo3WHKmC3/+X+iHXVHDQdVwMiUgROcWWEzVPYu6cU18UH/RQAOS48Z4vx+e5Mh14ms7+QxTbbqj
	KtYU+i3umMzjh9eYsMpPLoWZJIV+bpRbP3P4HoSDIJvMX4lI/GHUHMHcHlt8lvg+uR26En3/ZwuFq
	Lo5fCfNdrh4jEpdBBneZDaUxR6PmaiZoG2YSMITlrYPtMhnYFBVcydZiKDOSV37/VD4HMpsxtTVHj
	tKaTp/qg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2n9N-00000002bt0-15ol;
	Thu, 10 Apr 2025 08:20:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4FC293003FF; Thu, 10 Apr 2025 10:20:41 +0200 (CEST)
Date: Thu, 10 Apr 2025 10:20:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	eranian@google.com, songliubraving@meta.com, ravi.bangoria@amd.com,
	ananth.narayan@amd.com
Subject: Re: [PATCH 2/4] perf/x86/amd/uncore: Use hrtimer for handling
 overflows
Message-ID: <20250410082041.GY9833@noisy.programming.kicks-ass.net>
References: <cover.1744184837.git.sandipan.das@amd.com>
 <f3a7703c22e6734f0d1bf34bc56be3124f818a8b.1744184837.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a7703c22e6734f0d1bf34bc56be3124f818a8b.1744184837.git.sandipan.das@amd.com>

On Wed, Apr 09, 2025 at 01:27:07PM +0530, Sandipan Das wrote:
> Uncore counters do not provide mechanisms like interrupts to report
> overflows and the accumulated user-visible count is incorrect if there
> is more than one overflow between two successive read requests for the
> same event because the value of prev_count goes out-of-date for
> calculating the correct delta.
> 
> To avoid this, start a hrtimer to periodically initiate a pmu->read() of
> the active counters for keeping prev_count up-to-date. It should be
> noted that the hrtimer duration should be lesser than the shortest time
> it takes for a counter to overflow for this approach to be effective.
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/events/amd/uncore.c | 72 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 010024f09f2c..ee6528f2189f 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -21,6 +21,7 @@
>  #define NUM_COUNTERS_NB		4
>  #define NUM_COUNTERS_L2		4
>  #define NUM_COUNTERS_L3		6
> +#define NUM_COUNTERS_MAX	64
>  
>  #define RDPMC_BASE_NB		6
>  #define RDPMC_BASE_LLC		10
> @@ -38,6 +39,10 @@ struct amd_uncore_ctx {
>  	int refcnt;
>  	int cpu;
>  	struct perf_event **events;
> +	unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
> +	int nr_active;
> +	struct hrtimer hrtimer;
> +	u64 hrtimer_duration;
>  };
>  
>  struct amd_uncore_pmu {
> @@ -87,6 +92,51 @@ static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
>  	return container_of(event->pmu, struct amd_uncore_pmu, pmu);
>  }
>  
> +static enum hrtimer_restart amd_uncore_hrtimer(struct hrtimer *hrtimer)
> +{
> +	struct amd_uncore_ctx *ctx;
> +	struct perf_event *event;
> +	unsigned long flags;
> +	int bit;
> +
> +	ctx = container_of(hrtimer, struct amd_uncore_ctx, hrtimer);
> +
> +	if (!ctx->nr_active || ctx->cpu != smp_processor_id())
> +		return HRTIMER_NORESTART;
> +
> +	/*
> +	 * Disable local interrupts to prevent pmu->start() or pmu->stop()
> +	 * from interrupting the update process
> +	 */
> +	local_irq_save(flags);
> +
> +	for_each_set_bit(bit, ctx->active_mask, NUM_COUNTERS_MAX) {
> +		event = ctx->events[bit];
> +		event->pmu->read(event);
> +	}
> +
> +	local_irq_restore(flags);
> +
> +	hrtimer_forward_now(hrtimer, ns_to_ktime(ctx->hrtimer_duration));
> +	return HRTIMER_RESTART;
> +}
> +
> +static void amd_uncore_start_hrtimer(struct amd_uncore_ctx *ctx)
> +{
> +	hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
> +		      HRTIMER_MODE_REL_PINNED);
> +}

So I know you copied this from the Intel uncore driver; but would not
both be improved by using HRTIMER_MODE_HARD?

It makes no sense to me to bounce the thing to SoftIRQ only to then
disable IRQs in the handler again. Not to mention that the whole SoftIRQ
things delays things further, giving more room/time to reach overflow
wrap.
