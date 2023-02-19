Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79018C636CC
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 09:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjBSJjb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjBSJj0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 04:39:26 -0500
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2933C16
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:38:27 -0800 (PST)
Received: by mail-pj1-f73.google.com with SMTP id l3-20020a17090a4d4300b00233cde95f87so287481pjh.9
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9cwoCmrhGIfqHNT3FoQmyx1P/u1tZpxQLcinvW6P6c=;
        b=KZFTskEwL+dr/8fy74EfeXIcp2au/6QZJ3gGYkGbfhDs/uzHGlgkQlCyOtQqbhL3xY
         Jy1NQsoj7VKTWKAE/EitP649Ng/7FgcDlXOnxI1iU1cBlsH6DgyFo++fEl+UBe/E/+W5
         6hC9CawjtpR0vb/YU+KI0IOuX1SnuuwXheTWvrToMTgJNwtFIZ16uN4w91EFgClU/Kzn
         OEa/fXjKSNwohQfBZOG6jV6XNsX9hHU7FRETX0HMhyg1Hxjj/M+tT5z24TCVCzcXtwH3
         gj4FZtCyVBNx3v/vbbFuafTfVzEK/pt0egT6W2xLL818ez3k8/S5kDDMY5D9Auucjcbq
         xwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9cwoCmrhGIfqHNT3FoQmyx1P/u1tZpxQLcinvW6P6c=;
        b=EizLVXQS2TLQfUYA9uoTQ0cuxblPjOiqYAv4Zi39E9evll3QZfIeBvthtnDTnob6FZ
         YBtD/TrQR4AhhOFZgqg/TPudjEiMcdPxPlNkzpWbXWad9ms0GgAg6yZGyRv56s4En4Az
         NIjYX8RgWHNkRePTW2yS9XtP8kH4p/sXIHF75k9gVnehemKUPlX+cQX6MRxh+072g1oh
         CFL1KNsJ+QM0a9QGEENNqeQwpocccVz0RzckTN1QKGTcgQDZBV9vk5YVi2ZXMHMM38H8
         0MJAwviRAbtiy4bgc8t3AtftI2yjDRs/Z1nlT/Ar3eImLPOQgRoD/wo2TzEXqA3I2V+C
         AFTQ==
X-Gm-Message-State: AO0yUKVAxgUA4EOBq8+ighuHq+i7fS+ZnmXSH0eDBSVUVlkzjgQVR48c
        UXhL728FI9cYcGbKIqGm1X7OJEm91atq
X-Google-Smtp-Source: AK7set9bNoQNlEamDjQt4xlyLyaRtaDLRrmSUe5cS7+XDn8sfy7OhYKbMdzn4fSxiQ5++JQPwE6CfgAjpEI8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a17:902:ab0c:b0:198:fd60:df2c with SMTP id
 ik12-20020a170902ab0c00b00198fd60df2cmr28114plb.11.1676799353893; Sun, 19 Feb
 2023 01:35:53 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:46 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-50-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 49/51] perf metric: Directly use counts rather than saved_value
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

Bugs with double aggregation have been introduced because of
aggregation of counters and again with saved_value. Remove the generic
metric use-case. Update parse-metric and pmu-events tests to update
aggregate rather than saved_value counts.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-metric.c |  4 +--
 tools/perf/tests/pmu-events.c   |  4 +--
 tools/perf/util/stat-shadow.c   | 56 +++++++++++----------------------
 3 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 37e3371d978e..b9b8a48289c4 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -35,10 +35,10 @@ static void load_runtime_stat(struct evlist *evlist, struct value *vals)
 	struct evsel *evsel;
 	u64 count;
 
-	perf_stat__reset_shadow_stats();
+	evlist__alloc_aggr_stats(evlist, 1);
 	evlist__for_each_entry(evlist, evsel) {
 		count = find_value(evsel->name, vals);
-		perf_stat__update_shadow_stats(evsel, count, 0);
+		evsel->stats->aggr->counts.val = count;
 		if (!strcmp(evsel->name, "duration_time"))
 			update_stats(&walltime_nsecs_stats, count);
 	}
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 122e74c282a7..4ec2a4ca1a82 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -863,9 +863,9 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 	 * zero when subtracted and so try to make them unique.
 	 */
 	k = 1;
-	perf_stat__reset_shadow_stats();
+	evlist__alloc_aggr_stats(evlist, 1);
 	evlist__for_each_entry(evlist, evsel) {
-		perf_stat__update_shadow_stats(evsel, k, 0);
+		evsel->stats->aggr->counts.val = k;
 		if (!strcmp(evsel->name, "duration_time"))
 			update_stats(&walltime_nsecs_stats, k);
 		k++;
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 7b48e2bd3ba1..eba98520cea2 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -234,7 +234,6 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 				    int aggr_idx)
 {
 	u64 count_ns = count;
-	struct saved_value *v;
 	struct runtime_stat_data rsd = {
 		.ctx = evsel_context(counter),
 		.cgrp = counter->cgrp,
@@ -265,19 +264,6 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 		update_runtime_stat(STAT_DTLB_CACHE, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
 		update_runtime_stat(STAT_ITLB_CACHE, aggr_idx, count, &rsd);
-
-	if (counter->collect_stat) {
-		v = saved_value_lookup(counter, aggr_idx, true, STAT_NONE, 0,
-				       rsd.cgrp);
-		update_stats(&v->stats, count);
-		if (counter->metric_leader)
-			v->metric_total += count;
-	} else if (counter->metric_leader && !counter->merged_stat) {
-		v = saved_value_lookup(counter->metric_leader,
-				       aggr_idx, true, STAT_NONE, 0, rsd.cgrp);
-		v->metric_total += count;
-		v->metric_other++;
-	}
 }
 
 /* used for get_ratio_color() */
@@ -480,18 +466,17 @@ static int prepare_metric(struct evsel **metric_events,
 			  struct expr_parse_ctx *pctx,
 			  int aggr_idx)
 {
-	double scale;
-	char *n;
-	int i, j, ret;
+	int i;
 
 	for (i = 0; metric_events[i]; i++) {
-		struct saved_value *v;
-		struct stats *stats;
-		u64 metric_total = 0;
-		int source_count;
+		char *n;
+		double val;
+		int source_count = 0;
 
 		if (evsel__is_tool(metric_events[i])) {
-			source_count = 1;
+			struct stats *stats;
+			double scale;
+
 			switch (metric_events[i]->tool_event) {
 			case PERF_TOOL_DURATION_TIME:
 				stats = &walltime_nsecs_stats;
@@ -515,35 +500,32 @@ static int prepare_metric(struct evsel **metric_events,
 				pr_err("Unknown tool event '%s'", evsel__name(metric_events[i]));
 				abort();
 			}
+			val = avg_stats(stats) * scale;
+			source_count = 1;
 		} else {
-			v = saved_value_lookup(metric_events[i], aggr_idx, false,
-					       STAT_NONE, 0,
-					       metric_events[i]->cgrp);
-			if (!v)
+			struct perf_stat_evsel *ps = metric_events[i]->stats;
+			struct perf_stat_aggr *aggr = &ps->aggr[aggr_idx];
+
+			if (!aggr)
 				break;
-			stats = &v->stats;
+
 			/*
 			 * If an event was scaled during stat gathering, reverse
 			 * the scale before computing the metric.
 			 */
-			scale = 1.0 / metric_events[i]->scale;
-
+			val = aggr->counts.val * (1.0 / metric_events[i]->scale);
 			source_count = evsel__source_count(metric_events[i]);
-
-			if (v->metric_other)
-				metric_total = v->metric_total * scale;
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
 			return -ENOMEM;
 
-		expr__add_id_val_source_count(pctx, n,
-					metric_total ? : avg_stats(stats) * scale,
-					source_count);
+		expr__add_id_val_source_count(pctx, n, val, source_count);
 	}
 
-	for (j = 0; metric_refs && metric_refs[j].metric_name; j++) {
-		ret = expr__add_ref(pctx, &metric_refs[j]);
+	for (int j = 0; metric_refs && metric_refs[j].metric_name; j++) {
+		int ret = expr__add_ref(pctx, &metric_refs[j]);
+
 		if (ret)
 			return ret;
 	}
-- 
2.39.2.637.g21b0678d19-goog

