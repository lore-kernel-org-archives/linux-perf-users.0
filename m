Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ACC25C6F7;
	Mon,  9 Jun 2025 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749440279; cv=none; b=sZENTArvUZNIjwZkvtBp6giBvaQsnI0oV3RGJwKSlAvXppcwllzKcyqx8OXdnSNCrnsEbod+9JpSAAJRDEi+4UGL7wJZnzdn625in7/P2vNuUSkQRs5bwDgNOcJ6kIh/GKualqfzaRlcnYfL2mwcUhAnfnEeouIYcca2eSLF+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749440279; c=relaxed/simple;
	bh=EPTH44jqF1joHLOJRZq+d2ztXqqn7aJ98pXWigr/MQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WtCxtjPHcZkYh6Y4Iy4Nnk3MOj+s8oT9dsrKB0qWfPiLmX6q1jPPgNSaijbojGVYL+dhyudU/2FJljroL5tcKZb/7XNTqJiFXO3i9sxbGnsia5AGmRrdiiQOetDXqNrAHbbgeA+PGvcIjSX29EDIKGXEvq3mm8/u4qW/gvx5lU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bFyLB3V6nzKHN9n;
	Mon,  9 Jun 2025 11:37:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D11451A0FB3;
	Mon,  9 Jun 2025 11:37:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgB3218NV0ZolkrOOw--.50094S4;
	Mon, 09 Jun 2025 11:37:50 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] perf/core: Fix WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0) in perf_cgroup_switch
Date: Mon,  9 Jun 2025 03:53:16 +0000
Message-Id: <20250609035316.250557-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3218NV0ZolkrOOw--.50094S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4DWr17XF1kuF1rZF1kXwb_yoWrJr4kpF
	srCr4Ygws8XF9Iqay3tw1vvw1avw4FqaykWr17Kw4akrW5Xr1DGF47Ga15JFn8Zrn7tFy3
	trZ0kr13C34Ut3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

There may be concurrency between perf_cgroup_switch and
perf_cgroup_event_disable. Consider the following scenario: after a new
perf cgroup event is created on CPU0, the new event may not trigger
a reprogramming, causing ctx->is_active to be 0. In this case, when CPU1
disables this perf event, it executes __perf_remove_from_context->
list_del_event->perf_cgroup_event_disable on CPU1, which causes a race
with perf_cgroup_switch running on CPU0.

The following describes the details of this concurrency scenario:

CPU0						CPU1

perf_cgroup_switch:
   ...
   # cpuctx->cgrp is not NULL here
   if (READ_ONCE(cpuctx->cgrp) == NULL)
   	return;

						perf_remove_from_context:
						   ...
						   raw_spin_lock_irq(&ctx->lock);
						   ...
						   # ctx->is_active == 0 because reprogramm is not
						   # tigger, so CPU1 can do __perf_remove_from_context
						   # for CPU0
						   __perf_remove_from_context:
						         perf_cgroup_event_disable:
							    ...
							    if (--ctx->nr_cgroups)
							    ...

   # this warning will happened because CPU1 changed
   # ctx.nr_cgroups to 0.
   WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);

To fix this problem, re-check the condition after hold the lock and take
this opportunity to convert to guard instead of adding goto unlock.

Fixes: db4a835601b7 ("perf/core: Set cgroup in CPU contexts for new cgroup events")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
Changes in v3:
1. Using guard instead of adding goto unlock to make the code more robust.
2. Re-check the condition instead of expand the lock-holding critical
section.

Link to v2: https://lore.kernel.org/all/20250604033924.3914647-1-luogengkun@huaweicloud.com/
---
 kernel/events/core.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 280d42b40b34..4759a051459f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -207,6 +207,25 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 	__perf_ctx_unlock(&cpuctx->ctx);
 }
 
+typedef struct {
+	struct perf_cpu_context *cpuctx;
+	struct perf_event_context *ctx;
+} class_perf_ctx_lock_t;
+
+static inline void
+class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
+{
+	perf_ctx_unlock(_T->cpuctx, _T->ctx);
+}
+
+static inline class_perf_ctx_lock_t
+class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
+				struct perf_event_context *ctx)
+{
+	perf_ctx_lock(cpuctx, ctx);
+	return (class_perf_ctx_lock_t) {cpuctx, ctx};
+}
+
 #define TASK_TOMBSTONE ((void *)-1L)
 
 static bool is_kernel_event(struct perf_event *event)
@@ -938,13 +957,19 @@ static void perf_cgroup_switch(struct task_struct *task)
 	if (READ_ONCE(cpuctx->cgrp) == NULL)
 		return;
 
-	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
-
 	cgrp = perf_cgroup_from_task(task, NULL);
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
 		return;
 
-	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
+	/*
+	 * Re-check, could've raced vs perf_remove_from_context().
+	 */
+	if (READ_ONCE(cpuctx->cgrp) == NULL)
+		return;
+
+	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
+
 	perf_ctx_disable(&cpuctx->ctx, true);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
@@ -962,7 +987,6 @@ static void perf_cgroup_switch(struct task_struct *task)
 	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
 	perf_ctx_enable(&cpuctx->ctx, true);
-	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
 static int perf_cgroup_ensure_storage(struct perf_event *event,
-- 
2.34.1

