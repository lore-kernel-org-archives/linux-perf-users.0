Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9139AC636CC
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 09:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBSJrE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjBSJrD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 04:47:03 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B451206B
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:46:22 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5368a9902d0so14349517b3.10
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IR4cGxiP4ebyr+2RzCBvW6JFNP0fEMbIUpwuvhKV1BY=;
        b=NUcPy4ZHCiZDAbpqYYOc5JdSudhcF9l9kvtbJC+/xwt6fI8QeNC4WkMTcvQQ6804AT
         YF/xZ2bSpjDIgQdlfWHY/eHe3WKnEpPAPIMT7q5iIrd9Sn14jdygINYb7VGjPcgh8nCF
         trMCEbNSzgK3iAHSpUdlMuCCMauBc/SxT+NSFCPELU6vvdlM8J62FYawyLz3LzLGC5KK
         oUyaye5uBSEFDs6oNM8SAhzfix1YWJzevbaptGaf5BqcNtP47rHHphmVSl3Fb5Vw1PHF
         +L9HwzS3oieL/2/SVOgkIe6RBEYtywm/BAF3tZcvH8plHZ82czV8C5Pc6C6EUryLjpM7
         YatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IR4cGxiP4ebyr+2RzCBvW6JFNP0fEMbIUpwuvhKV1BY=;
        b=YItAf2wfSYsbdXRRd+hxX7EdHE+r8PF6Q/xiIykepCm9ZYvAJnteaI66FxGWmlgdcf
         +T8ngGB5/HJmwYFL+XDRl6XqGedZ1UuiYhhRxOrNX5HNwD5vLtgAw6JyyDZsp2k/L0Rh
         y3BQIs8oKxVGKkuknCtPZmMPjSLLnp4W1E8gz09b9ZY3cwQlaqODdPuGPEWCLRS2PHIG
         NYSm+BeCSWmKRsqANKCNFVbrCd4R4t+uzLyqLG0nv/7FPRXfkEKEzWRjMf9DKBNWWUCl
         BPk10b9A2RNgS1s/gDKlpHIYVj1CPznJs5zx9K6BdSx53D4XLRPC9eWLyvJzLBIc5rBa
         gB1w==
X-Gm-Message-State: AO0yUKWM9vRk/2u6un32bPuaLB/As4PaXsavqonrGOALuo2A2ndGWTho
        3giSCPg+XGYnKhyn/AVGoZguVpSsVcE2
X-Google-Smtp-Source: AK7set8dREUd48ldthm4G/cBwOOEaH0I+ZdYEzIr6WRbBTblxrP4saZKVOoIkrVw7eoOMt2hU/Yd1jyJKC9N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a5b:4c8:0:b0:8c2:3263:da34 with SMTP id
 u8-20020a5b04c8000000b008c23263da34mr1547079ybp.209.1676799311364; Sun, 19
 Feb 2023 01:35:11 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:41 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-45-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 44/51] perf stat: Use metrics for --smi-cost
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

Rather than parsing events for --smi-cost, use the json metric group
'smi'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 34 +++++++++++-----------------------
 tools/perf/util/stat-shadow.c | 30 ------------------------------
 tools/perf/util/stat.c        |  2 --
 tools/perf/util/stat.h        |  4 ----
 4 files changed, 11 insertions(+), 59 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e6b60b058257..9c1fbf154ee3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -100,14 +100,6 @@
 
 static void print_counters(struct timespec *ts, int argc, const char **argv);
 
-static const char *smi_cost_attrs = {
-	"{"
-	"msr/aperf/,"
-	"msr/smi/,"
-	"cycles"
-	"}"
-};
-
 static struct evlist	*evsel_list;
 static bool all_counters_use_bpf = true;
 
@@ -1666,7 +1658,6 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
  */
 static int add_default_attributes(void)
 {
-	int err;
 	struct perf_event_attr default_attrs0[] = {
 
   { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
@@ -1806,11 +1797,10 @@ static int add_default_attributes(void)
 	}
 
 	if (smi_cost) {
-		struct parse_events_error errinfo;
 		int smi;
 
 		if (sysfs__read_int(FREEZE_ON_SMI_PATH, &smi) < 0) {
-			fprintf(stderr, "freeze_on_smi is not supported.\n");
+			pr_err("freeze_on_smi is not supported.");
 			return -1;
 		}
 
@@ -1822,23 +1812,21 @@ static int add_default_attributes(void)
 			smi_reset = true;
 		}
 
-		if (!pmu_have_event("msr", "aperf") ||
-		    !pmu_have_event("msr", "smi")) {
-			fprintf(stderr, "To measure SMI cost, it needs "
-				"msr/aperf/, msr/smi/ and cpu/cycles/ support\n");
+		if (!metricgroup__has_metric("smi")) {
+			pr_err("Missing smi metrics");
 			return -1;
 		}
+
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
-		parse_events_error__init(&errinfo);
-		err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
-		if (err) {
-			parse_events_error__print(&errinfo, smi_cost_attrs);
-			fprintf(stderr, "Cannot set up SMI cost events\n");
-		}
-		parse_events_error__exit(&errinfo);
-		return err ? -1 : 0;
+		return metricgroup__parse_groups(evsel_list, "smi",
+						stat_config.metric_no_group,
+						stat_config.metric_no_merge,
+						stat_config.metric_no_threshold,
+						stat_config.user_requested_cpu_list,
+						stat_config.system_wide,
+						&stat_config.metric_events);
 	}
 
 	if (topdown_run) {
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3cfe4b4eb3de..d14fa531ee27 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -255,10 +255,6 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 		update_runtime_stat(st, STAT_DTLB_CACHE, map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
 		update_runtime_stat(st, STAT_ITLB_CACHE, map_idx, count, &rsd);
-	else if (perf_stat_evsel__is(counter, SMI_NUM))
-		update_runtime_stat(st, STAT_SMI_NUM, map_idx, count, &rsd);
-	else if (perf_stat_evsel__is(counter, APERF))
-		update_runtime_stat(st, STAT_APERF, map_idx, count, &rsd);
 
 	if (counter->collect_stat) {
 		v = saved_value_lookup(counter, map_idx, true, STAT_NONE, 0, st,
@@ -479,30 +475,6 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
 	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache accesses", ratio);
 }
 
-static void print_smi_cost(struct perf_stat_config *config, int map_idx,
-			   struct perf_stat_output_ctx *out,
-			   struct runtime_stat *st,
-			   struct runtime_stat_data *rsd)
-{
-	double smi_num, aperf, cycles, cost = 0.0;
-	const char *color = NULL;
-
-	smi_num = runtime_stat_avg(st, STAT_SMI_NUM, map_idx, rsd);
-	aperf = runtime_stat_avg(st, STAT_APERF, map_idx, rsd);
-	cycles = runtime_stat_avg(st, STAT_CYCLES, map_idx, rsd);
-
-	if ((cycles == 0) || (aperf == 0))
-		return;
-
-	if (smi_num)
-		cost = (aperf - cycles) / aperf * 100.00;
-
-	if (cost > 10)
-		color = PERF_COLOR_RED;
-	out->print_metric(config, out->ctx, color, "%8.1f%%", "SMI cycles%", cost);
-	out->print_metric(config, out->ctx, NULL, "%4.0f", "SMI#", smi_num);
-}
-
 static int prepare_metric(struct evsel **metric_events,
 			  struct metric_ref *metric_refs,
 			  struct expr_parse_ctx *pctx,
@@ -819,8 +791,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (unit != ' ')
 			snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
 		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
-	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
-		print_smi_cost(config, map_idx, out, st, &rsd);
 	} else {
 		num = 0;
 	}
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index b5b18d457254..d51d7457f12d 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -87,8 +87,6 @@ bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id)
 #define ID(id, name) [PERF_STAT_EVSEL_ID__##id] = #name
 static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 	ID(NONE,		x),
-	ID(SMI_NUM, msr/smi/),
-	ID(APERF, msr/aperf/),
 };
 #undef ID
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index c5fe847dd344..9af4af3bc3f2 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -21,8 +21,6 @@ struct stats {
 
 enum perf_stat_evsel_id {
 	PERF_STAT_EVSEL_ID__NONE = 0,
-	PERF_STAT_EVSEL_ID__SMI_NUM,
-	PERF_STAT_EVSEL_ID__APERF,
 	PERF_STAT_EVSEL_ID__MAX,
 };
 
@@ -88,8 +86,6 @@ enum stat_type {
 	STAT_LL_CACHE,
 	STAT_ITLB_CACHE,
 	STAT_DTLB_CACHE,
-	STAT_SMI_NUM,
-	STAT_APERF,
 	STAT_MAX
 };
 
-- 
2.39.2.637.g21b0678d19-goog

