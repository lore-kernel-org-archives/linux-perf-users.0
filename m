Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B379F6
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730166834; cv=none; b=iWmr5K5cSCek5gQ6CksEE8Y3F1Wkj3JhP1p7EXBalFDV01lKEf5bR/9A1VH7+oWaQfrOq4Xj87rKNbF8D//YtliOS30yYlwHDGTwLjck/6TBKB2NWp4JTZWxnCjR4oUh2drBb0l3qDncfo59LEvk4hZ0VUGfPTvNmJmdlbpKPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730166834; c=relaxed/simple;
	bh=nBMT5o4bs6JM1Oy8hIrwLJ67l2vZ1JDr9zJ4I3mz3Tg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q3fOA7IOVMWyQEumPSZZi35JiLftQdEBDz4SyaF2LRkad16WBEeKSwoFwYu0Zzu3jre9wt1A0shs2G0qH5A4NUkOEt3Q+KVwMUZH++j6i9oD6gOt1IkhRYzELB+LLx91TH20v8uLjZAAqA3U4PSyuZnFT9OykOsR29CVQR0uWvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XctYv0nQjz20r52;
	Tue, 29 Oct 2024 09:52:51 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id E500314013B;
	Tue, 29 Oct 2024 09:53:48 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 29 Oct 2024 09:53:48 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<ravi.bangoria@amd.com>, <cuigaosheng1@huawei.com>, <wangweiyang2@huawei.com>
CC: <linux-perf-users@vger.kernel.org>
Subject: [PATCH -next] perf: Fix possible null-ptr-deref in __perf_pmu_install_event()
Date: Tue, 29 Oct 2024 09:53:47 +0800
Message-ID: <20241029015347.476375-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The function find_get_pmu_context() returns ERR_PTR(-ENOMEM) if kzalloc()
fails. It is crucial to verify its return value before dereferencing
it to avoid a potential nullptr dereference.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index afada11ffb9f..4ff45e320314 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13177,6 +13177,10 @@ static void __perf_pmu_install_event(struct pmu *pmu,
 
 	event->cpu = cpu;
 	epc = find_get_pmu_context(pmu, ctx, event);
+	if (IS_ERR(epc)) {
+		put_ctx(ctx);
+		return;
+	}
 	event->pmu_ctx = epc;
 
 	if (event->state >= PERF_EVENT_STATE_OFF)
-- 
2.25.1

