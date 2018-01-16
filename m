From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/5] perf unwind: Do not look at globals
Date: Tue, 16 Jan 2018 20:55:55 +0100
Message-ID: <20180116195555.GC6183@krava>
References: <20180116142438.19520-1-acme@kernel.org>
 <20180116142438.19520-3-acme@kernel.org>
 <20180116151915.GC17819@krava>
 <20180116153621.GC16107@kernel.org>
 <20180116193035.GA6183@krava>
 <20180116194520.GF16107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180116194520.GF16107@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jan 16, 2018 at 04:45:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 16, 2018 at 08:30:35PM +0100, Jiri Olsa escreveu:
> > On Tue, Jan 16, 2018 at 12:36:21PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Jan 16, 2018 at 04:19:15PM +0100, Jiri Olsa escreveu:
> > > > On Tue, Jan 16, 2018 at 11:24:35AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > 
> > > > SNIP
> > > > 
> > > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > > Cc: David Ahern <dsahern@gmail.com>
> > > > > Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
> > > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > > Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> > > > > Cc: Wang Nan <wangnan0@huawei.com>
> > > > > Link: https://lkml.kernel.org/n/tip-skbth8ufepbtw8xar7gdsb6l@git.kernel.org
> > > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > ---
> > > > >  tools/perf/util/unwind-libunwind-local.c | 9 ---------
> > > > >  1 file changed, 9 deletions(-)
> > > > > 
> > > > > diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> > > > > index 7a42f703e858..02dc5a9d8f72 100644
> > > > > --- a/tools/perf/util/unwind-libunwind-local.c
> > > > > +++ b/tools/perf/util/unwind-libunwind-local.c
> > > > > @@ -631,9 +631,6 @@ static unw_accessors_t accessors = {
> > > > >  
> > > > >  static int _unwind__prepare_access(struct thread *thread)
> > > > >  {
> > > > > -	if (callchain_param.record_mode != CALLCHAIN_DWARF)
> > > > > -		return 0;
> > > > > -
> > > > 
> > > > this would create thread->addr_space also for data without
> > > > dwarf callchains data, so I think we need to keep it
> > > > 
> > > > it should get set in apply_config_terms which calls parse_callchain_record
> > > 
> > > No, it should not set the global parameter, as this is just for a
> > > specific event, i.e. we can have something like:
> > > 
> > > 	perf record -e cycles/call-graph=dwarf/ \
> > > 		    -e instructions/call-graph=lbr/
> > > 		    -e cache-misses/call-graph=fp
> > > 
> > > And then get these samples for the same thread.
> > > 
> > > If you want to avoid creating thread->addr_space, and we do want that,
> > > sure, a followup patch should address that, we need to postpone
> > > allocating it till we get a DWARF callchain in a sample for that
> > > specific thread, when we then should allocate thread->addr_space.
> > 
> > yea that could be fixed.. however current code prevents
> > to create that for data without DWARF data, and your change
> > forces it
> 
> Humm? Which code?

these bits

jirka


---
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 7a42f703e858..02dc5a9d8f72 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -631,9 +631,6 @@ static unw_accessors_t accessors = {

 static int _unwind__prepare_access(struct thread *thread)
 {
-       if (callchain_param.record_mode != CALLCHAIN_DWARF)
-               return 0;
-
        thread->addr_space = unw_create_addr_space(&accessors, 0);
        if (!thread->addr_space) {
                pr_err("unwind: Can't create unwind address space.\n");
@@ -646,17 +643,11 @@ static int _unwind__prepare_access(struct thread *thread)

 static void _unwind__flush_access(struct thread *thread)
 {
-       if (callchain_param.record_mode != CALLCHAIN_DWARF)
-               return;
-
        unw_flush_cache(thread->addr_space, 0, 0);
 }

 static void _unwind__finish_access(struct thread *thread)
 {
-       if (callchain_param.record_mode != CALLCHAIN_DWARF)
-               return;
-
        unw_destroy_addr_space(thread->addr_space);
 }
