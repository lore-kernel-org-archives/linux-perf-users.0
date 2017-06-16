From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: perf report: fix off-by-one for non-activation frames
Date: Fri, 16 Jun 2017 13:51:37 +0200
Message-ID: <5576772.scvU8aRrkq@agathebauer>
References: <20170515150444.6841-1-milian.wolff@kdab.com> <20170616061456.GA2472@host1.jankratochvil.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:43994 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752610AbdFPLvk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2017 07:51:40 -0400
In-Reply-To: <20170616061456.GA2472@host1.jankratochvil.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jan Kratochvil <jan.kratochvil@redhat.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>

On Freitag, 16. Juni 2017 08:14:56 CEST Jan Kratochvil wrote:
> On Mon, 15 May 2017 17:04:44 +0200, Milian Wolff wrote:
> 
> commit 1982ad48fc82c284a5cc55697a012d3357e84d01
> Author: Milian Wolff <milian.wolff@kdab.com>
> Date:   Wed May 24 15:21:25 2017 +0900
> 
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -168,12 +168,16 @@ frame_callback(Dwfl_Frame *state, void *arg)
> 
> ...
> 
> > +	if (!isactivation)
> > +		--pc;
> > +
> 
> FYI I find it as a regression a bit:
> 
> perf-4.11.4-200.fc25.x86_64
>                   30c563 gdb_main (/usr/libexec/gdb)
>                    fae48 main (/usr/libexec/gdb)
>    0x000055555564ee43 <+51>:    callq  0x55555585f340
> <gdb_main(captured_main_args*)> 0x000055555564ee48 <+56>:    mov   
> 0x18(%rsp),%rcx
> 
> perf-4.12.0-0.rc5.git0.1.fc27.x86_64
>                   39e32e gdb_main (/usr/libexec/gdb)
>                   10b6fa main (/usr/libexec/gdb)
>    0x000055555565f6f6 <+54>:    callq  0x5555558f17a0
> <gdb_main(captured_main_args*)> 0x000055555565f6fb <+59>:    mov   
> 0x18(%rsp),%rcx
> 
> In backtraces it is correct to show the source line of the calling line - as
> perf does now after your fix - but one still should report PC address of
> the start of the next instruction.  At least this is what debuggers are
> used to do:
> 
> #9  gdb_main (args=0x7fffffffe2e0) at ../../gdb/main.c:1257
> #10 0x000055555565f6fb in main (argc=<optimized out>, argv=<optimized out>)
> at ../../gdb/gdb.c:40 0x000055555565f6f6 <+54>:	callq  0x5555558f17a0
> <gdb_main(captured_main_args*)> => 0x000055555565f6fb <+59>:	mov   
> 0x18(%rsp),%rcx
> Line 40 of "../../gdb/gdb.c" starts at address 0x55555565f6f6 <main(int,
> char**)+54> and ends at 0x55555565f6fb <main(int, char**)+59>. Line 41 of
> "../../gdb/gdb.c" starts at address 0x55555565f6fb <main(int, char**)+59>
> and ends at 0x55555565f715.
> 
> You see "gdb.c:40" and 0x000055555565f6fb in the backtrace despite
> 0x55555565f6fb is already line 41.
> 
> This is also why elfutils reports separately PC and 'isactivation' flag.
> Instead of just reporting decreased PC.

Excuse me, but I'm having trouble following you. The non-GDB backtraces you 
are pasting do not show srcline information. So what exactly is broken? Can 
you show me the differences a bit more clearly? Maybe paste the perf output 
you get now and highlight what you'd expect instead? Best would be an 
accompanying test case that I can use to improve the situation, if possible?

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
