Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71CD19FA92;
	Thu, 16 Jan 2025 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028080; cv=none; b=t1HSMgM7gsEaroBI+rqs5VzRaLwgUIIo6iq8gjs3Ah4mfQiKniEe5Y0I2qrWKle/Eyq7zg/2xqSGDv3t8QVkEJ8P852ioPOqCqvBOs+N/tQVO/NpTauFC8ZQzfXE2JHKYnsXMAuTPkEhDjK/JVg0IYP+Ws+TMx0c9y0BbRxN2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028080; c=relaxed/simple;
	bh=kgu0IOPoh+/mTZWH9Z/Ec3pXX2ALJzDt+P83iVs6BJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tatkO5Bz6StzEbXbjojbsa6W+OorZkkoQXJX8PYq3N1LtJyAgfJeVYFJGphgVBYIJ1/+pdZoigfZJt/bC+PuToJX4FOtPrrJPLBtWIC7GheQypKxN6X3L+fI6ARQjD25j1hXiW2i712VmisjJPhSAjcHGS8ayx/Uu7uhlnORZ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZLgNpNqy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZLgNpNqy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vhc9o9g9y2Z4LH3mwpo+FtIZL36TRvnRdHaoc+cgZu8=; b=ZLgNpNqyz8ndthNgunWPWyVYX2
	lCmdJzGWQ2gViJCly8ECLumlwNlKv+tbqdmoJblAKs38ozqP5dtZRDohRb2GC2wCYPy4aiViJQjW0
	HKJ7ecvLBWSltItOzYSwLBoYT03K55s8ugWd3QjwVeieKLh6v6FyF+sJwV+YDRTqtYx8/N+6WCn2C
	I3mtbv3/lg7JJzTq/DeTNoh5XUcj1YgkFY/V1JCGVVW0tf+nvZ43iHmJ+CxNS0eiIcWf3IgTrUjSU
	Vqi2HR07sj5TXcamMYgKsZu9ALC2JzVE6DriCxzc/Sr/SDJI1nndC2Ud28G9Z17vzMxyf6DjQsQ2/
	o9HU/cPQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYOLo-0000000BETk-0A50;
	Thu, 16 Jan 2025 11:47:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 54214300777; Thu, 16 Jan 2025 12:47:51 +0100 (CET)
Date: Thu, 16 Jan 2025 12:47:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V9 3/3] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20250116114751.GJ8362@noisy.programming.kicks-ass.net>
References: <20250115184318.2854459-1-kan.liang@linux.intel.com>
 <20250115184318.2854459-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115184318.2854459-3-kan.liang@linux.intel.com>

On Wed, Jan 15, 2025 at 10:43:18AM -0800, kan.liang@linux.intel.com wrote:

> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

Did they really read all the various versions without spotting any of
the problems, or are you just rubber stamping things at this point :/

Best to drop review tags after serious changes to patches.

> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 8f218ac0d445..79a4aad5a0a3 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -94,6 +94,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
>  
>  DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
>  
> +DEFINE_STATIC_CALL_NULL(x86_pmu_late_config, x86_pmu_late_config);

So all these static call are through struct x86_pmu (hence the naming),
but not this one ?!?

>  /*
>   * This one is magic, it will get called even when PMU init fails (because
>   * there is no PMU), in which case it should simply return NULL.
> @@ -1329,7 +1331,16 @@ static void x86_pmu_enable(struct pmu *pmu)
>  		}
>  
>  		/*
> -		 * step2: reprogram moved events into new counters
> +		 * step2:
> +		 * The late config (after counters are scheduled)
> +		 * is required for some cases, e.g., PEBS counters
> +		 * snapshotting. Because an accurate counter index
> +		 * is needed.
> +		 */
> +		static_call_cond(x86_pmu_late_config)();
> +
> +		/*
> +		 * step3: reprogram moved events into new counters
>  		 */
>  		for (i = 0; i < cpuc->n_events; i++) {
>  			event = cpuc->event_list[i];

Placement and naming are weird.

These 2 loops migrate all counters that got a new place, the first loop
taking out pre-existing counters that got a new place, the second loop
setting up these same and new counters.

Why do the pebs config in the middle, where the least number of counters
are set-up?

AFAICT all it really needs is cpuc->assignp[], which is unchanged
throughout. You can call this at any time before clearing n_added,
sticking it in the middle just seems weird.

Then naming, config is typically what we do at event creation,
x86_pmu_hw_config() like. This is not at all related, so perhaps pick a
different name?

Bah, we're so very close between x86_pmu::{enable, disable, assign}() :/

Also, I think I found you another bug... Consider what happens to the
counter value when we reschedule a HES_STOPPED counter, then we skip
x86_pmu_start(RELOAD) on step2, which leave the counter value with
'random' crap from whatever was there last.

But meanwhile you do program PEBS to sample it. That will happily sample
this garbage.

Hmm?
