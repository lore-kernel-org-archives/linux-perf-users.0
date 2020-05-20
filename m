From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 5/7] perf metricgroup: Remove duped metric group events
Date: Thu, 21 May 2020 00:09:12 +0200
Message-ID: <20200520220912.GP157452@krava>
References: <20200520072814.128267-1-irogers@google.com>
 <20200520072814.128267-6-irogers@google.com>
 <20200520134847.GM157452@krava>
 <CAP-5=fVGf9i7hvQcht_8mnMMjzhQYdFqPzZFraE-iMR7Vcr1tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fVGf9i7hvQcht_8mnMMjzhQYdFqPzZFraE-iMR7Vcr1tw@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>li
List-Id: linux-perf-users.vger.kernel.org

On Wed, May 20, 2020 at 09:50:13AM -0700, Ian Rogers wrote:

SNIP

> > > +             }
> >
> > is the groupping still enabled when we merge groups? could part
> > of the metric (events) be now computed in different groups?
> 
> By default the change will take two metrics and allow the shorter
> metric (in terms of number of events) to share the events of the
> longer metric. If the events for the shorter metric aren't in the
> longer metric then the shorter metric must use its own group of
> events. If sharing has occurred then the bitmap is used to work out
> which events and groups are no longer in use.
> 
> With --metric-no-group then any event can be used for a metric as
> there is no grouping. This is why more events can be eliminated.
> 
> With --metric-no-merge then the logic to share events between
> different metrics is disabled and every metric is in a group. This
> allows the current behavior to be had.
> 
> There are some corner cases, such as metrics with constraints (that
> don't group) and duration_time that is never placed into a group.
> 
> Partial sharing, with one event in 1 weak event group and 1 in another
> is never performed. Using --metric-no-group allows something similar.
> Given multiplexing, I'd be concerned about accuracy problems if events
> between groups were shared - say for IPC, were you measuring
> instructions and cycles at the same moment?

hum, I think that's also concern if you are multiplexing 2 groups and one
metric getting events from both groups that were not meassured together 

it makes sense to me put all the merged events into single weak group
anything else will have the issue you described above, no?

and perhaps add command line option for merging that to make sure it's
what user actuly wants

thanks,
jirka


> 
> > I was wondering if we could merge all the hasmaps into single
> > one before the parse the evlist.. this way we won't need removing
> > later.. but I did not thought this through completely, so it
> > might not work at some point
> 
> This could be done in the --metric-no-group case reasonably easily
> like the current hashmap. For groups you'd want something like a set
> of sets of events, but then you'd only be able to share events if the
> sets were the same. A directed acyclic graph could capture the events
> and the sharing relationships, it may be possible to optimize cases
> like {A,B,C}, {A,B,D}, {A,B} so that the small group on the end shares
> events with both the {A,B,C} and {A,B,D} group. This may be good
> follow up work. We could also solve this in the json, for example
> create a "phony" group of {A,B,C,D} that all three metrics share from.
> You could also use --metric-no-group to achieve that sharing now.
> 
> Thanks,
> Ian
> 
> > jirka
> >
> 
