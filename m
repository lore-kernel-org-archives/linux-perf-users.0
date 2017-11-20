From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: measuring system wide CPU usage ignoring idle process
Date: Mon, 20 Nov 2017 21:24:42 +0100
Message-ID: <215895928.dRJQAAs51a@agathebauer>
References: <3344812.IFj9h2T05j@agathebauer> <20171120142908.GA22876@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:51386 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbdKTUYp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Nov 2017 15:24:45 -0500
In-Reply-To: <20171120142908.GA22876@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org

On Montag, 20. November 2017 15:29:08 CET Jiri Olsa wrote:
> On Mon, Nov 20, 2017 at 03:00:46PM +0100, Milian Wolff wrote:
> > Hey all,
> > 
> > colleagues of mine just brought this inconvenient perf stat behavior to my
> > attention:
> > 
> > $ perf stat -a -e cpu-clock,task-clock,cycles,instructions sleep 1
> > 
> >  Performance counter stats for 'system wide':
> >        4004.501439      cpu-clock (msec)          #    4.000 CPUs utilized
> >        4004.526474      task-clock (msec)         #    4.000 CPUs utilized
> >        945,906,029      cycles                    #    0.236 GHz
> >        461,861,241      instructions              #    0.49  insn per
> >        cycle
> >        
> >        1.001247082 seconds time elapsed
> > 
> > This shows that cpu-clock and task-clock are incremented also for the idle
> > processes. Is there some trick to exclude that time, such that the CPU
> > utilization drops below 100% when doing `perf stat -a`?
> 
> I dont think it's the idle process you see, I think it's the managing
> overhead before the 'sleep 1' task goes actualy to sleep
> 
> there's some user space code before it gets into the sleep syscall,
> and there's some possible kernel scheduling/syscall/irq code with
> events already enabled and counting

Sorry for being unclear: I was talking about the task-clock and cpu-clock 
values which you omitted from your measurements below. My example also shows 
that the counts for cycles and instructions are fine. But the cpu-clock and 
task-clock are useless as they always sum up to essentially `$nproc*$runtime`. 
What I'm hoping for are fractional values for the "N CPUs utilized".

> in following 3 sessions you can see the counts are pretty much
> the same regardless the sleeping time:
> 
> 	[jolsa@krava perf]$ sudo ./perf stat -e cycles:u,cycles:k sleep 1
> 
> 	 Performance counter stats for 'sleep 1':
> 
> 		   316,478      cycles:u
> 		   594,468      cycles:k
> 
> 	       1.000813330 seconds time elapsed
> 
> 	[jolsa@krava perf]$ sudo ./perf stat -e cycles:u,cycles:k sleep 5
> 
> 	 Performance counter stats for 'sleep 5':
> 
> 		   339,287      cycles:u
> 		   665,888      cycles:k
> 
> 	       5.001004575 seconds time elapsed
> 
> 	[jolsa@krava perf]$ sudo ./perf stat -e cycles:u,cycles:k sleep 10
> 
> 	 Performance counter stats for 'sleep 10':
> 
> 		   314,507      cycles:u
> 		   658,764      cycles:k
> 
> 	      10.001117596 seconds time elapsed


-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
