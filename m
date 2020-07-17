From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Date: Fri, 17 Jul 2020 15:11:11 -0700
Message-ID: <CAP-5=fVu5wcb864RWa8_j8kv3XLU0Cr5nbhvrwBNytfgmuPObg@mail.gmail.com>
References: <20200716094216.1418659-1-kjain@linux.ibm.com> <20200716152237.GC373728@kernel.org>
 <a80eebc2-885c-171d-7c7a-74df727d60b4@linux.ibm.com> <20200717085536.GC528602@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200717085536.GC528602@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: kajoljain <kjain@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Paul Clarke <pc@us.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, maddy@linux.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, "Liang, Kan" <kan.liang@linux.intel.com>, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Fri, Jul 17, 2020 at 1:55 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jul 17, 2020 at 01:41:22PM +0530, kajoljain wrote:
> >
> >
> > On 7/16/20 8:52 PM, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Jul 16, 2020 at 03:12:11PM +0530, Kajol Jain escreveu:
> > >> Patchset enhance current runtime parameter support. It introduces new
> > >> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
> > >> used to specify perpkg events.
> > >>
> > >> The "PerCore" and "PerChip" specifies whether its core or chip events.
> > >> Based on which we can decide which runtime parameter user want to
> > >> access. Now character  '?' can refers different parameter based on user
> > >> requirement.
> > >>
> > >> Initially, every time we want to add new terms like chip, core, thread
> > >> etc, we need to create corrsponding fields in pmu_events and event
> > >> struct.
> > >> This patchset adds an enum called 'aggr_mode_class' which store all these
> > >> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
> > >> to capture these terms.
> > >> Now, if user wants to add any new term, they just need to add it in
> > >> the enum defined. I try to test it with  my current setup.
> > >>
> > >> I also need to replace PerPkg field to AggregationMode in all the
> > >> x86 uncore json files. It will great if Andi and team can test it
> > >> and let me know if they have any concerns.
> > >>
> > >> Changelog:
> > >> v2 -> v3:
> > >> - Did some nits changes suggested by Jiri include correction of
> > >>   indentation, and making PerCore/PerChip values forward after
> > >>   PerPkg as 1 in the enum.
> > >> - Rebase the patchset on Arnaldo's tmp.perf/core branch.
> > >> - Change RFC tag
> > >
> > > Hey, have anybody provided Acked-by/Reviewed-by for previous revisions
> > > of this patchset? If so you could have collected them for patches
> > > without changes, was that the case?
> >
> > Hi Arnaldo,
> >       I did get "Acked-by: Ian Rogers" on my initial prototype which I send in my RFC.
> > Link to the patch: https://lkml.org/lkml/2020/7/5/399
> >
> > After that, I break it down and made some nits changes as suggested by Jiri, that's why I didn't
> > add his Acked-by tag.
> > Ian should I add it, if it seems fine to you.
>
> I posted one more comment and I'd also like to hear from
> guys maintainng json list on intel side that they are ok
> with this, mainly the change introduced in:
>
>   pmu-events/x86/uncore: Replace PerPkg field to AggregationMode in x86 json files
>
> Andi?
>
> thanks,
> jirka

I am happy with this change.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
