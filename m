From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf trace report with time consumed
Date: Tue, 5 Apr 2016 10:35:24 +0200
Message-ID: <20160405083524.GB17232@krava.brq.redhat.com>
References: <1894563.GPSC8z33rH@agathebauer>
 <4309725.73SKaCNb55@agathebauer>
 <20160404061408.GA2137@krava.local>
 <2600188.8x2NmCkWJL@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35272 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757451AbcDEIf1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 5 Apr 2016 04:35:27 -0400
Content-Disposition: inline
In-Reply-To: <2600188.8x2NmCkWJL@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, perf group <linux-perf-users@vger.kernel.org>

On Mon, Apr 04, 2016 at 11:17:11PM +0200, Milian Wolff wrote:

SNIP

>             7f688a5ef0c4 usleep (/usr/lib/libc-2.23.so)
>             5582244227cd main (/tmp/ex_sleep)
>   1001.702 ( 0.059 ms): ex_sleep/4390 nanosleep(rqtp: 0x7ffe4d16eec0                                        
> ) = 0
>                   20379e syscall_slow_exit_work ([kernel.kallsyms])
>                   203bc4 syscall_return_slowpath ([kernel.kallsyms])
>                   797248 int_ret_from_sys_call ([kernel.kallsyms])
>             7f688a5c5600 __nanosleep (/usr/lib/libc-2.23.so)
>             7f688a5ef0c4 usleep (/usr/lib/libc-2.23.so)
>             5582244227d7 main (/tmp/ex_sleep)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Is there a way to increase the event buffer or something like that to not lose 
> events when the costly dwarf unwinding happens for the first time? Consecutive 
> unwinding is cached by libunwind and much faster.

not sure about perf trace, but there's -m option available for perf record
that allows you to increase the buffer size

> 
> Alternatively, I could try to unwind in the `sys_enter`, but then I'd need to 
> buffer the output to print the trace after the duration line...
> 
> How would you guys handle this situation?
> 
> Also, Jiri, Arnaldo - what would be your suggestion on how to handle the 
> `thread::priv` situation - I doubt my naive `priv2` approach is acceptable.

yea, I think one priv is more than enough ;-)

I think we want to move the the unwinder usage of this field into separate field

thanks,
jirka
