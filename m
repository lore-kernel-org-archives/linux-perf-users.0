From: linxiulei@gmail.com
Subject: [PATCH] perf/core: Fix installing cgroup event into cpu
Date: Thu, 11 Jan 2018 11:09:58 +0800
Message-ID: <20180111030958.8627-1-linxiulei@gmail.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45756 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753084AbeAKDMD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Jan 2018 22:12:03 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, jolsa@redhat.com, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, eranian@gmail.com, torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org, brendan.d.gregg@gmail.com
Cc: yang_oliver@hotmail.com, jinli.zjl@alibaba-inc.com, "leilei.lin" <leilei.lin@alibaba-inc.com>

From: "leilei.lin" <leilei.lin@alibaba-inc.com>

Do not install cgroup event into the CPU context if the cgroup
is not running on this CPU

While there is no task of cgroup running specified CPU, current
kernel still install cgroup event into CPU context, that causes
another cgroup event can't be installed into this CPU.

Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
---
 kernel/events/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4df5b69..19c587b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2284,6 +2284,7 @@ static int  __perf_install_in_context(void *info)
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
+	struct perf_cgroup *cgrp;
 	bool reprogram = true;
 	int ret = 0;
 
@@ -2311,6 +2312,19 @@ static int  __perf_install_in_context(void *info)
 		raw_spin_lock(&task_ctx->lock);
 	}
 
+	if (event->cgrp) {
+		/*
+		 * Only care about cgroup events.
+		 *
+		 * If only the task belongs to cgroup of this event,
+		 * we will continue the installment
+		 */
+		cgrp = perf_cgroup_from_task(current, ctx);
+		if (!cgroup_is_descendant(cgrp->css.cgroup,
+					event->cgrp->css.cgroup))
+			goto unlock;
+	}
+
 	if (reprogram) {
 		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
-- 
2.8.4.31.g9ed660f
