From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf trace report with time consumed
Date: Sun, 3 Apr 2016 18:30:17 +0200
Message-ID: <20160403163017.GA27953@krava.local>
References: <1894563.GPSC8z33rH@agathebauer>
 <4785655.UdtHu7qvlx@agathebauer>
 <20160330215832.GG3420@kernel.org>
 <11979280.sfXiZ5YTfG@agathebauer>
 <20160401130140.GA7115@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35423 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbcDCQaY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 3 Apr 2016 12:30:24 -0400
Content-Disposition: inline
In-Reply-To: <20160401130140.GA7115@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@kernel.org>, perf group <linux-perf-users@vger.kernel.org>

On Fri, Apr 01, 2016 at 10:01:40AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Apr 01, 2016 at 12:34:44AM +0200, Milian Wolff escreveu:
> > Nice, so the frame point unwinding seems to work already. But I'm a user-space 
> > person and none of my tools have that. So let's try dwarf:
> 
> > ~~~~~~~~~~~~~~~~~
> > perf trace -e nanosleep --call-graph dwarf path/to/ex_sleep
> > perf: Segmentation fault

hum, I need some special change to run this?

is there command related to latest Arnaldo's perf/core
that reproduces the issue?

thanks,
jirka

> > Obtained 10 stack frames.
> > perf(sighandler_dump_stack+0x4f) [0x5637fdcfc85f]
> > /usr/lib/libc.so.6(+0x3332f) [0x7fe888b2132f]
> > /usr/lib/libc.so.6(__vsnprintf_chk+0x6b) [0x7fe888be38db]
> > perf(+0xb3f93) [0x5637fdc56f93]
> > perf(+0xb8fec) [0x5637fdc5bfec]
> > perf(cmd_trace+0x1c14) [0x5637fdc5e5c4]
> > perf(+0xe6bae) [0x5637fdc89bae]
> > perf(main+0x6e3) [0x5637fdc23a83]
> > /usr/lib/libc.so.6(__libc_start_main+0xef) [0x7fe888b0e70f]
> > perf(_start+0x28) [0x5637fdc23bc8]
> > Segmentation fault (core dumped)
> > ~~~~~~~~~~~~~~~~~
>  
> > Ouch :( Valgrind gives me:
>  
> > ~~~~~~~~~~~~~~~~~
> > ==8053== Syscall param msync(start) points to uninitialised byte(s)
> > ==8053==    at 0x528A700: __msync_nocancel (in /usr/lib/libpthread-2.23.so)
> > ==8053==    by 0x4E396D6: validate_mem (Ginit.c:137)
> > ==8053==    by 0x4E396D6: access_mem (Ginit.c:171)
> > ==8053==    by 0x4E3F79D: dwarf_get (libunwind_i.h:168)
> > ==8053==    by 0x4E3F79D: apply_reg_state (Gparser.c:819)
> > ==8053==    by 0x4E3EE72: _ULx86_64_dwarf_find_save_locs (Gparser.c:907)
> > ==8053==    by 0x4E4126A: _ULx86_64_dwarf_step (Gstep.c:34)
> > ==8053==    by 0x4E3A873: _ULx86_64_step (Gstep.c:71)
> > ==8053==    by 0x4E3B9CF: trace_init_addr (Gtrace.c:248)
> > ==8053==    by 0x4E3B9CF: trace_lookup (Gtrace.c:330)
> > ==8053==    by 0x4E3B9CF: _ULx86_64_tdep_trace (Gtrace.c:447)
> > ==8053==    by 0x4E38C8F: backtrace (backtrace.c:69)
> > ==8053==    by 0x26185F: dump_stack (util.c:338)
> > ==8053==    by 0x26185F: sighandler_dump_stack (util.c:356)
> > ==8053==    by 0x69B232F: ??? (in /usr/lib/libc-2.23.so)
> > ==8053==    by 0x6A748DA: __vsnprintf_chk (in /usr/lib/libc-2.23.so)
> > ==8053==    by 0x1BBF93: vsnprintf (stdio2.h:77)
> > ==8053==    by 0x1BBF93: scnprintf (kernel.h:91)
> > ==8053==  Address 0xffeffa000 is on thread 1's stack
> > ==8053==  in frame #7, created by backtrace (backtrace.c:59)
> > ~~~~~~~~~~~~~~~~
>  
> > Any idea what I'm missing in the setup routine? It works fine for `perf trace 
> > record --call-graph dwarf`.
> 
> Jiri?
> 
> I have to investigate this, I cooked up a patch almost the same as
> yours, only using the top callchain OPT_ stuff because it also sets
> those symbol_conf globals, but ended up having trouble with libunwind
> :-\
> 
> BTW: Those callchain related globals have to go, finally, because I want
> to be able to enable callchain collection/reporting per event, i.e.
> output that shows callchains for some 'perf probe' events while not for
> all syscalls except for futex(), etc.
> 
> - Arnaldo
