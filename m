Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661B1C84AB;
	Thu, 16 Apr 2026 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308926; cv=none; b=fqGhVqHVtdd/8o7mC9h1suB6JVzGEekSMze+Uh0ccFbyBVmenkQnd7yHnogzy8IacZjwBXGTdbQ+9zTKLssBUe8CmvIH28R9JiXBB4KoELZQm21996c5+lfqY65w5e3uimYTUjb4VauIqAbCuV/2Q2giiKxqF/y2QvYpVGAAp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308926; c=relaxed/simple;
	bh=+eMmYoc43mZN1cskmw2Qk3r3jda5ooUzLxuQ6pKbQSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Khc4frq98jRVR4SqEDMWLKbhs7kyRjTzqm8ZJAZYRS5G+0tTswEPZpE0VeVqd7pDR/hgdbFsYShzB7Rnnx7dsWQfYX+CdCAAfBOPFrtzw83HcHFs8+ABvN9dJ6IdKiUeB2AA6pWMkxdAggV6JG11bykLD1C7c2+IgZOXnoMqdNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zaiRqOVT; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zaiRqOVT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DXWV+0Q+J0decG6Kzcc/vZ96Yy+u5VrWmMLp0yvHQVM=;
	b=zaiRqOVTyWm3cu87ldXhlirnQh1Xua11zQjEc+Ee6lp0T9UD13YfZJuEY5jTfDBRtpmEMiMNt
	sUDc+qIyiCwGHf78FG4kQPwl8fkI9CaRXpqLotkHPpc7NvNSbqig7QcPWjN6CI6KTczGhB/aB5c
	NTeHrxBg9aHDSNcWNEDP0LY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fx2qY0ybGzRhV0;
	Thu, 16 Apr 2026 11:02:17 +0800 (CST)
Received: from kwepemj100017.china.huawei.com (unknown [7.202.194.11])
	by mail.maildlp.com (Postfix) with ESMTPS id E161A40574;
	Thu, 16 Apr 2026 11:08:35 +0800 (CST)
Received: from huawei.com (10.67.174.193) by kwepemj100017.china.huawei.com
 (7.202.194.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Apr
 2026 11:08:35 +0800
From: Luo Gengkun <luogengkun2@huawei.com>
To: <peterz@infradead.org>
CC: <mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<james.clark@linaro.org>, <elver@google.com>, <dvyukov@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf/core: Fix race between perf_event_exit_task and perf_pending_task
Date: Thu, 16 Apr 2026 03:34:43 +0000
Message-ID: <20260416033443.1492483-1-luogengkun2@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100017.china.huawei.com (7.202.194.11)

A race condition exists between perf_event_exit_task() and perf_pending_task().

During begin_new_exec(), perf_event_exit_task() may be called, and the
PF_EXITING flag is not set on task. so perf_sigtrap() continues to execute
and triggers WARN_ON_ONCE(event->ctx->task != current).

To fix this problem, also check if the event->ctx->task is TASK_TOMBSTONE.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f5699b339ec..3422900263fa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7543,7 +7543,7 @@ static void perf_sigtrap(struct perf_event *event)
 	 * Both perf_pending_task() and perf_pending_irq() can race with the
 	 * task exiting.
 	 */
-	if (current->flags & PF_EXITING)
+	if (current->flags & PF_EXITING || event->ctx->task == TASK_TOMBSTONE)
 		return;
 
 	/*
-- 
2.34.1

