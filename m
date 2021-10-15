Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AACC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE2F610E8
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbhJORYH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242211AbhJORYA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC5C061765
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:21:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h185-20020a256cc2000000b005bdce4db0easo11907027ybc.12
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=67hrvxKmrEDoqY7ODAkkr1wTsxlPv5mHbdDtZjdw+GU=;
        b=f8kHxmedhO1R0K+9i6GOG0nuTd/sZDlgQIJvloglT6tyhgWNOkF4XCKl0L5LgHvCPb
         yKPW1UewXpabhw6SOgCWOteyOFuZ4V+r2U1k2eQVlDBRm+PHMFdNpb3WxZu8VH2QGgOz
         knifoARFvFbQJ0LDrglIAzxXRHsrA01fIa+Dn6nZ3BA0W1n4/4j0UWDKRquFbfrHhpdX
         GNci2yp7yy834uaJY7SR2bXmaaFMOUys5lDt3r2TXNKPvsSmoPgN1Yet9BQTm2FtGXI+
         pYnkr+s5Nxhu0HQYu5D/tKpL95ZACuY8NR+AtunmHHemCCxgd1EofVkRGQnNXSApjhWQ
         8THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=67hrvxKmrEDoqY7ODAkkr1wTsxlPv5mHbdDtZjdw+GU=;
        b=PxwpimQ4kd2FbfDMLTen/vq+U/trbqrmRJ+Jmy8XEveIgd3qJxfKypmwRtuhr3PHAP
         pt0gcif7AtFvYQ62TfdjdoG1YIlggRoBtX23JZVRGTCvwbvesYjnTUqx0FEgK3OHvpQe
         O8m464MBQJ/aBIUgc99u86gf5d2+csyY5t0320wQduTn6jVHwAjlWjhfAXiEe2rLIsqM
         kf3bDQukHil69si2WSQdWYZjaT2ybYjg9TBi7r/oH7s5yKCjPCI8K0y+XNP8/821m8p2
         M8R2GKCPVSnzq+KcE3HiAP1UBrWI1jObiRkwra6cEjpG9nUYjQ8q3bwRJexHnveGhGd2
         97Gg==
X-Gm-Message-State: AOAM533O5eQtdFNxihdkAjeIMci28QyqAl6f7W5esdS81l1infx9hZ4A
        cGv/xIvL2RU3VTPfMdIucHA1i/KZvrS0
X-Google-Smtp-Source: ABdhPJxVuaFBPGvUhQX3ywGL8Ota2VOz2dm/cwh9fgnnj0a24LL+KC6Pvk5+bJ1e2kvpmK19vj2La9Hz6zn8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:c907:: with SMTP id
 z7mr15292249ybf.172.1634318512696; Fri, 15 Oct 2021 10:21:52 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:17 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-7-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 06/21] perf metric: Add documentation and rename a variable.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Documentation to make current functionality clearer. Rename a variable
called 'metric' to 'metric_name' as it can be ambiguous as to whether a
string is the name of a metric or the expression.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 59 ++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 139f4a793f92..3e5f02938452 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -776,13 +776,27 @@ int __weak arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused)
 
 struct metricgroup_add_iter_data {
 	struct list_head *metric_list;
-	const char *metric;
+	const char *metric_name;
 	struct expr_ids *ids;
 	int *ret;
 	bool *has_match;
 	bool metric_no_group;
 };
 
+/**
+ * __add_metric - Add a metric to metric_list.
+ * @metric_list: The list the metric is added to.
+ * @pe: The pmu_event containing the metric to be added.
+ * @metric_no_group: Should events written to events be grouped "{}" or
+ *                   global. Grouping is the default but due to multiplexing the
+ *                   user may override.
+ * @runtime: A special argument for the parser only known at runtime.
+ * @mp: The pointer to a location holding the first metric added to metric
+ *      list. It is initialized here if this is the first metric.
+ * @parent: The last entry in a linked list of metrics being
+ *          added/resolved. This is maintained to detect recursion.
+ * @ids: Storage for parent list.
+ */
 static int __add_metric(struct list_head *metric_list,
 			const struct pmu_event *pe,
 			bool metric_no_group,
@@ -1076,7 +1090,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
 	struct metric *m = NULL;
 	int ret;
 
-	if (!match_pe_metric(pe, d->metric))
+	if (!match_pe_metric(pe, d->metric_name))
 		return 0;
 
 	ret = add_metric(d->metric_list, pe, d->metric_no_group, &m, NULL, d->ids);
@@ -1095,7 +1109,22 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
 	return ret;
 }
 
-static int metricgroup__add_metric(const char *metric, bool metric_no_group,
+/**
+ * metricgroup__add_metric - Find and add a metric, or a metric group.
+ * @metric_name: The name of the metric or metric group. For example, "IPC"
+ *               could be the name of a metric and "TopDownL1" the name of a
+ *               metric group.
+ * @metric_no_group: Should events written to events be grouped "{}" or
+ *                   global. Grouping is the default but due to multiplexing the
+ *                   user may override.
+ * @events: an out argument string of events that need to be parsed and
+ *          associated with the metric. For example, the metric "IPC" would
+ *          create an events string like "{instructions,cycles}:W".
+ * @metric_list: The list that the metric or metric group are added to.
+ * @map: The map that is searched for metrics, most commonly the table for the
+ *       architecture perf is running upon.
+ */
+static int metricgroup__add_metric(const char *metric_name, bool metric_no_group,
 				   struct strbuf *events,
 				   struct list_head *metric_list,
 				   const struct pmu_events_map *map)
@@ -1107,7 +1136,11 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	int i, ret;
 	bool has_match = false;
 
-	map_for_each_metric(pe, i, map, metric) {
+	/*
+	 * Iterate over all metrics seeing if metric matches either the name or
+	 * group. When it does add the metric to the list.
+	 */
+	map_for_each_metric(pe, i, map, metric_name) {
 		has_match = true;
 		m = NULL;
 
@@ -1130,7 +1163,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 			.fn = metricgroup__add_metric_sys_event_iter,
 			.data = (void *) &(struct metricgroup_add_iter_data) {
 				.metric_list = &list,
-				.metric = metric,
+				.metric_name = metric_name,
 				.metric_no_group = metric_no_group,
 				.ids = &ids,
 				.has_match = &has_match,
@@ -1169,6 +1202,22 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	return ret;
 }
 
+/**
+ * metricgroup__add_metric_list - Find and add metrics, or metric groups,
+ *                                specified in a list.
+ * @list: the list of metrics or metric groups. For example, "IPC,CPI,TopDownL1"
+ *        would match the IPC and CPI metrics, and TopDownL1 would match all
+ *        the metrics in the TopDownL1 group.
+ * @metric_no_group: Should events written to events be grouped "{}" or
+ *                   global. Grouping is the default but due to multiplexing the
+ *                   user may override.
+ * @events: an out argument string of events that need to be parsed and
+ *          associated with the metric. For example, the metric "IPC" would
+ *          create an events string like "{instructions,cycles}:W".
+ * @metric_list: The list that metrics are added to.
+ * @map: The map that is searched for metrics, most commonly the table for the
+ *       architecture perf is running upon.
+ */
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct strbuf *events,
 					struct list_head *metric_list,
-- 
2.33.0.1079.g6e70778dc9-goog

