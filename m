Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749565;
	b=Q0KA5gz7wI2XDyLO3c9iZ21WZLocquNoMDb0D9thFOaKN8kNkJK4OtFw4y5oaQoRlSgl
	 fuNw3Rnm78rZhaklGJp+89HaUHmZIBBn46Flf2DYOD2yNwm0z0jEVBbluSkMeWT6xJmns
	 eWiyHYTc1IvPW64kCICiY+ieua0QpvRuj6XDLrisrY9AJsB0hcfLSHFcgWPWfPuI/gcCP
	 VgfuFTXhPEfpzXlSUWvOiPAsfR3/3S5RXfuT+RR4k7pW36ekAe8u8ix9bpuMYir33j3Lf
	 4oeuSzJbVwIH8QW2d2QqsmpCXWM7Z0MvVpecOj1X+msg2+09rBZgbvaMltWbynOlkxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=03fEdwKC+32oYkwLbiklOK3DaL2k6ls++oHZizBEI2g=;
	b=5lp6oQapLex/NWQgM8iut6klDsfclB8WjTOmVnbYLzaHq2dbpHOAonHWyO7BuLCbxW/c
	 zRxp+CjFmJHDuXFxupF+qBehYixK+TKleZxSg4XNRwjP5MbjX92hBNgUV3Jvk/BZHS5s3
	 fkGG9wnLFl4ZHawTO+U0ja4IWKRa/Uws5BetaxMlPlfZf5sfCos9RxoL5d1I22Apb/enA
	 dt1ABOb/s2YIgAW8ub0fP01tnTfZfPdLZ60uCueAOcEr87XIf4seM8HH6BfC9dlnWgsgp
	 7fmNydxzBKL7MHYJq+NDh6/yU+2oEvbqbMC45sY5Tw7QXIreq910ZGZ+92Lx2/aDlXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PR3Phmqh;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD64606A330
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CD64606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PR3Phmqh
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b20a4b5f2bso240410c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749564; x=1794354364; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03fEdwKC+32oYkwLbiklOK3DaL2k6ls++oHZizBEI2g=;
        b=PR3PhmqhCdcWbCrxmhvvWpuHCPJlLPNIuoOxOhlmR39WSRFeRnYKW6EVAz2INukbTp
         qnvLhH2pN5ZnO4kOxEa0bxG3hgxvtzA2JGuRudH7ex2WnPmznL5bWb/LrHgj3MFI6Q+D
         rCMtXhVpkhUsYRAVp6Ec0IDydhhsWNSktIQfMT+yM99miJWGYEXK9WxIuSodvKNBqZBO
         qCbVV1akx8xbpeXuDLc1VBYdvzxFu1J9+Gb0cKl62biQJgcrF77UG4/9BL+KJY4Uq3U9
         o+2Vv74wE7DPqLKScPYNvh5Dp9d3OXLlEdn/djzvG+yMnzdSvRBZ82hAq08MlKBvJu4A
         w/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749564; x=1794354364;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03fEdwKC+32oYkwLbiklOK3DaL2k6ls++oHZizBEI2g=;
        b=SgRtyBbYcRdivPn/G/qgAIix+hTWXMaM35sdj9OBS8no4wPfzu0aQJ44scsJ2E0NjC
         ot/1mnrf3X9OimgfMXxyy3ALiVzfMgF7ZOl4Yj5Hre5zv/OmPVtOrB+Rr2Z29Z3PqzvO
         Yrnmm6RVZ4OveZvBeGSB4epc2TcH6QP4pPSBbQt5rEHdxt06DkYzxU/17idBgc3cqq2G
         OBw1fXe7rSPcE6Mg4l0dr61kNMD5EU1dIUd6tEVOmkSC3pt2P/gedFe2OJLpM+C8OeBm
         2fM55QwyKJRzHrL6l9mqjkgbMXQiFuKv1zMgwOIaEaOKVugOFlKniBP/Gk4Bql1tnvGY
         En/w==
X-Gm-Message-State: APuU4Z/zUEMVBOdEX//DGsqD8uoQFoqyBBAL/LQ5qouuxcWT6xZQ9eL8
	81I0Ab/LhRCJXz/x6saNcLFe9FGQA9DxTpC9yVWi339qUA4pnUPdNwvK4HxsL2VyH7l0UluCaon
	2X+GxPLLVNvZD4o8OV3SuU5N+VWmi3ifVAYwnlj8sD1w1hxTfWrGhPwDz/bamq4twBxM1GPSv3+
	yDLTnWDIf9lHMhzmkRMrslfGGeZ//ohsw7in79zMjulll2fLEKY1Xg+aU=
X-Received: from dlbur23.prod.google.com ([2002:a05:7022:ea57:b0:15b:1fa2:b32d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4517:10b0:185:fd0c:4585
 with SMTP id a92af1059eb24-1ac5fb18de9mr21081064c88.33.1793749563835; Tue, 03
 Nov 2026 15:46:03 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:37 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-22-irogers@google.com>
Subject: [PATCH v1 21/41] perf script: Fix metrics computed from samples
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
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
index da3f1793774e..199a5af81f37 100644
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
 
 static struct aggr_cpu_id script_aggr_cpu_id_get(struct perf_stat_config *config __maybe_unused,
@@ -2379,7 +2375,6 @@ static void perf_sample__fprint_metric(struct thread *thread,
 	};
 	struct perf_counts_values *count, *old_count;
 	int cpu_map_idx, thread_map_idx, aggr_idx;
-	struct evsel *pos;
 
 	if (!init_metrics) {
 		/* One time initialization of stat_config and metric data. */
@@ -2445,14 +2440,23 @@ static void perf_sample__fprint_metric(struct thread *thread,
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
2.56.0.385.gac671c819a-goog

