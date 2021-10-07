Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4222EC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0C561245
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243209AbhJGRBS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243062AbhJGRAz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:00:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44030C0613E3
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:58:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a5-20020a258045000000b005b9cbabe735so8600061ybn.23
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Pgojksq8BrRXGp92I3V8xTPjI8vmbOO11bkWWnPU+6o=;
        b=nIlU7p0KgjgWo9NZhcwNSjYzhjcFYPZr88XHMd73IClV1LdJbN5kmKYY92r/ZCneTS
         86vGztcrbM4XqfaIRCyDWU7QuctO1y/1YqaTusncn7vLhw03Hvosau91UKYUkMGGiCnB
         LBIY4ksZberrIW67gBsgbBTcIYzA/yguBhtKa0xiE1zJpmtNkWsJ4CvaL3KPDftuqpq6
         QyuPROqoON1AuVTrzpf26l50l/9fS1eLZ264S8WnsNrE4DP7ZH05FQ4ENKB/TQh3XEH4
         rthfkdTRpFwyHjlyVaJ+VCca+vcLSkDn/4+eMtTbJr189nM2L9M6W2rrtN2LtJRdRC/b
         l9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pgojksq8BrRXGp92I3V8xTPjI8vmbOO11bkWWnPU+6o=;
        b=ro0nr/OSMNlXGgjpm2YcmP/yuMiD/o+QFz2HbZZ66eqIlSVfl+iAhGmGGCmm9KAWFb
         uHjDzZk2hNQ+O7LfFdBqrUbpn4gYIgIR6QyV3nbu3AaFBL88wdOkYs9pHoqC7yCkex05
         APL6uzuGM1XDJAcvEMRDqW6MBXLxUSs3c9pGepL3eqHcqswOwFBVptpaySzrci2Kucey
         eehC3hEw5ins72rgR4fAZAVs9UCzzvkNeYgxB3+r3Mr66lcu0soNUNYo6OaFiU2EOkeS
         H0vHtKPXv6Ma+H6A7tUlPyQ0Xo1ijRfQ11V9mo5161GjholVdQejOGI/nNp23HdLhVAA
         eQXA==
X-Gm-Message-State: AOAM53015sLkobJRbfNgPAw7+luHCNxdYyF8t1hROP4G7z9Pe1gY/gHT
        /uGLD0SFoHFpNfX0twVm8zBtC63BnOCO
X-Google-Smtp-Source: ABdhPJwETAr/eGhphepbu0pOZyuuVbZHis/CcdlzSg4QbQndGxickl5/GwnpmBBB4rlM24zBJDSv4U05Fh1s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a25:4289:: with SMTP id
 p131mr5779007yba.141.1633625900380; Thu, 07 Oct 2021 09:58:20 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:47 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-22-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 21/21] perf metric: Allow modifiers on metrics.
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

By allowing modifiers on metrics we can, for example, gather the
same metric for kernel and user mode. On a SkylakeX with
TopDownL1 this gives:

$ perf stat -M TopDownL1:u,TopDownL1:k -a sleep 2

 Performance counter stats for 'system wide':

       849,855,577      uops_issued.any:k         #     0.06 Bad_Speculation:k
                                                  #     0.51 Backend_Bound:k          (16.71%)
     1,995,257,996      cycles:k
                                                  # 7981031984.00 SLOTS:k
                                                  #     0.35 Frontend_Bound:k
                                                  #     0.08 Retiring:k               (16.71%)
     2,791,940,753      idq_uops_not_delivered.core:k                                     (16.71%)
       641,961,928      uops_retired.retire_slots:k                                     (16.71%)
        72,239,337      int_misc.recovery_cycles:k                                     (16.71%)
     2,294,413,647      uops_issued.any:u         #     0.04 Bad_Speculation:u
                                                  #     0.39 Backend_Bound:u          (16.78%)
     1,333,248,940      cycles:u
                                                  # 5332995760.00 SLOTS:u
                                                  #     0.16 Frontend_Bound:u
                                                  #     0.40 Retiring:u               (16.78%)
       858,517,081      idq_uops_not_delivered.core:u                                     (16.78%)
     2,153,789,582      uops_retired.retire_slots:u                                     (16.78%)
        19,373,627      int_misc.recovery_cycles:u                                     (16.78%)
        31,503,661      cpu_clk_unhalted.one_thread_active:k #     0.18 CoreIPC_SMT:k            (16.73%)
       315,454,104      inst_retired.any:k        # 315454104.00 Instructions:k       (16.73%)
        42,533,729      cpu_clk_unhalted.ref_xclk:k                                     (16.73%)
     2,043,119,037      cpu_clk_unhalted.thread:k                                     (16.73%)
        28,843,803      cpu_clk_unhalted.one_thread_active:u #     1.55 CoreIPC_SMT:u            (16.60%)
     2,153,353,869      inst_retired.any:u        # 2153353869.00 Instructions:u      (16.60%)
        28,844,743      cpu_clk_unhalted.ref_xclk:u                                     (16.60%)
     1,387,544,378      cpu_clk_unhalted.thread:u                                     (16.60%)
       308,031,603      inst_retired.any:k        #     0.15 CoreIPC:k                (33.19%)
     2,036,774,753      cycles:k                                                      (33.19%)
     1,994,344,281      inst_retired.any:u        #     1.59 CoreIPC:u                (33.18%)
     1,251,538,227      cycles:u                                                      (33.18%)

       2.000342948 seconds time elapsed

Modifiers are naively copy and pasted on to events, this can yield errors like:

$ perf stat -M Kernel_Utilization:k -a sleep 2
event syntax error: '..d.thread:k/kk,cpu_clk_unhalted.thread/metric-id=cpu_clk_unhalted.thread/k..'
                                  \___ Bad modifier

 Usage: perf stat [<options>] [<command>]

    -M, --metrics <metric/metric group list>
                          monitor specified metrics or metric groups (separated by ,)

When modifiers are present with constraints, from
--metric-no-group or the NMI watchdog, they are no longer placed
in the same set - which may miss deduplicating events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 120 ++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c588243a2d53..a28f61d59fe9 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -85,6 +85,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
 	struct metric_expr *expr, *tmp;
 
 	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
+		free((char *)expr->metric_name);
 		free(expr->metric_refs);
 		free(expr->metric_events);
 		free(expr);
@@ -130,6 +131,8 @@ struct metric {
 	struct expr_parse_ctx *pctx;
 	/** The name of the metric such as "IPC". */
 	const char *metric_name;
+	/** Modifier on the metric such as "u" or NULL for none. */
+	const char *modifier;
 	/** The expression to parse, for example, "instructions/cycles". */
 	const char *metric_expr;
 	/**
@@ -186,6 +189,7 @@ static bool metricgroup__has_constraint(const struct pmu_event *pe)
 }
 
 static struct metric *metric__new(const struct pmu_event *pe,
+				  const char *modifier,
 				  bool metric_no_group,
 				  int runtime)
 {
@@ -202,6 +206,12 @@ static struct metric *metric__new(const struct pmu_event *pe,
 	}
 
 	m->metric_name = pe->metric_name;
+	m->modifier = modifier ? strdup(modifier) : NULL;
+	if (modifier && !m->modifier) {
+		free(m);
+		expr__ctx_free(m->pctx);
+		return NULL;
+	}
 	m->metric_expr = pe->metric_expr;
 	m->metric_unit = pe->unit;
 	m->pctx->runtime = runtime;
@@ -216,6 +226,7 @@ static void metric__free(struct metric *m)
 {
 	free(m->metric_refs);
 	expr__ctx_free(m->pctx);
+	free((char *)m->modifier);
 	free(m);
 }
 
@@ -645,7 +656,7 @@ static int decode_metric_id(struct strbuf *sb, const char *x)
 	return 0;
 }
 
-static int decode_all_metric_ids(struct evlist *perf_evlist)
+static int decode_all_metric_ids(struct evlist *perf_evlist, const char *modifier)
 {
 	struct evsel *ev;
 	struct strbuf sb = STRBUF_INIT;
@@ -675,10 +686,24 @@ static int decode_all_metric_ids(struct evlist *perf_evlist)
 		 * give a more friendly display version.
 		 */
 		if (strstr(ev->name, "metric-id=")) {
+			bool has_slash = false;
+
 			free(ev->name);
-			for (cur = strchr(sb.buf, '@') ; cur; cur = strchr(++cur, '@'))
+			for (cur = strchr(sb.buf, '@') ; cur; cur = strchr(++cur, '@')) {
 				*cur = '/';
+				has_slash = true;
+			}
 
+			if (modifier) {
+				if (!has_slash && !strchr(sb.buf, ':')) {
+					ret = strbuf_addch(&sb, ':');
+					if (ret)
+						break;
+				}
+				ret = strbuf_addstr(&sb, modifier);
+				if (ret)
+					break;
+			}
 			ev->name = strdup(sb.buf);
 			if (!ev->name) {
 				ret = -ENOMEM;
@@ -692,6 +717,7 @@ static int decode_all_metric_ids(struct evlist *perf_evlist)
 
 static int metricgroup__build_event_string(struct strbuf *events,
 					   const struct expr_parse_ctx *ctx,
+					   const char *modifier,
 					   bool has_constraint)
 {
 	struct hashmap_entry *cur;
@@ -765,6 +791,10 @@ static int metricgroup__build_event_string(struct strbuf *events,
 			ret = strbuf_addstr(events, sep + 1);
 			RETURN_IF_NON_ZERO(ret);
 		}
+		if (modifier) {
+			ret = strbuf_addstr(events, modifier);
+			RETURN_IF_NON_ZERO(ret);
+		}
 	}
 	if (has_duration) {
 		if (no_group) {
@@ -798,6 +828,7 @@ struct visited_metric {
 struct metricgroup_add_iter_data {
 	struct list_head *metric_list;
 	const char *metric_name;
+	const char *modifier;
 	int *ret;
 	bool *has_match;
 	bool metric_no_group;
@@ -808,6 +839,7 @@ struct metricgroup_add_iter_data {
 
 static int add_metric(struct list_head *metric_list,
 		      const struct pmu_event *pe,
+		      const char *modifier,
 		      bool metric_no_group,
 		      struct metric *root_metric,
 		      const struct visited_metric *visited,
@@ -817,6 +849,7 @@ static int add_metric(struct list_head *metric_list,
  * resolve_metric - Locate metrics within the root metric and recursively add
  *                    references to them.
  * @metric_list: The list the metric is added to.
+ * @modifier: if non-null event modifiers like "u".
  * @metric_no_group: Should events written to events be grouped "{}" or
  *                   global. Grouping is the default but due to multiplexing the
  *                   user may override.
@@ -829,6 +862,7 @@ static int add_metric(struct list_head *metric_list,
  *       architecture perf is running upon.
  */
 static int resolve_metric(struct list_head *metric_list,
+			  const char *modifier,
 			  bool metric_no_group,
 			  struct metric *root_metric,
 			  const struct visited_metric *visited,
@@ -876,7 +910,7 @@ static int resolve_metric(struct list_head *metric_list,
 	 * context.
 	 */
 	for (i = 0; i < pending_cnt; i++) {
-		ret = add_metric(metric_list, pending[i].pe, metric_no_group,
+		ret = add_metric(metric_list, pending[i].pe, modifier, metric_no_group,
 				root_metric, visited, map);
 		if (ret)
 			break;
@@ -890,6 +924,7 @@ static int resolve_metric(struct list_head *metric_list,
  * __add_metric - Add a metric to metric_list.
  * @metric_list: The list the metric is added to.
  * @pe: The pmu_event containing the metric to be added.
+ * @modifier: if non-null event modifiers like "u".
  * @metric_no_group: Should events written to events be grouped "{}" or
  *                   global. Grouping is the default but due to multiplexing the
  *                   user may override.
@@ -904,6 +939,7 @@ static int resolve_metric(struct list_head *metric_list,
  */
 static int __add_metric(struct list_head *metric_list,
 			const struct pmu_event *pe,
+			const char *modifier,
 			bool metric_no_group,
 			int runtime,
 			struct metric *root_metric,
@@ -930,7 +966,7 @@ static int __add_metric(struct list_head *metric_list,
 		 * This metric is the root of a tree and may reference other
 		 * metrics that are added recursively.
 		 */
-		root_metric = metric__new(pe, metric_no_group, runtime);
+		root_metric = metric__new(pe, modifier, metric_no_group, runtime);
 		if (!root_metric)
 			return -ENOMEM;
 
@@ -979,7 +1015,7 @@ static int __add_metric(struct list_head *metric_list,
 		ret = -EINVAL;
 	} else {
 		/* Resolve referenced metrics. */
-		ret = resolve_metric(metric_list, metric_no_group, root_metric,
+		ret = resolve_metric(metric_list, modifier, metric_no_group, root_metric,
 				     &visited_node, map);
 	}
 
@@ -1021,6 +1057,7 @@ const struct pmu_event *metricgroup__find_metric(const char *metric,
 
 static int add_metric(struct list_head *metric_list,
 		      const struct pmu_event *pe,
+		      const char *modifier,
 		      bool metric_no_group,
 		      struct metric *root_metric,
 		      const struct visited_metric *visited,
@@ -1031,7 +1068,7 @@ static int add_metric(struct list_head *metric_list,
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 	if (!strstr(pe->metric_expr, "?")) {
-		ret = __add_metric(metric_list, pe, metric_no_group, 0,
+		ret = __add_metric(metric_list, pe, modifier, metric_no_group, 0,
 				   root_metric, visited, map);
 	} else {
 		int j, count;
@@ -1044,7 +1081,7 @@ static int add_metric(struct list_head *metric_list,
 		 */
 
 		for (j = 0; j < count && !ret; j++)
-			ret = __add_metric(metric_list, pe, metric_no_group, j,
+			ret = __add_metric(metric_list, pe, modifier, metric_no_group, j,
 					root_metric, visited, map);
 	}
 
@@ -1060,7 +1097,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
 	if (!match_pe_metric(pe, d->metric_name))
 		return 0;
 
-	ret = add_metric(d->metric_list, pe, d->metric_no_group,
+	ret = add_metric(d->metric_list, pe, d->modifier, d->metric_no_group,
 			 d->root_metric, d->visited, d->map);
 	if (ret)
 		goto out;
@@ -1086,6 +1123,7 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
  * @metric_name: The name of the metric or metric group. For example, "IPC"
  *               could be the name of a metric and "TopDownL1" the name of a
  *               metric group.
+ * @modifier: if non-null event modifiers like "u".
  * @metric_no_group: Should events written to events be grouped "{}" or
  *                   global. Grouping is the default but due to multiplexing the
  *                   user may override.
@@ -1093,7 +1131,8 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
  * @map: The map that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
  */
-static int metricgroup__add_metric(const char *metric_name, bool metric_no_group,
+static int metricgroup__add_metric(const char *metric_name, const char *modifier,
+				   bool metric_no_group,
 				   struct list_head *metric_list,
 				   const struct pmu_events_map *map)
 {
@@ -1108,7 +1147,7 @@ static int metricgroup__add_metric(const char *metric_name, bool metric_no_group
 	 */
 	map_for_each_metric(pe, i, map, metric_name) {
 		has_match = true;
-		ret = add_metric(&list, pe, metric_no_group,
+		ret = add_metric(&list, pe, modifier, metric_no_group,
 				 /*root_metric=*/NULL,
 				 /*visited_metrics=*/NULL, map);
 		if (ret)
@@ -1121,6 +1160,7 @@ static int metricgroup__add_metric(const char *metric_name, bool metric_no_group
 			.data = (void *) &(struct metricgroup_add_iter_data) {
 				.metric_list = &list,
 				.metric_name = metric_name,
+				.modifier = modifier,
 				.metric_no_group = metric_no_group,
 				.has_match = &has_match,
 				.ret = &ret,
@@ -1160,26 +1200,31 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct list_head *metric_list,
 					const struct pmu_events_map *map)
 {
-	char *llist, *nlist, *p;
+	char *list_itr, *list_copy, *metric_name, *modifier;
 	int ret, count = 0;
 
-	nlist = strdup(list);
-	if (!nlist)
+	list_copy = strdup(list);
+	if (!list_copy)
 		return -ENOMEM;
-	llist = nlist;
+	list_itr = list_copy;
+
+	while ((metric_name = strsep(&list_itr, ",")) != NULL) {
+		modifier = strchr(metric_name, ':');
+		if (modifier)
+			*modifier++ = '\0';
 
-	while ((p = strsep(&llist, ",")) != NULL) {
-		ret = metricgroup__add_metric(p, metric_no_group, metric_list,
+		ret = metricgroup__add_metric(metric_name, modifier,
+					      metric_no_group, metric_list,
 					      map);
 		if (ret == -EINVAL)
-			pr_err("Cannot find metric or group `%s'\n", p);
+			pr_err("Cannot find metric or group `%s'\n", metric_name);
 
 		if (ret)
 			break;
 
 		count++;
 	}
-	free(nlist);
+	free(list_copy);
 
 	if (!ret) {
 		/*
@@ -1225,7 +1270,7 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 		return -ENOMEM;
 
 	list_for_each_entry(m, metric_list, nd) {
-		if (m->has_constraint) {
+		if (m->has_constraint && !m->modifier) {
 			hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
 				dup = strdup(cur->key);
 				if (!dup) {
@@ -1250,11 +1295,12 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
  *             evlist. The encoded metric_ids are decoded.
  * @fake_pmu: used when testing metrics not supported by the current CPU.
  * @ids: the event identifiers parsed from a metric.
+ * @modifier: any modifiers added to the events.
  * @has_constraint: false if events should be placed in a weak group.
  * @out_evlist: the created list of events.
  */
 static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
-		     bool has_constraint, struct evlist **out_evlist)
+		     const char *modifier, bool has_constraint, struct evlist **out_evlist)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
@@ -1262,7 +1308,8 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
 	int ret;
 
 	*out_evlist = NULL;
-	ret = metricgroup__build_event_string(&events, ids, has_constraint);
+	ret = metricgroup__build_event_string(&events, ids, modifier,
+					      has_constraint);
 	if (ret)
 		return ret;
 
@@ -1278,7 +1325,7 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
 		parse_events_print_error(&parse_error, events.buf);
 		goto err_out;
 	}
-	ret = decode_all_metric_ids(parsed_evlist);
+	ret = decode_all_metric_ids(parsed_evlist, modifier);
 	if (ret)
 		goto err_out;
 
@@ -1318,7 +1365,8 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		ret = build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
-			ret = parse_ids(fake_pmu, combined, /*has_constraint=*/true,
+			ret = parse_ids(fake_pmu, combined, /*modifier=*/NULL,
+					/*has_constraint=*/true,
 					&combined_evlist);
 		}
 		if (combined)
@@ -1349,6 +1397,12 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 				if (n->evlist == NULL)
 					continue;
 
+				if ((!m->modifier && n->modifier) ||
+				    (m->modifier && !n->modifier) ||
+				    (m->modifier && n->modifier &&
+					    strcmp(m->modifier, n->modifier)))
+					continue;
+
 				if (expr__subset_of_ids(n->pctx, m->pctx)) {
 					pr_debug("Events in '%s' fully contained within '%s'\n",
 						 m->metric_name, n->metric_name);
@@ -1359,8 +1413,8 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 			}
 		}
 		if (!metric_evlist) {
-			ret = parse_ids(fake_pmu, m->pctx, m->has_constraint,
-					&m->evlist);
+			ret = parse_ids(fake_pmu, m->pctx, m->modifier,
+					m->has_constraint, &m->evlist);
 			if (ret)
 				goto out;
 
@@ -1385,7 +1439,21 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		expr->metric_refs = m->metric_refs;
 		m->metric_refs = NULL;
 		expr->metric_expr = m->metric_expr;
-		expr->metric_name = m->metric_name;
+		if (m->modifier) {
+			char *tmp;
+
+			if (asprintf(&tmp, "%s:%s", m->metric_name, m->modifier) < 0)
+				expr->metric_name = NULL;
+			else
+				expr->metric_name = tmp;
+		} else
+			expr->metric_name = strdup(m->metric_name);
+
+		if (!expr->metric_name) {
+			ret = -ENOMEM;
+			free(metric_events);
+			goto out;
+		}
 		expr->metric_unit = m->metric_unit;
 		expr->metric_events = metric_events;
 		expr->runtime = m->pctx->runtime;
-- 
2.33.0.882.g93a45727a2-goog

