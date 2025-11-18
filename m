Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5D16F265;
	Tue, 18 Nov 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463865; cv=none; b=XWw9Gj6zlPZHG63cT9Q6ZAmMA83tukTqlH8E7UwAjIFw8Lma/vsSc6vozU0mZmMQW+cgT3UuNE4bT482nN7OT7VDGVXFqfCTq+PxEqyDqMY3rq5avJyDFZ1ZtATzYmsCSz16WDhbxK47LFGBN6U+1a9DwQ4ls07vsfGDG2NEv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463865; c=relaxed/simple;
	bh=qtqCvrv7JopV9CrfUBT92DXWqjaVx3AbXuBW1w/juo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSdwYI7Lf1Gol1+WiPQCLp1LCDrmduutdpjruIuNQm4rOed05qpd77RDgqsIs7udtZbYN6ysys6DaBMB47mOfZRELp47BNg0HglfjWFhbAaQE7Z4LQSPrhDtIjIHzUx3hNfQs2Rdfzd8tkK4tZOIXyRv3K6RuFefz8UashXkTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cj9EiWc2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cj9EiWc2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EVH/E+cL9bjStuAWv383+yn1qkoEiFkrAZCT1+EtgyM=; b=Cj9EiWc2Sq8gA2zJyUEXEtiK5Q
	jTgvs7k46HKvmrwmYz8I0XbF3drDwknKoOcfXlnp+xXG5qboNLbZ3W0Ebm61G7V2YH6+/LSWNwKr+
	etBFOrVXqId65g1kJ6MzmS/ZUbR8hr6QTs/btnWtShFaqM/pFohFHsn9H8FINDSDwvEUCdvzDFFWu
	bFrXGB+H5uZyaJpwKY/PmWvsPPQ2ndzIglUogYb1MQiuIzt0Q58AhxgadIGLBe9jXApBlb3qjMH5z
	xWB0js1EKOPaXGQNvEbLrho6Nh7fDDWJ0NMf9ovMzN51p42zmeVXk5Xmd2tCawt/oNyQxLHaJXT3Q
	OXSSvDDA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLIdo-00000009Swl-1NNn;
	Tue, 18 Nov 2025 10:08:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FBBF30029E; Tue, 18 Nov 2025 12:04:17 +0100 (CET)
Date: Tue, 18 Nov 2025 12:04:17 +0100
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
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH] perf: Fix 0 count issue of cpu-clock
Message-ID: <20251118110417.GI4068168@noisy.programming.kicks-ass.net>
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
 <20251118110309.GP3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118110309.GP3245006@noisy.programming.kicks-ass.net>

On Tue, Nov 18, 2025 at 12:03:09PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 12, 2025 at 04:05:26PM +0800, Dapeng Mi wrote:
> 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index f6a08c73f783..77d3af5959c1 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11964,7 +11964,7 @@ static int cpu_clock_event_add(struct perf_event *event, int flags)
> >  
> >  static void cpu_clock_event_del(struct perf_event *event, int flags)
> >  {
> > -	cpu_clock_event_stop(event, flags);
> > +	cpu_clock_event_stop(event, flags | PERF_EF_UPDATE);
> >  }
> >  
> >  static void cpu_clock_event_read(struct perf_event *event)
> > @@ -12043,7 +12043,7 @@ static int task_clock_event_add(struct perf_event *event, int flags)
> >  
> >  static void task_clock_event_del(struct perf_event *event, int flags)
> >  {
> > -	task_clock_event_stop(event, PERF_EF_UPDATE);
> > +	task_clock_event_stop(event, flags | PERF_EF_UPDATE);
> >  }
> 
> I think it can both just be: PERF_EF_UPDATE. The only pmu::del() caller
> hands in flags=0, but if there were to be flags added, we'd have to
> audit all del methods anyway.
> 
> Also, the few comments we do have already note that ->del() must do
> ->stop(EF_UPDATE).

Updated patch now sits in queue/perf/urgent.
