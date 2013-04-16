From: David Ahern <dsahern@gmail.com>
Subject: Re: Issue about raw_syscalls!
Date: Tue, 16 Apr 2013 09:53:14 -0700
Message-ID: <516D81FA.7080302@gmail.com>
References: <201304162317193846964@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:53588 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934722Ab3DPQxR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Apr 2013 12:53:17 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so393220pdc.14
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2013 09:53:17 -0700 (PDT)
In-Reply-To: <201304162317193846964@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: OSDepend <osdepend@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On 4/16/13 8:17 AM, OSDepend wrote:
> Hi all,
>
> I recently use perf "-e  raw_syscalls:sys_enter  -e raw_syscalls:sys_exit" to trace all the syscall entry and exit.
> After i perf script the data, I get result like below:
>              perf 10258 [013] 260748.823215: sys_exit: NR 0 = 0
>              perf 10258 [013] 260748.823244: sys_enter: NR 59 (7fffd5b085bf, 7fffd5b0bb10, 12f7030, 3266018240, 65726f632d667265, 2811)
>              perf 10258 [013] 260748.823280: sys_exit: NR 59 = -2
>              perf 10258 [013] 260748.823283: sys_enter: NR 59 (7fffd5b085b9, 7fffd5b0bb10, 12f7030, 3266018240, 6e69622f75706363, 2811)
>           runspec 10258 [019] 260748.823995: sys_exit: NR 59 = 0
>           runspec 10258 [019] 260748.824028: sys_enter: NR 12 (0, 41b590, 0, 64, 7fffa13ff000, 37f)
>           runspec 10258 [019] 260748.824031: sys_exit: NR 12 = 7761920
>           runspec 10258 [019] 260748.824139: sys_enter: NR 9 (0, 1000, 3, 22, ffffffff, 0)
>           runspec 10258 [019] 260748.824147: sys_exit: NR 9 = 140288080863232
>           runspec 10258 [019] 260748.824167: sys_enter: NR 21 (326521cb00, 4, 3265200158, 0, 0, 0)
>           runspec 10258 [019] 260748.824187: sys_exit: NR 21 = -2
>           runspec 10258 [019] 260748.824203: sys_enter: NR 2 (326521b181, 0, 1, 0, fefefefefefefeff, 0)
>           runspec 10258 [019] 260748.824223: sys_exit: NR 2 = 4
>           runspec 10258 [019] 260748.824225: sys_enter: NR 5 (4, 7fffa135d310, 7fffa135d310, 0, fefefefefefefeff, 0)
>           runspec 10258 [019] 260748.824229: sys_exit: NR 5 = 0
>           runspec 10258 [019] 260748.824231: sys_enter: NR 9 (0, c052, 1, 2, 4, 0)
>           runspec 10258 [019] 260748.824245: sys_exit: NR 9 = 140288080809984
>           runspec 10258 [019] 260748.824247: sys_enter: NR 3 (4, c052, 1, 2, 4, 0)
>           runspec 10258 [019] 260748.824249: sys_exit: NR 3 = 0
>
> I guess that the NR # in the end of the line is defined as the systemcall id, but i'm confused about how to match the NR id to the exact systemcall name! Is there any systemcall table or list that I can check the system name accoring to the NR number?

perf-trace uses libaudit to do the conversion. Perhaps something can be 
done for perf-script as well.

David
