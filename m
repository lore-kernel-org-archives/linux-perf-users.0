Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DB304BBC
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430923; cv=none; b=WFomojP8LOzcFej8jW9vrAOQJ6JsPDmlYbQWAYwRdmFyairhIzQ9xYhIiHZjyPAepyepWJTVon1UX3544Ka2xKUl4ykle+1K0eRkObgAabN/FAORwVHnywiw0wFUUSjbndnsPzBzBJTdp7PrMZPHKxrtqqxgQXdY/2Wspwe6OdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430923; c=relaxed/simple;
	bh=OfCEegRK+0wqNv3PqM/R41lMaXxUJIWi5jk/y/NMt/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRwcz9Ir9jVu0N0FCmuuPUf2C8FzGfjn0d1TjAwmkcLwMDh3JuqJs9v2Q8favHgBqXiEisXQx2SSosodtp1lDMRV43zBihTVdrdoEkRZPp1jmodbC6na5SkXaI86fhBSTGSFoWBV/kdcmkIoHuo72y8YMcTZh4m5ARtI57oe6Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PcLFxT4B; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PcLFxT4B"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Rh7I96I1Ye56LgCNCTflwomet+0JXYgpPPw8AKqRQrY=;
	b=PcLFxT4BZfMrO4YwTr9I1st2Bw+UPdUyFjLgMqwsMUdByDNkY2wiDFrfB2lD7rVFPMYpdqfY2
	19E6751n77Fo8boc6i1fSgEz/XGU9p+x9Rh90RQDPOJrrwLNODsJ1KJQmv6iBg/GC8PsiaaMct/
	0EwnkU1645kK7Qmp3uXOjT8=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4f07Dt5sYszcb29;
	Mon, 26 Jan 2026 20:31:10 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5381C4056A;
	Mon, 26 Jan 2026 20:35:17 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Jan 2026 20:35:17 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 26 Jan 2026 20:35:16 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <mike.leach@linaro.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <peterz@infradead.org>,
	<john.g.garry@oracle.com>, <Jonathan.Cameron@huawei.com>,
	<shiju.jose@huawei.com>, <will@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <liuyonglong@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RFT PATCH 1/7] perf stat: Check color's length instead of the pointer
Date: Mon, 26 Jan 2026 20:35:08 +0800
Message-ID: <20260126123514.3238425-2-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260126123514.3238425-1-wangyushan12@huawei.com>
References: <20260126123514.3238425-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
index 62e43d3c5ad7..9fe90f564c69 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2100,7 +2100,7 @@ static void script_print_metric(struct perf_stat_config *config __maybe_unused,
 	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx->evsel,
 				   PERF_RECORD_SAMPLE, mctx->fp);
 	fputs("\tmetric: ", mctx->fp);
-	if (color)
+	if (strlen(color))
 		color_fprintf(mctx->fp, color, fmt, val);
 	else
 		printf(fmt, val);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6d02f84c5691..91c0c1020f4e 100644
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

