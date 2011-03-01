From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 4/6] perf script: dump software events too
Date: Tue, 1 Mar 2011 17:24:44 +0100
Message-ID: <AANLkTin_ShM+OA3QPxJ1Tc-EGf6enHg-d84Cdpg00=Op@mail.gmail.com>
References: <1298865151-23656-1-git-send-email-daahern@cisco.com>
	<1298865151-23656-5-git-send-email-daahern@cisco.com>
	<AANLkTikwsuBGVfB6uu7=H0jbL+2YbbvX=ea6rLwNP8w-@mail.gmail.com>
	<4D6D004F.5010602@cisco.com>
	<AANLkTi=jmS80Rs13QiTmdA5iUXvNaSKxQ9Gpp2P2nqRU@mail.gmail.com>
	<4D6D1AA8.4060809@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37026 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab1CAQ2k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Mar 2011 11:28:40 -0500
In-Reply-To: <4D6D1AA8.4060809@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de

2011/3/1 David Ahern <daahern@cisco.com>:
>
>
> On 03/01/2011 08:11 AM, Frederic Weisbecker wrote:
>>
>> Why shouldn't it be designed to dump software events? It's called pr=
int_event().
>> Its current version is rather something I would call "limited". But =
it
>> was not designed
>> to be limited.
>
> That's because its origins are trace specific. Per last week's thread=
,
> perf-script was perf-trace until Nov 2010. perf-script deals with
> tracepoints.

Right it has been first created to support tracing events. Now why
should it stay limited to them?

>> Ideally, we should have print_tracepoint_event() in
>> trace-event-parse.c, print_software_event()
>> where you want, and have print_event() in builtin-script.c that wrap=
s on those.
>
>
> process_event does not take the event sample, it takes elements of it=
:
>
> struct scripting_ops {
> ...
> =A0 =A0void (*process_event) (int cpu, void *data, int size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long long nsecs, char *c=
omm);
> ...
> };

What is the problem with changing a function prototype?
