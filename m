Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A1C636CC
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 09:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjBSJjC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjBSJjB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 04:39:01 -0500
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF9AC653
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:38:10 -0800 (PST)
Received: by mail-yb1-f201.google.com with SMTP id k18-20020a25b292000000b0091231592671so22362ybj.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83ufvBpHVtY5n0dRrsyH94JHmCN6bDj+Te8NRRpOnv0=;
        b=lxWRJOz1YmAnLVIpr+fpP4VDEQycUyWETLBz0W+CvZOIA6Kr/CoxJ2NsHEn41bEINl
         xdOo4dSeb6JldrmmHx8t98bCU9i7l7fSaOmRZyGpziCtv6bpIJCU9iN0JcYU+NjDa2O+
         9XTFi0YHaXrGx64qq4FOlIRjg9uoMS8Ya2jorXHuAwkk2xbnSK++ZlozuUPqdODuJFKs
         6tKq8t5/yfeYhmVTyuQilkmzIWpSy5DP2e7xVmQeMyMJXwX8z5cUkxyl2CUbyclghtcG
         xaFP4bc1MAn1II2okkTepHrecIc0FvHgfZ29b/HmYpMob81nIptOTI3KNc6OhwmW2xc0
         LwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83ufvBpHVtY5n0dRrsyH94JHmCN6bDj+Te8NRRpOnv0=;
        b=tzCfeiZLARh2fhtu9FnV3hYY77PBb4yIVLjXqfyNntCxw38TialLiOz9hA2hjOMYGj
         9pjFCAK27XQCU5GSLkYcqdJNw4JLqgN4X5ZgJ58hgx5x1ts6Jqd0iBTSVC46uv9bWXlp
         FAiYD5/v0HdRvYDi843RT9LJAgVLB6Xw0ZGappuDaYNuSRbnWUXYDI4LKMHOK2+EeYZe
         qucLMYw31ndZGF/K+EqVyTBvPYS67eBizeHS/5RHxGCcJokkVXtlCXUKdZejI4Ck3olL
         YxOK2K2sMS40hIjm9PTwfs1ruxggsaausEPfKSXf8QYuprb6Hsw8KIRAMFWs5QBbuNP+
         93AA==
X-Gm-Message-State: AO0yUKW/tZlOc6qHs75fjHjaX4pSt0HxiK0gYQzG/0HK10Tt7XiYtiLa
        WFgka4NV4B7oHqg36ZCYIaIoJ04bd87r
X-Google-Smtp-Source: AK7set8t3rcgc5hL8cNAhis/P84/LQFLK5QsqBjIvZYGgI+BUkbIeJCgbTvi2p9zIdmfba0Vf3xefkV5CXYn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c6:b0:855:fdcb:4467 with SMTP
 id w6-20020a05690210c600b00855fdcb4467mr151684ybu.0.1676799302521; Sun, 19
 Feb 2023 01:35:02 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:40 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-44-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 43/51] perf stat: Remove hard coded transaction events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The metric group "transaction" is now present for Intel architectures
so the legacy hard coded approach won't be used. Remove the associated
logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 59 ++++++-----------------------------
 tools/perf/util/stat-shadow.c | 48 +---------------------------
 tools/perf/util/stat.c        |  4 ---
 tools/perf/util/stat.h        |  7 -----
 4 files changed, 11 insertions(+), 107 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bdb1ef4fc6ad..e6b60b058257 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -100,30 +100,6 @@
 
 static void print_counters(struct timespec *ts, int argc, const char **argv);
 
-/* Default events used for perf stat -T */
-static const char *transaction_attrs = {
-	"task-clock,"
-	"{"
-	"instructions,"
-	"cycles,"
-	"cpu/cycles-t/,"
-	"cpu/tx-start/,"
-	"cpu/el-start/,"
-	"cpu/cycles-ct/"
-	"}"
-};
-
-/* More limited version when the CPU does not have all events. */
-static const char * transaction_limited_attrs = {
-	"task-clock,"
-	"{"
-	"instructions,"
-	"cycles,"
-	"cpu/cycles-t/,"
-	"cpu/tx-start/"
-	"}"
-};
-
 static const char *smi_cost_attrs = {
 	"{"
 	"msr/aperf/,"
@@ -1811,37 +1787,22 @@ static int add_default_attributes(void)
 		return 0;
 
 	if (transaction_run) {
-		struct parse_events_error errinfo;
 		/* Handle -T as -M transaction. Once platform specific metrics
 		 * support has been added to the json files, all architectures
 		 * will use this approach. To determine transaction support
 		 * on an architecture test for such a metric name.
 		 */
-		if (metricgroup__has_metric("transaction")) {
-			return metricgroup__parse_groups(evsel_list, "transaction",
-							 stat_config.metric_no_group,
-							 stat_config.metric_no_merge,
-							 stat_config.metric_no_threshold,
-							 stat_config.user_requested_cpu_list,
-							 stat_config.system_wide,
-							 &stat_config.metric_events);
-		}
-
-		parse_events_error__init(&errinfo);
-		if (pmu_have_event("cpu", "cycles-ct") &&
-		    pmu_have_event("cpu", "el-start"))
-			err = parse_events(evsel_list, transaction_attrs,
-					   &errinfo);
-		else
-			err = parse_events(evsel_list,
-					   transaction_limited_attrs,
-					   &errinfo);
-		if (err) {
-			fprintf(stderr, "Cannot set up transaction events\n");
-			parse_events_error__print(&errinfo, transaction_attrs);
+		if (!metricgroup__has_metric("transaction")) {
+			pr_err("Missing transaction metrics");
+			return -1;
 		}
-		parse_events_error__exit(&errinfo);
-		return err ? -1 : 0;
+		return metricgroup__parse_groups(evsel_list, "transaction",
+						stat_config.metric_no_group,
+						stat_config.metric_no_merge,
+						stat_config.metric_no_threshold,
+						stat_config.user_requested_cpu_list,
+						stat_config.system_wide,
+						&stat_config.metric_events);
 	}
 
 	if (smi_cost) {
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 5189756bf16d..3cfe4b4eb3de 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -235,12 +235,6 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 		update_runtime_stat(st, STAT_NSECS, map_idx, count_ns, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, map_idx, count, &rsd);
-	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
-		update_runtime_stat(st, STAT_CYCLES_IN_TX, map_idx, count, &rsd);
-	else if (perf_stat_evsel__is(counter, TRANSACTION_START))
-		update_runtime_stat(st, STAT_TRANSACTION, map_idx, count, &rsd);
-	else if (perf_stat_evsel__is(counter, ELISION_START))
-		update_runtime_stat(st, STAT_ELISION, map_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
 				    map_idx, count, &rsd);
@@ -695,7 +689,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 {
 	void *ctxp = out->ctx;
 	print_metric_t print_metric = out->print_metric;
-	double total, ratio = 0.0, total2;
+	double total, ratio = 0.0;
 	struct runtime_stat_data rsd = {
 		.ctx = evsel_context(evsel),
 		.cgrp = evsel->cgrp,
@@ -808,46 +802,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		} else {
 			print_metric(config, ctxp, NULL, NULL, "Ghz", 0);
 		}
-	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, map_idx, &rsd);
-
-		if (total)
-			print_metric(config, ctxp, NULL,
-					"%7.2f%%", "transactional cycles",
-					100.0 * (avg / total));
-		else
-			print_metric(config, ctxp, NULL, NULL, "transactional cycles",
-				     0);
-	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX_CP)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, map_idx, &rsd);
-		total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, map_idx, &rsd);
-
-		if (total2 < avg)
-			total2 = avg;
-		if (total)
-			print_metric(config, ctxp, NULL, "%7.2f%%", "aborted cycles",
-				100.0 * ((total2-avg) / total));
-		else
-			print_metric(config, ctxp, NULL, NULL, "aborted cycles", 0);
-	} else if (perf_stat_evsel__is(evsel, TRANSACTION_START)) {
-		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, map_idx, &rsd);
-
-		if (avg)
-			ratio = total / avg;
-
-		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, map_idx, &rsd) != 0)
-			print_metric(config, ctxp, NULL, "%8.0f",
-				     "cycles / transaction", ratio);
-		else
-			print_metric(config, ctxp, NULL, NULL, "cycles / transaction",
-				      0);
-	} else if (perf_stat_evsel__is(evsel, ELISION_START)) {
-		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, map_idx, &rsd);
-
-		if (avg)
-			ratio = total / avg;
-
-		print_metric(config, ctxp, NULL, "%8.0f", "cycles / elision", ratio);
 	} else if (evsel__is_clock(evsel)) {
 		if ((ratio = avg_stats(&walltime_nsecs_stats)) != 0)
 			print_metric(config, ctxp, NULL, "%8.3f", "CPUs utilized",
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0b8c91ca13cd..b5b18d457254 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -87,10 +87,6 @@ bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id)
 #define ID(id, name) [PERF_STAT_EVSEL_ID__##id] = #name
 static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 	ID(NONE,		x),
-	ID(CYCLES_IN_TX,	cpu/cycles-t/),
-	ID(TRANSACTION_START,	cpu/tx-start/),
-	ID(ELISION_START,	cpu/el-start/),
-	ID(CYCLES_IN_TX_CP,	cpu/cycles-ct/),
 	ID(SMI_NUM, msr/smi/),
 	ID(APERF, msr/aperf/),
 };
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 42af350a96d9..c5fe847dd344 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -21,10 +21,6 @@ struct stats {
 
 enum perf_stat_evsel_id {
 	PERF_STAT_EVSEL_ID__NONE = 0,
-	PERF_STAT_EVSEL_ID__CYCLES_IN_TX,
-	PERF_STAT_EVSEL_ID__TRANSACTION_START,
-	PERF_STAT_EVSEL_ID__ELISION_START,
-	PERF_STAT_EVSEL_ID__CYCLES_IN_TX_CP,
 	PERF_STAT_EVSEL_ID__SMI_NUM,
 	PERF_STAT_EVSEL_ID__APERF,
 	PERF_STAT_EVSEL_ID__MAX,
@@ -92,9 +88,6 @@ enum stat_type {
 	STAT_LL_CACHE,
 	STAT_ITLB_CACHE,
 	STAT_DTLB_CACHE,
-	STAT_CYCLES_IN_TX,
-	STAT_TRANSACTION,
-	STAT_ELISION,
 	STAT_SMI_NUM,
 	STAT_APERF,
 	STAT_MAX
-- 
2.39.2.637.g21b0678d19-goog

