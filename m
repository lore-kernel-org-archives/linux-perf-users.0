From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: Re: perf probe an addr without debuginfo
Date: Tue, 30 Jun 2015 17:51:48 +0900
Message-ID: <559258A4.2020205@hitachi.com>
References: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com> <20150628154651.GA3953@localhost> <20150629150038.GA1225@kernel.org> <20150630064457.GA20873@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42]:45500 "EHLO
	mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbF3Ivy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Jun 2015 04:51:54 -0400
In-Reply-To: <20150630064457.GA20873@localhost>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin King <benjaminking@web.de>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, cti.systems-productivity-manager.ts@hitachi.com

On 2015/06/30 15:44, Benjamin King wrote:
> On Mon, Jun 29, 2015 at 12:00:38PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Sun, Jun 28, 2015 at 05:46:51PM +0200, Benjamin King escreveu:
>>>> Is there a trick to getting perf to probe a user-level address without
>>>> debuginfo? Eg (on Linux 4.0):
>>>> [...]
>>>> I can do this using ftrace ok, eg, "p:tick_0x583 /root/tick:0x583"
>>>> works. Thanks,
>>>
>>> Not quite what you have asked for, but you can add the probe via ftrace and
>>> then use it from perf. Probes from /sys/kernel/debug/tracing/uprobe_events
>>> will show up in 'perf list' as well.
>>
>> Masami,
>>
>> 	Is this already possible?
> 
> Hi Arnaldo,
> 
> for me this works in 3.19.0. I'm using the attached script to help me add
> probes to /sys/kernel/debug/tracing/uprobe_events which I can then see with
> 'sudo perf list' and use from the other perf subcommands. Tracing arguments is
> also working fine:

Yeah, perf probe should be able to do the same thing without debuginfo.
If not, there must be a bug. :(

> 
> --- snip ---
> $ uprobe /lib/x86_64-linux-gnu/libc.so.6 malloc %di
> $ sudo perf stat  -e uprobes:* ls
> ...
>  Performance counter stats for 'ls':
> ...
>                218      uprobes:malloc_1                                            
> $ sudo perf record -euprobes:malloc_1 ls >/dev/null 2>&1
> $ sudo perf script
>               ls 21084 [003] 10825.526815: uprobes:malloc_1: (7f772bfc2700) arg1=0x238
>               ls 21084 [003] 10825.526917: uprobes:malloc_1: (7f772bfc2700) arg1=0x238
>               ls 21084 [003] 10825.526968: uprobes:malloc_1: (7f772bfc2700) arg1=0x78
>               ls 21084 [003] 10825.527089: uprobes:malloc_1: (7f772bfc2700) arg1=0x5
>               ls 21084 [003] 10825.527132: uprobes:malloc_1: (7f772bfc2700) arg1=0x78
> ...
> --- snip ---
> 
> This is superuseful to me, so thank you all for working on perf!
> 
> I failed to manage placing proper probes in C++-Code with perf probe, so I
> hacked the script together after reading Brendans ftrace article on LWN.

Hmm, that must be a bug, so it should be fixed.

Thank you!



-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
