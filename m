From: Milian Wolff <mail@milianw.de>
Subject: Re: perf trace: file names, strace groups
Date: Wed, 15 Jul 2015 17:41:53 +0200
Message-ID: <239503894.ASNylTKZCF@milian-kdab2>
References: <2853551.Qtj9hFrTSc@milian-kdab2> <20150715145309.GD3868@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:51675 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbGOPl4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jul 2015 11:41:56 -0400
In-Reply-To: <20150715145309.GD3868@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Perf Users <linux-perf-users@vger.kernel.org>, David Ahern <dsahern@gmail.com>

On Wednesday 15 July 2015 11:53:09 Arnaldo Carvalho de Melo wrote:
> Executive summary:
> 
> . Check the latest sources, i.e. 4.2-rc

I could also try to compile perf from git, if you tell me what branch and 
remote I should use.

> . Some of the stuff you report was implemented or fixed already
> 
> . Details about some of the limitations and advantages of 'perf trace' below
> 
> . Including an auto-tracing that will fix one of the problems you reported

Nice, thanks for that!

<snip>

> [acme@zoo ~]$ trace -e file cat file
> Error:	Invalid syscall file
> Hint:	try 'perf list syscalls:sys_enter_*'
> Hint:	and: 'man syscalls'

Just to be clear: Supporting the strace groups as a collection of syscalls 
will be implemented? Or is that not possible, as it goes straight down to the 
perf event subsystem which does not know this group?

<snip>

> Ok, that was good, using trace to trace trace and fix it, after lunch I'll
> give it a try.

Cool, so you'll add that internally such that the hoops are not necessary on 
the user side to get the filename? Excellent! I also notice that 
close/read/write and others /sometimes/ write out the filename:

    10.404 ( 0.001 ms): kmimetypefinde/8217 read(fd: 6</etc/localtime>, buf: 
0x7ffe2b6d1319, count: 15671         ) = 0

    10.529 ( 0.004 ms): kmimetypefinde/8494 read(fd: 6, buf: 0x7ffc61c45b40, 
count: 8192                          ) = 4

This is also pretty odd.

<snip>

> > O_RDONLY flag is not properly handled (compare to the strace output
> > above).
> 
> It is zero, right? yeap:
> 
> #define O_RDONLY        00000000
> 
> syscall arguments with a zero payload are removed trying to make the output
> more compact, and also for cases where some of the args are optional, to
> reduce the logic needed to know when things are optional, just don't print
> zeroes.
> 
> This shortcut has issues, as in this case, where an exception seems to be
> needed, i.e. we should print O_RDONLY, d'accord?

Yes, that would be good to have here, I guess. In general, the closer the 
output gets to `strace`, the better.

> > I'd love to see someone working on this gem, as it really promises to be a
> > good replacement for strace.
> 
> Well, you're doing some work, getting some discussion going, I can code some
> more if someone like you tests it and tries to use it in your use cases.
> 
> Bonus points go to whoever follows these discussions and writes some
> documentation or blogs about it ;-)
> 
> Ok, now to juggle this with the eBPF enablement of perf... I can see
> some synergies, like: please, trace network traffic to host foo.bar,
> please... :-)

Sounds cool :)
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
