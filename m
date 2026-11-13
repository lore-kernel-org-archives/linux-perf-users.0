Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599625;
	b=TDSkAhANDETrzoXueVKIF1Tz8XVpnB8ZGNyzAcRyMqPJN2H0jGK3jAnnDojaR8Al5WMQ
	 9zgGByIk56HaOm0PyVkOJR55bFw5hdGkKdKfkiQF9mD90F8SCVFCaH/2b9BBFoVdToDkB
	 o6BPkrz8jTwJJdNvPCPnwpwytiVC98FOGS13yQS30uHjHWNJQhlxok08Csvhjk+uX9oeP
	 kHvzdBOwSgRsjZ1A85g49M5IAABEFe8n9QwQD/IPUGv2wcjzYtPEDjFREPUrLUyOTTlwg
	 g3sdvsYJ5EqUDcxQoeeqJinC0NEQZPz22ChBJkbmnMwk5TWq2hLKgwrPLbxtYHsfSGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kfhrMsa4puJEq2NxLT5Hxuoaf4b0ucNLDbW3ALcX/Sk=;
	b=sgQKIfVoZ/oW+BoY/58E+1aUE23qbkd/Lu3ADT+Bh1pPdgX+YMZ5j4qIHuy2cgRfUGKi
	 q4rILTOtaMG1fmbG1+ijWQpwARIpkEJ7Pb8pwaahcKDOTnS20meYWdUDsKVVa8ztnHWIN
	 oFpvMOfvNrdWF5+giPKm0qtDu0USWcMToG215Apos9+mu/iZxBkIc5dJc/NWlxWorjORU
	 jxuVQrDjmEF6yOy64H47oxrUTvIcCzilpfl90t8bmpwhwTjIIsaCGb/jB428ESnx9GzF2
	 1mfqvntIxo55w1epbqsl0OfAsOvnO8z9FkKIsvd4m/Q9jIoE/2Z13vzn8qO+/302qdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DUtwgLhe;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FA6606A8AA
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15FA6606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DUtwgLhe
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1728673eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599623; x=1795204423; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfhrMsa4puJEq2NxLT5Hxuoaf4b0ucNLDbW3ALcX/Sk=;
        b=DUtwgLheIFYl1WP8cjmPLtIoMd8gNadv7BuBZfeFPWltJwyODjztoeKWY0nuZbMXgS
         PQ9c7S59r44BLiQ1te1AquHsY/72mTlDHyo6D/6waczEEtQgZmesRLKQvM+Bz8IcU4Y3
         GO5a7T9IP80E2Pzti8IaxecOOsMl4TMei4GTUWNXviSVuFylKQD4h55CkSqZQekWctaD
         vGthjSDOp6R51sj9B7rNveZIp43tHdyFyeoVTsojUrhieGPGWCI/rMvwmQLjPtGSfh/a
         A5XuhEwn712ckC3cK9CETHhTiByf+jIkDkl1r+LSKatmd3u7Gs5Oc2qEH/s2EM1v2wlW
         wQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599623; x=1795204423;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kfhrMsa4puJEq2NxLT5Hxuoaf4b0ucNLDbW3ALcX/Sk=;
        b=a52ycmPeRK9FTovjPzxHGJzxIbnC/kvlzAx98J443Y9S+eQdXRXOvz2AgGAQ+ChYJ/
         5eO8OyKorZweMixbl4Q/YHr2N9bH0FABdEWwO7ICxbWaNm1BjyMs3+CUum4s7dkP8TPz
         dgjORlguouzN8/bewWRACmMcnkeH9IXS/K+FIBoOnViK+0tE/nI9kuvxQBOBQQFWk1mc
         a33gzXXqRPvZizTNNQ3TtVig49rpHq2XtQgBXPbFW4PzsnolokKAuer/6rnKe8Miz5dh
         D2B2DhSPki6nB4vydP5JATOL4EvxjkOTA+AWydj7AKAKgXx8MnEosL1a3RDpVPfCrWq0
         RseA==
X-Gm-Message-State: APuU4Z/5SXL47LyNRCfWJ6DFEr8yaVQP7RcsvMv90sHdYoRCv1Qnoml0
	nmvnDn6vEnNXZWvAXFiFj4JGYrqPviZLKHfCQWD8kSUxcXUram+X+HQupcLIIafJ4zcAhDRF2PK
	oM7HPGNnsvQ==
X-Received: from dyr22.prod.google.com ([2002:a05:693c:4016:b0:359:72f9:2aab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:40c3:b0:370:1e50:a485
 with SMTP id 5a478bee46e88-379679df0a1mr3558243eec.37.1794599622862; Fri, 13
 Nov 2026 11:53:42 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:07 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-3-irogers@google.com>
Subject: [PATCH v2 02/30] perf script: Fix metrics computed from samples
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf script -F metric computes metrics from the sum of sample periods of
the events, but the computed values were wrong and the output was
garbled:

 - perf_stat_process_counter() replaces each count with its delta from
   the previous raw count. As counts were left as deltas, the next sample
   computed negative deltas for the counts of all CPUs and threads other
   than the sample's. Restore the counts to the running totals after
   processing.

 - Metrics for all events were displayed after every sample. Only display
   the metrics associated with the sampled event.

 - The new_line callback started a metric line that the next metric
   started again. Each metric starts its own line, so make it a no-op.

 - The metric value was written to stdout rather than the event's output
   file.

For example, with whitespace reduced:

  $ perf record -e '{cpu_core/instructions/,cpu_core/cycles/}:S' -a sleep 1
  $ perf script -F comm,cpu,event,period,metric

Before:

  perf [001]  2206 cpu_core/cycles/:
  perf [001] metric: 42972.00 tma_info_inst_mix_instructions
  perf [001] metric: perf [001] metric: 1.20 tma_info_thread_cpi
  perf [001] metric: perf [001] metric: 0.83 tma_info_thread_ipc
  perf [001] metric: 51762.00 tma_info_thread_clks
  perf [001]   804 cpu_core/instructions/:
  perf [001] metric: 18446744073709549568.00 tma_info_inst_mix_instructions

After:

  perf [001]  2206 cpu_core/cycles/:
  perf [001] metric: 67668.00 tma_info_thread_clks
  perf [001]   804 cpu_core/instructions/:
  perf [001] metric: 46758.00 tma_info_inst_mix_instructions
  perf [001] metric:     1.45 tma_info_thread_cpi
  perf [001] metric:     0.69 tma_info_thread_ipc

Before, the cpu_core/cycles/ sample is followed by the metrics of both
events, such as tma_info_inst_mix_instructions that only uses the
instructions event, rather than just tma_info_thread_clks. The CPI and
IPC lines repeat the "perf [001] metric:" prefix as script_new_line()
started a line that script_print_metric() started again. The following
cpu_core/instructions/ sample shows tma_info_inst_mix_instructions as
18446744073709549568, a negative delta, as the counts of the other CPUs
were left as deltas by the previous sample. The same deltas made the
before tma_info_thread_clks value of 51762 too small.

After, each sample is followed only by the metrics of the sampled event,
one per line, and the metric values are computed from the running totals
of the sample periods of all CPUs.

Fixes: 4bd1bef8bba2 ("perf script: Allow computing 'perf stat' style metrics")
Fixes: 3622990efaab ("perf script: Change metric format to use json metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b6691ebb1b4e..c5a9651a197c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2340,18 +2340,14 @@ static void script_print_metric(struct perf_stat_config *config __maybe_unused,
 	if (color)
 		color_fprintf(mctx->fp, color, fmt, val);
 	else
-		printf(fmt, val);
+		fprintf(mctx->fp, fmt, val);
 	fprintf(mctx->fp, " %s\n", unit);
 }
 
 static void script_new_line(struct perf_stat_config *config __maybe_unused,
-			    void *ctx)
+			    void *ctx __maybe_unused)
 {
-	struct metric_ctx *mctx = ctx;
-
-	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx->evsel,
-				   PERF_RECORD_SAMPLE, mctx->fp);
-	fputs("\tmetric: ", mctx->fp);
+	/* Each metric is printed on its own line by script_print_metric(). */
 }
 
 struct script_find_metrics_args {
@@ -2524,7 +2520,6 @@ static void perf_sample__fprint_metric(struct thread *thread,
 	};
 	struct perf_counts_values *count, *old_count;
 	int cpu_map_idx, thread_map_idx, aggr_idx;
-	struct evsel *pos;
 
 	if (!init_metrics) {
 		/* One time initialization of stat_config and metric data. */
@@ -2593,14 +2588,23 @@ static void perf_sample__fprint_metric(struct thread *thread,
 	/* Update the aggregated stats. */
 	perf_stat_process_counter(&stat_config, evsel);
 
-	/* Display all metrics. */
-	evlist__for_each_entry(evsel->evlist, pos) {
-		cpu_aggr_map__for_each_idx(aggr_idx, stat_config.aggr_map) {
-			perf_stat__print_shadow_stats(&stat_config, pos,
-						aggr_idx,
-						&ctx);
+	/*
+	 * Processing the counter replaced the counts with deltas from the
+	 * previous raw counts. Restore the running totals so that only the
+	 * next sample's period is added to the aggregated stats.
+	 */
+	for (unsigned int cpu_idx = 0; cpu_idx < perf_cpu_map__nr(evsel->core.cpus); cpu_idx++) {
+		for (int thread_idx = 0;
+		     thread_idx < perf_thread_map__nr(evsel->core.threads);
+		     thread_idx++) {
+			*perf_counts(evsel->counts, cpu_idx, thread_idx) =
+				*perf_counts(evsel->prev_raw_counts, cpu_idx, thread_idx);
 		}
 	}
+
+	/* Display the metrics associated with the sampled event. */
+	cpu_aggr_map__for_each_idx(aggr_idx, stat_config.aggr_map)
+		perf_stat__print_shadow_stats(&stat_config, evsel, aggr_idx, &ctx);
 }
 
 static bool show_event(struct perf_sample *sample,
-- 
2.56.1.703.gf848ed807c-goog

