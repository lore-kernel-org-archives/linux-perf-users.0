Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F04BC54EED
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 06:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjAXGfB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 01:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjAXGew (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 01:34:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FC814E85
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 22:34:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-434eb7c6fa5so144340267b3.14
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 22:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mV7cd0PttK0+CvZwdwIN1L+qh3nyibbPKOb9QqB52t0=;
        b=Rsz1NCmD4FsTwujPvvNFULUb3G6Qt8mtfR3s9eM19Q/3ptMnz7GtWJABmlo355EwF9
         /9tolkcmpwpltwOuoPPmSHGI+g6qGwGL+oI6n6IeNAmSSrilJtpY7va0Usz6K+1lebwR
         UyD23kOD7mUwrZosJB1/nZ1Yf+2ShsVW3nN5o6+FeehqGYqB5mHyUafslJmskwDtmSlA
         AeHRnCsSvgzegm1pWJG357rG5UXlMnveRnv2UUFoV5QS5Zo4llus3J26YnsTnQEbDmjQ
         pI4a7tVg+edZxMmLkCwMJ54Q6ym0Li5gma1j41eYKJgGXc8KpTn1mjD7Wt3ecTfXjj7v
         /gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mV7cd0PttK0+CvZwdwIN1L+qh3nyibbPKOb9QqB52t0=;
        b=GukriZN0vANI6p/CkiCNLO+B3RvGtb0tZlTjwN1HDtyDBuTmW3RZr36vPDTnOzBnk+
         OvBgJH1qkP0/Q3IdGhO0pCORLD7jJHvmcIFxotFR/t24Zm2524MmxfuifZSo4cd8c/2y
         jYJ1cg4Uyvfhw5/5sY05RT/B5cI8JvJBHmEU0YU30vv6c5KhIdj1VQv2KfEtnAg5YEKs
         TCHTvws9PQ5VG33AUwQgWap9wX8+zfr7hpMB6av5FoK1c10adPWcAjgfP15sKLxiKrsB
         pRc6fjZ0PorEu0N8mXvvyaYBhHUyRzinioF0c6tM95X2Sw/1M1bnHHoUtvXp4Ae4sq84
         gUWg==
X-Gm-Message-State: AFqh2koKhQn2PRSfidIUt8MBG1VG1jpcG9HuBoyzfNw7sUgMFdcolte3
        ms0WN3F+zdIt3sMTo1fDQITqG0pbQYQJ
X-Google-Smtp-Source: AMrXdXsPa4iefJ/f/nMKz0OxMzz8uNqcasB4ILJr+Oz387qo8FN3KAiJaOsPzKCmQQnLJPABw4nQpOS9vHGB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:460d:1b4a:acb8:ae9a])
 (user=irogers job=sendgmr) by 2002:a81:7047:0:b0:4bc:e7dc:16bc with SMTP id
 l68-20020a817047000000b004bce7dc16bcmr3185257ywc.368.1674542066399; Mon, 23
 Jan 2023 22:34:26 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:33:16 -0800
In-Reply-To: <20230124063320.668917-1-irogers@google.com>
Message-Id: <20230124063320.668917-8-irogers@google.com>
Mime-Version: 1.0
References: <20230124063320.668917-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v3 07/11] perf stat: Remove evsel metric_name/expr
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Metrics are their own unit and these variables held broken metrics
previously and now just hold the value NULL. Remove code that used
these variables.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     |   1 -
 tools/perf/util/cgroup.c      |   1 -
 tools/perf/util/evsel.c       |   2 -
 tools/perf/util/evsel.h       |   2 -
 tools/perf/util/python.c      |   7 ---
 tools/perf/util/stat-shadow.c | 112 ----------------------------------
 tools/perf/util/stat.h        |   1 -
 7 files changed, 126 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9f3e4b257516..5d18a5a6f662 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2524,7 +2524,6 @@ int cmd_stat(int argc, const char **argv)
 					&stat_config.metric_events);
 		zfree(&metrics);
 	}
-	perf_stat__collect_metric_expr(evsel_list);
 	perf_stat__init_shadow_stats();
 
 	if (add_default_attributes())
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index cd978c240e0d..bfb13306d82c 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -481,7 +481,6 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 		nr_cgroups++;
 
 		if (metric_events) {
-			perf_stat__collect_metric_expr(tmp_list);
 			if (metricgroup__copy_metric_events(tmp_list, cgrp,
 							    metric_events,
 							    &orig_metric_events) < 0)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8550638587e5..a90e998826e0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -285,8 +285,6 @@ void evsel__init(struct evsel *evsel,
 	evsel->sample_size = __evsel__sample_size(attr->sample_type);
 	evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
-	evsel->metric_expr   = NULL;
-	evsel->metric_name   = NULL;
 	evsel->metric_events = NULL;
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d572be41b960..24cb807ef6ce 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -105,8 +105,6 @@ struct evsel {
 	 * metric fields are similar, but needs more care as they can have
 	 * references to other metric (evsel).
 	 */
-	const char *		metric_expr;
-	const char *		metric_name;
 	struct evsel		**metric_events;
 	struct evsel		*metric_leader;
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 9e5d881b0987..42e8b813d010 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -76,13 +76,6 @@ const char *perf_env__arch(struct perf_env *env __maybe_unused)
 	return NULL;
 }
 
-/*
- * Add this one here not to drag util/stat-shadow.c
- */
-void perf_stat__collect_metric_expr(struct evlist *evsel_list)
-{
-}
-
 /*
  * These ones are needed not to drag the PMU bandwagon, jevents generated
  * pmu_sys_event_tables, etc and evsel__find_pmu() is used so far just for
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index cadb2df23c87..35ea4813f468 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -346,114 +346,6 @@ static const char *get_ratio_color(enum grc_type type, double ratio)
 	return color;
 }
 
-static struct evsel *perf_stat__find_event(struct evlist *evsel_list,
-						const char *name)
-{
-	struct evsel *c2;
-
-	evlist__for_each_entry (evsel_list, c2) {
-		if (!strcasecmp(c2->name, name) && !c2->collect_stat)
-			return c2;
-	}
-	return NULL;
-}
-
-/* Mark MetricExpr target events and link events using them to them. */
-void perf_stat__collect_metric_expr(struct evlist *evsel_list)
-{
-	struct evsel *counter, *leader, **metric_events, *oc;
-	bool found;
-	struct expr_parse_ctx *ctx;
-	struct hashmap_entry *cur;
-	size_t bkt;
-	int i;
-
-	ctx = expr__ctx_new();
-	if (!ctx) {
-		pr_debug("expr__ctx_new failed");
-		return;
-	}
-	evlist__for_each_entry(evsel_list, counter) {
-		bool invalid = false;
-
-		leader = evsel__leader(counter);
-		if (!counter->metric_expr)
-			continue;
-
-		expr__ctx_clear(ctx);
-		metric_events = counter->metric_events;
-		if (!metric_events) {
-			if (expr__find_ids(counter->metric_expr,
-					   counter->name,
-					   ctx) < 0)
-				continue;
-
-			metric_events = calloc(sizeof(struct evsel *),
-					       hashmap__size(ctx->ids) + 1);
-			if (!metric_events) {
-				expr__ctx_free(ctx);
-				return;
-			}
-			counter->metric_events = metric_events;
-		}
-
-		i = 0;
-		hashmap__for_each_entry(ctx->ids, cur, bkt) {
-			const char *metric_name = cur->pkey;
-
-			found = false;
-			if (leader) {
-				/* Search in group */
-				for_each_group_member (oc, leader) {
-					if (!strcasecmp(oc->name,
-							metric_name) &&
-						!oc->collect_stat) {
-						found = true;
-						break;
-					}
-				}
-			}
-			if (!found) {
-				/* Search ignoring groups */
-				oc = perf_stat__find_event(evsel_list,
-							   metric_name);
-			}
-			if (!oc) {
-				/* Deduping one is good enough to handle duplicated PMUs. */
-				static char *printed;
-
-				/*
-				 * Adding events automatically would be difficult, because
-				 * it would risk creating groups that are not schedulable.
-				 * perf stat doesn't understand all the scheduling constraints
-				 * of events. So we ask the user instead to add the missing
-				 * events.
-				 */
-				if (!printed ||
-				    strcasecmp(printed, metric_name)) {
-					fprintf(stderr,
-						"Add %s event to groups to get metric expression for %s\n",
-						metric_name,
-						counter->name);
-					free(printed);
-					printed = strdup(metric_name);
-				}
-				invalid = true;
-				continue;
-			}
-			metric_events[i++] = oc;
-			oc->collect_stat = true;
-		}
-		metric_events[i] = NULL;
-		if (invalid) {
-			free(metric_events);
-			counter->metric_events = NULL;
-			counter->metric_expr = NULL;
-		}
-	}
-	expr__ctx_free(ctx);
-}
-
 static double runtime_stat_avg(struct runtime_stat *st,
 			       enum stat_type type, int map_idx,
 			       struct runtime_stat_data *rsd)
@@ -1299,10 +1191,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			color = NULL;
 		print_metric(config, ctxp, color, "%8.1f%%", "Core Bound",
 				core_bound * 100.);
-	} else if (evsel->metric_expr) {
-		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
-			       evsel->name, evsel->metric_name, NULL, 1,
-			       map_idx, out, st);
 	} else if (runtime_stat_n(st, STAT_NSECS, map_idx, &rsd) != 0) {
 		char unit = ' ';
 		char unit_buf[10] = "/sec";
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 499c3bf81333..b1c29156c560 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -257,7 +257,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events,
 				   struct runtime_stat *st);
-void perf_stat__collect_metric_expr(struct evlist *);
 
 int evlist__alloc_stats(struct perf_stat_config *config,
 			struct evlist *evlist, bool alloc_raw);
-- 
2.39.0.246.g2a6d74b583-goog

