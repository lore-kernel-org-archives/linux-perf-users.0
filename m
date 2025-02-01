Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054214B06E
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738395817; cv=none; b=MuGwvDYOeQXJL0NJXbTcRZCBckBCz4vikqHBgfSwE5D40eqyY2ldLqLcDNNNRxWFwYD+VUKM6s2PPJWW8Lj42hSPsTTKgGr78BpzLXoIXUJwMB/QeI7PKaeZDObH9DUeDtCGrCM2rB1Lc4i81CYEQDwWfW+4/XorGxfCf6dAzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738395817; c=relaxed/simple;
	bh=RseWtrW6YqihRx+zeSELljPhbWz4e7HhEQDllupFe3c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZYBnwOBQ/FHdQAh3KTh40Gxa5TcDc2AldNfQpNnb0wYeEf+exh2tSB7Iw6LsNsb/Iqe5Te3JMdXMmpdkTit1RMvLHB3pC6JZDaIdwy8dbp7b4UVEauoAyCLOb3n8CDtMQp0vsA7TU5I5d13TLQcuyEthL7eXSsES9u4oRUSSOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZGjXkAs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZGjXkAs"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f46fb73061so17585397b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 23:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738395815; x=1739000615; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WurBRvDnGyHSSQ6Q0kdWu3ZKA7LBB5POS8oXLnCfa+Q=;
        b=iZGjXkAsQ8DAYOfZWXm9Pvg5Dfp+hTWw1tFJmpEGfuqnef3EUkEfIhaEscioYeso/B
         SRyVXVIx0LsjcT/N/MEvYF2jR8gkrSekCgsZt5eMM9ZQRUTZCVfp82Y1C13i8fy0yBfe
         tjIXJKKtaxTs4SSAdyXzKPONtE92GN8i/K9iDgvtzbVWGFTf/oAMn/oupxd6Xwwaq6p/
         S/peCpe2KIcZ8tOfLMcBAnqURpxkmcUDO8xCKiZrswImca3blc6IA4bEYXwtEzysoOc+
         NbG5ND0yRD4EKC3W0dyX8YnbQ3I4fVgPB3GW+DfyLiMw2+oTlptTc1IY09s5QuNKl46W
         /ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738395815; x=1739000615;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WurBRvDnGyHSSQ6Q0kdWu3ZKA7LBB5POS8oXLnCfa+Q=;
        b=aWFrbipgcn6ZcqmS8o5KfUD89IbTd/UCaf9zlKD6aOd2AkWTOqq6epIowNakZgW13j
         Z6OIuEPQhnl5OY95cydPx6jeo2OacYks6WlpMO8nfjdhoKDlD1g5l/6V+inWTZIK5vek
         EBXYE3G7NweZmtnaDyjEBaHLuUkqc+q+DPDq9QsqFQ2E7VWFeRxl7IDqT/wqngoNNonp
         Q5iKbGaQEamcQHqSHTJKl3BNkoPb7Hq86LQQZFpDbqjuYUawAP+oy91/TQRD56kkJDZ5
         y5RfHNID25D2OPI3GafwrCrUZNVx2UllOw/9cgtGVQUg04jOBISPjTYooMQK2eWKqzMx
         R5tA==
X-Forwarded-Encrypted: i=1; AJvYcCULVP6JKGcNMt8jmoWZe9Rx+L8+As3jc0WCDUB28GUdH/P2BgHb/pz709jdI1sZt5B63r8o3JGc14qfseE3buCO@vger.kernel.org
X-Gm-Message-State: AOJu0YzkTUh6xd8hGu0HG8v8ouF0dNjbBl9OV1SBWi64HE7WawmMVS+Q
	LkfkNr14rtVQDIo7Fxo1XXdGznRxhLtRGZ3MuHLlHNr9L14hCyJEgoomw68HPEHFJSJ0k5iPham
	U6HqP/g==
X-Google-Smtp-Source: AGHT+IHbG86rtBAsooTyabtcnbDhXSsOBm/aJku1DwLxPxkhIFWdnInE1Z/qgMp5bvx7Xbobm/51YzwEmnQu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:de26:87db:e4d0:62b6])
 (user=irogers job=sendgmr) by 2002:a25:6b46:0:b0:e39:7035:60ba with SMTP id
 3f1490d57ef6-e5ac891aab0mr35525276.4.1738395815164; Fri, 31 Jan 2025 23:43:35
 -0800 (PST)
Date: Fri, 31 Jan 2025 23:43:20 -0800
In-Reply-To: <20250201074320.746259-1-irogers@google.com>
Message-Id: <20250201074320.746259-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201074320.746259-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v3 5/5] perf stat: Changes to event name uniquification
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The existing logic would disable uniquification on an evlist or enable
it per evsel, this is unfortunate as uniquification is most needed
when events have the same name and so the whole evlist must be
considered.  Change the initial disable uniquify on an evlist
processing to also set a needs_uniquify flag, for cases like the
matching event names. This must be done as an initial pass as
uniquification of an event name will change the behavior of the
check. Keep the per counter uniquification but now only uniquify event
names when the needs_uniquify flag is set.

Before this change a hwmon like temp1 wouldn't be uniquified and
afterwards it will (ie the PMU is added to the temp1 event's name).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.h        |   1 +
 tools/perf/util/stat-display.c | 111 +++++++++++++++++++++++----------
 2 files changed, 79 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 2dd108a14b89..aae431d63d64 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -119,6 +119,7 @@ struct evsel {
 	bool			errored;
 	bool			needs_auxtrace_mmap;
 	bool			default_metricgroup; /* A member of the Default metricgroup */
+	bool			needs_uniquify;
 	struct hashmap		*per_pkg_mask;
 	int			err;
 	int			script_output_type;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ba79f73e1cf5..e65c7e9f15d1 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -929,12 +929,16 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	}
 }
 
-static void uniquify_event_name(struct evsel *counter)
+static void evsel__uniquify_counter(struct evsel *counter)
 {
 	const char *name, *pmu_name;
 	char *new_name, *config;
 	int ret;
 
+	/* No uniquification necessary. */
+	if (!counter->needs_uniquify)
+		return;
+
 	/* The evsel was already uniquified. */
 	if (counter->uniquified_name)
 		return;
@@ -942,19 +946,6 @@ static void uniquify_event_name(struct evsel *counter)
 	/* Avoid checking to uniquify twice. */
 	counter->uniquified_name = true;
 
-	/* The evsel has a "name=" config term or is from libpfm. */
-	if (counter->use_config_name || counter->is_libpfm_event)
-		return;
-
-	/* Legacy no PMU event, don't uniquify. */
-	if  (!counter->pmu ||
-	     (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type != PERF_TYPE_RAW))
-		return;
-
-	/* A sysfs or json event replacing a legacy event, don't uniquify. */
-	if (counter->pmu->is_core && counter->alternate_hw_config != PERF_COUNT_HW_MAX)
-		return;
-
 	name = evsel__name(counter);
 	pmu_name = counter->pmu->name;
 	/* Already prefixed by the PMU name. */
@@ -993,17 +984,6 @@ static void uniquify_event_name(struct evsel *counter)
 	}
 }
 
-static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config)
-{
-	return evsel__is_hybrid(evsel) && !config->hybrid_merge;
-}
-
-static void uniquify_counter(struct perf_stat_config *config, struct evsel *counter)
-{
-	if (config->aggr_mode == AGGR_NONE || hybrid_uniquify(counter, config))
-		uniquify_event_name(counter);
-}
-
 /**
  * should_skip_zero_count() - Check if the event should print 0 values.
  * @config: The perf stat configuration (including aggregation mode).
@@ -1089,7 +1069,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	if (counter->merged_stat)
 		return;
 
-	uniquify_counter(config, counter);
+	evsel__uniquify_counter(counter);
 
 	val = aggr->counts.val;
 	ena = aggr->counts.ena;
@@ -1670,7 +1650,8 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 		print_metric_end(config, os);
 }
 
-static void disable_uniquify(struct evlist *evlist)
+/* Should uniquify be disabled for the evlist? */
+static bool evlist__disable_uniquify(const struct evlist *evlist)
 {
 	struct evsel *counter;
 	struct perf_pmu *last_pmu = NULL;
@@ -1679,20 +1660,84 @@ static void disable_uniquify(struct evlist *evlist)
 	evlist__for_each_entry(evlist, counter) {
 		/* If PMUs vary then uniquify can be useful. */
 		if (!first && counter->pmu != last_pmu)
-			return;
+			return false;
 		first = false;
 		if (counter->pmu) {
 			/* Allow uniquify for uncore PMUs. */
 			if (!counter->pmu->is_core)
-				return;
+				return false;
 			/* Keep hybrid event names uniquified for clarity. */
 			if (perf_pmus__num_core_pmus() > 1)
-				return;
+				return false;
+		}
+	}
+	return true;
+}
+
+static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config)
+{
+	struct evsel *evsel;
+
+	if (counter->merged_stat) {
+		/* Counter won't be shown. */
+		return;
+	}
+
+	if (counter->use_config_name || counter->is_libpfm_event) {
+		/* Original name will be used. */
+		return;
+	}
+
+	if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
+		/* Legacy event, don't uniquify. */
+		return;
+	}
+
+	if (counter->pmu && counter->pmu->is_core &&
+	    counter->alternate_hw_config != PERF_COUNT_HW_MAX) {
+		/* A sysfs or json event replacing a legacy event, don't uniquify. */
+		return;
+	}
+
+	if (config->aggr_mode == AGGR_NONE) {
+		/* Always unique with no aggregation. */
+		counter->needs_uniquify = true;
+		return;
+	}
+
+	if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
+		/* Unique hybrid counters necessary. */
+		counter->needs_uniquify = true;
+		return;
+	}
+
+	/*
+	 * Do other non-merged events in the evlist have the same name? If so
+	 * uniquify is necessary.
+	 */
+	evlist__for_each_entry(counter->evlist, evsel) {
+		if (evsel == counter || evsel->merged_stat)
+			continue;
+
+		if (evsel__name_is(counter, evsel__name(evsel))) {
+			counter->needs_uniquify = true;
+			return;
 		}
 	}
-	evlist__for_each_entry_continue(evlist, counter) {
-		counter->uniquified_name = true;
+}
+
+static void evlist__set_needs_uniquify(struct evlist *evlist, const struct perf_stat_config *config)
+{
+	struct evsel *counter;
+
+	if (evlist__disable_uniquify(evlist)) {
+		evlist__for_each_entry(evlist, counter)
+			counter->uniquified_name = true;
+		return;
 	}
+
+	evlist__for_each_entry(evlist, counter)
+		evsel__set_needs_uniquify(counter, config);
 }
 
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
@@ -1706,7 +1751,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		.first = true,
 	};
 
-	disable_uniquify(evlist);
+	evlist__set_needs_uniquify(evlist, config);
 
 	if (config->iostat_run)
 		evlist->selected = evlist__first(evlist);
-- 
2.48.1.362.g079036d154-goog

