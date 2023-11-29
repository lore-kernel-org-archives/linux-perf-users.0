Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q2NbVUFM"
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D295;
	Wed, 29 Nov 2023 02:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KigNA1TZVqFp7ATaA0tVgaRfg+vW2ATtcc+1Uw9papU=; b=Q2NbVUFMfdymSbxHURADyz+2dQ
	gbloL7jZqkpqjodYwok3ql66wYy7cdufNcJCC2EZfTYZLQyR/x16CzXMCFWFAQ3xgYLkmVqdyBUVL
	SD/WEF1Px2v/ctRMyjh4QZt853ckle8P++uVw2YAyyTUTNP5IwmiX0ev188ZEFO1lJtV6566KeSGu
	azaZQxJrOH6ovUcIMOTCL4Me2IJuKOJxtMyQroIbFOezolfDgAK2wHEhkImI+LwO3rXB5XBgHi7tU
	EGgIQAFXLUKMXOUSyXIwwYAspPX0mlLRGJs0LSa0MlK/S9XbzLVn6AUhHZ0SfWb53PlCWcSCwHUBa
	Bz6/9MZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r8IH7-000Jr8-0G;
	Wed, 29 Nov 2023 10:58:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B7D0B300487; Wed, 29 Nov 2023 11:58:36 +0100 (CET)
Date: Wed, 29 Nov 2023 11:58:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: James Clark <james.clark@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] perf/x86/intel/pt: Add support for pause_resume()
Message-ID: <20231129105836.GF30650@noisy.programming.kicks-ass.net>
References: <20231123121851.10826-1-adrian.hunter@intel.com>
 <20231123121851.10826-3-adrian.hunter@intel.com>
 <c63808b2-2049-da18-f0af-5dff2bc87cd2@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63808b2-2049-da18-f0af-5dff2bc87cd2@arm.com>

On Wed, Nov 29, 2023 at 09:53:39AM +0000, James Clark wrote:
> On 23/11/2023 12:18, Adrian Hunter wrote:

> > +static void pt_event_pause_resume(struct perf_event *event)
> > +{
> > +	if (event->aux_paused)
> > +		pt_config_stop(event);
> > +	else if (!event->hw.state)
> > +		pt_config_start(event);
> > +}
> 
> It seems like having a single pause/resume callback rather than separate
> pause and resume ones pushes some of the event state management into the
> individual drivers and would be prone to code duplication and divergent
> behavior.
> 
> Would it be possible to move the conditions from here into the core code
> and call separate functions instead?
> 
> > +
> >  static void pt_event_start(struct perf_event *event, int mode)
> >  {
> >  	struct hw_perf_event *hwc = &event->hw;
> > @@ -1798,6 +1809,7 @@ static __init int pt_init(void)
> >  	pt_pmu.pmu.del			 = pt_event_del;
> >  	pt_pmu.pmu.start		 = pt_event_start;
> >  	pt_pmu.pmu.stop			 = pt_event_stop;
> > +	pt_pmu.pmu.pause_resume		 = pt_event_pause_resume;
> 
> The general idea seems ok to me. Is there a reason to not use the
> existing start() stop() callbacks, rather than adding a new one?
> 
> I assume it's intended to be something like an optimisation where you
> can turn it on and off without having to do the full setup, teardown and
> emit an AUX record because you know the process being traced never gets
> switched out?

So the actual scheduling uses ->add() / ->del(), the ->start() /
->stop() methods are something that can be used after ->add() and before
->del() to 'temporarily' pause things.

Pretty much exactly what is required here I think. We currently use this
for PMI throttling and adaptive frequency stuff, but there is no reason
it could not also be used for this.

As is, we don't track the paused state across ->del() / ->add(), but
perhaps that can be fixed. We can easily add more PERF_EF_ / PERF_HES_
bits to manage things.


