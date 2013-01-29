From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Mixed group of sw/hw counters are not started if sw counter is
 group leader
Date: Tue, 29 Jan 2013 16:37:20 +0100
Message-ID: <20130129153720.GG8339@krava.brq.redhat.com>
References: <CAGz0_-0ti+_3cXQhYUAb_-zKqHBcPVYjFtQ86ZGr8utXF13Rag@mail.gmail.com>
 <20130129123908.GC8339@krava.brq.redhat.com>
 <CAGz0_-2O+7a5Bkeu3vgNFYrsGGYJxrqECKQUJJTwSDQZBktLjw@mail.gmail.com>
 <20130129140110.GF8339@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55022 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857Ab3A2PhY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Jan 2013 10:37:24 -0500
Content-Disposition: inline
In-Reply-To: <20130129140110.GF8339@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: linux-perf-users@vger.kernel.org

On Tue, Jan 29, 2013 at 03:01:10PM +0100, Jiri Olsa wrote:
> On Tue, Jan 29, 2013 at 02:43:34PM +0100, Andreas Hollmann wrote:

SNIP

> > 
> > [capjo@e6410 ~]$ perf stat -v -e '{task-clock,cpu-clock,instructions}' kill
> > usage: kill [ -s signal | -p ] [ -a ] pid ...
> >        kill -l [ signal ]
> > task-clock: 884808 884808 884808
> > cpu-clock: 885924 884808 884808
> > instructions: 735287 884808 884808
> > 
> >  Performance counter stats for 'kill':
> > 
> >           0.884808 task-clock                #    0.687 CPUs utilized
> >           0.885924 cpu-clock
> >            735,287 instructions              #    0.00  insns per cycle
> > 
> >        0.001287584 seconds time elapsed
> 
> hum, mine's not working.. seems like some event scheduling
> issue fox mixed events group
> 
> > 
> > [capjo@e6410 ~]$ perf --version
> > perf version 3.7-5
> > [capjo@e6410 ~]$ uname -a
> > Linux e6410 3.7.4-1-ARCH #1 SMP PREEMPT Mon Jan 21 23:05:29 CET 2013
> > x86_64 GNU/Linux

ok, there's been perf fixies wrt enable events groups, but they
landed in 3.8-rc1.. until that point all the group members are
specifically enabled, so that's why your perf is working and
mine not..

Anyway, seems like there's bug in kernel code when we have group
with sw and hw counters.

Attached path makes your test case working for me. I'll give it some
more thoughts & testing and send it out soon. If you like to test,
please go ahead.

thanks,
jirka


---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dd1c130..7fd93ba 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6116,6 +6116,12 @@ unlock:
 	return pmu;
 }
 
+static void perf_init_state(struct perf_event *event)
+{
+	event->state = event->attr.disabled ? PERF_EVENT_STATE_OFF :
+					      PERF_EVENT_STATE_INACTIVE;
+}
+
 /*
  * Allocate and initialize a event structure
  */
@@ -6194,8 +6200,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	event->overflow_handler	= overflow_handler;
 	event->overflow_handler_context = context;
 
-	if (attr->disabled)
-		event->state = PERF_EVENT_STATE_OFF;
+	perf_init_state(event);
 
 	pmu = NULL;
 
@@ -6624,9 +6629,11 @@ SYSCALL_DEFINE5(perf_event_open,
 
 		mutex_lock(&gctx->mutex);
 		perf_remove_from_context(group_leader);
+		perf_init_state(group_leader);
 		list_for_each_entry(sibling, &group_leader->sibling_list,
 				    group_entry) {
 			perf_remove_from_context(sibling);
+			perf_init_state(sibling);
 			put_ctx(gctx);
 		}
 		mutex_unlock(&gctx->mutex);
