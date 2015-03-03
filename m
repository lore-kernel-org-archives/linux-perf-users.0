From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: address output in 'perf script' does not work for addr2line
Date: Tue, 3 Mar 2015 13:23:22 -0300
Message-ID: <20150303162322.GK5187@kernel.org>
References: <CAJh9x3pz1aLQP_vvfN_Y_BwF4ekcU1mqvZFJz7x7X6QqLkK1jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58342 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbbCCQXZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Mar 2015 11:23:25 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9BC7320375
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2015 16:23:24 +0000 (UTC)
Received: from zoo.ghostprotocols.net (unknown [191.184.42.27])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A774E20364
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2015 16:23:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJh9x3pz1aLQP_vvfN_Y_BwF4ekcU1mqvZFJz7x7X6QqLkK1jg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yuanfang Chen <cyfmxc@gmail.com>
Cc: linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>

Em Tue, Mar 03, 2015 at 11:07:18AM -0500, Yuanfang Chen escreveu:
> I'm using perf 3.19.0 on Archlinux
> 
> [arch@t440s-arch ~/Trash]$ uname -a
> Linux t440s-arch 3.18.6-1-ARCH #1 SMP PREEMPT Sat Feb 7 08:44:05 CET
> 2015 x86_64 GNU/Linux
> 
> Recently after updating perf package, I found the 'ip' in 'perf
> script' like below is shorter than before. Also feeding that address
> (like 57e below) to addr2line does not output filename:lineno
> information anymore.  How do I fix this issue? Is this a bug?

Yeah, I tried using it with addr2line and it didn't work :-\ So what
you're saying is that in the past it worked like that?

If so, could you please 'git bisect' it to find out when it got broken?

I would argue that it would be even better if it resolved to file:lineno
by default...

- Arnaldo
 
> a.out 26620 [000] 314643.350007:    6825289 cycles:
>                      57e main (/home/arch/Trash/a.out)
>                    20800 __libc_start_main (/usr/lib/libc-2.21.so)
>         13d6258d4c544155 [unknown] ([unknown])
> 
> thank you,
> Yuanfang
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
