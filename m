Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6125E449;
	Wed,  4 Jun 2025 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749007435; cv=none; b=cqFXFrUrENHIYfhnAG1qYU+6nA56n+sPmxzdMnLVc7UdA5BbZiykZDeo+xYjJnDW0aThPQcVk+9NlFb74cGo6yMDOhfZ8x64oeedOaXhBwPPMMzuj4fDqdwXrV4lFOHpEeRfT3fbvarr8llfPP+vmZguxSAei6kjS3rWx+szM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749007435; c=relaxed/simple;
	bh=GaIZHI2iHdcx1NzRvfEH8Ec6CXweNlSy+LmYuvXzuUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APAXfzBqLynpTie2L5qmIFnURCkBbz4Ro8loLqe9TVXUFGM2DdYHJnbd0yj2GgTVCuFYmKWS1mJw522mufJzRhEH2fl6QvlX9MBY4wuNyfwJGrVu/4xjw3WO8naWl89k46rDxmbw1LbmS+60Lny/oyElxX7EFdYuhe9aKlbqXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bBtGH5tWgzYQvQN;
	Wed,  4 Jun 2025 11:23:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DC04A1A0DE2;
	Wed,  4 Jun 2025 11:23:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP1 (Coremail) with SMTP id cCh0CgC3GntEvD9ondLUOA--.11688S5;
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
Subject: [PATCH v2 1/2] perf/core: Fix nr_cgroups/cpuctx->cgrp is not updated correctly
Date: Wed,  4 Jun 2025 03:39:23 +0000
Message-Id: <20250604033924.3914647-2-luogengkun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgC3GntEvD9ondLUOA--.11688S5
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy8uFyfJr4xWF45Gw18uFg_yoW8AFWDpr
	s3CrsxK3y0qw1jvw13tw18W345Gw4rtFZ0gw1DKw4fZFW5WrWrXF1xGa4rZFs8Zr97AFy3
	tw1jvr17C3yUJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Since __perf_remove_from_context updates event->state before
list_del_event, this prevents list_del_event from calling
perf_cgroup_event_disable, resulting in will not update nr_cgroups and
cpuctx->cgrp.

To fix this problem, move perf_cgroup_event_disable into
__perf_remove_from_context as:

commit a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")

did.

Fixes: a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f34c99f8ce8f..280d42b40b34 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2120,18 +2120,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (event->group_leader == event)
 		del_event_from_groups(event, ctx);
 
-	/*
-	 * If event was in error state, then keep it
-	 * that way, otherwise bogus counts will be
-	 * returned on read(). The only way to get out
-	 * of error state is by explicit re-enabling
-	 * of the event
-	 */
-	if (event->state > PERF_EVENT_STATE_OFF) {
-		perf_cgroup_event_disable(event, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	}
-
 	ctx->generation++;
 	event->pmu_ctx->nr_events--;
 }
@@ -2498,6 +2486,9 @@ __perf_remove_from_context(struct perf_event *event,
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
+
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
 	perf_event_set_state(event, min(event->state, state));
 
 	if (flags & DETACH_GROUP)
-- 
2.34.1

