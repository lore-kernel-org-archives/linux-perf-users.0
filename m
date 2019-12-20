From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Date: Fri, 20 Dec 2019 20:50:12 +0900
Message-ID: <CAM9d7cgdHSTf9fLJeHVoinLdkii+-hXXmy7+kbzaj1zVFa53Uw@mail.gmail.com>
References: <20191220043253.3278951-1-namhyung@kernel.org> <20191220043253.3278951-2-namhyung@kernel.org>
 <20191220093335.GC2844@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191220093335.GC2844@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Dec 20, 2019 at 6:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index 377d794d3105..7bae2d3380a6 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -377,7 +377,8 @@ struct perf_event_attr {
> >                               ksymbol        :  1, /* include ksymbol events */
> >                               bpf_event      :  1, /* include bpf events */
> >                               aux_output     :  1, /* generate AUX records instead of events */
> > -                             __reserved_1   : 32;
> > +                             cgroup         :  1, /* include cgroup events */
> > +                             __reserved_1   : 31;
> >
> >       union {
> >               __u32           wakeup_events;    /* wakeup every n events */
> > @@ -1006,6 +1007,17 @@ enum perf_event_type {
> >        */
> >       PERF_RECORD_BPF_EVENT                   = 18,
> >
> > +     /*
> > +      * struct {
> > +      *      struct perf_event_header        header;
> > +      *      u64                             id;
> > +      *      u64                             path_len;
>
> You can leave out path_len (also u64 for a length field is silly).

Right, will remove.

Thanks
Namhyung


>
> > +      *      char                            path[];
> > +      *      struct sample_id                sample_id;
> > +      * };
> > +      */
> > +     PERF_RECORD_CGROUP                      = 19,
