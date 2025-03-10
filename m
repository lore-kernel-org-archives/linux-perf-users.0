Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03061DE2B7
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636545; cv=none; b=uW8UI/Gor5k3nA5wtyhNiTa9zNJpF0Y6l6MV+5xA5XLvEBhhoRaf/EQZ8hBNyuYXt85L+MrPDd+99RuMd4ETfsp0pxEMETYDsS720Pu2XgkDsOKre3/Sz1eirgD9wFI2kqjyKc0YfG1qdRPFoY24ol2ROp0jS2zEZazG1C4uWlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636545; c=relaxed/simple;
	bh=z8tk6NEo+qt0UMeoPrCYEzp3GWtdK26aBzxK9MLi2P4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RYip3Db4tdOnHHXdKbHG8Z+egpMYQvalkq5yDjcTdpt5WXO3Nou2cMFg9Ge1vKPzOlUl/uhleaULf+kMCLy+4/kw/t+giKVkIU9lfkyqrF7ecs0111Gdc3BfChWNaHK7vO6Q8gA7BojbPd885cvEAURfHjf0tEfREBXl3U9BjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2UUgDfw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2UUgDfw"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff68033070so7469082a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741636543; x=1742241343; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/JlJMcZ5IMZUK/raTA8JFgLCXPXl7h3UP7dz91G4Lk=;
        b=p2UUgDfwHbBj1JrSIutyThdI7Qt+yveXkFN0mVARLTZOvDjYWlJpaARQSYZd8hoKcj
         0H9MIZde0zvlJ00KfP1k40Q+6QVXMXPHKDxNRaSwYMseVHJtKQcuvbMhsEam3/Nqp12J
         WPaBMyNlJJH8WB0zjTsvtBq2oKVNK3SioDc/6WcOfAS5SsIoyKMcEhPSxqpUr6hi3icC
         Ljp5ovMFcxES8zXnwmcqDUlt2hyzaDMj90moFRnL6nKmnHx3AxPd/ISXyluIVGHD9YkU
         RTQpIVUu+gc9fwf4TC0/qEZ6WVVLxH6CrwZOr/rfoPxvXVqka8EBOpPARW62EqE7YsDO
         kp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636543; x=1742241343;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/JlJMcZ5IMZUK/raTA8JFgLCXPXl7h3UP7dz91G4Lk=;
        b=kJMzVSO80P8eIJoYvG530XQYUNQROIAiYHkgNbBqn68GYmbgjA4dGSKbSQDwx3lpk4
         1bUsRnjVhvNvD44toPnGhCVLUCpvuJsAu7c8e5l8fjZVeYh0ErhM4gSDkhYbSdL0MNE+
         8hVIg9PvLbazQqyaX4EK7rDIy6HnIfgYFgxsglxCQ04gX9chQoCaqcqwfOtjJleRLV3B
         wqpZ44hTZJXwe4IBuLUW6sVSshLAX+lXIZxT5pwR4KBCjJi8PzPaDkIllYSKUZ9sPNjh
         coxESfZcxOPNs4hTN1s8bAvGthEcU1A/VQvtOK3R1OzZjMBfQpgq/12UuTLqrS4+9/7I
         yqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi5SVoKg60mFXV6eHPoagSL42yIEdbWTDhTzYNN9sgiBwkTD8lt26GXgib31FZSx7Cy2XkWm0H3zQ1AiqA6WTC@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/rPKW65Z2Le/qUkUCHfIvrxgTflZeE0ELYY0624zAy0gICq1
	9clQQaHl5SV8Kp41y+cTdpXN5/zxDsKG+sBN8Rk4cDFbJ5ubIvPDAYewek/Qx/A6IGg8V31hRQC
	jN7pjjQ==
X-Google-Smtp-Source: AGHT+IGP7PL/RMy/It9PScbVC2X+jH+eqAEL95lIMDqaAQGQUShkH4NAm1SwHY2/IvlM+vSWSNYh1/DSNv1g
X-Received: from pjbpd6.prod.google.com ([2002:a17:90b:1dc6:b0:2fa:15aa:4d1e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c8:b0:2fa:157e:c78e
 with SMTP id 98e67ed59e1d1-300ff0a441cmr1509149a91.7.1741636543305; Mon, 10
 Mar 2025 12:55:43 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:55:18 -0700
In-Reply-To: <20250310195518.2012571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310195518.2012571-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310195518.2012571-3-irogers@google.com>
Subject: [PATCH v1 2/2] Revert "perf evsel: Add alternate_hw_config and use in evsel__match"
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit 22a4db3c36034e2b034c5b88414680857fc59cf4.

Now legacy events are prioritized there is no need to worry about a
sysfs/json event being used when trying to pattern match a legacy
event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-diff.c      |  6 ++--
 tools/perf/util/evsel.c        | 21 -------------
 tools/perf/util/evsel.h        | 19 ++++++++++--
 tools/perf/util/parse-events.c | 55 +++++++++++++---------------------
 tools/perf/util/parse-events.h |  8 +----
 tools/perf/util/parse-events.y |  2 +-
 tools/perf/util/pmu.c          |  6 +---
 tools/perf/util/pmu.h          |  2 +-
 8 files changed, 45 insertions(+), 74 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ae490d58af92..b49c1dc1fd96 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -470,13 +470,13 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 
 static struct perf_diff pdiff;
 
-static struct evsel *evsel_match(struct evsel *evsel, struct evlist *evlist)
+static struct evsel *evsel_match(struct evsel *evsel,
+				      struct evlist *evlist)
 {
 	struct evsel *e;
 
 	evlist__for_each_entry(evlist, e) {
-		if ((evsel->core.attr.type == e->core.attr.type) &&
-		    (evsel->core.attr.config == e->core.attr.config))
+		if (evsel__match2(evsel, e))
 			return e;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a0ef095db92..5566232f9bb9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -404,7 +404,6 @@ void evsel__init(struct evsel *evsel,
 	evsel->collect_stat  = false;
 	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
-	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
 	evsel->script_output_type = -1; // FIXME: OUTPUT_TYPE_UNSET, see builtin-script.c
 }
 
@@ -551,8 +550,6 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 	if (evsel__copy_config_terms(evsel, orig) < 0)
 		goto out_err;
 
-	evsel->alternate_hw_config = orig->alternate_hw_config;
-
 	return evsel;
 
 out_err:
@@ -1848,24 +1845,6 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 	return evsel__process_group_data(leader, cpu_map_idx, thread, data);
 }
 
-bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
-{
-
-	u32 e_type = evsel->core.attr.type;
-	u64 e_config = evsel->core.attr.config;
-
-	if (e_type != type) {
-		return type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
-			evsel->alternate_hw_config == config;
-	}
-
-	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) &&
-	    perf_pmus__supports_extended_type())
-		e_config &= PERF_HW_EVENT_MASK;
-
-	return e_config == config;
-}
-
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	if (evsel__is_tool(evsel))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index aae431d63d64..c199481d3338 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -87,7 +87,6 @@ struct evsel {
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
-		u64			alternate_hw_config;
 	};
 
 	/*
@@ -370,10 +369,26 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
 struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *name);
 
-bool __evsel__match(const struct evsel *evsel, u32 type, u64 config);
+static inline bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
+{
+	if (evsel->core.attr.type != type)
+		return false;
+
+	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)  &&
+	    perf_pmus__supports_extended_type())
+		return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == config;
+
+	return evsel->core.attr.config == config;
+}
 
 #define evsel__match(evsel, t, c) __evsel__match(evsel, PERF_TYPE_##t, PERF_COUNT_##c)
 
+static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
+{
+	return (e1->core.attr.type == e2->core.attr.type) &&
+	       (e1->core.attr.config == e2->core.attr.config);
+}
+
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread);
 
 int __evsel__read_on_cpu(struct evsel *evsel, int cpu_map_idx, int thread, bool scale);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 04bb70ba4292..a71492829c58 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -229,7 +229,7 @@ __add_event(struct list_head *list, int *idx,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
 	    struct list_head *config_terms, bool auto_merge_stats,
-	    struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
+	    struct perf_cpu_map *cpu_list)
 {
 	struct evsel *evsel;
 	struct perf_cpu_map *cpus = perf_cpu_map__is_empty(cpu_list) && pmu ? pmu->cpus : cpu_list;
@@ -264,7 +264,6 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
-	evsel->alternate_hw_config = alternate_hw_config;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -287,19 +286,16 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 {
 	return __add_event(/*list=*/NULL, &idx, attr, /*init_attr=*/false, name,
 			   metric_id, pmu, /*config_terms=*/NULL,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL,
-			   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
+			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL);
 }
 
 static int add_event(struct list_head *list, int *idx,
 		     struct perf_event_attr *attr, const char *name,
-		     const char *metric_id, struct list_head *config_terms,
-		     u64 alternate_hw_config)
+		     const char *metric_id, struct list_head *config_terms)
 {
 	return __add_event(list, idx, attr, /*init_attr*/true, name, metric_id,
 			   /*pmu=*/NULL, config_terms,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL,
-			   alternate_hw_config) ? 0 : -ENOMEM;
+			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL) ? 0 : -ENOMEM;
 }
 
 /**
@@ -423,7 +419,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats, u64 alternate_hw_config);
+				bool auto_merge_stats);
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
@@ -449,8 +445,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 */
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
-						   perf_pmu__auto_merge_stats(pmu),
-						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
+						   perf_pmu__auto_merge_stats(pmu));
 			if (ret)
 				return ret;
 			continue;
@@ -481,8 +476,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
 		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
 				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-				/*cpu_list=*/NULL,
-				/*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
+				/*cpu_list=*/NULL) == NULL)
 			return -ENOMEM;
 
 		free_config_terms(&config_terms);
@@ -750,7 +744,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 	name = get_config_name(head_config);
 
 	return add_event(list, &parse_state->idx, &attr, name, /*mertic_id=*/NULL,
-			&config_terms, /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
+			 &config_terms);
 }
 
 static int check_type_val(struct parse_events_term *term,
@@ -1354,9 +1348,8 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
 	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
-			  metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-			  /*cpu_list=*/NULL, /*alternate_hw_config=*/PERF_COUNT_HW_MAX
-		) == NULL ? -ENOMEM : 0;
+			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
+			/*cpu_list=*/NULL) ? 0 : -ENOMEM;
 	free_config_terms(&config_terms);
 	return ret;
 }
@@ -1407,7 +1400,7 @@ static bool config_term_percore(struct list_head *config_terms)
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats, u64 alternate_hw_config)
+				bool auto_merge_stats)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
@@ -1444,7 +1437,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
 				    /*config_terms=*/NULL, auto_merge_stats,
-				    /*cpu_list=*/NULL, alternate_hw_config);
+				    /*cpu_list=*/NULL);
 		return evsel ? 0 : -ENOMEM;
 	}
 
@@ -1465,8 +1458,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	/* Look for event names in the terms and rewrite into format based terms. */
 	if (perf_pmu__check_alias(pmu, &parsed_terms,
-				  &info, &alias_rewrote_terms,
-				  &alternate_hw_config, err)) {
+				  &info, &alias_rewrote_terms, err)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -EINVAL;
 	}
@@ -1513,8 +1505,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL,
-			    alternate_hw_config);
+			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
 	if (!evsel) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
@@ -1535,7 +1526,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name, u64 hw_config,
+			       const char *event_name,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc_)
 {
@@ -1588,7 +1579,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 		if (!parse_events_add_pmu(parse_state, list, pmu,
-					  &parsed_terms, auto_merge_stats, hw_config)) {
+					  &parsed_terms, auto_merge_stats)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1601,7 +1592,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, list, perf_pmus__fake_pmu(), &parsed_terms,
-					  /*auto_merge_stats=*/true, hw_config)) {
+					  /*auto_merge_stats=*/true)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1642,15 +1633,13 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
 	pmu = perf_pmus__find(event_or_pmu);
 	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
-					 /*auto_merge_stats=*/false,
-					 /*alternate_hw_config=*/PERF_COUNT_HW_MAX))
+					/*auto_merge_stats=*/false))
 		return 0;
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, *listp, perf_pmus__fake_pmu(),
 					  const_parsed_terms,
-					  /*auto_merge_stats=*/false,
-					  /*alternate_hw_config=*/PERF_COUNT_HW_MAX))
+					  /*auto_merge_stats=*/false))
 			return 0;
 	}
 
@@ -1663,8 +1652,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 			if (!parse_events_add_pmu(parse_state, *listp, pmu,
 						  const_parsed_terms,
-						  auto_merge_stats,
-						  /*alternate_hw_config=*/PERF_COUNT_HW_MAX)) {
+						  auto_merge_stats)) {
 				ok++;
 				parse_state->wild_card_pmus = true;
 			}
@@ -1675,8 +1663,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 	/* Failure to add, assume event_or_pmu is an event name. */
 	zfree(listp);
-	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu, PERF_COUNT_HW_MAX,
-					const_parsed_terms, listp, loc))
+	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu, const_parsed_terms, listp, loc))
 		return 0;
 
 	if (asprintf(&help, "Unable to find PMU or event on a PMU of '%s'", event_or_pmu) < 0)
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e176a34ab088..0edb8b14e522 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -128,12 +128,6 @@ struct parse_events_term {
 	 * value is assumed to be 1. An event name also has no value.
 	 */
 	bool no_value;
-	/**
-	 * @alternate_hw_config: config is the event name but num is an
-	 * alternate PERF_TYPE_HARDWARE config value which is often nice for the
-	 * sake of quick matching.
-	 */
-	bool alternate_hw_config;
 };
 
 struct parse_events_error {
@@ -244,7 +238,7 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      struct perf_pmu *pmu);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name, u64 hw_config,
+			       const char *event_name,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f888cbb076d6..5c4669264177 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -290,7 +290,7 @@ PE_NAME sep_dc
 	struct list_head *list;
 	int err;
 
-	err = parse_events_multi_pmu_add(_parse_state, $1, PERF_COUNT_HW_MAX, NULL, &list, &@1);
+	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list, &@1);
 	if (err < 0) {
 		struct parse_events_state *parse_state = _parse_state;
 		struct parse_events_error *error = parse_state->error;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 57450c73fb63..7b32b9638d5f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1662,7 +1662,7 @@ static int check_info_data(struct perf_pmu *pmu,
  */
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_terms,
 			  struct perf_pmu_info *info, bool *rewrote_terms,
-			  u64 *alternate_hw_config, struct parse_events_error *err)
+			  struct parse_events_error *err)
 {
 	struct parse_events_term *term, *h;
 	struct perf_pmu_alias *alias;
@@ -1699,7 +1699,6 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 						NULL);
 			return ret;
 		}
-
 		*rewrote_terms = true;
 		ret = check_info_data(pmu, alias, info, err, term->err_term);
 		if (ret)
@@ -1708,9 +1707,6 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		if (alias->per_pkg)
 			info->per_pkg = true;
 
-		if (term->alternate_hw_config)
-			*alternate_hw_config = term->val.num;
-
 		list_del_init(&term->list);
 		parse_events_term__delete(term);
 	}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b93014cc3670..71b979a4a9dc 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -231,7 +231,7 @@ __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
 int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_terms,
 			  struct perf_pmu_info *info, bool *rewrote_terms,
-			  u64 *alternate_hw_config, struct parse_events_error *err);
+			  struct parse_events_error *err);
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
 void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

