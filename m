From: Milian Wolff <mail@milianw.de>
Subject: Re: task-clock vs. cpu-clock; per-event documentation
Date: Wed, 05 Aug 2015 15:38:50 +0200
Message-ID: <2546272.3bCUhbRkWq@milian-kdab2>
References: <1472439.mytDSkIAAG@milian-kdab2> <CAGz0_-2CGffoKu7LG+ZA6=QkYFzts8=AVg=j7xYVHkCxJPtQSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:37977 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbbHENix (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Aug 2015 09:38:53 -0400
In-Reply-To: <CAGz0_-2CGffoKu7LG+ZA6=QkYFzts8=AVg=j7xYVHkCxJPtQSQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: linux-perf-users@vger.kernel.org

On Wednesday 05 August 2015 15:07:28 Andreas Hollmann wrote:
> Hi,
> 
> I had the same question in 2013 and the best answer I got was (by David
> Ahern):

Hello Andreas,

I found your email as well, but not the answer by David Ahern - thanks!

> cpu-clock is wall-clock based -- so samples are taken at regular
> intervals relative to walltime.
> 
> I believe that task-clock is relative to the task run time. So,
> samples are taken at regular intervals relative to the process'
> runtime.

Hm, I seem to be missing some crucial information then. From the above, I'd 
assume that cpu-clock would advance even when any other process is running on 
the given CPU, and also that it would always be higher than the task-clock:

perf stat -e cpu-clock,task-clock find /tmp

 Performance counter stats for 'find /tmp':

          2.504951      cpu-clock (msec)                                            
          2.508933      task-clock (msec)         #    0.726 CPUs utilized          

       0.003456557 seconds time elapsed

Here the task-clock is higher than the cpu-clock...? So what is a task in 
Kernel speak? Is it a thread? A process? 

Also, you say that cpu-clock samples are relative to walltime, but that is 
only CPU walltime, i.e. excluding sleep or I/O time. And even then, cpu-clock 
is limited to the process clock:

$ perf stat -e cpu-clock,task-clock sleep 1

 Performance counter stats for 'sleep 1':

          0.365390      cpu-clock (msec)                                            
          0.365318      task-clock (msec)         #    0.000 CPUs utilized          

       1.000775593 seconds time elapsed

$ sudo perf stat -e cpu-clock,task-clock -a sleep 1

 Performance counter stats for 'system wide':

       8015.143460      cpu-clock (msec)                                              
(100.00%)
       8015.047445      task-clock (msec)         #    8.006 CPUs utilized          

       1.001121827 seconds time elapsed

Bye

> 2015-08-05 14:55 GMT+02:00 Milian Wolff <mail@milianw.de>:
> > Hello all,
> > 
> > I was asked by a colleague of mine what the difference between task-clock
> > and cpu-clock is. I found many similar questions on the web, but none
> > have a final answer:
> > 
> > http://stackoverflow.com/questions/23965363/linux-perf-events-cpu-clock-an
> > d-task-clock-what-is-the-difference https://lkml.org/lkml/2010/11/3/373
> > 
> > Could someone explain the difference between the two counters for a
> > non-kernel person? What is a task for that matter? When I compare the
> > counters on test applications, they deviate only marginally.
> > 
> > In general, is there hope for more documentation on the individual
> > performance counters? Perf list shows what's available but has no
> > information whatsoever about the actual meaning of the counters. It would
> > be excellent to also explain how to interpret the counter, or in what
> > case you'd want to look at a given event.
> > 
> > Thanks
> > --
> > Milian Wolff
> > mail@milianw.de
> > http://milianw.de
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-perf-users" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
