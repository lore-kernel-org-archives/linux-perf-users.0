From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 16:31:52 -0300
Message-ID: <20140918193152.GL2770@kernel.org>
References: <2221771.b2oSN5LR6X@milian-kdab2>
 <2297882.Vc1x1zOfA6@milian-kdab2>
 <20140918155745.GH2770@kernel.org>
 <45528931.El8SOGvs6Z@milian-kdab2>
 <20140918191713.GK2770@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47108 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756244AbaIRTb5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 15:31:57 -0400
Content-Disposition: inline
In-Reply-To: <20140918191713.GK2770@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

Em Thu, Sep 18, 2014 at 04:17:13PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Sep 18, 2014 at 06:37:47PM +0200, Milian Wolff escreveu:
> > This was also why I asked my initial question, which I want to repeat once 
> > more: Is there a technical reason to not offer a "timer" software event to 
> > perf? I'm a complete layman when it comes to Kernel internals, but from a user 
> > point of view this would be awesome:
>  
> > perf record --call-graph dwarf -e sw-timer -F 100 someapplication
>  
> > This command would then create a timer in the kernel with a 100Hz frequency. 
> > Whenever it fires, the callgraphs of all threads in $someapplication are 
> > sampled and written to perf.data. Is this technically not feasible? Or is it 
> > simply not implemented?

What you want is a sysrq-t that goes all the way to userspace, right?

Try:

echo t > /proc/sysrq
dmesg

i.e. probably you want that when a thread goes to sleep, we can take a
sample with callchains, no?

With a 'ping 127.0.0.1' running, I get this for its process:

[19255.244315] ping            S ffff88043e213100     0  6754   6548 0x00000080
[19255.244316]  ffff880231693a80 0000000000000082 ffff88040ffb1940 0000000000013100
[19255.244317]  ffff880231693fd8 0000000000013100 ffff880423c88000 ffff88040ffb1940
[19255.244318]  ffffffff81efb1c0 ffff880231693ab0 00000001012131d1 ffffffff81efb1c0
[19255.244319] Call Trace:
[19255.244321]  [<ffffffff816b93a9>] schedule+0x29/0x70
[19255.244322]  [<ffffffff816bbf91>] schedule_timeout+0x151/0x270
[19255.244325]  [<ffffffff815ac606>] __skb_recv_datagram+0x426/0x4d0
[19255.244328]  [<ffffffff815ac6e2>] skb_recv_datagram+0x32/0x40
[19255.244330]  [<ffffffff8161a1ad>] raw_recvmsg+0x7d/0x1b0
[19255.244331]  [<ffffffff8162961c>] inet_recvmsg+0x6c/0x80
[19255.244333]  [<ffffffff8159d42a>] sock_recvmsg+0x9a/0xd0
[19255.244345]  [<ffffffff8159e1a2>] __sys_recvmsg+0x42/0x80
[19255.244346]  [<ffffffff8159e1f2>] SyS_recvmsg+0x12/0x20
[19255.244348]  [<ffffffff816bd412>] system_call_fastpath+0x16/0x1b

No? Trying to collect dwarf callchains after installing iputils-debuginfo (where /bin/ping
symtab is)...
 
> > I'm experimenting with a libunwind based profiler, and with some ugly signal 
> > hackery I can now grab backtraces by sending my application SIGUSR1. Based on 
> 
> Humm, can't you do the same thing with perf? I.e. you send SIGUSR1 to
> your app with the frequency you want, and then hook a 'perf probe' into
> your signal... /me tries some stuff, will get back with results...
> 
> > that, I can probably create a profiling tool that fits my needs. I just wonder 
> > why one cannot do the same with perf.
> 
> - Arnaldo
