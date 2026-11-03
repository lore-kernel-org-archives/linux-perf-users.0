Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749571;
	b=JgHheuXw/y2uNAyRxAC5RN3GaVAXgvk46VyVT7WYLKEvV5M0ZjZo1t3XNRGwz0Xse5uW
	 u8hcifpJpo/VyD5bzY7G4RoSHzcqTTtyvipRwWVgRsNxoVWH4ji/MvtogEZddKzpm7jfR
	 8GVewKNc1E3AHK9QPlPJ26pGa2OltoTVimo3mjEjQWzCyWfRKR+Da5Ze17AqGwxRjm/mw
	 +wpZ5WtLhOZPN8rXPB2oYCk9RcEJePAvSdrpKqcmM3OjgnI0VVpvrUxn6rHdZfJzXoI8e
	 mmZOIBB6X+jxnOlTd/2CKPIYTr3t4Pj5pFcL/KlogVo8GGt69EbBKaT8JmPPQ+L4Rog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BdNIDHXwQW7cVFtv3QOuCHu+O347LacODj9B7d52BFs=;
	b=4dWOCtapxLuswZuEj46rA4zT9Kpu6eHOfY6sWFSpVbrQ1W30GNWUOHVckO8Il4ZsD+r6
	 OxSqLCsV0IXFXCt6few+FGHxiku77Amg0/JbSWk6KO/TC+vt88uEa4gOcvWH42LXaE8Zy
	 SkOGAsMTarkRH36ego93CptyabogkjelxpHdUH/4euqjaOOACmjIXpfUYpTaTJy1swDgm
	 2HI57wd3usLWu+WNifmURZzGHtChkidsDN50lbH696B7ftbrqjWZtrAf+2Dw6iPOC58Nk
	 1+tNf0r0EVwo+RpCPnuCFuz9JzD/Vb72bhVEg/mNNBsyOCNwV6pnHYY4FrlAXpWSVwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pzNh0oHa;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09744606EEAB
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09744606EEAB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pzNh0oHa
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1a2af4c8cbaso92892c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749570; x=1794354370; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BdNIDHXwQW7cVFtv3QOuCHu+O347LacODj9B7d52BFs=;
        b=pzNh0oHawxxuYImTRiw5FmGhtcpfUnvRAFRMuHMiy9xrFWnvzjZVLq55QHGT4dndxI
         gpsV+18coGL9CAhwFZpEvjNr4QMPEXnLV+Fd6lR5ddTFaCxRbwGmxFP4rbHHHA16nVOi
         /Lhlc04ALaJLr6LovVIF+JI/waT20kwAT3aHj0bU0QD/6tgE7wOBrEDPkMyvUsLGUGAA
         7zAPEv5x7+GnSBAJj5zbrX2AWdCeyjwPHfnUwok3wR97Q/7xzt/XDyx5aaxN/3x0gTbp
         zU5+GYtXrxeKox+YiERcVW3sTcuNjuyjiWWwSrOdp602BgeV14LTX830QsO+IxZ6BrEo
         +Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749570; x=1794354370;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BdNIDHXwQW7cVFtv3QOuCHu+O347LacODj9B7d52BFs=;
        b=RSueWE3riMYLn2pp/Pgp03Rrlemtx96Ywupw/82JSa+gS7A+6f4sfE4oH//wjvvLBp
         iAFN0f0outbb87CFhV91P8DCNCvHMHbTMFT7qCwudZry2TVDiIIjYro2gxrmeCtpZwpA
         kLjICj8xeqT7rkJ0DZ1UW7IglIdmwSeRseWClvRMP4RFN8jH4mDtp/o7ohPdMAn4m5tO
         CexkhKaLoZM+Vv+1XILUQRMCM8F1uvRsDjezH2DMMmcAaF0LoXjqCT79d6BlonCNQ4hW
         B/K+C09M4jIjTlfOXmv53ZxffOF2fS2hlgJ5BscrKCrxcusGR6Xmp3HA5jQm2C+apCgj
         0ylA==
X-Gm-Message-State: APuU4Z9hfmdztFwBTD7D2JdGZ6hR1AakilTgJqka+jfeUKu3EFJrwn/Z
	flSoTLzTM3neYDTNwNgt8N+WPoBWwbq64TFBn9pZgdg5dhK1pvC6B88QlxxjpF8ouJwpt/cejZu
	oWacokjYoS89cAxD3X9/eZ8/SfcBMPZvh/32Z7PMrjWBVRMdkEU4RejG90u731sQTDgWUC+GYjS
	a+5IOkFGTlZOT1JLIm+kl+17qLNOqVmjAZdOX/IkFW9FEviTqVaRy9iz0=
X-Received: from dleh6.prod.google.com ([2002:a05:701b:4346:b0:196:8199:c26c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7e0c:b0:14c:d8d9:9502
 with SMTP id a92af1059eb24-1ac5a0b8a9amr21752968c88.14.1793749569476; Tue, 03
 Nov 2026 15:46:09 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:39 -0800
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
Message-ID: <20261103234502.1008382-24-irogers@google.com>
Subject: [PATCH v1 23/41] perf stat report: Display metrics for recorded events
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

perf stat report displays the recorded counts but not the metrics that
perf stat record displayed, as metrics aren't recorded in the perf.data
file. Inspect the recorded command line in struct perf_env and display
the metrics requested on the perf stat record command line (or the
default metrics when no events or metrics were explicitly specified),
for example:

  $ perf stat record -M insn_per_cycle -a sleep 1
  $ perf stat report
  ...
    784,599,279  cpu_atom/cpu-cycles/   # 0.7 instructions  insn_per_cycle
    586,070,692  cpu_atom/instructions/
    776,737,361  cpu_core/cpu-cycles/   # 1.3 instructions  insn_per_cycle
  1,011,699,468  cpu_core/instructions/

    1.004467030 seconds time elapsed

Also add --all-metrics (and the stat.all-metrics config option) to
display all metrics whose events were recorded in the perf.data file,
as well as -M/--metrics and --metric-only options to perf stat report.
Set stat_config.system_wide from the recorded thread map as metrics
such as CPUs_utilized depend upon it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-config.txt |  7 ++++
 tools/perf/Documentation/perf-stat.txt   |  5 +++
 tools/perf/builtin-stat.c                | 53 +++++++++++++++++++++---
 tools/perf/util/config.c                 |  3 ++
 tools/perf/util/stat.h                   |  1 +
 5 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 6cff6f26af8d..906e59c7e9d5 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -713,6 +713,13 @@ stat.*::
 		(boolean) Change the default for "--big-num". To make
 		"--no-big-num" the default, set "stat.big-num=false".
 
+	stat.all-metrics::
+		(boolean) Change the default for "--all-metrics" in
+		"perf stat report" and "perf script". When true, all metrics
+		whose events were recorded in the data file are displayed rather
+		than only the metrics requested on the "perf stat record"
+		command line.
+
 intel-pt.*::
 
 	intel-pt.cache-divisor::
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 8ea17da89976..7258ec280770 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -426,6 +426,11 @@ information at the boundary of the level 3 cache in the system.
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.
 
+--all-metrics::
+Display all metrics that match the recorded events in the perf data file,
+rather than only the metrics requested on the 'perf stat record' command line.
+Default setting can be changed with "perf config stat.all-metrics=true".
+
 -M::
 --metrics::
 Print metrics or metricgroups specified in a comma separated list.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f81192cec481..12004244af0e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2232,6 +2232,28 @@ static int process_stat_round_event(const struct perf_tool *tool __maybe_unused,
 	struct perf_env *env = perf_session__env(session);
 	const char **argv = env->cmdline_argv;
 	int argc = env->nr_cmdline;
+	static bool metrics_added;
+
+	if (!metrics_added) {
+		struct perf_thread_map *threads = evlist__core(session->evlist)->threads;
+		bool system_wide = !threads || perf_thread_map__pid(threads, /*idx=*/0) == -1;
+
+		/* Metrics may use system_wide, such as for #target_cpu. */
+		stat_config.system_wide = system_wide;
+		metricgroup__add_recorded_metrics(session->evlist, metrics,
+						  parse_events_option_args.pmu_filter,
+						  parse_events_option_args.cputype_filter,
+						  stat_config.metric_no_group,
+						  stat_config.metric_no_merge,
+						  stat_config.metric_no_threshold,
+						  stat_config.all_metrics,
+						  system_wide,
+						  /*default_metricgroup=*/true,
+						  force_metric_only ? NULL
+								    : &stat_config.metric_only);
+		zfree(&metrics);
+		metrics_added = true;
+	}
 
 	process_counters();
 
@@ -2282,6 +2304,8 @@ int process_stat_config_event(const struct perf_tool *tool,
 
 static int set_maps(struct perf_stat *st)
 {
+	struct evsel *counter;
+
 	if (!st->cpus || !st->threads)
 		return 0;
 
@@ -2293,6 +2317,9 @@ static int set_maps(struct perf_stat *st)
 	if (evlist__alloc_stats(&stat_config, evsel_list, /*alloc_raw=*/true))
 		return -ENOMEM;
 
+	evlist__for_each_entry(evsel_list, counter)
+		counter->supported = false;
+
 	st->maps_allocated = true;
 	return 0;
 }
@@ -2351,7 +2378,7 @@ static int __cmd_report(int argc, const char **argv)
 {
 	struct perf_session *session;
 	struct opt_aggr_mode opt_mode = {};
-	const struct option options[] = {
+	struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_BOOLEAN(0, "per-thread", &opt_mode.thread, "aggregate counts per thread"),
 	OPT_BOOLEAN(0, "per-socket", &opt_mode.socket,
@@ -2367,11 +2394,20 @@ static int __cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "per-node", &opt_mode.node, "aggregate counts per numa node"),
 	OPT_BOOLEAN('A', "no-aggr", &opt_mode.no_aggr,
 		    "disable aggregation across CPUs or PMUs"),
+	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
+		     "display specified metrics or metric groups (separated by ,)",
+		     append_metric_groups),
+	OPT_BOOLEAN(0, "all-metrics", &stat_config.all_metrics,
+		    "display all metrics matching recorded events"),
+	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
+			   "Only print computed metrics. No raw values",
+			   enable_metric_only),
 	OPT_END()
 	};
 	struct stat st;
 	int ret;
 
+	set_option_flag(options, 'M', "metrics", PARSE_OPT_NONEG);
 	argc = parse_options(argc, argv, options, stat_report_usage, 0);
 
 	perf_stat.aggr_mode = opt_aggr_mode_to_aggr_mode(&opt_mode);
@@ -2398,8 +2434,10 @@ static int __cmd_report(int argc, const char **argv)
 	perf_stat.tool.stat_round	= process_stat_round_event;
 
 	session = perf_session__new(&perf_stat.data, &perf_stat.tool);
-	if (IS_ERR(session))
-		return PTR_ERR(session);
+	if (IS_ERR(session)) {
+		ret = PTR_ERR(session);
+		goto out;
+	}
 
 	perf_stat.session  = session;
 	stat_config.output = stderr;
@@ -2408,10 +2446,13 @@ static int __cmd_report(int argc, const char **argv)
 
 	ret = perf_session__process_events(session);
 	if (ret)
-		return ret;
+		goto out;
 
 	perf_session__delete(session);
-	return 0;
+out:
+	/* Freed when processing the first stat round, if there was one. */
+	zfree(&metrics);
+	return ret;
 }
 
 static void setup_system_wide(int forks)
@@ -2589,6 +2630,8 @@ int cmd_stat(int argc, const char **argv)
 		OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 			"monitor specified metrics or metric groups (separated by ,)",
 			append_metric_groups),
+		OPT_BOOLEAN(0, "all-metrics", &stat_config.all_metrics,
+			"display all metrics matching recorded events (report only)"),
 		OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
 				"Configure all used events to run in kernel space.",
 				PARSE_OPT_EXCLUSIVE),
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 287401f159e6..d64d0db51d8e 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -514,6 +514,9 @@ static int perf_stat_config(const char *var, const char *value)
 	if (!strcmp(var, "stat.bpf-counter-events"))
 		evsel__bpf_counter_events = strdup(value);
 
+	if (!strcmp(var, "stat.all-metrics"))
+		stat_config.all_metrics = perf_config_bool(var, value);
+
 	/* Add other config variables here. */
 	return 0;
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index e3598037a6aa..a957479804c1 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -82,6 +82,7 @@ struct perf_stat_config {
 	bool			 metric_no_group;
 	bool			 metric_no_merge;
 	bool			 metric_no_threshold;
+	bool			 all_metrics;
 	bool			 hardware_aware_grouping;
 	bool			 stop_read_counter;
 	bool			 iostat_run;
-- 
2.56.0.385.gac671c819a-goog

