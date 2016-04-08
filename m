From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf tools: Add dedicated unwind addr_space member into
 thread struct
Date: Fri, 8 Apr 2016 09:58:42 -0300
Message-ID: <20160408125842.GL5945@kernel.org>
References: <1894563.GPSC8z33rH@agathebauer>
 <20160405083524.GB17232@krava.brq.redhat.com>
 <20160406154657.GA14971@krava.brq.redhat.com>
 <2529332.MbcSn26IoS@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58708 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758351AbcDHM6q (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 8 Apr 2016 08:58:46 -0400
Content-Disposition: inline
In-Reply-To: <2529332.MbcSn26IoS@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>, perf group <linux-perf-users@vger.kernel.org>

Em Wed, Apr 06, 2016 at 11:15:27PM +0200, Milian Wolff escreveu:
> On Mittwoch, 6. April 2016 17:46:57 CEST Jiri Olsa wrote:
> > On Tue, Apr 05, 2016 at 10:35:24AM +0200, Jiri Olsa wrote:
> > > On Mon, Apr 04, 2016 at 11:17:11PM +0200, Milian Wolff wrote:
> > > 
> > > SNIP
> > > 
> > > >             7f688a5ef0c4 usleep (/usr/lib/libc-2.23.so)
> > > >             5582244227cd main (/tmp/ex_sleep)
> > > >   
> > > >   1001.702 ( 0.059 ms): ex_sleep/4390 nanosleep(rqtp: 0x7ffe4d16eec0
> > > > 
> > > > ) = 0
> > > > 
> > > >                   20379e syscall_slow_exit_work ([kernel.kallsyms])
> > > >                   203bc4 syscall_return_slowpath ([kernel.kallsyms])
> > > >                   797248 int_ret_from_sys_call ([kernel.kallsyms])
> > > >             
> > > >             7f688a5c5600 __nanosleep (/usr/lib/libc-2.23.so)
> > > >             7f688a5ef0c4 usleep (/usr/lib/libc-2.23.so)
> > > >             5582244227d7 main (/tmp/ex_sleep)
> > > > 
> > > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > 
> > > > Is there a way to increase the event buffer or something like that to
> > > > not lose events when the costly dwarf unwinding happens for the first
> > > > time? Consecutive unwinding is cached by libunwind and much faster.
> > > 
> > > not sure about perf trace, but there's -m option available for perf record
> > > that allows you to increase the buffer size
> > > 
> > > > Alternatively, I could try to unwind in the `sys_enter`, but then I'd
> > > > need to buffer the output to print the trace after the duration line...
> > > > 
> > > > How would you guys handle this situation?
> > > > 
> > > > Also, Jiri, Arnaldo - what would be your suggestion on how to handle the
> > > > `thread::priv` situation - I doubt my naive `priv2` approach is
> > > > acceptable.
> > > 
> > > yea, I think one priv is more than enough ;-)
> > > 
> > > I think we want to move the the unwinder usage of this field into separate
> > > field
> > need to run test over this, but will try to post it this week
> > let me know if this solution would work for you
> 
> Yes, works for me, thanks a lot!
> 
> Feel free to add
> 
>     Tested-by: Milian Wolff <milian.wolff@kdab.com>

Added, thanks,

- Arnaldo
