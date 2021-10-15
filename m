Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3751C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88EE060E8B
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242295AbhJORYn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbhJORYW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49750C061777
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:22:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s66-20020a252c45000000b005ba35261459so12016222ybs.7
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f6wn4fabuMlVtL7qpUc33HnfvtzgC4H0xEuqazG2NeQ=;
        b=fojbJGxVvMUygS/e0YYm6PLcA4IJ4DyiLlpEKt4+nQH2KHRIDqPUCo6x7HETTeDYL0
         fvIELxLZ1BRdx1NM2bkrtD4kUI/tYBfICCZEBEdMDOYDOpE8Flb/nYaYbzjKFMguOInh
         Ai9LM3cW3hqzw468nANOZ3rdYMx7THMj/NzoM+5mi1yE/9lbffJnKEZr9+r8+CqTNa9F
         4bQwN7hPLhBy4bxez2gxDMtqajSeOvPqP+YG+MqGGqJbSc6zvUG0c70R7eq56GXypLCc
         OmL5TAaci+/se2UV7nHK3JOGUfnAyvNZF9UgNPRdg8A0CswtW6aADysfk005lXwK0EVX
         RiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f6wn4fabuMlVtL7qpUc33HnfvtzgC4H0xEuqazG2NeQ=;
        b=UF01PwV6ibbijS66UhDepDO6FJsPmHG2Cb5s7pUzH41Dr3xXlKfFYRx/6IAXsa9mGF
         +UdeRHLcYOQykNZ8OBtOUkdh03GFiOgjguPndhogLbLLPM+N0ZBpH5K/8T7//l4r2r8v
         c4s+tryL0ACk6DCwPpFg49UpVjo/xBWb44itTiZjrx6I+DGqdElndq8HJqyaeT06rCNP
         5Q0kvbfxVOT/GzKjLNbi1TL11tqAtrhu/pVJl3Kjgfwq/bFoTjazLIdaggcMNIbfGgVH
         oR8zNBEjlpX+VA6vPIS4ZskCzdoHOP4XnMZe5hWyI/Ja/0IVNCi7ubbj25LbH5+kBVkk
         eFRg==
X-Gm-Message-State: AOAM531YTKklpN5TRjWM+BwKFXeR9B9tWoW/GD8m0FGtd4alwYdyz/On
        EawIxObg2GEYgrl7Gu2eNQKEOUGr4z2n
X-Google-Smtp-Source: ABdhPJzbWwmG6LFo8JBVUEO5Sa9A9/qABtesv5tGZdPRqwq3hM/Rmrau9Iuk9QzfBpcuEdHv2zjUls+qyf+w
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:cc4a:: with SMTP id
 l71mr13907110ybf.41.1634318531470; Fri, 15 Oct 2021 10:22:11 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:25 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-15-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 14/21] perf parse-events: Add new "metric-id" term.
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

Add a new "metric-id" term to events so that metric parsing can set an
ID that can be reliably looked up. Metric parsing currently will turn a
metric like "instructions/cycles" into a parse events string of
"{instructions,cycles}:W". However, parse-events may change
"instructions" into "instructions:u" if perf_event_paranoid=2. When this
happens expr__resolve_id currently fails as stat-shadow adds the ID
"instructions:u" to match with the counter value and the metric tries to
look up the ID just "instructions".

A later patch will use the new term.

An example of the current problem:
$ echo -1 > /proc/sys/kernel/perf_event_paranoid
$ perf stat -M IPC /bin/true
 Performance counter stats for '/bin/true':

         1,217,161      inst_retired.any          #     0.97 IPC
         1,250,389      cpu_clk_unhalted.thread

       0.002064773 seconds time elapsed

       0.002378000 seconds user
       0.000000000 seconds sys

$ echo 2 > /proc/sys/kernel/perf_event_paranoid
$ perf stat -M IPC /bin/true
 Performance counter stats for '/bin/true':

           150,298      inst_retired.any:u        #      nan IPC
           187,095      cpu_clk_unhalted.thread:u

       0.002042731 seconds time elapsed

       0.000000000 seconds user
       0.002377000 seconds sys

Note: nan IPC is printed as an effect of "perf metric: Use NAN for
missing event IDs." but earlier versions of perf just fail with a parse
error and display no value.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c               | 17 +++++
 tools/perf/util/evsel.h               |  2 +
 tools/perf/util/parse-events-hybrid.c | 25 ++++---
 tools/perf/util/parse-events-hybrid.h |  4 +-
 tools/perf/util/parse-events.c        | 95 ++++++++++++++++++---------
 tools/perf/util/parse-events.h        |  5 +-
 tools/perf/util/parse-events.l        |  1 +
 tools/perf/util/pfm.c                 |  3 +-
 8 files changed, 107 insertions(+), 45 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..96ef6a4a7c14 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -410,6 +410,11 @@ struct evsel *evsel__clone(struct evsel *orig)
 		if (evsel->filter == NULL)
 			goto out_err;
 	}
+	if (orig->metric_id) {
+		evsel->metric_id = strdup(orig->metric_id);
+		if (evsel->metric_id == NULL)
+			goto out_err;
+	}
 	evsel->cgrp = cgroup__get(orig->cgrp);
 	evsel->tp_format = orig->tp_format;
 	evsel->handler = orig->handler;
@@ -779,6 +784,17 @@ const char *evsel__name(struct evsel *evsel)
 	return "unknown";
 }
 
+const char *evsel__metric_id(const struct evsel *evsel)
+{
+	if (evsel->metric_id)
+		return evsel->metric_id;
+
+	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE && evsel->tool_event)
+		return "duration_time";
+
+	return "unknown";
+}
+
 const char *evsel__group_name(struct evsel *evsel)
 {
 	return evsel->group_name ?: "anon group";
@@ -1423,6 +1439,7 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->pmu_name);
+	zfree(&evsel->metric_id);
 	evsel__zero_per_pkg(evsel);
 	hashmap__free(evsel->per_pkg_mask);
 	evsel->per_pkg_mask = NULL;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f7edfa8568a..45476a888942 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -68,6 +68,7 @@ struct evsel {
 		double			scale;
 		const char		*unit;
 		struct cgroup		*cgrp;
+		const char		*metric_id;
 		enum perf_tool_event	tool_event;
 		/* parse modifier helper */
 		int			exclude_GH;
@@ -261,6 +262,7 @@ bool evsel__match_bpf_counter_events(const char *name);
 
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
+const char *evsel__metric_id(const struct evsel *evsel);
 
 const char *evsel__group_name(struct evsel *evsel);
 int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index 7e44deee1343..9fc86971027b 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -39,6 +39,7 @@ static void config_hybrid_attr(struct perf_event_attr *attr,
 static int create_event_hybrid(__u32 config_type, int *idx,
 			       struct list_head *list,
 			       struct perf_event_attr *attr, const char *name,
+			       const char *metric_id,
 			       struct list_head *config_terms,
 			       struct perf_pmu *pmu)
 {
@@ -47,7 +48,7 @@ static int create_event_hybrid(__u32 config_type, int *idx,
 	__u64 config = attr->config;
 
 	config_hybrid_attr(attr, config_type, pmu->type);
-	evsel = parse_events__add_event_hybrid(list, idx, attr, name,
+	evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
 					       pmu, config_terms);
 	if (evsel)
 		evsel->pmu_name = strdup(pmu->name);
@@ -70,7 +71,8 @@ static int pmu_cmp(struct parse_events_state *parse_state,
 
 static int add_hw_hybrid(struct parse_events_state *parse_state,
 			 struct list_head *list, struct perf_event_attr *attr,
-			 const char *name, struct list_head *config_terms)
+			 const char *name, const char *metric_id,
+			 struct list_head *config_terms)
 {
 	struct perf_pmu *pmu;
 	int ret;
@@ -84,7 +86,7 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
 		copy_config_terms(&terms, config_terms);
 		ret = create_event_hybrid(PERF_TYPE_HARDWARE,
 					  &parse_state->idx, list, attr, name,
-					  &terms, pmu);
+					  metric_id, &terms, pmu);
 		free_config_terms(&terms);
 		if (ret)
 			return ret;
@@ -96,13 +98,14 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
 static int create_raw_event_hybrid(int *idx, struct list_head *list,
 				   struct perf_event_attr *attr,
 				   const char *name,
+				   const char *metric_id,
 				   struct list_head *config_terms,
 				   struct perf_pmu *pmu)
 {
 	struct evsel *evsel;
 
 	attr->type = pmu->type;
-	evsel = parse_events__add_event_hybrid(list, idx, attr, name,
+	evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
 					       pmu, config_terms);
 	if (evsel)
 		evsel->pmu_name = strdup(pmu->name);
@@ -114,7 +117,8 @@ static int create_raw_event_hybrid(int *idx, struct list_head *list,
 
 static int add_raw_hybrid(struct parse_events_state *parse_state,
 			  struct list_head *list, struct perf_event_attr *attr,
-			  const char *name, struct list_head *config_terms)
+			  const char *name, const char *metric_id,
+			  struct list_head *config_terms)
 {
 	struct perf_pmu *pmu;
 	int ret;
@@ -127,7 +131,7 @@ static int add_raw_hybrid(struct parse_events_state *parse_state,
 
 		copy_config_terms(&terms, config_terms);
 		ret = create_raw_event_hybrid(&parse_state->idx, list, attr,
-					      name, &terms, pmu);
+					      name, metric_id, &terms, pmu);
 		free_config_terms(&terms);
 		if (ret)
 			return ret;
@@ -139,7 +143,7 @@ static int add_raw_hybrid(struct parse_events_state *parse_state,
 int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 				     struct list_head *list,
 				     struct perf_event_attr *attr,
-				     const char *name,
+				     const char *name, const char *metric_id,
 				     struct list_head *config_terms,
 				     bool *hybrid)
 {
@@ -152,17 +156,18 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 
 	*hybrid = true;
 	if (attr->type != PERF_TYPE_RAW) {
-		return add_hw_hybrid(parse_state, list, attr, name,
+		return add_hw_hybrid(parse_state, list, attr, name, metric_id,
 				     config_terms);
 	}
 
-	return add_raw_hybrid(parse_state, list, attr, name,
+	return add_raw_hybrid(parse_state, list, attr, name, metric_id,
 			      config_terms);
 }
 
 int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
 				   struct perf_event_attr *attr,
 				   const char *name,
+				   const char *metric_id,
 				   struct list_head *config_terms,
 				   bool *hybrid,
 				   struct parse_events_state *parse_state)
@@ -183,7 +188,7 @@ int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
 
 		copy_config_terms(&terms, config_terms);
 		ret = create_event_hybrid(PERF_TYPE_HW_CACHE, idx, list,
-					  attr, name, &terms, pmu);
+					  attr, name, metric_id, &terms, pmu);
 		free_config_terms(&terms);
 		if (ret)
 			return ret;
diff --git a/tools/perf/util/parse-events-hybrid.h b/tools/perf/util/parse-events-hybrid.h
index 25a4a4f73f3a..cbc05fec02a2 100644
--- a/tools/perf/util/parse-events-hybrid.h
+++ b/tools/perf/util/parse-events-hybrid.h
@@ -11,13 +11,13 @@
 int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 				     struct list_head *list,
 				     struct perf_event_attr *attr,
-				     const char *name,
+				     const char *name, const char *metric_id,
 				     struct list_head *config_terms,
 				     bool *hybrid);
 
 int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
 				   struct perf_event_attr *attr,
-				   const char *name,
+				   const char *name, const char *metric_id,
 				   struct list_head *config_terms,
 				   bool *hybrid,
 				   struct parse_events_state *parse_state);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 88f181a985b7..89494b6213a6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -332,12 +332,7 @@ const char *event_type(int type)
 	return "unknown";
 }
 
-static int parse_events__is_name_term(struct parse_events_term *term)
-{
-	return term->type_term == PARSE_EVENTS__TERM_TYPE_NAME;
-}
-
-static const char *get_config_name(struct list_head *head_terms)
+static char *get_config_str(struct list_head *head_terms, int type_term)
 {
 	struct parse_events_term *term;
 
@@ -345,17 +340,27 @@ static const char *get_config_name(struct list_head *head_terms)
 		return NULL;
 
 	list_for_each_entry(term, head_terms, list)
-		if (parse_events__is_name_term(term))
+		if (term->type_term == type_term)
 			return term->val.str;
 
 	return NULL;
 }
 
+static char *get_config_metric_id(struct list_head *head_terms)
+{
+	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_METRIC_ID);
+}
+
+static char *get_config_name(struct list_head *head_terms)
+{
+	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
+}
+
 static struct evsel *
 __add_event(struct list_head *list, int *idx,
 	    struct perf_event_attr *attr,
 	    bool init_attr,
-	    const char *name, struct perf_pmu *pmu,
+	    const char *name, const char *metric_id, struct perf_pmu *pmu,
 	    struct list_head *config_terms, bool auto_merge_stats,
 	    const char *cpu_list)
 {
@@ -384,6 +389,9 @@ __add_event(struct list_head *list, int *idx,
 	if (name)
 		evsel->name = strdup(name);
 
+	if (metric_id)
+		evsel->metric_id = strdup(metric_id);
+
 	if (config_terms)
 		list_splice_init(config_terms, &evsel->config_terms);
 
@@ -394,18 +402,21 @@ __add_event(struct list_head *list, int *idx,
 }
 
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
-				      const char *name, struct perf_pmu *pmu)
+				      const char *name, const char *metric_id,
+				      struct perf_pmu *pmu)
 {
-	return __add_event(NULL, &idx, attr, false, name, pmu, NULL, false,
-			   NULL);
+	return __add_event(/*list=*/NULL, &idx, attr, /*init_attr=*/false, name,
+			   metric_id, pmu, /*config_terms=*/NULL,
+			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL);
 }
 
 static int add_event(struct list_head *list, int *idx,
 		     struct perf_event_attr *attr, const char *name,
-		     struct list_head *config_terms)
+		     const char *metric_id, struct list_head *config_terms)
 {
-	return __add_event(list, idx, attr, true, name, NULL, config_terms,
-			   false, NULL) ? 0 : -ENOMEM;
+	return __add_event(list, idx, attr, /*init_attr*/true, name, metric_id,
+			   /*pmu=*/NULL, config_terms,
+			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL) ? 0 : -ENOMEM;
 }
 
 static int add_event_tool(struct list_head *list, int *idx,
@@ -417,8 +428,10 @@ static int add_event_tool(struct list_head *list, int *idx,
 		.config = PERF_COUNT_SW_DUMMY,
 	};
 
-	evsel = __add_event(list, idx, &attr, true, NULL, NULL, NULL, false,
-			    "0");
+	evsel = __add_event(list, idx, &attr, /*init_attr=*/true, /*name=*/NULL,
+			    /*metric_id=*/NULL, /*pmu=*/NULL,
+			    /*config_terms=*/NULL, /*auto_merge_stats=*/false,
+			    /*cpu_list=*/"0");
 	if (!evsel)
 		return -ENOMEM;
 	evsel->tool_event = tool_event;
@@ -465,7 +478,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
 	char name[MAX_NAME_LEN];
-	const char *config_name;
+	const char *config_name, *metric_id;
 	int cache_type = -1, cache_op = -1, cache_result = -1;
 	char *op_result[2] = { op_result1, op_result2 };
 	int i, n, ret;
@@ -530,13 +543,17 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 			return -ENOMEM;
 	}
 
+	metric_id = get_config_metric_id(head_config);
 	ret = parse_events__add_cache_hybrid(list, idx, &attr,
-					     config_name ? : name, &config_terms,
+					     config_name ? : name,
+					     metric_id,
+					     &config_terms,
 					     &hybrid, parse_state);
 	if (hybrid)
 		goto out_free_terms;
 
-	ret = add_event(list, idx, &attr, config_name ? : name, &config_terms);
+	ret = add_event(list, idx, &attr, config_name ? : name, metric_id,
+			&config_terms);
 out_free_terms:
 	free_config_terms(&config_terms);
 	return ret;
@@ -1013,7 +1030,8 @@ int parse_events_add_breakpoint(struct list_head *list, int *idx,
 	attr.type = PERF_TYPE_BREAKPOINT;
 	attr.sample_period = 1;
 
-	return add_event(list, idx, &attr, NULL, NULL);
+	return add_event(list, idx, &attr, /*name=*/NULL, /*mertic_id=*/NULL,
+			 /*config_terms=*/NULL);
 }
 
 static int check_type_val(struct parse_events_term *term,
@@ -1058,6 +1076,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
 	[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
 	[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
+	[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
 };
 
 static bool config_term_shrinked;
@@ -1080,6 +1099,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
 	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
+	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
@@ -1170,6 +1190,9 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 		CHECK_TYPE_VAL(STR);
 		break;
+	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
+		CHECK_TYPE_VAL(STR);
+		break;
 	case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
 		CHECK_TYPE_VAL(NUM);
 		break;
@@ -1439,6 +1462,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
+	const char *name, *metric_id;
 	bool hybrid;
 	int ret;
 
@@ -1455,14 +1479,16 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			return -ENOMEM;
 	}
 
+	name = get_config_name(head_config);
+	metric_id = get_config_metric_id(head_config);
 	ret = parse_events__add_numeric_hybrid(parse_state, list, &attr,
-					       get_config_name(head_config),
+					       name, metric_id,
 					       &config_terms, &hybrid);
 	if (hybrid)
 		goto out_free_terms;
 
-	ret = add_event(list, &parse_state->idx, &attr,
-			get_config_name(head_config), &config_terms);
+	ret = add_event(list, &parse_state->idx, &attr, name, metric_id,
+			&config_terms);
 out_free_terms:
 	free_config_terms(&config_terms);
 	return ret;
@@ -1563,8 +1589,11 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	if (!head_config) {
 		attr.type = pmu->type;
-		evsel = __add_event(list, &parse_state->idx, &attr, true, NULL,
-				    pmu, NULL, auto_merge_stats, NULL);
+		evsel = __add_event(list, &parse_state->idx, &attr,
+				    /*init_attr=*/true, /*name=*/NULL,
+				    /*metric_id=*/NULL, pmu,
+				    /*config_terms=*/NULL, auto_merge_stats,
+				    /*cpu_list=*/NULL);
 		if (evsel) {
 			evsel->pmu_name = name ? strdup(name) : NULL;
 			evsel->use_uncore_alias = use_uncore_alias;
@@ -1617,9 +1646,10 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -EINVAL;
 	}
 
-	evsel = __add_event(list, &parse_state->idx, &attr, true,
-			    get_config_name(head_config), pmu,
-			    &config_terms, auto_merge_stats, NULL);
+	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
+			    get_config_name(head_config),
+			    get_config_metric_id(head_config), pmu,
+			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
 	if (!evsel)
 		return -ENOMEM;
 
@@ -3345,9 +3375,12 @@ char *parse_events_formats_error_string(char *additional_terms)
 
 struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
 					     struct perf_event_attr *attr,
-					     const char *name, struct perf_pmu *pmu,
+					     const char *name,
+					     const char *metric_id,
+					     struct perf_pmu *pmu,
 					     struct list_head *config_terms)
 {
-	return __add_event(list, idx, attr, true, name, pmu,
-			   config_terms, false, NULL);
+	return __add_event(list, idx, attr, /*init_attr=*/true, name, metric_id,
+			   pmu, config_terms, /*auto_merge_stats=*/false,
+			   /*cpu_list=*/NULL);
 }
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 54d24c24d074..c6c8343d311b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -87,6 +87,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_PERCORE,
 	PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT,
 	PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE,
+	PARSE_EVENTS__TERM_TYPE_METRIC_ID,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
@@ -199,7 +200,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 bool use_alias);
 
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
-				      const char *name, struct perf_pmu *pmu);
+				      const char *name, const char *metric_id,
+				      struct perf_pmu *pmu);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str,
@@ -267,6 +269,7 @@ int perf_pmu__test_parse_init(void);
 struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
 					     struct perf_event_attr *attr,
 					     const char *name,
+					     const char *metric_id,
 					     struct perf_pmu *pmu,
 					     struct list_head *config_terms);
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 47da7a0c5df4..b1e29b97d261 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -294,6 +294,7 @@ no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
+metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 r{num_raw_hex}		{ return raw(yyscanner); }
 r0x{num_raw_hex}	{ return raw(yyscanner); }
 ,			{ return ','; }
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 756295dedccc..f0bcfcab1a93 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -87,7 +87,8 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
 
 		pmu = perf_pmu__find_by_type((unsigned int)attr.type);
 		evsel = parse_events__add_event(evlist->core.nr_entries,
-						&attr, q, pmu);
+						&attr, q, /*metric_id=*/NULL,
+						pmu);
 		if (evsel == NULL)
 			goto error;
 
-- 
2.33.0.1079.g6e70778dc9-goog

