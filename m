From: Arun Sharma <asharma@fb.com>
Subject: Profiling sleep times?
Date: Mon, 3 Oct 2011 12:38:59 -0700
Message-ID: <4E8A0F53.7020408@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54719 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756250Ab1JCTsX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Oct 2011 15:48:23 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@ghostprotocols.net, Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu, Stephane Eranian <eranian@google.com>


Some of our users want to use perf to profile not just the code that 
consumes cycles, but also the code that ends up waiting for I/O - 
otherwise known as wall clock profiling.

I could not find ways of getting this info from the perf tool as-is. 
Wondering if a software event such as PERF_COUNT_SW_SLEEP_CLOCK below 
makes sense.

The idea is, if a task sleeps for 1ms, it should generate 1000x more 
samples vs a task that sleeps for 1us. Also, the callchain emitted 
should be the user stack.

If such an event is useful to a larger set of users, I could try to work 
out the details of how to get to event->attr.freq in the context switch 
path with low overhead and run some tests to verify that the profile 
that comes out of "perf report" looks sane.

We'll also need ways of combining PERF_COUNT_SW_TASK_CLOCK and 
PERF_COUNT_SW_SLEEP_CLOCK (in userspace?) to get the full picture.

  -Arun


diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c2da40d..a3e2fb4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -106,6 +106,7 @@ enum perf_sw_ids {
         PERF_COUNT_SW_PAGE_FAULTS_MAJ           = 6,
         PERF_COUNT_SW_ALIGNMENT_FAULTS          = 7,
         PERF_COUNT_SW_EMULATION_FAULTS          = 8,
+       PERF_COUNT_SW_SLEEP_CLOCK               = 9,

         PERF_COUNT_SW_MAX,                      /* non-ABI */
  };
diff --git a/kernel/sched_fair.c b/kernel/sched_fair.c
index 7406f36..e973862 100644
--- a/kernel/sched_fair.c
+++ b/kernel/sched_fair.c
@@ -877,8 +877,10 @@ static void enqueue_sleeper(struct cfs_rq *cfs_rq, 
struct sched_entity *se)
                 se->statistics.sum_sleep_runtime += delta;

                 if (tsk) {
+                       u64 freq = 1000000; /* XXX: Use event->attr.freq 
? */
                         account_scheduler_latency(tsk, delta >> 10, 1);
                         trace_sched_stat_sleep(tsk, delta);
+                       perf_sw_event(PERF_COUNT_SW_SLEEP_CLOCK, 
delta/freq, 0, NULL, 0);
                 }
         }
         if (se->statistics.block_start) {
