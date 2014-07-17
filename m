From: David Ahern <dsahern@gmail.com>
Subject: Re: kprobe string
Date: Wed, 16 Jul 2014 22:41:02 -0600
Message-ID: <53C753DE.6080306@gmail.com>
References: <CAE40pdfJpksb-LJghF+w4XZBagKo7wg6fh3irGPha5F9Uknb=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58479 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaGQElF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Jul 2014 00:41:05 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so2583304pad.39
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2014 21:41:04 -0700 (PDT)
In-Reply-To: <CAE40pdfJpksb-LJghF+w4XZBagKo7wg6fh3irGPha5F9Uknb=A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>



On 07/16/2014 06:51 PM, Brendan Gregg wrote:
> G'Day,
>
> I'm not sure where else to ask this; I don't think this functionality
> is in perf_events yet...
>
> kprobes is supposed to be able to handle string arguments, but I've
> not been able to find a single working example. I'm trying (on 3.16):
>
> # cd /sys/kernel/debug/tracing
> # echo 'r:getname getname $retval:string' > kprobe_events
> -bash: echo: write error: Invalid argument
> # echo 'p:myprobe do_sys_open %dx:string' > kprobe_events
> -bash: echo: write error: Invalid argument
>
> I'm following the syntax in Documentation/trace/kprobetrace.txt by
> Masami Hiramatsu, and it is recognizing "string". But I'm getting
> these errors:
>
> # dmesg | tail -4
> [98021.813560] string type has no corresponding fetch method.
> [98021.813564] Parse error at argument[0]. (-22)
> [98705.956199] string type has no corresponding fetch method.
> [98705.956203] Parse error at argument[0]. (-22)
>
> Anyone seen this work? I'm checking the source... Thanks in advance,

Have you seen this:
https://lkml.org/lkml/2014/6/19/698

David
