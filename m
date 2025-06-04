Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DBF231828;
	Wed,  4 Jun 2025 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749007440; cv=none; b=EotZwPUhR4BEdYk8BI7enw+WKvMXHrtPss3GSdB6TL3597qkso8I5JYJspziFllZ2YOaxZEbcMRLZBt7q7CCIpT7E6C6If0gaIe9MqdgyDFXz+AtHd/QrCSgx6aeJQ57r1boQpX/iUQNRtZkJ34Xz5r8zo0yvL1twBup0RPVa2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749007440; c=relaxed/simple;
	bh=KKCtxcNKDurQedRm8dJ/mP8QxHRVX5UPgpzxDkDohe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7K8UMwUDjZ4iJ7Lb0XCE4LZnRBYNZsonFSKqV9Ooz+DnK31XEK9/yQc4lagOY5yzgesTlOBk+WGcfQGPxynlO7AGyWMpEVvtMKXTZ7+HoRnx058+L7TBBu4Wn8iRNFn6uyQe3W+wq33ZhjfsqHMMhmKuryKc5zlFcYOeUSir7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bBtGJ4Hq3zKHND7;
	Wed,  4 Jun 2025 11:23:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F16FF1A118D;
	Wed,  4 Jun 2025 11:23:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP1 (Coremail) with SMTP id cCh0CgC3GntEvD9ondLUOA--.11688S6;
	Wed, 04 Jun 2025 11:23:50 +0800 (CST)
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
	davidcc@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH v2 2/2] perf/core: Fix WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0) in perf_cgroup_switch
Date: Wed,  4 Jun 2025 03:39:24 +0000
Message-Id: <20250604033924.3914647-3-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604033924.3914647-1-luogengkun@huaweicloud.com>
References: <20250604033924.3914647-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3GntEvD9ondLUOA--.11688S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4DWr17XF1kuF1rZF1kXwb_yoW5GF47pa
	n7CrW29ws5XF90qay5t34vq3W0qa1Fqa95Wr1jkw4ayrW5Xr1fXF4xCw43JF15AFn7JFy3
	trZ0vr15C34UKaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

There may be concurrency between perf_cgroup_switch and
perf_cgroup_event_disable. Consider the following scenario: after a new
perf cgroup event is created on CPU0, the new event may not trigger
a reprogramming, causing ctx->is_active to be 0. In this case, when CPU1
disables this perf event, it executes __perf_remove_from_context->
list _del_event->perf_cgroup_event_disable on CPU1, which causes a race
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

To fix this problem, expand the lock-holding critical section in
perf_cgroup_switch.

Fixes: db4a835601b7 ("perf/core: Set cgroup in CPU contexts for new cgroup events")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 280d42b40b34..1e442897ebde 100644
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

