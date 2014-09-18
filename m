From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 10:23:50 -0300
Message-ID: <20140918132350.GE2770@kernel.org>
References: <2221771.b2oSN5LR6X@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:57621 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682AbaIRNYA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 09:24:00 -0400
Content-Disposition: inline
In-Reply-To: <2221771.b2oSN5LR6X@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Em Thu, Sep 18, 2014 at 02:32:10PM +0200, Milian Wolff escreveu:
> Hello,
> 
> is it somehow possible to use perf based on some kernel timer? I'd like to get 

Try with tracepoints or with probe points combined with callchains
instead of using a hardware counter.

- Arnaldo

> an overview of where a userspace application is spending time, both on-CPU as 
> well as waiting off-CPU. E.g. something similar to using GDB as a poor-mans 
> profiler and regularly interrupting the process and investigating the 
> callgraphs. This is quite efficient for a high-level overview when you want to 
> figure out where time is spent, unrelated to how it was actually spent (cpu, 
> thread locks, io wait, ...).
> 
> E.g. what event would I use for a simple application like this:
> 
> ~~~~~~~~~~~~~~
> #include <unistd.h>
> 
> int main()
> {
>   sleep(10);
>   return 0;
> }
> ~~~~~~~~~~~~~~
> 
> Which perf event would show me that most of the time is spent sleeping? I 
> tried something like this to no avail:
> 
> $ perf record --call-graph dwarf -e cpu-clock -F 100 ./a.out 
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.007 MB perf.data (~304 samples) ]
> perf report --stdio
> Error:
> The perf.data file has no samples!
> # To display the perf.data header info, please use --header/--header-only 
> options.
> 
> I read https://perf.wiki.kernel.org/index.php/Tutorial#Profiling_sleep_times
> and tried it out. The result is odd, as I get the "same" backtrace multiple 
> times, all with 100% cost:
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~
>    100.00%     0.00%             0    a.out  libc-2.19.so       [.] 
> __GI___libc_nanosleep
>               |
>               --- __GI___libc_nanosleep
> 
>    100.00%     0.00%             0    a.out  [kernel.kallsyms]  [k] 
> system_call_fastpath 
>               |
>               --- system_call_fastpath
>                   __GI___libc_nanosleep
> 
>    100.00%     0.00%             0    a.out  [kernel.kallsyms]  [k] 
> sys_nanosleep        
>               |
>               --- sys_nanosleep
>                   system_call_fastpath
>                   __GI___libc_nanosleep
> 
>    100.00%     0.00%             0    a.out  [kernel.kallsyms]  [k] 
> hrtimer_nanosleep    
>               |
>               --- hrtimer_nanosleep
>                   sys_nanosleep
>                   system_call_fastpath
>                   __GI___libc_nanosleep
> ~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> And generally, this would *only* profile sleep time and would ignore the on-
> CPU time (and maybe thread waits) and so forth.
> 
> Is there a technical reason on why it is not possible to use a plain timer as 
> a sampling event? If I'm not mistaken, then Intel VTune actually uses a 
> similar technique for its simple profiling modes which can already give 
> extremely useful data - both to find CPU hotspots as well as locks&waits.
> 
> Bye
> -- 
> Milian Wolff
> mail@milianw.de
> http://milianw.de
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
