Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3289582B81
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203273; cv=none; b=h3N9P61FJDysy9y7udVTjfu36wSeB0Y/uy8On78/gzF1tiH8xe/YuLqGGBzje8gZj/hz0S3FfBaETpqPjTHjYl5ZPXt+M/GopQvK9iabAPWg3phPk3TA+GgMElQdSgTnhc6pjzjudGIWZCHKDud48zJF3i9mVxLU+1SsvLreoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203273; c=relaxed/simple;
	bh=eZKn99eSGTXtiQncajeBvRTuYaIHCGPsJ/9iV1l85hI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=tfioaWfFcoFy/V7CWZT6FXGD6hLc0VQprjncuBR2Ub5waInPVHmwmlBm/AyCzjpBxppOiBKwRcotpZRh/iixkOADu0Gu/QCqpYzbOaqi1fw0c53v5yca3ZTAHxpUFt2Le97tbb/sNONUeCO0KTYpttTwgmoyTTKcopH9wwSbX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QyVKccK+; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyVKccK+"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14373747468so2114768c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790203270; x=1790808070; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wfWrnRPUN9WvqwLjz7VeSW/3oGZTANoMbTk1u6T45mk=;
        b=QyVKccK+98a9SG4wbzPfE1R1PAagRpg5bxgTTGv8Lms8jdb/lRNpkpxUVgtWaqS3SC
         MhSAyBTDIwOZHsOI/2H8KGur/Ft/WQgrB51+sGH2WGutRk3ap+CCEhIsaWXhcvcWSU9i
         v67v+EvSsAUJIyVQkXR+0IvnnJPvveE1l7ReeaW5plt+CwGIjejdJjkFfTM5vg5253/H
         bCDZCZBkYiu3FZhuFuv/qDZVPepyRGwZAt4KaYyWb40OzU4AJHZ5hJ2tFXcqCPbHUT2Y
         xVCnmU4MaH3QO6zkoCqsKPCt3ozvqAKRjA4E1f4CWeg+cSe5QF3YeTDvGERdxCnKhQVV
         cvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790203270; x=1790808070;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfWrnRPUN9WvqwLjz7VeSW/3oGZTANoMbTk1u6T45mk=;
        b=iBWIm1Izk+BT9nBf7y2XOOLQUzH6Xubtxsf4e0snss1fhN6vLHkZoNMSSls4/So4RP
         OEW4UECrN/hF8MIOiLGScUDHbe1Lr5mFiTBjIKdKUGT0AfqvOnPWOxmhrOuj9Sc5e4fz
         8Xfh5kf0ZZNQ3EkmOGnay8D7UnS2iuTKKzx/UkOUI8acVFahGdSI7o5olbhXMHuTqOfo
         bzV1tl2QOak/jbkoHYQ4/8nwL0019TO1ktUj7nGpMwnYCwaBBvAqpmGK4HWQMCSaKeTg
         Zqcx4eMsQwwHHgweFLqTphhXvpXtGry2UAiNB8LtVppo+7AVT9Be5TRqhXMYz3Z/2JdH
         u/9w==
X-Forwarded-Encrypted: i=1; AKwUvBytkFmQCYf2O5sIsd4bcIpylHxqjZyN2bqRfo+AshO/KmjZmUCIw0AbNJt/Kv3RL6uEMfzLmW3nUyRUNOMMGazm@vger.kernel.org
X-Gm-Message-State: AFuF++mKX7+8fTLO12/OCtVTU1Ait0nVgH1S56Bh44aUKteQ38yNZLRY
	rfAgtQZAbUQul5DRkRwRtbAxexX5SwMFg5/FU3l0kcQdLz7lunsXxExlL994sjjbCiCSh0gz1W4
	2rgZg7v9+WA==
X-Received: from dlx9.prod.google.com ([2002:a05:7022:89:b0:144:fc09:77a2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4586:20b0:143:7001:7645
 with SMTP id a92af1059eb24-1450401c5damr356072c88.47.1790203269507; Wed, 23
 Sep 2026 15:41:09 -0700 (PDT)
Date: Wed, 23 Sep 2026 15:41:06 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923224106.3268925-1-irogers@google.com>
Subject: [PATCH v1] perf test: Fix PMU metric parsing tests for unknown literals
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Qinxin Xia <xiaqinxin@huawei.com>, Yu Peng <pengyu@kylinos.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On ARM the #slots literal may or may not be present, it won't be
present on x86. As it is missing it causes the ampereone and
ampereonex PMU metric tests to fail when run say on x86. Extend the
fake_pmu logic so that in these test cases we fake the unknown
literals like #slots as 1.0. When building with JEVENTS_ARCH=all the
ampere metric tests no longer fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c        |  5 ++++-
 tools/perf/util/metricgroup.c | 37 ++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 8aef3c7418f7..f1164c4666b1 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -431,7 +431,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 	}
 
 	pr_debug2("literal: %s = %f\n", literal, result);
-	return result;
+	if (!ctx->is_test)
+		return result;
+	else
+		return isnan(result) ? 1.0 : result;
 }
 
 /* Does the event 'id' parse? Determine via ctx->ids if possible. */
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 5a60cb95e31c..779fe56fe8d0 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -224,7 +224,8 @@ static struct metric *metric__new(const struct pmu_metric *pm,
 				  bool metric_no_threshold,
 				  int runtime,
 				  const char *user_requested_cpu_list,
-				  bool system_wide)
+				  bool system_wide,
+				  bool fake_pmu)
 {
 	struct metric *m;
 
@@ -256,6 +257,7 @@ static struct metric *metric__new(const struct pmu_metric *pm,
 	}
 	m->pctx->sctx.runtime = runtime;
 	m->pctx->sctx.system_wide = system_wide;
+	m->pctx->sctx.is_test = fake_pmu;
 	m->group_events = !metric_no_group && metric__group_events(pm, metric_no_threshold);
 	m->default_show_events = pm->default_show_events;
 	m->metric_refs = NULL;
@@ -699,6 +701,7 @@ static int add_metric(struct list_head *metric_list,
 		      bool metric_no_threshold,
 		      const char *user_requested_cpu_list,
 		      bool system_wide,
+		      bool fake_pmu,
 		      struct metric *root_metric,
 		      const struct visited_metric *visited,
 		      const struct pmu_metrics_table *table);
@@ -724,6 +727,7 @@ static int metricgroup__find_metric_callback(const struct pmu_metric *pm,
  *                   user may override.
  * @user_requested_cpu_list: Command line specified CPUs to record on.
  * @system_wide: Are events for all processes recorded.
+ * @fake_pmu: Are PMUs and events being faked for testing?
  * @root_metric: Metrics may reference other metrics to form a tree. In this
  *               case the root_metric holds all the IDs and a list of referenced
  *               metrics. When adding a root this argument is NULL.
@@ -739,6 +743,7 @@ static int resolve_metric(struct list_head *metric_list,
 			  bool metric_no_threshold,
 			  const char *user_requested_cpu_list,
 			  bool system_wide,
+			  bool fake_pmu,
 			  struct metric *root_metric,
 			  const struct visited_metric *visited,
 			  const struct pmu_metrics_table *table)
@@ -788,7 +793,7 @@ static int resolve_metric(struct list_head *metric_list,
 	for (i = 0; i < pending_cnt; i++) {
 		ret = add_metric(metric_list, &pending[i].pm, modifier, metric_no_group,
 				 metric_no_threshold, user_requested_cpu_list, system_wide,
-				 root_metric, visited, table);
+				 fake_pmu, root_metric, visited, table);
 		if (ret)
 			break;
 	}
@@ -809,6 +814,7 @@ static int resolve_metric(struct list_head *metric_list,
  * @runtime: A special argument for the parser only known at runtime.
  * @user_requested_cpu_list: Command line specified CPUs to record on.
  * @system_wide: Are events for all processes recorded.
+ * @fake_pmu: Are PMUs and events being faked for testing?
  * @root_metric: Metrics may reference other metrics to form a tree. In this
  *               case the root_metric holds all the IDs and a list of referenced
  *               metrics. When adding a root this argument is NULL.
@@ -825,6 +831,7 @@ static int __add_metric(struct list_head *metric_list,
 			int runtime,
 			const char *user_requested_cpu_list,
 			bool system_wide,
+			bool fake_pmu,
 			struct metric *root_metric,
 			const struct visited_metric *visited,
 			const struct pmu_metrics_table *table)
@@ -851,7 +858,7 @@ static int __add_metric(struct list_head *metric_list,
 		 * metrics that are added recursively.
 		 */
 		root_metric = metric__new(pm, modifier, metric_no_group, metric_no_threshold,
-					  runtime, user_requested_cpu_list, system_wide);
+					  runtime, user_requested_cpu_list, system_wide, fake_pmu);
 		if (!root_metric)
 			return -ENOMEM;
 
@@ -924,7 +931,7 @@ static int __add_metric(struct list_head *metric_list,
 
 		ret = resolve_metric(metric_list, pmu, modifier, metric_no_group,
 				     metric_no_threshold, user_requested_cpu_list,
-				     system_wide, root_metric, &visited_node,
+				     system_wide, fake_pmu, root_metric, &visited_node,
 				     table);
 	}
 	if (ret) {
@@ -944,6 +951,7 @@ static int add_metric(struct list_head *metric_list,
 		      bool metric_no_threshold,
 		      const char *user_requested_cpu_list,
 		      bool system_wide,
+		      bool fake_pmu,
 		      struct metric *root_metric,
 		      const struct visited_metric *visited,
 		      const struct pmu_metrics_table *table)
@@ -955,7 +963,7 @@ static int add_metric(struct list_head *metric_list,
 	if (!strstr(pm->metric_expr, "?")) {
 		ret = __add_metric(metric_list, pm, modifier, metric_no_group,
 				   metric_no_threshold, 0, user_requested_cpu_list,
-				   system_wide, root_metric, visited, table);
+				   system_wide, fake_pmu, root_metric, visited, table);
 	} else {
 		int j, count;
 
@@ -969,7 +977,7 @@ static int add_metric(struct list_head *metric_list,
 		for (j = 0; j < count && !ret; j++)
 			ret = __add_metric(metric_list, pm, modifier, metric_no_group,
 					   metric_no_threshold, j, user_requested_cpu_list,
-					   system_wide, root_metric, visited, table);
+					   system_wide, fake_pmu, root_metric, visited, table);
 	}
 
 	return ret;
@@ -1030,6 +1038,7 @@ struct metricgroup__add_metric_data {
 	bool metric_no_group;
 	bool metric_no_threshold;
 	bool system_wide;
+	bool fake_pmu;
 	bool has_match;
 };
 
@@ -1047,7 +1056,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
 		data->has_match = true;
 		ret = add_metric(data->list, pm, data->modifier, metric_no_group,
 				 data->metric_no_threshold, data->user_requested_cpu_list,
-				 data->system_wide, /*root_metric=*/NULL,
+				data->system_wide, data->fake_pmu, /*root_metric=*/NULL,
 				 /*visited_metrics=*/NULL, table);
 	}
 	return ret;
@@ -1065,6 +1074,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
  *                   user may override.
  * @user_requested_cpu_list: Command line specified CPUs to record on.
  * @system_wide: Are events for all processes recorded.
+ * @fake_pmu: Are PMUs and events being faked for testing?
  * @metric_list: The list that the metric or metric group are added to.
  * @table: The table that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
@@ -1072,7 +1082,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
 static int metricgroup__add_metric(const char *pmu, const char *metric_name, const char *modifier,
 				   bool metric_no_group, bool metric_no_threshold,
 				   const char *user_requested_cpu_list,
-				   bool system_wide,
+				   bool system_wide, bool fake_pmu,
 				   struct list_head *metric_list,
 				   const struct pmu_metrics_table *table)
 {
@@ -1087,6 +1097,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 		.metric_no_threshold = metric_no_threshold,
 		.user_requested_cpu_list = user_requested_cpu_list,
 		.system_wide = system_wide,
+		.fake_pmu = fake_pmu,
 		.has_match = false,
 	};
 
@@ -1118,6 +1129,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
  *                   user may override.
  * @user_requested_cpu_list: Command line specified CPUs to record on.
  * @system_wide: Are events for all processes recorded.
+ * @fake_pmu: Are PMUs and events being faked for testing?
  * @metric_list: The list that metrics are added to.
  * @table: The table that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
@@ -1126,7 +1138,8 @@ static int metricgroup__add_metric_list(const char *pmu, const char *list,
 					bool metric_no_group,
 					bool metric_no_threshold,
 					const char *user_requested_cpu_list,
-					bool system_wide, struct list_head *metric_list,
+					bool system_wide, bool fake_pmu,
+					struct list_head *metric_list,
 					const struct pmu_metrics_table *table)
 {
 	char *list_itr, *list_copy, *metric_name, *modifier;
@@ -1145,7 +1158,8 @@ static int metricgroup__add_metric_list(const char *pmu, const char *list,
 		ret = metricgroup__add_metric(pmu, metric_name, modifier,
 					      metric_no_group, metric_no_threshold,
 					      user_requested_cpu_list,
-					      system_wide, metric_list, table);
+					      system_wide, fake_pmu,
+					      metric_list, table);
 		if (ret == -EINVAL)
 			pr_err("Fail to parse metric or group `%s'\n", metric_name);
 		else if (ret == -ENOENT)
@@ -1403,7 +1417,8 @@ static int parse_groups(struct evlist *perf_evlist,
 
 	ret = metricgroup__add_metric_list(pmu, str, metric_no_group, metric_no_threshold,
 					   user_requested_cpu_list,
-					   system_wide, &metric_list, table);
+					   system_wide, fake_pmu,
+					   &metric_list, table);
 	if (ret)
 		goto out;
 
-- 
2.56.0.rc1.310.g51773c2048-goog

