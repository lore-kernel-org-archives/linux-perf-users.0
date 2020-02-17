From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Date: Mon, 17 Feb 2020 12:46:04 -0300
Message-ID: <20200217154604.GE19953@kernel.org>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-5-namhyung@kernel.org>
 <20200108215235.GA12995@krava>
 <CAM9d7cifgLKbu5KM+QF6ZK9DGbN=8g1oj+vzU3HcTfrUQHP5jg@mail.gmail.com>
 <CAM9d7chWNyFx6vBNZZea7exiwKhU+cwTY-Yaf2_cSXoJ1jSgcQ@mail.gmail.com>
 <20200121094246.GA707582@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200121094246.GA707582@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jan 21, 2020 at 10:42:46AM +0100, Jiri Olsa escreveu:
> On Mon, Jan 20, 2020 at 10:57:47PM +0900, Namhyung Kim wrote:
> > So I tried this but then realized that it's hard to get the perf_env later
> > when it needs to convert a cgroup id to name (ie. in sort_entry.se_snprintf).
> > I also checked maybe I can resolve it when a hist entry is added,
> > but it doesn't have the pointer there too.
 
> looks like there might be a path for standard report where hists
> are part of evsel object:
> 
>   'struct hist_entry' via ->hists to  'struct hists'
>   hists_to_evsel(hists) to 'struct evsel'
>   'struct evsel' via ->evlist to 'struct evlist'
>   and there you have evlist->env ;-)

Hey, recently I did work that ended up adding a 'struct maps' to 'struct
map_symbol' and then hist_entry::ms has it, enough?

i.e.:

hist_entry::ms->maps->machine

  he->ms->maps->machine
 
> however I was wondering if we could add 'machine' pointer
> to the hist object, that would make that simpler ;-)

Directly from one of its hist_entries? As above?
 
> not sure about the way.. would be nice if that'd work for
> both evsel hists and standalone ones like in c2c
 
> but maybe just some init helper that sets the pointer early on
> might do the job

Sorry for the delay in answering, was travelling/vacations, now taming a
huge mailbox :-\

- Arnaldo
