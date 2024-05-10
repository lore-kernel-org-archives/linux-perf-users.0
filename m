Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101A1527AA
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319489; cv=none; b=MEeuH56NzIjxYv71mTTau9Vf8hAyow1SSRV1CNwxvytF1f1yDP9SiopaoKwDz6toD0Ad/D7KEf2uOYBLTSLzBBn6TEr0xAfON9PuGBkbFvYDPsSoMQ0GDng3U1gygR6abF7EMJVntHVA8hpm/GUcoVVG9cXHXyh9OzrC3EmYrbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319489; c=relaxed/simple;
	bh=iQp86WhJwgC1NI9vANYNuDRZL+PBh+5rBgpbw6bQX+I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SIu3yxz7Rs+7NfMsmjudAUfubYEYu0JJIOteuG3L1cGKOaTF+5JBrxmpH45wdFa+n5tx1rzZ26xuJ8ovpYjUtdvjgz4/kHfymchCX3bH9KkEKDccaAuUbmrvl2tjGJAWD4KDSkqljexJjGIIf0wswasLL7yw1FXPVXjW8J/WvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTs1V4RE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTs1V4RE"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de617c7649dso2487203276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 May 2024 22:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715319486; x=1715924286; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SA0P+oT0/VAImEkmD4noOd22el5UFzWPyOCiJ0gQY+o=;
        b=pTs1V4REuN3s3Jb8Gsf8UmW7QxEsemZQIizY8USyy1sQCLg3Cs6u2CgINUel9iHHf1
         s+YQUFkYvTvUqIan02PRgUOIPIJbCPfQSvuXYYM077ZnZbbfqvJsahirqbDEgWfyGKwi
         0s07Ab1m44P+lJMhOlchKGbRwwXUwtm92dVU3Ka3KI+ZFkYhsRIFBluG36r4ZT64pUnE
         lZvhEBGcalla/fFgLGBrC3QN1g5Ajq64pNSXGstwX7gUxP+tCjzOQJ11pD3EFXdOaRoe
         aKn5sKL9zDzI0EvC1ervv73XA4SWyzuAbIV/szWXP66U5WmP5tVwjV3A0aDmoKJZWexU
         hhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715319486; x=1715924286;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SA0P+oT0/VAImEkmD4noOd22el5UFzWPyOCiJ0gQY+o=;
        b=p1iXblLUX0Pz5FFbaIQBti6SiGMOirB3c1Iu3PyVyDETcm9BOGnG4M3VZmb9QqmJAs
         0yvfpCKI8jEaK+1uZ3gHRVX062Pqr7cOqFvda5p8/BmNPsy8HDF5OX9EVPZi9dLiMPJ2
         9EdLwX/XWKK+zk4LYtB4XA8gQ+F3ghOFvf5RTqiC/kPpdJABbHTNR3htjwPG91k/8B3d
         uSEPgNB/LJ4rJL0yaH3iGd5D0lG7r7nU95Xhrf60gTm2vqZQHbUhQVUx0JBHB0d57dT6
         KadGSQ1CNRbAufY6plJoaoLdDpPmgzVOueQwpJt9xiWnkh3Ku5Wm5d44sb7Ev4pn28y4
         qusQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+L39BM4TTeSfC3qyAv0CctBnkWKjcxOzGH9yB4d0eCEdhVqdTJI7inugX5Cm0HGSdnpqHfvstJI2YwSsnwecue+98vUDHY9gxCAkNRVc39A==
X-Gm-Message-State: AOJu0YyrKz9FjqEqrskxYpIMkfzfMHVK1QeIkIoD0DAPLKdidjBqAaQd
	mT47q7eZICYa/fRBvm7KXszUPIwzByCoVcs4jNcQHILVR6/UGuGmJjNxrIM8uVPeCDH6pjrwzAj
	XpWbVLQ==
X-Google-Smtp-Source: AGHT+IFx9uSqqUpY1vOJkuteO3S7PtFgtmXqFQAlFsZba51Zp/FAznyfk763w6RecjMzVymrpIlaSZuUA4Lg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:79ed:c375:51e3:ed39])
 (user=irogers job=sendgmr) by 2002:a05:6902:150a:b0:dc2:2ace:860 with SMTP id
 3f1490d57ef6-dee4f3117c3mr139280276.2.1715319486529; Thu, 09 May 2024
 22:38:06 -0700 (PDT)
Date: Thu,  9 May 2024 22:37:01 -0700
In-Reply-To: <20240510053705.2462258-1-irogers@google.com>
Message-Id: <20240510053705.2462258-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510053705.2462258-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Subject: [PATCH v3 1/5] perf evsel: Add alternate_hw_config and use in evsel__match
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There are cases where we want to match events like instructions and
cycles with legacy hardware values, in particular in stat-shadow's
hard coded metrics. An evsel's name isn't a good point of reference as
it gets altered, strstr would be too imprecise and re-parsing the
event from its name is silly. Instead, hold the legacy hardware event
name, determined during parsing, in the evsel for this matching case.

Inline evsel__match2 that is only used in builtin-diff.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-diff.c      |  6 ++--
 tools/perf/util/evsel.c        | 21 ++++++++++++++
 tools/perf/util/evsel.h        | 19 ++-----------
 tools/perf/util/parse-events.c | 51 +++++++++++++++++++++-------------
 tools/perf/util/parse-events.h |  6 ++++
 tools/perf/util/pmu.c          |  6 +++-
 tools/perf/util/pmu.h          |  2 +-
 7 files changed, 70 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 57d300d8e570..500a8f9e7c0d 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -483,13 +483,13 @@ static struct perf_diff pdiff = {
 	},
 };
 
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
index 3536404e9447..dfdb60c7a364 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -295,6 +295,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->pmu_name      = NULL;
 	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
+	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
@@ -441,6 +442,8 @@ struct evsel *evsel__clone(struct evsel *orig)
 	if (evsel__copy_config_terms(evsel, orig) < 0)
 		goto out_err;
 
+	evsel->alternate_hw_config = orig->alternate_hw_config;
+
 	return evsel;
 
 out_err:
@@ -1600,6 +1603,24 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 	return evsel__process_group_data(leader, cpu_map_idx, thread, data);
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
 	u64 read_format = evsel->core.attr.read_format;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 517cff431de2..46e3589314f1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -101,6 +101,7 @@ struct evsel {
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
+		u64			alternate_hw_config;
 	};
 
 	/*
@@ -354,26 +355,10 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
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
index 2b9ede311c31..c72e1722b1fb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -230,7 +230,7 @@ __add_event(struct list_head *list, int *idx,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
 	    struct list_head *config_terms, bool auto_merge_stats,
-	    const char *cpu_list)
+	    const char *cpu_list, u64 alternate_hw_config)
 {
 	struct evsel *evsel;
 	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
@@ -266,6 +266,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->pmu_name = pmu ? strdup(pmu->name) : NULL;
+	evsel->alternate_hw_config = alternate_hw_config;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -288,16 +289,19 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
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
@@ -312,7 +316,8 @@ static int add_event_tool(struct list_head *list, int *idx,
 	evsel = __add_event(list, idx, &attr, /*init_attr=*/true, /*name=*/NULL,
 			    /*metric_id=*/NULL, /*pmu=*/NULL,
 			    /*config_terms=*/NULL, /*auto_merge_stats=*/false,
-			    /*cpu_list=*/"0");
+			    /*cpu_list=*/"0",
+			    /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 	if (!evsel)
 		return -ENOMEM;
 	evsel->tool_event = tool_event;
@@ -446,7 +451,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats);
+				bool auto_merge_stats, u64 alternate_hw_config);
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
@@ -472,7 +477,8 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 */
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
-						   perf_pmu__auto_merge_stats(pmu));
+						   perf_pmu__auto_merge_stats(pmu),
+						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 			if (ret)
 				return ret;
 			continue;
@@ -503,7 +509,8 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
 		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
 				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
-				/*cpu_list=*/NULL) == NULL)
+				/*cpu_list=*/NULL,
+				/*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
 			return -ENOMEM;
 
 		free_config_terms(&config_terms);
@@ -743,7 +750,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 	name = get_config_name(head_config);
 
 	return add_event(list, &parse_state->idx, &attr, name, /*mertic_id=*/NULL,
-			 &config_terms);
+			&config_terms, /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 }
 
 static int check_type_val(struct parse_events_term *term,
@@ -1043,6 +1050,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 		if (perf_pmu__have_event(pmu, term->config)) {
 			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
 			term->no_value = true;
+			term->alternate_hw_config = true;
 		} else {
 			attr->type = PERF_TYPE_HARDWARE;
 			attr->config = term->val.num;
@@ -1354,8 +1362,9 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
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
@@ -1413,7 +1422,7 @@ static bool config_term_percore(struct list_head *config_terms)
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats)
+				bool auto_merge_stats, u64 alternate_hw_config)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
@@ -1450,7 +1459,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
 				    /*config_terms=*/NULL, auto_merge_stats,
-				    /*cpu_list=*/NULL);
+				    /*cpu_list=*/NULL, alternate_hw_config);
 		return evsel ? 0 : -ENOMEM;
 	}
 
@@ -1471,7 +1480,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	/* Look for event names in the terms and rewrite into format based terms. */
 	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
-							    &info, &alias_rewrote_terms, err)) {
+							    &info, &alias_rewrote_terms,
+							    &alternate_hw_config, err)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -EINVAL;
 	}
@@ -1517,7 +1527,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
+			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL,
+			    alternate_hw_config);
 	if (!evsel) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
@@ -1596,7 +1607,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 		if (!parse_events_add_pmu(parse_state, list, pmu,
-					  &parsed_terms, auto_merge_stats)) {
+					  &parsed_terms, auto_merge_stats, hw_config)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1611,7 +1622,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, list, parse_state->fake_pmu, &parsed_terms,
-					  /*auto_merge_stats=*/true)) {
+					  /*auto_merge_stats=*/true, hw_config)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1664,7 +1675,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
 	pmu = parse_state->fake_pmu ?: perf_pmus__find(event_or_pmu);
 	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
-					/*auto_merge_stats=*/false))
+						/*auto_merge_stats=*/false,
+						/*alternate_hw_config=*/PERF_COUNT_HW_MAX))
 		return 0;
 
 	pmu = NULL;
@@ -1676,7 +1688,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 			if (!parse_events_add_pmu(parse_state, *listp, pmu,
 						  const_parsed_terms,
-						  auto_merge_stats)) {
+						  auto_merge_stats,
+						  /*alternate_hw_config=*/PERF_COUNT_HW_MAX)) {
 				ok++;
 				parse_state->wild_card_pmus = true;
 			}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e7ac1f13376d..8dd426b8aeb9 100644
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
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b3b072feef02..8f02fc5365aa 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1547,7 +1547,7 @@ static int check_info_data(struct perf_pmu *pmu,
  */
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_terms,
 			  struct perf_pmu_info *info, bool *rewrote_terms,
-			  struct parse_events_error *err)
+			  u64 *alternate_hw_config, struct parse_events_error *err)
 {
 	struct parse_events_term *term, *h;
 	struct perf_pmu_alias *alias;
@@ -1575,6 +1575,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 						NULL);
 			return ret;
 		}
+
 		*rewrote_terms = true;
 		ret = check_info_data(pmu, alias, info, err, term->err_term);
 		if (ret)
@@ -1583,6 +1584,9 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		if (alias->per_pkg)
 			info->per_pkg = true;
 
+		if (term->alternate_hw_config)
+			*alternate_hw_config = term->val.num;
+
 		list_del_init(&term->list);
 		parse_events_term__delete(term);
 	}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 561716aa2b25..a4df58ce70ce 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -211,7 +211,7 @@ __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name);
 int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_terms,
 			  struct perf_pmu_info *info, bool *rewrote_terms,
-			  struct parse_events_error *err);
+			  u64 *alternate_hw_config, struct parse_events_error *err);
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
 void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
-- 
2.45.0.118.g7fe29c98d7-goog

