From: Yuanfang Chen <cyfmxc@gmail.com>
Subject: Re: address output in 'perf script' does not work for addr2line
Date: Tue, 3 Mar 2015 14:27:46 -0500
Message-ID: <CAJh9x3rwvAdjXJ67wvNjWjy451zWy1a_7JjDKQacJkwWWL031A@mail.gmail.com>
References: <CAJh9x3pz1aLQP_vvfN_Y_BwF4ekcU1mqvZFJz7x7X6QqLkK1jg@mail.gmail.com>
	<20150303162322.GK5187@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:42472 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040AbbCCT1r (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Mar 2015 14:27:47 -0500
Received: by wggz12 with SMTP id z12so4956211wgg.9
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2015 11:27:46 -0800 (PST)
In-Reply-To: <20150303162322.GK5187@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>

On Tue, Mar 3, 2015 at 11:23 AM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Tue, Mar 03, 2015 at 11:07:18AM -0500, Yuanfang Chen escreveu:
>> I'm using perf 3.19.0 on Archlinux
>>
>> [arch@t440s-arch ~/Trash]$ uname -a
>> Linux t440s-arch 3.18.6-1-ARCH #1 SMP PREEMPT Sat Feb 7 08:44:05 CET
>> 2015 x86_64 GNU/Linux
>>
>> Recently after updating perf package, I found the 'ip' in 'perf
>> script' like below is shorter than before. Also feeding that address
>> (like 57e below) to addr2line does not output filename:lineno
>> information anymore.  How do I fix this issue? Is this a bug?
>
> Yeah, I tried using it with addr2line and it didn't work :-\ So what
> you're saying is that in the past it worked like that?
>
> If so, could you please 'git bisect' it to find out when it got broken?

Yeah, it worked in the past.
commit 5550171b2a9f8df26ff483051d060db06376b26d  change ip into
relative address ( not sure relative to which address), which makes
addr2line unable to parse.

> I would argue that it would be even better if it resolved to file:lineno
> by default...

Totally agree.

> - Arnaldo
>
>> a.out 26620 [000] 314643.350007:    6825289 cycles:
>>                      57e main (/home/arch/Trash/a.out)
>>                    20800 __libc_start_main (/usr/lib/libc-2.21.so)
>>         13d6258d4c544155 [unknown] ([unknown])
>>
>> thank you,
>> Yuanfang
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
