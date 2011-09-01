From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH] perf tool: fix endianness handling of u32 data in samples
Date: Thu, 01 Sep 2011 10:41:58 -0600
Message-ID: <4E5FB5D6.1080209@gmail.com>
References: <1314654924-13071-1-git-send-email-dsahern@gmail.com> <20110901161900.GB15984@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46577 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757763Ab1IAQmE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 1 Sep 2011 12:42:04 -0400
In-Reply-To: <20110901161900.GB15984@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de, anton@samba.org



On 09/01/2011 10:19 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 29, 2011 at 03:55:24PM -0600, David Ahern escreveu:
>> Currently, analyzing PPC data files on x86 the cpu field is always 0=
 and
>> the tid and pid are backwards. For example, analyzing a PPC file on =
PPC
>> the pid/tid fields show:
>>         rsyslogd  1210/1212
>>
>> and analyzing the same PPC file using an x86 perf binary shows:
>>         rsyslogd  1212/1210
>>
>> The problem is that the swap_op method for samples is
>> perf_event__all64_swap which assumes all elements in the sample_data
>> struct are u64s. cpu, tid and pid are u32s and need to be handled
>> individually. Given that the swap is done before the sample is parse=
d,
>> the simplest solution is to undo the 64-bit swap of those elements w=
hen
>> the sample is parsed and do the proper swap.
>>
>> The RAW data field is generic and perf cannot have programmatic know=
ledge
>> of how to treat that data. Instead a warning is given to the user.
>>
>> Thanks to Anton Blanchard for providing a data file for a mult-CPU
>> PPC system so I could verify the fix for the CPU fields.
>>
>> Signed-off-by: David Ahern <dsahern@gmail.com>
>=20
> cc1: warnings being treated as errors
> util/evsel.c: In function =E2=80=98perf_event__parse_sample=E2=80=99:
> util/evsel.c:379: error: dereferencing pointer =E2=80=98p=E2=80=99 do=
es break strict-aliasing rules
> util/evsel.c:375: error: dereferencing pointer =E2=80=98p=E2=80=99 do=
es break strict-aliasing rules
> util/evsel.c:375: error: dereferencing pointer =E2=80=98p=E2=80=99 do=
es break strict-aliasing rules
> util/evsel.c:371: note: initialized from here
> util/evsel.c:376: error: dereferencing pointer =E2=80=98({anonymous})=
=E2=80=99 does break strict-aliasing rules
> util/evsel.c:376: error: dereferencing pointer =E2=80=98({anonymous})=
=E2=80=99 does break strict-aliasing rules
> util/evsel.c:376: note: initialized from here
> util/evsel.c:380: error: dereferencing pointer =E2=80=98({anonymous})=
=E2=80=99 does break strict-aliasing rules
> util/evsel.c:380: note: initialized from here
> util/evsel.c:414: error: dereferencing pointer =E2=80=98p=E2=80=99 do=
es break strict-aliasing rules
> util/evsel.c:412: error: dereferencing pointer =E2=80=98p=E2=80=99 do=
es break strict-aliasing rules
> util/evsel.c:408: note: initialized from here
> util/evsel.c:462: error: dereferencing pointer =E2=80=98p=E2=80=99 do=
es break strict-aliasing rules
> util/evsel.c:450: error: dereferencing pointer =E2=80=98p=E2=80=99 do=
es break strict-aliasing rules
> util/evsel.c:450: error: dereferencing pointer =E2=80=98p=E2=80=99 do=
es break strict-aliasing rules
> util/evsel.c:444: note: initialized from here
> util/evsel.c:451: error: dereferencing pointer =E2=80=98({anonymous})=
=E2=80=99 does break strict-aliasing rules
> util/evsel.c:451: error: dereferencing pointer =E2=80=98({anonymous})=
=E2=80=99 does break strict-aliasing rules
> util/evsel.c:451: note: initialized from here

That's no good. It compiles cleanly on Fedora 15-x86 and Fedora 12-ppc.
What version of gcc is this?

David


>     CC /home/acme/git/build/perf//util/symbol.o
> make: *** [/home/acme/git/build/perf//util/evsel.o] Error 1
> make: *** Waiting for unfinished jobs....
> make: Leaving directory `/home/acme/git/linux/tools/perf'
> [acme@emilia linux]$
>=20
> [acme@emilia linux]$ uname -a
> Linux emilia.ghostprotocols.net 3.0.3-rt12.14.el6rt.x86_64 #1 SMP PRE=
EMPT RT Wed Aug 31 12:38:53 BRT 2011 x86_64 x86_64 x86_64 GNU/Linux
> [acme@emilia linux]$ cat /etc/redhat-release=20
> Red Hat Enterprise Linux release 6.0 Beta (Santiago)
> [acme@emilia linux]$
>=20
> - Arnaldo
