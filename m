From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf report: Support caller callchain order when using
 DWARF unwinder.
Date: Mon, 2 Nov 2015 18:19:44 -0300
Message-ID: <20151102211944.GR2923@kernel.org>
References: <1443971797-25548-1-git-send-email-milian.wolff@kdab.com>
 <20151004203817.GE20515@kernel.org>
 <20151005110836.GA28364@krava.landal.opennet>
 <2192570.dg0L2eaEiH@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32982 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbbKBVTu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 2 Nov 2015 16:19:50 -0500
Content-Disposition: inline
In-Reply-To: <2192570.dg0L2eaEiH@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>

Em Fri, Oct 09, 2015 at 07:29:34PM +0200, Milian Wolff escreveu:
> On Montag, 5. Oktober 2015 13:08:36 CEST Jiri Olsa wrote:
> > On Sun, Oct 04, 2015 at 05:38:17PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Sun, Oct 04, 2015 at 05:16:37PM +0200, Milian Wolff escreveu:
> > > > We cannot reverse the order of the libunwind stepper. To workaround
> > > > this, we store the IPs in a temporary stack buffer and then walk
> > > > this buffer in reverse order when callchain_param.order is set to
> > > > ORDER_CALLER.
> > > > 
> > > > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > > 
> > > Jiri,
> > > 
> > > 	Can you please take a look at this?
> > > 
> > > - Arnaldo
> > > 
> > > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > ---
> > > > 
> > > >  tools/perf/util/unwind-libunwind.c | 21 +++++++++++++++++----
> > > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/tools/perf/util/unwind-libunwind.c
> > > > b/tools/perf/util/unwind-libunwind.c index 4c00507..bf631f1 100644
> > > > --- a/tools/perf/util/unwind-libunwind.c
> > > > +++ b/tools/perf/util/unwind-libunwind.c
> > > > @@ -621,11 +621,24 @@ static int get_entries(struct unwind_info *ui,
> > > > unwind_entry_cb_t cb,> > 
> > > >  	if (ret)
> > > >  	
> > > >  		display_error(ret);
> > > > 
> > > > -	while (!ret && (unw_step(&c) > 0) && max_stack--) {
> > > > -		unw_word_t ip;
> > > > +	if (callchain_param.order == ORDER_CALLEE) {
> > > > +		while (!ret && (unw_step(&c) > 0) && max_stack--) {
> > > > +			unw_word_t ip;
> > > > 
> > > > -		unw_get_reg(&c, UNW_REG_IP, &ip);
> > > > -		ret = ip ? entry(ip, ui->thread, cb, arg) : 0;
> > > > +			unw_get_reg(&c, UNW_REG_IP, &ip);
> > > > +			ret = ip ? entry(ip, ui->thread, cb, arg) : 0;
> > > > +		}
> > > > +	} else {
> > > > +		unw_word_t ips[max_stack];
> > > > +		int i = 0;
> > > > +
> > > > +		while ((unw_step(&c) > 0) && i < max_stack) {
> > > > +			unw_get_reg(&c, UNW_REG_IP, &ips[i]);
> > > > +			++i;
> > > > +		}
> > > > +		max_stack = i;
> > > > +		for (i = max_stack - 1; i >= 0; --i)
> > > > +			entry(ips[i], ui->thread, cb, arg);
> > 
> > there's no check for return value of entry callback
> > 
> > also I wonder would it be better to store into ips[] within
> > the single loop all the time, and iterate throught it after
> > forward/backward based on the callchain_param.order
> > 
> > please check attached patch, totaly untested, probably leaking some index
> > ;-)
> > 
> > any chance this could be done also for util/unwind-libdw.c ?
> 
> That patch looks much better than mine. I'll try it out later next week and 
> will also have a look at util/unwind-libdw.c. Question: How can I test the 

So, you tried this patch, right? Jiri, have you submitted this in some
other message I missed?

- Arnaldo

> behavior of the latter? Do I need to uninstall libunwind, or can I change the 
> unwinder at runtime somehow (env var?).
> 
> Also, are there unit tests for this behavior somewhere?
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
