From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf probe an addr without debuginfo
Date: Tue, 30 Jun 2015 11:07:16 -0700
Message-ID: <CAE40pdd3NRDQsPBA0WPgGiGs8RAN4riT6rE9f-9thZdSqJdjyg@mail.gmail.com>
References: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com>
 <20150628154651.GA3953@localhost> <20150629150038.GA1225@kernel.org> <20150630064457.GA20873@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35191 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbbF3SHh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Jun 2015 14:07:37 -0400
Received: by iecuq6 with SMTP id uq6so18179973iec.2
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2015 11:07:36 -0700 (PDT)
In-Reply-To: <20150630064457.GA20873@localhost>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin King <benjaminking@web.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Mon, Jun 29, 2015 at 11:44 PM, Benjamin King <benjaminking@web.de> wrote:
>
> On Mon, Jun 29, 2015 at 12:00:38PM -0300, Arnaldo Carvalho de Melo wrote:
>>
>> Em Sun, Jun 28, 2015 at 05:46:51PM +0200, Benjamin King escreveu:
>>>
>>> >Is there a trick to getting perf to probe a user-level address without
>>> >debuginfo? Eg (on Linux 4.0):
>>> >[...]
>>> >I can do this using ftrace ok, eg, "p:tick_0x583 /root/tick:0x583"
>>> >works. Thanks,
>>>
>>> Not quite what you have asked for, but you can add the probe via ftrace and
>>> then use it from perf. Probes from /sys/kernel/debug/tracing/uprobe_events
>>> will show up in 'perf list' as well.
>>
>>
>> Masami,
>>
>>         Is this already possible?
>
>
> Hi Arnaldo,
>
> for me this works in 3.19.0. I'm using the attached script to help me add
> probes to /sys/kernel/debug/tracing/uprobe_events which I can then see with
> 'sudo perf list' and use from the other perf subcommands. Tracing arguments is
> also working fine:
>
> --- snip ---
> $ uprobe /lib/x86_64-linux-gnu/libc.so.6 malloc %di

Nice - and I'd been thinking along the same lines, that it wouldn't be
hard to write a helper, and published something to do it all from
ftrace: http://www.brendangregg.com/blog/2015-06-28/linux-ftrace-uprobe.html

But I was thinking about doing this from perf as well, or instead.

[...]
>
> I failed to manage placing proper probes in C++-Code with perf probe, so I
> hacked the script together after reading Brendans ftrace article on LWN.
>
> Cheers,
>  Benjamin
