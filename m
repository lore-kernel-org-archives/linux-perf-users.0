From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: perf lock usage
Date: Thu, 23 Jan 2014 13:36:39 +0100
Message-ID: <CAFTL4hzowjuj0E8X8trCz19iq5o-BAjj_JPe86XRnS6E8xs1VQ@mail.gmail.com>
References: <21216.48020.60857.22056@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36692 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbaAWMgk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 23 Jan 2014 07:36:40 -0500
Received: by mail-lb0-f176.google.com with SMTP id w7so1385246lbi.35
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2014 04:36:39 -0800 (PST)
In-Reply-To: <21216.48020.60857.22056@gargle.gargle.HOWL>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Sujith Manoharan <sujith@msujith.org>
Cc: perf group <linux-perf-users@vger.kernel.org>

2014/1/23 Sujith Manoharan <sujith@msujith.org>:
> Hi,
>
> I am trying to use perf lock and am not sure if
> the results are correct (the bad rate is 98 %).
>
> Is this expected behavior ?
>
> root@linux-test ~# perf --version
> perf version 3.12.0
>
> root@linux-test ~# perf lock record cat /etc/issue
> Arch Linux \r (\l)
>
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.356 MB perf.data (~15533 samples) ]
> root@linux-test ~# perf lock report
>                 Name   acquired  contended total wait (ns)   max wait (ns)   min wait (ns)
>
>         &cpuctx_lock          0          0               0               0               0
>  &sig->cred_guard...          0          0               0               0               0
>
> === output for debug===
>
> bad: 153, total: 155
> bad rate: 98.709677 %
> histogram of events caused bad sequence
>     acquire: 1
>    acquired: 0
>   contended: 0
>     release: 152
>
> I am using the wireless-testing kernel:
> root@linux-test ~# uname -a
> Linux linux-test 3.13.0-wl-debug #197 SMP PREEMPT Tue Jan 21 03:19:43 IST 2014 x86_64 GNU/Linux
>
> lockdep is enabled:
> root@linux-test ~# zgrep -i lockdep /proc/config.gz
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_LOCKDEP=y
> # CONFIG_DEBUG_LOCKDEP is not set
>


Hi Sujith,

You also need CONFIG_LOCK_STAT=y
