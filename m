Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637B2770B
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173470; cv=none; b=Tqy/3lbj4jueaA3CWoLiFbGL04Cm1acykS7oxf3vX81lO8i2naZuJxHNCJlyMp0KrBsTOqKRreSdWI11GM/+LiwFT/UIffNR3LHuF65UYpxmkc9LPMlgTV1Tm7h7cC2o8Z3i0r4nl1Z6hYoYV/aqdRGHFwOsIex6c32UPFcuSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173470; c=relaxed/simple;
	bh=pwxN7A9QxyWrBbAvQDktpU8eHsWNzyjeJU/lwtO+s4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjVqYJUSDhlTiI9OlW/BfTS8tOS2uB6K/Rn99qxlfMN43k+N1ffR3DplYedkRGovYVz+5ibn2ITU/mzJ73fpMjQCRVHgzJMuqZil3fdqAM7uRZ5db7g/L70WBA1X0dLTMo7VsQJZxbcc2O232FqNiKuRfavxeK94ZdieZ7okQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5KsXseM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5KsXseM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e3abea7e8so63346385ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747173466; x=1747778266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxL3TbvB/16WHorakdVMHoaGMhIV+eNabPj9LLXDkI4=;
        b=j5KsXseMVWgjeDvA8AgCAkNsZzICA1v7Nwq/yCdddS0Kjh2GroXHZGIm6f67R0O2lj
         RHkYyw6Q8w5/Q1ORplhK9zFXbrK040a+YTqCXgAz5wi39UEd3L1zfWAvkpqC4SFTo6FY
         V12CNVCSzmh9lmKbmUzt62ygpYbCgtJbTF4hJHQ8U7vhlSU+scYJFqjrt1Kw1/y1M1y3
         30cDR3ioYGNdw3ZN0Tz/1g6344nX1P825xUabAqehG8C0ejk2YGbT0DgDGk2z2gLTEN/
         ULphSM3e414vgpOZKJgdMnDqx1xDGbroAafIQ83chg1DM097keywXZqYfSM/Gk4lYhXx
         899A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747173466; x=1747778266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxL3TbvB/16WHorakdVMHoaGMhIV+eNabPj9LLXDkI4=;
        b=WYZmglaOsI8lWd7mMs/8/tCA+RdZaWkrNQvwvssLTBiJ5k7xLvjSyUX1bR4ABpJlUV
         rFk6s1UQewziPPEyN+bBZSrkpA0bJallUuS3FP5aGXFhmm12IQ6ZDNOLes+8KM+VIDoU
         Qg+UXYP6CpWpLkgdKyDEEmwNWzRl4TfXOJe3yQrMZkXnIX7LaE46tn5uTM6WVVox/mr7
         ms/vTuxDYgA+yYDqeJTj/LecXVEpfkWrzvGafxeJSnA8/uFj2cgePfN7Hl+S05+AVMkf
         OVmAnjk0J7wyRpKWICkMrhZEo+6dbA44wL5UGQy4LHxF02i2pyCarlML2t15gsFQLVXe
         WVsA==
X-Forwarded-Encrypted: i=1; AJvYcCUnpR4pnhrL8vBtmg+3VqXu+ymhKw/FRL27E768PM8PeMGT55RLFezJEQ8spLpZ3dip07hDgoWj7ZCrQ+VzO5Ya@vger.kernel.org
X-Gm-Message-State: AOJu0YyQEkgYh8Qv0vhgspkvY3Kpg/Suz9DLj9OTVQnlfIY7RAeWbdkL
	rNkggPA/nQlOqPF/Zex6t+j1skwavC0VEFFN+7F05v6PpHJLeNCYKqUeB11RKwJawqjgf3/GL4I
	Zwg==
X-Google-Smtp-Source: AGHT+IE2O8/M7/jf7POfgFpYb8eT+2tgFqnAlgArJM8KUsFPfGkvP/2fLdTe5ghxlFtXegiowmyWDcCUT0Y=
X-Received: from plnu4.prod.google.com ([2002:a17:903:1a44:b0:21f:56e1:c515])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32cd:b0:224:c46:d162
 with SMTP id d9443c01a7336-23198148268mr11045295ad.20.1747173466553; Tue, 13
 May 2025 14:57:46 -0700 (PDT)
Date: Tue, 13 May 2025 14:45:02 -0700
In-Reply-To: <20250513215401.2315949-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513215401.2315949-1-ctshao@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513215401.2315949-3-ctshao@google.com>
Subject: [PATCH v4 2/3] perf parse-events: Use wildcard processing to set an
 event to merge into
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, ak@linux.intel.com, howardchu95@gmail.com, 
	linux@treblig.org, yeoreum.yun@arm.com, james.clark@linaro.org, 
	weilin.wang@intel.com, linux-perf-users@vger.kernel.org
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
 tools/perf/util/evsel.c        | 18 +++++---
 tools/perf/util/evsel.h        |  7 ++-
 tools/perf/util/parse-events.c | 84 ++++++++++++++++++++++++----------
 tools/perf/util/stat-display.c | 11 ++++-
 tools/perf/util/stat.c         | 40 ++--------------
 5 files changed, 88 insertions(+), 72 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 34409828f8ec..d55482f094bf 100644
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
@@ -3964,11 +3964,6 @@ bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_con
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
@@ -3997,12 +3992,21 @@ bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_con
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
index df8d2eea0465..6dbc9690e0c9 100644
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
index e4ef8a828ac9..2380de56a207 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -250,13 +250,34 @@ __add_event(struct list_head *list, int *idx,
 	    struct perf_event_attr *attr,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
-	    struct list_head *config_terms, bool auto_merge_stats,
+	    struct list_head *config_terms, struct evsel *first_wildcard_match,
 	    struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
 {
 	struct evsel *evsel;
 	bool is_pmu_core;
 	struct perf_cpu_map *cpus;
 
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
+
 	if (pmu) {
 		is_pmu_core = pmu->is_core;
 		cpus = perf_cpu_map__get(perf_cpu_map__is_empty(cpu_list) ? pmu->cpus : cpu_list);
@@ -293,9 +314,9 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->core.is_pmu_core = is_pmu_core;
-	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->alternate_hw_config = alternate_hw_config;
+	evsel->first_wildcard_match = first_wildcard_match;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -318,7 +339,7 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 {
 	return __add_event(/*list=*/NULL, &idx, attr, /*init_attr=*/false, name,
 			   metric_id, pmu, /*config_terms=*/NULL,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL,
+			   /*first_wildcard_match=*/NULL, /*cpu_list=*/NULL,
 			   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 }
 
@@ -329,7 +350,7 @@ static int add_event(struct list_head *list, int *idx,
 {
 	return __add_event(list, idx, attr, /*init_attr*/true, name, metric_id,
 			   /*pmu=*/NULL, config_terms,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL,
+			   /*first_wildcard_match=*/NULL, /*cpu_list=*/NULL,
 			   alternate_hw_config) ? 0 : -ENOMEM;
 }
 
@@ -454,7 +475,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats, u64 alternate_hw_config);
+				struct evsel *first_wildcard_match, u64 alternate_hw_config);
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
@@ -466,6 +487,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	const char *metric_id = get_config_metric_id(parsed_terms);
 	struct perf_cpu_map *cpus = get_config_cpu(parsed_terms);
 	int ret = 0;
+	struct evsel *first_wildcard_match = NULL;
 
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 		LIST_HEAD(config_terms);
@@ -481,10 +503,13 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 */
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
-						   perf_pmu__auto_merge_stats(pmu),
+						   first_wildcard_match,
 						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 			if (ret)
 				goto out_err;
+			if (first_wildcard_match == NULL)
+				first_wildcard_match =
+					container_of(list->prev, struct evsel, core.node);
 			continue;
 		}
 
@@ -515,10 +540,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 		}
 
 		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
-				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
+				metric_id, pmu, &config_terms, first_wildcard_match,
 				cpus, /*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
 			ret = -ENOMEM;
 
+		if (first_wildcard_match == NULL)
+			first_wildcard_match = container_of(list->prev, struct evsel, core.node);
 		free_config_terms(&config_terms);
 		if (ret)
 			goto out_err;
@@ -1387,7 +1414,8 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 				struct list_head *list,
 				struct perf_pmu *pmu, u32 type, u32 extended_type,
-				u64 config, const struct parse_events_terms *head_config)
+				u64 config, const struct parse_events_terms *head_config,
+				struct evsel *first_wildcard_match)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
@@ -1416,7 +1444,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	metric_id = get_config_metric_id(head_config);
 	cpus = get_config_cpu(head_config);
 	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
-			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
+			metric_id, pmu, &config_terms, first_wildcard_match,
 			cpus, /*alternate_hw_config=*/PERF_COUNT_HW_MAX) ? 0 : -ENOMEM;
 	perf_cpu_map__put(cpus);
 	free_config_terms(&config_terms);
@@ -1434,6 +1462,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 
 	/* Wildcards on numeric values are only supported by core PMUs. */
 	if (wildcard && perf_pmus__supports_extended_type()) {
+		struct evsel *first_wildcard_match = NULL;
 		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 			int ret;
 
@@ -1443,15 +1472,20 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 
 			ret = __parse_events_add_numeric(parse_state, list, pmu,
 							 type, pmu->type,
-							 config, head_config);
+							 config, head_config,
+							 first_wildcard_match);
 			if (ret)
 				return ret;
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
@@ -1469,7 +1503,7 @@ static bool config_term_percore(struct list_head *config_terms)
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				bool auto_merge_stats, u64 alternate_hw_config)
+				struct evsel *first_wildcard_match, u64 alternate_hw_config)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
@@ -1506,7 +1540,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
-				    /*config_terms=*/NULL, auto_merge_stats,
+				    /*config_terms=*/NULL, first_wildcard_match,
 				    /*cpu_list=*/NULL, alternate_hw_config);
 		return evsel ? 0 : -ENOMEM;
 	}
@@ -1577,7 +1611,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
 			    get_config_metric_id(&parsed_terms), pmu,
-			    &config_terms, auto_merge_stats, term_cpu, alternate_hw_config);
+			    &config_terms, first_wildcard_match, term_cpu, alternate_hw_config);
 	perf_cpu_map__put(term_cpu);
 	if (!evsel) {
 		parse_events_terms__exit(&parsed_terms);
@@ -1614,6 +1648,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	int ok = 0;
 	const char *config;
 	struct parse_events_terms parsed_terms;
+	struct evsel *first_wildcard_match = NULL;
 
 	*listp = NULL;
 
@@ -1646,17 +1681,14 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
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
@@ -1665,11 +1697,13 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
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
@@ -1700,6 +1734,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	struct perf_pmu *pmu;
 	int ok = 0;
 	char *help;
+	struct evsel *first_wildcard_match = NULL;
 
 	*listp = malloc(sizeof(**listp));
 	if (!*listp)
@@ -1710,14 +1745,14 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
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
@@ -1727,15 +1762,16 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
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
index c022afb28514..729ad5cd52cb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1002,8 +1002,15 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
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
2.49.0.1045.g170613ef41-goog

