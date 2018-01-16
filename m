From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/5] perf unwind: Do not look at globals
Date: Tue, 16 Jan 2018 20:30:35 +0100
Message-ID: <20180116193035.GA6183@krava>
References: <20180116142438.19520-1-acme@kernel.org>
 <20180116142438.19520-3-acme@kernel.org>
 <20180116151915.GC17819@krava>
 <20180116153621.GC16107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbeAPTal (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Jan 2018 14:30:41 -0500
Content-Disposition: inline
In-Reply-To: <20180116153621.GC16107@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>

On Tue, Jan 16, 2018 at 12:36:21PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 16, 2018 at 04:19:15PM +0100, Jiri Olsa escreveu:
> > On Tue, Jan 16, 2018 at 11:24:35AM -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > SNIP
> > 
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: David Ahern <dsahern@gmail.com>
> > > Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> > > Cc: Wang Nan <wangnan0@huawei.com>
> > > Link: https://lkml.kernel.org/n/tip-skbth8ufepbtw8xar7gdsb6l@git.kernel.org
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/unwind-libunwind-local.c | 9 ---------
> > >  1 file changed, 9 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> > > index 7a42f703e858..02dc5a9d8f72 100644
> > > --- a/tools/perf/util/unwind-libunwind-local.c
> > > +++ b/tools/perf/util/unwind-libunwind-local.c
> > > @@ -631,9 +631,6 @@ static unw_accessors_t accessors = {
> > >  
> > >  static int _unwind__prepare_access(struct thread *thread)
> > >  {
> > > -	if (callchain_param.record_mode != CALLCHAIN_DWARF)
> > > -		return 0;
> > > -
> > 
> > this would create thread->addr_space also for data without
> > dwarf callchains data, so I think we need to keep it
> > 
> > it should get set in apply_config_terms which calls parse_callchain_record
> 
> No, it should not set the global parameter, as this is just for a
> specific event, i.e. we can have something like:
> 
> 	perf record -e cycles/call-graph=dwarf/ \
> 		    -e instructions/call-graph=lbr/
> 		    -e cache-misses/call-graph=fp
> 
> And then get these samples for the same thread.
> 
> If you want to avoid creating thread->addr_space, and we do want that,
> sure, a followup patch should address that, we need to postpone
> allocating it till we get a DWARF callchain in a sample for that
> specific thread, when we then should allocate thread->addr_space.

yea that could be fixed.. however current code prevents
to create that for data without DWARF data, and your change
forces it

I guess that's addressed in your next email.. going to read it ;-)

jirka
