Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A6CC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Nov 2021 01:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhKXBzm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbhKXBzk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 20:55:40 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3B2C06173E
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 17:52:30 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pg9-20020a17090b1e0900b001a689204b52so2473980pjb.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 17:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qCgAZNpP6++lkRf299wPMYpVTG2XAg9F0zJlPBozgfc=;
        b=lxcz1JpCdJmaW4PoJnXX8Ah9Gc0QjezdvkAHkm3dM71bXub7gTnuP4HqTSEmPxmdtO
         sF4Y3OID/zrpf4G+TNhQ4A+cCKN/zm+8WEdOMq8Sr5MSOM0vRuZxVnkkPJAeikU+AyK7
         z11RsztYfHJARjz9Ft30deTwOj4jGzCHtoW+eRNkBBroODSwA3834oWKfzWxw/lQCXCC
         g/ZzESwEU/LJx+IeQwNBWNQSFeq7upn90A/ykS6/tsWHDwtNmBB8ttvY8iRyDlKai/YH
         YGnvcvKbY+UtMPSWU4eufgb3Siu3CPSgvX0yYuM4piDATqat31mh8azUhZZQzOSesDuX
         YI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qCgAZNpP6++lkRf299wPMYpVTG2XAg9F0zJlPBozgfc=;
        b=Ac+wYnQfE1olog6rK2uHpqzn2zc4LcYXwNQFhCRdaHivzCxTh3hz7qbN/fQXvBpYxV
         HJWKlh+yaCZlbaQcpkLwGHA7uJ1TbiCMUn+SKsObQUVeHV6WNaRU6I6NLklCmUlqLWvm
         wD2RVk607Ow8hsbx/mAquudPxxcLIR+iAdk/E8pErWN6/qkDavH0lrQmp+FmsN2W3G39
         WpcxEVk7oxNP0Dc+573ZMyLdBLNqKeKSSTv9WowToxddhde91eHAOhXOEyEX3yxyfJ8N
         fe/P+ZpnJGgUhJ+4VeTK4EGqSOcnXtSNpFI908KEHuMt6jD9AAZAuVg9JjSrYDnzFBlF
         7A2w==
X-Gm-Message-State: AOAM531/dGiLVk4zc8ZgjcZNU62ZtEdhCuBLICcJgv8oJA7ODBbjQfV3
        PBzcDTJdu0Oe/HXaIIj/jCsHDCHk4Y88
X-Google-Smtp-Source: ABdhPJybnLxu/eQaljlooi+bWcg8G7+Nsyjo1JQW75DRvy8cdgfxPy3CLCXnRekJAXy4p2rinnXWzLMOKoDP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dbab:a6fe:1e3a:91fa])
 (user=irogers job=sendgmr) by 2002:aa7:9903:0:b0:49f:e368:4fc3 with SMTP id
 z3-20020aa79903000000b0049fe3684fc3mr2189795pff.1.1637718750203; Tue, 23 Nov
 2021 17:52:30 -0800 (PST)
Date:   Tue, 23 Nov 2021 17:52:26 -0800
Message-Id: <20211124015226.3317994-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2] perf metric: Reduce multiplexing with duration_time
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

v2. Doesn't count duration_time in the metric_list_cmp function that
    sorts larger metrics first. Without this a metric with duration_time
    and an event is sorted the same as a metric with two events,
    possibly not allowing the first metric to share with the second.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 42 +++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index fffe02aae3ed..51c99cb08abf 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1115,13 +1115,27 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
 	return ret;
 }
 
+/**
+ * metric_list_cmp - list_sort comparator that sorts metrics with more events to
+ *                   the front. duration_time is excluded from the count.
+ */
 static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 			   const struct list_head *r)
 {
 	const struct metric *left = container_of(l, struct metric, nd);
 	const struct metric *right = container_of(r, struct metric, nd);
+	struct expr_id_data *data;
+	int left_count, right_count;
+
+	left_count = hashmap__size(left->pctx->ids);
+	if (!expr__get_id(left->pctx, "duration_time", &data))
+		left_count--;
+
+	right_count = hashmap__size(right->pctx->ids);
+	if (!expr__get_id(right->pctx, "duration_time", &data))
+		right_count--;
 
-	return hashmap__size(right->pctx->ids) - hashmap__size(left->pctx->ids);
+	return right_count - left_count;
 }
 
 /**
@@ -1299,14 +1313,16 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
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
@@ -1314,12 +1330,19 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
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
@@ -1387,7 +1410,8 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		ret = build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
-			ret = parse_ids(fake_pmu, combined, /*modifier=*/NULL,
+			ret = parse_ids(metric_no_merge, fake_pmu, combined,
+					/*modifier=*/NULL,
 					/*has_constraint=*/true,
 					&combined_evlist);
 		}
@@ -1435,7 +1459,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
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

