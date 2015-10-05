From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf report: Support caller callchain order when using
 DWARF unwinder.
Date: Mon, 5 Oct 2015 13:08:36 +0200
Message-ID: <20151005110836.GA28364@krava.landal.opennet>
References: <1443971797-25548-1-git-send-email-milian.wolff@kdab.com>
 <20151004203817.GE20515@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58706 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbbJELIk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 5 Oct 2015 07:08:40 -0400
Content-Disposition: inline
In-Reply-To: <20151004203817.GE20515@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>

On Sun, Oct 04, 2015 at 05:38:17PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Oct 04, 2015 at 05:16:37PM +0200, Milian Wolff escreveu:
> > We cannot reverse the order of the libunwind stepper. To workaround
> > this, we store the IPs in a temporary stack buffer and then walk
> > this buffer in reverse order when callchain_param.order is set to
> > ORDER_CALLER.
> > 
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> 
> Jiri,
> 
> 	Can you please take a look at this?
> 
> - Arnaldo
>  
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > ---
> >  tools/perf/util/unwind-libunwind.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
> > index 4c00507..bf631f1 100644
> > --- a/tools/perf/util/unwind-libunwind.c
> > +++ b/tools/perf/util/unwind-libunwind.c
> > @@ -621,11 +621,24 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
> >  	if (ret)
> >  		display_error(ret);
> >  
> > -	while (!ret && (unw_step(&c) > 0) && max_stack--) {
> > -		unw_word_t ip;
> > +	if (callchain_param.order == ORDER_CALLEE) {
> > +		while (!ret && (unw_step(&c) > 0) && max_stack--) {
> > +			unw_word_t ip;
> >  
> > -		unw_get_reg(&c, UNW_REG_IP, &ip);
> > -		ret = ip ? entry(ip, ui->thread, cb, arg) : 0;
> > +			unw_get_reg(&c, UNW_REG_IP, &ip);
> > +			ret = ip ? entry(ip, ui->thread, cb, arg) : 0;
> > +		}
> > +	} else {
> > +		unw_word_t ips[max_stack];
> > +		int i = 0;
> > +
> > +		while ((unw_step(&c) > 0) && i < max_stack) {
> > +			unw_get_reg(&c, UNW_REG_IP, &ips[i]);
> > +			++i;
> > +		}
> > +		max_stack = i;
> > +		for (i = max_stack - 1; i >= 0; --i)
> > +			entry(ips[i], ui->thread, cb, arg);

there's no check for return value of entry callback

also I wonder would it be better to store into ips[] within
the single loop all the time, and iterate throught it after
forward/backward based on the callchain_param.order

please check attached patch, totaly untested, probably leaking some index ;-)

any chance this could be done also for util/unwind-libdw.c ?

thanks,
jirka


---
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 4c00507ee3fd..f91433f868f9 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -609,9 +609,10 @@ void unwind__finish_access(struct thread *thread)
 static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 		       void *arg, int max_stack)
 {
+	unw_word_t ips[max_stack];
 	unw_addr_space_t addr_space;
 	unw_cursor_t c;
-	int ret;
+	int ret, i = 0;
 
 	addr_space = thread__priv(ui->thread);
 	if (addr_space == NULL)
@@ -621,11 +622,19 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	if (ret)
 		display_error(ret);
 
-	while (!ret && (unw_step(&c) > 0) && max_stack--) {
-		unw_word_t ip;
+	while ((unw_step(&c) > 0) && i < max_stack) {
+		unw_get_reg(&c, UNW_REG_IP, &ips[i]);
+		++i;
+	}
+
+	max_stack = i;
+
+	for (i = 0; i < max_stack && !ret; i++) {
+		int j = i;
 
-		unw_get_reg(&c, UNW_REG_IP, &ip);
-		ret = ip ? entry(ip, ui->thread, cb, arg) : 0;
+		if (callchain_param.order == ORDER_CALLER)
+			j = max_stack - i - 1;
+		ret = entry(ips[j], ui->thread, cb, arg);
 	}
 
 	return ret;
