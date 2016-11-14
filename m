From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: can not trace function (main) with perf-probe
Date: Mon, 14 Nov 2016 11:55:36 -0300
Message-ID: <20161114145536.GA24331@kernel.org>
References: <CABvthirHujJiKsYc_1Fq=sy9SoYzg0h9XyYGxe-LRf10YdXn8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932280AbcKNOzu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2016 09:55:50 -0500
Content-Disposition: inline
In-Reply-To: <CABvthirHujJiKsYc_1Fq=sy9SoYzg0h9XyYGxe-LRf10YdXn8g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: HOUSSEN Franck <fghoussen@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, namhyung@kernel.org, jolsa@kernel.org, penberg@kernel.org, linux-perf-users@vger.kernel.org

Em Sun, Nov 13, 2016 at 12:10:05PM +0100, HOUSSEN Franck escreveu:
> I can not trace the main function (hello world) with perf-probe.

You should send this to a list, like I'm doing now, not in private, I suggest
linux-perf-users@vger.kernel.org, info about it:

http://vger.kernel.org/vger-lists.html#linux-perf-users
 
> perf-report reports:
> # Overhead  Trace output
> # ........  ............
> #
>    100.00%  (563a994a56b
> Instead of the expected:
> # Overhead  Trace output
> # ........  ............
> #
>    100.00%  main

So, trying this:

[root@jouet c]# cat hello.c
#include <stdio.h>

int main(void)
{
	printf("hello, world\n");
	return 0;
}
[root@jouet c]# make hello
cc     hello.c   -o hello
[root@jouet c]# perf probe -x ./hello main
Added new event:
  probe_hello:main     (on main in /home/acme/c/hello)

You can now use it in all perf tools, such as:

	perf record -e probe_hello:main -aR sleep 1

[root@jouet c]# perf record -e probe_hello:main ./hello
hello, world
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.021 MB perf.data (1 samples) ]
[root@jouet c]# perf report --no-header --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 1  of event 'probe_hello:main'
# Event count (approx.): 1
#
# Overhead  Trace output
# ........  ............
#
   100.00%  (400526)


#
# (Tip: Create an archive with symtabs to analyse on other machine: perf archive)
#
[root@jouet c]# 


Reproduced, this ends up showing just the trace fields for this tracepoint:

[root@jouet c]# perf evlist --trace
probe_hello:main: trace_fields: __probe_ip
[root@jouet c]# perf script
           hello 26213 [003] 174431.417607: probe_hello:main: (400526)
[root@jouet c]# 

If we instead ask for dso,sym, as it is done for non-tracepoint events, we'd get:

[root@jouet c]# perf report --no-header --stdio -s dso,sym
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 1  of event 'probe_hello:main'
# Event count (approx.): 1
#
# Overhead  Shared Object  Symbol  
# ........  .............  ........
#
   100.00%  hello          [.] main

You can get both with:

[root@jouet c]# perf report --no-header --stdio -s dso,sym,trace
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 1  of event 'probe_hello:main'
# Event count (approx.): 1
#
# Overhead  Shared Object  Symbol    Trace output
# ........  .............  ........  ............
#
   100.00%  hello          [.] main  (400526)


[root@jouet c]#

Please look at the --sort/-s docs for further information:

[root@jouet c]# perf report -h -s

 Usage: perf report [<options>]

    -s, --sort <key[,key2...]>
                          sort by key(s): pid, comm, dso, symbol, parent, cpu, srcline, ... Please refer the man page for the complete list.

[root@jouet c]# 

Some other example:

[root@jouet c]# perf report --no-header --stdio -s dso,sym,pid,cpu
# To display the perf.data header info, please use
# --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 1  of event 'probe_hello:main'
# Event count (approx.): 1
#
# Overhead  Shared Object  Symbol        Pid:Command  CPU
# ........  .............  ........  ...............  ...
#
   100.00%  hello          [.] main    26213:hello    003


[root@jouet c]#

- Arnaldo

 
> I use perf record/report with other events and I get some reports with
> expected symbols (= name of functions instead of their memory
> address).
> 
> Did I miss something when using perf-probe or perf-record / perf-report ?
> 
> Franck
> 
> /tmp> more main.cpp
> #include <unistd.h> // sleep
> int main(void) { sleep(10); return 0; }
> 
> /tmp> gcc -g main.cpp -o main
> 
> /tmp> sudo perf probe --exec ./main --add main
> Added new event:
>   probe_main:main      (on main in /tmp/main)
>   You can now use it in all perf tools, such as:
>     perf record -e probe_main:main -aR sleep 1
> 
> /tmp> sudo perf record -e probe_main:main ./main
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (1 samples) ]
> 
> /tmp> sudo perf report --stdio
> # To display the perf.data header info, please use
> --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 1  of event 'probe_main:main'
> # Event count (approx.): 1
> #
> # Overhead  Trace output
> # ........  ............
> #
>    100.00%  (563a994a56b
> #
> # (Tip: List events using substring match: perf list <keyword>)
> #
> 
> ~> lsb_release -a
> No LSB modules are available.
> Distributor ID: Debian
> Description:  Debian GNU/Linux testing (stretch)
> Release:  testing
> Codename: stretch
> 
> ~> cat /proc/sys/kernel/perf_event_paranoid
> -1
> 
> ~> cat /proc/sys/kernel/kptr_restrict
> 0
> 
> ~> gcc --version
> gcc (Debian 6.2.0-10) 6.2.0 20161027
> 
> ~> perf --version
> perf version 4.7.8
> 
> ~> uname -a
> Linux yoda 4.7.0-1-amd64 #1 SMP Debian 4.7.8-1 (2016-10-19) x86_64 GNU/Linux
