Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258351DF251
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743116387; cv=none; b=e4EyUPT/+9xIOP636jCCderyotZB2mkRu/bRqpCfEWc/qCbDYf3G4oNWrXKKd9V4nDMLSZYZEOntqSKWPrEwr4YomLfpsWOJp0qyBdWEdaJLRNE2/Um6KaImQVx39ZgcAvnIqW4/qI2uKduvG7tWuT8jbUHeAM0TYB3f1tGIMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743116387; c=relaxed/simple;
	bh=rmW4xF3TxYslzByqTsfIwMF9FY3WunDP4/Pq4GC/Mw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nuwv70Y2BrHOFxFd+wAx/iFDVv6CF9Lg40Ngsk4+joyGpbn91T13fg9m6QbiD5wLWwEGmLyZadFa5UneuHsoBnfRV8qQ+Rq0x5rmS0fF3QBGOBVKI17ehisQhGhowHl1GpQ71Q94Qna24+3T0XqUAkNAD5x6VHTxb3IoNf/pp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpW4iMlk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpW4iMlk"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso3295335a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 15:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743116383; x=1743721183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/euh3tTrQt0cm2ZuVr18wpmd9WYjQe4EReQ858wpno=;
        b=qpW4iMlkpCAd8KyrKsDUzTzFEQmACCFiYJMYpRaGaMMdCx0RoO9m9zlzQH3gEty58M
         H74MQmricNGc+8/tSdgmQsX6mdBb5SBc4SUb3GNSAFhQshff5eYlBNXNsXcQXNDju9b1
         jhs0jl9mFEuZoWIQNRFzp6bctsy0Mad3fH3UcjYEVxwRF4C5DPb5EEm6T9AAyCsIjTOs
         nq78VxZAEIvdVhydx6nltrmRO8llAWkfBWP8qWFYYSlGDFz+31ZtwWvMXEVPIqvnP79B
         mus+D5oOztrNIkYcHiD2OCBwVRoVKxBu2SwV2vGfWqcqfqKe+ggytW1po5liFjMfD43Y
         Nd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743116383; x=1743721183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/euh3tTrQt0cm2ZuVr18wpmd9WYjQe4EReQ858wpno=;
        b=xQoe5NveD+0Hx/ELouhSEN1C6+Xr5nfWqexYEX9M9w9WB06q1pkdDCAQuPBOUyF1U5
         qDCJmyz+Fqc+M0aJxnwyAgPMscRn0GpeMzop8U4HUPsOMGKtLjOYxnEh6wNfq9Z9Vcys
         Lj96b/ZWSHvnww4U/3Br03hlr5CpAqdGxiTnFg5e923NpnnK68O4ZtBEsSSXDryP8yiU
         3zZoUveqzkzvWYO6NSmfCDVcCWhTcJj1nILu4t70L9mfUUknZpd+3OKsNdjGMxgkRJO6
         5bwi75dKDOB75eC1wGvbG5O0W+hlha9Iggq2XMaSEUy/b7yQFWTTihK11PbwdYaMmQym
         XTZw==
X-Forwarded-Encrypted: i=1; AJvYcCWTi65BWsoOeNM7xWUBxW35U9YVRCWv7+QTePIEbH7z9UlTjv0AEqOSiwTM/adO0YGXRTioc18PlRehj+J7FGoQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyCylJP4J9ojU7MaaCP7g5V1DeBw9lKO5x/LwHvWg20+iZxkvcL
	IBXiI6RemDXMTde5Sg/Q8ieIjPY1UpXyQnmCFv/6bCF5TSpwBc7ei9RLEX2AOvg10/OV4RN8Pqr
	6+g==
X-Google-Smtp-Source: AGHT+IFcHJbzXzRJOMz9u1R+/BQOIeGBp4Au2HbdqNYsBssIiBpTnrkwZvY9oOMXCN7b6UKlBeJN8T9M+RQ=
X-Received: from pjm14.prod.google.com ([2002:a17:90b:2fce:b0:2f5:63a:4513])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5824:b0:301:1bce:c25a
 with SMTP id 98e67ed59e1d1-303a7f70685mr7188872a91.20.1743116383392; Thu, 27
 Mar 2025 15:59:43 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:48:17 -0700
In-Reply-To: <20250327225651.642965-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327225651.642965-1-ctshao@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327225651.642965-3-ctshao@google.com>
Subject: [PATCH v2 2/3] perf parse-events: Use wildcard processing to set an
 event to merge into
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, ak@linux.intel.com, howardchu95@gmail.com, 
	linux@treblig.org, yeoreum.yun@arm.com, james.clark@linaro.org, 
	weilin.wang@intel.com, asmadeus@codewreck.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ian Rogers <irogers@google.com>

The merge stat code fails for uncore events if they are repeated
twice, for example `perf stat -e clockticks,clockticks -I 1000` as the
counts of the second set of uncore events will be merged into the
first counter. Reimplement the logic to have a first_wildcard_match so
that merged later events correctly merge into the first wildcard event
that they will be aggregated into.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/evsel.c        | 18 ++++---
 tools/perf/util/evsel.h        |  7 ++-
 tools/perf/util/parse-events.c | 86 ++++++++++++++++++++++++----------
 tools/perf/util/stat-display.c | 11 ++++-
 tools/perf/util/stat.c         | 40 ++--------------
 5 files changed, 90 insertions(+), 72 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f00cfff119aa..e360071c870d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -552,11 +552,11 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 
 	evsel->exclude_GH = orig->exclude_GH;
 	evsel->sample_read = orig->sample_read;
-	evsel->auto_merge_stats = orig->auto_merge_stats;
 	evsel->collect_stat = orig->collect_stat;
 	evsel->weak_group = orig->weak_group;
 	evsel->use_config_name = orig->use_config_name;
 	evsel->pmu = orig->pmu;
+	evsel->first_wildcard_match = orig->first_wildcard_match;
 
 	if (evsel__copy_config_terms(evsel, orig) < 0)
 		goto out_err;
@@ -3949,11 +3949,6 @@ bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_con
 		return true;
 	}
 
-	if (counter->merged_stat) {
-		/* Counter won't be shown. */
-		return false;
-	}
-
 	if (counter->use_config_name || counter->is_libpfm_event) {
 		/* Original name will be used. */
 		return false;
@@ -3982,12 +3977,21 @@ bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_con
 		return true;
 	}
 
+	if (counter->first_wildcard_match != NULL) {
+		/*
+		 * If stats are merged then only the first_wildcard_match is
+		 * displayed, there is no need to uniquify this evsel as the
+		 * name won't be shown.
+		 */
+		return false;
+	}
+
 	/*
 	 * Do other non-merged events in the evlist have the same name? If so
 	 * uniquify is necessary.
 	 */
 	evlist__for_each_entry(counter->evlist, evsel) {
-		if (evsel == counter || evsel->merged_stat || evsel->pmu == counter->pmu)
+		if (evsel == counter || evsel->first_wildcard_match || evsel->pmu == counter->pmu)
 			continue;
 
 		if (evsel__name_is(counter, evsel__name(evsel))) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 76ccb7c7e8c2..2cc046894e30 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -70,6 +70,11 @@ struct evsel {
 		const char		*unit;
 		struct cgroup		*cgrp;
 		const char		*metric_id;
+		/*
+		 * This point to the first evsel with the same name, intended to store the
+		 * aggregated counts in aggregation mode.
+		 */
+		struct evsel		*first_wildcard_match;
 		/* parse modifier helper */
 		int			exclude_GH;
 		int			sample_read;
@@ -78,7 +83,6 @@ struct evsel {
 		bool			percore;
 		bool			precise_max;
 		bool			is_libpfm_event;
-		bool			auto_merge_stats;
 		bool			collect_stat;
 		bool			weak_group;
 		bool			bpf_counter;
@@ -115,7 +119,6 @@ struct evsel {
 	bool			ignore_missing_thread;
 	bool			forced_leader;
 	bool			cmdline_group_boundary;
-	bool			merged_stat;
 	bool			reset_group;
 	bool			errored;
 	bool			needs_auxtrace_mmap;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..233836c37e41 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -228,12 +228,32 @@ __add_event(struct list_head *list, int *idx,
 	    struct perf_event_attr *attr,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
-	    struct list_head *config_terms, bool auto_merge_stats,
+	    struct list_head *config_terms, struct evsel *first_wildcard_match,
 	    struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
 {
 	struct evsel *evsel;
 	struct perf_cpu_map *cpus = perf_cpu_map__is_empty(cpu_list) && pmu ? pmu->cpus : cpu_list;
 
+	/*
+	 * Ensure the first_wildcard_match's PMU matches that of the new event
+	 * being added. Otherwise try to match with another event further down
+	 * the evlist.
+	 */
+	if (first_wildcard_match) {
+		struct evsel *pos = list_prev_entry(first_wildcard_match, core.node);
+
+		first_wildcard_match = NULL;
+		list_for_each_entry_continue(pos, list, core.node) {
+			if (perf_pmu__name_no_suffix_match(pos->pmu, pmu->name)) {
+				first_wildcard_match = pos;
+				break;
+			}
+			if (pos->pmu->is_core && (!pmu || pmu->is_core)) {
+				first_wildcard_match = pos;
+				break;
+			}
+		}
+	}
 	cpus = perf_cpu_map__get(cpus);
 	if (pmu)
 		perf_pmu__warn_invalid_formats(pmu);
@@ -262,9 +282,9 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
-	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->alternate_hw_config = alternate_hw_config;
+	evsel->first_wildcard_match = first_wildcard_match;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -287,7 +307,7 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 {
 	return __add_event(/*list=*/NULL, &idx, attr, /*init_attr=*/false, name,
 			   metric_id, pmu, /*config_terms=*/NULL,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL,
+			   /*first_wildcard_match=*/NULL, /*cpu_list=*/NULL,
 			   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 }
 
@@ -298,7 +318,7 @@ static int add_event(struct list_head *list, int *idx,
 {
 	return __add_event(list, idx, attr, /*init_attr*/true, name, metric_id,
 			   /*pmu=*/NULL, config_terms,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL,
+			   /*first_wildcard_match=*/NULL, /*cpu_list=*/NULL,
 			   alternate_hw_config) ? 0 : -ENOMEM;
 }
 
@@ -423,7 +443,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats, u64 alternate_hw_config);
+				struct evsel *first_wildcard_match, u64 alternate_hw_config);
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
@@ -433,6 +453,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	bool found_supported = false;
 	const char *config_name = get_config_name(parsed_terms);
 	const char *metric_id = get_config_metric_id(parsed_terms);
+	struct evsel *first_wildcard_match = NULL;
 
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 		LIST_HEAD(config_terms);
@@ -449,10 +470,14 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 */
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
-						   perf_pmu__auto_merge_stats(pmu),
+						   first_wildcard_match,
 						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 			if (ret)
 				return ret;
+
+			if (first_wildcard_match == NULL)
+				first_wildcard_match =
+					container_of(list->prev, struct evsel, core.node);
 			continue;
 		}
 
@@ -480,11 +505,13 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 		}
 
 		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
-				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
+				metric_id, pmu, &config_terms, first_wildcard_match,
 				/*cpu_list=*/NULL,
 				/*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
 			return -ENOMEM;
 
+		if (first_wildcard_match == NULL)
+			first_wildcard_match = container_of(list->prev, struct evsel, core.node);
 		free_config_terms(&config_terms);
 	}
 	return found_supported ? 0 : -EINVAL;
@@ -1335,7 +1362,8 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 				struct list_head *list,
 				struct perf_pmu *pmu, u32 type, u32 extended_type,
-				u64 config, const struct parse_events_terms *head_config)
+				u64 config, const struct parse_events_terms *head_config,
+				struct evsel *first_wildcard_match)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
@@ -1362,7 +1390,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
 	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
-			  metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
+			  metric_id, pmu, &config_terms, first_wildcard_match,
 			  /*cpu_list=*/NULL, /*alternate_hw_config=*/PERF_COUNT_HW_MAX
 		) == NULL ? -ENOMEM : 0;
 	free_config_terms(&config_terms);
@@ -1380,6 +1408,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 
 	/* Wildcards on numeric values are only supported by core PMUs. */
 	if (wildcard && perf_pmus__supports_extended_type()) {
+		struct evsel *first_wildcard_match = NULL;
+
 		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 			int ret;
 
@@ -1389,15 +1419,21 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 
 			ret = __parse_events_add_numeric(parse_state, list, pmu,
 							 type, pmu->type,
-							 config, head_config);
+							 config, head_config,
+							 first_wildcard_match);
 			if (ret)
 				return ret;
+
+			if (first_wildcard_match == NULL)
+				first_wildcard_match =
+					container_of(list->prev, struct evsel, core.node);
 		}
 		if (found_supported)
 			return 0;
 	}
 	return __parse_events_add_numeric(parse_state, list, perf_pmus__find_by_type(type),
-					type, /*extended_type=*/0, config, head_config);
+					type, /*extended_type=*/0, config, head_config,
+					/*first_wildcard_match=*/NULL);
 }
 
 static bool config_term_percore(struct list_head *config_terms)
@@ -1415,7 +1451,7 @@ static bool config_term_percore(struct list_head *config_terms)
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats, u64 alternate_hw_config)
+				struct evsel *first_wildcard_match, u64 alternate_hw_config)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
@@ -1451,7 +1487,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
-				    /*config_terms=*/NULL, auto_merge_stats,
+				    /*config_terms=*/NULL, first_wildcard_match,
 				    /*cpu_list=*/NULL, alternate_hw_config);
 		return evsel ? 0 : -ENOMEM;
 	}
@@ -1521,7 +1557,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL,
+			    &config_terms, first_wildcard_match, /*cpu_list=*/NULL,
 			    alternate_hw_config);
 	if (!evsel) {
 		parse_events_terms__exit(&parsed_terms);
@@ -1554,6 +1590,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	int ok = 0;
 	const char *config;
 	struct parse_events_terms parsed_terms;
+	struct evsel *first_wildcard_match = NULL;
 
 	*listp = NULL;
 
@@ -1586,17 +1623,14 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	INIT_LIST_HEAD(list);
 
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		bool auto_merge_stats;
-
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
 
 		if (!perf_pmu__have_event(pmu, event_name))
 			continue;
 
-		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 		if (!parse_events_add_pmu(parse_state, list, pmu,
-					  &parsed_terms, auto_merge_stats, hw_config)) {
+					  &parsed_terms, first_wildcard_match, hw_config)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1605,11 +1639,13 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			strbuf_release(&sb);
 			ok++;
 		}
+		if (first_wildcard_match == NULL)
+			first_wildcard_match = container_of(list->prev, struct evsel, core.node);
 	}
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, list, perf_pmus__fake_pmu(), &parsed_terms,
-					  /*auto_merge_stats=*/true, hw_config)) {
+					 first_wildcard_match, hw_config)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1640,6 +1676,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	struct perf_pmu *pmu;
 	int ok = 0;
 	char *help;
+	struct evsel *first_wildcard_match = NULL;
 
 	*listp = malloc(sizeof(**listp));
 	if (!*listp)
@@ -1650,14 +1687,14 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
 	pmu = perf_pmus__find(event_or_pmu);
 	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
-					 /*auto_merge_stats=*/false,
+					 first_wildcard_match,
 					 /*alternate_hw_config=*/PERF_COUNT_HW_MAX))
 		return 0;
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, *listp, perf_pmus__fake_pmu(),
 					  const_parsed_terms,
-					  /*auto_merge_stats=*/false,
+					  first_wildcard_match,
 					  /*alternate_hw_config=*/PERF_COUNT_HW_MAX))
 			return 0;
 	}
@@ -1667,15 +1704,16 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 		if (!parse_events__filter_pmu(parse_state, pmu) &&
 		    perf_pmu__wildcard_match(pmu, event_or_pmu)) {
-			bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
-
 			if (!parse_events_add_pmu(parse_state, *listp, pmu,
 						  const_parsed_terms,
-						  auto_merge_stats,
+						  first_wildcard_match,
 						  /*alternate_hw_config=*/PERF_COUNT_HW_MAX)) {
 				ok++;
 				parse_state->wild_card_pmus = true;
 			}
+			if (first_wildcard_match == NULL)
+				first_wildcard_match =
+					container_of((*listp)->prev, struct evsel, core.node);
 		}
 	}
 	if (ok)
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d427e0ca98a1..91386429115d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1011,8 +1011,15 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	os->evsel = counter;
 
 	/* Skip already merged uncore/hybrid events */
-	if (counter->merged_stat)
-		return;
+	if (config->aggr_mode != AGGR_NONE) {
+		if (evsel__is_hybrid(counter)) {
+			if (config->hybrid_merge && counter->first_wildcard_match != NULL)
+				return;
+		} else {
+			if (counter->first_wildcard_match != NULL)
+				return;
+		}
+	}
 
 	val = aggr->counts.val;
 	ena = aggr->counts.ena;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 1f7abd8754c7..355a7d5c8ab8 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -535,35 +535,6 @@ static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
 
 	return 0;
 }
-/*
- * Events should have the same name, scale, unit, cgroup but on different core
- * PMUs or on different but matching uncore PMUs.
- */
-static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
-{
-	if (strcmp(evsel__name(evsel_a), evsel__name(evsel_b)))
-		return false;
-
-	if (evsel_a->scale != evsel_b->scale)
-		return false;
-
-	if (evsel_a->cgrp != evsel_b->cgrp)
-		return false;
-
-	if (strcmp(evsel_a->unit, evsel_b->unit))
-		return false;
-
-	if (evsel__is_clock(evsel_a) != evsel__is_clock(evsel_b))
-		return false;
-
-	if (evsel_a->pmu == evsel_b->pmu || evsel_a->pmu == NULL || evsel_b->pmu == NULL)
-		return false;
-
-	if (evsel_a->pmu->is_core)
-		return evsel_b->pmu->is_core;
-
-	return perf_pmu__name_no_suffix_match(evsel_a->pmu, evsel_b->pmu->name);
-}
 
 static void evsel__merge_aliases(struct evsel *evsel)
 {
@@ -572,10 +543,9 @@ static void evsel__merge_aliases(struct evsel *evsel)
 
 	alias = list_prepare_entry(evsel, &(evlist->core.entries), core.node);
 	list_for_each_entry_continue(alias, &evlist->core.entries, core.node) {
-		/* Merge the same events on different PMUs. */
-		if (evsel__is_alias(evsel, alias)) {
+		if (alias->first_wildcard_match == evsel) {
+			/* Merge the same events on different PMUs. */
 			evsel__merge_aggr_counters(evsel, alias);
-			alias->merged_stat = true;
 		}
 	}
 }
@@ -588,11 +558,7 @@ static bool evsel__should_merge_hybrid(const struct evsel *evsel,
 
 static void evsel__merge_stats(struct evsel *evsel, struct perf_stat_config *config)
 {
-	/* this evsel is already merged */
-	if (evsel->merged_stat)
-		return;
-
-	if (evsel->auto_merge_stats || evsel__should_merge_hybrid(evsel, config))
+	if (!evsel->pmu || !evsel->pmu->is_core || evsel__should_merge_hybrid(evsel, config))
 		evsel__merge_aliases(evsel);
 }
 
-- 
2.49.0.472.ge94155a9ec-goog

