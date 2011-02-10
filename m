From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: 2.6.37 kernel warning in perf_events code
Date: Thu, 10 Feb 2011 17:08:43 -0200
Message-ID: <20110210190843.GE20676@ghostprotocols.net>
References: <AANLkTi=4_p73eHhQbj5DDDEzTWaLou+u2igiY+yNiPQ9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46189 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab1BJTIz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Feb 2011 14:08:55 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=4_p73eHhQbj5DDDEzTWaLou+u2igiY+yNiPQ9@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

Em Wed, Feb 09, 2011 at 06:50:09PM -0800, Arun Sharma escreveu:
> [ Not sure if this is known and fixed in newer kernels. My machine
> becomes unusable after this warning triggers ]
> 
> perf record -g -p <pid> cs -o csw.data -- sleep 3

What kernel are you using? Peter, rings any bells?

- Arnaldo
 
> Feb 7 15:28:36 localhost kernel: WARNING: at kernel/perf_event.c:1302
> task_ctx_sched_out+0x45/0x67()
> ..
> Feb 7 15:28:36 localhost kernel: [<ffffffff8103c60d>]
> warn_slowpath_null+0x15/0x17
> Feb 7 15:28:36 localhost kernel: [<ffffffff8109e3b6>]
> task_ctx_sched_out+0x45/0x67
> Feb 7 15:28:36 localhost kernel: [<ffffffff8109e3b6>]
> task_ctx_sched_out+0x45/0x67
> Feb 7 15:28:36 localhost kernel: [<ffffffff810a207f>]
> perf_event_exit_task+0xca/0x196
> Feb 7 15:28:36 localhost kernel: [<ffffffff810a207f>]
> perf_event_exit_task+0xca/0x196
> Feb 7 15:28:36 localhost kernel: [<ffffffff8103fb3f>] do_exit+0x2c5/0x6e6
> Feb 7 15:28:36 localhost kernel: [<ffffffff8103fb3f>] do_exit+0x2c5/0x6e6
> Feb 7 15:28:36 localhost kernel: [<ffffffff81040021>] complete_and_exit+0x0/0x1e
> Feb 7 15:28:36 localhost kernel: [<ffffffff81040021>] complete_and_exit+0x0/0x1e
> Feb 7 15:28:36 localhost kernel: [<ffffffff8100293b>]
> system_call_fastpath+0x16/0x1b
> Feb 7 15:28:36 localhost kernel: [<ffffffff8100293b>]
> system_call_fastpath+0x16/0x1b
> 
> 
> 1301
> 1302         if (WARN_ON_ONCE(ctx != cpuctx->task_ctx))
> 1303                 return;
> 
>  -Arun
