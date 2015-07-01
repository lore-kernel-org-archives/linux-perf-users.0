From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: Re: perf probe an addr without debuginfo
Date: Wed, 01 Jul 2015 20:05:58 +0900
Message-ID: <5593C996.6090803@hitachi.com>
References: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com> <20150628154651.GA3953@localhost> <20150629150038.GA1225@kernel.org> <55924725.5010504@hitachi.com> <CAE40pde_keAUGX7S1MN7ekYhM8E5my445nRKDJvYXRTOw-UPnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:52360 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbbGALGH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Jul 2015 07:06:07 -0400
In-Reply-To: <CAE40pde_keAUGX7S1MN7ekYhM8E5my445nRKDJvYXRTOw-UPnQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin King <benjaminking@web.de>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, cti.systems-productivity-manager.ts@hitachi.com

On 2015/07/01 3:40, Brendan Gregg wrote:
> G'Day Masami,
> 
> On Tue, Jun 30, 2015 at 12:37 AM, Masami Hiramatsu
> <masami.hiramatsu.pt@hitachi.com> wrote:
>> On 2015/06/30 0:00, Arnaldo Carvalho de Melo wrote:
>>> Em Sun, Jun 28, 2015 at 05:46:51PM +0200, Benjamin King escreveu:
>>>> Hi Brendan
>>>>
>>>>> Is there a trick to getting perf to probe a user-level address without
>>>>> debuginfo? Eg (on Linux 4.0):
>>>>> [...]
>>>>> I can do this using ftrace ok, eg, "p:tick_0x583 /root/tick:0x583"
>>>>> works. Thanks,
>>>>
>>>> Not quite what you have asked for, but you can add the probe via ftrace and
>>>> then use it from perf. Probes from /sys/kernel/debug/tracing/uprobe_events
>>>> will show up in 'perf list' as well.
>>>
>>> Masami,
>>>
>>>       Is this already possible?
>>
>> Yes, it should be possible. However, I don't recommend you to
>> probe the address inside a function without debuginfo. You must
>> check the instruction boundary in that case.
> 
> Ah, because otherwise I could accidentally trace at a non-zero offsite
> inside an instruction? That probably explains the only failure I saw
> on uprobes on linux 4.0.
> 
> Here's the original use case:
> 
> # readelf -n /root/node/node
> [...]
>   stapsdt              0x00000082 NT_STAPSDT (SystemTap probe descriptors)
>     Provider: node
>     Name: http__client__request
>     Location: 0x0000000000bf48ff, Base: 0x0000000000f22464, Semaphore:
> 0x0000000001243024
>     Arguments: 8@%rax 8@%rdx 8@-136(%rbp) -4@-140(%rbp) 8@-72(%rbp)
> 8@-80(%rbp) -4@-144(%rbp)
> [...]
> 
> These user SDT probes (or "USDT probes") can't currently be traced
> using perf (although Hemant Kumar was working on a patch).

Yes, and I'm working on it.

> I can trace them via ftrace, and have already written a helper script.
> But that's another story. I'm interested in doing this from perf as
> well! (Without needing to create the probes via ftrace.)
> 
> I have their instruction offset above from readelf (and need to
> subtract the base load address). Here's what doesn't work:
> 
> A) Tracing via the absolute address. Eg, "perf probe -x node '@+0x7f48ff'
> 
> B) Tracing via the offset from main. Eg, "perf probe -x node
> 'main+0x...", since perf complains I'm tracing at an offset bigger
> than main.
> 
> C) Tracing via the offset from the function that contains the probe.
> In this case, because the function name is too big! (Due to C++) Eg:
> 
> # ./perf probe -x /root/node/node --filter="*"
> '_ZN4node26DTRACE_HTTP_CLIENT_REQUESTERKN2v820FunctionCallbackInfoINS0_5ValueEEE+0x42f'
> Added new event:
>   Error: Failed to add events.
> 
> I've attached a trivial patch for (C), it just increases the buffer
> size in __add_probe_trace_events() from 64 to 128. It's still a bit of
> a nuisance to resolve the containing function (addr2line) when I have
> the absolute address...

The buffer size will be fixed with strbuf in my series.

https://lkml.org/lkml/2015/5/31/84

Anyway, thank you for reporting it. I'll check why it doesn't work.

Thanks!

> 
> Brendan
> 


-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
