Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB335A127
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057153; cv=none; b=mVskPFwFaxkBvr80TTPj3+bf5w+4YmkpQT7+ECDyAH0+Oq2TW57U2J684tpsi0RwFEXnDKxRXgfBOpVce5wwYeaGq8UQvEdUDnhdj1gI3b0OR5gJTYt1dyLSViF9CRe1qIjKziS+72OIYLs/UvnBxtBHmBzcYX+VI5jPcrd4qN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057153; c=relaxed/simple;
	bh=hVJICGlrUy8MMJWuUtg1ckaMNBO234W7zrw4C+CGyhw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZcNyxS+hqmaaaJCeYVEylKOOuhQttS/geap3hypja7nTNxZEBGbUFLhUhaiTZoHKYPCGhco40K7rCC1lyvpLoeS3RyDKGETNkLGvfTnbTHpuzTI6BQWHuJwXcIE4zesSNLjjpi5ab1Fa3oVdh768U5N6sT2DD0b8PzUXv3m+7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/IN6cYR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/IN6cYR"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b95d06db747so1745512a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057151; x=1763661951; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1FXHzBhA2SQQSmsUII/uTyO8cL2QPYiQNF1YetQubM=;
        b=q/IN6cYR5aISncm8WszH5O+k5QUcR+2VJG6+Yfdu4X0qmIig8sBmOQ2kbnrGZKOQES
         W0PA2GVuqHqfOByDtUez47QiSaNE+kno6cwAN27JvLTE8q7nHKdYAvzmJVuMgHkbcmDk
         c2sRJEdtYSstP72R4ipL+EcSlJXoPqDIHj40BuqMuvB75tJkfv9gD9giKGZijfBXmC8g
         24AULUJrKElH9nhPBKxaEUHCfpiLckp0WLLWJHkMPN2NLB55ehhX1RyTRVDdNPqsT6C6
         sLSVnYW6FB9AKR9dwrD+U6U5bZ5+YGY9q+c7oc7S88p1CgSvAZA7SY2PAvR8rDYkbm3F
         I57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057151; x=1763661951;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1FXHzBhA2SQQSmsUII/uTyO8cL2QPYiQNF1YetQubM=;
        b=YwSIhQYlIHzw9ZEZbcMUEVYdAWMpXiif8CwpeUy7GqbD8i8R6AL1TIdV8/X3u2l7D+
         Sg9qgAn+M9AkCoTCNdwfut94c4hW+8ktnp8HbqQ39Zos67XSReBaHorO+dNVgEyF9nLv
         h/RsiM8ptcox5W7g9Euv5cSUINHyECSZvqLLHLi4uQouxlPwuRm5Gw6HNWm0uoO4gyXb
         xQ6Vl1Chk/6MD5K8QlGMfiJUc2IHQeCU895bvBooIeZgBzoKSH5pfHu+1uHl2K9jUe6t
         VIIL/fzkzDPce+IxJa4wzGwDQqwBTHApl+fpJzAJthVUSHuGJDfJo76dgU4zPV7nJC/s
         1YTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB4692PQxlGZmgeCACR1UeKyYPMm++Mtxo32FH0wmbxYLDcRYk+LFozqCe7D0uUBRkdaF//zvbEn1GJTYK9Rvb@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxSOW7jpQ0cr7QtU7OTs6ag/MK6ckGzFx2lVVbhydXzfwSfB6
	HbZgy0uT9it3hkZme34NYwqsJAx58W/55EKqPmdNs3TJbvKW+R9w5/CR0lOr8ZNQ/NJ/Mjrk7Mk
	HtF6tokZRog==
X-Google-Smtp-Source: AGHT+IGtzsF5urWKveWPScCG0h+dMh3vXRquU320w0u1H20MqrHGTFvpU8Dd08FOYTy1HNYzKtEOtnJe5xyJ
X-Received: from dykh19.prod.google.com ([2002:a05:7300:5713:b0:2a4:738e:9908])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fd03:b0:2a4:3593:ccb9
 with SMTP id 5a478bee46e88-2a4ab230e56mr118302eec.0.1763057150808; Thu, 13
 Nov 2025 10:05:50 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:10 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-5-irogers@google.com>
Subject: [PATCH v4 04/10] perf stat-shadow: Read tool events directly
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
 tools/perf/util/stat-shadow.c | 149 +++++++++++++++-------------------
 1 file changed, 66 insertions(+), 83 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index b3b482e1808f..6c1ad78604e1 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -26,7 +26,32 @@ void perf_stat__reset_shadow_stats(void)
 	memset(&ru_stats, 0, sizeof(ru_stats));
 }
 
-static int prepare_metric(const struct metric_expr *mexp,
+static bool tool_pmu__is_time_event(const struct perf_stat_config *config,
+				   const struct evsel *evsel, int *tool_aggr_idx)
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
+static int prepare_metric(struct perf_stat_config *config,
+			  const struct metric_expr *mexp,
 			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
 			  int aggr_idx)
@@ -36,93 +61,51 @@ static int prepare_metric(const struct metric_expr *mexp,
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
-			case TOOL_PMU__EVENT_SYSTEM_TIME:
-				stats = &ru_stats.ru_stime_usec_stat;
-				scale = 1e-6;
-				break;
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
-			case TOOL_PMU__EVENT_CORE_WIDE:
-			case TOOL_PMU__EVENT_TARGET_CPU:
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
@@ -168,7 +151,7 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(mexp, evsel, pctx, aggr_idx);
+	i = prepare_metric(config, mexp, evsel, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -229,7 +212,7 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp, /*evsel=*/NULL, pctx, aggr_idx) < 0)
+	if (prepare_metric(/*config=*/NULL, mexp, /*evsel=*/NULL, pctx, aggr_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
-- 
2.51.2.1041.gc1ab5b90ca-goog

