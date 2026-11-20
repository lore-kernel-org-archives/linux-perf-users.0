Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212978;
	b=hopQvegkMOklmqkpVUAK9dTrRdGrLEhDgAB2m9BTFbMQy0l4FWR0J+Gd3gjYtwmtNkiI
	 o2RqsJKOjuR6/5fKTGs/O3dLY8wtJ3uYMQHIu1DmV/ti44uY3vpSla/Ufu2k6GBAiewGP
	 f8ntKSbrO6VikLgg2MZJDnSLYVBaIQBIMMlHdP6ecVr0ouny5Ogkv6E52Zhu67WbXuT1S
	 cki51CmlXotOiV32f2hmtMaBttPFDWrNKqG568z2Mc4kDsYA9pFyRfs6tw0InsanyxYFa
	 nKt0sEETk4nJHZ1P6yHx0jY83FdpXIxRZqfY1k10P1CXhQas7jh8huiYI0+AAWIFcpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+3GA/Hx+rJjH8NEt3R7rrCgNjWYX47icXT6CUIFco3s=;
	b=hHQPhbT1unD/N7fcLotg4RqadzkTcBJa0pZoP5gn4zb3e2ZerDsPIyq47Uf+gfTpIbHy
	 WMaPgXEMBYTdU9OrYucReQT94foNJt79Niu5ogPhO2Z1jEF6rDv2lIC19Cr4ZSne5LBta
	 Ft0s9vdQGvRfDJaGY8iEbNmfTGG4eedMxMw8NzK8/h8zqF88sjJ3gINqowQjDbJxDVxC3
	 AqIrF8LXufaxdEjXSdDynwXLjAfrjny0b2w4AYqD10O7By845gPxU6o3TDSmNbFMWhPMO
	 bq6gwAruPigbOtEPdr7P460YyaCsKGnnbqPyeEHl7ilv9nErh+LyNmc+XenWg/+IrdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KTciVtpz;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88209606A6B5
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88209606A6B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KTciVtpz
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-384c78aa0dbso1820340eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212968; x=1795817768; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3GA/Hx+rJjH8NEt3R7rrCgNjWYX47icXT6CUIFco3s=;
        b=KTciVtpzt/ADkq/HTagr56OcyxiJJqKipleAe0Xhbws8JaU6XZYxtRiEftwyh3LUBq
         trQkCxfPIX4aRoKcPmeBrhe1tlm6NEx+KSQRfm25E60hRo+/VQ82sTf+r/kJTenTpOMx
         /hzqWPOyx47HLFUZu7mvoHFUgFY70+UsSlP5GrWN1W//iAKj5r3pzVMNY4UHfplSlggn
         3J0GdfnWMK+iOe3WmSl0alfcbPGW0tN+vdfVQKjO2ctGHiMq+ZZRs6n0WwCXTKYlNeIz
         HcHakFhQc1EWRgSV9XPBEHnuVmSYa6s0Bb8EOY2y+hORhQjBxeDoZ1Z69rMntRlXR1SR
         Y0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212968; x=1795817768;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+3GA/Hx+rJjH8NEt3R7rrCgNjWYX47icXT6CUIFco3s=;
        b=JqPM44kEG5eYry0ahMmUsTH9FBrmalv3sEu4+m2G9mt132ikkhKUot1jVhlOFIBKCe
         aPFggNO5PvX6zPPaXRJBIzxEldyfRcYLJ0SnW/Mxg+iNDrAL4hb2GSsBdJt5RF4TEeQZ
         dmIMwYfho3fBcNxE08K5fApFl12x6z6ez9ijDSMmz8ArsjVOF5KJTIdnoyMxP9q4cXrt
         7zQhUHGVC4CX4alSXZutiQcpnxKS2inP5DMsbUqMV0RLfm9BjCvg70VVS5QTsQ/Oo2yk
         jlU0b7zW2PhDr80v+KLpimQypdGsW/vSBD75cGfOJ74lSKyKsTfrpnTxH6P2m6iO5rys
         0ZVw==
X-Gm-Message-State: APuU4Z9fA7UYgxwA2V1Iq6ExlVqQY5FHxtxWtvXgju3I0g53QQZDZ++a
	R0NnaNh5RHNyYqlYI+W7v0W+OPwsx2Q91r3qXdr1Fw8mIlgiwDypZc2i4BIzR1pzyz9AeOGCsM2
	tOY6eA6CbVA==
X-Received: from dyba9.prod.google.com ([2002:a05:693c:63c9:b0:36d:8068:9180])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f401:b0:385:e4d9:e0e7
 with SMTP id 5a478bee46e88-385e4d9e3f5mr2821138eec.5.1795212967274; Fri, 20
 Nov 2026 14:16:07 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:30 -0800
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
Message-ID: <20261120221332.2245191-30-irogers@google.com>
Subject: [PATCH v3 29/30] perf script: Display metrics for perf stat record data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf script displays the counts of each stat round read from a perf stat
record perf.data file. Also display, after each round, the metrics
requested on the perf stat record command line (or all matching metrics
when --all-metrics or stat.all-metrics=true is used), computed from the
counts aggregated across CPUs and threads, for example:

  $ perf stat record -M insn_per_cycle -a sleep 1
  $ perf script
  CPU THREAD         VAL         ENA         RUN        TIME EVENT
  ...
  cpu_atom/cpu-cycles/  metric:      0.7 instructions  insn_per_cycle
  cpu_core/cpu-cycles/  metric:      1.3 instructions  insn_per_cycle

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-script.txt |   6 ++
 tools/perf/builtin-script.c              | 107 ++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index f0228e784ced..bfd69d411996 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -468,6 +468,12 @@ include::itrace.txt[]
 	default behavior.  If you want to see separate CALLCHAIN_DEFERRED
 	records for some reason, use --no-merge-callchains explicitly.
 
+--all-metrics::
+	Display all metrics that match the recorded stat events in the perf data
+	file, rather than only the metrics requested on the 'perf stat record'
+	command line. Default setting can be changed with
+	"perf config stat.all-metrics=true".
+
 :GMEXAMPLECMD: script
 :GMEXAMPLESUBCMD:
 include::guest-files.txt[]
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index afed2353ef80..135ec34494bd 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2334,8 +2334,13 @@ static void script_print_metric(struct perf_stat_config *config __maybe_unused,
 
 	if (!fmt)
 		return;
-	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx->evsel,
-				   PERF_RECORD_SAMPLE, mctx->fp);
+	if (mctx->sample) {
+		perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx->evsel,
+					   PERF_RECORD_SAMPLE, mctx->fp);
+	} else {
+		/* Metric computed from the counts of a perf stat record round. */
+		fputs(evsel__name(mctx->evsel), mctx->fp);
+	}
 	fputs("\tmetric: ", mctx->fp);
 	if (color)
 		color_fprintf(mctx->fp, color, fmt, val);
@@ -3795,26 +3800,112 @@ static void script__setup_sample_type(struct perf_script *script)
 	}
 }
 
+/*
+ * Set up the computation of metrics whose events were all recorded by perf stat
+ * record. Counts are aggregated globally for the metrics.
+ */
+static bool script_stat_metrics_init(struct evlist *evlist)
+{
+	struct perf_thread_map *threads = evlist__core(evlist)->threads;
+	struct evsel *counter;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (!counter->stats)
+			return false;
+	}
+	/* Metrics may use system_wide, such as for #target_cpu. */
+	stat_config.system_wide = !threads || perf_thread_map__nr(threads) < 1 ||
+				  perf_thread_map__pid(threads, /*idx=*/0) == -1;
+	metricgroup__add_recorded_metrics(evlist, /*metrics=*/NULL,
+					  /*pmu_filter=*/NULL,
+					  /*cputype_filter=*/false,
+					  stat_config.metric_no_group,
+					  stat_config.metric_no_merge,
+					  stat_config.metric_no_threshold,
+					  stat_config.all_metrics,
+					  stat_config.system_wide,
+					  /*default_metricgroup=*/false,
+					  /*metric_only=*/NULL);
+
+	if (rblist__empty(evlist__metric_events(evlist)))
+		return false;
+
+	if (!stat_config.aggr_map) {
+		stat_config.aggr_get_id = script_aggr_cpu_id_get;
+		stat_config.aggr_map =
+			cpu_aggr_map__new(evlist__core(evlist)->user_requested_cpus,
+					  aggr_cpu_id__global, /*data=*/NULL,
+					  /*needs_sort=*/false);
+		if (!stat_config.aggr_map)
+			return false;
+	}
+	/*
+	 * The aggregated stats may already have been allocated, with the
+	 * aggr_map, for metrics computed from samples.
+	 */
+	if (!evlist__first(evlist)->stats->aggr &&
+	    evlist__alloc_aggr_stats(evlist, stat_config.aggr_map->nr))
+		return false;
+
+	if (!stat_config.output)
+		stat_config.output = stdout;
+	stat_config.aggr_mode = AGGR_GLOBAL;
+	return true;
+}
+
+static void script_print_stat_metrics(struct evlist *evlist)
+{
+	struct evsel *counter;
+	int aggr_idx;
+
+	evlist__for_each_entry(evlist, counter) {
+		struct perf_stat_output_ctx ctx = {
+			.print_metric = script_print_metric,
+			.new_line = script_new_line,
+			.ctx = &(struct metric_ctx) {
+				.evsel = counter,
+				.fp = stdout,
+			},
+			.force_header = false,
+		};
+
+		cpu_aggr_map__for_each_idx(aggr_idx, stat_config.aggr_map)
+			perf_stat__print_shadow_stats(&stat_config, counter, aggr_idx, &ctx);
+	}
+}
+
 static int process_stat_round_event(const struct perf_tool *tool __maybe_unused,
 				    struct perf_session *session,
 				    union perf_event *event)
 {
 	struct perf_record_stat_round *round = &event->stat_round;
 	struct evsel *counter;
+	static int show_metrics = -1;
+
+	if (show_metrics < 0)
+		show_metrics = script_stat_metrics_init(session->evlist) ? 1 : 0;
+
+	if (show_metrics)
+		evlist__reset_aggr_stats(session->evlist);
 
 	evlist__for_each_entry(session->evlist, counter) {
 		perf_stat_process_counter(&stat_config, counter);
 		process_stat(counter, round->time);
 	}
 
+	if (show_metrics)
+		script_print_stat_metrics(session->evlist);
+
 	process_stat_interval(round->time);
 	return 0;
 }
 
 static int process_stat_config_event(const struct perf_tool *tool __maybe_unused,
-				     struct perf_session *session __maybe_unused,
+				     struct perf_session *session,
 				     union perf_event *event)
 {
+	struct evsel *counter;
+
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
 
 	/*
@@ -3823,6 +3914,13 @@ static int process_stat_config_event(const struct perf_tool *tool __maybe_unused
 	 */
 	stat_config.aggr_mode = AGGR_NONE;
 
+	/*
+	 * Mark counters unsupported until a PERF_RECORD_STAT event is
+	 * processed for them by perf_event__process_stat_event().
+	 */
+	evlist__for_each_entry(session->evlist, counter)
+		counter->supported = false;
+
 	return 0;
 }
 
@@ -4206,6 +4304,8 @@ int cmd_script(int argc, const char **argv)
 		    "Enable LBR callgraph stitching approach"),
 	OPT_BOOLEAN('\0', "merge-callchains", &merge_deferred_callchains,
 		    "Enable merge deferred user callchains"),
+	OPT_BOOLEAN(0, "all-metrics", &stat_config.all_metrics,
+		    "Display all metrics matching recorded stat events"),
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
@@ -4577,6 +4677,7 @@ int cmd_script(int argc, const char **argv)
 
 	zstd_fini(&(session->zstd_data));
 	evlist__free_stats(session->evlist);
+	zfree(&stat_config.aggr_map);
 	perf_session__delete(session);
 	perf_script__exit(&script);
 
-- 
2.56.1.750.gf70dc682cf-goog

