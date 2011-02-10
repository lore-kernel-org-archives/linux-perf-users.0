From: Arun Sharma <arun@sharma-home.net>
Subject: 2.6.37 kernel warning in perf_events code
Date: Wed, 9 Feb 2011 18:50:09 -0800
Message-ID: <AANLkTi=4_p73eHhQbj5DDDEzTWaLou+u2igiY+yNiPQ9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59124 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab1BJCuK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Feb 2011 21:50:10 -0500
Received: by iwn9 with SMTP id 9so829584iwn.19
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Feb 2011 18:50:09 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org

[ Not sure if this is known and fixed in newer kernels. My machine
becomes unusable after this warning triggers ]

perf record -g -p <pid> cs -o csw.data -- sleep 3

Feb 7 15:28:36 localhost kernel: WARNING: at kernel/perf_event.c:1302
task_ctx_sched_out+0x45/0x67()
..
Feb 7 15:28:36 localhost kernel: [<ffffffff8103c60d>]
warn_slowpath_null+0x15/0x17
Feb 7 15:28:36 localhost kernel: [<ffffffff8109e3b6>]
task_ctx_sched_out+0x45/0x67
Feb 7 15:28:36 localhost kernel: [<ffffffff8109e3b6>]
task_ctx_sched_out+0x45/0x67
Feb 7 15:28:36 localhost kernel: [<ffffffff810a207f>]
perf_event_exit_task+0xca/0x196
Feb 7 15:28:36 localhost kernel: [<ffffffff810a207f>]
perf_event_exit_task+0xca/0x196
Feb 7 15:28:36 localhost kernel: [<ffffffff8103fb3f>] do_exit+0x2c5/0x6e6
Feb 7 15:28:36 localhost kernel: [<ffffffff8103fb3f>] do_exit+0x2c5/0x6e6
Feb 7 15:28:36 localhost kernel: [<ffffffff81040021>] complete_and_exit+0x0/0x1e
Feb 7 15:28:36 localhost kernel: [<ffffffff81040021>] complete_and_exit+0x0/0x1e
Feb 7 15:28:36 localhost kernel: [<ffffffff8100293b>]
system_call_fastpath+0x16/0x1b
Feb 7 15:28:36 localhost kernel: [<ffffffff8100293b>]
system_call_fastpath+0x16/0x1b


1301
1302         if (WARN_ON_ONCE(ctx != cpuctx->task_ctx))
1303                 return;

 -Arun
