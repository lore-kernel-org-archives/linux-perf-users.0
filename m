Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D585C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089EA61040
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbhJGRA0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbhJGRAO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:00:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF364C061760
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:58:00 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id o10-20020a65614a000000b002850cb8c434so182418pgv.13
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DKk7gYA97LusEn3hP/5WaAwdmMnNvOjC0L8CB2TRhaQ=;
        b=kEnpQJVS+QVYLkv0k9EOl9/iPyWj38/UT53Rbedj4smDTSO+jBirKuwgrq2PQ+BJrI
         bP7LIJVhbgROPmtSiXP118Q6rS4h4kyQ4NQ3ySD97KG3j5bt5eZX0Ybe7/OQVFiYng2Q
         wSpbXAU+a/iprUk17ZUijnUlllj+dWGWfQfyWaIJIrx/T0JI82vKZHWLtx30wambRS5s
         5QuzFnz5p5CEJ9MRUFm5iV2gdMSjF9FAZW01MM87LVx3CiUd+C8Qxmu3nXCzpgeTok45
         WJ9LVTirynlDgRFnBSW50yk3ZoXLf52zlI93wVyusOBErNKzVK2SvBfpRVOLM6YMxp2P
         NKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DKk7gYA97LusEn3hP/5WaAwdmMnNvOjC0L8CB2TRhaQ=;
        b=rj89apno7Yq17icN24a8aQuttxClUOQgrI9f4N0U+Xn1KVZWESgpueNArf31xqD08j
         eBU/SiXJiajD692QW4pAUDH4tDDLFxpCHDxEsw384++LW9srg305RfnXvvDoIWse2xok
         vUI6PqUGYM1e4Y4QyI3qoUM3ZTu5kemY9zonWfmuwcg6BrcCSaRN8pafjA8YTMsMlLhH
         IPyr+WWqeZVidt+eGDldoXAi7Z6NUohaIRa52gKMxLTH4UP8GgNZ/t+4uuwhw2KOV+5P
         Rwm8q6aa/KBeFgN9UzX0nf1nn84Hxc2eJVwAS7Gihn4T/9bzlMl2qKvJ9Likp7euw4zI
         mbOQ==
X-Gm-Message-State: AOAM531J3IVLukss/3L9FHsbIqUlizGfUqopYPfnEbd2D8fH67bnBes4
        Z0B3IdJJudA7ssZOMuXXml+5W6jpsIFK
X-Google-Smtp-Source: ABdhPJzpQM+MA/evANtsp+4SqzeKkjrtx3INNqf/nYRBUaNLA35Ieixes9qg0cFnNb3n56F7su+rtMdrK6GO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a17:90a:4dc6:: with SMTP id
 r6mr6707646pjl.5.1633625880291; Thu, 07 Oct 2021 09:58:00 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:39 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-14-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 13/21] perf parse-events: Add const to evsel name
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

The evsel name is strdup-ed before assignment and so can be const.
A later change will add another similar string. Using const makes it
clearer that these are not out arguments.

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
2.33.0.882.g93a45727a2-goog

