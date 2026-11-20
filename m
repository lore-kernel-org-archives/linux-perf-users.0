Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212827;
	b=d+e8XJlWARdGeEKF3F1OnOWbSuaoUavpGi6sfJmbVe/3auAwErgosE7BwzYEJ4CXwCt1
	 X8mWwzcxtTJHNfwtXCFquowSBJ/+WlA98mikVleK9ziWgre2pzajEVDjat87Kvs0FjoBp
	 +DzptYNDst9Ds6xIjOUJTJJ3uzvkydR3cyGm7uAoqPOIFrLQttQ25tAsBqi44DLzJqT/p
	 uHXm9kH9NJzK2L/AXEcwS5tusjsTT/BBRA4RYLxq7T7BriQ43mmVRKABf48biHKcc9bkI
	 IBk50WYc905Xnpd0lmxpvQkcXZZDhVunhOA6BEa1ttGaEztfU9+lqRg75H610TlftGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/iqd1s6yIkM3QgjlFuj6dLBfLTgftpemZYmyudK9OX0=;
	b=quUOGVg/+tZ2OEPLu/WQKGCkTcbjxXxGYV/RtKORzi4qSImYGn3vYfzcFmdGvsN+81oS
	 l8QGo9wcxJ8Hj5MKyjmtLDcvPIPvCsWx9QjVjJWwjMUxnrIXlyw90tQ2qCeWitaPp6aMi
	 fi7K2lrS09ZXcDeoEJVn01I+adbdrRfzmx0ur9PMzbfaGh6j2AeCxvV2wBak0PVzlI1uR
	 X2OfglGSB7oQOSg7OE6gRe0R5gcT7DI8vIuqnBuVs7P0wU9Vrua1cU9GZp15V8oXmknnm
	 Q+FRioZD2babQeHvSd0MkH4trqM5eQCHjpUyU/hij8iAgFFRtt/9x6rkpKyHgksQxBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h8xCOweh;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE8606A6B0
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60DE8606A6B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h8xCOweh
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-370230d93efso4226692eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212825; x=1795817625; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/iqd1s6yIkM3QgjlFuj6dLBfLTgftpemZYmyudK9OX0=;
        b=h8xCOwehtj+kfV7SY8E7fMyWYaLTjBfcFyMDlOoSRuK0P83xLZTMDfK/frahTNL7Hw
         Z6PM5dfmNvqVL8qWfBcfhQK8Mc+KLAwYD+HVdMFLeckznFlPaKHAiHhQeUZHegTFW+wB
         l+1C2jinEvjTt0wISFoUusWNKIlDzngyCv5Jo+mcIPoim2Hsg+vEtEsbIC6J69ueXlGk
         /rk2IDZNA08nHgpeAwuDgPTRDups4rv7qiSS7VBR60+au2FSJ9kmA5P4zu8LrE5eaHut
         ZsLI2EhsENoV8L5vB43ghsExLZHG94gEH5/26WsX2DfDEON6874e8hip/+mwgpizu7Sv
         e7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212825; x=1795817625;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/iqd1s6yIkM3QgjlFuj6dLBfLTgftpemZYmyudK9OX0=;
        b=kqL20KYOzBDcGXeMf7vHlKl2CJM8yIxmFDCE0/7cFmzR9wfVWXOWSPmfx3Dbif2Jhj
         kgGx32JL3Vc8qGJNW5oqfPvEX5kHtPTg8hCt6DfLzrYMagzeRxjqj8RnD906UQ+5MBIv
         7n483gabgvfrdJ6/X5G9++gHg3JoqC3uDwfBnMV8AZ8W3t7AVrpABBVF4wqLn1q3JbtP
         Or8xXEhPS+Whbr3oLxx0BIj2iRQ+hipHu+99yvs+uUiwfUzS6lW8UTJh4q0/9Bz75hhN
         JhUGWcHotlSPx/reyYZVkgSbPe72aiwvvnAx19Pjk7YhUmUzPmkQpupm+egmZJu+ffpc
         tIEg==
X-Gm-Message-State: APuU4Z9RzJJM8a1JqzwzEnhFRO5jSmCRutKrWxQWUVDqino+jt2oy7r7
	w4QRhYe1aD5AW2hkWBFI9yuwdMJU/FRpLZAf7TYvezWXe0ZFWZnFNSEpY+OpmcXkuiAnEEQeBKM
	Z33/WGSC4Qg==
X-Received: from dyev10.prod.google.com ([2002:a05:7300:430a:b0:343:520f:7a80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d090:b0:386:8bd2:da2c
 with SMTP id 5a478bee46e88-3868bd2db9amr1848412eec.2.1795212824252; Fri, 20
 Nov 2026 14:13:44 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:03 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-3-irogers@google.com>
Subject: [PATCH v3 02/30] perf script: Fix metrics computed from samples
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
2.56.1.750.gf70dc682cf-goog

