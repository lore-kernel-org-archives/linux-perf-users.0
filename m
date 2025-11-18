Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC861A4F3C;
	Tue, 18 Nov 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450982; cv=none; b=PWcND/SLX5XfegcONwa07VkWEThWh7D1vneMm/op7YxRgn687F3fPKSv07rc9xdE83KgnFWfMIbQa4YktSWKdt1cf/rsMqs1CvjSU4O9Ojsn6aETIVG+TZRqIbv/vT6tJpdbnh0X1g+I0GzIDVCAP5sXfvzBdSyVK4DNJhxy9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450982; c=relaxed/simple;
	bh=6/OHJ7AoKWrYggCvQUvCZn4tzvLGZoPyGlgpe21eiCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DykWdUyB7TEanURFsbSUWx60qjqIr9WBzEb7F6qZEObCWOYP0CJ288fVpqYal5wh+oDZ6O+d0c3rZdKmaXxCYlKP2ZcHnfxCS2X6qDwlqXHKF5ndVBCgKXvU/FEqxZil/V0gJ0++4rZvkk2nLtSMi+kR56PHpoKahwGG4tW7Phs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4Nb2PMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4Nb2PMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC8AC19423;
	Tue, 18 Nov 2025 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450982;
	bh=6/OHJ7AoKWrYggCvQUvCZn4tzvLGZoPyGlgpe21eiCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4Nb2PMmJ0bohvUpKLUN/tgNDkh5kO52Lreu88DlU9j5WGjJlFek8IBjkZkWv6RUE
	 1sNeRM2j0S7jZRCTuctlIgwSVZMxHC5/d5RfpWdWIPSi8U7i/J9BUFQtCQwRjTLRER
	 kNYUyARhXIsbQeygatuC+KM5uqjdPsw15vjDVWmVkjD4IJNuhoi7OaRXuXNY9AfsBb
	 2eO84O0ikLgEcK46FrnZDXC4Ziu/l3x49jbbSJBdYY1E4ulk4TIE92tyYb3XhrTShL
	 u2dG1tFRI+gow1przUnRx5+W+dMUAT9xIpwoxduiS36ssg4ze5DL9HEbq+fg2EOFss
	 OHsHHcGZ6C/Kw==
Date: Mon, 17 Nov 2025 23:29:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Xu Yang <xu.yang_2@nxp.com>, Chun-Tse Shao <ctshao@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v4 03/18] perf jevents: Add set of common metrics based
 on default ones
Message-ID: <aRwgZOgsr7yz0nH3@google.com>
References: <20251111212206.631711-1-irogers@google.com>
 <20251111212206.631711-4-irogers@google.com>
 <ca0f0cd3-7335-48f9-8737-2f70a75b019a@linaro.org>
 <CAP-5=fWNr9oaxWy3PyqbeH-sjsPpSt9g=8vP0drbb_e+ijpWkw@mail.gmail.com>
 <aRi9xnwdLh3Dir9f@google.com>
 <CAP-5=fVKwQbOFcm5kNkuZ62rTu77A+N=aa2Of+hN1-68Qe7rFA@mail.gmail.com>
 <aRvNux4vlacfrgin@google.com>
 <CAP-5=fUpkUifLiBSO473Ws5HyDH0dGNMVCqomggE2P2=VNhAZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUpkUifLiBSO473Ws5HyDH0dGNMVCqomggE2P2=VNhAZg@mail.gmail.com>

On Mon, Nov 17, 2025 at 06:28:31PM -0800, Ian Rogers wrote:
> On Mon, Nov 17, 2025 at 5:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sat, Nov 15, 2025 at 07:29:29PM -0800, Ian Rogers wrote:
> > > On Sat, Nov 15, 2025 at 9:52 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Fri, Nov 14, 2025 at 08:57:39AM -0800, Ian Rogers wrote:
> > > > > On Fri, Nov 14, 2025 at 8:28 AM James Clark <james.clark@linaro.org> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 11/11/2025 9:21 pm, Ian Rogers wrote:
> > > > > > > Add support to getting a common set of metrics from a default
> > > > > > > table. It simplifies the generation to add json metrics at the same
> > > > > > > time. The metrics added are CPUs_utilized, cs_per_second,
> > > > > > > migrations_per_second, page_faults_per_second, insn_per_cycle,
> > > > > > > stalled_cycles_per_instruction, frontend_cycles_idle,
> > > > > > > backend_cycles_idle, cycles_frequency, branch_frequency and
> > > > > > > branch_miss_rate based on the shadow metric definitions.
> > > > > > >
> > > > > > > Following this change the default perf stat output on an alderlake
> > > > > > > looks like:
> > > > > > > ```
> > > > > > > $ perf stat -a -- sleep 2
> > > > > > >
> > > > > > >   Performance counter stats for 'system wide':
> > > > > > >
> > > > > > >                0.00 msec cpu-clock                        #    0.000 CPUs utilized
> > > > > > >              77,739      context-switches
> > > > > > >              15,033      cpu-migrations
> > > > > > >             321,313      page-faults
> > > > > > >      14,355,634,225      cpu_atom/instructions/           #    1.40  insn per cycle              (35.37%)
> > > > > > >     134,561,560,583      cpu_core/instructions/           #    3.44  insn per cycle              (57.85%)
> > > > > > >      10,263,836,145      cpu_atom/cycles/                                                        (35.42%)
> > > > > > >      39,138,632,894      cpu_core/cycles/                                                        (57.60%)
> > > > > > >       2,989,658,777      cpu_atom/branches/                                                      (42.60%)
> > > > > > >      32,170,570,388      cpu_core/branches/                                                      (57.39%)
> > > > > > >          29,789,870      cpu_atom/branch-misses/          #    1.00% of all branches             (42.69%)
> > > > > > >         165,991,152      cpu_core/branch-misses/          #    0.52% of all branches             (57.19%)
> > > > > > >                         (software)                 #      nan cs/sec  cs_per_second
> > > > > > >               TopdownL1 (cpu_core)                 #     11.9 %  tma_bad_speculation
> > > > > > >                                                    #     19.6 %  tma_frontend_bound       (63.97%)
> > > > > > >               TopdownL1 (cpu_core)                 #     18.8 %  tma_backend_bound
> > > > > > >                                                    #     49.7 %  tma_retiring             (63.97%)
> > > > > > >                         (software)                 #      nan faults/sec  page_faults_per_second
> > > > > > >                                                    #      nan GHz  cycles_frequency       (42.88%)
> > > > > > >                                                    #      nan GHz  cycles_frequency       (69.88%)
> > > > > > >               TopdownL1 (cpu_atom)                 #     11.7 %  tma_bad_speculation
> > > > > > >                                                    #     29.9 %  tma_retiring             (50.07%)
> > > > > > >               TopdownL1 (cpu_atom)                 #     31.3 %  tma_frontend_bound       (43.09%)
> > > > > > >                         (cpu_atom)                 #      nan M/sec  branch_frequency     (43.09%)
> > > > > > >                                                    #      nan M/sec  branch_frequency     (70.07%)
> > > > > > >                                                    #      nan migrations/sec  migrations_per_second
> > > > > > >               TopdownL1 (cpu_atom)                 #     27.1 %  tma_backend_bound        (43.08%)
> > > > > > >                         (software)                 #      0.0 CPUs  CPUs_utilized
> > > > > > >                                                    #      1.4 instructions  insn_per_cycle  (43.04%)
> > > > > > >                                                    #      3.5 instructions  insn_per_cycle  (69.99%)
> > > > > > >                                                    #      1.0 %  branch_miss_rate         (35.46%)
> > > > > > >                                                    #      0.5 %  branch_miss_rate         (65.02%)
> > > > > > >
> > > > > > >         2.005626564 seconds time elapsed
> > > > > > > ```
> > > > > > >
> > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > > ---
> > > > > > >   .../arch/common/common/metrics.json           |  86 +++++++++++++
> > > > > > >   tools/perf/pmu-events/empty-pmu-events.c      | 115 +++++++++++++-----
> > > > > > >   tools/perf/pmu-events/jevents.py              |  21 +++-
> > > > > > >   tools/perf/pmu-events/pmu-events.h            |   1 +
> > > > > > >   tools/perf/util/metricgroup.c                 |  31 +++--
> > > > > > >   5 files changed, 212 insertions(+), 42 deletions(-)
> > > > > > >   create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json
> > > > > > >
> > > > > > > diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/tools/perf/pmu-events/arch/common/common/metrics.json
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..d915be51e300
> > > > > > > --- /dev/null
> > > > > > > +++ b/tools/perf/pmu-events/arch/common/common/metrics.json
> > > > > > > @@ -0,0 +1,86 @@
> > > > > > > +[
> > > > > > > +    {
> > > > > > > +        "BriefDescription": "Average CPU utilization",
> > > > > > > +        "MetricExpr": "(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)",
> > > > > >
> > > > > > Hi Ian,
> > > > > >
> > > > > > I noticed that this metric is making "perf stat tests" fail.
> > > > > > "duration_time" is a tool event and they don't work with "perf stat
> > > > > > record" anymore. The test tests the record command with the default args
> > > > > > which results in this event being used and a failure.
> > > > > >
> > > > > > I suppose there are three issues. First two are unrelated to this change:
> > > > > >
> > > > > >   - Perf stat record continues to write out a bad perf.data file even
> > > > > >     though it knows that tool events won't work.
> > > > > >
> > > > > >     For example 'status' ends up being -1 in cmd_stat() but it's ignored
> > > > > >     for some of the writing parts. It does decide to not print any stdout
> > > > > >     though:
> > > > > >
> > > > > >     $ perf stat record -e "duration_time"
> > > > > >     <blank>
> > > > > >
> > > > > >   - The other issue is obviously that tool events don't work with perf
> > > > > >     stat record which seems to be a regression from 6828d6929b76 ("perf
> > > > > >     evsel: Refactor tool events")
> > > > > >
> > > > > >   - The third issue is that this change adds a broken tool event to the
> > > > > >     default output of perf stat
> > > > > >
> > > > > > I'm not actually sure what "perf stat record" is for? It's possible that
> > > > > > it's not used anymore, expecially if nobody noticed that tool events
> > > > > > haven't been working in it for a while.
> > > > > >
> > > > > > I think we're also supposed to have json output for perf stat (although
> > > > > > this is also broken in some obscure scenarios), so maybe perf stat
> > > > > > record isn't needed anymore?
> > > > >
> > > > > Hi James,
> > > > >
> > > > > Thanks for the report. I think this is also an overlap with perf stat
> > > > > metrics don't work with perf stat record, and because these changes
> > > > > made that the default. Let me do some follow up work as the perf
> > > > > script work shows we can do useful things with metrics while not being
> > > > > on a live perf stat - there's the obstacle that the CPUID of the host
> > > > > will be used :-/
> > > > >
> > > > > Anyway, I'll take a look and we should add a test on this. There is
> > > > > one that the perf stat json output is okay, to some definition. One
> > > > > problem is that the stat-display code is complete spaghetti. Now that
> > > > > stat-shadow only handles json metrics, and perf script isn't trying to
> > > > > maintain a set of shadow counters, that is a little bit improved.
> > > >
> > > > I have another test failure on this.  On my AMD machine, perf all
> > > > metrics test fails due to missing "LLC-loads" events.
> > > >
> > > >   $ sudo perf stat -M llc_miss_rate true
> > > >   Error:
> > > >   No supported events found.
> > > >   The LLC-loads event is not supported.
> > > >
> > > > Maybe we need to make some cache metrics conditional as some events are
> > > > missing.
> > >
> > > Maybe we can `perf list Default`, etc. for this is a problem. We have
> > > similar unsupported events in metrics on Intel like:
> > >
> > > ```
> > > $ perf stat -M itlb_miss_rate -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >    <not supported>      iTLB-loads
> > >            168,926      iTLB-load-misses
> > >
> > >        1.002287122 seconds time elapsed
> > > ```
> > >
> > > but I've not seen failures:
> > >
> > > ```
> > > $ perf test -v "all metrics"
> > > 103: perf all metrics test                                           : Skip
> > > ```
> >
> >   $ sudo perf test -v "all metrics"
> >   --- start ---
> >   test child forked, pid 1347112
> >   Testing CPUs_utilized
> >   Testing backend_cycles_idle
> >   Not supported events
> >   Performance counter stats for 'system wide': <not counted> cpu-cycles <not supported> stalled-cycles-backend 0.013162328 seconds time elapsed
> >   Testing branch_frequency
> >   Testing branch_miss_rate
> >   Testing cs_per_second
> >   Testing cycles_frequency
> >   Testing frontend_cycles_idle
> >   Testing insn_per_cycle
> >   Testing migrations_per_second
> >   Testing page_faults_per_second
> >   Testing stalled_cycles_per_instruction
> >   Testing l1d_miss_rate
> >   Testing llc_miss_rate
> >   Metric contains missing events
> >   Error: No supported events found. The LLC-loads event is not supported.
> 
> Right, but this should match the Intel case as iTLB-loads is an
> unsupported event so I'm not sure why we don't see a failure on Intel
> but do on AMD given both events are legacy cache ones. I'll need to
> trace through the code (or uftrace it :-) ).
                          ^^^^^^^^^^^^^^^^^
                          That'd be fun! ;-)

Thanks,
Namhyung

