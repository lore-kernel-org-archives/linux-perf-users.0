Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5C237717;
	Tue, 13 May 2025 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129324; cv=none; b=be7aTniwv9Y4ZDYUFBGwc8wZasAWLdvh/UBwF8vFix4g3tYkoUt++DAt7n01sfWK0AMR/abPvHtfAE4XrS9joMK7WnC626jEXT/TrBEocvB9P7PaEwrRJmJ6+4zpRA4c8v6plTCzZ/sJGjuCSmWNm6kSq0wXK+3+dTfA1GJD+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129324; c=relaxed/simple;
	bh=qBLNBy/gq445RAkBYHQEtoxXsl0N+NBg01MgE36mwbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IatMWohm+7aSZ5BoqWFLNY8DMSTOX1/lqJu43JWMOnPeJGyF526tLm51miObvx/g3hGRnKStL/gSDYCcp8HuGrV+gXIYAr4Kq5VNqGNUKIh9wy2gb564mtxmhZ5pqohJZQcHPUPsqeBGX8mhg6lmkDY5SAqzVD7j5i0nKM98ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VCiENWgH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VCiENWgH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=js5CdpYS9yFA/MzQbhixDBeZ4NnfAUqz+EhtbAMZ180=; b=VCiENWgHxoFeNq368K6MRyaFcu
	ifPbpMsoCnYsfCxINGjEfCZPR63eukf0vd3F8365MwYkW9ssTdMgJiHqSyEuiC+MM0L4fr8iR3sUy
	JgBjBvzhX9KWoSOE8UHs2LJhPytfs/x0nwp+nODRVq401eNDc8Txm3SkMZZjdLv7CqoDym7SL3ki3
	bdsxAvFmyfAiGC1cXZXzHvwqyKXUzOX5tIqg5JpBTpDohty4f3tScHXyf3P8frhmCMmQEA9G78el7
	CxNBqRbjBzCQPY3xCmon1LzemNW3e9LULkUYa2gmwcISrnX3fpJuMop/+hdTco5lg558EpUJmvbI3
	8F5sqRMg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uEm95-0000000GuC2-3uRT;
	Tue, 13 May 2025 09:41:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4F3E0300787; Tue, 13 May 2025 11:41:55 +0200 (CEST)
Date: Tue, 13 May 2025 11:41:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, namhyung@kernel.org, irogers@google.com,
	mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, eranian@google.com,
	ctshao@google.com, tmricht@linux.ibm.com
Subject: Re: [RFC PATCH 01/15] perf: Fix the throttle logic for a group
Message-ID: <20250513094155.GD25763@noisy.programming.kicks-ass.net>
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
 <20250506164740.1317237-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506164740.1317237-2-kan.liang@linux.intel.com>

On Tue, May 06, 2025 at 09:47:26AM -0700, kan.liang@linux.intel.com wrote:

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a84abc2b7f20..eb0dc871f4f1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2734,6 +2734,38 @@ void perf_event_disable_inatomic(struct perf_event *event)
>  static void perf_log_throttle(struct perf_event *event, int enable);
>  static void perf_log_itrace_start(struct perf_event *event);
>  
> +static void perf_event_group_unthrottle(struct perf_event *event, bool start_event)
> +{
> +	struct perf_event *leader = event->group_leader;
> +	struct perf_event *sibling;
> +
> +	if (leader != event || start_event)
> +		leader->pmu->start(leader, 0);
> +	leader->hw.interrupts = 0;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (sibling != event || start_event)
> +			sibling->pmu->start(sibling, 0);
> +		sibling->hw.interrupts = 0;
> +	}
> +
> +	perf_log_throttle(leader, 1);
> +}
> +
> +static void perf_event_group_throttle(struct perf_event *event)
> +{
> +	struct perf_event *leader = event->group_leader;
> +	struct perf_event *sibling;
> +
> +	leader->hw.interrupts = MAX_INTERRUPTS;
> +	leader->pmu->stop(leader, 0);
> +
> +	for_each_sibling_event(sibling, leader)
> +		sibling->pmu->stop(sibling, 0);
> +
> +	perf_log_throttle(leader, 0);
> +}

Urgh, this seems inconsistent at best.

 - unthrottle will set interrupts to 0 for the whole group
 - throttle will set interrupts for leader
   while the old code would set interrupts for event.
 - interrupts was written with event stopped, while now you consistently
   write when started
 - both now issue perf_log_throttle() on leader, whereas previously it
   was issued on event.

IOW

before:				after:
 event stops			 leader MAX_INTERRUPTS
 event MAX_INTERRUPTS		 event group stops
 event logs			 leader logs

 event 0			 event group 0
 event starts			 event group starts
 event logs			 leader logs

Like said, a rather inconsistent and random collection of things.



What's wrong with something simple like:

static void perf_event_throttle(struct perf_event *event, bool start)
{
	event->hw.interrupts = 0;
	if (start)
		event->pmu->start(event, 0);
	perf_log_throttle(event, 1);
}

static void perf_event_unthrottle(struct perf_event *event)
{
	event->pmu->stop(event, 0);
	event->hw.interrupts = MAX_INTERRUPTS;
	perf_log_throttle(event, 0);
}

static void perf_event_throttle_group(struct perf_event *event, bool start)
{
	struct perf_event *sibling, *leader = event->group_leader;

	perf_event_throttle(leader, start);
	for_each_sibling_event(sibling, leader)
		perf_event_throttle(sibling, start);
}

static void perf_event_unthrottle_group(struct perf_event *event)
{
	struct perf_event *sibling, *leader = event->group_leader;

	perf_event_unthrottle(leader);
	for_each_sibling_event(sibling, leader)
		perf_event_unthrottle(sibling);
}

That way:

before:				after:
 event stops			 event group stops
 event MAX_INTERRUPTS		 event group MAX_INTERRUPTS
 event logs			 event group logs

 event 0			 event group 0
 event starts			 event group starts
 event logs			 event group logs

All that was done before is still done - no change in behaviour for
event. Its just that the rest of the group is now taken along for the
ride.

> @@ -6421,14 +6451,6 @@ static void __perf_event_period(struct perf_event *event,
>  	active = (event->state == PERF_EVENT_STATE_ACTIVE);
>  	if (active) {
>  		perf_pmu_disable(event->pmu);
> -		/*
> -		 * We could be throttled; unthrottle now to avoid the tick
> -		 * trying to unthrottle while we already re-started the event.
> -		 */
> -		if (event->hw.interrupts == MAX_INTERRUPTS) {
> -			event->hw.interrupts = 0;
> -			perf_log_throttle(event, 1);
> -		}
>  		event->pmu->stop(event, PERF_EF_UPDATE);
>  	}
>  
> @@ -6436,6 +6458,12 @@ static void __perf_event_period(struct perf_event *event,
>  
>  	if (active) {
>  		event->pmu->start(event, PERF_EF_RELOAD);
> +		/*
> +		 * We could be throttled; unthrottle now to avoid the tick
> +		 * trying to unthrottle while we already re-started the event.
> +		 */
> +		if (event->group_leader->hw.interrupts == MAX_INTERRUPTS)
> +			perf_event_group_unthrottle(event, false);
>  		perf_pmu_enable(event->pmu);
>  	}
>  }

This change seems random. Also, note that I'm kicking myself for the
total lack of useful information in commit 1e02cd40f151.

Notably, we're calling this from event_function_call(), this means we're
having IRQs disabled and are running on the events CPU. How can we
interact with the tick?


