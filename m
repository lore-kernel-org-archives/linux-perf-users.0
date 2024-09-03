Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA91A0BD1
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Sep 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358844; cv=none; b=CCQ7+2ZFXytMCTzNkCKnEUGGGeYROFtkUYcSTbdex6s74B3BUAueR15pHzdK4eoz+PfGdJhMYQVI29yAnOd5VoVbSbuJ8CrAaDXPORJgJectq8ANKmVWerybv/aMlufGlFNyJ16luxOPh60Zw6PeNo9B1nP1F5mh7qyRoIDcsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358844; c=relaxed/simple;
	bh=seF5ziZN6wVptRQ12GO/NFeP89lPyAgneSV109A4QQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwqq4LmizrQH+pVTFkRdi1yrF7m02vhKC85f5ne8okng6RIfajMbw9lMVC0j4sWuDKyXft5a1m+bQzZ1k9WmWwsznPA+VU+qlXVocIl5PQhX1VNYspcJlK3QBiTKt371XbsLKHmg0M1dYSU5muJeF7gYlr7uZbxzuH3HzgLMjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xaoCKjDT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xaoCKjDT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42c7856ed66so24884335e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725358840; x=1725963640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSIRbj8Rb/jfALOc0Otj8KTwtef0MK65RgsPT2QJ0Go=;
        b=xaoCKjDTvHZsj7Wz3yogzUUTt5yZ2AnsBpLE5KrC2w68GEFq5CprkA1bT0XNLk9bEU
         wbxskt8lVPqSaaDSb25xplne5iDxW+RxSSnYbjS3tKTr5EURcwhJm7jI4pRmuMldztw6
         FS8XpnWgo2IsN6p9ZEd4tfZf6g9ep0PfPX+L+6T1GS/sPb73ZodB2VQVlbM0E/w8bgMa
         9zl1uc/Q0ekYKBQ8nXQHCxlywOaV9Xf/ZnS5qAZCEbGphqtYcZriBEV8ukdBv1KyhEhn
         cajh59VJ6e+/uGzayI3mADQ5of5ON+Do8TCf0+QMIzkd7SPdyvD3fQGOUr3RWPnheLLH
         PVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725358840; x=1725963640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSIRbj8Rb/jfALOc0Otj8KTwtef0MK65RgsPT2QJ0Go=;
        b=Aae7FAGMYW+/js2WnrIJPZaT3UBYVnW2+sPYek+AUNWT9ybtjdykyBmDza7Vx9ws0N
         J0al9Vx2R9UDjjwcB84vjqX8Gb8lltfU5BXZH/IOHMg1SQfBxLbTGmwwHm+xba6TPgRZ
         PNEGnTLVWXJvTx1plzlEQOh15RbqCcW72PzWCTcgHNoXEfdMD7jk53W3SImqrZO3l+sy
         /L/+lCgRQmxz1HZXVHSjcImSQxDDRrJ+MWzHf+yllpciz+ny/K9F5isC8FT0bcS0DN8K
         cKrkvcPX2NrzrXGdUwX+zxTqlTNDlB1Bg49Vb57xWIgfwuQPEJxE/memMOf7lXob9roA
         VfPg==
X-Forwarded-Encrypted: i=1; AJvYcCXx32x7Bg78ppl4dowZNA7lR9WUE1qnVaPEUtMbb4/vANwJpdqm468Gfmmz4Ls08nhgeqQIrN+2f9Xi57C9bKRH@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWkjWcz0h9qGVTSt/6BkCYrn1uVMn8M3Ehp7k5NMlrOWLiYpN
	hTtXGccEGR9TO80Se32/KlplAy08LQzT4+iXpv9kxfQ0kO7ubDkmLEwFg/ohlns=
X-Google-Smtp-Source: AGHT+IG0pGKyFxhUYIZxyizCprVXeOYwV9O/Cu8dGummQjlPHaKWHg/LIgIEa0ORW9lyqscxBKa+0Q==
X-Received: by 2002:a05:600c:4f42:b0:427:d713:a5d3 with SMTP id 5b1f17b1804b1-42bb02eb478mr125076105e9.11.1725358840072;
        Tue, 03 Sep 2024 03:20:40 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e274ccsm168739995e9.37.2024.09.03.03.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:20:39 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/7] perf evsel: Add alternate_hw_config and use in evsel__match
Date: Tue,  3 Sep 2024 11:19:45 +0100
Message-Id: <20240903102005.78049-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903102005.78049-1-james.clark@linaro.org>
References: <20240903102005.78049-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

There are cases where we want to match events like instructions and
cycles with legacy hardware values, in particular in stat-shadow's
hard coded metrics. An evsel's name isn't a good point of reference as
it gets altered, strstr would be too imprecise and re-parsing the
event from its name is silly. Instead, hold the legacy hardware event
name, determined during parsing, in the evsel for this matching case.

Inline evsel__match2 that is only used in builtin-diff.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-diff.c      |  6 ++--
 tools/perf/util/evsel.c        | 21 +++++++++++++
 tools/perf/util/evsel.h        | 19 ++----------
 tools/perf/util/parse-events.c | 57 +++++++++++++++++++++-------------
 tools/perf/util/parse-events.h |  8 ++++-
 tools/perf/util/parse-events.y |  2 +-
 tools/perf/util/pmu.c          |  6 +++-
 tools/perf/util/pmu.h          |  2 +-
 8 files changed, 76 insertions(+), 45 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 23326dd20333..82fb7773e03e 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -469,13 +469,13 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 
 static struct perf_diff pdiff;
 
-static struct evsel *evsel_match(struct evsel *evsel,
-				      struct evlist *evlist)
+static struct evsel *evsel_match(struct evsel *evsel, struct evlist *evlist)
 {
 	struct evsel *e;
 
 	evlist__for_each_entry(evlist, e) {
-		if (evsel__match2(evsel, e))
+		if ((evsel->core.attr.type == e->core.attr.type) &&
+		    (evsel->core.attr.config == e->core.attr.config))
 			return e;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 49cc71511c0c..2928c1f76dad 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -299,6 +299,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->pmu_name      = NULL;
 	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
+	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
@@ -445,6 +446,8 @@ struct evsel *evsel__clone(struct evsel *orig)
 	if (evsel__copy_config_terms(evsel, orig) < 0)
 		goto out_err;
 
+	evsel->alternate_hw_config = orig->alternate_hw_config;
+
 	return evsel;
 
 out_err:
@@ -1845,6 +1848,24 @@ static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
 	return 0;
 }
 
+bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
+{
+
+	u32 e_type = evsel->core.attr.type;
+	u64 e_config = evsel->core.attr.config;
+
+	if (e_type != type) {
+		return type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
+			evsel->alternate_hw_config == config;
+	}
+
+	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) &&
+	    perf_pmus__supports_extended_type())
+		e_config &= PERF_HW_EVENT_MASK;
+
+	return e_config == config;
+}
+
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	if (evsel__is_tool(evsel))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 15acf293e12a..430441fdfbbc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -102,6 +102,7 @@ struct evsel {
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
+		u64			alternate_hw_config;
 	};
 
 	/*
@@ -388,26 +389,10 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
 struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *name);
 
-static inline bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
-{
-	if (evsel->core.attr.type != type)
-		return false;
-
-	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)  &&
-	    perf_pmus__supports_extended_type())
-		return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == config;
-
-	return evsel->core.attr.config == config;
-}
+bool __evsel__match(const struct evsel *evsel, u32 type, u64 config);
 
 #define evsel__match(evsel, t, c) __evsel__match(evsel, PERF_TYPE_##t, PERF_COUNT_##c)
 
-static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
-{
-	return (e1->core.attr.type == e2->core.attr.type) &&
-	       (e1->core.attr.config == e2->core.attr.config);
-}
-
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread);
 
 int __evsel__read_on_cpu(struct evsel *evsel, int cpu_map_idx, int thread, bool scale);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fab01ba54e34..d1355e492df3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -227,7 +227,7 @@ __add_event(struct list_head *list, int *idx,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
 	    struct list_head *config_terms, bool auto_merge_stats,
-	    const char *cpu_list)
+	    const char *cpu_list, u64 alternate_hw_config)
 {
 	struct evsel *evsel;
 	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
@@ -263,6 +263,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->pmu_name = pmu ? strdup(pmu->name) : NULL;
+	evsel->alternate_hw_config = alternate_hw_config;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -285,16 +286,19 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 {
 	return __add_event(/*list=*/NULL, &idx, attr, /*init_attr=*/false, name,
 			   metric_id, pmu, /*config_terms=*/NULL,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL);
+			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL,
+			   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 }
 
 static int add_event(struct list_head *list, int *idx,
 		     struct perf_event_attr *attr, const char *name,
-		     const char *metric_id, struct list_head *config_terms)
+		     const char *metric_id, struct list_head *config_terms,
+		     u64 alternate_hw_config)
 {
 	return __add_event(list, idx, attr, /*init_attr*/true, name, metric_id,
 			   /*pmu=*/NULL, config_terms,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL) ? 0 : -ENOMEM;
+			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL,
+			   alternate_hw_config) ? 0 : -ENOMEM;
 }
 
 static int add_event_tool(struct list_head *list, int *idx,
@@ -314,7 +318,9 @@ static int add_event_tool(struct list_head *list, int *idx,
 	evsel = __add_event(list, idx, &attr, /*init_attr=*/true, /*name=*/NULL,
 			    /*metric_id=*/NULL, /*pmu=*/NULL,
 			    /*config_terms=*/NULL, /*auto_merge_stats=*/false,
-			    cpu_list);
+			    cpu_list,
+			    /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
+
 	if (!evsel)
 		return -ENOMEM;
 	evsel->tool_event = tool_event;
@@ -448,7 +454,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats);
+				bool auto_merge_stats, u64 alternate_hw_config);
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
@@ -474,7 +480,8 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 */
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
-						   perf_pmu__auto_merge_stats(pmu));
+						   perf_pmu__auto_merge_stats(pmu),
+						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 			if (ret)
 				return ret;
 			continue;
@@ -505,7 +512,8 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
 		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
 				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-				/*cpu_list=*/NULL) == NULL)
+				/*cpu_list=*/NULL,
+				/*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
 			return -ENOMEM;
 
 		free_config_terms(&config_terms);
@@ -750,7 +758,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 	name = get_config_name(head_config);
 
 	return add_event(list, &parse_state->idx, &attr, name, /*mertic_id=*/NULL,
-			 &config_terms);
+			&config_terms, /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 }
 
 static int check_type_val(struct parse_events_term *term,
@@ -1050,6 +1058,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 		if (perf_pmu__have_event(pmu, term->config)) {
 			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
 			term->no_value = true;
+			term->alternate_hw_config = true;
 		} else {
 			attr->type = PERF_TYPE_HARDWARE;
 			attr->config = term->val.num;
@@ -1362,8 +1371,9 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
 	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
-			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-			/*cpu_list=*/NULL) ? 0 : -ENOMEM;
+			  metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
+			  /*cpu_list=*/NULL, /*alternate_hw_config=*/PERF_COUNT_HW_MAX
+		) == NULL ? -ENOMEM : 0;
 	free_config_terms(&config_terms);
 	return ret;
 }
@@ -1421,7 +1431,7 @@ static bool config_term_percore(struct list_head *config_terms)
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats)
+				bool auto_merge_stats, u64 alternate_hw_config)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
@@ -1458,7 +1468,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
 				    /*config_terms=*/NULL, auto_merge_stats,
-				    /*cpu_list=*/NULL);
+				    /*cpu_list=*/NULL, alternate_hw_config);
 		return evsel ? 0 : -ENOMEM;
 	}
 
@@ -1479,7 +1489,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	/* Look for event names in the terms and rewrite into format based terms. */
 	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
-							    &info, &alias_rewrote_terms, err)) {
+							    &info, &alias_rewrote_terms,
+							    &alternate_hw_config, err)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -EINVAL;
 	}
@@ -1525,7 +1536,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
+			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL,
+			    alternate_hw_config);
 	if (!evsel) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
@@ -1551,7 +1563,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name,
+			       const char *event_name, u64 hw_config,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc_)
 {
@@ -1604,7 +1616,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 		if (!parse_events_add_pmu(parse_state, list, pmu,
-					  &parsed_terms, auto_merge_stats)) {
+					  &parsed_terms, auto_merge_stats, hw_config)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1617,7 +1629,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, list, parse_state->fake_pmu, &parsed_terms,
-					  /*auto_merge_stats=*/true)) {
+					  /*auto_merge_stats=*/true, hw_config)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1658,7 +1670,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
 	pmu = parse_state->fake_pmu ?: perf_pmus__find(event_or_pmu);
 	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
-					/*auto_merge_stats=*/false))
+						/*auto_merge_stats=*/false,
+						/*alternate_hw_config=*/PERF_COUNT_HW_MAX))
 		return 0;
 
 	pmu = NULL;
@@ -1670,7 +1683,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 			if (!parse_events_add_pmu(parse_state, *listp, pmu,
 						  const_parsed_terms,
-						  auto_merge_stats)) {
+						  auto_merge_stats,
+						  /*alternate_hw_config=*/PERF_COUNT_HW_MAX)) {
 				ok++;
 				parse_state->wild_card_pmus = true;
 			}
@@ -1681,7 +1695,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 	/* Failure to add, assume event_or_pmu is an event name. */
 	zfree(listp);
-	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu, const_parsed_terms, listp, loc))
+	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu, PERF_COUNT_HW_MAX,
+					const_parsed_terms, listp, loc))
 		return 0;
 
 	if (asprintf(&help, "Unable to find PMU or event on a PMU of '%s'", event_or_pmu) < 0)
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b735cd9e0acf..703cb6d9f970 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -127,6 +127,12 @@ struct parse_events_term {
 	 * value is assumed to be 1. An event name also has no value.
 	 */
 	bool no_value;
+	/**
+	 * @alternate_hw_config: config is the event name but num is an
+	 * alternate PERF_TYPE_HARDWARE config value which is often nice for the
+	 * sake of quick matching.
+	 */
+	bool alternate_hw_config;
 };
 
 struct parse_events_error {
@@ -238,7 +244,7 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      struct perf_pmu *pmu);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name,
+			       const char *event_name, u64 hw_config,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index b3c51f06cbdc..dcf47fabdfdd 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -292,7 +292,7 @@ PE_NAME sep_dc
 	struct list_head *list;
 	int err;
 
-	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list, &@1);
+	err = parse_events_multi_pmu_add(_parse_state, $1, PERF_COUNT_HW_MAX, NULL, &list, &@1);
 	if (err < 0) {
 		struct parse_events_state *parse_state = _parse_state;
 		struct parse_events_error *error = parse_state->error;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0b38c51bd6eb..6f3ca69b71f1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1602,7 +1602,7 @@ static int check_info_data(struct perf_pmu *pmu,
  */
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_terms,
 			  struct perf_pmu_info *info, bool *rewrote_terms,
-			  struct parse_events_error *err)
+			  u64 *alternate_hw_config, struct parse_events_error *err)
 {
 	struct parse_events_term *term, *h;
 	struct perf_pmu_alias *alias;
@@ -1630,6 +1630,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 						NULL);
 			return ret;
 		}
+
 		*rewrote_terms = true;
 		ret = check_info_data(pmu, alias, info, err, term->err_term);
 		if (ret)
@@ -1638,6 +1639,9 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		if (alias->per_pkg)
 			info->per_pkg = true;
 
+		if (term->alternate_hw_config)
+			*alternate_hw_config = term->val.num;
+
 		list_del_init(&term->list);
 		parse_events_term__delete(term);
 	}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b2d3fd291f02..b5f65b705a1e 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -213,7 +213,7 @@ __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
 int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_terms,
 			  struct perf_pmu_info *info, bool *rewrote_terms,
-			  struct parse_events_error *err);
+			  u64 *alternate_hw_config, struct parse_events_error *err);
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
 void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
-- 
2.34.1

