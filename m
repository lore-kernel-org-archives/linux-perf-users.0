From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Date: Mon, 17 Feb 2020 11:22:04 -0800
Message-ID: <CAM9d7ciaNNJFxVPeCHkwkshDccbdYc2MMzM7+-eD_AVBnRM-aQ@mail.gmail.com>
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-5-namhyung@kernel.org>
 <20200108215235.GA12995@krava> <CAM9d7cifgLKbu5KM+QF6ZK9DGbN=8g1oj+vzU3HcTfrUQHP5jg@mail.gmail.com>
 <CAM9d7chWNyFx6vBNZZea7exiwKhU+cwTY-Yaf2_cSXoJ1jSgcQ@mail.gmail.com>
 <20200121094246.GA707582@krava> <20200217154604.GE19953@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200217154604.GE19953@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,

On Mon, Feb 17, 2020 at 7:46 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jan 21, 2020 at 10:42:46AM +0100, Jiri Olsa escreveu:
> > On Mon, Jan 20, 2020 at 10:57:47PM +0900, Namhyung Kim wrote:
> > > So I tried this but then realized that it's hard to get the perf_env later
> > > when it needs to convert a cgroup id to name (ie. in sort_entry.se_snprintf).
> > > I also checked maybe I can resolve it when a hist entry is added,
> > > but it doesn't have the pointer there too.
>
> > looks like there might be a path for standard report where hists
> > are part of evsel object:
> >
> >   'struct hist_entry' via ->hists to  'struct hists'
> >   hists_to_evsel(hists) to 'struct evsel'
> >   'struct evsel' via ->evlist to 'struct evlist'
> >   and there you have evlist->env ;-)
>
> Hey, recently I did work that ended up adding a 'struct maps' to 'struct
> map_symbol' and then hist_entry::ms has it, enough?
>
> i.e.:
>
> hist_entry::ms->maps->machine
>
>   he->ms->maps->machine

Yep, that's enough for my use.

>
> > however I was wondering if we could add 'machine' pointer
> > to the hist object, that would make that simpler ;-)
>
> Directly from one of its hist_entries? As above?

Right, any path from hist_entry to perf_env would be ok.

>
> > not sure about the way.. would be nice if that'd work for
> > both evsel hists and standalone ones like in c2c
>
> > but maybe just some init helper that sets the pointer early on
> > might do the job
>
> Sorry for the delay in answering, was travelling/vacations, now taming a
> huge mailbox :-\

No problem, I'll send the next version soon.

Thanks
Namhyung
