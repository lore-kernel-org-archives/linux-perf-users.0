Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480B33CEBB;
	Thu,  7 May 2026 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135864; cv=none; b=gpZX788+MiwmpFW0Pdoug911W+uE9ZFiLtR1rOfql9T30YI6nJZ2ohD3YPlu0q75XoZHmAMN3IYQXa2/zr4fnurkI8d1uh+uwFeIg1QftJh+ZLmNRflmRFEU0b/TJdyCSWDXxV7Wg6uUztCA1m5Al59xcEmh91H7j10WPjifcAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135864; c=relaxed/simple;
	bh=nfa03i+Qj4pJ1N+xjnYP3nk1MAeudgQ/KvyaeooiSvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwBEMAEJCSwJ9JiK4gpQZNirIrzmVsbyNu3Z5WKaSnKqUajjsQwdpsLPnsel2hXtJRWI3M0LXSdIz0t/Ecw/U0WyNzJOy5Nf8LgQxmVth6qVIaZ7gGerG+cZQHplomDceUr6+PCT+EwMBnDCL1RIPJpsgMPFQIdePefJhQFYNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QAaXfvgf; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QAaXfvgf"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tavSIncRGrNJHQl5vLDBA/vQ3CjL1RwZuizxVlTGWb4=;
	b=QAaXfvgfLZBcV5BuOemObCVuRQ+f+oq8VPQg5mps2gajMvSf9mdtLduIsVnJfz+o4v/Nr1phE
	AUWDc1lq1tm8/oggeKyIt97d0NaMkNg9NlRQsqwuswGsrdWXu2kCj5/gkZjoB+3gE9yelqv/2rZ
	vdelzoC3s8JiXrWP6eVM0JM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gB2SS3HJYzpT04;
	Thu,  7 May 2026 14:30:48 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 310A020226;
	Thu,  7 May 2026 14:37:39 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 14:37:38 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 14:37:38 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <mike.leach@arm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <jic23@kernel.org>, <leo.yan@linux.dev>, <robin.murphy@arm.com>,
	<linuxarm@huawei.com>, <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RFT PATCH v2 1/7] perf stat: Check color's length instead of the pointer
Date: Thu, 7 May 2026 14:37:31 +0800
Message-ID: <20260507063737.3542950-2-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260507063737.3542950-1-wangyushan12@huawei.com>
References: <20260507063737.3542950-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)

Color string returned by metric_threshold_classify__color() is never
NULL, check the presence of *color will always return true.

Fix this by change the checks against length of *color.

Fixes: 37b77ae95416 ("perf stat: Change color to threshold in print_metric")
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 tools/perf/builtin-script.c    | 2 +-
 tools/perf/util/stat-display.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c8ac9f01a36b..58cd5cd377a6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2111,7 +2111,7 @@ static void script_print_metric(struct perf_stat_config *config __maybe_unused,
 	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx->evsel,
 				   PERF_RECORD_SAMPLE, mctx->fp);
 	fputs("\tmetric: ", mctx->fp);
-	if (color)
+	if (strlen(color))
 		color_fprintf(mctx->fp, color, fmt, val);
 	else
 		printf(fmt, val);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 993f4c4b8f44..74cba80c24b0 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -474,7 +474,7 @@ static void print_metric_std(struct perf_stat_config *config,
 		do_new_line_std(config, os);
 
 	n = fprintf(out, " # ");
-	if (color)
+	if (strlen(color))
 		n += color_fprintf(out, color, fmt, val);
 	else
 		n += fprintf(out, fmt, val);
@@ -607,7 +607,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	if (mlen < strlen(unit))
 		mlen = strlen(unit) + 1;
 
-	if (color)
+	if (strlen(color))
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
 	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
-- 
2.33.0

