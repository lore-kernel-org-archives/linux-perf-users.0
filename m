Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB71BF37;
	Thu, 18 Jul 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721295547; cv=none; b=icwadAQ0eDMq1VMROsmxouMzCFo1yol5ydLq/qMr0N4GG6RCW3qW2hz/Acu4NdqkyVMYV5O9c/MDIxW0oYtnVWxfP8puE2LxHYVxS5VO73Z8DMzPPh41pGV+K/sqpTy0DqjunJfo4xsUUBFV3nHLsu/OIVxYA3TvJVepOMuWc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721295547; c=relaxed/simple;
	bh=or/dYLZwuKob/2SmTnu50xKA9faM6wgcIEKdV0rCwG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzmpwB87hqPlvoUf+XRbP1CyQ4oQxVevl0LvHKXhjQmG+2L+BOA8PzmUSXQAiIVLmxptojreap/RV9B++8CsNo6G62khFjS3wDYiSxi1nCZb76Mnlef0DgTayEV7Co+z8Oa7IDtWvQ+MObiZONDpFjuVg8coNwxxi1eaVutobjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rwQpcfFx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rwQpcfFx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wT78pFN34/V9uidmy7XYu2UoYrn2A2taxXO8JOLiM9Q=; b=rwQpcfFxtKPKmXhYBtiHgeClbk
	wN7G9+koaKNpwtI0xqxNOT5rPipdVFi/RxbrX25DgXSgqggw+9Zj/C1YaLWCsrU18VffViblVNZTc
	cVx5cbtLmMxW88++yGXH4yyvuPEDAqypkfmCqMNQxK2yCaEKEijdHBsEtg/sjKIWiMfCf0fFVgPuk
	MgVzlv6sbp6lSQpnz0X8rGialcGDebGKdvpspnATBqPwzFYzhkLJRxbEsRlHP7sJPxcuZp5J/qq63
	rn4zu9MLhMmSlnUAMhT4L2iNhzAcCUMXZFdJYl/mgUMBdDoOmAllKpJl2BBZRl80M44uyUURzwgYU
	pwkGbZ8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUNb5-00000001pRp-2CG5;
	Thu, 18 Jul 2024 09:38:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7F3583006B7; Thu, 18 Jul 2024 11:38:46 +0200 (CEST)
Date: Thu, 18 Jul 2024 11:38:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V9 02/13] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <20240718093846.GJ26750@noisy.programming.kicks-ass.net>
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715160712.127117-3-adrian.hunter@intel.com>

On Mon, Jul 15, 2024 at 07:07:01PM +0300, Adrian Hunter wrote:
> Hardware traces, such as instruction traces, can produce a vast amount of
> trace data, so being able to reduce tracing to more specific circumstances
> can be useful.
> 
> The ability to pause or resume tracing when another event happens, can do
> that.
> 
> Add ability for an event to "pause" or "resume" AUX area tracing.
> 
> Add aux_pause bit to perf_event_attr to indicate that, if the event
> happens, the associated AUX area tracing should be paused. Ditto
> aux_resume. Do not allow aux_pause and aux_resume to be set together.
> 
> Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
> event that it should start in a "paused" state.
> 
> Add aux_paused to struct hw_perf_event for AUX area events to keep track of
> the "paused" state. aux_paused is initialized to aux_start_paused.
> 
> Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
> callbacks. Call as needed, during __perf_event_output(). Add

Why in __perf_event_output() rather than in __perf_event_overflow().
Specifically, before bpf_overflow_handler().

That is, what do we want BPF to be able to do here? To me it seems
strange that BPF would be able to affect this functionality. You want
this pause/resume to happen irrespective of how the rest of the event is
processed, no?

> aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
> handler. Pause/resume in NMI context will miss out if it coincides with
> another pause/resume.

I'm struggling here. That variable is only ever used inside that one
function. So it must be self-recursion. Are you thinking something like:

  swevent_overflow()
    ...
      event_aux_pause()
        <NMI>
	  event_overflow()
	    ...
	      event_aux_pause()

?

Where two events in the group, one software and one hardware, are both
trying to control the AUX thing? Because I don't think the PT-PMI ever
gets here.

> To use aux_pause or aux_resume, an event must be in a group with the AUX
> area event as the group leader.


> @@ -402,6 +411,15 @@ struct pmu {
>  	 *
>  	 * ->start() with PERF_EF_RELOAD will reprogram the counter
>  	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
> +	 *
> +	 * ->stop() with PERF_EF_PAUSE will stop as simply as possible. Will not
> +	 * overlap another ->stop() with PERF_EF_PAUSE nor ->start() with
> +	 * PERF_EF_RESUME.
> +	 *
> +	 * ->start() with PERF_EF_RESUME will start as simply as possible but
> +	 * only if the counter is not otherwise stopped. Will not overlap
> +	 * another ->start() with PERF_EF_RESUME nor ->stop() with
> +	 * PERF_EF_PAUSE.
>  	 */
>  	void (*start)			(struct perf_event *event, int flags);
>  	void (*stop)			(struct perf_event *event, int flags);

Notably, they *can* race with ->stop/start without EF_PAUSE/RESUME.
