Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3032D7F8;
	Thu,  7 May 2026 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135865; cv=none; b=XALc8cAN3qT5T4m/hPGBgd7mSpSFPA2Vr4AU9U1EHONUH0yiKUVriSOcT4fUxPsYhOQ8ovzYnLQAsRFZmcFW9PoDhq6HhRlZkYVtBeHOTdGa3sPKbsov1Zxwp+wxCuSj258DFv4hCLh66KkLoyHQqOza75DJXqWqB/G0dQsEdZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135865; c=relaxed/simple;
	bh=oojAeG5H3pW9Ppnf1YNd2kT7A7Xa313INUdoqNbpIRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiuCbr+qt9U5h4ppqyGAWzHJqlja5cFpChVsu+tm7KstAOkrjhOp8jqy4FIIKMdQg+JPdzeJd935Ue8HBAQBiDR6SNSMRfodzo1UVs+qSkc6egwstDo6/Tym1vlwHROI73EJB5r9v1Uv7fCXFrUCns3jodegSYqgSbQi0D2Muuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4T6e9NGJ; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4T6e9NGJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l16reIjru4M+K09e8ccjfVDCtpBwMJxYZ+RYe9nuL5g=;
	b=4T6e9NGJvAtkQ59NxHNjugt48JsLs2u8IcR5TDGTJmQx+KN2SNxSQKNVLzwlxZjD7Y0cj9ska
	Jd7Ps7aJ8jytyR16Jj+mLi5tri2L30Qzp3Q7L/i93Yu/PiSCUoHDdjUU2EHsd3L3tu5AEXWSB3j
	i4nhVRUFDcai3u8o77SGOxc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gB2SW0rnqzpSx4;
	Thu,  7 May 2026 14:30:51 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D152540576;
	Thu,  7 May 2026 14:37:41 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 14:37:41 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 14:37:40 +0800
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
Subject: [RFT PATCH v2 5/7] perf-iostat: Extend iostat interface to support different iostat PMUs
Date: Thu, 7 May 2026 14:37:35 +0800
Message-ID: <20260507063737.3542950-6-wangyushan12@huawei.com>
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
Co-developed-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 tools/perf/util/iostat.c | 88 ++++++++++++++++++++++++++++++----------
 tools/perf/util/iostat.h | 38 ++++++++++++++++-
 2 files changed, 102 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
index a68ab100780d..90607d1cf3fa 100644
--- a/tools/perf/util/iostat.c
+++ b/tools/perf/util/iostat.c
@@ -1,47 +1,91 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/iostat.h"
-#include "util/debug.h"
+
+/*
+ * Below iostat_* function calls are scattered through out perf stat process,
+ * allowing multiple iostat PMUs and iterated them in following functions may
+ * violate calling conventions or cause incorrect display.
+ *
+ * Default to register the first PMU device that matches any of the specified
+ * iostat pmu name wildcards.
+ */
+static struct iostat_pmu *iostat_pmu;
 
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
 {
-	return -1;
+	if (!iostat_pmu)
+		return -1;
+
+	return iostat_pmu->parse(opt, str, unset);
 }
 
-__weak int iostat_parse(const struct option *opt __maybe_unused,
-			 const char *str __maybe_unused,
-			 int unset __maybe_unused)
+__weak void iostat_list(struct evlist *evlist, struct perf_stat_config *config)
 {
-	pr_err("iostat mode is not supported on current platform\n");
-	return -1;
+	iostat_pmu->list(evlist, config);
 }
 
-__weak void iostat_list(struct evlist *evlist __maybe_unused,
-		       struct perf_stat_config *config __maybe_unused)
+__weak void iostat_release(struct evlist *evlist)
 {
+	iostat_pmu->release(evlist);
 }
 
-__weak void iostat_release(struct evlist *evlist __maybe_unused)
+__weak void iostat_print_header_prefix(struct perf_stat_config *config)
 {
+	iostat_pmu->print_header_prefix(config);
 }
 
-__weak void iostat_print_header_prefix(struct perf_stat_config *config __maybe_unused)
+__weak void iostat_print_metric(struct perf_stat_config *config,
+				struct evsel *evsel,
+				struct perf_stat_output_ctx *out)
 {
+	iostat_pmu->print_metric(config, evsel, out);
 }
 
-__weak void iostat_print_metric(struct perf_stat_config *config __maybe_unused,
-				struct evsel *evsel __maybe_unused,
-				struct perf_stat_output_ctx *out __maybe_unused)
+__weak void iostat_print_counters(struct evlist *evlist,
+				  struct perf_stat_config *config,
+				  struct timespec *ts, char *prefix,
+				  iostat_print_counter_t print_cnt_cb,
+				  void *arg)
 {
+	iostat_pmu->print_counters(evlist, config, ts, prefix,
+				   print_cnt_cb, arg);
+}
+
+void register_iostat_pmu(struct iostat_pmu *pmu)
+{
+	if (!pmu || !pmu->match)
+		return;
+
+	if (iostat_pmu || !pmu->match(pmu))
+		return;
+
+	iostat_pmu = pmu;
+}
+
+static void unregister_iostat_pmu(void)
+{
+	if (!iostat_pmu)
+		return;
+
+	/*
+	 * Release function of iostat_pmu is called on the exit of cmd_stat, we
+	 * don't need to call release function here.
+	 */
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
index 820930a096d9..5cc8963c6122 100644
--- a/tools/perf/util/iostat.h
+++ b/tools/perf/util/iostat.h
@@ -10,6 +10,7 @@
 #ifndef _IOSTAT_H
 #define _IOSTAT_H
 
+#include <stdbool.h>
 #include <subcmd/parse-options.h>
 #include "util/stat.h"
 #include "util/parse-events.h"
@@ -31,8 +32,7 @@ extern enum iostat_mode_t iostat_mode;
 typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, void *);
 
 int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config);
-int iostat_parse(const struct option *opt, const char *str,
-		 int unset __maybe_unused);
+int iostat_parse(const struct option *opt, const char *str, int unset);
 void iostat_list(struct evlist *evlist, struct perf_stat_config *config);
 void iostat_release(struct evlist *evlist);
 void iostat_print_header_prefix(struct perf_stat_config *config);
@@ -42,4 +42,38 @@ void iostat_print_counters(struct evlist *evlist,
 			   struct perf_stat_config *config, struct timespec *ts,
 			   char *prefix, iostat_print_counter_t print_cnt_cb, void *arg);
 
+/**
+ * struct iostat_pmu - Callbacks for an iostat-capable PMU backend.
+ * @pmu_name_wildcard: Glob pattern to identify the PMU (e.g. "uncore_iio*").
+ * @match: Detect whether matching PMUs exist on this system.
+ * @prepare: Set up events and config for iostat collection.
+ * @parse: Parse the --iostat option argument.
+ * @list: Display available iostat PMU instances.
+ * @print_header_prefix: Print the column header prefix.
+ * @print_metric: Format and print one metric value.
+ * @print_counters:  Iterate over counters and print per-port results.
+ * @release: Clean up PMU-specific resources.
+ */
+struct iostat_pmu {
+	const char *pmu_name_wildcard;
+	bool (*match)(struct iostat_pmu *iostat_pmu);
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
+/*
+ * Register an iostat PMU handler. Called from __attribute__((constructor))
+ * functions in each backend's translation unit.
+ *
+ * Only the first matched backend is activated.
+ */
+void register_iostat_pmu(struct iostat_pmu *iostat_pmu);
 #endif /* _IOSTAT_H */
-- 
2.33.0

