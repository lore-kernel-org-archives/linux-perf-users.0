Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8A5C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31BC6115A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhKHNnN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:43:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240047AbhKHNnN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkYYk+MOYhDH07s3D3s/T62QjX5MogBsiMOnZ8hwpng=;
        b=VRvV4REuOxuazi+oepyuOSSthy7fwH+YtaRaYc5HUGWUpPXnwi/kmQ5j5kZO4IOZZvjpdp
        tHKJK+Uzpf0d08NZwH6v7y9d+XlwJOuNr1SGB1M/LFqXKByZ34G2ePPPuAcclVNNGr/v02
        kQ/9+tllU6IKkRaatca7UhKNeesM73E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-7TOvIeOjNZmdPuPSuIkCRQ-1; Mon, 08 Nov 2021 08:39:22 -0500
X-MC-Unique: 7TOvIeOjNZmdPuPSuIkCRQ-1
Received: by mail-wm1-f70.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso10171178wmb.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkYYk+MOYhDH07s3D3s/T62QjX5MogBsiMOnZ8hwpng=;
        b=CiyBpaxmkcbU69cRpE7dMCOclmZ47jxPvu8d7v2HhOVvW05cvUJVF/ZjAT23saX1ta
         ZHieyT1wfXUN3hxRotuDuOb017UNsOTPBb+7jp55LgZqydSxjp32pbCABzSOXO/8oV75
         OtpkbiuXapO0x4i7Tb9j+tshQaM7W8NmURKnSsG177AF29W80MblMjfc8bBGjeFvGPur
         2jshLjyZFF1fTDay0exg1CFiTfywhAW6jISXL2o4mq+/cpTBEZAdcdQvEnbxzz33qPX/
         qdZ8FdCdUCxiT2URZorixAPrPbqC11F4RURg3S1dziPoYD7Dyoz4j82EKmlIEerifubQ
         sfBA==
X-Gm-Message-State: AOAM530+shoFbAJAGteVkWaKZOMMTKtlUZS2VjJinW85S7i7IrclCQ8H
        f88wtRvKK2g5vO9+ZAnq3W5gnTMPdtwAhtweizhJ70N/rUiJwNTIsUSDfBFdmtAi8GZpm30CS5f
        8+DY7lLobQib5XVNo+Yxs3fn58BFjMg==
X-Received: by 2002:a5d:584c:: with SMTP id i12mr61483477wrf.95.1636378760879;
        Mon, 08 Nov 2021 05:39:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7jxWJ2U2vDHFnfFJ4Rc8NzlplOWtX7Gb7dfnwjOTuY0EqUOtLrA1wdepux3krIZW8RpsWoQ==
X-Received: by 2002:a5d:584c:: with SMTP id i12mr61483446wrf.95.1636378760671;
        Mon, 08 Nov 2021 05:39:20 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id h13sm17288820wrx.82.2021.11.08.05.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:39:20 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 20/59] perf tools: Pass parse_state all the way down to __add_event
Date:   Mon,  8 Nov 2021 14:36:31 +0100
Message-Id: <20211108133710.1352822-21-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

So we can provide event allocation callbacks.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events-hybrid.c | 24 +++++++------
 tools/perf/util/parse-events-hybrid.h |  6 ++--
 tools/perf/util/parse-events.c        | 49 +++++++++++++++------------
 tools/perf/util/parse-events.h        | 15 ++++----
 tools/perf/util/parse-events.y        | 21 ++++--------
 5 files changed, 60 insertions(+), 55 deletions(-)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index de901e74ce3d..49e9047d20d9 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -36,7 +36,8 @@ static void config_hybrid_attr(struct perf_event_attr *attr,
 	attr->config = attr->config | ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT);
 }
 
-static int create_event_hybrid(__u32 config_type, int *idx,
+static int create_event_hybrid(struct parse_events_state *parse_state,
+			       __u32 config_type,
 			       struct list_head *list,
 			       struct perf_event_attr *attr, const char *name,
 			       const char *metric_id,
@@ -48,7 +49,7 @@ static int create_event_hybrid(__u32 config_type, int *idx,
 	__u64 config = attr->config;
 
 	config_hybrid_attr(attr, config_type, pmu->type);
-	evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
+	evsel = parse_events__add_event_hybrid(parse_state, list, attr, name, metric_id,
 					       pmu, config_terms);
 	if (evsel)
 		evsel->pmu_name = strdup(pmu->name);
@@ -84,8 +85,8 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
 			continue;
 
 		copy_config_terms(&terms, config_terms);
-		ret = create_event_hybrid(PERF_TYPE_HARDWARE,
-					  &parse_state->idx, list, attr, name,
+		ret = create_event_hybrid(parse_state, PERF_TYPE_HARDWARE,
+					  list, attr, name,
 					  metric_id, &terms, pmu);
 		free_config_terms(&terms);
 		if (ret)
@@ -95,7 +96,8 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
 	return 0;
 }
 
-static int create_raw_event_hybrid(int *idx, struct list_head *list,
+static int create_raw_event_hybrid(struct parse_events_state *parse_state,
+				   struct list_head *list,
 				   struct perf_event_attr *attr,
 				   const char *name,
 				   const char *metric_id,
@@ -105,7 +107,7 @@ static int create_raw_event_hybrid(int *idx, struct list_head *list,
 	struct evsel *evsel;
 
 	attr->type = pmu->type;
-	evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
+	evsel = parse_events__add_event_hybrid(parse_state, list, attr, name, metric_id,
 					       pmu, config_terms);
 	if (evsel)
 		evsel->pmu_name = strdup(pmu->name);
@@ -130,7 +132,7 @@ static int add_raw_hybrid(struct parse_events_state *parse_state,
 			continue;
 
 		copy_config_terms(&terms, config_terms);
-		ret = create_raw_event_hybrid(&parse_state->idx, list, attr,
+		ret = create_raw_event_hybrid(parse_state, list, attr,
 					      name, metric_id, &terms, pmu);
 		free_config_terms(&terms);
 		if (ret)
@@ -164,13 +166,13 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 			      config_terms);
 }
 
-int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
+int parse_events__add_cache_hybrid(struct parse_events_state *parse_state,
+				   struct list_head *list,
 				   struct perf_event_attr *attr,
 				   const char *name,
 				   const char *metric_id,
 				   struct list_head *config_terms,
-				   bool *hybrid,
-				   struct parse_events_state *parse_state)
+				   bool *hybrid)
 {
 	struct perf_pmu *pmu;
 	int ret;
@@ -187,7 +189,7 @@ int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
 			continue;
 
 		copy_config_terms(&terms, config_terms);
-		ret = create_event_hybrid(PERF_TYPE_HW_CACHE, idx, list,
+		ret = create_event_hybrid(parse_state, PERF_TYPE_HW_CACHE, list,
 					  attr, name, metric_id, &terms, pmu);
 		free_config_terms(&terms);
 		if (ret)
diff --git a/tools/perf/util/parse-events-hybrid.h b/tools/perf/util/parse-events-hybrid.h
index cbc05fec02a2..7e4a88a87846 100644
--- a/tools/perf/util/parse-events-hybrid.h
+++ b/tools/perf/util/parse-events-hybrid.h
@@ -15,11 +15,11 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 				     struct list_head *config_terms,
 				     bool *hybrid);
 
-int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
+int parse_events__add_cache_hybrid(struct parse_events_state *parse_state,
+				   struct list_head *list,
 				   struct perf_event_attr *attr,
 				   const char *name, const char *metric_id,
 				   struct list_head *config_terms,
-				   bool *hybrid,
-				   struct parse_events_state *parse_state);
+				   bool *hybrid);
 
 #endif /* __PERF_PARSE_EVENTS_HYBRID_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2bacbab86b09..d3ad2c89c7a2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -357,7 +357,8 @@ static char *get_config_name(struct list_head *head_terms)
 }
 
 static struct evsel *
-__add_event(struct list_head *list, int *idx,
+__add_event(struct parse_events_state *parse_state,
+	    struct list_head *list,
 	    struct perf_event_attr *attr,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
@@ -367,6 +368,7 @@ __add_event(struct list_head *list, int *idx,
 	struct evsel *evsel;
 	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
 			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
+	int *idx = &parse_state->idx;
 
 	if (pmu && attr->type == PERF_TYPE_RAW)
 		perf_pmu__warn_invalid_config(pmu, attr->config, name);
@@ -401,25 +403,28 @@ __add_event(struct list_head *list, int *idx,
 	return evsel;
 }
 
-struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
+struct evsel *parse_events__add_event(struct parse_events_state *parse_state,
+				      struct perf_event_attr *attr,
 				      const char *name, const char *metric_id,
 				      struct perf_pmu *pmu)
 {
-	return __add_event(/*list=*/NULL, &idx, attr, /*init_attr=*/false, name,
+	return __add_event(parse_state, /*list=*/NULL, attr, /*init_attr=*/false, name,
 			   metric_id, pmu, /*config_terms=*/NULL,
 			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL);
 }
 
-static int add_event(struct list_head *list, int *idx,
+static int add_event(struct parse_events_state *parse_state,
+		     struct list_head *list,
 		     struct perf_event_attr *attr, const char *name,
 		     const char *metric_id, struct list_head *config_terms)
 {
-	return __add_event(list, idx, attr, /*init_attr*/true, name, metric_id,
+	return __add_event(parse_state, list, attr, /*init_attr*/true, name, metric_id,
 			   /*pmu=*/NULL, config_terms,
 			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL) ? 0 : -ENOMEM;
 }
 
-static int add_event_tool(struct list_head *list, int *idx,
+static int add_event_tool(struct parse_events_state *parse_state,
+			  struct list_head *list,
 			  enum perf_tool_event tool_event)
 {
 	struct evsel *evsel;
@@ -428,7 +433,7 @@ static int add_event_tool(struct list_head *list, int *idx,
 		.config = PERF_COUNT_SW_DUMMY,
 	};
 
-	evsel = __add_event(list, idx, &attr, /*init_attr=*/true, /*name=*/NULL,
+	evsel = __add_event(parse_state, list, &attr, /*init_attr=*/true, /*name=*/NULL,
 			    /*metric_id=*/NULL, /*pmu=*/NULL,
 			    /*config_terms=*/NULL, /*auto_merge_stats=*/false,
 			    /*cpu_list=*/"0");
@@ -469,11 +474,11 @@ static int config_attr(struct perf_event_attr *attr,
 		       struct parse_events_error *err,
 		       config_term_func_t config_term);
 
-int parse_events_add_cache(struct list_head *list, int *idx,
+int parse_events_add_cache(struct parse_events_state *parse_state,
+			   struct list_head *list,
 			   char *type, char *op_result1, char *op_result2,
 			   struct parse_events_error *err,
-			   struct list_head *head_config,
-			   struct parse_events_state *parse_state)
+			   struct list_head *head_config)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
@@ -544,15 +549,15 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 	}
 
 	metric_id = get_config_metric_id(head_config);
-	ret = parse_events__add_cache_hybrid(list, idx, &attr,
+	ret = parse_events__add_cache_hybrid(parse_state, list, &attr,
 					     config_name ? : name,
 					     metric_id,
 					     &config_terms,
-					     &hybrid, parse_state);
+					     &hybrid);
 	if (hybrid)
 		goto out_free_terms;
 
-	ret = add_event(list, idx, &attr, config_name ? : name, metric_id,
+	ret = add_event(parse_state, list, &attr, config_name ? : name, metric_id,
 			&config_terms);
 out_free_terms:
 	free_config_terms(&config_terms);
@@ -1006,7 +1011,8 @@ do {					\
 	return 0;
 }
 
-int parse_events_add_breakpoint(struct list_head *list, int *idx,
+int parse_events_add_breakpoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				u64 addr, char *type, u64 len)
 {
 	struct perf_event_attr attr;
@@ -1030,7 +1036,7 @@ int parse_events_add_breakpoint(struct list_head *list, int *idx,
 	attr.type = PERF_TYPE_BREAKPOINT;
 	attr.sample_period = 1;
 
-	return add_event(list, idx, &attr, /*name=*/NULL, /*mertic_id=*/NULL,
+	return add_event(parse_state, list, &attr, /*name=*/NULL, /*mertic_id=*/NULL,
 			 /*config_terms=*/NULL);
 }
 
@@ -1487,7 +1493,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 	if (hybrid)
 		goto out_free_terms;
 
-	ret = add_event(list, &parse_state->idx, &attr, name, metric_id,
+	ret = add_event(parse_state, list, &attr, name, metric_id,
 			&config_terms);
 out_free_terms:
 	free_config_terms(&config_terms);
@@ -1498,7 +1504,7 @@ int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  int tool_event)
 {
-	return add_event_tool(list, &parse_state->idx, tool_event);
+	return add_event_tool(parse_state, list, tool_event);
 }
 
 static bool config_term_percore(struct list_head *config_terms)
@@ -1589,7 +1595,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	if (!head_config) {
 		attr.type = pmu->type;
-		evsel = __add_event(list, &parse_state->idx, &attr,
+		evsel = __add_event(parse_state, list, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
 				    /*config_terms=*/NULL, auto_merge_stats,
@@ -1646,7 +1652,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -EINVAL;
 	}
 
-	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
+	evsel = __add_event(parse_state, list, &attr, /*init_attr=*/true,
 			    get_config_name(head_config),
 			    get_config_metric_id(head_config), pmu,
 			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
@@ -3380,14 +3386,15 @@ char *parse_events_formats_error_string(char *additional_terms)
 	return NULL;
 }
 
-struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
+struct evsel *parse_events__add_event_hybrid(struct parse_events_state *parse_state,
+					     struct list_head *list,
 					     struct perf_event_attr *attr,
 					     const char *name,
 					     const char *metric_id,
 					     struct perf_pmu *pmu,
 					     struct list_head *config_terms)
 {
-	return __add_event(list, idx, attr, /*init_attr=*/true, name, metric_id,
+	return __add_event(parse_state, list, attr, /*init_attr=*/true, name, metric_id,
 			   pmu, config_terms, /*auto_merge_stats=*/false,
 			   /*cpu_list=*/NULL);
 }
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index f60a661a2247..218a282d8b3d 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -186,12 +186,13 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  int tool_event);
-int parse_events_add_cache(struct list_head *list, int *idx,
+int parse_events_add_cache(struct parse_events_state *parse_state,
+			   struct list_head *list,
 			   char *type, char *op_result1, char *op_result2,
 			   struct parse_events_error *error,
-			   struct list_head *head_config,
-			   struct parse_events_state *parse_state);
-int parse_events_add_breakpoint(struct list_head *list, int *idx,
+			   struct list_head *head_config);
+int parse_events_add_breakpoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				u64 addr, char *type, u64 len);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
@@ -199,7 +200,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 bool auto_merge_stats,
 			 bool use_alias);
 
-struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
+struct evsel *parse_events__add_event(struct parse_events_state *parse_state,
+				      struct perf_event_attr *attr,
 				      const char *name, const char *metric_id,
 				      struct perf_pmu *pmu);
 
@@ -268,7 +270,8 @@ static inline bool is_sdt_event(char *str __maybe_unused)
 
 int perf_pmu__test_parse_init(void);
 
-struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
+struct evsel *parse_events__add_event_hybrid(struct parse_events_state *parse_state,
+					     struct list_head *list,
 					     struct perf_event_attr *attr,
 					     const char *name,
 					     const char *metric_id,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 2d60f3cbe42b..30c382d4a605 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -478,8 +478,7 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_e
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, $5, error, $6,
-				     parse_state);
+	err = parse_events_add_cache(parse_state, list, $1, $3, $5, error, $6);
 	parse_events_terms__delete($6);
 	free($1);
 	free($3);
@@ -500,8 +499,7 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, NULL, error, $4,
-				     parse_state);
+	err = parse_events_add_cache(parse_state, list, $1, $3, NULL, error, $4);
 	parse_events_terms__delete($4);
 	free($1);
 	free($3);
@@ -521,8 +519,7 @@ PE_NAME_CACHE_TYPE opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, NULL, NULL, error, $2,
-				     parse_state);
+	err = parse_events_add_cache(parse_state, list, $1, NULL, NULL, error, $2);
 	parse_events_terms__delete($2);
 	free($1);
 	if (err) {
@@ -541,8 +538,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_breakpoint(list, &parse_state->idx,
-					  $2, $6, $4);
+	err = parse_events_add_breakpoint(parse_state, list, $2, $6, $4);
 	free($6);
 	if (err) {
 		free(list);
@@ -558,8 +554,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	if (parse_events_add_breakpoint(list, &parse_state->idx,
-					$2, NULL, $4)) {
+	if (parse_events_add_breakpoint(parse_state, list, $2, NULL, $4)) {
 		free(list);
 		YYABORT;
 	}
@@ -574,8 +569,7 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_breakpoint(list, &parse_state->idx,
-					  $2, $4, 0);
+	err = parse_events_add_breakpoint(parse_state, list, $2, $4, 0);
 	free($4);
 	if (err) {
 		free(list);
@@ -591,8 +585,7 @@ PE_PREFIX_MEM PE_VALUE sep_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	if (parse_events_add_breakpoint(list, &parse_state->idx,
-					$2, NULL, 0)) {
+	if (parse_events_add_breakpoint(parse_state, list, $2, NULL, 0)) {
 		free(list);
 		YYABORT;
 	}
-- 
2.31.1

