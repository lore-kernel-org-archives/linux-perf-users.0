Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046912D7DEA;
	Thu,  6 Nov 2025 05:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762406964; cv=none; b=s+ovVBCcNhJtFiPu+SMRuqoofHosuvPOtN3tHqLD36Pu6v56wo2kgTtpwfiDCdPHt+zLNfzuGq57sY3Y9eqhiZmYechVozEv1Y65ZHEWnl/skYJxS0XDE9sWJIcVCXLJly0xDcMbkMl10fYOcTEJna1fK/kZfIJWSMiyUfBF9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762406964; c=relaxed/simple;
	bh=SkogPYk4QLHERBeaT4qVGwEzmHQkhK1nc4xnVl1EdPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVjAS+SGeBamu39Wgtn/V7vYegGihcXPoN68lbq9qfn38KpOW0JBiofCmgTR0W9gLh6k+PBR29IIbtUxpfIshS6vrzorZzsnMAEoNX5E5pYIRrZASkUjXnj+tMZSqDEKMdAjdAz407HdjTGELFPAdEtJTNPgibec/3z57+UNtYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHegBrAd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHegBrAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E49C116C6;
	Thu,  6 Nov 2025 05:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762406962;
	bh=SkogPYk4QLHERBeaT4qVGwEzmHQkhK1nc4xnVl1EdPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHegBrAdfErawxZXx4M7QRv7Aze//66m+TtohMSriyskyC1dnpbcNpYLrL4JGhz1x
	 PLO8bf2s8xuQYBY+my7UlNpFRyvmdf5v7strNJTT6Io0g+4hCJRLnzHxs/DiS/rc41
	 IIxFNfxITJA/zowoFNzWBJGzEChKy0HlT5CaG2Iq7Mnbc1ksudm0mw4BafRSUK8QcK
	 xl8wIoP0u5hgU9XgzURyFcTbvgs3UYoqZt7S6iFpwqPZhtc3f17+RmUJt5zwstFPNV
	 W6GRingAz1iPABVW4jw/un+nx787xlj4YyfUpxDA0GIRXxi+lhJNWHUJFltIKfyE06
	 JlRGBpMCdinPA==
Date: Wed, 5 Nov 2025 21:29:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 00/22] Switch the default perf stat metrics to json
Message-ID: <aQwyMFRvk0gZg88v@google.com>
References: <20251024175857.808401-1-irogers@google.com>
 <aQmFV7fqURMXQNHC@google.com>
 <CAP-5=fWv1JtKumMpX7Ck+K4ttXTKW-zDQZYen0MxzV1B7VizaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWv1JtKumMpX7Ck+K4ttXTKW-zDQZYen0MxzV1B7VizaQ@mail.gmail.com>

On Mon, Nov 03, 2025 at 09:09:14PM -0800, Ian Rogers wrote:
> On Mon, Nov 3, 2025 at 8:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Fri, Oct 24, 2025 at 10:58:35AM -0700, Ian Rogers wrote:
> > > Prior to this series stat-shadow would produce hard coded metrics if
> > > certain events appeared in the evlist. This series produces equivalent
> > > json metrics and cleans up the consequences in tests and display
> > > output. A before and after of the default display output on a
> > > tigerlake is:
> > >
> > > Before:
> > > ```
> > > $ perf stat -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >     16,041,816,418      cpu-clock                        #   15.995 CPUs utilized
> > >              5,749      context-switches                 #  358.376 /sec
> > >                121      cpu-migrations                   #    7.543 /sec
> > >              1,806      page-faults                      #  112.581 /sec
> > >        825,965,204      instructions                     #    0.70  insn per cycle
> > >      1,180,799,101      cycles                           #    0.074 GHz
> > >        168,945,109      branches                         #   10.532 M/sec
> > >          4,629,567      branch-misses                    #    2.74% of all branches
> > >  #     30.2 %  tma_backend_bound
> > >                                                   #      7.8 %  tma_bad_speculation
> > >                                                   #     47.1 %  tma_frontend_bound
> > >  #     14.9 %  tma_retiring
> > > ```
> > >
> > > After:
> > > ```
> > > $ perf stat -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >              2,890      context-switches                 #    179.9 cs/sec  cs_per_second
> > >     16,061,923,339      cpu-clock                        #     16.0 CPUs  CPUs_utilized
> > >                 43      cpu-migrations                   #      2.7 migrations/sec  migrations_per_second
> > >              5,645      page-faults                      #    351.5 faults/sec  page_faults_per_second
> > >          5,708,413      branch-misses                    #      1.4 %  branch_miss_rate         (88.83%)
> > >        429,978,120      branches                         #     26.8 K/sec  branch_frequency     (88.85%)
> > >      1,626,915,897      cpu-cycles                       #      0.1 GHz  cycles_frequency       (88.84%)
> > >      2,556,805,534      instructions                     #      1.5 instructions  insn_per_cycle  (88.86%)
> > >                         TopdownL1                 #     20.1 %  tma_backend_bound
> > >                                                   #     40.5 %  tma_bad_speculation      (88.90%)
> > >                                                   #     17.2 %  tma_frontend_bound       (78.05%)
> > >                                                   #     22.2 %  tma_retiring             (88.89%)
> > >
> > >        1.002994394 seconds time elapsed
> > > ```
> >
> > While this looks nicer, I worry about the changes in the output.  And I'm
> > curious why only the "After" output shows the multiplexing percent.
> >
> > >
> > > Having the metrics in json brings greater uniformity, allows events to
> > > be shared by metrics, and it also allows descriptions like:
> > > ```
> > > $ perf list cs_per_second
> > > ...
> > >   cs_per_second
> > >        [Context switches per CPU second]
> > > ```
> > >
> > > A thorn in the side of doing this work was that the hard coded metrics
> > > were used by perf script with '-F metric'. This functionality didn't
> > > work for me (I was testing `perf record -e instructions,cycles` and
> > > then `perf script -F metric` but saw nothing but empty lines)
> >
> > The documentation says:
> >
> >         With the metric option perf script can compute metrics for
> >         sampling periods, similar to perf stat. This requires
> >         specifying a group with multiple events defining metrics with the :S option
> >         for perf record. perf will sample on the first event, and
> >         print computed metrics for all the events in the group. Please note
> >         that the metric computed is averaged over the whole sampling
> >         period (since the last sample), not just for the sample point.
> >
> > So I guess it should have 'S' modifiers in a group.
> 
> Thanks Namhyung. Yes, this is the silly behavior where leader sample
> events are both treated as an event but then the constituent parts
> turned into individual events with the period set to the leader sample
> read counts. Most recently this behavior was disabled by struct
> perf_tool's dont_split_sample_group in the case of perf inject as it
> causes events to be processed multiple times. The perf script behavior
> doesn't rely anywhere on the grouping of the leader sample events and
> even with it the metric format option doesn't work either - I'll save
> pasting a screen full of blank lines here.

Right, it seems to be broken at some point.

> 
> > > but anyway I decided to fix it to the best of my ability in this
> > > series. So the script side counters were removed and the regular ones
> > > associated with the evsel used. The json metrics were all searched
> > > looking for ones that have a subset of events matching those in the
> > > perf script session, and all metrics are printed. This is kind of
> > > weird as the counters are being set by the period of samples, but I
> > > carried the behavior forward. I suspect there needs to be follow up
> > > work to make this better, but what is in the series is superior to
> > > what is currently in the tree. Follow up work could include finding
> > > metrics for the machine in the perf.data rather than using the host,
> > > allowing multiple metrics even if the metric ids of the events differ,
> > > fixing pre-existing `perf stat record/report` issues, etc.
> > >
> > > There is a lot of stat tests that, for example, assume '-e
> > > instructions,cycles' will produce an IPC metric. These things needed
> > > tidying as now the metric must be explicitly asked for and when doing
> > > this ones using software events were preferred to increase
> > > compatibility. As the test updates were numerous they are distinct to
> > > the patches updating the functionality causing periods in the series
> > > where not all tests are passing. If this is undesirable the test fixes
> > > can be squashed into the functionality updates.
> >
> > Hmm.. how many of them?  I think it'd better to have the test changes at
> > the same time so that we can assure test success count after the change.
> > Can the test changes be squashed into one or two commits?
> 
> So the patches are below. The first set are all clean up:
> 
> > > Ian Rogers (22):
> > >   perf evsel: Remove unused metric_events variable
> > >   perf metricgroup: Update comment on location of metric_event list
> > >   perf metricgroup: Missed free on error path
> > >   perf metricgroup: When copy metrics copy default information
> > >   perf metricgroup: Add care to picking the evsel for displaying a
> > >     metric
> > >   perf jevents: Make all tables static

I've applied most of this part to perf-tools-next, will take a look at
others later.

Thanks,
Namhyung

> 
> Then there is the addition of the legacy metrics as json:
> 
> > >   perf expr: Add #target_cpu literal
> > >   perf jevents: Add set of common metrics based on default ones
> > >   perf jevents: Add metric DefaultShowEvents
> > >   perf stat: Add detail -d,-dd,-ddd metrics
> 
> Then there is the change to make perf script metric format work:
> 
> > >   perf script: Change metric format to use json metrics
> 
> Then there is a clean up patch:
> 
> > >   perf stat: Remove hard coded shadow metrics
> 
> Then there are fixes to perf stat's already broken output:
> 
> > >   perf stat: Fix default metricgroup display on hybrid
> > >   perf stat: Sort default events/metrics
> > >   perf stat: Remove "unit" workarounds for metric-only
> 
> Then there are 7 patches updating test expectations. Each patch deals
> with a separate test to make the resolution clear.
> 
> > >   perf test stat+json: Improve metric-only testing
> > >   perf test stat: Ignore failures in Default[234] metricgroups
> > >   perf test stat: Update std_output testing metric expectations
> > >   perf test metrics: Update all metrics for possibly failing default
> > >     metrics
> > >   perf test stat: Update shadow test to use metrics
> > >   perf test stat: Update test expectations and events
> > >   perf test stat csv: Update test expectations and events
> 
> The patch "perf jevents: Add set of common metrics based on default
> ones" most impacts the output but we don't want to verify the default
> stat output with the hardcoded metrics that are removed in "perf stat:
> Remove hard coded shadow metrics". Having a test for both hard coded
> and json metrics in an intermediate state makes little sense and the
> default output is impacting by the 3 patches fixing it and removing
> workarounds.
> 
> It is possible to squash things together but I think something is lost
> in doing so, hence presenting it this way.
> 
> Thanks,
> Ian
