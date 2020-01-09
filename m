From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 8/9] perf top: Add --all-cgroups option
Date: Thu, 9 Jan 2020 16:55:21 +0900
Message-ID: <CAM9d7ch7t9GDu=emb9MYdTSB8hPb0adAy1iOdjyXSXVXTpGBFg@mail.gmail.com>
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-9-namhyung@kernel.org>
 <20200108222458.GF12995@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200108222458.GF12995@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jan 9, 2020 at 7:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:35:00PM +0900, Namhyung Kim wrote:
> > The --all-cgroups option is to enable cgroup profiling support.  It
> > tells kernel to record CGROUP events in the ring buffer so that perf
> > report can identify task/cgroup association later.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-top.txt | 4 ++++
> >  tools/perf/builtin-top.c              | 9 +++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> > index 5596129a71cf..c75507f50071 100644
> > --- a/tools/perf/Documentation/perf-top.txt
> > +++ b/tools/perf/Documentation/perf-top.txt
> > @@ -266,6 +266,10 @@ Default is to monitor all CPUS.
> >       Record events of type PERF_RECORD_NAMESPACES and display it with the
> >       'cgroup_id' sort key.
> >
> > +--cgroup::
> > +     Record events of type PERF_RECORD_CGROUP and display it with the
> > +     'cgroup' sort key.
>
> should be '--all-cgroups' ?

Oops, you're right.

>
> anyway, we dont have '--cgroups', why not use just this?

I chose it for consistency since perf record has '--cgroup' option.

Thanks
Namhyung
