From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf lock usage
Date: Tue, 28 Jan 2014 10:35:42 +0100
Message-ID: <20140128093542.GD1229@krava.brq.redhat.com>
References: <21216.48020.60857.22056@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23918 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754917AbaA1Jfv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 28 Jan 2014 04:35:51 -0500
Content-Disposition: inline
In-Reply-To: <21216.48020.60857.22056@gargle.gargle.HOWL>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Sujith Manoharan <sujith@msujith.org>
Cc: linux-perf-users@vger.kernel.org

On Thu, Jan 23, 2014 at 12:19:56PM +0530, Sujith Manoharan wrote:
> Hi,
> 
> I am trying to use perf lock and am not sure if
> the results are correct (the bad rate is 98 %).
> 
> Is this expected behavior ?

some of the kernel lock types do not follow the:
  acquire
  contended
  acuired
  release

lock state machine, like rcu or spin locks.. and thats what
caused most of the bad rates in my tests.

I was recently working on some changes for lock tracing,
what stats are you interested in?

jirka

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
> 
> Sujith
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
