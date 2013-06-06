From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Re: What is the difference between the events task-clock and cpu-clock?
Date: Thu, 6 Jun 2013 16:57:46 +0200
Message-ID: <CAGz0_-3+vfirrD2uvtRS70Hj_TDG0+QL_PjpZwGJo5WvS2FpZQ@mail.gmail.com>
References: <CAGz0_-0wg+k4--2CWdMWiVOY-eEmut1Br2Z4ck21b=1jff7rew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailsender1.informatik.tu-muenchen.de ([131.159.0.97]:48052
	"EHLO mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750731Ab3FFO5u (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Jun 2013 10:57:50 -0400
Received: from mail-vb0-f44.google.com (mail-vb0-f44.google.com [209.85.212.44])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail.in.tum.de (Postfix) with ESMTPSA id 811012401E7
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2013 16:57:47 +0200 (CEST)
Received: by mail-vb0-f44.google.com with SMTP id 11so2053944vbf.3
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jun 2013 07:57:46 -0700 (PDT)
In-Reply-To: <CAGz0_-0wg+k4--2CWdMWiVOY-eEmut1Br2Z4ck21b=1jff7rew@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Any ideas?

2013/5/22 Andreas Hollmann <hollmann@in.tum.de>:
> Hi,
>
> what's the difference between the two events task-clock and cpu-clock?
>
> I couldn't find any information that tells me the difference.
>
> Why does the event modifier 'u' has no effect on these two software events?
>
> Cheers,
> Andreas
>
> Here is the example:
>
> $ time perf stat -e
> '{task-clock,task-clock:u,cpu-clock,cpu-clock:u,instructions,instructions:u}'
> dd if=/dev/zero of=/dev/null count=10000000
> 10000000+0 records in
> 10000000+0 records out
> 5120000000 bytes (5.1 GB) copied, 2.99018 s, 1.7 GB/s
>
>  Performance counter stats for 'dd if=/dev/zero of=/dev/null count=10000000':
>
>        2989.907827 task-clock                #    0.999 CPUs utilized
>        2989.907827 task-clock:u              #    0.999 CPUs utilized
>        2989.992015 cpu-clock
>        2989.999305 cpu-clock:u
>     14,525,479,811 instructions              #    0.00  insns per cycle
>      3,130,315,989 instructions:u            #    0.00  insns per cycle
>
>        2.991410383 seconds time elapsed
>
>
> real    0m3.001s
> user    0m0.723s
> sys     0m2.270s
