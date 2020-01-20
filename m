From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Date: Mon, 20 Jan 2020 22:57:47 +0900
Message-ID: <CAM9d7chWNyFx6vBNZZea7exiwKhU+cwTY-Yaf2_cSXoJ1jSgcQ@mail.gmail.com>
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-5-namhyung@kernel.org>
 <20200108215235.GA12995@krava> <CAM9d7cifgLKbu5KM+QF6ZK9DGbN=8g1oj+vzU3HcTfrUQHP5jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAM9d7cifgLKbu5KM+QF6ZK9DGbN=8g1oj+vzU3HcTfrUQHP5jg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Jiri,

On Thu, Jan 9, 2020 at 9:51 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Jiri,
>
> On Thu, Jan 9, 2020 at 6:52 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Jan 07, 2020 at 10:34:56PM +0900, Namhyung Kim wrote:
> > > Each cgroup is kept in the global cgroup_tree sorted by the cgroup id.
> > > Hist entries have cgroup id can compare it directly and later it can
> > > be used to find a group name using this tree.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/cgroup.c  | 72 +++++++++++++++++++++++++++++++++++++++
> > >  tools/perf/util/cgroup.h  | 15 +++++---
> > >  tools/perf/util/machine.c |  7 ++++
> > >  tools/perf/util/session.c |  4 +++
> > >  4 files changed, 94 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > > index 4881d4af3381..4e8ef1db0c94 100644
> > > --- a/tools/perf/util/cgroup.c
> > > +++ b/tools/perf/util/cgroup.c
> > > @@ -13,6 +13,8 @@
> > >
> > >  int nr_cgroups;
> > >
> > > +static struct rb_root cgroup_tree = RB_ROOT;
> >
> > I think we shoud carry that in 'struct perf_env'
>
> OK, will move.

So I tried this but then realized that it's hard to get the perf_env later
when it needs to convert a cgroup id to name (ie. in sort_entry.se_snprintf).
I also checked maybe I can resolve it when a hist entry is added,
but it doesn't have the pointer there too.

Thanks
Namhyung
