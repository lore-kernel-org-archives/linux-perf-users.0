Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50081FF7B0;
	Wed, 14 May 2025 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204259; cv=none; b=cYo4wvgOhwHd7aeBMSIA6c6oWHAqcbhxj2S9B6fZwN6MClsdjIFqlQInnVcpNcs2lajVSRFk8FURrRl3XLyGWjp8pFIyVJgiqNeJE5/UGfxO/BvYcomiWhy4K6aHAhvXM/Xvngv2NlwO69HWw5aditPf4+Uk34rYCqyah3FxHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204259; c=relaxed/simple;
	bh=X/PMX4gFsSln85c3wxBJ0Z3RAuoCm0t+XCLinqgK2ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKYKmLBLo0Z4cIEpjcV91A6+LOyFmw6R596BsmBG0Z98AQVfIEB20cuiNqraoIYxnJJL6xcsRQ5mtwBd1ZlJ5rWrrMLZxzM9aBuIoyrkCv4gO6Ike1J2+AQfXdy4Q6X7BeK7arWrMUvJubg4UrLRqt2jQrtIXg15zQdAVbkP7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zy3PJ63jXz4f3lDq;
	Wed, 14 May 2025 14:30:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 13FC61A12EF;
	Wed, 14 May 2025 14:30:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl+NOCRovzV0MQ--.23862S6;
	Wed, 14 May 2025 14:30:54 +0800 (CST)
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
	yeoreum.yun@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH Fix perf cgroup problem 2/2] perf/core: Fix WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0) in perf_cgroup_switch
Date: Wed, 14 May 2025 06:47:58 +0000
Message-Id: <20250514064758.4156497-3-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514064758.4156497-1-luogengkun@huaweicloud.com>
References: <20250514064758.4156497-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl+NOCRovzV0MQ--.23862S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tryrtr45JFW8tw4kAFy3XFb_yoW8ZFy8pa
	1kCrW2kws5WFnIqa45K34vv3WIqw4Fqa98W34qkr4fCrW5Xr13XF1xWw43JF15CFs7tFy3
	trZ09r1Yk34UKaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxUFSdyUUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

There may be concurrency between perf_cgroup_switch and
perf_cgroup_event_disable. Consider the following scenario: after a new
perf cgroup event is created on CPU0, the new event might not trigger
reprogramm, leaving ctx->is_active as 0. In this case, when CPU1 disables
the perf event, it executes __perf_remove_from_context->list_del_event->
perf_cgroup_event_disable on CPU1, resulting in a race with
perf_cgroup_switch running on CPU0.

To fix this problem, expand the lock-holding critical section in
perf_cgroup_switch.

Fixes: db4a835601b7 ("perf/core: Set cgroup in CPU contexts for new cgroup events")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ecb4d852a006..fae1f68cbca5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -931,20 +931,20 @@ static void perf_cgroup_switch(struct task_struct *task)
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_cgroup *cgrp;
 
+	cgrp = perf_cgroup_from_task(task, NULL);
+	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	/*
 	 * cpuctx->cgrp is set when the first cgroup event enabled,
 	 * and is cleared when the last cgroup event disabled.
 	 */
 	if (READ_ONCE(cpuctx->cgrp) == NULL)
-		return;
+		goto unlock;
 
 	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
 
-	cgrp = perf_cgroup_from_task(task, NULL);
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
-		return;
+		goto unlock;
 
-	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_ctx_disable(&cpuctx->ctx, true);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
@@ -962,6 +962,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
 	perf_ctx_enable(&cpuctx->ctx, true);
+unlock:
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
-- 
2.34.1

