From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/5] perf unwind: Do not look at globals
Date: Tue, 16 Jan 2018 12:36:21 -0300
Message-ID: <20180116153621.GC16107@kernel.org>
References: <20180116142438.19520-1-acme@kernel.org>
 <20180116142438.19520-3-acme@kernel.org>
 <20180116151915.GC17819@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbeAPPgZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Jan 2018 10:36:25 -0500
Content-Disposition: inline
In-Reply-To: <20180116151915.GC17819@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>

Em Tue, Jan 16, 2018 at 04:19:15PM +0100, Jiri Olsa escreveu:
> On Tue, Jan 16, 2018 at 11:24:35AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> > Cc: Wang Nan <wangnan0@huawei.com>
> > Link: https://lkml.kernel.org/n/tip-skbth8ufepbtw8xar7gdsb6l@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/unwind-libunwind-local.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> > index 7a42f703e858..02dc5a9d8f72 100644
> > --- a/tools/perf/util/unwind-libunwind-local.c
> > +++ b/tools/perf/util/unwind-libunwind-local.c
> > @@ -631,9 +631,6 @@ static unw_accessors_t accessors = {
> >  
> >  static int _unwind__prepare_access(struct thread *thread)
> >  {
> > -	if (callchain_param.record_mode != CALLCHAIN_DWARF)
> > -		return 0;
> > -
> 
> this would create thread->addr_space also for data without
> dwarf callchains data, so I think we need to keep it
> 
> it should get set in apply_config_terms which calls parse_callchain_record

No, it should not set the global parameter, as this is just for a
specific event, i.e. we can have something like:

	perf record -e cycles/call-graph=dwarf/ \
		    -e instructions/call-graph=lbr/
		    -e cache-misses/call-graph=fp

And then get these samples for the same thread.

If you want to avoid creating thread->addr_space, and we do want that,
sure, a followup patch should address that, we need to postpone
allocating it till we get a DWARF callchain in a sample for that
specific thread, when we then should allocate thread->addr_space.

But then we need to break that prepare routine, the part that needs the
map needs to set something in the 'struct thread' to mark what kind of
unwind ops should be used if we ever get a sample with a DWARF
callchain for that thread later on the perf.data (or live session), and
when that happens, look if the thread->addr_space is allocated and
allocate it if not.

> once it detects some 'call-graph' term setup.. something's probably wrong
> there?

See above. The fix in this patch is the quickest, i.e. we make sure that
if we ever find DWARF callchains, what we need will be there. We could
introduce a new global variable that would be touched by
apply_config_terms() now, and touch that, not the global config, that
may be used by other code, that would think that hey, DWARF is globally
configured, when it is just by some of the events.

But if we do that, we will waste some space anyway since not all threads
will have DWARF callchains, e.g. in a system wide session.

- Arnaldo
 
> jirka
> 
> >  	thread->addr_space = unw_create_addr_space(&accessors, 0);
> >  	if (!thread->addr_space) {
> >  		pr_err("unwind: Can't create unwind address space.\n");
> > @@ -646,17 +643,11 @@ static int _unwind__prepare_access(struct thread *thread)
> >  
> >  static void _unwind__flush_access(struct thread *thread)
> >  {
> > -	if (callchain_param.record_mode != CALLCHAIN_DWARF)
> > -		return;
> > -
> >  	unw_flush_cache(thread->addr_space, 0, 0);
> >  }
> >  
> >  static void _unwind__finish_access(struct thread *thread)
> >  {
> > -	if (callchain_param.record_mode != CALLCHAIN_DWARF)
> > -		return;
> > -
> >  	unw_destroy_addr_space(thread->addr_space);
> >  }
> >  
> > -- 
> > 2.14.3
> > 
