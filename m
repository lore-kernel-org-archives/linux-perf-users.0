Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACB9C7EE2C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbjEXWS7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbjEXWSt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:18:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F191A4
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:18:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb51cb4d4so2857487276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966726; x=1687558726;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFns1xCRwQs2VyvHbQeG+YbR09DfXce+1D3kwfuUbnc=;
        b=QBr9lERJqVOyRESMrYuu86b2CdwP8E37LjcND2+YwAsaaYAwrXeS6BLSwafdlxK582
         1YgxVxE51wwGv+MrZUjxItnJYOoIch1+Hlf6+GWfUCygqxEYKJb0b6v2CmDirxj7b9Hd
         n8C/uLbNhq+0WIAbhLhQFfHXsXpmEbPkjb1vT8dIUiHCSRIDv4IPgal067zwTt2CVv2d
         s+gLhZ4BMoZRaUTH8XNILpUOZ32qsYcQ1OWhL/TY/AarkNrfQZd8TOCMXSJ4miuSHTEM
         amZTsMRWpEHsvCOU+gQ2sgWYxcJ3Mj9CQShfjDTOBP/+eisezlXKsDvNsi13BI79bD4Q
         dX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966726; x=1687558726;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFns1xCRwQs2VyvHbQeG+YbR09DfXce+1D3kwfuUbnc=;
        b=G9eONqeQZ3k4qv9qcW9BtLdQYeKiGDzsGNLTxdo4VEFHwArM+apRbuVuSzRxfVNFKs
         mfqzrUDZktUtJYX7tScqAYU3mdD+tflLyzp4ALGYWCuaclFbB0p/mHcnUsvq5v5SgYau
         m4noPMJgTREK4hY36BeFqhYWXaRtPe5X5b8J1ikMAUTKGpjmzuGl9Egj6JVlMCI063fz
         Uh6WgVBgm48s+aX2y6/nwloTGAZlmwBNdhPVEHptRAADPsgyu8hR6glT07x0Djxdshak
         pr+6fCEDGDR1gbwv7PHcLgp06thQwssjmyhtqkGzm+eThYliDMI2PqZ7s7D1gzIV6ugW
         MBjQ==
X-Gm-Message-State: AC+VfDxJEWeHWZIDK8NGfV80Y3ipNrdF419AS9tKMG06eUa8vcXnyW+P
        8fXRQl63b0IDxoiEGTEvo9eSUkfcs4WD
X-Google-Smtp-Source: ACHHUZ5LWVtjDgkHe3VGgp6svl3iqUT5s26of6Cnt+3BMjpCYvoth9HVqtVzYx+uGVMnna+JIgbHZhIaupNd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:5285:0:b0:ba8:8d92:caea with SMTP id
 g127-20020a255285000000b00ba88d92caeamr579597ybb.1.1684966726491; Wed, 24 May
 2023 15:18:46 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:01 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-6-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 05/35] perf pmu: Detect ARM and hybrid PMUs with sysfs
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

is_arm_pmu_core detects a core PMU via the presence of a "cpus" file
rather than a "cpumask" file. This pattern holds for hybrid PMUs so
rename the function and remove redundant perf_pmu__is_hybrid
tests.

Add a new helper is_pmu_hybrid similar to is_pmu_core.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 29 ++++++++++++++++++-----------
 tools/perf/util/pmu.h |  1 +
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f4f0afbc391c..7392cec725bf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -643,12 +643,14 @@ static char *pmu_id(const char *name)
 	return str;
 }
 
-/*
- *  PMU CORE devices have different name other than cpu in sysfs on some
- *  platforms.
- *  Looking for possible sysfs files to identify the arm core device.
+/**
+ * is_sysfs_pmu_core() - PMU CORE devices have different name other than cpu in
+ *         sysfs on some platforms like ARM or Intel hybrid. Looking for
+ *         possible the cpus file in sysfs files to identify whether this is a
+ *         core device.
+ * @name: The PMU name such as "cpu_atom".
  */
-static int is_arm_pmu_core(const char *name)
+static int is_sysfs_pmu_core(const char *name)
 {
 	char path[PATH_MAX];
 
@@ -814,7 +816,7 @@ void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
 	struct pmu_add_cpu_aliases_map_data data = {
 		.head = head,
 		.name = pmu->name,
-		.cpu_name = is_arm_pmu_core(pmu->name) ? pmu->name : "cpu",
+		.cpu_name = is_sysfs_pmu_core(pmu->name) ? pmu->name : "cpu",
 		.pmu = pmu,
 	};
 
@@ -1647,22 +1649,27 @@ static int cmp_sevent(const void *a, const void *b)
 
 bool is_pmu_core(const char *name)
 {
-	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
+	return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
+}
+
+bool is_pmu_hybrid(const char *name)
+{
+	return !strcmp(name, "cpu_atom") || !strcmp(name, "cpu_core");
 }
 
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+	return is_pmu_core(pmu->name);
 }
 
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+	return is_pmu_core(pmu->name);
 }
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 {
-	return !perf_pmu__is_hybrid(pmu->name);
+	return !is_pmu_hybrid(pmu->name);
 }
 
 static bool pmu_alias_is_duplicate(struct sevent *alias_a,
@@ -1716,7 +1723,7 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		bool is_cpu = is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+		bool is_cpu = is_pmu_core(pmu->name);
 
 		list_for_each_entry(event, &pmu->aliases, list) {
 			aliases[j].event = event;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 0e0cb6283594..f50919f1b34c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -220,6 +220,7 @@ void perf_pmu__del_formats(struct list_head *formats);
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
 bool is_pmu_core(const char *name);
+bool is_pmu_hybrid(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
-- 
2.40.1.698.g37aff9b760-goog

