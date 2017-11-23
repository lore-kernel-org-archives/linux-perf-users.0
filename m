From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: measuring system wide CPU usage ignoring idle process
Date: Thu, 23 Nov 2017 16:15:36 +0100
Message-ID: <20171123151536.3vzjtbs5e4pccxpw@hirez.programming.kicks-ass.net>
References: <3344812.IFj9h2T05j@agathebauer>
 <215895928.dRJQAAs51a@agathebauer>
 <20171120234438.GA22397@krava>
 <6754554.PRelPk1P9n@milian-kdab2>
 <20171123140931.GA5575@krava>
 <20171123142100.GA7066@krava>
 <20171123144220.GB8789@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:53108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdKWPPq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Nov 2017 10:15:46 -0500
Content-Disposition: inline
In-Reply-To: <20171123144220.GB8789@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org, namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>

On Thu, Nov 23, 2017 at 11:42:20AM -0300, Arnaldo Carvalho de Melo wrote:
> What is wrong with perf_event_attr.exclude_idle? :-)

Neither task- nor cpu-clock actually implement that..

Something like the _completely_untested_ below might cure that for
cpu-clock. I have the nagging feeling we actually already account the
idle time _somewhere_, but I couldn't remember and was too lazy to go
find -- but someone should if this were to become an actual patch.


---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a59fe11558a4..5386d551b373 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8900,6 +8908,10 @@ static void cpu_clock_event_update(struct perf_event *event)
 	u64 now;
 
 	now = local_clock();
+
+	if (event->attr.exclude_idle)
+		now -= idle_task(event->oncpu)->se.sum_exec_runtime;
+
 	prev = local64_xchg(&event->hw.prev_count, now);
 	local64_add(now - prev, &event->count);
 }
diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
index d518664cce4f..419c620510c6 100644
--- a/kernel/sched/idle_task.c
+++ b/kernel/sched/idle_task.c
@@ -27,9 +27,14 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 static struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
+	struct task_struct *idle = rq->idle;
+
 	put_prev_task(rq, prev);
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+
+	idle->se.exec_start = rq_clock_task(rq);
+
 	return rq->idle;
 }
 
@@ -48,6 +53,17 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
+	struct task_struct *idle = rq->idle;
+	u64 delta, now;
+
+	now = rq_clock_task(rq);
+	delta = now - idle->se.exec_start;
+	if (unlikely((s64)delta < 0))
+		delta = 0;
+
+	idle->se.sum_exec_runtime += delta;
+	idle->se.exec_start = now;
+
 	rq_last_tick_reset(rq);
 }
 
@@ -57,6 +73,9 @@ static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 
 static void set_curr_task_idle(struct rq *rq)
 {
+	struct task_struct *idle = rq->idle;
+
+	idle->se.exec_start = rq_clock_task(rq);
 }
 
 static void switched_to_idle(struct rq *rq, struct task_struct *p)
