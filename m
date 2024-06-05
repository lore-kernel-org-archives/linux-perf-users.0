Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3844190471
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Jun 2024 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569518; cv=none; b=KlhvdDQlIb+G7Ou9aK7AVtlbPoDfE7v5jk8TueqJd29/q/3JIbv85MA5S4dQwbNE0aB6rg2qjFGL6RPktFh+ap0RLcjJp4bJy868HThMnhke4NGnss6itrry/Gg8OzMkrA3HEiPsdsvYy0RTcDJNw825nYxx/mQnF0Hm1R6yWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569518; c=relaxed/simple;
	bh=C/gqpNsPW6X9AgnD3SWjLERM0lEWOMKoVOsDhhAN66M=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=pmboaBJdcGsqKA86A9stwQH0ovddmhPw4zCq4dRh8xrG6JIydiF19lo8oFR7pZRng3ijQMdd124rXIb+BrjDZHNUOiM0Y33QEJrDt+Ub6nCLLusWhlkxMyYtVl2+GLfCapZkgYyeRo2FYxC1kpdlsgZC6cejjpsHXyojam0bQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uBoAWrJu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBoAWrJu"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627f43bec13so108862237b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jun 2024 23:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717569514; x=1718174314; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+PpR1gGIbojHkt37dr2HX8fPNt5afUg8N/f8kUSgZ4=;
        b=uBoAWrJun4MWHQ+xmWFVacuCOeGsAoop3sd+wArrOyOuJaEOmDv81wp2xYKn9GHekn
         Rcoc+N1ovAZoBrUCSjqbr5jmcAsabaSvZirw94LTzgC/Ja26mybIE8+eBw8ko9a15uci
         OBLIlQ80/8/bJIQ4CbLx7ezRNYqndVBdJx17cxEEpQO7gST8e+HxucJAai2mNr7mcYFC
         NbrHWRLTOUdHPBiRw8EVZFyb5MSlaWX0plQ0GP+6B7vMGiohTN7lJIGQxYBK3qu8Jums
         igBfOaI9kczlvDM5KvPFybrzzfrymm4vmASWyUku7xKpyPkYzPN8o9nIcABdwUB/keT4
         r2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717569514; x=1718174314;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+PpR1gGIbojHkt37dr2HX8fPNt5afUg8N/f8kUSgZ4=;
        b=cCt3S9Wg4ez9cQvEuHWSC37BXyRWpRHBCDeYdZRDKC8wW9OwO4vD0AcNk0pUSfYb7M
         4pRVwMFS7tK95GreL0eJru5ft9rFBNFqwl6ClmBLdvJ/q3i4VtIze+V05JRnKPJosT8G
         jLJFMhRxROs3cujKW6U2h+KA07nYGK96uOZcKepqQwJcFDqv5WZAxPhC3o77u86ge9TE
         yGxg8W698BR3R1ROu87fn9nO8CslLrKLsq49OEeaswPGj4Db/4Rwb7LSqzALEoL2x/h0
         q9CddbLG4hVsqRwlFMFV2GhR8xfoaEvkruQsHMUcNXMadhCsKVF0qVrwAcEKyYqwhWZe
         UMOA==
X-Forwarded-Encrypted: i=1; AJvYcCUdOjStrjaAXfpUNNXHNheomN9VL+Ww5yDdtgo2Yp9uY/nB8G04gl3WpzjEBuXdrhm8LEdNL4m34hTg/Ho+fBTjfSKOLqqfztzxDNb74Kug7g==
X-Gm-Message-State: AOJu0YxX4M4/A9U+VRxjpL0AmHXh6DSPzGKM0jJFHQs86FO4cXLCFqjQ
	P7eNEThjXJzGRVdLfoAE2fJ6s7LhSWC0D+2EsXbd0DEU44PHgfgF3vwzQat3xVJtp8/CTFd00NA
	3J3O5zQ==
X-Google-Smtp-Source: AGHT+IET95r1UUZLR/FCgKAwLafvauszpYRfROWKh9xsLEESFUplMNArj2C7155zVTfI8yKt1OfgIRUnDxs/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:42c2:ffc7:ca9b:501f])
 (user=irogers job=sendgmr) by 2002:a05:690c:dc1:b0:627:cc70:be02 with SMTP id
 00721157ae682-62cbb4c30b8mr4425467b3.4.1717569513812; Tue, 04 Jun 2024
 23:38:33 -0700 (PDT)
Date: Tue,  4 Jun 2024 23:38:27 -0700
Message-Id: <20240605063828.195700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [RFC PATCH v1 1/2] perf stat: Make options local
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Reduce the scope of stat_options to cmd_stat, and pass as an argument
to __cmd_record. This is done to make more localized changes to the
options in later patches. A side-effect of the change is to reduce the
size of a stripped PIE perf binary by 5952 bytes. The savings come
mainly in the dynamic relocation section.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 291 +++++++++++++++++++-------------------
 1 file changed, 145 insertions(+), 146 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 35f79b48e8dc..6227b25d1446 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1140,150 +1140,6 @@ static int parse_cache_level(const struct option *opt,
 	return 0;
 }
 
-static struct option stat_options[] = {
-	OPT_BOOLEAN('T', "transaction", &transaction_run,
-		    "hardware transaction statistics"),
-	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
-		     "event selector. use 'perf list' to list available events",
-		     parse_events_option),
-	OPT_CALLBACK(0, "filter", &evsel_list, "filter",
-		     "event filter", parse_filter),
-	OPT_BOOLEAN('i', "no-inherit", &stat_config.no_inherit,
-		    "child tasks do not inherit counters"),
-	OPT_STRING('p', "pid", &target.pid, "pid",
-		   "stat events on existing process id"),
-	OPT_STRING('t', "tid", &target.tid, "tid",
-		   "stat events on existing thread id"),
-#ifdef HAVE_BPF_SKEL
-	OPT_STRING('b', "bpf-prog", &target.bpf_str, "bpf-prog-id",
-		   "stat events on existing bpf program id"),
-	OPT_BOOLEAN(0, "bpf-counters", &target.use_bpf,
-		    "use bpf program to count events"),
-	OPT_STRING(0, "bpf-attr-map", &target.attr_map, "attr-map-path",
-		   "path to perf_event_attr map"),
-#endif
-	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
-		    "system-wide collection from all CPUs"),
-	OPT_BOOLEAN(0, "scale", &stat_config.scale,
-		    "Use --no-scale to disable counter scaling for multiplexing"),
-	OPT_INCR('v', "verbose", &verbose,
-		    "be more verbose (show counter open errors, etc)"),
-	OPT_INTEGER('r', "repeat", &stat_config.run_count,
-		    "repeat command and print average + stddev (max: 100, forever: 0)"),
-	OPT_BOOLEAN(0, "table", &stat_config.walltime_run_table,
-		    "display details about each run (only with -r option)"),
-	OPT_BOOLEAN('n', "null", &stat_config.null_run,
-		    "null run - dont start any counters"),
-	OPT_INCR('d', "detailed", &detailed_run,
-		    "detailed run - start a lot of events"),
-	OPT_BOOLEAN('S', "sync", &sync_run,
-		    "call sync() before starting a run"),
-	OPT_CALLBACK_NOOPT('B', "big-num", NULL, NULL,
-			   "print large numbers with thousands\' separators",
-			   stat__set_big_num),
-	OPT_STRING('C', "cpu", &target.cpu_list, "cpu",
-		    "list of cpus to monitor in system-wide"),
-	OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
-		    "disable aggregation across CPUs or PMUs", AGGR_NONE),
-	OPT_SET_UINT(0, "no-merge", &stat_config.aggr_mode,
-		    "disable aggregation the same as -A or -no-aggr", AGGR_NONE),
-	OPT_BOOLEAN(0, "hybrid-merge", &stat_config.hybrid_merge,
-		    "Merge identical named hybrid events"),
-	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
-		   "print counts with custom separator"),
-	OPT_BOOLEAN('j', "json-output", &stat_config.json_output,
-		   "print counts in JSON format"),
-	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
-		     "monitor event in cgroup name only", parse_stat_cgroups),
-	OPT_STRING(0, "for-each-cgroup", &stat_config.cgroup_list, "name",
-		    "expand events for each cgroup"),
-	OPT_STRING('o', "output", &output_name, "file", "output file name"),
-	OPT_BOOLEAN(0, "append", &append_file, "append to the output file"),
-	OPT_INTEGER(0, "log-fd", &output_fd,
-		    "log output to fd, instead of stderr"),
-	OPT_STRING(0, "pre", &pre_cmd, "command",
-			"command to run prior to the measured command"),
-	OPT_STRING(0, "post", &post_cmd, "command",
-			"command to run after to the measured command"),
-	OPT_UINTEGER('I', "interval-print", &stat_config.interval,
-		    "print counts at regular interval in ms "
-		    "(overhead is possible for values <= 100ms)"),
-	OPT_INTEGER(0, "interval-count", &stat_config.times,
-		    "print counts for fixed number of times"),
-	OPT_BOOLEAN(0, "interval-clear", &stat_config.interval_clear,
-		    "clear screen in between new interval"),
-	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
-		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
-	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
-		     "aggregate counts per processor socket", AGGR_SOCKET),
-	OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
-		     "aggregate counts per processor die", AGGR_DIE),
-	OPT_SET_UINT(0, "per-cluster", &stat_config.aggr_mode,
-		     "aggregate counts per processor cluster", AGGR_CLUSTER),
-	OPT_CALLBACK_OPTARG(0, "per-cache", &stat_config.aggr_mode, &stat_config.aggr_level,
-			    "cache level", "aggregate count at this cache level (Default: LLC)",
-			    parse_cache_level),
-	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
-		     "aggregate counts per physical processor core", AGGR_CORE),
-	OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
-		     "aggregate counts per thread", AGGR_THREAD),
-	OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
-		     "aggregate counts per numa node", AGGR_NODE),
-	OPT_INTEGER('D', "delay", &target.initial_delay,
-		    "ms to wait before starting measurement after program start (-1: start with events disabled)"),
-	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
-			"Only print computed metrics. No raw values", enable_metric_only),
-	OPT_BOOLEAN(0, "metric-no-group", &stat_config.metric_no_group,
-		       "don't group metric events, impacts multiplexing"),
-	OPT_BOOLEAN(0, "metric-no-merge", &stat_config.metric_no_merge,
-		       "don't try to share events between metrics in a group"),
-	OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
-		       "disable adding events for the metric threshold calculation"),
-	OPT_BOOLEAN(0, "topdown", &topdown_run,
-			"measure top-down statistics"),
-	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
-			"Set the metrics level for the top-down statistics (0: max level)"),
-	OPT_BOOLEAN(0, "smi-cost", &smi_cost,
-			"measure SMI cost"),
-	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
-		     "monitor specified metrics or metric groups (separated by ,)",
-		     append_metric_groups),
-	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
-			 "Configure all used events to run in kernel space.",
-			 PARSE_OPT_EXCLUSIVE),
-	OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
-			 "Configure all used events to run in user space.",
-			 PARSE_OPT_EXCLUSIVE),
-	OPT_BOOLEAN(0, "percore-show-thread", &stat_config.percore_show_thread,
-		    "Use with 'percore' event qualifier to show the event "
-		    "counts of one hardware thread by sum up total hardware "
-		    "threads of same physical core"),
-	OPT_BOOLEAN(0, "summary", &stat_config.summary,
-		       "print summary for interval mode"),
-	OPT_BOOLEAN(0, "no-csv-summary", &stat_config.no_csv_summary,
-		       "don't print 'summary' for CSV summary output"),
-	OPT_BOOLEAN(0, "quiet", &quiet,
-			"don't print any output, messages or warnings (useful with record)"),
-	OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
-		     "Only enable events on applying cpu with this type "
-		     "for hybrid platform (e.g. core or atom)",
-		     parse_cputype),
-#ifdef HAVE_LIBPFM
-	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
-		"libpfm4 event selector. use 'perf list' to list available events",
-		parse_libpfm_events_option),
-#endif
-	OPT_CALLBACK(0, "control", &stat_config, "fd:ctl-fd[,ack-fd] or fifo:ctl-fifo[,ack-fifo]",
-		     "Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).\n"
-		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
-		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
-		      parse_control_option),
-	OPT_CALLBACK_OPTARG(0, "iostat", &evsel_list, &stat_config, "default",
-			    "measure I/O performance metrics provided by arch/platform",
-			    iostat_parse),
-	OPT_END()
-};
-
 /**
  * Calculate the cache instance ID from the map in
  * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
@@ -2245,7 +2101,7 @@ static void init_features(struct perf_session *session)
 	perf_header__clear_feat(&session->header, HEADER_AUXTRACE);
 }
 
-static int __cmd_record(int argc, const char **argv)
+static int __cmd_record(const struct option stat_options[], int argc, const char **argv)
 {
 	struct perf_session *session;
 	struct perf_data *data = &perf_stat.data;
@@ -2494,6 +2350,149 @@ static void setup_system_wide(int forks)
 
 int cmd_stat(int argc, const char **argv)
 {
+	struct option stat_options[] = {
+		OPT_BOOLEAN('T', "transaction", &transaction_run,
+			"hardware transaction statistics"),
+		OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
+			"event selector. use 'perf list' to list available events",
+			parse_events_option),
+		OPT_CALLBACK(0, "filter", &evsel_list, "filter",
+			"event filter", parse_filter),
+		OPT_BOOLEAN('i', "no-inherit", &stat_config.no_inherit,
+			"child tasks do not inherit counters"),
+		OPT_STRING('p', "pid", &target.pid, "pid",
+			"stat events on existing process id"),
+		OPT_STRING('t', "tid", &target.tid, "tid",
+			"stat events on existing thread id"),
+#ifdef HAVE_BPF_SKEL
+		OPT_STRING('b', "bpf-prog", &target.bpf_str, "bpf-prog-id",
+			"stat events on existing bpf program id"),
+		OPT_BOOLEAN(0, "bpf-counters", &target.use_bpf,
+			"use bpf program to count events"),
+		OPT_STRING(0, "bpf-attr-map", &target.attr_map, "attr-map-path",
+			"path to perf_event_attr map"),
+#endif
+		OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
+			"system-wide collection from all CPUs"),
+		OPT_BOOLEAN(0, "scale", &stat_config.scale,
+			"Use --no-scale to disable counter scaling for multiplexing"),
+		OPT_INCR('v', "verbose", &verbose,
+			"be more verbose (show counter open errors, etc)"),
+		OPT_INTEGER('r', "repeat", &stat_config.run_count,
+			"repeat command and print average + stddev (max: 100, forever: 0)"),
+		OPT_BOOLEAN(0, "table", &stat_config.walltime_run_table,
+			"display details about each run (only with -r option)"),
+		OPT_BOOLEAN('n', "null", &stat_config.null_run,
+			"null run - dont start any counters"),
+		OPT_INCR('d', "detailed", &detailed_run,
+			"detailed run - start a lot of events"),
+		OPT_BOOLEAN('S', "sync", &sync_run,
+			"call sync() before starting a run"),
+		OPT_CALLBACK_NOOPT('B', "big-num", NULL, NULL,
+				"print large numbers with thousands\' separators",
+				stat__set_big_num),
+		OPT_STRING('C', "cpu", &target.cpu_list, "cpu",
+			"list of cpus to monitor in system-wide"),
+		OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
+			"disable aggregation across CPUs or PMUs", AGGR_NONE),
+		OPT_SET_UINT(0, "no-merge", &stat_config.aggr_mode,
+			"disable aggregation the same as -A or -no-aggr", AGGR_NONE),
+		OPT_BOOLEAN(0, "hybrid-merge", &stat_config.hybrid_merge,
+			"Merge identical named hybrid events"),
+		OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
+			"print counts with custom separator"),
+		OPT_BOOLEAN('j', "json-output", &stat_config.json_output,
+			"print counts in JSON format"),
+		OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
+			"monitor event in cgroup name only", parse_stat_cgroups),
+		OPT_STRING(0, "for-each-cgroup", &stat_config.cgroup_list, "name",
+			"expand events for each cgroup"),
+		OPT_STRING('o', "output", &output_name, "file", "output file name"),
+		OPT_BOOLEAN(0, "append", &append_file, "append to the output file"),
+		OPT_INTEGER(0, "log-fd", &output_fd,
+			"log output to fd, instead of stderr"),
+		OPT_STRING(0, "pre", &pre_cmd, "command",
+			"command to run prior to the measured command"),
+		OPT_STRING(0, "post", &post_cmd, "command",
+			"command to run after to the measured command"),
+		OPT_UINTEGER('I', "interval-print", &stat_config.interval,
+			"print counts at regular interval in ms "
+			"(overhead is possible for values <= 100ms)"),
+		OPT_INTEGER(0, "interval-count", &stat_config.times,
+			"print counts for fixed number of times"),
+		OPT_BOOLEAN(0, "interval-clear", &stat_config.interval_clear,
+			"clear screen in between new interval"),
+		OPT_UINTEGER(0, "timeout", &stat_config.timeout,
+			"stop workload and print counts after a timeout period in ms (>= 10ms)"),
+		OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
+			"aggregate counts per processor socket", AGGR_SOCKET),
+		OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
+			"aggregate counts per processor die", AGGR_DIE),
+		OPT_SET_UINT(0, "per-cluster", &stat_config.aggr_mode,
+			"aggregate counts per processor cluster", AGGR_CLUSTER),
+		OPT_CALLBACK_OPTARG(0, "per-cache", &stat_config.aggr_mode, &stat_config.aggr_level,
+				"cache level", "aggregate count at this cache level (Default: LLC)",
+				parse_cache_level),
+		OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
+			"aggregate counts per physical processor core", AGGR_CORE),
+		OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
+			"aggregate counts per thread", AGGR_THREAD),
+		OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
+			"aggregate counts per numa node", AGGR_NODE),
+		OPT_INTEGER('D', "delay", &target.initial_delay,
+			"ms to wait before starting measurement after program start (-1: start with events disabled)"),
+		OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
+				"Only print computed metrics. No raw values", enable_metric_only),
+		OPT_BOOLEAN(0, "metric-no-group", &stat_config.metric_no_group,
+			"don't group metric events, impacts multiplexing"),
+		OPT_BOOLEAN(0, "metric-no-merge", &stat_config.metric_no_merge,
+			"don't try to share events between metrics in a group"),
+		OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
+			"disable adding events for the metric threshold calculation"),
+		OPT_BOOLEAN(0, "topdown", &topdown_run,
+			"measure top-down statistics"),
+		OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
+			"Set the metrics level for the top-down statistics (0: max level)"),
+		OPT_BOOLEAN(0, "smi-cost", &smi_cost,
+			"measure SMI cost"),
+		OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
+			"monitor specified metrics or metric groups (separated by ,)",
+			append_metric_groups),
+		OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
+				"Configure all used events to run in kernel space.",
+				PARSE_OPT_EXCLUSIVE),
+		OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
+				"Configure all used events to run in user space.",
+				PARSE_OPT_EXCLUSIVE),
+		OPT_BOOLEAN(0, "percore-show-thread", &stat_config.percore_show_thread,
+			"Use with 'percore' event qualifier to show the event "
+			"counts of one hardware thread by sum up total hardware "
+			"threads of same physical core"),
+		OPT_BOOLEAN(0, "summary", &stat_config.summary,
+			"print summary for interval mode"),
+		OPT_BOOLEAN(0, "no-csv-summary", &stat_config.no_csv_summary,
+			"don't print 'summary' for CSV summary output"),
+		OPT_BOOLEAN(0, "quiet", &quiet,
+			"don't print any output, messages or warnings (useful with record)"),
+		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
+			"Only enable events on applying cpu with this type "
+			"for hybrid platform (e.g. core or atom)",
+			parse_cputype),
+#ifdef HAVE_LIBPFM
+		OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
+			"libpfm4 event selector. use 'perf list' to list available events",
+			parse_libpfm_events_option),
+#endif
+		OPT_CALLBACK(0, "control", &stat_config, "fd:ctl-fd[,ack-fd] or fifo:ctl-fifo[,ack-fifo]",
+			"Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).\n"
+			"\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
+			"\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
+			parse_control_option),
+		OPT_CALLBACK_OPTARG(0, "iostat", &evsel_list, &stat_config, "default",
+				"measure I/O performance metrics provided by arch/platform",
+				iostat_parse),
+		OPT_END()
+	};
 	const char * const stat_usage[] = {
 		"perf stat [<options>] [<command>]",
 		NULL
@@ -2530,7 +2529,7 @@ int cmd_stat(int argc, const char **argv)
 		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
 	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
-		argc = __cmd_record(argc, argv);
+		argc = __cmd_record(stat_options, argc, argv);
 		if (argc < 0)
 			return -1;
 	} else if (argc && strlen(argv[0]) > 2 && strstarts("report", argv[0]))
-- 
2.45.1.288.g0e0cd299f1-goog

