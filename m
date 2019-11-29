From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 04/15] perf tools: Add map_groups to 'struct
 addr_location'
Date: Fri, 29 Nov 2019 13:06:31 -0300
Message-ID: <20191129160631.GD26963@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
 <20191112183757.28660-5-acme@kernel.org>
 <20191129134056.GE14169@krava>
 <20191129151733.GC26963@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191129151733.GC26963@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Nov 29, 2019 at 12:17:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 29, 2019 at 02:40:56PM +0100, Jiri Olsa escreveu:
> > > +++ b/tools/perf/util/callchain.c
> > > @@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
> > >  			goto out;
> > >  	}
> > >  
> > > -	if (al->map->groups == &al->machine->kmaps) {
> > > -		if (machine__is_host(al->machine)) {
> > > +	if (al->mg == &al->mg->machine->kmaps) {

> > heya, I'm getting segfault because of this change

> > perf record --call-graph dwarf ./ex

> > 	(gdb) r report --stdio
> > 	Program received signal SIGSEGV, Segmentation fault.
> > 	fill_callchain_info (al=0x7fffffffa1b0, node=0xcd2bd0, hide_unresolved=false) at util/callchain.c:1122
> > 	1122            if (al->maps == &al->maps->machine->kmaps) {
> > 	(gdb) p al->maps
> > 	$1 = (struct maps *) 0x0

> > I wish all those map changes would go through some review,
> > I have no idea how the code works now ;-)

> ouch, I did tons of tests, obviously some more, and reviewing, would
> catch these, my bad, will try and fix this...

> And yeah, I reproduced the problem, working on a fix.

Can you try with this one-liner?

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 416d174d223c..c8c5410315e8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2446,6 +2446,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 
 	list_for_each_entry(ilist, &inline_node->val, list) {
 		struct map_symbol ilist_ms = {
+			.maps = ms->maps,
 			.map = map,
 			.sym = ilist->symbol,
 		};
