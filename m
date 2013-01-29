From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Re: Mixed group of sw/hw counters are not started if sw counter is
 group leader
Date: Tue, 29 Jan 2013 14:43:34 +0100
Message-ID: <CAGz0_-2O+7a5Bkeu3vgNFYrsGGYJxrqECKQUJJTwSDQZBktLjw@mail.gmail.com>
References: <CAGz0_-0ti+_3cXQhYUAb_-zKqHBcPVYjFtQ86ZGr8utXF13Rag@mail.gmail.com>
	<20130129123908.GC8339@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailsender1.informatik.tu-muenchen.de ([131.159.0.97]:65002
	"EHLO mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752331Ab3A2Nni (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Jan 2013 08:43:38 -0500
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com [209.85.220.174])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail.in.tum.de (Postfix) with ESMTPSA id 4BFEE24038E
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jan 2013 14:43:36 +0100 (CET)
Received: by mail-vc0-f174.google.com with SMTP id n11so263547vch.19
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Jan 2013 05:43:35 -0800 (PST)
In-Reply-To: <20130129123908.GC8339@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org

> hm, I'm getting following stats when running perf stat in similar scenario:
>
> [jolsa@dhcp-26-214 perf]$ ./perf stat -e '{task-clock,cpu-clock,instructions}' kill
> usage: kill [ -s signal | -p ] [ -a ] pid ...
>        kill -l [ signal ]
>
>  Performance counter stats for 'kill':
>
>           1.039561 task-clock                #    0.479 CPUs utilized
>      <not counted> cpu-clock
>          2,281,726 instructions              #    0.00  insns per cycle
>
>        0.002168502 seconds time elapsed
> ...
>
> seems wrong ;-) will check
>
> thanks,
> jirka

creating groups with perf stat is new for me and not documented ?

running the same works for me:

[capjo@e6410 ~]$ perf stat -v -e '{task-clock,cpu-clock,instructions}' kill
usage: kill [ -s signal | -p ] [ -a ] pid ...
       kill -l [ signal ]
task-clock: 884808 884808 884808
cpu-clock: 885924 884808 884808
instructions: 735287 884808 884808

 Performance counter stats for 'kill':

          0.884808 task-clock                #    0.687 CPUs utilized
          0.885924 cpu-clock
           735,287 instructions              #    0.00  insns per cycle

       0.001287584 seconds time elapsed

[capjo@e6410 ~]$ perf --version
perf version 3.7-5
[capjo@e6410 ~]$ uname -a
Linux e6410 3.7.4-1-ARCH #1 SMP PREEMPT Mon Jan 21 23:05:29 CET 2013
x86_64 GNU/Linux
