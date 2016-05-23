From: Andi Kleen <andi@firstfloor.org>
Subject: Re: usability issues with inlining and backtraces
Date: Mon, 23 May 2016 07:59:54 -0700
Message-ID: <871t4s251x.fsf@tassilo.jf.intel.com>
References: <3421510.JYGX19gbWH@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9037 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755701AbcEWPAB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 May 2016 11:00:01 -0400
In-Reply-To: <3421510.JYGX19gbWH@milian-kdab2> (Milian Wolff's message of
	"Mon, 23 May 2016 11:10:00 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:
> Here, the cost of inlined functions (random.tcc:3332,random.h:143) is 
> attributed to the main function. This is of course correct, but very unhelpful 
> to me as a programmer. I'm much more interested in the line inside test.cpp 
> which triggered the call to random.tcc:3332 etc. Is there a way to get that 
> data? Note how you can a way better backtrace when using GDB on the same 
> binary as above:

Yes this works using --call-graph ...,address

If you use srcfile it can resolve inlines. it is currently not supported
for other backtraces, but yes expanding them in the normal history
would be useful.

> On one hand, we have the same issue as above, namely inlined functions being 
> attributed directly to the parent function. See how the backtrace shows main 
> calling hypot? Look at the source, I'm not calling hypot anywhere - it's 
> std::norm calling it internally eventually. And GDB does know about that and 
> can give me a proper backtrace.

Use srcfile then.

>
> But, differently to above, the major gripe I have with this output is 
> exemplified by this part:
>
> ~~~~~~~~~
>      3.63%  [.] __hypot_finite         __hypot_finite+257
>             |
>             ---hypot
>                main
>                __libc_start_main
>                _start
> ~~~~~~~~~
>
> I added `srcline` to the report, but the backtrace still only contains the 
> symbol name. I hope, that we can simply honor srcline there as well, to at 
> least print something like this instead:

--call-graph ....,address

(or --branch-history)

> ########## symbol cost aggregation
>
> Once we have that implemented, can we maybe account for the following: I told 
> `perf report` to aggregate by symbol first, then srcline, i.e. `-s 
> sym,srcline`. But the report seems to aggregate by `srcline`, because I see 
> some symbols (__hypot_finite) multiple times, for different code points. Can 
> we merge those and start the backtrace then at the different code points? 
> Something like this would be my desirable output:

perf sorts by address, but the compiler can generate the same symbol
in multiple versions or in may inlines instances. That's probably
more work to fix.

> As such, I propose a "simplified" `perf annotate` output, which gets closer to 
> what you'll see in other profilers, e.g. VTune or also Microsoft Visual 
> studio's sampling profilers: Use the source files and annotate those with 
> inclusive cost. Only show the cost of individual binary instructions (status 
> quo) when explicitly asked. I.e. I want the output to look something like that 
> (I made up the actual percentages):

Sounds like the fallacy of abstracted performance analysis.

-Andi
