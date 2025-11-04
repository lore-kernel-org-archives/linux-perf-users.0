Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD73491C3
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299723; cv=none; b=Er4Mtw4GOi7S2tv2a9wsUCwr/RG+GlRn0tt/OJSvM58KoFjIK3KWDA5HxaVjxonvmqWWTiCIdqKPyd+MCYaJPmCVAE/fZ3w891O4nNZulRwbWWtjYYOQ/VrSZoLTPWpTNLzX1Tr0TGBYQjKgMh6yxSyaJu3kVshLPP5HJUo/TLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299723; c=relaxed/simple;
	bh=l9WjVRTzXR02G534Y8ur6oBPUiHCmqZkz5nsEhpbC6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=g9ecybbPMHT3p71aGcAARS8vv6aH2JvAVCKjhj5D+a9OQxswXrAlRTm3rXODX3Zb0eK0ktflAUhB3LiOEHKVdDNU5HfSR+GldTV6iSMDRR8bG8vf2z+mf362rRLIM99N1jv72x+cJJPRxXWGglpIv8ZB6oCO1BO9jiSUYx/Nt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjsTXd8/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjsTXd8/"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso6087111a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Nov 2025 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762299721; x=1762904521; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGzX6T80+5mDXFDrMwSicSUCom6rnJXyUmaUagXHkqY=;
        b=LjsTXd8/lPbml365qUdisShwHzhKD96X02IHzf8h2+l/jWtZG+v9b08qMPzk5hcxQ5
         psXKp2ZCvCQdQROCDy5ob0TACFjeskmdgu3BQeHplm4EhHPaGGU9yBP2oGMh2JCcWXYa
         EIjAm1GWbV5UfCJOBQiLSBUNG+jWW+4YEG4Zaj1YvveLLrl3Zk5rMuGxGsl6MwqYSy7w
         H9pS8dQErqxDTUKqeakvf6ZBfnRXPthQcW8ZZhmdU6PVbLnNJROW7aDb4eyiM0xRMuB0
         oiuvn2ZC+dtgaO0Q/Lcez2zR3Ge3mNOMEAK+fiIaWLbo+Y9A6k/LUutGyPkoPbSibakc
         SleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762299721; x=1762904521;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGzX6T80+5mDXFDrMwSicSUCom6rnJXyUmaUagXHkqY=;
        b=Q1lOF9aP0tcxP/DEdYGkXXyhM+vL2hw9y/PVpiMJmweEdaZhNC/iCi649YSanNrNLt
         aZD4i6bLzU0EeKFJWMPgGomVDYNIlcF99D4+HsbpNzp2nOa1ogwDT+4A4DQ2dbFhsWgs
         x+Ynr6s8BBLfkwB+TlNw7XJ/k1W9KiaGWcxWy9teBUzgEQH1G+p8Fxh4rQSPrxnsrXuM
         qzmPGQERYidLw7HcyuulqKKSne2u/gsXlOJJeaBWdYZLfXyv+48apm5++f+nYPwvccou
         fXXo5BUNK7OpS6eGebNCmgqvkxQM8Uow/Lbod6b/5X3i3cj/Ir7kwudTgoFQAfMJWdNe
         6A1A==
X-Forwarded-Encrypted: i=1; AJvYcCUuCbBUeXrT+lyiqlr1STrQt8D9FDoe4Cfrl7yyEML36PJJa1JLIBvNScHUJuImtnNKehoqsce99azDoPLTx/96@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMJR+r1/27YBv468tfeBBMBezaGfLoSU57LFGXf46CitEdYOw
	ni3+e4WH0OAhRXHqm7ANHgIDaYHg/VCHsM1ROLn2n2p4469cgCzdTB3RQl9u8SCnCsiCcjXypBX
	W61uZ+tfqcQ==
X-Google-Smtp-Source: AGHT+IG51wY5xZCiMGwaqZ95pvP83psM5QTnMUHuVRR0GXgMG3ADrlqUFPdQBFgyLOMXfSWPDtwAvGmMHMLy
X-Received: from dlbuu14.prod.google.com ([2002:a05:7022:7e8e:b0:119:78ff:fe1c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b71e:b0:34f:b660:770d
 with SMTP id adf61e73a8af0-34fb6608d73mr438065637.55.1762299720831; Tue, 04
 Nov 2025 15:42:00 -0800 (PST)
Date: Tue,  4 Nov 2025 15:41:47 -0800
In-Reply-To: <20251104234148.3103176-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251104234148.3103176-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251104234148.3103176-2-irogers@google.com>
Subject: [PATCH v2 2/3] perf stat-shadow: Read tool events directly
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When reading time values for metrics don't use the globals updated in
builtin-stat, just read the events as regular events. The only
exception is for time events where nanoseconds need converting to
seconds as metrics assume time metrics are in seconds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2. Make sure that tool time events read from the aggregation index for CPU0.
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
2.51.2.1006.ga50a493c49-goog

