From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 04/15] perf tools: Add map_groups to 'struct
 addr_location'
Date: Fri, 29 Nov 2019 12:17:33 -0300
Message-ID: <20191129151733.GC26963@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
 <20191112183757.28660-5-acme@kernel.org>
 <20191129134056.GE14169@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191129134056.GE14169@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Nov 29, 2019 at 02:40:56PM +0100, Jiri Olsa escreveu:
> On Tue, Nov 12, 2019 at 03:37:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > From there we can get al->mg->machine, so replace that field with the
> > more useful 'struct map_groups' that for now we're obtaining from
> > al->map->groups, and that is one thing getting into the way of maps
> > being fully shareable.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lkml.kernel.org/n/tip-4qdducrm32tgrjupcp0kjh1e@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/callchain.c                          |  6 +++---
> >  tools/perf/util/db-export.c                          | 12 ++++++------
> >  tools/perf/util/event.c                              |  6 +++---
> >  .../perf/util/scripting-engines/trace-event-python.c |  2 +-
> >  tools/perf/util/symbol.h                             |  2 +-
> >  5 files changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > index 9a9b56ed3f0a..89faa644b0bc 100644
> > --- a/tools/perf/util/callchain.c
> > +++ b/tools/perf/util/callchain.c
> > @@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
> >  			goto out;
> >  	}
> >  
> > -	if (al->map->groups == &al->machine->kmaps) {
> > -		if (machine__is_host(al->machine)) {
> > +	if (al->mg == &al->mg->machine->kmaps) {
> 
> heya, I'm getting segfault because of this change
> 
> perf record --call-graph dwarf ./ex
> 
> 	(gdb) r report --stdio
> 	Program received signal SIGSEGV, Segmentation fault.
> 	fill_callchain_info (al=0x7fffffffa1b0, node=0xcd2bd0, hide_unresolved=false) at util/callchain.c:1122
> 	1122            if (al->maps == &al->maps->machine->kmaps) {
> 	(gdb) p al->maps
> 	$1 = (struct maps *) 0x0
> 
> I wish all those map changes would go through some review,
> I have no idea how the code works now ;-)

ouch, I did tons of tests, obviously some more, and reviewing, would
catch these, my bad, will try and fix this...

And yeah, I reproduced the problem, working on a fix.

- Arnaldo
