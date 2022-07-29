Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD79C19F2B
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 07:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiG2HpG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiG2Ho4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0BE820CC
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k16-20020a252410000000b006718984ef63so3311582ybk.3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Erk4wRaNj75eOg4s5q1IE3PwAROzueG5Y9xXx5fRq5Q=;
        b=ceYcCHEt7cwQaf9fLFr6VwUHtuxA9NHhZDIFt4KvpdG/SeMYeJPImEw0TanZvYTkSO
         jxaYirq2ZfEhQN4eL6O7B494n5LDZqNi3ksV3esyIHxLlRwdNuHXt0C7VsHp4kogIIFw
         d/Id+nA+3IB1S9Yua+EMBvoGJ+VYKvhLZ/LNfHKbURQIO2jtj3BLHo98MOs4o42FrlyD
         cVgmPQ0brptiV3OAElYPAPf0rQzWbLQDDEivGL/N8NiTvYuD+Z3myQ/FBSGQvZB3twvl
         Xei2Q34PCWYF7BbzHnwodGeINBAiTH6WeEhnnWqYbi9AMWD3W0+IjeN2SVm5+Ev+JMTM
         eXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Erk4wRaNj75eOg4s5q1IE3PwAROzueG5Y9xXx5fRq5Q=;
        b=xe0iM3Jy7vFx5oiSOxNunKsvcoA7vSEl9eMrQtaP3sLTChs8TypnReQa57Qpr/rnS1
         J2I/eG22K0nsc65xpMMXbwd/Gbn4+4cYjgSiQkExz7twPiBFRu2NxyitvgQ1kpS7mi3E
         Gvps28yOPH4p/JgVHYoR84mKj6cFcZRT2CeRSsIvwytBHpjLNmEmTnNq83xkCMZ2UL1j
         S6CnqsyAyJGHLFen5bTphXBKfadGKHO693yvM5hlyGLNJOwMgGb+k7CowE8j1V8Uj9jS
         xh54dBRByofgmUE/pr4n47hUHWcesbrYYd/O/imhX/pg6G66iRPnb2AaT6udlyJ/sbHT
         yDuQ==
X-Gm-Message-State: ACgBeo0HUGTE4yVuGuZA/cbeD7Nr4KSKtjiB4egDnE3UMbTUVixSNzqc
        iTls3q3awgxnZwlmdV+NqIz0vA2iz1Km
X-Google-Smtp-Source: AA6agR6TGWhOWiiJl2Sd9EKoOSeuAgEOCnNPhdEE5jN6zK7mLkK9MFuLjnjdzhv40GzTcEJLgEjZoKdkXIei
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a0d:e004:0:b0:31f:311d:2351 with SMTP id
 j4-20020a0de004000000b0031f311d2351mr1986253ywe.10.1659080680507; Fri, 29 Jul
 2022 00:44:40 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:49 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-16-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 15/17] perf metrics: Copy entire pmu_event in find metric
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
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
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The pmu_event passed to the pmu_events_table_for_each_event is invalid
after the loop. Copy the entire struct in metricgroup__find_metric.
Reduce the scope of this function to static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 33 ++++++++++++++++++---------------
 tools/perf/util/metricgroup.h |  2 --
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8ef44f4b5e9a..95f4b46dba09 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -879,6 +879,10 @@ struct metricgroup_add_iter_data {
 	const struct pmu_events_table *table;
 };
 
+static bool metricgroup__find_metric(const char *metric,
+				     const struct pmu_events_table *table,
+				     struct pmu_event *pe);
+
 static int add_metric(struct list_head *metric_list,
 		      const struct pmu_event *pe,
 		      const char *modifier,
@@ -914,7 +918,7 @@ static int resolve_metric(struct list_head *metric_list,
 	size_t bkt;
 	struct to_resolve {
 		/* The metric to resolve. */
-		const struct pmu_event *pe;
+		struct pmu_event pe;
 		/*
 		 * The key in the IDs map, this may differ from in case,
 		 * etc. from pe->metric_name.
@@ -928,16 +932,15 @@ static int resolve_metric(struct list_head *metric_list,
 	 * the pending array.
 	 */
 	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
-		const struct pmu_event *pe;
+		struct pmu_event pe;
 
-		pe = metricgroup__find_metric(cur->key, table);
-		if (pe) {
+		if (metricgroup__find_metric(cur->key, table, &pe)) {
 			pending = realloc(pending,
 					(pending_cnt + 1) * sizeof(struct to_resolve));
 			if (!pending)
 				return -ENOMEM;
 
-			pending[pending_cnt].pe = pe;
+			memcpy(&pending[pending_cnt].pe, &pe, sizeof(pe));
 			pending[pending_cnt].key = cur->key;
 			pending_cnt++;
 		}
@@ -952,7 +955,7 @@ static int resolve_metric(struct list_head *metric_list,
 	 * context.
 	 */
 	for (i = 0; i < pending_cnt; i++) {
-		ret = add_metric(metric_list, pending[i].pe, modifier, metric_no_group,
+		ret = add_metric(metric_list, &pending[i].pe, modifier, metric_no_group,
 				root_metric, visited, table);
 		if (ret)
 			break;
@@ -1073,7 +1076,7 @@ static int __add_metric(struct list_head *metric_list,
 
 struct metricgroup__find_metric_data {
 	const char *metric;
-	const struct pmu_event *pe;
+	struct pmu_event *pe;
 };
 
 static int metricgroup__find_metric_callback(const struct pmu_event *pe,
@@ -1085,21 +1088,21 @@ static int metricgroup__find_metric_callback(const struct pmu_event *pe,
 	if (!match_metric(pe->metric_name, data->metric))
 		return 0;
 
-	data->pe = pe;
-	return -1;
+	memcpy(data->pe, pe, sizeof(*pe));
+	return 1;
 }
 
-const struct pmu_event *metricgroup__find_metric(const char *metric,
-						 const struct pmu_events_table *table)
+static bool metricgroup__find_metric(const char *metric,
+				     const struct pmu_events_table *table,
+				     struct pmu_event *pe)
 {
 	struct metricgroup__find_metric_data data = {
 		.metric = metric,
-		.pe = NULL,
+		.pe = pe,
 	};
 
-	pmu_events_table_for_each_event(table, metricgroup__find_metric_callback, &data);
-
-	return data.pe;
+	return pmu_events_table_for_each_event(table, metricgroup__find_metric_callback, &data)
+		? true : false;
 }
 
 static int add_metric(struct list_head *metric_list,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index f54d170043e9..016b3b1a289a 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -69,8 +69,6 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_group,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
-const struct pmu_event *metricgroup__find_metric(const char *metric,
-						 const struct pmu_events_table *table);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_events_table *table,
 				   const char *str,
-- 
2.37.1.455.g008518b4e5-goog

