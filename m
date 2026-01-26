Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D3328616
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430925; cv=none; b=gwe7rWmOvpv1RguvdUEBkwXaN61TGWtSTB0hKuGjPzOVcG0vRjSVN3g0jREIp1LRmBNIss7ze4QLukzJUMCkxn32G8uHGfOfpgXq/+AVv/NCi7ii7WGCHDd6kDQS6Cg6xuRnaVdnng0jRf/i+xzDTOqEGfWNdpS+r6KvfzE/61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430925; c=relaxed/simple;
	bh=sqNtnjsEJkNfUxo4qisWMP5+H80tLYVCTbfDM2Fq19U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qczrieEW1SwSEw8NAZPyW/CFD+dKNVtpG9qjg+K7CSqi+QX06LZQqIBnYJl76OY3llcmU2mp1w8hOeaCIFbhU9yqdLpAmc2e3euEFIw7vlazkORghvii0qZehWKu1z//LwSPnrNz8KoDpAyhPVqT898a5eHl9xucP25q1PSCn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YR4trii4; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YR4trii4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mQBIvjZPRygTR+KqidewsTuGin+HJsCKVIPd1KjVIv0=;
	b=YR4trii41UjRp+hs+BFiXHfQNNonqCtHAwn34cDsQRio80ag4k/VDEsKddOGCLLvpLdFl43iO
	A7uPm1TNpWQD4Y8BOhf/r2fnhKk7ivLI7kjH2xcCx4n3IpgJZNvbi3wBlV1yM1NvCCXYkJFNKRq
	FIyYYkrzK4zA4mVo2XcRnfE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4f07F81NZLz12LKh;
	Mon, 26 Jan 2026 20:31:24 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 895FD2016A;
	Mon, 26 Jan 2026 20:35:19 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Jan 2026 20:35:19 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 26 Jan 2026 20:35:18 +0800
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
Subject: [RFT PATCH 4/7] perf-iostat: Extend iostat interface to support different iostat PMUs
Date: Mon, 26 Jan 2026 20:35:11 +0800
Message-ID: <20260126123514.3238425-5-wangyushan12@huawei.com>
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

From: Shiju Jose <shiju.jose@huawei.com>

Currently, platform-specific iostat code for PMUs is implemented as a
common iostat callback interface and linked during build. This approach
limits support for iostat across different implementations of PMU of the
same architecture.

To address this, extend common iostat interface to provide support for
different PMUs by allowing each PMU to register itself and receive
callbacks to its PMU-specific functions through the unified iostat
framework.

Signed-off-by: Shiju Jose  <shiju.jose@huawei.com>
Signed-off-by: Yushan Wang <wangyushan@huawei.com>
---
 tools/perf/util/iostat.c | 78 ++++++++++++++++++++++++++++------------
 tools/perf/util/iostat.h | 19 ++++++++--
 2 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
index a68ab100780d..84ab92d8f0b3 100644
--- a/tools/perf/util/iostat.c
+++ b/tools/perf/util/iostat.c
@@ -1,47 +1,81 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/iostat.h"
-#include "util/debug.h"
+
+static struct iostat_pmu_list *iostat_pmu;
 
 enum iostat_mode_t iostat_mode = IOSTAT_NONE;
 
-__weak int iostat_prepare(struct evlist *evlist __maybe_unused,
-			  struct perf_stat_config *config __maybe_unused)
+__weak int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config)
+{
+	if (!iostat_pmu)
+		return -1;
+
+	return iostat_pmu->prepare(evlist, config);
+}
+
+__weak int iostat_parse(const struct option *opt, const char *str, int unset)
+{
+	if (!iostat_pmu)
+		return -1;
+
+	return iostat_pmu->parse(opt, str, unset);
+}
+
+__weak void iostat_list(struct evlist *evlist, struct perf_stat_config *config)
+{
+	iostat_pmu->list(evlist, config);
+}
+
+__weak void iostat_release(struct evlist *evlist)
 {
-	return -1;
+	iostat_pmu->release(evlist);
 }
 
-__weak int iostat_parse(const struct option *opt __maybe_unused,
-			 const char *str __maybe_unused,
-			 int unset __maybe_unused)
+__weak void iostat_print_header_prefix(struct perf_stat_config *config)
 {
-	pr_err("iostat mode is not supported on current platform\n");
-	return -1;
+	iostat_pmu->print_header_prefix(config);
 }
 
-__weak void iostat_list(struct evlist *evlist __maybe_unused,
-		       struct perf_stat_config *config __maybe_unused)
+__weak void iostat_print_metric(struct perf_stat_config *config,
+				struct evsel *evsel,
+				struct perf_stat_output_ctx *out)
 {
+	iostat_pmu->print_metric(config, evsel, out);
 }
 
-__weak void iostat_release(struct evlist *evlist __maybe_unused)
+__weak void iostat_print_counters(struct evlist *evlist,
+				  struct perf_stat_config *config,
+				  struct timespec *ts, char *prefix,
+				  iostat_print_counter_t print_cnt_cb,
+				  void *arg)
 {
+	iostat_pmu->print_counters(evlist, config, ts, prefix,
+				   print_cnt_cb, arg);
 }
 
-__weak void iostat_print_header_prefix(struct perf_stat_config *config __maybe_unused)
+int register_iostat_pmu(struct iostat_pmu_list *pmu)
 {
+	if (!pmu || !pmu->probe)
+		return -1;
+
+	if (pmu->probe(pmu))
+		return 0;
+
+	iostat_pmu = pmu;
+
+	return 0;
 }
 
-__weak void iostat_print_metric(struct perf_stat_config *config __maybe_unused,
-				struct evsel *evsel __maybe_unused,
-				struct perf_stat_output_ctx *out __maybe_unused)
+static void unregister_iostat_pmu(void)
 {
+	if (!iostat_pmu)
+		return;
+
+	iostat_pmu = NULL;
 }
 
-__weak void iostat_print_counters(struct evlist *evlist __maybe_unused,
-				  struct perf_stat_config *config __maybe_unused,
-				  struct timespec *ts __maybe_unused,
-				  char *prefix __maybe_unused,
-				  iostat_print_counter_t print_cnt_cb __maybe_unused,
-				  void *arg __maybe_unused)
+__attribute__((destructor))
+static void iostat_exit(void)
 {
+	unregister_iostat_pmu();
 }
diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
index 820930a096d9..58225542e49d 100644
--- a/tools/perf/util/iostat.h
+++ b/tools/perf/util/iostat.h
@@ -31,8 +31,7 @@ extern enum iostat_mode_t iostat_mode;
 typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, void *);
 
 int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config);
-int iostat_parse(const struct option *opt, const char *str,
-		 int unset __maybe_unused);
+int iostat_parse(const struct option *opt, const char *str, int unset);
 void iostat_list(struct evlist *evlist, struct perf_stat_config *config);
 void iostat_release(struct evlist *evlist);
 void iostat_print_header_prefix(struct perf_stat_config *config);
@@ -42,4 +41,20 @@ void iostat_print_counters(struct evlist *evlist,
 			   struct perf_stat_config *config, struct timespec *ts,
 			   char *prefix, iostat_print_counter_t print_cnt_cb, void *arg);
 
+struct iostat_pmu_list {
+	const char *pmu_name;
+	int (*probe)(struct iostat_pmu_list *iostat_pmu);
+	int (*prepare)(struct evlist *evlist, struct perf_stat_config *config);
+	int (*parse)(const struct option *opt, const char *str, int unset);
+	void (*list)(struct evlist *evlist, struct perf_stat_config *config);
+	void (*print_header_prefix)(struct perf_stat_config *config);
+	void (*print_metric)(struct perf_stat_config *config, struct evsel *evsel,
+			     struct perf_stat_output_ctx *out);
+	void (*print_counters)(struct evlist *evlist,
+			       struct perf_stat_config *config, struct timespec *ts,
+			       char *prefix, iostat_print_counter_t print_cnt_cb, void *arg);
+	void (*release)(struct evlist *evlist __maybe_unused);
+};
+
+int register_iostat_pmu(struct iostat_pmu_list *iostat_pmu);
 #endif /* _IOSTAT_H */
-- 
2.33.0

