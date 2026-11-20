Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212971;
	b=nEb8rED5vPgSXLg/EQx13F5Iki4y4gPHwOIbvQVWsvHibLjQYaK6PxGTFH3Yq4yzYFhv
	 MpmtTpcDKFbP20gF2o4kSJb5DbbENwhhPUveppGX9JvcvQcKCXUZyHXgWXHnec9dj0hw4
	 i7Ic4K+pUHWfoahQuyK5QUKp5yDnQROW7qI/nbvhzfRKOkmPPKoYw4DTDHqnLGyp4ZhTw
	 2NUQScHZhBL3B2ctCBykY45lA0fmMu6ihXD3XhOajFsvnhw3QemRnJlk9DQC/08H36/3p
	 6cz1cdMnH2nA7Sl+v7D+7lDOq8eqdqKDt/BHU5DYvOq/v2xfI9yu5mPP1rnl6cUGmrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2HEN6VUdgvdF1e1P4lzoTvsLs3mhrZspRNp4JiB/L5I=;
	b=5iakiDk9CK4vOye7ekQRCuexRIDjawn9IqwGcjHu4qKRuMNX3jDSLzKPscj49IPSjXlA
	 cKYSd99WZfXHDJ7K/sE+s9Wxko+/eVkHEW434UUWfygwe3LtmIIEop6ux7pJbI2B1Y6fo
	 Ji2YSWqZ9lhALcnxaPJyIUmovVluv5ClLiR05Cbrsr6MRtrbaFZplRMH3JQy/5NTCN4ts
	 xUpfmTm8n6i621glA6OTZKPh4/mfZgFIoeLkMoUcl8MRoQ/2vIsaKKiYlkOvJdt2T23R5
	 Bs/z3jjEOPQ7i7iSO1doKhe2ZGcvAa8S1iGLYpSl6/J63MsccJ7YxPiU3eJJoJd5lIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VgtTw4XP;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A1606A68E
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA8A1606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VgtTw4XP
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2f0329e57eeso13386915ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212962; x=1795817762; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HEN6VUdgvdF1e1P4lzoTvsLs3mhrZspRNp4JiB/L5I=;
        b=VgtTw4XP3Tea/OPo+j/xL5RWam/c6pQbvxUCKaIsinEksk+QAnx7FvPVCnQ4asjWHS
         DVnJvsjJvBcbimAFeXgKI7N8qJdApmcHf/n7BJiotla/R7ksKwW69/CfOHqTJL6zince
         eVzmoHlFwO5RPPH1EzEexSSHQsFkBOnF2Uwh1CH8c9KbdG4IK66Q7+1hxNj0GaSrZ8D1
         RGbL+jy5+mlBdOfsIkuNKxwkBgGdWu88VzEgPCdXmWDtroEhuFGTeoZnRA4L7vxW0SZS
         a4HJBr7Qa16T58e+zVRrJ6SXCWSqERFxPTOz5dg6loQ6rqy4ZUx7rq/ZezqfSka5oRP+
         KnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212962; x=1795817762;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HEN6VUdgvdF1e1P4lzoTvsLs3mhrZspRNp4JiB/L5I=;
        b=L5qZm/e0hzPtcKr6rx/4jc++e6SphATvzfn/APPs4M4n73vZMhgxug4JjxU+GTyXdN
         FaUFGgADTiw3cuxaiVyiSU7WuxNcrV9Q8cRSQKlWk28q/v4SXcuBNSrBlEK3diYXxYRV
         6biEhF18wUpQcwRMZgicktjY02u78q3WGztV+tgo62stOlbpgieED38RX9WsqSbTT7aq
         AtGD0XE58zmCywzK8D195jaTWNucQydvVLBTJ6nusHUBVoDWvBK5zda84vKREi1jyTCo
         bGbv/xE/nXYhHMeSCp0xjq4alLzA2j9QhxDsJ8NhoPaIp4jcABueiQNTSK5IhJWblLoy
         Cg4g==
X-Gm-Message-State: APuU4Z+QY2YQ77a5mq6aJojAPmFNW2TZPzWMfISoVmddH5kshcIt9sxR
	AwP1VcuarYpwSL0x+rDhwoOfxDj3JLnSIkirKgg12qIP6pGBY0eSoNZxQNUUQNwbUHkMaEBXYHu
	KI4xEASBTiw==
X-Received: from plhc7.prod.google.com ([2002:a17:903:2347:b0:2e4:afb6:7889])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c401:b0:2ef:e9df:2429
 with SMTP id d9443c01a7336-2f03f17d1afmr51904595ad.21.1795212961653; Fri, 20
 Nov 2026 14:16:01 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:29 -0800
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
Message-ID: <20261120221332.2245191-29-irogers@google.com>
Subject: [PATCH v3 28/30] perf stat report: Display metrics for recorded events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
 tools/perf/Documentation/perf-config.txt |  7 +++
 tools/perf/Documentation/perf-stat.txt   |  5 +++
 tools/perf/builtin-stat.c                | 54 +++++++++++++++++++++---
 tools/perf/util/config.c                 |  3 ++
 tools/perf/util/stat.h                   |  1 +
 5 files changed, 65 insertions(+), 5 deletions(-)

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
index 2b563382cf43..64883e7cb6aa 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2246,6 +2246,29 @@ static int process_stat_round_event(const struct perf_tool *tool __maybe_unused,
 	struct perf_env *env = perf_session__env(session);
 	const char **argv = env->cmdline_argv;
 	int argc = env->nr_cmdline;
+	static bool metrics_added;
+
+	if (!metrics_added) {
+		struct perf_thread_map *threads = evlist__core(session->evlist)->threads;
+		bool system_wide = !threads || perf_thread_map__nr(threads) < 1 ||
+				   perf_thread_map__pid(threads, /*idx=*/0) == -1;
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
 
@@ -2296,6 +2319,8 @@ int process_stat_config_event(const struct perf_tool *tool,
 
 static int set_maps(struct perf_stat *st)
 {
+	struct evsel *counter;
+
 	if (!st->cpus || !st->threads)
 		return 0;
 
@@ -2307,6 +2332,9 @@ static int set_maps(struct perf_stat *st)
 	if (evlist__alloc_stats(&stat_config, evsel_list, /*alloc_raw=*/true))
 		return -ENOMEM;
 
+	evlist__for_each_entry(evsel_list, counter)
+		counter->supported = false;
+
 	st->maps_allocated = true;
 	return 0;
 }
@@ -2365,7 +2393,7 @@ static int __cmd_report(int argc, const char **argv)
 {
 	struct perf_session *session;
 	struct opt_aggr_mode opt_mode = {};
-	const struct option options[] = {
+	struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_BOOLEAN(0, "per-thread", &opt_mode.thread, "aggregate counts per thread"),
 	OPT_BOOLEAN(0, "per-socket", &opt_mode.socket,
@@ -2381,11 +2409,20 @@ static int __cmd_report(int argc, const char **argv)
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
@@ -2412,8 +2449,10 @@ static int __cmd_report(int argc, const char **argv)
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
@@ -2422,10 +2461,13 @@ static int __cmd_report(int argc, const char **argv)
 
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
@@ -2603,6 +2645,8 @@ int cmd_stat(int argc, const char **argv)
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
2.56.1.750.gf70dc682cf-goog

