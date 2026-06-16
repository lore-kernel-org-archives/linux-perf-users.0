Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2E3DB319
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590453; cv=none; b=A17DHajABsRZTxlhiDdQVirc8GMdvutd4/VX84grCEnrS/r0WhF9KVyrDkCBLxgKCXSxSGQF756oBgOanfpm4rOWNpPqzdzvqiKSYaL5bFCvX0NCMw2s6R+wWHWM+iB290QTevK5mWQXqCe45CQPonhb+R1K8xE1RznzeE3vZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590453; c=relaxed/simple;
	bh=n88GiIRuBWN1QX0yrkoE+1hbcrTspaAItV/M2hiU7Fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nFBpHWplTYtGn7vi5BRrZoDNPDKbXzo3r6yvDOo8V1jXmKfgqlOy5p7pTFpPpezqYBr4swnGhFr8K5NAegGRGD4R2L/GOi013VUJBUcLiePXbrjzP7dD5KL2ZbbLlwmzIk8fWRz6QAkyGDT5DCxcOJnAZIjW92apuyNzbCjKh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SAK5bCj1; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAK5bCj1"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304b8d0ee63so6623442eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590451; x=1782195251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RP12n5UP3rULLqBRmPHB6+8Mx9qlwouQz8qIeEt0GmA=;
        b=SAK5bCj1vB5BZ0Z2BK8+tqFJfpwZ0KPSRl40Gv8zGLDMm8ck777dSoi+XE8L2oek4d
         +FmBBAs+k7KpHI/y33NzqM5q92bmxNirP24SD9S3PdNImSDnF8tHdo8X8sZxchVUUZO0
         umvcKDWnoYa64E0T4v3ZA11q4iv8onItt9sg+uXEkr9EItcNg3DEXc/E0aQRl0BjTu1t
         XD549AhWsC16U0ahhtHaNW5rVQwOh1rnsJGCWB2gGUxpz8RZw0U6tBf6fYCDel6nRIlq
         DF9DahTKWPLeV2G09nGpkACPCOnJSPJXKo64b1blpum7swEM1HKYJummx8eT3tdjsN+t
         Gt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590451; x=1782195251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RP12n5UP3rULLqBRmPHB6+8Mx9qlwouQz8qIeEt0GmA=;
        b=J6y0kTDhoNEGxDk3UI6lvd7wHoLU2iN2gtc/6pqnWanj7E+m859We8j8axuZIQZvFc
         2jlBAXPBnd6fdaiFxVSFaX1HGdxm3xNStpCnnz6POQswhgvxGAIl6sHLUohpA5oVZI6z
         MQuyWhwvbp7POTh94KmD2Zck6nCgtclQVs8I0UyewT1SBbi11CcVtkgjj9bhHnXy5On1
         Q9+sl+mc8JIWD74QniyvKuk9DN1A0SNr95qFf513l2/FfuUUAykHoYJWlIEhDtV2tqI1
         exz1H5eyGZJTFbcMH7KO9u5c1MmlnMwULHuhTwbfyfA4Ic6txaeqoCki7z2rSfZRx07A
         QaHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OJfrniT1zBBM5hQ2cdYK8y8k5fvEkWFdHE6JVT0EQCQjGiySLJmS2pqB40CsbGs9WYUk3b3QTs1aS9B8j9vxE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq38qCKUzy6ag94GzVoxFud+5Fk97cKaaKsk6+f1CsoyrMpf/t
	x7VIi9T8zghEEXPpgHyqhjIrRSX8GxozmV++Qq2Gsia8CJ5ZKlMJSIw57mDanr+PLZompLDguem
	JRSiAjUf1EA==
X-Received: from dlbsi13.prod.google.com ([2002:a05:7022:b88d:b0:137:f54a:5c7e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b9c:b0:136:d029:459
 with SMTP id a92af1059eb24-1386f395671mr6302104c88.22.1781590450443; Mon, 15
 Jun 2026 23:14:10 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:13:53 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-2-irogers@google.com>
Subject: [PATCH v2 01/12] perf parse-events: Restrict core PMU bypass to
 --cputype option
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Commit b1c5efbfd92e ("perf parse-events: Remove hard coded legacy hardware
and cache parsing") introduced a bypass to PMU filtering to prevent uncore PMUs
from being filtered out during event parsing, which was required for resolving
`duration_time` and `uncore_freq` when running with `--cputype`. However, this
bypass was active whenever `pmu_filter` was set, which also incorrectly bypassed
filtering for the `--pmu-filter` option.

Introduce a `cputype_filter` boolean flag in `parse_events_state` and
`parse_events_option_args` to distinguish filtering initiated by `--cputype`
from that initiated by `--pmu-filter`. Restrict the core-only check in
`parse_events__filter_pmu()` to when `cputype_filter` is true.

Fixes: b1c5efbfd92e ("perf parse-events: Remove hard coded legacy hardware and cache parsing")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c      |  1 +
 tools/perf/builtin-stat.c        | 12 +++++++-----
 tools/perf/tests/expand-cgroup.c |  2 +-
 tools/perf/tests/parse-events.c  | 11 +++++++----
 tools/perf/tests/parse-metric.c  |  2 +-
 tools/perf/tests/pmu-events.c    |  8 +++++---
 tools/perf/util/metricgroup.c    | 23 +++++++++++++++--------
 tools/perf/util/metricgroup.h    |  4 +++-
 tools/perf/util/parse-events.c   | 22 ++++++++++++++--------
 tools/perf/util/parse-events.h   | 17 +++++++++++------
 tools/perf/util/python.c         |  2 +-
 11 files changed, 66 insertions(+), 38 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9ac29bdc3cd5..6bd4d8627704 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2174,6 +2174,7 @@ static int script_find_metrics(const struct pmu_metric *pm,
 	struct evsel *metric_evsel;
 	int ret = metricgroup__parse_groups(metric_evlist,
 					/*pmu=*/"all",
+					/*cputype_filter=*/false,
 					pm->metric_name,
 					/*metric_no_group=*/false,
 					/*metric_no_merge=*/false,
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a04466ea3b0a..2505bc604e53 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1210,6 +1210,7 @@ static int parse_cputype(const struct option *opt,
 		return -1;
 	}
 	parse_events_option_args.pmu_filter = pmu->name;
+	parse_events_option_args.cputype_filter = true;
 
 	return 0;
 }
@@ -1226,6 +1227,7 @@ static int parse_pmu_filter(const struct option *opt,
 	}
 
 	parse_events_option_args.pmu_filter = str;
+	parse_events_option_args.cputype_filter = false;
 	return 0;
 }
 
@@ -1999,7 +2001,7 @@ static int add_default_events(void)
 			ret = -1;
 			goto out;
 		}
-		ret = metricgroup__parse_groups(evlist, pmu, "transaction",
+		ret = metricgroup__parse_groups(evlist, pmu, false, "transaction",
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
@@ -2036,7 +2038,7 @@ static int add_default_events(void)
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
-		ret = metricgroup__parse_groups(evlist, pmu, "smi",
+		ret = metricgroup__parse_groups(evlist, pmu, false, "smi",
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
@@ -2073,7 +2075,7 @@ static int add_default_events(void)
 		}
 		str[8] = stat_config.topdown_level + '0';
 		if (metricgroup__parse_groups(evlist,
-						pmu, str,
+					      pmu, false, str,
 						/*metric_no_group=*/false,
 						/*metric_no_merge=*/false,
 						/*metric_no_threshold=*/true,
@@ -2112,7 +2114,7 @@ static int add_default_events(void)
 				ret = -ENOMEM;
 				break;
 			}
-			if (metricgroup__parse_groups(metric_evlist, pmu, default_metricgroup_names[i],
+			if (metricgroup__parse_groups(metric_evlist, pmu, false, default_metricgroup_names[i],
 							/*metric_no_group=*/false,
 							/*metric_no_merge=*/false,
 							/*metric_no_threshold=*/true,
@@ -2848,7 +2850,7 @@ int cmd_stat(int argc, const char **argv)
 	 */
 	if (metrics) {
 		const char *pmu = parse_events_option_args.pmu_filter ?: "all";
-		int ret = metricgroup__parse_groups(evsel_list, pmu, metrics,
+		int ret = metricgroup__parse_groups(evsel_list, pmu, parse_events_option_args.cputype_filter, metrics,
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index dd547f2f77cc..be6d7feeb38e 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -179,7 +179,7 @@ static int expand_metric_events(void)
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
 	pme_test = find_core_metrics_table("testarch", "testcpu");
-	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str);
+	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str, false);
 	if (ret < 0) {
 		pr_debug("failed to parse '%s' metric\n", metric_str);
 		goto out;
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 05c3e899b425..2cbe81b9c886 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2556,8 +2556,10 @@ static int test_event(const struct evlist_test *e)
 		return TEST_FAIL;
 	}
 	parse_events_error__init(&err);
-	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL, &err, /*fake_pmu=*/false,
-			     /*warn_if_reordered=*/true, /*fake_tp=*/true);
+	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL,
+			     /*cputype_filter=*/false, &err, /*fake_pmu=*/false,
+			     /*warn_if_reordered=*/true,
+			     /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n", e->name, ret);
 		parse_events_error__print(&err, e->name);
@@ -2584,8 +2586,9 @@ static int test_event_fake_pmu(const char *str)
 		return -ENOMEM;
 
 	parse_events_error__init(&err);
-	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL, &err,
-			     /*fake_pmu=*/true, /*warn_if_reordered=*/true,
+	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL,
+			     /*cputype_filter=*/false, &err, /*fake_pmu=*/true,
+			     /*warn_if_reordered=*/true,
 			     /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n",
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 7c7f489a5eb0..fd9d0cae580e 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -92,7 +92,7 @@ static int __compute_metric(const char *name, struct value *vals,
 
 	/* Parse the metric into metric_events list. */
 	pme_test = find_core_metrics_table("testarch", "testcpu");
-	err = metricgroup__parse_groups_test(evlist, pme_test, name);
+	err = metricgroup__parse_groups_test(evlist, pme_test, name, false);
 	if (err)
 		goto out;
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index fd5630f0a13c..df8806d8a8fd 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -794,8 +794,10 @@ static int check_parse_id(const char *id, struct parse_events_error *error)
 	for (cur = strchr(dup, '@') ; cur; cur = strchr(++cur, '@'))
 		*cur = '/';
 
-	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL, error, /*fake_pmu=*/true,
-			     /*warn_if_reordered=*/true, /*fake_tp=*/false);
+	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL,
+			     /*cputype_filter=*/false, error, /*fake_pmu=*/true,
+			     /*warn_if_reordered=*/true,
+			     /*fake_tp=*/false);
 	free(dup);
 
 	evlist__delete(evlist);
@@ -871,7 +873,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 
 	perf_evlist__set_maps(&evlist->core, cpus, NULL);
 
-	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name);
+	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name, false);
 	if (err) {
 		if (is_expected_broken_metric(pm)) {
 			(*failures)--;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c2ce3e53aaee..9c9b04883841 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1262,7 +1262,8 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 		     struct expr_parse_ctx *ids, const char *modifier,
 		     bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
 		     struct evlist **out_evlist,
-		     const char *filter_pmu)
+		     const char *filter_pmu,
+		     bool cputype_filter)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
@@ -1317,7 +1318,9 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
 	ret = __parse_events(parsed_evlist, events.buf, filter_pmu,
-			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
+			     cputype_filter,
+			     &parse_error, fake_pmu,
+			     /*warn_if_reordered=*/false,
 			     /*fake_tp=*/false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
@@ -1382,7 +1385,7 @@ static struct evsel *pick_display_evsel(struct list_head *metric_list,
 }
 
 static int parse_groups(struct evlist *perf_evlist,
-			const char *pmu, const char *str,
+			const char *pmu, bool cputype_filter, const char *str,
 			bool metric_no_group,
 			bool metric_no_merge,
 			bool metric_no_threshold,
@@ -1420,7 +1423,8 @@ static int parse_groups(struct evlist *perf_evlist,
 					/*group_events=*/false,
 					tool_events,
 					&combined_evlist,
-					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
+					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu,
+					cputype_filter);
 		}
 		if (combined)
 			expr__ctx_free(combined);
@@ -1476,7 +1480,8 @@ static int parse_groups(struct evlist *perf_evlist,
 		if (!metric_evlist) {
 			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
 					m->group_events, tool_events, &m->evlist,
-					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
+					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu,
+					cputype_filter);
 			if (ret)
 				goto out;
 
@@ -1557,6 +1562,7 @@ static int parse_groups(struct evlist *perf_evlist,
 
 int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      const char *pmu,
+			      bool cputype_filter,
 			      const char *str,
 			      bool metric_no_group,
 			      bool metric_no_merge,
@@ -1570,16 +1576,17 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 	if (hardware_aware_grouping)
 		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
 
-	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
+	return parse_groups(perf_evlist, pmu, cputype_filter, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/false, table);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_metrics_table *table,
-				   const char *str)
+				   const char *str,
+				   bool cputype_filter)
 {
-	return parse_groups(evlist, "all", str,
+	return parse_groups(evlist, "all", cputype_filter, str,
 			    /*metric_no_group=*/false,
 			    /*metric_no_merge=*/false,
 			    /*metric_no_threshold=*/false,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 4be6bfc13c46..6a66f14dd01b 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -71,6 +71,7 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 bool create);
 int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      const char *pmu,
+			      bool cputype_filter,
 			      const char *str,
 			      bool metric_no_group,
 			      bool metric_no_merge,
@@ -80,7 +81,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool hardware_aware_grouping);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_metrics_table *table,
-				   const char *str);
+				   const char *str,
+				   bool cputype_filter);
 
 int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				 void *data);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 943569e82b82..9f64d5197b8a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -429,6 +429,9 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 	if (parse_state->pmu_filter == NULL)
 		return false;
 
+	if (parse_state->cputype_filter && !pmu->is_core)
+		return false;
+
 	return perf_pmu__wildcard_match(pmu, parse_state->pmu_filter) == 0;
 }
 
@@ -2288,18 +2291,20 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 	return (idx_changed || num_leaders != orig_num_leaders) ? 1 : 0;
 }
 
-int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
+int __parse_events(struct evlist *evlist, const char *str,
+		   const char *pmu_filter, bool cputype_filter,
 		   struct parse_events_error *err, bool fake_pmu,
 		   bool warn_if_reordered, bool fake_tp)
 {
 	struct parse_events_state parse_state = {
-		.list	  = LIST_HEAD_INIT(parse_state.list),
-		.idx	  = evlist->core.nr_entries,
-		.error	  = err,
-		.stoken	  = PE_START_EVENTS,
+		.list = LIST_HEAD_INIT(parse_state.list),
+		.idx = evlist->core.nr_entries,
+		.error = err,
+		.stoken = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
-		.fake_tp  = fake_tp,
+		.fake_tp = fake_tp,
 		.pmu_filter = pmu_filter,
+		.cputype_filter = cputype_filter,
 		.match_legacy_cache_terms = true,
 	};
 	int ret, ret2;
@@ -2518,8 +2523,9 @@ int parse_events_option(const struct option *opt, const char *str,
 	int ret;
 
 	parse_events_error__init(&err);
-	ret = __parse_events(*args->evlistp, str, args->pmu_filter, &err,
-			     /*fake_pmu=*/false, /*warn_if_reordered=*/true,
+	ret = __parse_events(*args->evlistp, str, args->pmu_filter,
+			     args->cputype_filter, &err, /*fake_pmu=*/false,
+			     /*warn_if_reordered=*/true,
 			     /*fake_tp=*/false);
 
 	if (ret) {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 3577ab213730..b14c832b03a1 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -26,20 +26,23 @@ const char *event_type(size_t type);
 struct parse_events_option_args {
 	struct evlist **evlistp;
 	const char *pmu_filter;
+	bool cputype_filter;
 };
 int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
-__attribute__((nonnull(1, 2, 4)))
-int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
-		   struct parse_events_error *error, bool fake_pmu,
-		   bool warn_if_reordered, bool fake_tp);
+__attribute__((nonnull(1, 2, 5))) int
+__parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
+	       bool cputype_filter, struct parse_events_error *error,
+	       bool fake_pmu, bool warn_if_reordered, bool fake_tp);
 
 __attribute__((nonnull(1, 2, 3)))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
-	return __parse_events(evlist, str, /*pmu_filter=*/NULL, err, /*fake_pmu=*/false,
-			      /*warn_if_reordered=*/true, /*fake_tp=*/false);
+	return __parse_events(evlist, str, /*pmu_filter=*/NULL,
+			      /*cputype_filter=*/false, err, /*fake_pmu=*/false,
+			      /*warn_if_reordered=*/true,
+			      /*fake_tp=*/false);
 }
 
 int parse_event(struct evlist *evlist, const char *str);
@@ -161,6 +164,8 @@ struct parse_events_state {
 	bool			   fake_tp;
 	/* If non-null, when wildcard matching only match the given PMU. */
 	const char		  *pmu_filter;
+	/* If true, the pmu_filter was set by --cputype option. */
+	bool cputype_filter;
 	/* Should PE_LEGACY_NAME tokens be generated for config terms? */
 	bool			   match_legacy_cache_terms;
 	/* Were multiple PMUs scanned to find events? */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc1019d29a5d..fd9095aa4430 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2104,7 +2104,7 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	evlist__init(&evlist, cpus, threads);
-	ret = metricgroup__parse_groups(&evlist, pmu ?: "all", input,
+	ret = metricgroup__parse_groups(&evlist, pmu ?: "all", false, input,
 					/*metric_no_group=*/ false,
 					/*metric_no_merge=*/ false,
 					/*metric_no_threshold=*/ true,
-- 
2.54.0.1136.gdb2ca164c4-goog

