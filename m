From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Inlined functions in perf report
Date: Tue, 20 Dec 2016 13:17:55 +0100
Message-ID: <20161220121755.GL3124@twins.programming.kicks-ass.net>
References: <20161220115954.GA35897@sesse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755868AbcLTMR6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Dec 2016 07:17:58 -0500
Content-Disposition: inline
In-Reply-To: <20161220115954.GA35897@sesse.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>

On Tue, Dec 20, 2016 at 12:59:54PM +0100, Steinar H. Gunderson wrote:
> Hi Peter,
> 
> I can't find a good point of contact for perf, so I'm contacting you based on
> the MAINTAINERS file; feel free to redirect somewhere if you're not the right
> person.
> 

Cc'ed linux-perf-users@vger.kernel.org

> I'm trying to figure out how to deal with perf report when there are inlined
> functions; they don't generally seem to show up in the call stack, which
> sometimes can make it very hard to figure out what is going, especially in
> a code base one doesn't know too well. As an example, I threw together a
> minimal test program:
> 
>   #include <stdlib.h>
>   
>   inline int foo()
>   {
>           int k = rand();
>           int sum = 1;
>           for (int i = 0; i < 10000000000; ++i)
>           {
>                   sum ^= k;
>                   sum += k;
>           }
>           return sum;
>   }
>   
>   int main(void)
>   {
>           return foo();
>   }
> 
> Compiling with -O2 -g, and running perf record -g yields:
> 
>   # Samples: 6K of event 'cycles:ppp'
>   # Event count (approx.): 5876825543
>   #
>   # Children      Self  Command  Shared Object      Symbol                
>   # ........  ........  .......  .................  ......................
>   #
>       99.98%    99.98%  inline   inline             [.] main
>               |
>               ---0x706258d4c544155
>                  main
>   
>       99.98%     0.00%  inline   [unknown]          [.] 0x0706258d4c544155
>               |
>               ---0x706258d4c544155
>                  main
> 
> Is there a way I can get it to show “foo” in the call graph? (I suppose also
> ideally, “foo” and not “main” should show up in a non-graph run.) Of course,
> this gets even more confusing if foo calls bar, since it now looks like the
> call chain is main -> bar directly.
> 
> I have debug information that should be sufficient in the binary, because if
> I break in gdb, I definitely get the call stack:
> 
>   Program received signal SIGINT, Interrupt.
>   0x0000555555554589 in foo () at inline.c:5
>   5               int k = rand();
>   (gdb) bt
>   #0  0x0000555555554589 in foo () at inline.c:5
>   #1  main () at inline.c:17
>   (gdb) 
> 
> FWIW, this is with perf from 4.10 (git as of a few days ago) and GCC 6.2.1.

OK, so it might be possible with: perf record -g --call-graph dwarf
but that's fairly heavy on the overhead, it will dump the top-of-stack
for each sample (8k default) and unwind using libunwind in userspace.

The default mechanism used for call-graphs is frame-pointers which are
(relatively) simple and fast to traverse from kernel space. The down
side is of course that all your userspace needs to be compiled with
frame pointers enabled and inlined functions, as you noticed, are
'lost'.

There has been talk to attempt to utilize the ELF EH frames which are
mandatory in the x86_64 ABI (even for C) to attempt a kernel based
'DWARF' unwind, but nobody has put forward working code for this yet.
Also, even if the EH stuff is mapped at runtime, it doesn't mean the
pages will actually be loaded (due to demand paging) and available for
use, which also will limit usability. (perf sampling is using
interrupt/NMI context and we cannot page from that, so we're limited to
memory that's present.)
