Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19370539794;
	Tue, 13 Oct 2026 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917790; cv=none; b=nqbNU+o9hMRgJ5lIXGiSxTczPDWoulvWCU8rreTvTL7bDoo19v6XdrbWCs7kEzBupxvrEUPLPTBsVDHEZUN3kM7K95AZKrhok0hALs4DWYXpx7PPMKZis3Al0m2WyEub+ytTSrmgSvx8JZH2DSMjKiaOSZ09ssoP3HjIHmDep6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917790; c=relaxed/simple;
	bh=G8Bo676GjGbnxg3GgpCYH6crRYBMGKMJ80OZj8r4qRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRJb5te6RejoPMPHn8yw7TePWBSp9nmv0kFJdikFUocdhQRZd2uh9jTjgW4wpR2VJS/0jkw/RJCkJJsplPCEqICAJoKFam3ypjG7VWgPDiqLirrFk1fGd8LMWu3flcpXSqY95F0IuxriHNdNgQN0gcRpI5Xq8XW7hxcfpZf5mYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=N0CVUyQL; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="N0CVUyQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1791917789; x=1823453789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9XJ+kKwmeQYzrH/jGKEqsuhyI3KMPbf2VdFFRgwHRao=;
  b=N0CVUyQLF7mpOyquyDxj71FyZJBICNETJJlW6Z/ZGhoKJX4y0ytjamkW
   4qffN16V9ib1lrySM2HfwFoBPF5TjQGs5Jobkm79e+fkBQkzr3UvUFOI9
   TIe8ncCq6ZoiAcGsGy90JHC1n4Pi7Z/x6qvU3yiqc+palEmRjRMCfOV8R
   eOCIv0EO+8tFynG+sckMTnidwN/9NBV3IUvpcOCQqolkx/8efd2RbpGOM
   aFVSdEZ2QxFwWbgzLaXnK+DEcAURgT1Igy8/FynD99S5kO4W8WjRPjra3
   MCRLIbH0iucpKJM5nalEOS4lUSRI6tQKdYwdEmC05I/Bl2sqwziOCHMk2
   Q==;
X-CSE-ConnectionGUID: j0FygOHfSyS4sq5lD7S3UQ==
X-CSE-MsgGUID: tU/+8qrKTEa8p78Z7htO3A==
X-IronPort-AV: E=Sophos;i="6.27,156,1787011200"; 
   d="scan'208";a="30957098"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 18:56:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:24547]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.46:2525] with esmtp (Farcaster)
 id 0a7120f2-3207-4601-8dac-c72bc561f46d; Tue, 13 Oct 2026 18:56:28 +0000 (UTC)
X-Farcaster-Flow-ID: 0a7120f2-3207-4601-8dac-c72bc561f46d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 18:56:27 +0000
Received: from u34cccd802f2d52.amazon.com (10.187.170.30) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 18:56:26 +0000
From: Haris Okanovic <harisokn@amazon.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <harisokn@amazon.com>
Subject: [PATCH 1/4] perf/core: Fix perf_pmu_migrate_context() leaving events behind
Date: Tue, 13 Oct 2026 13:56:00 -0500
Message-ID: <20261013185603.1347265-2-harisokn@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013185603.1347265-1-harisokn@amazon.com>
References: <20261013185603.1347265-1-harisokn@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

__perf_pmu_remove() walks the group leaders of a CPU and PMU with
perf_event_groups_for_cpu_pmu(), removing each one as it goes.
perf_remove_from_context() takes the leader out of the groups rbtree,
after which rb_next() on that node returns NULL, prematurely ending the
walk. Other groups stay behind in the source context.

On CPU hotplug, they are then torn down with the dying CPU. They keep
running until teardown, while the PMU's interrupt and migrated events
are on a new CPU, which drivers rely on never happening.

Walk ctx->event_list instead and pick out the PMU's events by their
pmu_ctx.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Haris Okanovic <harisokn@amazon.com>
---
 kernel/events/core.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7846d70be57f6..7caba4d528301 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14394,23 +14394,18 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 }
 EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
 
-static void __perf_pmu_remove(struct perf_event_context *ctx,
-			      int cpu, struct pmu *pmu,
-			      struct perf_event_groups *groups,
+static void __perf_pmu_remove(struct perf_event_context *ctx, struct pmu *pmu,
 			      struct list_head *events)
 {
-	struct perf_event *event, *sibling;
+	struct perf_event *event, *tmp;
+
+	list_for_each_entry_safe(event, tmp, &ctx->event_list, event_entry) {
+		if (event->pmu_ctx->pmu != pmu)
+			continue;
 
-	perf_event_groups_for_cpu_pmu(event, groups, cpu, pmu) {
 		perf_remove_from_context(event, 0);
 		put_pmu_ctx(event->pmu_ctx);
 		list_add(&event->migrate_entry, events);
-
-		for_each_sibling_event(sibling, event) {
-			perf_remove_from_context(sibling, 0);
-			put_pmu_ctx(sibling->pmu_ctx);
-			list_add(&sibling->migrate_entry, events);
-		}
 	}
 }
 
@@ -14486,8 +14481,7 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 	 */
 	mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);
 
-	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_ctx->pinned_groups, &events);
-	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_ctx->flexible_groups, &events);
+	__perf_pmu_remove(src_ctx, pmu, &events);
 
 	if (!list_empty(&events)) {
 		/*
-- 
Haris Okanovic
AWS Graviton

