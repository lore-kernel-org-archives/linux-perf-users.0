Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4EE2E62D9;
	Thu, 26 Jun 2025 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945051; cv=none; b=TvaE2ASjMIzjcz8MuFAavHLw+gcBC23XlIspngWHGAv68b8o7MRCtOQmCJJaeT0hLUCjAkGi6xuIS5bCNSrs9/t4gDFVqyNIe4jBr5/8J3CufzWkhCc+6QMdY7LvD86UTnecsHJkzTD6VQfKf6eujxfgvWB7aiwd7Edqy5Sastk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945051; c=relaxed/simple;
	bh=EDqkWAsPHJhPn0akvoePYwUq4YKPq78Au74sO3OhtC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tvSh9cJHJbWRm3QkSHm1WEAM54XKXF7/fHS40LYtLRhHEfYgV5y3tTMG/S5T7A4fdaWq+eu3QgBuQtBlJtV794ROwUiJE0FvFaGUMmN84AN4ToJg2qDE76snsF4VziracHeQbfoCiSPeV2FLjqgKTyGsBj2i+/995Ep7tvNJ6Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bSfr73tF6zKHLtf;
	Thu, 26 Jun 2025 21:37:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E156A1A084D;
	Thu, 26 Jun 2025 21:37:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl8UTV1omo7iQg--.26859S4;
	Thu, 26 Jun 2025 21:37:25 +0800 (CST)
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
	linux-kernel@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH] perf/core: Fix the WARN_ON_ONCE is out of lock protected region
Date: Thu, 26 Jun 2025 13:54:03 +0000
Message-Id: <20250626135403.2454105-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl8UTV1omo7iQg--.26859S4
X-Coremail-Antispam: 1UD129KBjvJXoWrtFWDKr4rur17Wr1xZr4UXFb_yoW8JrW5pa
	4kCFy7tws5ua42vay5G348Z342va10qan5WF12gw4SyF45Jw1rXFW7Gw13XF1UAwn7tFy3
	JFZ0vr1Ykw4UtaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRixwI3UUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

commit 3172fb986666 ("perf/core: Fix WARN in perf_cgroup_switch()") try to
fix a concurrency problem between perf_cgroup_switch and
perf_cgroup_event_disable. But it does not to move the WARN_ON_ONCE into
lock-protected region, so the warning is still be triggered.

Fixes: 3172fb986666 ("perf/core: Fix WARN in perf_cgroup_switch()")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f746469fda5..a35784d42c66 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -951,8 +951,6 @@ static void perf_cgroup_switch(struct task_struct *task)
 	if (READ_ONCE(cpuctx->cgrp) == NULL)
 		return;
 
-	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
-
 	cgrp = perf_cgroup_from_task(task, NULL);
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
 		return;
@@ -964,6 +962,8 @@ static void perf_cgroup_switch(struct task_struct *task)
 	if (READ_ONCE(cpuctx->cgrp) == NULL)
 		return;
 
+	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
+
 	perf_ctx_disable(&cpuctx->ctx, true);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
-- 
2.34.1

