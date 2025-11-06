Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E82E5B27
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413176; cv=none; b=ANf29Bd0jop0TivkfdqQ/k7CDQEhpcmiBU/ap/bAkyaJQa9+k289duPfntjtYi5NMJpAFH1wYWqaJ49471f5oAWqyUvZCwKr4Z78+QIwh2Bjl/PQjUE/Z/lrEGHxXVN7O7x5znTOUbVgxoNuHDgHq9KeZzVy3sO8vO5oiMgmrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413176; c=relaxed/simple;
	bh=EC/tZ9Xdy5myRRq+PdXPCKA/bbIvt50N1agXEhWd7Rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=i0mfv/MNvSW3cjmMgUYvJG4CASNzyzzDEChIQPUtWKuqlQ4WIreNOX74MgTRMcB8i1QQUrJZeKvOUqeiLcC+1LcJ46OMKSZ84dHyB76s3COkifIAYO0EI/74knD71Ku/yyekwnpJPf9hWhrkQ2hUGFYsU5v87XYLEIB71+Zd6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tg5T3ARd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tg5T3ARd"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62da7602a0so621570a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Nov 2025 23:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413173; x=1763017973; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4ZNYhXXjGnRVVF3I/Hjm5vaAXPO71/s9Kf71lIm9nQ=;
        b=tg5T3ARdGqbsgOew2K+s222ZCz7ckEai9nG75XNpK0yYq2f4L5m9IaYJyF7kJpcG5g
         9KUJodYzUCSwNNDnBKgbYyJZm8RXO8iBqEEbc7YnaKp6ab5/JkjImngcLLkKNIXguVAc
         u4lPMP2Yam/vUCdtIrkkLKRhF2KaBKSbmcbjYe1naSBweHlFWWTYOBmhm3/tA6ztf/9v
         Qi4Xf5Yz9xcvkMkIWhedHV3dEcX7kyqSuCFexChbHdLx8AbhAFxmhp5X/tVteVVn4j1d
         u9It7uQhZbctr3z/mAPsnCRXl5oR9FtwjjUK9mhKKon9A4UUdpSRL9xV9r7hmrnb9lmI
         dFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413173; x=1763017973;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4ZNYhXXjGnRVVF3I/Hjm5vaAXPO71/s9Kf71lIm9nQ=;
        b=Ka0HMQjlMpu7r8ZkF2efr623AY+UGwiKjUdpbae7AatQYIwjfDoiZ6VEjJi6UXrb0U
         E6ZI6VQ+wRiGHqZBSpUgXmC0i3D5lSYhpHsEhsLGRDl+FKXEf4aayYX9SHgiO1EI7wCx
         qqZWpWF6WNyFX7c8gMgLcDzM4eVqF85M1iZUGJTEV4zP7Ko/SE12YskhJLN3MKLRcS85
         SGfB2DAIX3wdyNUsKwFWx5EkWxcMg66phSMddEo2Sp6QHVSF9eSagB8+SyN6ltPOFuvR
         SkuF+Utm5LApphjt6LUAMt/0AbkD0DQkzSaQCS5yfBDyk8A26r9sUd8MQajBjfClIj/u
         /DUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD4DhaMGoU5MGxw8F0jMnt5IYdLAAGNqOO2obELNVk3dq43tBsrEKXt5Z1PwZscNDltK+8f/j2hQZ7quGrDc2x@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdmck+mVhaIYNWs0WiUVq1D3fPXDoCWE9J00NUINpGTk9okLHQ
	tkHULLUcIzJAIhafzrzb/25rzXWfUeIfYNWTL7J9DIE9nV5z4FgDm5CAgzxPH7zyjqX0V6OSAXd
	fkT/8EBey4A==
X-Google-Smtp-Source: AGHT+IHGU1zIshvyY+car8C198znETVpyz+J4B/MEF/IzHG6Vp7onwTJYM5tT/KUFm8oCtJPiJO3W6kuDROM
X-Received: from dlbut3.prod.google.com ([2002:a05:7022:7e03:b0:119:49ca:6ba5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4305:b0:344:bf35:2bfa
 with SMTP id adf61e73a8af0-34f8561d759mr8426190637.33.1762413173091; Wed, 05
 Nov 2025 23:12:53 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:35 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-5-irogers@google.com>
Subject: [PATCH v3 4/9] perf stat-shadow: Read tool events directly
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When reading time values for metrics don't use the globals updated in
builtin-stat, just read the events as regular events. The only
exception is for time events where nanoseconds need converting to
seconds as metrics assume time metrics are in seconds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 147 +++++++++++++++-------------------
 1 file changed, 66 insertions(+), 81 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index abaf6b579bfc..939ac3269a44 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -371,7 +371,32 @@ static void print_nsecs(struct perf_stat_config *config,
 	}
 }
 
-static int prepare_metric(const struct metric_expr *mexp,
+static bool tool_pmu__is_time_event(const struct perf_stat_config *config,
+				    const struct evsel *evsel, int *tool_aggr_idx)
+{
+	enum tool_pmu_event event = evsel__tool_event(evsel);
+	int aggr_idx;
+
+	if (event != TOOL_PMU__EVENT_DURATION_TIME &&
+	    event != TOOL_PMU__EVENT_USER_TIME &&
+	    event != TOOL_PMU__EVENT_SYSTEM_TIME)
+		return false;
+
+	if (config) {
+		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+			if (config->aggr_map->map[aggr_idx].cpu.cpu == 0) {
+				*tool_aggr_idx = aggr_idx;
+				return true;
+			}
+		}
+		pr_debug("Unexpected CPU0 missing in aggregation for tool event.\n");
+	}
+	*tool_aggr_idx = 0; /* Assume the first aggregation index works. */
+	return true;
+}
+
+static int prepare_metric(const struct perf_stat_config *config,
+			  const struct metric_expr *mexp,
 			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
 			  int aggr_idx)
@@ -381,91 +406,51 @@ static int prepare_metric(const struct metric_expr *mexp,
 	int i;
 
 	for (i = 0; metric_events[i]; i++) {
+		int source_count = 0, tool_aggr_idx;
+		bool is_tool_time =
+			tool_pmu__is_time_event(config, metric_events[i], &tool_aggr_idx);
+		struct perf_stat_evsel *ps = metric_events[i]->stats;
+		struct perf_stat_aggr *aggr;
 		char *n;
 		double val;
-		int source_count = 0;
 
-		if (evsel__is_tool(metric_events[i])) {
-			struct stats *stats;
-			double scale;
-
-			switch (evsel__tool_event(metric_events[i])) {
-			case TOOL_PMU__EVENT_DURATION_TIME:
-				stats = &walltime_nsecs_stats;
-				scale = 1e-9;
-				break;
-			case TOOL_PMU__EVENT_USER_TIME:
-				stats = &ru_stats.ru_utime_usec_stat;
-				scale = 1e-6;
-				break;
-			case TOOL_PMU__EVENT_SYSTEM_TIME:
-				stats = &ru_stats.ru_stime_usec_stat;
-				scale = 1e-6;
+		/*
+		 * If there are multiple uncore PMUs and we're not reading the
+		 * leader's stats, determine the stats for the appropriate
+		 * uncore PMU.
+		 */
+		if (evsel && evsel->metric_leader &&
+		    evsel->pmu != evsel->metric_leader->pmu &&
+		    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
+			struct evsel *pos;
+
+			evlist__for_each_entry(evsel->evlist, pos) {
+				if (pos->pmu != evsel->pmu)
+					continue;
+				if (pos->metric_leader != mexp->metric_events[i])
+					continue;
+				ps = pos->stats;
+				source_count = 1;
 				break;
-			case TOOL_PMU__EVENT_NONE:
-				pr_err("Invalid tool event 'none'");
-				abort();
-			case TOOL_PMU__EVENT_MAX:
-				pr_err("Invalid tool event 'max'");
-				abort();
-			case TOOL_PMU__EVENT_HAS_PMEM:
-			case TOOL_PMU__EVENT_NUM_CORES:
-			case TOOL_PMU__EVENT_NUM_CPUS:
-			case TOOL_PMU__EVENT_NUM_CPUS_ONLINE:
-			case TOOL_PMU__EVENT_NUM_DIES:
-			case TOOL_PMU__EVENT_NUM_PACKAGES:
-			case TOOL_PMU__EVENT_SLOTS:
-			case TOOL_PMU__EVENT_SMT_ON:
-			case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
-			default:
-				pr_err("Unexpected tool event '%s'", evsel__name(metric_events[i]));
-				abort();
 			}
-			val = avg_stats(stats) * scale;
-			source_count = 1;
-		} else {
-			struct perf_stat_evsel *ps = metric_events[i]->stats;
-			struct perf_stat_aggr *aggr;
-
+		}
+		/* Time events are always on CPU0, the first aggregation index. */
+		aggr = &ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
+		if (!aggr || !metric_events[i]->supported) {
 			/*
-			 * If there are multiple uncore PMUs and we're not
-			 * reading the leader's stats, determine the stats for
-			 * the appropriate uncore PMU.
+			 * Not supported events will have a count of 0, which
+			 * can be confusing in a metric. Explicitly set the
+			 * value to NAN. Not counted events (enable time of 0)
+			 * are read as 0.
 			 */
-			if (evsel && evsel->metric_leader &&
-			    evsel->pmu != evsel->metric_leader->pmu &&
-			    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
-				struct evsel *pos;
-
-				evlist__for_each_entry(evsel->evlist, pos) {
-					if (pos->pmu != evsel->pmu)
-						continue;
-					if (pos->metric_leader != mexp->metric_events[i])
-						continue;
-					ps = pos->stats;
-					source_count = 1;
-					break;
-				}
-			}
-			aggr = &ps->aggr[aggr_idx];
-			if (!aggr)
-				break;
-
-			if (!metric_events[i]->supported) {
-				/*
-				 * Not supported events will have a count of 0,
-				 * which can be confusing in a
-				 * metric. Explicitly set the value to NAN. Not
-				 * counted events (enable time of 0) are read as
-				 * 0.
-				 */
-				val = NAN;
-				source_count = 0;
-			} else {
-				val = aggr->counts.val;
-				if (!source_count)
-					source_count = evsel__source_count(metric_events[i]);
-			}
+			val = NAN;
+			source_count = 0;
+		} else {
+			val = aggr->counts.val;
+			if (is_tool_time)
+				val *= 1e-9; /* Convert time event nanoseconds to seconds. */
+			if (!source_count)
+				source_count = evsel__source_count(metric_events[i]);
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
@@ -511,7 +496,7 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(mexp, evsel, pctx, aggr_idx);
+	i = prepare_metric(config, mexp, evsel, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -572,7 +557,7 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp, /*evsel=*/NULL, pctx, aggr_idx) < 0)
+	if (prepare_metric(/*config=*/NULL, mexp, /*evsel=*/NULL, pctx, aggr_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
-- 
2.51.2.1041.gc1ab5b90ca-goog

