Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1117202978;
	Wed, 14 May 2025 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204255; cv=none; b=HC6LngmF5iwY/yygM4IqU4YV2waydVu9LWjHfEaGip0fny+S+xAcbcyEkhfedRpJm7Pq/++4ZxhWNcUT6fnV+ppSQ/67SDgZXSmD6hxxbksMFsJ5EMaSnPsCqUVyjXyXTMc0NZ8jA+GFcqHzc0xW6VTCbh4GfJHAuyZUQ3JfV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204255; c=relaxed/simple;
	bh=sQrzucZYUDYdQm4eX+PRjNPoCM0sY46xAWqos37bKP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abiAhs0ZWuGxgdHhKa08GARWgtDPmBi5xMCB1MciCFxWb0y3buRWZGrxfvHG3PFUM3fJG2KBhoxk8WHbcazIqRD2P9pwtv64odNHh7Cau0bcP/fepESve3iK/7jg2ZJhW/ObpkHIAbCd2EB45QDlcmgT0k8kzgAhfnJ1ATSc69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zy3P43lp8z4f3lDF;
	Wed, 14 May 2025 14:30:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BB8E01A195E;
	Wed, 14 May 2025 14:30:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl+NOCRovzV0MQ--.23862S5;
	Wed, 14 May 2025 14:30:42 +0800 (CST)
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
Subject: [PATCH Fix perf cgroup problem 1/2] perf/core: Fix nr_cgroups/cpuctx->cgrp is not updated correctly
Date: Wed, 14 May 2025 06:47:57 +0000
Message-Id: <20250514064758.4156497-2-luogengkun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnSl+NOCRovzV0MQ--.23862S5
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy8uFyfJr4xXrWktw15XFb_yoW8GFykpr
	Z3ArnxK3y0qw1qvw13Jr1kuw1UW3yrXrsIqa1kKw4avFy5W3yrJa13GayFvrs0vrZ3Xa45
	Jw4v9w1UW3yUXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
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
	JbIYCTnIWIevJa73UjIFyTuYvjxU2HGQDUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Since __perf_remove_from_context updates event->state before list_del_event,
this prevents list_del_event from calling perf_cgroup_event_disable,
resulting in will not update nr_cgroups and cpuctx->cgrp.

To resolve this issue:
 1. First update the event time to ensure perf_child_detach uses
    accurate event time.
 2. Then update event->state after list_del_event completes.

Fixes: a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95e703891b24..ecb4d852a006 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2482,12 +2482,17 @@ __perf_remove_from_context(struct perf_event *event,
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
-	perf_event_set_state(event, min(event->state, state));
+	perf_event_update_time(event);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
+	/*
+	 * Update the event->state after list_del_event.
+	 */
+	if (flags & (DETACH_DEAD | DETACH_EXIT))
+		event->state = state;
 
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
-- 
2.34.1

