Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B323185D;
	Tue, 18 Nov 2025 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448349; cv=none; b=oyQYxHcj9X86rdnRMJ1DbFRf53qtVLDCJVb+y+KZhJM6NdyQvseDDA1W4+MfQHGNAIrcn5r30L57Cl2B/oIqKuzTzPDQNS43fFo5T0TDwi/85vqMDerDWSvxrQeG/pS6wzNvYmuqSaAEQgbsVsj7E6Ogd3LIxs+RuzaF5kvdl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448349; c=relaxed/simple;
	bh=/hJ1LaQQpM6q1Ph09lRoORD2yvpmvhisH0GDchq7y88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl6E3mznTGOIWNLS4Xth8aXYD5CirhFHInE709W6A5SAU9fWn53kUxWvGCJUvP+3aecm1QkABbW0jtmeceDggBYVe842jdbOk+0oEE+6xkLEwIMaONUpPlZNFb0y079ua4BN5od+j9xgAw2wqeEMCgAS/5dGzWFxdk5Rix8nwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpqHMEiJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpqHMEiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8056DC19423;
	Tue, 18 Nov 2025 06:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763448348;
	bh=/hJ1LaQQpM6q1Ph09lRoORD2yvpmvhisH0GDchq7y88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpqHMEiJhDP+D3jwC3qKPxszmFExeFnMMjXo400utU680IhQxX4z8i12MMgs+BdWB
	 vO0ILnleXHuxYZ5BDrMHCC7OE1wQzUITuHv4rPKgm8lwOdY3rZbA9QoWUrkXYDuO1w
	 R6gK5g8HQ1UP2MTICauwAWRZtpueadZUnY+cWX1dswc/hGM9PHwpDCaYBh8oAf8eos
	 wtAuE3yzBOmDvAu9NutIO8/n/b/R3zU9/UgOSnfLgJGkzZGe3+JVrKtp18lf6fTuS/
	 LafaRNZ/mlpiVTHVnEa9DZFpeNoyqQmnZpLsSttJ5IZfZdfj/g93b/7xkkCljmG7mW
	 aCFkH0D4SDG1w==
Date: Mon, 17 Nov 2025 22:45:44 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 04/10] perf stat-shadow: Read tool events directly
Message-ID: <aRwWGPs0IQoQesoo@google.com>
References: <20251113180517.44096-1-irogers@google.com>
 <20251113180517.44096-5-irogers@google.com>
 <aRvaK32xmC8XUA-k@google.com>
 <CAP-5=fUJFFOQzbPyef0F0UixFFD4Mtfh2iYc6aMXsT0mr_DXqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUJFFOQzbPyef0F0UixFFD4Mtfh2iYc6aMXsT0mr_DXqA@mail.gmail.com>

On Mon, Nov 17, 2025 at 08:36:34PM -0800, Ian Rogers wrote:
> On Mon, Nov 17, 2025 at 6:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Nov 13, 2025 at 10:05:10AM -0800, Ian Rogers wrote:
> > > When reading time values for metrics don't use the globals updated in
> > > builtin-stat, just read the events as regular events. The only
> > > exception is for time events where nanoseconds need converting to
> > > seconds as metrics assume time metrics are in seconds.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
[SNIP]
> > > -                     case TOOL_PMU__EVENT_SYSTEM_TIME:
> > > -                             stats = &ru_stats.ru_stime_usec_stat;
> > > -                             scale = 1e-6;
> > > -                             break;
> >
> > I think this was broken as it seems to be converted to nsec in the
> > update_rusage_stats().
> 
> The global utime/stime is in usecs as in the name. In the tool_pmu it
> is converted to nanoseconds, for consistency with duration_time. In
> the new code the counters are all in nanoseconds and so the same
> scaling factor can be applied.

What do you mean by global utime/stime?

> 
> > > -                     case TOOL_PMU__EVENT_NONE:
> > > -                             pr_err("Invalid tool event 'none'");
> > > -                             abort();
> > > -                     case TOOL_PMU__EVENT_MAX:
> > > -                             pr_err("Invalid tool event 'max'");
> > > -                             abort();
> > > -                     case TOOL_PMU__EVENT_HAS_PMEM:
> > > -                     case TOOL_PMU__EVENT_NUM_CORES:
> > > -                     case TOOL_PMU__EVENT_NUM_CPUS:
> > > -                     case TOOL_PMU__EVENT_NUM_CPUS_ONLINE:
> > > -                     case TOOL_PMU__EVENT_NUM_DIES:
> > > -                     case TOOL_PMU__EVENT_NUM_PACKAGES:
> > > -                     case TOOL_PMU__EVENT_SLOTS:
> > > -                     case TOOL_PMU__EVENT_SMT_ON:
> > > -                     case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
> > > -                     case TOOL_PMU__EVENT_CORE_WIDE:
> > > -                     case TOOL_PMU__EVENT_TARGET_CPU:
> > > -                     default:
> > > -                             pr_err("Unexpected tool event '%s'", evsel__name(metric_events[i]));
> > > -                             abort();
> > >                       }
> > > -                     val = avg_stats(stats) * scale;
> > > -                     source_count = 1;
> > > -             } else {
> > > -                     struct perf_stat_evsel *ps = metric_events[i]->stats;
> > > -                     struct perf_stat_aggr *aggr;
> > > -
> > > +             }
> > > +             /* Time events are always on CPU0, the first aggregation index. */
> > > +             aggr = &ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
> > > +             if (!aggr || !metric_events[i]->supported) {
> > >                       /*
> > > -                      * If there are multiple uncore PMUs and we're not
> > > -                      * reading the leader's stats, determine the stats for
> > > -                      * the appropriate uncore PMU.
> > > +                      * Not supported events will have a count of 0, which
> > > +                      * can be confusing in a metric. Explicitly set the
> > > +                      * value to NAN. Not counted events (enable time of 0)
> > > +                      * are read as 0.
> > >                        */
> > > -                     if (evsel && evsel->metric_leader &&
> > > -                         evsel->pmu != evsel->metric_leader->pmu &&
> > > -                         mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
> > > -                             struct evsel *pos;
> > > -
> > > -                             evlist__for_each_entry(evsel->evlist, pos) {
> > > -                                     if (pos->pmu != evsel->pmu)
> > > -                                             continue;
> > > -                                     if (pos->metric_leader != mexp->metric_events[i])
> > > -                                             continue;
> > > -                                     ps = pos->stats;
> > > -                                     source_count = 1;
> > > -                                     break;
> > > -                             }
> > > -                     }
> > > -                     aggr = &ps->aggr[aggr_idx];
> > > -                     if (!aggr)
> > > -                             break;
> > > -
> > > -                     if (!metric_events[i]->supported) {
> > > -                             /*
> > > -                              * Not supported events will have a count of 0,
> > > -                              * which can be confusing in a
> > > -                              * metric. Explicitly set the value to NAN. Not
> > > -                              * counted events (enable time of 0) are read as
> > > -                              * 0.
> > > -                              */
> > > -                             val = NAN;
> > > -                             source_count = 0;
> > > -                     } else {
> > > -                             val = aggr->counts.val;
> > > -                             if (!source_count)
> > > -                                     source_count = evsel__source_count(metric_events[i]);
> > > -                     }
> > > +                     val = NAN;
> > > +                     source_count = 0;
> > > +             } else {
> > > +                     val = aggr->counts.val;
> > > +                     if (is_tool_time)
> > > +                             val *= 1e-9; /* Convert time event nanoseconds to seconds. */
> >
> > And this code treats all time events are in nsec now.
> 
> That's correct: user_time, system_time and duration_time are all
> counters that give a count in nanoseconds. However, in the metrics, I
> guess as the counts are doubles, the time has always been in whole
> seconds.

Yep, I think it's ok.

Thanks,
Namhyung

