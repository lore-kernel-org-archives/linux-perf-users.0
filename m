From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: Re: perf probe an addr without debuginfo
Date: Mon, 6 Jul 2015 16:18:51 -0700
Message-ID: <CAE40pdfVg2eay_1XG9YKhUEMFh1-WOwLUGk3R432X=Kct3WqrQ@mail.gmail.com>
References: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com>
 <20150628154651.GA3953@localhost> <20150629150038.GA1225@kernel.org>
 <55924725.5010504@hitachi.com> <CAE40pde_keAUGX7S1MN7ekYhM8E5my445nRKDJvYXRTOw-UPnQ@mail.gmail.com>
 <5593C996.6090803@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37335 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755695AbbGFXTL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 6 Jul 2015 19:19:11 -0400
Received: by igau2 with SMTP id u2so23725838iga.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2015 16:19:10 -0700 (PDT)
In-Reply-To: <5593C996.6090803@hitachi.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin King <benjaminking@web.de>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, cti.systems-productivity-manager.ts@hitachi.com

G'Day Masami-san,

On Wed, Jul 1, 2015 at 4:05 AM, Masami Hiramatsu
<masami.hiramatsu.pt@hitachi.com> wrote:
> On 2015/07/01 3:40, Brendan Gregg wrote:
>> G'Day Masami,
>>
>> On Tue, Jun 30, 2015 at 12:37 AM, Masami Hiramatsu
>> <masami.hiramatsu.pt@hitachi.com> wrote:
>>> On 2015/06/30 0:00, Arnaldo Carvalho de Melo wrote:
>>>> Em Sun, Jun 28, 2015 at 05:46:51PM +0200, Benjamin King escreveu:
>>>>> Hi Brendan
>>>>>
>>>>>> Is there a trick to getting perf to probe a user-level address without
>>>>>> debuginfo? Eg (on Linux 4.0):
>>>>>> [...]
>>>>>> I can do this using ftrace ok, eg, "p:tick_0x583 /root/tick:0x583"
>>>>>> works. Thanks,
>>>>>
>>>>> Not quite what you have asked for, but you can add the probe via ftrace and
>>>>> then use it from perf. Probes from /sys/kernel/debug/tracing/uprobe_events
>>>>> will show up in 'perf list' as well.
>>>>
>>>> Masami,
>>>>
>>>>       Is this already possible?
>>>
>>> Yes, it should be possible. However, I don't recommend you to
>>> probe the address inside a function without debuginfo. You must
>>> check the instruction boundary in that case.
>>
>> Ah, because otherwise I could accidentally trace at a non-zero offsite
>> inside an instruction? That probably explains the only failure I saw
>> on uprobes on linux 4.0.
>>
>> Here's the original use case:
>>
>> # readelf -n /root/node/node
>> [...]
>>   stapsdt              0x00000082 NT_STAPSDT (SystemTap probe descriptors)
>>     Provider: node
>>     Name: http__client__request
>>     Location: 0x0000000000bf48ff, Base: 0x0000000000f22464, Semaphore:
>> 0x0000000001243024
>>     Arguments: 8@%rax 8@%rdx 8@-136(%rbp) -4@-140(%rbp) 8@-72(%rbp)
>> 8@-80(%rbp) -4@-144(%rbp)
>> [...]
>>
>> These user SDT probes (or "USDT probes") can't currently be traced
>> using perf (although Hemant Kumar was working on a patch).
>
> Yes, and I'm working on it.

Oh, can't wait! :)

If it's helpful, I did some USDT hacking with ftrace:
http://www.brendangregg.com/blog/2015-07-03/hacking-linux-usdt-ftrace.html
, although this is really a place-holder until we have a proper
implementation.

Brendan
