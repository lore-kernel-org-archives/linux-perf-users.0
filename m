Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1DA189BB5
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743033165; cv=none; b=OyeCAF6e/TTPOJ+buIJzn6cLxpMfB8IMWAH6fXN/atjM06ksPc/3I8jfjKFNmlxd2wdSmB/TalLutxwiWK8N+hE7I6kzrc3EzoAqvnORyzgt6e0RpmWmJ8VJCRFkU/ouu2g1sa5Q0EWafHEKcg4IXeeO2FSSZN+TO/fGmsdYWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743033165; c=relaxed/simple;
	bh=xVp2QMfLt7PK7AmAqU2aS2o/Vv+VexUF9/S5FnYX/LM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lbr63C/l9TFf8fso/7r9+FPcfVNEOREr6FEUXmVhRzNqJOJ1NnnHUprzO3AFFtdk33w/HRrpAkuflUxOueyiwkm/+O5PdmdyqIO787P25OCc6Yyx+TwBLBKXFO0FzwMfphYU/z1u05m68AS8cCocUaz049TJ3D4xtjOGr2jN+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oUpqypyi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oUpqypyi"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254bdd4982so9161065ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743033162; x=1743637962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x90XvYEzFqcvfnyhuh/NjS2NoQXwJjkpKyy6gPyPFcE=;
        b=oUpqypyiplWGtGdCn03TTocyRV2GD3pVROePObteUVslQXF8t/GdWo33SwQWBVN30A
         d1bm2HwAHRIB+ADFMyQ/r6k5w9F6fiUKmwa+GO8wpspEnN2m1eIbxyGzDJXGdHV9XpKx
         ea5ftE6P2eiDgB0O18VVIdMYLXv4WVwvJgGRrAMbCF0Fvk5k+Kf8kgc3B3j7tdkZHi8I
         xLB+DCJG2brd3mVXfEj/PYcPEMOmS8Ecr3bcLoozVc40Dyt3YVU5Gom++7VQaADe8nTc
         6nkRTZPQ6xpY7V+CiDYANMu3GWzKZjlDAb/EyBOeGLUzHUFROp41YJznsEDM7g68zDC/
         NWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743033162; x=1743637962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x90XvYEzFqcvfnyhuh/NjS2NoQXwJjkpKyy6gPyPFcE=;
        b=gw4QjuC3+2VzMn4jxILFHJJQ3bzi7OWgBDhG6ouRj/Ze1DY94wvC4iDn27lP2aKaUP
         1qKwdp38tMiW/2VKvoocz0NLA3GpfsIBBnibzkagxIH3KhQEih93on0gAhS4lK/QoEvl
         X7dgEau5rFQs/Bkkmo497fUdMYBUPUQ7EjkDdW7A2nlIVpesAZOebw+njUrR5DweuZCV
         woJktOJdL9cUtFWHDkh+UgTLL5WRXuJKZrA0fKwNoYlYfJDeKVCDFnPw/IsIt8hhJCk9
         6z1ce32PH9deSgjRpqzyQzMpJHDXlhoSc3xZrQxHEKZtdzbunF5Hyb6C668XmjbaJjJO
         IC8A==
X-Forwarded-Encrypted: i=1; AJvYcCVXjU7I2aTYBFoxrIfKD3flb3lDu53yDo6DczU/RPkIae41b/5QLk/yUCXChFsEN4jJNtQXSlblq+1v5OeMYNLI@vger.kernel.org
X-Gm-Message-State: AOJu0YwbX91jXnkwvnhSWWbTSAnL+3n1tj3YOHWx3EKT/e27jafgpI6l
	kItOx7ywlaXotMeE7KongIFjvEo76syvLv04RRSYVPiT534Y5ETRWmTwvRePMpahG7jJkjqjtBk
	ZUA==
X-Google-Smtp-Source: AGHT+IHDXEo6LkpH675QoZfsVFOYEDRrNppU08Rfa+cGSrzioV6wNeqQmVyyBL+VZB8bDIo624XJIuSnL5Q=
X-Received: from plqt12.prod.google.com ([2002:a17:902:a5cc:b0:21f:14cc:68b0])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f548:b0:223:6455:8752
 with SMTP id d9443c01a7336-2280498703dmr18329665ad.43.1743033162148; Wed, 26
 Mar 2025 16:52:42 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:42:36 -0700
In-Reply-To: <20250326234758.480431-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326234758.480431-1-ctshao@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250326234758.480431-3-ctshao@google.com>
Subject: [PATCH v1 2/2] perf parse-events: Use wildcard processing to set an
 event to merge into
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, howardchu95@gmail.com, 
	weilin.wang@intel.com, yeoreum.yun@arm.com, linux@treblig.org, 
	ak@linux.intel.com, asmadeus@codewreck.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ian Rogers <irogers@google.com>

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
 tools/perf/util/evsel.c        | 15 ++++++------
 tools/perf/util/evsel.h        |  7 ++++--
 tools/perf/util/parse-events.c | 45 ++++++++++++++++++++--------------
 tools/perf/util/stat-display.c |  2 +-
 tools/perf/util/stat.c         | 40 +++---------------------------
 5 files changed, 44 insertions(+), 65 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f00cfff119aa..84e56691c49f 100644
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
@@ -3980,6 +3975,12 @@ bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_con
 		/* Always unique with no aggregation. */
 		counter->needs_uniquify = true;
 		return true;
+	} else if (counter->first_wildcard_match != NULL) {
+		/*
+		 * It is under aggregation mode and the counter won't be shown (the counts should be
+		 * aggreated to the `first_wildcard_match` evsel)
+		 */
+		return false;
 	}
 
 	/*
@@ -3987,7 +3988,7 @@ bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_con
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
index 5152fd5a6ead..0985fea17a26 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -228,7 +228,7 @@ __add_event(struct list_head *list, int *idx,
 	    struct perf_event_attr *attr,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
-	    struct list_head *config_terms, bool auto_merge_stats,
+	    struct list_head *config_terms, struct evsel *first_wildcard_match,
 	    struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
 {
 	struct evsel *evsel;
@@ -262,9 +262,9 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
-	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->alternate_hw_config = alternate_hw_config;
+	evsel->first_wildcard_match = first_wildcard_match;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -423,7 +423,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats, u64 alternate_hw_config);
+				struct evsel *first_wildcard_match, u64 alternate_hw_config);
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
@@ -433,6 +433,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	bool found_supported = false;
 	const char *config_name = get_config_name(parsed_terms);
 	const char *metric_id = get_config_metric_id(parsed_terms);
+	struct evsel *first_wildcard_match = NULL;
 
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 		LIST_HEAD(config_terms);
@@ -449,10 +450,14 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
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
 
@@ -480,11 +485,13 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
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
@@ -1415,7 +1422,7 @@ static bool config_term_percore(struct list_head *config_terms)
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats, u64 alternate_hw_config)
+				struct evsel *first_wildcard_match, u64 alternate_hw_config)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
@@ -1451,7 +1458,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
-				    /*config_terms=*/NULL, auto_merge_stats,
+				    /*config_terms=*/NULL, first_wildcard_match,
 				    /*cpu_list=*/NULL, alternate_hw_config);
 		return evsel ? 0 : -ENOMEM;
 	}
@@ -1521,7 +1528,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL,
+			    &config_terms, first_wildcard_match, /*cpu_list=*/NULL,
 			    alternate_hw_config);
 	if (!evsel) {
 		parse_events_terms__exit(&parsed_terms);
@@ -1554,6 +1561,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	int ok = 0;
 	const char *config;
 	struct parse_events_terms parsed_terms;
+	struct evsel *first_wildcard_match = NULL;
 
 	*listp = NULL;
 
@@ -1586,17 +1594,14 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
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
@@ -1605,11 +1610,13 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
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
@@ -1640,6 +1647,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	struct perf_pmu *pmu;
 	int ok = 0;
 	char *help;
+	struct evsel *first_wildcard_match = NULL;
 
 	*listp = malloc(sizeof(**listp));
 	if (!*listp)
@@ -1650,14 +1658,14 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
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
@@ -1667,15 +1675,16 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
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
index d427e0ca98a1..7e2ec33e8c99 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1011,7 +1011,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	os->evsel = counter;
 
 	/* Skip already merged uncore/hybrid events */
-	if (counter->merged_stat)
+	if (config->aggr_mode != AGGR_NONE && counter->first_wildcard_match)
 		return;
 
 	val = aggr->counts.val;
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

