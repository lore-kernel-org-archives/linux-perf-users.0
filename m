From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 5/7] perf metricgroup: Remove duped metric group events
Date: Thu, 21 May 2020 10:26:02 -0700
Message-ID: <CAP-5=fWfV=+TY80kvTz9ZmzzzR5inYbZXRuQfsLfe9tPG7eJrQ@mail.gmail.com>
References: <20200520072814.128267-1-irogers@google.com> <20200520072814.128267-6-irogers@google.com>
 <20200520134847.GM157452@krava> <CAP-5=fVGf9i7hvQcht_8mnMMjzhQYdFqPzZFraE-iMR7Vcr1tw@mail.gmail.com>
 <20200520220912.GP157452@krava> <CAP-5=fU12vP45Sg3uRSuz-xoceTPTKw9-XZieKv1PaTnREMdrw@mail.gmail.com>
 <20200521105412.GS157452@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200521105412.GS157452@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>li
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 21, 2020 at 3:54 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, May 20, 2020 at 03:42:02PM -0700, Ian Rogers wrote:
>
> SNIP
>
> > >
> > > hum, I think that's also concern if you are multiplexing 2 groups and one
> > > metric getting events from both groups that were not meassured together
> > >
> > > it makes sense to me put all the merged events into single weak group
> > > anything else will have the issue you described above, no?
> > >
> > > and perhaps add command line option for merging that to make sure it's
> > > what user actuly wants
> >
> > I'm not sure I'm following. With the patch set if we have 3 metrics
> > with the event groups shown:
> > M1: {A,B,C}:W
> > M2: {A,B}:W
> > M3: {A,B,D}:W
> >
> > then what happens is we sort the metrics in to M1, M3, M2 then when we
> > come to match the events:
> >
> >  - by default: match events allowing sharing if all events come from
> > the same group. So in the example M1 will first match with {A,B,C}
> > then M3 will fail to match the group {A,B,C} but match {A,B,D}; M2
> > will succeed with matching {A,B} from M1. The events/group for M2 can
> > be removed as they are no longer used. This kind of sharing is
> > opportunistic and respects existing groupings. While it may mean a
> > metric is computed from a group that now multiplexes, that group will
> > run for more of the time as there are fewer groups to multiplex with.
> > In this example we've gone from 3 groups down to 2, 8 events down to
> > 6. An improvement would be to realize that A,B is in both M1 and M3,
> > so when we print the stat we could combine these values.
>
> ok, I misunderstood and thought you would colaps also M3 to
> have A,B computed via M1 group and with separate D ...
>
> thanks a lot for the explanation, it might be great to have it
> in the comments/changelog or even man page

Thanks Jiri! Arnaldo do you want me to copy the description above into
the commit message of this change and resend?
This patch adds some description to find_evsel_group, this is expanded
by the next patch that adds the two command line flags:
https://lore.kernel.org/lkml/20200520072814.128267-7-irogers@google.com/
When writing the patches it wasn't clear to me how much detail to
include in say the man pages.

Thanks,
Ian

> >
> >  - with --metric-no-merge: no events are shared by metrics M1, M2 and
> > M3 have their events and computation as things currently are. There
> > are 3 groups and 8 events.
> >
> >  - with --metric-no-group: all groups are removed and so the evlist
> > has A,B,C,A,B,A,B,D in it. The matching will now match M1 to A,B,C at
> > the beginning of the list, M2 to the first A,B and M3 to the same A,B
> > and D at the end of the list. We've got no groups and the events have
> > gone from 8 down to 4.
> >
> > It is difficult to reason about which grouping is most accurate. If we
> > have 4 counters (no NMI watchdog) then this example will fit with no
> > multiplexing. The default above should achieve less multiplexing, in
> > the same way merging PMU events currently does - this patch is trying
> > to mirror the --no-merge functionality to a degree. Considering
> > TopDownL1 then we go from metrics that never sum to 100%, to metrics
> > that do in either the default or --metric-no-group cases.
> >
> > I'm not sure what user option is missing with these combinations? The
> > default is trying to strike a compromise and I think user interaction
> > is unnecessary, just as --no-merge doesn't cause interaction. If the
> > existing behavior is wanted using --metric-no-merge will give that.
> > The new default and --metric-no-group are hopefully going to reduce
> > the number of groups and events. I'm somewhat agnostic as to what the
> > flag functionality should be as what I'm working with needs either the
> > default or --metric-no-group, I can use whatever flag is agreed upon.
>
> no other option is needed then
>
> thanks,
> jirka
>
