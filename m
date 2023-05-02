Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90C9C19F20
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEBWjR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjEBWjQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:39:16 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A274C2D59
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:39:14 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1aae803a5eeso19471245ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067154; x=1685659154;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h10TGNBRB+swYQLldhqIixkznDBQsILm/HEqOr0YFfQ=;
        b=yYeNw6rrDXtRTtstKxgcQ/8z/3UzTNAFcKVoOAyBjspBXMBO0280ONt3OEZQqCcqjn
         Uwz14ZbYkRZ8poP7bXJm/CQtUujNMn0OQ3hQS4OPRhGIVV0kKDMNTF2IybxRnraKTv4N
         i/VWPPJaKm8JaWLKANQMq3foxEYe11qfksY81IxJrTwSXT/FN6JZffVFUa+Acwg95bva
         VQpdyjMTNTkRCowm1pbWH2ay14pPe974KC0ZNstH45sYtJjLIBZoDIOh0A4hnPtZzmlL
         lREJuzVfQQt6j0+JJn9/5P3WH/TbbWwUTcYK54VpD9pNbXJTAQFwo293BzYxwMF7kscE
         MBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067154; x=1685659154;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h10TGNBRB+swYQLldhqIixkznDBQsILm/HEqOr0YFfQ=;
        b=OKgoqShGEhXl6PpclEWdFKr8dtHhgRGgq1NsKH0YxXgOdNn+xOSF5YAThvh9XEDjfd
         OI2XfcJ2wSKgB38EQOZZ20tkk+D2qvCYyNQyOwGVwXqNBl2osgC4sPYUAaH+vcxSEmqX
         s33/wmtJoQbN1jWZA7s+DsFFN3HqwDjdOxlxl0D32E3cgOq1FkRChqfS8sSUn5Jg39ZT
         ZJV4fq4J63e8LCwjDytOPJl2rB7bqk4t/2UA2wY/0obn6Xg2Yjj0yVfGtYNrOK/mutPU
         aUoZcKmIur9RuLrQce9i82oqmUnDdqoXgmVeyCLB8Vm8LThESiEAkp951Vc+f91PW8st
         cfaA==
X-Gm-Message-State: AC+VfDw+R2tPiq0+g9eExwKKXIAz5gs1Rh/p+g9G+sfyoquv+lCA0Uas
        whznln/zKy/KszNavmc8/mwLJ+xHZbcO
X-Google-Smtp-Source: ACHHUZ47hifw5kvjgdhe0rDUe3579g8BZgsdKW6Wmz2s+UmPoufmfiO1wLZGgHZDvdlaI0qZZVy319SeCR1h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a17:903:492:b0:1a2:8940:6db0 with SMTP id
 jj18-20020a170903049200b001a289406db0mr11798plb.13.1683067154077; Tue, 02 May
 2023 15:39:14 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:08 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-2-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 01/44] perf metric: Change divide by zero and !support
 events behavior
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Division by zero causes expression parsing to fail and no metric to be
generated. This can mean for short running benchmarks metrics are not
shown. Change the behavior to make the value nan, which gets shown like:

'''
$ perf stat -M TopdownL2 true

 Performance counter stats for 'true':

         1,031,492      INST_RETIRED.ANY                 #      nan %  tma_fetch_bandwidth
                                                  #      nan %  tma_heavy_operations
                                                  #      nan %  tma_light_operations
            29,304      CPU_CLK_UNHALTED.REF_XCLK        #      nan %  tma_fetch_latency
                                                  #      nan %  tma_branch_mispredicts
                                                  #      nan %  tma_machine_clears
                                                  #      nan %  tma_core_bound
                                                  #      nan %  tma_memory_bound
         2,658,319      IDQ_UOPS_NOT_DELIVERED.CORE
            11,167      EXE_ACTIVITY.BOUND_ON_STORES
           262,058      EXE_ACTIVITY.1_PORTS_UTIL
     <not counted>      BR_MISP_RETIRED.ALL_BRANCHES                                            (0.00%)
     <not counted>      INT_MISC.RECOVERY_CYCLES_ANY                                            (0.00%)
     <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE                                        (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD                                                 (0.00%)
     <not counted>      UOPS_RETIRED.RETIRE_SLOTS                                               (0.00%)
     <not counted>      CYCLE_ACTIVITY.STALLS_MEM_ANY                                           (0.00%)
     <not counted>      UOPS_RETIRED.MACRO_FUSED                                                (0.00%)
     <not counted>      IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE                                        (0.00%)
     <not counted>      EXE_ACTIVITY.2_PORTS_UTIL                                               (0.00%)
     <not counted>      CYCLE_ACTIVITY.STALLS_TOTAL                                             (0.00%)
     <not counted>      MACHINE_CLEARS.COUNT                                                    (0.00%)
     <not counted>      UOPS_ISSUED.ANY                                                         (0.00%)

       0.002864879 seconds time elapsed

       0.003012000 seconds user
       0.000000000 seconds sys
'''

When events aren't supported a count of 0 can be confusing and make
metrics look meaningful. Change these to be nan also which, with the
next change, gets shown like:

'''
$ perf stat true
 Performance counter stats for 'true':

              1.25 msec task-clock:u                     #    0.387 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
                46      page-faults:u                    #   36.702 K/sec
           255,942      cycles:u                         #    0.204 GHz                         (88.66%)
           123,046      instructions:u                   #    0.48  insn per cycle
            28,301      branches:u                       #   22.580 M/sec
             2,489      branch-misses:u                  #    8.79% of all branches
             4,719      CPU_CLK_UNHALTED.REF_XCLK:u      #    3.765 M/sec
                                                  #      nan %  tma_frontend_bound
                                                  #      nan %  tma_retiring
                                                  #      nan %  tma_backend_bound
                                                  #      nan %  tma_bad_speculation
           344,855      IDQ_UOPS_NOT_DELIVERED.CORE:u    #  275.147 M/sec
   <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
     <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u                                        (0.00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD:u                                               (0.00%)
     <not counted>      UOPS_RETIRED.RETIRE_SLOTS:u                                             (0.00%)
     <not counted>      UOPS_ISSUED.ANY:u                                                       (0.00%)

       0.003238142 seconds time elapsed

       0.000000000 seconds user
       0.003434000 seconds sys
'''

Ensure that nan metric values are quoted as nan isn't a valid number
in json.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c         |  3 ++-
 tools/perf/tests/parse-metric.c |  1 +
 tools/perf/util/expr.y          |  6 +++++-
 tools/perf/util/stat-display.c  |  2 +-
 tools/perf/util/stat-shadow.c   | 25 +++++++++++++++++++------
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index cbf0e0c74906..733ead151c63 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -120,7 +120,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 
 	p = "FOO/0";
 	ret = expr__parse(&val, ctx, p);
-	TEST_ASSERT_VAL("division by zero", ret == -1);
+	TEST_ASSERT_VAL("division by zero", ret == 0);
+	TEST_ASSERT_VAL("division by zero", isnan(val));
 
 	p = "BAR/";
 	ret = expr__parse(&val, ctx, p);
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 1185b79e6274..c05148ea400c 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -38,6 +38,7 @@ static void load_runtime_stat(struct evlist *evlist, struct value *vals)
 	evlist__alloc_aggr_stats(evlist, 1);
 	evlist__for_each_entry(evlist, evsel) {
 		count = find_value(evsel->name, vals);
+		evsel->supported = true;
 		evsel->stats->aggr->counts.val = count;
 		if (evsel__name_is(evsel, "duration_time"))
 			update_stats(&walltime_nsecs_stats, count);
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 250e444bf032..4ce931cccb63 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -225,7 +225,11 @@ expr: NUMBER
 {
 	if (fpclassify($3.val) == FP_ZERO) {
 		pr_debug("division by zero\n");
-		YYABORT;
+		assert($3.ids == NULL);
+		if (compute_ids)
+			ids__free($1.ids);
+		$$.val = NAN;
+		$$.ids = NULL;
 	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
 		assert($1.ids == NULL);
 		assert($3.ids == NULL);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 73b2ff2ddf29..bf5a6c14dfcd 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -431,7 +431,7 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	fprintf(out, "\"metric-value\" : %f, ", val);
+	fprintf(out, "\"metric-value\" : \"%f\", ", val);
 	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
 	if (!config->metric_only)
 		fprintf(out, "}");
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index eeccab6751d7..1566a206ba42 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -403,12 +403,25 @@ static int prepare_metric(struct evsel **metric_events,
 			if (!aggr)
 				break;
 
-			/*
-			 * If an event was scaled during stat gathering, reverse
-			 * the scale before computing the metric.
-			 */
-			val = aggr->counts.val * (1.0 / metric_events[i]->scale);
-			source_count = evsel__source_count(metric_events[i]);
+                        if (!metric_events[i]->supported) {
+				/*
+				 * Not supported events will have a count of 0,
+				 * which can be confusing in a
+				 * metric. Explicitly set the value to NAN. Not
+				 * counted events (enable time of 0) are read as
+				 * 0.
+				 */
+				val = NAN;
+				source_count = 0;
+			} else {
+				/*
+				 * If an event was scaled during stat gathering,
+				 * reverse the scale before computing the
+				 * metric.
+				 */
+				val = aggr->counts.val * (1.0 / metric_events[i]->scale);
+				source_count = evsel__source_count(metric_events[i]);
+			}
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
-- 
2.40.1.495.gc816e09b53d-goog

