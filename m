Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932F330652;
	Sun, 20 Sep 2026 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889141; cv=none; b=X2bnNOJ8PB6WDM0BrYDdeJlO9+ELcreuBOr8SV/4PfPLcg47ndK4IpNJVyDW+A2C2djv3ZtUa1T50+AtawjPjaHgXp2BDI5QzGFmNGl7Ra6SqlQp4/0HsmjfUvBtqGni8KsPTPHQEQKEjXwAEZ4+tWufhfTUhgseQUKxfUzCpF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889141; c=relaxed/simple;
	bh=oLo+HZBH+y8fgGsX0KHNJ/CcM+Iqmt6s70E0LtQhWPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fc7zI1xt0gR2VdSHps/ZO1NoRQRImOZFWh3lC4d2T2WoUEwF2MJP6j+2kYxMu2n494eR9Q7a2+qgqydJ9O9bGppCRvxpB4Fs70ZLPLpsfkz95C/AHvMc/WT/INE9C0ZjL5LxGJ4KuqWF6UKVHrGFX+hOxlJ2rFZk+kA1zSBYeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SleBAUVa; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SleBAUVa"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=B3frz5Uk8hPeGgyQBEQ2E6aoVcLT+GBE4dIyOQ7xhdA=;
	b=SleBAUVaUE1qahl9nApRe8fvzLI4NbjJHykstG0+klATTkqO8xYOM3nAU8kdorWP3rikLOOsw
	HL9TWp9CE5PsCY1x3OfrB3Bxm1M+vvtQmlcEde7Eq36hgXFuZkx2JiValCY2hAXPr4kSmT6nXqd
	tCj1cishpnjVJ2DMXONNSt0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hnd07035Fz1prN6;
	Sun, 20 Sep 2026 15:14:31 +0800 (CST)
Received: from whupemk200005.china.huawei.com (unknown [7.152.185.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F4FC40561;
	Sun, 20 Sep 2026 15:25:33 +0800 (CST)
Received: from huawei.com (10.67.174.193) by whupemk200005.china.huawei.com
 (7.152.185.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 20 Sep
 2026 15:25:31 +0800
From: Luo Gengkun <luogengkun2@huawei.com>
To: <peterz@infradead.org>
CC: <acme@kernel.org>, <adrian.hunter@intel.com>,
	<alexander.shishkin@linux.intel.com>, <dvyukov@google.com>,
	<elver@google.com>, <irogers@google.com>, <james.clark@linaro.org>,
	<jolsa@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <luogengkun2@huawei.com>,
	<mark.rutland@arm.com>, <mingo@redhat.com>, <namhyung@kernel.org>
Subject: [PATCH v2] perf/core: Fix race between perf_event_exit_task() and perf_pending_task()
Date: Sun, 20 Sep 2026 07:50:26 +0000
Message-ID: <20260920075026.990582-1-luogengkun2@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918095049.GL1837346@noisy.programming.kicks-ass.net>
References: <20260918095049.GL1837346@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk200005.china.huawei.com (7.152.185.164)

A race condition exists between perf_event_exit_task() and
perf_pending_task() during begin_new_exec().

During begin_new_exec(), perf_event_exit_task() may be called, and the
PF_EXITING flag is not set on task. So perf_sigtrap() continues to execute
and triggers WARN_ON_ONCE(event->ctx->task != current).

Since both task exit and exec paths can call perf_event_exit_task() which
sets ctx->task to TASK_TOMBSTONE, fix this by explicitly checking if
event->ctx->task equals TASK_TOMBSTONE and dropping the redundant
PF_EXITING check.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
---
v1 -> v2:
- Drop the redundant PF_EXITING check and only check for TASK_TOMBSTONE.
- Update the code comment to reflect this unified exec/exit race protection.
---
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe33fe15689d..8f4b61a135e8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7616,9 +7616,11 @@ static void perf_sigtrap(struct perf_event *event)
 {
 	/*
 	 * Both perf_pending_task() and perf_pending_irq() can race with the
-	 * task exiting.
+	 * task exiting or exec-ing. We can determine if such a race has
+	 * occurred by checking if perf_event_exit_task(), which will set
+	 * ctx->task to TASK_TOMBSTONE, has already been called.
 	 */
-	if (current->flags & PF_EXITING)
+	if (event->ctx->task == TASK_TOMBSTONE)
 		return;
 
 	/*
-- 
2.34.1

