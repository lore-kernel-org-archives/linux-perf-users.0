Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB9C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6309E61151
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbhJORYk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242290AbhJORYQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BBEC06176F
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:22:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j193-20020a2523ca000000b005b789d71d9aso11863404ybj.21
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I7q/UjXdgOVhTC5GRLzsbIXbn3jS9TUQiER0V51CZnY=;
        b=H9ynp2+TZNqpvFyYsKv9M+/LQFnrMELfpNaVZV0tNa7avoQ6rT0P5Ko+YeMs7kILQ6
         yypmThaZ8T1aodSpP5O/98bLBo3HkBA8AgqS/KiR3la1vcDvEOUYSPdfwJapn0FIwPbD
         nV02GjeL2cexyr3aOsMImwboJwOLusED6tLIOY1Vfiuj2g7fEJTBjxmLFHnlElSL93LW
         MZFq0OljAn++uJcy7jT+az6m0q3wvCR06mKJR7Ue6zeNp00Fkxm261/WUUlQS25LZ88a
         jJljmfw2O6hQlvXZctDsQqQOWOWzEhNJBfOscwPwNgUL1P4UcnORdPui5Lz/9IbG45zv
         +9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I7q/UjXdgOVhTC5GRLzsbIXbn3jS9TUQiER0V51CZnY=;
        b=hDgSR1myEfZ0gSg86PSCKCVhYdeP1Kg/BKa2KLO7QX3F9LMCwF6JhFrOC4fouf+vxA
         LF+hoNq27SQvDlsSI9mXemZRWCGjGD5DNkq8UJQrqhuWke0zZ+/EI6WGrtqTzAZHg6Fe
         2gMw6V0Zz1LONOcRXWbEa0E0fZJxNyWjYlkDfyoHLY5vtMekUHhXk+zIZxMvoc2tnZYt
         9qfO8I42GL/cYExtKEG3+acMpWeIS3U3s1GMRnAZSAj+9wOHMS4L9UTml39OzbfaQJi8
         lRi7nGASdYYFPLGX93Wg/PZVthwYg2uaPpiK6Xgk5Bg0P0NQ45+NrWjMAT9cEzh5BeLJ
         1t7g==
X-Gm-Message-State: AOAM531ighGKwT4OFQJYTPcSTzEQqvL5OQNoSYovpRgGBSTuzhCxwNdu
        OJkjdBlH0aojHiS/PXRdL9O3833i2PAC
X-Google-Smtp-Source: ABdhPJyCbQnPdFff6jfCdAn98bI3MZ9LR0EspxzQWEel78ubStf0j5YS/6rrE4APgucefT+7FtmdFzqdzTqe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a5b:846:: with SMTP id v6mr13126824ybq.457.1634318528822;
 Fri, 15 Oct 2021 10:22:08 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:24 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-14-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 13/21] perf parse-events: Add const to evsel name
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

The evsel name is strdup-ed before assignment and so can be const.
A later change will add another similar string. Using const makes it
clearer that these are not out arguments.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events-hybrid.c | 15 +++++++++------
 tools/perf/util/parse-events-hybrid.h |  6 ++++--
 tools/perf/util/parse-events.c        | 15 ++++++++-------
 tools/perf/util/parse-events.h        |  7 ++++---
 tools/perf/util/pmu.c                 |  2 +-
 tools/perf/util/pmu.h                 |  2 +-
 6 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index b234d95fb10a..7e44deee1343 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -38,7 +38,7 @@ static void config_hybrid_attr(struct perf_event_attr *attr,
 
 static int create_event_hybrid(__u32 config_type, int *idx,
 			       struct list_head *list,
-			       struct perf_event_attr *attr, char *name,
+			       struct perf_event_attr *attr, const char *name,
 			       struct list_head *config_terms,
 			       struct perf_pmu *pmu)
 {
@@ -70,7 +70,7 @@ static int pmu_cmp(struct parse_events_state *parse_state,
 
 static int add_hw_hybrid(struct parse_events_state *parse_state,
 			 struct list_head *list, struct perf_event_attr *attr,
-			 char *name, struct list_head *config_terms)
+			 const char *name, struct list_head *config_terms)
 {
 	struct perf_pmu *pmu;
 	int ret;
@@ -94,7 +94,8 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
 }
 
 static int create_raw_event_hybrid(int *idx, struct list_head *list,
-				   struct perf_event_attr *attr, char *name,
+				   struct perf_event_attr *attr,
+				   const char *name,
 				   struct list_head *config_terms,
 				   struct perf_pmu *pmu)
 {
@@ -113,7 +114,7 @@ static int create_raw_event_hybrid(int *idx, struct list_head *list,
 
 static int add_raw_hybrid(struct parse_events_state *parse_state,
 			  struct list_head *list, struct perf_event_attr *attr,
-			  char *name, struct list_head *config_terms)
+			  const char *name, struct list_head *config_terms)
 {
 	struct perf_pmu *pmu;
 	int ret;
@@ -138,7 +139,8 @@ static int add_raw_hybrid(struct parse_events_state *parse_state,
 int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 				     struct list_head *list,
 				     struct perf_event_attr *attr,
-				     char *name, struct list_head *config_terms,
+				     const char *name,
+				     struct list_head *config_terms,
 				     bool *hybrid)
 {
 	*hybrid = false;
@@ -159,7 +161,8 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 }
 
 int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
-				   struct perf_event_attr *attr, char *name,
+				   struct perf_event_attr *attr,
+				   const char *name,
 				   struct list_head *config_terms,
 				   bool *hybrid,
 				   struct parse_events_state *parse_state)
diff --git a/tools/perf/util/parse-events-hybrid.h b/tools/perf/util/parse-events-hybrid.h
index f33bd67aa851..25a4a4f73f3a 100644
--- a/tools/perf/util/parse-events-hybrid.h
+++ b/tools/perf/util/parse-events-hybrid.h
@@ -11,11 +11,13 @@
 int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 				     struct list_head *list,
 				     struct perf_event_attr *attr,
-				     char *name, struct list_head *config_terms,
+				     const char *name,
+				     struct list_head *config_terms,
 				     bool *hybrid);
 
 int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
-				   struct perf_event_attr *attr, char *name,
+				   struct perf_event_attr *attr,
+				   const char *name,
 				   struct list_head *config_terms,
 				   bool *hybrid,
 				   struct parse_events_state *parse_state);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1acac3e13b32..88f181a985b7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -337,7 +337,7 @@ static int parse_events__is_name_term(struct parse_events_term *term)
 	return term->type_term == PARSE_EVENTS__TERM_TYPE_NAME;
 }
 
-static char *get_config_name(struct list_head *head_terms)
+static const char *get_config_name(struct list_head *head_terms)
 {
 	struct parse_events_term *term;
 
@@ -355,7 +355,7 @@ static struct evsel *
 __add_event(struct list_head *list, int *idx,
 	    struct perf_event_attr *attr,
 	    bool init_attr,
-	    char *name, struct perf_pmu *pmu,
+	    const char *name, struct perf_pmu *pmu,
 	    struct list_head *config_terms, bool auto_merge_stats,
 	    const char *cpu_list)
 {
@@ -394,14 +394,14 @@ __add_event(struct list_head *list, int *idx,
 }
 
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
-					char *name, struct perf_pmu *pmu)
+				      const char *name, struct perf_pmu *pmu)
 {
 	return __add_event(NULL, &idx, attr, false, name, pmu, NULL, false,
 			   NULL);
 }
 
 static int add_event(struct list_head *list, int *idx,
-		     struct perf_event_attr *attr, char *name,
+		     struct perf_event_attr *attr, const char *name,
 		     struct list_head *config_terms)
 {
 	return __add_event(list, idx, attr, true, name, NULL, config_terms,
@@ -464,7 +464,8 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
-	char name[MAX_NAME_LEN], *config_name;
+	char name[MAX_NAME_LEN];
+	const char *config_name;
 	int cache_type = -1, cache_op = -1, cache_result = -1;
 	char *op_result[2] = { op_result1, op_result2 };
 	int i, n, ret;
@@ -2027,7 +2028,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 	return 0;
 }
 
-int parse_events_name(struct list_head *list, char *name)
+int parse_events_name(struct list_head *list, const char *name)
 {
 	struct evsel *evsel;
 
@@ -3344,7 +3345,7 @@ char *parse_events_formats_error_string(char *additional_terms)
 
 struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
 					     struct perf_event_attr *attr,
-					     char *name, struct perf_pmu *pmu,
+					     const char *name, struct perf_pmu *pmu,
 					     struct list_head *config_terms)
 {
 	return __add_event(list, idx, attr, true, name, pmu,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b32ed3064c49..54d24c24d074 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -162,7 +162,7 @@ void parse_events_terms__purge(struct list_head *terms);
 void parse_events__clear_array(struct parse_events_array *a);
 int parse_events__modifier_event(struct list_head *list, char *str, bool add);
 int parse_events__modifier_group(struct list_head *list, char *event_mod);
-int parse_events_name(struct list_head *list, char *name);
+int parse_events_name(struct list_head *list, const char *name);
 int parse_events_add_tracepoint(struct list_head *list, int *idx,
 				const char *sys, const char *event,
 				struct parse_events_error *error,
@@ -199,7 +199,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 bool use_alias);
 
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
-					char *name, struct perf_pmu *pmu);
+				      const char *name, struct perf_pmu *pmu);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str,
@@ -266,7 +266,8 @@ int perf_pmu__test_parse_init(void);
 
 struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
 					     struct perf_event_attr *attr,
-					     char *name, struct perf_pmu *pmu,
+					     const char *name,
+					     struct perf_pmu *pmu,
 					     struct list_head *config_terms);
 
 #endif /* __PERF_PARSE_EVENTS_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cdd6c3f6caf1..9b5039bf909a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1906,7 +1906,7 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 }
 
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
-				   char *name)
+				   const char *name)
 {
 	struct perf_pmu_format *format;
 	__u64 masks = 0, bits;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index cc9f9e001347..f9743eab07b6 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -134,7 +134,7 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
-				   char *name);
+				   const char *name);
 
 bool perf_pmu__has_hybrid(void);
 int perf_pmu__match(char *pattern, char *name, char *tok);
-- 
2.33.0.1079.g6e70778dc9-goog

