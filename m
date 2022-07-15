Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC2C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jul 2022 06:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiGOGjY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiGOGiU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Jul 2022 02:38:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D429877A7F
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 23:37:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c9a49a1a8so33682797b3.9
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 23:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zRY4q8dGu1/hQr60xv0fzIHPiiQD0Rve6HsFB3hsbJk=;
        b=AJi1iXRo01uKEFISeKI3HajnGrt0gt02mv4Vy4WtJ1TCuImtAZAWRiloR+sTyW7HeI
         QQVbdkFBZ4E0v3QBE4YOBmFbwTBLl2snB12NDtrJ22TbVj8NhFzET12RHwMXYNG1Scc4
         l1ueN/93t69/EIXH5G+VjObmwt6WWV1z7a85EFgtSLq355vNiM3p37CpT1BlIYFT6aDN
         VCCmZ2Kj/U8/P3bXH4atEWTHgLdWf8ToMX3usp9xzhgF32AqGFhPjmViPACvSYpS8Fhm
         BxJthOgOWyKbcF4teHyyPeWREdkbt+Uq9vW89Ni+Jwz5IoTegbw4j18bND2xvZ2Oz5gA
         uPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zRY4q8dGu1/hQr60xv0fzIHPiiQD0Rve6HsFB3hsbJk=;
        b=6K2BrwFXHFUe9D+JusdSP7fbA3pwKDkH1CmLHYkGW8p+oBQzqk7IZisgwjEzQTGOBs
         kU8ngaeKkknxANJSa8n6CIIUixfREbmGHCx3qblFUbh6pisuBnLAqWv99g0ns+VTpGfD
         Ma9mQavoVSo+cAeM6bRnEC8RWOPm2glB0t1tbBbM5Xl+UmLwHlE7C7FE071sUqacrD1U
         6OoroORLI65/X56raGLr3LMaxc2grfaUZRFuhk95xUzC8CNmVcTSj3DWIt2Uv3RzuH2o
         GBN6ROyxkVvLdJSU00aleo1D8Xv4m6HmIVAwiNVW+iKEp+H1R+ChsLfXuBPvrxRzfkyc
         JFHQ==
X-Gm-Message-State: AJIora/t8hSi1pDqWdelMHyd3fyk3uORQ7C88Cwu88Z7MYJfaMEhKNUB
        gTaqohDn0u2+37UxUDEQnHeBfOXsRZg/
X-Google-Smtp-Source: AGRyM1s9U2WGZvSsdr/Y3vq4x60yOs1ZiOiNMMnYoJyQNsjTcwuj+5f84KosQYEXShYBFhmQB8yNcQKZT6RJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a25:3b95:0:b0:66e:316c:159 with SMTP id
 i143-20020a253b95000000b0066e316c0159mr12911831yba.297.1657867068756; Thu, 14
 Jul 2022 23:37:48 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:52 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-15-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 14/15] perf metrics: Copy entire pmu_event in find metric
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
2.37.0.170.g444d1eabd0-goog

