Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3E15820E;
	Thu, 11 Jul 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698703; cv=none; b=Hp4oTEeziFlu+8pB4eXtVpBpM3GgmirX30Dpem44DNfiYQyNoplwYiHojHyBNUd8xRYtYt4ULIOqUWYqQ6DNVew2E2Xy6xY3gjcUrh1CMGnE57drUw2ALfiIBK/oXmw5FH1AUNstK8QVqgO/GcdUT0hfb9G0jmE76WY9kKmFCqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698703; c=relaxed/simple;
	bh=ucFrtL2gfjqV/c9AnCqRKLXAq1ujHVF98cnp+SY1VWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubL64qS5JIN581UZFK17rThnKwHpOULWnuPcpTW3a2NSQaR0KWAANBjA9wltfJIL/k7OndrWi6KRDRzGhtXN8peatwKAlmQjElQMQl3Q8JlPQaD/G2A7lV10mU2aUf3otZc12z9d+wWIGGcX6kfQsB8ZXTgZZYxcndDX+Vzctfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CjuOTmGc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CjuOTmGc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cxjY6RuKkVBvnWP6/j3ZkXH4A7CjxPaXbnE4ia7U018=; b=CjuOTmGcSItVqRAm5Q500eJiDo
	7I9fjGSWOsyEowDdifFzf+CO5UjT93aUWgVDTwOEQaSyC/9eaenJsncnKZafukUaSeaWD+jDqarxq
	GAjq8UoW2sTnxYSqRTjgjmcU/yapxdJ37vjJeWytSZ2b1F+kTq+VL8G2KT7gwz57KJL9M8A/nmCJ3
	Kj5qZTVoHIAITPl7Z8rypdEYOLA52VOig+NLekxf+Q0V9GBg3GcQy0uzsUHADc6ha2oK0RW1uq1eN
	4sa/fItDw2nTD8wJKKLzSLPwOjlC7KEg8M+AxyWOqiw4MNDueUEA5sFExX3j5Obx1qwrurtwuBqUZ
	cvrkhDTg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRsKZ-000000015sZ-3OMo;
	Thu, 11 Jul 2024 11:51:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6BB7D30050D; Thu, 11 Jul 2024 13:51:23 +0200 (CEST)
Date: Thu, 11 Jul 2024 13:51:23 +0200
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
Subject: Re: [PATCH V8 01/12] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <20240711115123.GK4587@noisy.programming.kicks-ass.net>
References: <20240628065111.59718-1-adrian.hunter@intel.com>
 <20240628065111.59718-2-adrian.hunter@intel.com>
 <20240701102644.GA20127@noisy.programming.kicks-ass.net>
 <68796741-f49f-447f-b707-fe4f8391fc17@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68796741-f49f-447f-b707-fe4f8391fc17@intel.com>

On Thu, Jul 11, 2024 at 01:42:33PM +0300, Adrian Hunter wrote:
> On 1/07/24 13:26, Peter Zijlstra wrote:
> > On Fri, Jun 28, 2024 at 09:51:00AM +0300, Adrian Hunter wrote:
> > 
> >> Add aux_paused to struct perf_event for AUX area events to keep track of
> >> the "paused" state. aux_paused is initialized to aux_start_paused.
> > 	
> >> @@ -798,6 +810,9 @@ struct perf_event {
> >>  	/* for aux_output events */
> >>  	struct perf_event		*aux_event;
> >>  
> >> +	/* for AUX area events */
> >> +	unsigned int			aux_paused;
> >> +
> >>  	void (*destroy)(struct perf_event *);
> >>  	struct rcu_head			rcu_head;
> >>  
> > 
> > Should this not be part of struct hw_perf_event for whatever hw event
> > implements this AUX stuff?
> > 
> > In fact, I would expect PERF_HES_PAUSED or something to go in
> > perf_event::hw::state.
> 
> Sorry for the slow reply due to vacation.
> 
> There doesn't seem to be anything preventing pause/resume from
> "racing" (PMI vs task context) with changes in the aux event state,
> so aux_paused must be separate from perf_event::hw::state.

So normally, context switching perf would be under pmu_disable(), which
should ensure no PMI happens while we're reprogramming the PMU.

That said, I think for the aux case we have perf_event_stop() that can
race vs PMI, so yeah, bummer.

Sticking it in hw_perf_event would be good though. Also perhaps add a
comment about exactly why this cannot be in ::state.
