Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45E223320
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896427; cv=none; b=RcTbFLbL9zBYMHCG54huwsA/rBw0UIAP3eIVRbKqWUqogGZCmA16mgOq+9V7FEK6/LxN+zEFaNtfy0E5q++kluibWGwTHhFNnKKYypu7UV1IjTPQ2ykyD0yIreGUlt9s/G/I5RjAdAbDIAlVeQR8GH/nPSlBA58I0rlwPhHTz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896427; c=relaxed/simple;
	bh=0Hx4NSZJe5ECE65y1lry5FP/Xw26WaUY/hr9480+KXQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hsBUIurpLQyAk2dqg4CduUIPoIS0UOumOpaEdL6OBCCem6/e+jgVMQpD76pwDb3lGVTjbyjFsg42Joe2DZ7EOLliF31r3cOW+jQSD6HtaPXmq+GKgWpvFC1uvw0AtOe52g+O9XcToLKhkQH36g1KruAytZY2Zo83bMaEEODjUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpoDm+OJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpoDm+OJ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e53bf9e60e4so14743812276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 15:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736896424; x=1737501224; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePVlEVv5m1tigC/CdRn/0kZjaG1+iIHc/7tw87zaT8Q=;
        b=MpoDm+OJNDhJdjYCWgVUIvvSWjsmfW9j3qZIaYsKsLYLfmQc21ghxvoJrPybLnOoot
         WZamlWvuoantqWeaOYocgOgcXbsZqJi72EM0wTMVlTuh/EUbz7jGjHKYPFcCY3l14UsO
         WMPhu4r7HnVrlpwKcO9o6sPttk9On62a0hStFaGjAv20s171lMc31mfSepQ/TTwcDpL5
         BJeafykm4ck6aaFgydnFrne64ulETkCIXDCpFfTVY2t++OE6qO/d5qhqlX456ylYlULM
         dW7aI33TpAeY5IJtGNpLocOO2DD8WxEMCkLXgYv8XHGvSTfCKx61c9kr24NA3apc9+er
         DaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896424; x=1737501224;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePVlEVv5m1tigC/CdRn/0kZjaG1+iIHc/7tw87zaT8Q=;
        b=qMlEkEpelfJrbrIXDNLVDPdL6IkxtD7ZrhPS+VnHQjL3lANC7OfzANZjUibbfhRQWJ
         VnBkuSJcnntixDq7JXL5LDfIczNBn0cDF/0G8puog/HtDbzGXMWqf9puyW1Gbrj7H5jh
         THt2ek8lSwwXz+DeRelux8QYyoArIWmPsl32S9GVjk7y/HT8MyfJSGIktdvMyslPuO0g
         WfqMijJbCePU/u6rnS6QIsw1PhYy5mQQzdCkPAuyTjIfpfHOQXl7GZWhrYVc1uyviX33
         0eg7He5gsOlAXyCmgM3qOf0joQzsWbLOQndX2Ghm2O9GiMigLUvy1QMu4TBTCQO3w9mX
         IbRA==
X-Forwarded-Encrypted: i=1; AJvYcCVU91kcV0OOP8RWRx3p5itjotG2v2qg/U9L/F63hYiF7yrTGzIgDaLShLYSyXP64TN+Eer3wPBGkMCj6lelEqVe@vger.kernel.org
X-Gm-Message-State: AOJu0YyIFptWy70bc2xTloU1Y/Z+1dIkkCSSoEU7WnTSLvQYpfzMCj/d
	gGJcWCOfO1juPmL4HCJ0bxBZV+N01l8ECCM8pcA2K3GtHTIiGgim6z2dPA/xcyubxUgOqWNSTs/
	MSCWGvg==
X-Google-Smtp-Source: AGHT+IHLbP7GZ3eL9yLxHK1VGBTGA/27h/UjLaxoc/tls292SQSUjIcvbNoP47GkJvG5cCmpTxrAfRk7NQmn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b3e8:96da:3fa1:5494])
 (user=irogers job=sendgmr) by 2002:a05:690c:2099:b0:6ee:4b9d:df44 with SMTP
 id 00721157ae682-6f531323dc9mr524617b3.8.1736896424377; Tue, 14 Jan 2025
 15:13:44 -0800 (PST)
Date: Tue, 14 Jan 2025 15:13:32 -0800
In-Reply-To: <20250114231332.13419-1-irogers@google.com>
Message-Id: <20250114231332.13419-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114231332.13419-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v1 4/4] perf stat: Changes to event name uniquification
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
index 5e789fa80590..d91621b6c8c2 100644
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
2.48.0.rc2.279.g1de40edade-goog

