From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
Date: Wed, 25 Mar 2020 09:17:42 -0300
Message-ID: <20200325121742.GI9917@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
 <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com>
 <20200324163444.GA162390@mtj.duckdns.org>
 <20200324201522.GP2452@worktop.programming.kicks-ass.net>
 <D53AD1F8-4B2B-4B30-BC72-59CCA7F0D268@gmail.com>
 <CAM9d7chu0xowWK19fBQdSueVmAacpE6qO4x4NPjOY9Tcm8_AqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM9d7chu0xowWK19fBQdSueVmAacpE6qO4x4NPjOY9Tcm8_AqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Melo <arnaldo.melo@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Mar 25, 2020 at 07:24:37PM +0900, Namhyung Kim escreveu:
> On Wed, Mar 25, 2020 at 6:25 AM Arnaldo Melo <arnaldo.melo@gmail.com> wrote:
> > On March 24, 2020 5:15:22 PM GMT-03:00, Peter Zijlstra <peterz@infradead.org> wrote:
> > >On Tue, Mar 24, 2020 at 12:34:44PM -0400, Tejun Heo wrote:
> > >> On Mon, Mar 23, 2020 at 08:58:04AM +0900, Namhyung Kim wrote:
> > >> > Hello Peter, Tejun and folks.
> > >> >
> > >> > Do you have any other comments on the kernel side?
> > >> > If not, can I get your Ack?
> > >>
> > >> Everything looks good from cgroup side. I think I acked all cgroup
> > >parts already
> > >> but if not please feel free to add
> > >>
> > >>  Acked-by: Tejun Heo <tj@kernel.org>
> > >
> > >Yeah, looks good to me too. Since it's mostly userspace patches, will
> > >you route it Arnaldo?
> > >
> > >Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > Thanks for the acks, I'll process it tomorrow, so tests passing it'll go Ingo's way for 5.7 tomorrow.
> 
> Thanks all for the acks,
> 
> Arnaldo, as it's floating around on the list about a month already
> I guess it needs a rebase.  Also I need to check TUI as Jiri reported.
> Will post a next version soon.

Thanks, I'll wait then.

- Arnaldo
