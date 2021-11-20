Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FA7C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 20 Nov 2021 03:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhKTDEC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbhKTDEB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Nov 2021 22:04:01 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8FC061574
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Nov 2021 19:00:58 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y6-20020a17090322c600b001428ab3f888so5600656plg.8
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Nov 2021 19:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R1DnboryHFg+rFRaLaj3Lm7I2twjI4y664AaJ2cbzRk=;
        b=I1fE+KzUrGfqPgVYXFfk5IslyBzfgN56sJs31K56LIhdGPikNAGbpIvdLSYYm6fpQB
         VrzgBEMCIGY+IIo6d7CpbZup5aQw7tJMnrQAUKJD9729WWo8lhoAjT0sRVjUnO3FDj20
         703eeSO4uL6raWREHDAiO3G+3mumHFQSAM9CEErAMdB+bQkzby0l4CG528aonVFwUwe3
         gaagdMnSZq551G4WI3nd0fxG94cDI0sCGzeyRPc6WL2TDcg2R82iE82og3USJmvsMzYQ
         vPyWn6GNcdp77gtlhsLCWqD25SZz9oV0a1vAnvBjwB/VL5HhItwb2Dc49g5fl89lwHQv
         kVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R1DnboryHFg+rFRaLaj3Lm7I2twjI4y664AaJ2cbzRk=;
        b=PMBjFO4zxYSpXdr/XcXoPUjA/FIXyr6ZYej92Z3zYJ/oJSOwdri5VJdLqigwgpsSr5
         UlE0m1m/RbkSA0BOwxPFaQ50OfLg11T78zKr7bV9vCKC8tbzgCMehXRy34NI+SbjDNRK
         EL7b46bSfdUEuRb3V9oF/r4e/ULcliya+7M30GOhBoNE8//yKBj5P016rkpfL5RoSbBt
         J1Xx1gz7SB3Vkc+tRLZ7MIK+jGky4zml2tAQNfQLX9bqaltiNHyBqNFpgRC1nGkhW/uR
         KuWs316FGjfOuyyY5LkYOTD4npIa8+MeTicenMseYTfmhe0DKlsgvIYUQmTn1DYAAXop
         phGg==
X-Gm-Message-State: AOAM531NCw1zdSJLzEK+JSRs+8KRL01mzdXQfS6JYsVH9FMJruUGPMgy
        yAdljlcTkc+BQCivtmaRCR9ex5RtkxYm
X-Google-Smtp-Source: ABdhPJwrRsIIi5U4I132j7Yjx/VCG6jELgFqX4PIF8N0/tgI8CNF3fn3nFm9caiOpQqd7m68CRmcNLI4u1N3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9122:1607:8323:8ea2])
 (user=irogers job=sendgmr) by 2002:a63:5c20:: with SMTP id
 q32mr20568505pgb.173.1637377258239; Fri, 19 Nov 2021 19:00:58 -0800 (PST)
Date:   Fri, 19 Nov 2021 19:00:53 -0800
Message-Id: <20211120030053.2649499-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] perf metric: Reduce multiplexing with duration_time
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It is common to use the same counters with and without
duration_time. The ID sharing code treats duration_time as if it
were a hardware event placed in the same group. This causes
unnecessary multiplexing such as in the following example where
l3_cache_access isn't shared:

$ perf stat -M l3 -a sleep 1

 Performance counter stats for 'system wide':

         3,117,007      l3_cache_miss             #    199.5 MB/s  l3_rd_bw
                                                  #     43.6 %  l3_hits
                                                  #     56.4 %  l3_miss               (50.00%)
         5,526,447      l3_cache_access                                               (50.00%)
         5,392,435      l3_cache_access           # 5389191.2 access/s  l3_access_rate  (50.00%)
     1,000,601,901 ns   duration_time

       1.000601901 seconds time elapsed

Fix this by placing duration_time in all groups unless metric
sharing has been disabled on the command line:

$ perf stat -M l3 -a sleep 1

 Performance counter stats for 'system wide':

         3,597,972      l3_cache_miss             #    230.3 MB/s  l3_rd_bw
                                                  #     48.0 %  l3_hits
                                                  #     52.0 %  l3_miss
         6,914,459      l3_cache_access           # 6909935.9 access/s  l3_access_rate
     1,000,654,579 ns   duration_time

       1.000654579 seconds time elapsed

$ perf stat --metric-no-merge -M l3 -a sleep 1

 Performance counter stats for 'system wide':

         3,501,834      l3_cache_miss             #     53.5 %  l3_miss               (24.99%)
         6,548,173      l3_cache_access                                               (24.99%)
         3,417,622      l3_cache_miss             #     45.7 %  l3_hits               (25.04%)
         6,294,062      l3_cache_access                                               (25.04%)
         5,923,238      l3_cache_access           # 5919688.1 access/s  l3_access_rate  (24.99%)
     1,000,599,683 ns   duration_time
         3,607,486      l3_cache_miss             #    230.9 MB/s  l3_rd_bw           (49.97%)

       1.000599683 seconds time elapsed

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index fffe02aae3ed..145c59ba2ddc 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1299,14 +1299,16 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 /**
  * parse_ids - Build the event string for the ids and parse them creating an
  *             evlist. The encoded metric_ids are decoded.
+ * @metric_no_merge: is metric sharing explicitly disabled.
  * @fake_pmu: used when testing metrics not supported by the current CPU.
  * @ids: the event identifiers parsed from a metric.
  * @modifier: any modifiers added to the events.
  * @has_constraint: false if events should be placed in a weak group.
  * @out_evlist: the created list of events.
  */
-static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
-		     const char *modifier, bool has_constraint, struct evlist **out_evlist)
+static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
+		     struct expr_parse_ctx *ids, const char *modifier,
+		     bool has_constraint, struct evlist **out_evlist)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
@@ -1314,12 +1316,19 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
 	int ret;
 
 	*out_evlist = NULL;
-	if (hashmap__size(ids->ids) == 0) {
+	if (!metric_no_merge || hashmap__size(ids->ids) == 0) {
 		char *tmp;
 		/*
-		 * No ids/events in the expression parsing context. Events may
-		 * have been removed because of constant evaluation, e.g.:
-		 *  event1 if #smt_on else 0
+		 * We may fail to share events between metrics because
+		 * duration_time isn't present in one metric. For example, a
+		 * ratio of cache misses doesn't need duration_time but the same
+		 * events may be used for a misses per second. Events without
+		 * sharing implies multiplexing, that is best avoided, so place
+		 * duration_time in every group.
+		 *
+		 * Also, there may be no ids/events in the expression parsing
+		 * context because of constant evaluation, e.g.:
+		 *    event1 if #smt_on else 0
 		 * Add a duration_time event to avoid a parse error on an empty
 		 * string.
 		 */
@@ -1387,7 +1396,8 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		ret = build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
-			ret = parse_ids(fake_pmu, combined, /*modifier=*/NULL,
+			ret = parse_ids(metric_no_merge, fake_pmu, combined,
+					/*modifier=*/NULL,
 					/*has_constraint=*/true,
 					&combined_evlist);
 		}
@@ -1435,7 +1445,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 			}
 		}
 		if (!metric_evlist) {
-			ret = parse_ids(fake_pmu, m->pctx, m->modifier,
+			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
 					m->has_constraint, &m->evlist);
 			if (ret)
 				goto out;
-- 
2.34.0.rc2.393.gf8c9666880-goog

