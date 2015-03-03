From: David Ahern <dsahern@gmail.com>
Subject: Re: address output in 'perf script' does not work for addr2line
Date: Tue, 03 Mar 2015 12:54:26 -0700
Message-ID: <54F61172.4050002@gmail.com>
References: <CAJh9x3pz1aLQP_vvfN_Y_BwF4ekcU1mqvZFJz7x7X6QqLkK1jg@mail.gmail.com>	<20150303162322.GK5187@kernel.org> <CAJh9x3rwvAdjXJ67wvNjWjy451zWy1a_7JjDKQacJkwWWL031A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:44065 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbbCCTy2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Mar 2015 14:54:28 -0500
Received: by igdh15 with SMTP id h15so31127733igd.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2015 11:54:27 -0800 (PST)
In-Reply-To: <CAJh9x3rwvAdjXJ67wvNjWjy451zWy1a_7JjDKQacJkwWWL031A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yuanfang Chen <cyfmxc@gmail.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

On 3/3/15 12:27 PM, Yuanfang Chen wrote:
> On Tue, Mar 3, 2015 at 11:23 AM, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
>> Em Tue, Mar 03, 2015 at 11:07:18AM -0500, Yuanfang Chen escreveu:
>>> I'm using perf 3.19.0 on Archlinux
>>>
>>> [arch@t440s-arch ~/Trash]$ uname -a
>>> Linux t440s-arch 3.18.6-1-ARCH #1 SMP PREEMPT Sat Feb 7 08:44:05 CET
>>> 2015 x86_64 GNU/Linux
>>>
>>> Recently after updating perf package, I found the 'ip' in 'perf
>>> script' like below is shorter than before. Also feeding that address
>>> (like 57e below) to addr2line does not output filename:lineno
>>> information anymore.  How do I fix this issue? Is this a bug?
>>
>> Yeah, I tried using it with addr2line and it didn't work :-\ So what
>> you're saying is that in the past it worked like that?
>>
>> If so, could you please 'git bisect' it to find out when it got broken?
>
> Yeah, it worked in the past.
> commit 5550171b2a9f8df26ff483051d060db06376b26d  change ip into
> relative address ( not sure relative to which address), which makes
> addr2line unable to parse.
>

That's Andi's commit.
