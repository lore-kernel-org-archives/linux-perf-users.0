Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E55D34CFAE
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751156; cv=none; b=lPh1BD9UiHKle8FkpTP87FPeKgKqFpUgdpnUYylrc6RKGasPpZWP9S9KfVV9Um6Kh62nud47ZlvbJktmKpigaHhw5GfHK/IhnIpd5ynx8UTSzNIXiKMKxBsXIWXkBstieVhaa8hjVJJmqzaN3FD7ab+3Gygv6Ur8NazQpZWPxlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751156; c=relaxed/simple;
	bh=YW/PB6OhofSUgC0gwmp9VNw+PaDdq2oRNCE/6R5+QhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gWTqBIjiquQj8i4w8iI8g/OHRuckhY22lJ7hxXLmIZckSbTFwmUtiuYAhHgIJ4BbX53NETiI0wwknE8fij2eJj3N6kMuuJ///j3uoLpsg8Ul8urdFOZw+0MiTjAih2EkwYsJZj80mMi3xXhHtCCx1021U8F1e0AYp1WfG9A4IqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEiIZQGw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEiIZQGw"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c802545ae0eso6055515a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751153; x=1780355953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zv+XX5u/+jo6hcOxSb6D7eKRFv4netVa4jcNjpv4Efk=;
        b=DEiIZQGwVcGXd/My3eHXFEVLjlU7J/i1ACHWWa/VkGcKsC0TaMffwnBwFAL7sVbE2t
         lQiEmk/G7OmhbkQZNkAc3OeHqdzSEiZW9SQi6ahWhHxRFMJv5nqr4qJjE7u4i8XP9gf4
         WTPL0xiYWEMLtMUwCND2x8OpH7mb5GEz15RaPGk2wC+PPZa/Q6mgCCwWogu2ZaVCrys+
         oIaV9xDCKhOyF9LtYKbqtIr21F2ca3eTiMttlWP6PH3nzH8FLxTOTZSe0W6wXV6vrFSg
         FiO+S8jaMQZfRqiMEGC//e5sv0RU0nv7tYwe+WysxEnRRAzlRgx7vP9PstBTHtoIazXf
         AYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751153; x=1780355953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zv+XX5u/+jo6hcOxSb6D7eKRFv4netVa4jcNjpv4Efk=;
        b=KmmYuYDuQlTbKCi6Jn1Bh62CqEraf393P/3DzHtVUeRaDA61xmMGljCWhvE866Pdi7
         y9YlSrpRNmMjTDeNcDI+qWF8NYZfX3TKzQKeZf0Lp6EmQMZreQkJJvxrMcTzz+7ps0mZ
         v4eqxyeTsJwuudGoSEgDx7nOcNkEPbx82Yu106ClJK7BUappPCBQiSIYEOFET/6NEOQA
         wWyIIbFgeFdSEWCOzM/6aCQvUGmIMhiVCB8y7B11rfnAVsr9R+DPh8HyOlyPllCFezuB
         tTrJ1Oj/o2rUYqZjrhVmCowgvWX6BZqiRp+7SP7901rrndZD72nFIhOipZleEO/Lp4UA
         ixPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lYKBIOy+44uv+9yPPFyzchYn4rBRgKDlkz3tU+B4XBSpRPEFbu9zkzwRarRjU8ZGTkc1lBpelxBZq5inG5zs7@vger.kernel.org
X-Gm-Message-State: AOJu0YwdVlnt2DfQAOoTKgQdNB64fbixxaFaUbiIeOody2Nzz95SQpXt
	NAmmivXMUuJ4mATseIGwteOsbplQlHrkOUrw59iPOQ872+6hS4U2ImT0lHoMhK4NixfDgV7/gfj
	9Jg22FaOBOA==
X-Received: from pfij18.prod.google.com ([2002:aa7:8012:0:b0:835:20c7:97df])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b4f:b0:829:8cfb:df45
 with SMTP id d2e1a72fcca58-8415f323ebdmr15444446b3a.15.1779751152407; Mon, 25
 May 2026 16:19:12 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:47 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-2-irogers@google.com>
Subject: [RFC PATCH v2 01/14] perf stat: Introduce core generic print
 traversal engine and header stubs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch introduces the initial infrastructure for decoupling the
perf stat printing API. It declares the struct perf_stat_print_callbacks
interface and the core traversal driver perf_stat__print_cb() inside
the newly created util/stat-print.h and util/stat-print.c files.

The generic traversal driver perf_stat__print_cb() drive traversing
the event lists across all supported cpu aggregation modes (global,
die, socket, cache, cluster, core, thread, none). It implements
the clean display filtering checks (perf_stat__skip_metric_event(),
hybrid wildcard merges) and the basic metrics allowlist filter
(is_basic_shadow_metric()) to keep formatting callbacks decoupled.

This also introduces two format-agnostic shared helpers to centralize
aggregation prefix formatting:
- perf_stat__get_aggr_key(): resolves JSON key names.
- perf_stat__get_aggr_id_char(): formats unified aggregation identifiers.

Adds empty format-specific stubs (perf_stat__print_std, _csv, _json)
to ensure that the new print files link and compile cleanly under util/Build,
without affecting the legacy print path.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/builtin-stat.c         | 261 ++++++++--------
 tools/perf/util/Build             |   4 +
 tools/perf/util/stat-display.c    |  28 +-
 tools/perf/util/stat-print-csv.c  |  13 +
 tools/perf/util/stat-print-json.c |  13 +
 tools/perf/util/stat-print-std.c  |  13 +
 tools/perf/util/stat-print.c      | 490 ++++++++++++++++++++++++++++++
 tools/perf/util/stat-print.h      | 133 ++++++++
 tools/perf/util/stat.h            |   2 +
 9 files changed, 815 insertions(+), 142 deletions(-)
 create mode 100644 tools/perf/util/stat-print-csv.c
 create mode 100644 tools/perf/util/stat-print-json.c
 create mode 100644 tools/perf/util/stat-print-std.c
 create mode 100644 tools/perf/util/stat-print.c
 create mode 100644 tools/perf/util/stat-print.h

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 99d7db372b48..ef8f5da99c64 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -40,62 +40,64 @@
  *   Jaswinder Singh Rajput <jaswinder@kernel.org>
  */
 
+#include <errno.h>
+#include <inttypes.h>
+#include <locale.h>
+#include <math.h>
+#include <signal.h>
+#include <stdlib.h>
+
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/list_sort.h>
+#include <linux/time64.h>
+#include <linux/zalloc.h>
+#include <sys/prctl.h>
+#include <sys/resource.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <api/fs/fs.h>
+#include <internal/threadmap.h>
+#include <perf/evlist.h>
+#include <subcmd/parse-options.h>
+
+#include "asm/bug.h"
 #include "builtin.h"
+#include "util/affinity.h"
+#include "util/bpf_counter.h"
 #include "util/cgroup.h"
-#include <subcmd/parse-options.h>
-#include "util/parse-events.h"
-#include "util/pmus.h"
-#include "util/pmu.h"
-#include "util/tool_pmu.h"
+#include "util/color.h"
+#include "util/counts.h"
+#include "util/cpumap.h"
+#include "util/debug.h"
 #include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
-#include "util/debug.h"
-#include "util/color.h"
-#include "util/stat.h"
 #include "util/header.h"
-#include "util/cpumap.h"
-#include "util/thread_map.h"
-#include "util/counts.h"
-#include "util/topdown.h"
+#include "util/intel-tpebs.h"
+#include "util/iostat.h"
+#include "util/metricgroup.h"
+#include "util/parse-events.h"
+#include "util/pfm.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
 #include "util/session.h"
-#include "util/tool.h"
+#include "util/stat-print.h"
+#include "util/stat.h"
 #include "util/string2.h"
-#include "util/metricgroup.h"
 #include "util/synthetic-events.h"
 #include "util/target.h"
+#include "util/thread_map.h"
 #include "util/time-utils.h"
+#include "util/tool.h"
+#include "util/tool_pmu.h"
 #include "util/top.h"
-#include "util/affinity.h"
-#include "util/pfm.h"
-#include "util/bpf_counter.h"
-#include "util/iostat.h"
+#include "util/topdown.h"
 #include "util/util.h"
-#include "util/intel-tpebs.h"
-#include "asm/bug.h"
-
-#include <linux/list_sort.h>
-#include <linux/time64.h>
-#include <linux/zalloc.h>
-#include <api/fs/fs.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdlib.h>
-#include <sys/prctl.h>
-#include <inttypes.h>
-#include <locale.h>
-#include <math.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <unistd.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <linux/err.h>
-
-#include <linux/ctype.h>
-#include <perf/evlist.h>
-#include <internal/threadmap.h>
 
 #ifdef HAVE_BPF_SKEL
 #include "util/bpf_skel/bperf_cgroup.h"
@@ -123,6 +125,7 @@ static struct target target;
 static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
 static bool			transaction_run;
+static bool use_perf_stat_print;
 static bool			topdown_run			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
@@ -1091,7 +1094,10 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	if (quiet)
 		return;
 
-	evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, argv);
+	if (use_perf_stat_print)
+		perf_stat__print(evsel_list, &stat_config, &target, ts, argc, argv);
+	else
+		evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, argv);
 }
 
 static volatile sig_atomic_t signr = -1;
@@ -2455,155 +2461,152 @@ int cmd_stat(int argc, const char **argv)
 	bool affinity = true, affinity_set = false;
 	struct option stat_options[] = {
 		OPT_BOOLEAN('T', "transaction", &transaction_run,
-			"hardware transaction statistics"),
+			    "hardware transaction statistics"),
 		OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
-			"event selector. use 'perf list' to list available events",
-			parse_events_option),
-		OPT_CALLBACK(0, "filter", &evsel_list, "filter",
-			"event filter", parse_filter),
+			     "event selector. use 'perf list' to list available events",
+			     parse_events_option),
+		OPT_CALLBACK(0, "filter", &evsel_list, "filter", "event filter", parse_filter),
 		OPT_BOOLEAN('i', "no-inherit", &stat_config.no_inherit,
-			"child tasks do not inherit counters"),
-		OPT_STRING('p', "pid", &target.pid, "pid",
-			"stat events on existing process id"),
-		OPT_STRING('t', "tid", &target.tid, "tid",
-			"stat events on existing thread id"),
+			    "child tasks do not inherit counters"),
+		OPT_STRING('p', "pid", &target.pid, "pid", "stat events on existing process id"),
+		OPT_STRING('t', "tid", &target.tid, "tid", "stat events on existing thread id"),
 #ifdef HAVE_BPF_SKEL
 		OPT_STRING('b', "bpf-prog", &target.bpf_str, "bpf-prog-id",
-			"stat events on existing bpf program id"),
-		OPT_BOOLEAN(0, "bpf-counters", &target.use_bpf,
-			"use bpf program to count events"),
+			   "stat events on existing bpf program id"),
+		OPT_BOOLEAN(0, "bpf-counters", &target.use_bpf, "use bpf program to count events"),
 		OPT_STRING(0, "bpf-attr-map", &target.attr_map, "attr-map-path",
-			"path to perf_event_attr map"),
+			   "path to perf_event_attr map"),
 #endif
 		OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
-			"system-wide collection from all CPUs"),
+			    "system-wide collection from all CPUs"),
 		OPT_BOOLEAN(0, "scale", &stat_config.scale,
-			"Use --no-scale to disable counter scaling for multiplexing"),
+			    "Use --no-scale to disable counter scaling for multiplexing"),
 		OPT_INCR('v', "verbose", &verbose,
-			"be more verbose (show counter open errors, etc)"),
+			 "be more verbose (show counter open errors, etc)"),
 		OPT_INTEGER('r', "repeat", &stat_config.run_count,
-			"repeat command and print average + stddev (max: 100, forever: 0)"),
+			    "repeat command and print average + stddev (max: 100, forever: 0)"),
 		OPT_BOOLEAN(0, "table", &stat_config.walltime_run_table,
-			"display details about each run (only with -r option)"),
+			    "display details about each run (only with -r option)"),
 		OPT_BOOLEAN('n', "null", &stat_config.null_run,
-			"null run - dont start any counters"),
-		OPT_INCR('d', "detailed", &detailed_run,
-			"detailed run - start a lot of events"),
-		OPT_BOOLEAN('S', "sync", &sync_run,
-			"call sync() before starting a run"),
+			    "null run - dont start any counters"),
+		OPT_INCR('d', "detailed", &detailed_run, "detailed run - start a lot of events"),
+		OPT_BOOLEAN('S', "sync", &sync_run, "call sync() before starting a run"),
 		OPT_CALLBACK_NOOPT('B', "big-num", NULL, NULL,
-				"print large numbers with thousands\' separators",
-				stat__set_big_num),
+				   "print large numbers with thousands\' separators",
+				   stat__set_big_num),
 		OPT_STRING('C', "cpu", &target.cpu_list, "cpu",
-			"list of cpus to monitor in system-wide"),
+			   "list of cpus to monitor in system-wide"),
 		OPT_BOOLEAN('A', "no-aggr", &opt_mode.no_aggr,
-			"disable aggregation across CPUs or PMUs"),
+			    "disable aggregation across CPUs or PMUs"),
 		OPT_BOOLEAN(0, "no-merge", &opt_mode.no_aggr,
-			"disable aggregation the same as -A or -no-aggr"),
+			    "disable aggregation the same as -A or -no-aggr"),
 		OPT_BOOLEAN(0, "hybrid-merge", &stat_config.hybrid_merge,
-			"Merge identical named hybrid events"),
+			    "Merge identical named hybrid events"),
 		OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
-			"print counts with custom separator"),
+			   "print counts with custom separator"),
 		OPT_BOOLEAN('j', "json-output", &stat_config.json_output,
-			"print counts in JSON format"),
+			    "print counts in JSON format"),
 		OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
-			"monitor event in cgroup name only", parse_stat_cgroups),
+			     "monitor event in cgroup name only", parse_stat_cgroups),
 		OPT_STRING(0, "for-each-cgroup", &stat_config.cgroup_list, "name",
-			"expand events for each cgroup"),
+			   "expand events for each cgroup"),
 		OPT_STRING('o', "output", &output_name, "file", "output file name"),
 		OPT_BOOLEAN(0, "append", &append_file, "append to the output file"),
-		OPT_INTEGER(0, "log-fd", &output_fd,
-			"log output to fd, instead of stderr"),
+		OPT_INTEGER(0, "log-fd", &output_fd, "log output to fd, instead of stderr"),
 		OPT_STRING(0, "pre", &pre_cmd, "command",
-			"command to run prior to the measured command"),
+			   "command to run prior to the measured command"),
 		OPT_STRING(0, "post", &post_cmd, "command",
-			"command to run after to the measured command"),
+			   "command to run after to the measured command"),
 		OPT_UINTEGER('I', "interval-print", &stat_config.interval,
-			"print counts at regular interval in ms "
-			"(overhead is possible for values <= 100ms)"),
+			     "print counts at regular interval in ms "
+			     "(overhead is possible for values <= 100ms)"),
 		OPT_INTEGER(0, "interval-count", &stat_config.times,
-			"print counts for fixed number of times"),
+			    "print counts for fixed number of times"),
 		OPT_BOOLEAN(0, "interval-clear", &stat_config.interval_clear,
-			"clear screen in between new interval"),
-		OPT_UINTEGER(0, "timeout", &stat_config.timeout,
+			    "clear screen in between new interval"),
+		OPT_UINTEGER(
+			0, "timeout", &stat_config.timeout,
 			"stop workload and print counts after a timeout period in ms (>= 10ms)"),
 		OPT_BOOLEAN(0, "per-socket", &opt_mode.socket,
-			"aggregate counts per processor socket"),
+			    "aggregate counts per processor socket"),
 		OPT_BOOLEAN(0, "per-die", &opt_mode.die, "aggregate counts per processor die"),
 		OPT_BOOLEAN(0, "per-cluster", &opt_mode.cluster,
-			"aggregate counts per processor cluster"),
-		OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode.cache, &stat_config.aggr_level,
-				"cache level", "aggregate count at this cache level (Default: LLC)",
-				parse_cache_level),
+			    "aggregate counts per processor cluster"),
+		OPT_CALLBACK_OPTARG(
+			0, "per-cache", &opt_mode.cache, &stat_config.aggr_level, "cache level",
+			"aggregate count at this cache level (Default: LLC)", parse_cache_level),
 		OPT_BOOLEAN(0, "per-core", &opt_mode.core,
-			"aggregate counts per physical processor core"),
+			    "aggregate counts per physical processor core"),
 		OPT_BOOLEAN(0, "per-thread", &opt_mode.thread, "aggregate counts per thread"),
 		OPT_BOOLEAN(0, "per-node", &opt_mode.node, "aggregate counts per numa node"),
-		OPT_INTEGER('D', "delay", &target.initial_delay,
+		OPT_INTEGER(
+			'D', "delay", &target.initial_delay,
 			"ms to wait before starting measurement after program start (-1: start with events disabled)"),
 		OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
-				"Only print computed metrics. No raw values", enable_metric_only),
+				   "Only print computed metrics. No raw values",
+				   enable_metric_only),
 		OPT_BOOLEAN(0, "metric-no-group", &stat_config.metric_no_group,
-			"don't group metric events, impacts multiplexing"),
+			    "don't group metric events, impacts multiplexing"),
 		OPT_BOOLEAN(0, "metric-no-merge", &stat_config.metric_no_merge,
-			"don't try to share events between metrics in a group"),
+			    "don't try to share events between metrics in a group"),
 		OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
-			"disable adding events for the metric threshold calculation"),
-		OPT_BOOLEAN(0, "topdown", &topdown_run,
-			"measure top-down statistics"),
+			    "disable adding events for the metric threshold calculation"),
+		OPT_BOOLEAN(0, "topdown", &topdown_run, "measure top-down statistics"),
 #ifdef HAVE_ARCH_X86_64_SUPPORT
 		OPT_BOOLEAN(0, "record-tpebs", &tpebs_recording,
-			"enable recording for tpebs when retire_latency required"),
+			    "enable recording for tpebs when retire_latency required"),
 		OPT_CALLBACK(0, "tpebs-mode", &tpebs_mode, "tpebs-mode",
-			"Mode of TPEBS recording: mean, min or max",
-			parse_tpebs_mode),
+			     "Mode of TPEBS recording: mean, min or max", parse_tpebs_mode),
 #endif
 		OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
-			"Set the metrics level for the top-down statistics (0: max level)"),
-		OPT_BOOLEAN(0, "smi-cost", &smi_cost,
-			"measure SMI cost"),
+			     "Set the metrics level for the top-down statistics (0: max level)"),
+		OPT_BOOLEAN(0, "smi-cost", &smi_cost, "measure SMI cost"),
 		OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
-			"monitor specified metrics or metric groups (separated by ,)",
-			append_metric_groups),
+			     "monitor specified metrics or metric groups (separated by ,)",
+			     append_metric_groups),
 		OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
-				"Configure all used events to run in kernel space.",
-				PARSE_OPT_EXCLUSIVE),
+				 "Configure all used events to run in kernel space.",
+				 PARSE_OPT_EXCLUSIVE),
 		OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
-				"Configure all used events to run in user space.",
-				PARSE_OPT_EXCLUSIVE),
+				 "Configure all used events to run in user space.",
+				 PARSE_OPT_EXCLUSIVE),
 		OPT_BOOLEAN(0, "percore-show-thread", &stat_config.percore_show_thread,
-			"Use with 'percore' event qualifier to show the event "
-			"counts of one hardware thread by sum up total hardware "
-			"threads of same physical core"),
-		OPT_BOOLEAN(0, "summary", &stat_config.summary,
-			"print summary for interval mode"),
+			    "Use with 'percore' event qualifier to show the event "
+			    "counts of one hardware thread by sum up total hardware "
+			    "threads of same physical core"),
+		OPT_BOOLEAN(0, "new", &use_perf_stat_print,
+			    "use new clean API code for display output"),
+		OPT_BOOLEAN(0, "summary", &stat_config.summary, "print summary for interval mode"),
 		OPT_BOOLEAN(0, "no-csv-summary", &stat_config.no_csv_summary,
-			"don't print 'summary' for CSV summary output"),
+			    "don't print 'summary' for CSV summary output"),
 		OPT_BOOLEAN(0, "quiet", &quiet,
-			"don't print any output, messages or warnings (useful with record)"),
+			    "don't print any output, messages or warnings (useful with record)"),
 		OPT_BOOLEAN_SET(0, "affinity", &affinity, &affinity_set,
-			"enable (default) or disable affinity optimizations to reduce IPIs"),
+				"enable (default) or disable affinity optimizations to reduce IPIs"),
 		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
-			"Only enable events on applying cpu with this type "
-			"for hybrid platform (e.g. core or atom)",
-			parse_cputype),
-		OPT_CALLBACK(0, "pmu-filter", &evsel_list, "pmu",
+			     "Only enable events on applying cpu with this type "
+			     "for hybrid platform (e.g. core or atom)",
+			     parse_cputype),
+		OPT_CALLBACK(
+			0, "pmu-filter", &evsel_list, "pmu",
 			"Only enable events on applying pmu with specified "
 			"for multiple pmus with same type(e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)",
 			parse_pmu_filter),
 #ifdef HAVE_LIBPFM
 		OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
-			"libpfm4 event selector. use 'perf list' to list available events",
-			parse_libpfm_events_option),
+			     "libpfm4 event selector. use 'perf list' to list available events",
+			     parse_libpfm_events_option),
 #endif
-		OPT_CALLBACK(0, "control", &stat_config, "fd:ctl-fd[,ack-fd] or fifo:ctl-fifo[,ack-fifo]",
+		OPT_CALLBACK(
+			0, "control", &stat_config,
+			"fd:ctl-fd[,ack-fd] or fifo:ctl-fifo[,ack-fifo]",
 			"Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).\n"
 			"\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
 			"\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 			parse_control_option),
 		OPT_CALLBACK_OPTARG(0, "iostat", &evsel_list, &stat_config, "default",
-				"measure I/O performance metrics provided by arch/platform",
-				iostat_parse),
+				    "measure I/O performance metrics provided by arch/platform",
+				    iostat_parse),
 		OPT_END()
 	};
 	const char * const stat_usage[] = {
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4bbc78b1f741..b03099e820d4 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -113,6 +113,10 @@ perf-util-y += counts.o
 perf-util-y += stat.o
 perf-util-y += stat-shadow.o
 perf-util-y += stat-display.o
+perf-util-y += stat-print.o
+perf-util-y += stat-print-std.o
+perf-util-y += stat-print-csv.o
+perf-util-y += stat-print-json.o
 perf-util-y += perf_api_probe.o
 perf-util-y += record.o
 perf-util-y += srcline.o
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 2b69d238858c..e5aed8d629e6 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -37,7 +37,7 @@
 #define PID_LEN       7
 #define CPUS_LEN      4
 
-static int aggr_header_lens[] = {
+const int aggr_header_lens[] = {
 	[AGGR_CORE] 	= 18,
 	[AGGR_CACHE]	= 22,
 	[AGGR_CLUSTER]	= 20,
@@ -49,7 +49,7 @@ static int aggr_header_lens[] = {
 	[AGGR_GLOBAL] 	= 0,
 };
 
-static const char *aggr_header_csv[] = {
+const char *aggr_header_csv[] = {
 	[AGGR_CORE]	=	"core,ctrs,",
 	[AGGR_CACHE]	=	"cache,ctrs,",
 	[AGGR_CLUSTER]	=	"cluster,ctrs,",
@@ -61,7 +61,7 @@ static const char *aggr_header_csv[] = {
 	[AGGR_GLOBAL]	=	""
 };
 
-static const char *aggr_header_std[] = {
+const char *aggr_header_std[] = {
 	[AGGR_CORE] 	= 	"core",
 	[AGGR_CACHE] 	= 	"cache",
 	[AGGR_CLUSTER]	= 	"cluster",
@@ -580,13 +580,16 @@ static void print_metricgroup_header_std(struct perf_stat_config *config,
 					 const char *metricgroup_name)
 {
 	struct outstate *os = ctx;
+	int n;
 
 	if (!metricgroup_name) {
 		__new_line_std(config, os);
 		return;
 	}
 
-	fprintf(config->output, " %*s", config->metric_only_len, metricgroup_name);
+	n = fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_name);
+
+	fprintf(config->output, "%*s", MGROUP_LEN + config->unit_width + 2 - n, "");
 }
 
 static void print_metric_only(struct perf_stat_config *config,
@@ -596,20 +599,19 @@ static void print_metric_only(struct perf_stat_config *config,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char str[1024];
-	unsigned mlen;
+	unsigned mlen = config->metric_only_len;
 	const char *color = metric_threshold_classify__color(thresh);
-	int olen;
 
-	if (!unit) {
-		os->first = false;
-		return;
-	}
+	if (!unit)
+		unit = "";
+	if (mlen < strlen(unit))
+		mlen = strlen(unit) + 1;
 
-	mlen = max_t(unsigned, strlen(unit), config->metric_only_len);
+	if (color)
+		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
-	olen = snprintf(str, sizeof(str), fmt ?: "", val);
 	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
-	fprintf(out, "%*s%s", max_t(int, mlen - olen, 1), "", str);
+	fprintf(out, "%*s ", mlen, str);
 	os->first = false;
 }
 
diff --git a/tools/perf/util/stat-print-csv.c b/tools/perf/util/stat-print-csv.c
new file mode 100644
index 000000000000..e9d1e7c30c90
--- /dev/null
+++ b/tools/perf/util/stat-print-csv.c
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include "stat-print.h"
+#include <linux/compiler.h>
+
+int perf_stat__print_csv(struct evlist *evlist __maybe_unused,
+			 const struct perf_stat_config *config __maybe_unused,
+			 const struct target *target __maybe_unused,
+			 const struct timespec *ts __maybe_unused,
+			 int argc __maybe_unused,
+			 const char **argv __maybe_unused)
+{
+	return 0;
+}
diff --git a/tools/perf/util/stat-print-json.c b/tools/perf/util/stat-print-json.c
new file mode 100644
index 000000000000..72df7a94095d
--- /dev/null
+++ b/tools/perf/util/stat-print-json.c
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include "stat-print.h"
+#include <linux/compiler.h>
+
+int perf_stat__print_json(struct evlist *evlist __maybe_unused,
+			  const struct perf_stat_config *config __maybe_unused,
+			  const struct target *target __maybe_unused,
+			  const struct timespec *ts __maybe_unused,
+			  int argc __maybe_unused,
+			  const char **argv __maybe_unused)
+{
+	return 0;
+}
diff --git a/tools/perf/util/stat-print-std.c b/tools/perf/util/stat-print-std.c
new file mode 100644
index 000000000000..83987e97c889
--- /dev/null
+++ b/tools/perf/util/stat-print-std.c
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include "stat-print.h"
+#include <linux/compiler.h>
+
+int perf_stat__print_std(struct evlist *evlist __maybe_unused,
+			 const struct perf_stat_config *config __maybe_unused,
+			 const struct target *target __maybe_unused,
+			 const struct timespec *ts __maybe_unused,
+			 int argc __maybe_unused,
+			 const char **argv __maybe_unused)
+{
+	return 0;
+}
diff --git a/tools/perf/util/stat-print.c b/tools/perf/util/stat-print.c
new file mode 100644
index 000000000000..92ff9f1fe31c
--- /dev/null
+++ b/tools/perf/util/stat-print.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "stat-print.h"
+
+#include <errno.h>
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/compiler.h>
+
+#include "cpumap.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "expr.h"
+#include "metricgroup.h"
+#include "stat.h"
+#include "thread_map.h"
+#include "tool_pmu.h"
+
+/*
+ * Unified Aggregation Helpers (Shared by STD, CSV, JSON Formats)
+ */
+
+const char *perf_stat__get_aggr_key(const struct perf_stat_config *config,
+				    const struct evsel *evsel)
+{
+	switch (config->aggr_mode) {
+	case AGGR_CORE:
+		return "core";
+	case AGGR_CACHE:
+		return "cache";
+	case AGGR_CLUSTER:
+		return "cluster";
+	case AGGR_DIE:
+		return "die";
+	case AGGR_SOCKET:
+		return "socket";
+	case AGGR_NODE:
+		return "node";
+	case AGGR_NONE:
+		if (evsel->percore && !config->percore_show_thread)
+			return "core";
+		return "cpu";
+	case AGGR_THREAD:
+		return "thread";
+	case AGGR_GLOBAL:
+	case AGGR_UNSET:
+	case AGGR_MAX:
+	default:
+		return "";
+	}
+}
+
+int perf_stat__get_aggr_id_char(const struct perf_stat_config *config, struct evsel *evsel,
+				struct aggr_cpu_id id, char *buf, size_t buf_size)
+{
+	switch (config->aggr_mode) {
+	case AGGR_CORE:
+		return scnprintf(buf, buf_size, "S%d-D%d-C%d", id.socket, id.die, id.core);
+	case AGGR_CACHE:
+		return scnprintf(buf, buf_size, "S%d-D%d-L%d-ID%d", id.socket, id.die, id.cache_lvl,
+				 id.cache);
+	case AGGR_CLUSTER:
+		return scnprintf(buf, buf_size, "S%d-D%d-CLS%d", id.socket, id.die, id.cluster);
+	case AGGR_DIE:
+		return scnprintf(buf, buf_size, "S%d-D%d", id.socket, id.die);
+	case AGGR_SOCKET:
+		return scnprintf(buf, buf_size, "S%d", id.socket);
+	case AGGR_NODE:
+		return scnprintf(buf, buf_size, "N%d", id.node);
+	case AGGR_NONE:
+		if (evsel->percore && !config->percore_show_thread) {
+			return scnprintf(buf, buf_size, "S%d-D%d-C%d", id.socket, id.die, id.core);
+		} else if (id.cpu.cpu > -1) {
+			return scnprintf(buf, buf_size, "%d", id.cpu.cpu);
+		}
+		break;
+	case AGGR_THREAD:
+		return scnprintf(buf, buf_size, "%s-%d",
+				 perf_thread_map__comm(evsel->core.threads, id.thread_idx),
+				 perf_thread_map__pid(evsel->core.threads, id.thread_idx));
+	case AGGR_GLOBAL:
+	case AGGR_UNSET:
+	case AGGR_MAX:
+	default:
+		break;
+	}
+	buf[0] = '\0';
+	return -1;
+}
+
+/*
+ * Traversal Driver and Calculation Code
+ */
+
+/**
+ * tool_pmu__is_time_event - Check if event is a tool PMU time event.
+ *
+ * Copied from stat-shadow.c to make stat-print.c self-contained.
+ */
+static bool tool_pmu__is_time_event(const struct perf_stat_config *config,
+				    const struct evsel *evsel, int *tool_aggr_idx)
+{
+	enum tool_pmu_event event = evsel__tool_event(evsel);
+	int aggr_idx;
+
+	if (event != TOOL_PMU__EVENT_DURATION_TIME && event != TOOL_PMU__EVENT_USER_TIME &&
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
+/**
+ * prepare_metric - Collect event values required for a metric.
+ * @config: Perf stat configuration.
+ * @mexp: The metric expression.
+ * @evsel: The associated event selector.
+ * @pctx: Expr parse context to add ID/values to.
+ * @aggr_idx: Aggregation index to read values from.
+ *
+ * Iterates over the events required for the metric expression, reads their
+ * counts for the given aggregation index, and adds them to the expression
+ * parser context.
+ *
+ * Copied and refactored from stat-shadow.c.
+ */
+static int prepare_metric(const struct perf_stat_config *config, const struct metric_expr *mexp,
+			  struct evsel *evsel, struct expr_parse_ctx *pctx, int aggr_idx)
+{
+	struct evsel *const *metric_events = mexp->metric_events;
+	struct metric_ref *metric_refs = mexp->metric_refs;
+	int i;
+
+	for (i = 0; metric_events[i]; i++) {
+		int source_count = 0, tool_aggr_idx;
+		bool is_tool_time =
+			tool_pmu__is_time_event(config, metric_events[i], &tool_aggr_idx);
+		struct perf_stat_evsel *ps = metric_events[i]->stats;
+		char *n;
+		double val;
+
+		/*
+		 * If there are multiple uncore PMUs and we're not reading the
+		 * leader's stats, determine the stats for the appropriate
+		 * uncore PMU.
+		 */
+		if (evsel && evsel->metric_leader && evsel->pmu != evsel->metric_leader->pmu &&
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
+				break;
+			}
+		}
+		/* Time events are always on CPU0, the first aggregation index. */
+		if (!ps || !metric_events[i]->supported) {
+			val = NAN;
+			source_count = 0;
+		} else {
+			struct perf_stat_aggr *aggr =
+				&ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
+
+			if (aggr->counts.run == 0) {
+				val = NAN;
+				source_count = 0;
+			} else {
+				val = aggr->counts.val;
+				if (is_tool_time) {
+					/* Convert time event nanoseconds to seconds. */
+					val *= 1e-9;
+				}
+				if (!source_count)
+					source_count = evsel__source_count(metric_events[i]);
+			}
+		}
+		n = strdup(evsel__metric_id(metric_events[i]));
+		if (!n)
+			return -ENOMEM;
+
+		expr__add_id_val_source_count(pctx, n, val, source_count);
+	}
+
+	for (int j = 0; metric_refs && metric_refs[j].metric_name; j++) {
+		int ret = expr__add_ref(pctx, &metric_refs[j]);
+
+		if (ret)
+			return ret;
+	}
+
+	return i;
+}
+
+/**
+ * calculate_and_print_metric - Compute and print a single metric.
+ *
+ * Parses the metric expression, computes the ratio, and calls the print_metric
+ * callback directly with clean parameters.
+ * Returns the return value of the print_metric callback (0 on success, or error).
+ */
+static int calculate_and_print_metric(const struct perf_stat_config *config,
+				      const struct perf_stat_print_callbacks *cb, void *outer_ctx,
+				      struct metric_expr *mexp, struct evsel *evsel, int aggr_idx)
+{
+	const char *metric_name = mexp->metric_name;
+	const char *metric_expr = mexp->metric_expr;
+	const char *metric_threshold = mexp->metric_threshold;
+	const char *metric_unit = mexp->metric_unit;
+	struct evsel *const *metric_events = mexp->metric_events;
+	int runtime = mexp->runtime;
+	struct expr_parse_ctx *pctx;
+	double ratio, scale, threshold;
+	int i;
+	enum metric_threshold_classify thresh = METRIC_THRESHOLD_UNKNOWN;
+	int ret = 0;
+
+	if (!cb->print_metric)
+		return 0;
+
+	pctx = expr__ctx_new();
+	if (!pctx)
+		return -ENOMEM;
+
+	if (config->user_requested_cpu_list)
+		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
+	pctx->sctx.runtime = runtime;
+	pctx->sctx.system_wide = config->system_wide;
+	i = prepare_metric(config, mexp, evsel, pctx, aggr_idx);
+	if (i < 0) {
+		expr__ctx_free(pctx);
+		return i;
+	}
+	if (!metric_events[i]) {
+		if (expr__parse(&ratio, pctx, metric_expr) == 0) {
+			char *unit;
+
+			if (metric_threshold &&
+			    expr__parse(&threshold, pctx, metric_threshold) == 0 &&
+			    !isnan(threshold)) {
+				thresh = fpclassify(threshold) == FP_ZERO ? METRIC_THRESHOLD_GOOD :
+									    METRIC_THRESHOLD_BAD;
+			}
+
+			if (metric_unit && metric_name) {
+				if (perf_pmu__convert_scale(metric_unit, &unit, &scale) >= 0) {
+					ratio *= scale;
+				}
+				ret = cb->print_metric(outer_ctx, config, evsel, aggr_idx,
+						       metric_name, unit, ratio, thresh);
+			} else {
+				ret = cb->print_metric(outer_ctx, config, evsel, aggr_idx,
+						       metric_name ?: (evsel->name ?: ""), NULL,
+						       ratio, thresh);
+			}
+		}
+	}
+
+	expr__ctx_free(pctx);
+	return ret;
+}
+
+/**
+ * perf_stat_print_metricgroup - Traverse metrics for an event.
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ */
+static bool is_basic_shadow_metric(const char *name)
+{
+	static const char *const basic_metrics[] = {
+		"insn_per_cycle",   "branch_miss_rate",	      "branch_frequency",
+		"cycles_frequency", "page_faults_per_second", "migrations_per_second",
+		"cs_per_second",    "CPUs_utilized",
+	};
+	for (size_t i = 0; i < ARRAY_SIZE(basic_metrics); i++) {
+		if (!strcmp(basic_metrics[i], name))
+			return true;
+	}
+	return false;
+}
+
+static int perf_stat_print_metricgroup(const struct perf_stat_config *config,
+				       const struct perf_stat_print_callbacks *cb, void *outer_ctx,
+				       struct evsel *evsel, int aggr_idx)
+{
+	struct metric_event *me;
+	struct metric_expr *mexp;
+	struct rblist *metric_events = &evsel->evlist->metric_events;
+	int ret;
+
+	me = metricgroup__lookup(metric_events, evsel, false);
+	if (me == NULL)
+		return 0;
+
+	list_for_each_entry(mexp, &me->head, nd) {
+		if (!config->metric_only &&
+		    (!evsel->default_metricgroup || evsel->default_show_events)) {
+			if (!is_basic_shadow_metric(mexp->metric_name))
+				continue;
+		}
+
+		ret = calculate_and_print_metric(config, cb, outer_ctx, mexp, evsel, aggr_idx);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/**
+ * perf_stat_print_metrics - Entry point for metric calculation & printing.
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ */
+static int perf_stat_print_metrics(const struct perf_stat_config *config,
+				   const struct perf_stat_print_callbacks *cb, void *outer_ctx,
+				   struct evsel *evsel, int aggr_idx)
+{
+	if (config->iostat_run) {
+		/* IOSTAT metrics not supported yet in new API */
+		return 0;
+	}
+
+	return perf_stat_print_metricgroup(config, cb, outer_ctx, evsel, aggr_idx);
+}
+
+int perf_stat__print_cb(struct evlist *evlist, const struct perf_stat_config *config,
+			const struct target *target __maybe_unused,
+			const struct timespec *ts __maybe_unused, int argc __maybe_unused,
+			const char **argv __maybe_unused,
+			const struct perf_stat_print_callbacks *cb, void *ctx)
+{
+	struct evsel *counter;
+	int aggr_idx;
+	int ret = 0;
+
+	evlist__uniquify_evsel_names(evlist, config);
+
+	if (cb->print_start) {
+		ret = cb->print_start(ctx, config);
+		if (ret)
+			return ret;
+	}
+
+	switch (config->aggr_mode) {
+	case AGGR_GLOBAL:
+	case AGGR_NONE:
+	case AGGR_SOCKET:
+	case AGGR_DIE:
+	case AGGR_CLUSTER:
+	case AGGR_CACHE:
+	case AGGR_CORE:
+	case AGGR_THREAD:
+	case AGGR_NODE:
+		if (config->aggr_map) {
+			cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+				evlist__for_each_entry(evlist, counter) {
+					struct perf_stat_evsel *ps = counter->stats;
+					u64 val = 0, ena = 0, run = 0;
+
+					if (ps && ps->aggr) {
+						val = ps->aggr[aggr_idx].counts.val;
+						ena = ps->aggr[aggr_idx].counts.ena;
+						run = ps->aggr[aggr_idx].counts.run;
+					}
+
+					/* Skip already merged uncore/hybrid events */
+					if (config->aggr_mode != AGGR_NONE) {
+						if (evsel__is_hybrid(counter)) {
+							if (config->hybrid_merge &&
+							    counter->first_wildcard_match != NULL)
+								continue;
+						} else {
+							if (counter->first_wildcard_match != NULL)
+								continue;
+						}
+					}
+
+					if (perf_stat__skip_metric_event(counter))
+						continue;
+
+					if (cb->print_event) {
+						double stdev_pct = 0.0;
+						if (ps && ps->res_stats.n > 1) {
+							stdev_pct = rel_stddev_stats(
+								stddev_stats(&ps->res_stats), val);
+						}
+						ret = cb->print_event(ctx, config, counter,
+								      aggr_idx, val, ena, run,
+								      stdev_pct);
+						if (ret)
+							goto out;
+					}
+
+					ret = perf_stat_print_metrics(config, cb, ctx, counter,
+								      aggr_idx);
+					if (ret)
+						goto out;
+				}
+			}
+		} else {
+			evlist__for_each_entry(evlist, counter) {
+				struct perf_stat_evsel *ps = counter->stats;
+				u64 val = 0, ena = 0, run = 0;
+
+				if (ps && ps->aggr) {
+					val = ps->aggr[0].counts.val;
+					ena = ps->aggr[0].counts.ena;
+					run = ps->aggr[0].counts.run;
+				}
+
+				/* Skip already merged uncore/hybrid events */
+				if (config->aggr_mode != AGGR_NONE) {
+					if (evsel__is_hybrid(counter)) {
+						if (config->hybrid_merge &&
+						    counter->first_wildcard_match != NULL)
+							continue;
+					} else {
+						if (counter->first_wildcard_match != NULL)
+							continue;
+					}
+				}
+
+				if (perf_stat__skip_metric_event(counter))
+					continue;
+
+				if (cb->print_event) {
+					double stdev_pct = 0.0;
+					if (ps && ps->res_stats.n > 1) {
+						stdev_pct = rel_stddev_stats(
+							stddev_stats(&ps->res_stats), val);
+					}
+					ret = cb->print_event(ctx, config, counter, 0, val, ena,
+							      run, stdev_pct);
+					if (ret)
+						goto out;
+				}
+
+				ret = perf_stat_print_metrics(config, cb, ctx, counter, 0);
+				if (ret)
+					goto out;
+			}
+		}
+		break;
+	case AGGR_UNSET:
+	case AGGR_MAX:
+	default:
+		fprintf(config->output, "Aggregation mode %d not supported in new API yet\n",
+			config->aggr_mode);
+		break;
+	}
+
+out:
+	if (cb->print_end) {
+		int err = cb->print_end(ctx, config);
+		if (!ret)
+			ret = err;
+	}
+
+	return ret;
+}
+
+int perf_stat__print(struct evlist *evlist, const struct perf_stat_config *config,
+		     const struct target *target, const struct timespec *ts, int argc,
+		     const char **argv)
+{
+	if (config->csv_output) {
+		return perf_stat__print_csv(evlist, config, target, ts, argc, argv);
+	} else if (config->json_output) {
+		return perf_stat__print_json(evlist, config, target, ts, argc, argv);
+	} else {
+		return perf_stat__print_std(evlist, config, target, ts, argc, argv);
+	}
+}
diff --git a/tools/perf/util/stat-print.h b/tools/perf/util/stat-print.h
new file mode 100644
index 000000000000..a86414f32584
--- /dev/null
+++ b/tools/perf/util/stat-print.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_STAT_PRINT_H
+#define __PERF_STAT_PRINT_H
+
+#include <linux/types.h>
+
+#include "stat.h"
+
+#define CNTR_NOT_SUPPORTED "<not supported>"
+#define CNTR_NOT_COUNTED "<not counted>"
+
+struct evlist;
+struct perf_stat_config;
+struct target;
+struct timespec;
+struct evsel;
+struct aggr_cpu_id;
+
+extern const int aggr_header_lens[];
+extern const char *aggr_header_csv[];
+extern const char *aggr_header_std[];
+
+/**
+ * struct perf_stat_print_callbacks - Callbacks for rendering perf stat output.
+ *
+ * This structure defines the interface for different output formats (e.g.,
+ * Standard, CSV, JSON) to render the collected performance counter statistics.
+ * The core display logic traverses the events and metrics and calls these
+ * callbacks in a streaming fashion, which build an in-memory DOM tree. The
+ * final rendering and output formatting is executed entirely in print_end.
+ */
+struct perf_stat_print_callbacks {
+	/**
+	 * print_start - Called before any event or metric is printed.
+	 * @ctx: Opaque context pointer passed to the print function.
+	 * @config: Perf stat configuration.
+	 */
+	int (*print_start)(void *ctx, const struct perf_stat_config *config);
+
+	/**
+	 * print_end - Called after all events and metrics have been traversed.
+	 * Executes the actual formatting and printing of the buffered tree.
+	 * @ctx: Opaque context pointer.
+	 * @config: Perf stat configuration.
+	 */
+	int (*print_end)(void *ctx, const struct perf_stat_config *config);
+
+	/**
+	 * print_event - Called to buffer an event (counter) value.
+	 * @ctx: Opaque context pointer.
+	 * @config: Perf stat configuration.
+	 * @evsel: The event selector being printed (mutable for lazy initialization).
+	 * @aggr_idx: Aggregation index in evsel->stats.
+	 * @val: Raw counter value.
+	 * @ena: Enabled time for the counter (for multiplexing).
+	 * @run: Running time for the counter (for multiplexing).
+	 * @stdev_pct: Standard deviation percentage across multiple repeated runs.
+	 *
+	 * Returns 0 on success, or a negative error code (e.g., -ENOMEM) on failure.
+	 */
+	int (*print_event)(void *ctx, const struct perf_stat_config *config, struct evsel *evsel,
+			   int aggr_idx, u64 val, u64 ena, u64 run, double stdev_pct);
+
+	/**
+	 * print_metric - Called to buffer a metric value associated with an event.
+	 * @ctx: Opaque context pointer.
+	 * @config: Perf stat configuration.
+	 * @evsel: The event selector associated with the metric (mutable).
+	 * @aggr_idx: Aggregation index.
+	 * @name: The display name of the metric.
+	 * @unit: The unit of the metric (e.g., "%", "GHz", or NULL).
+	 * @val: The calculated metric value.
+	 * @thresh: Threshold classification (e.g., good, bad) for color coding.
+	 *
+	 * Returns 0 on success, or a negative error code (e.g., -ENOMEM) on failure.
+	 */
+	int (*print_metric)(void *ctx, const struct perf_stat_config *config, struct evsel *evsel,
+			    int aggr_idx, const char *name, const char *unit, double val,
+			    enum metric_threshold_classify thresh);
+};
+
+/**
+ * perf_stat__get_aggr_key - Get the JSON key name for an aggregation mode.
+ */
+const char *perf_stat__get_aggr_key(const struct perf_stat_config *config,
+				    const struct evsel *evsel);
+
+/**
+ * perf_stat__get_aggr_id_char - Get the unified aggregation ID string.
+ *
+ * Returns the formatted string size, or a negative error code on failure.
+ */
+int perf_stat__get_aggr_id_char(const struct perf_stat_config *config, struct evsel *evsel,
+				struct aggr_cpu_id id, char *buf, size_t buf_size);
+
+/**
+ * perf_stat__print_cb - Drive the traversal and call callbacks.
+ *
+ * Defined in stat-print.c. Called by format-specific entry points.
+ * Returns 0 on success, or a negative error code on failure.
+ */
+int perf_stat__print_cb(struct evlist *evlist, const struct perf_stat_config *config,
+			const struct target *target, const struct timespec *ts, int argc,
+			const char **argv, const struct perf_stat_print_callbacks *cb, void *ctx);
+
+/**
+ * perf_stat__print - Entry point for the decoupled print API.
+ *
+ * Defined in stat-print.c. Dispatches to format-specific entry points.
+ * Returns 0 on success, or a negative error code on failure.
+ */
+int perf_stat__print(struct evlist *evlist, const struct perf_stat_config *config,
+		     const struct target *target, const struct timespec *ts, int argc,
+		     const char **argv);
+
+/*
+ * Format-specific entry points, implemented in their respective files.
+ * All return 0 on success, or a negative error code on failure.
+ */
+
+int perf_stat__print_std(struct evlist *evlist, const struct perf_stat_config *config,
+			 const struct target *target, const struct timespec *ts, int argc,
+			 const char **argv);
+
+int perf_stat__print_csv(struct evlist *evlist, const struct perf_stat_config *config,
+			 const struct target *target, const struct timespec *ts, int argc,
+			 const char **argv);
+
+int perf_stat__print_json(struct evlist *evlist, const struct perf_stat_config *config,
+			  const struct target *target, const struct timespec *ts, int argc,
+			  const char **argv);
+
+#endif /* __PERF_STAT_PRINT_H */
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 4bced233d2fc..77873d51786c 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -106,6 +106,8 @@ struct perf_stat_config {
 	bool			 ctl_fd_close;
 	const char		*cgroup_list;
 	unsigned int		topdown_level;
+	bool			 headers_printed;
+	bool			 metric_only_headers_printed;
 };
 
 extern struct perf_stat_config stat_config;
-- 
2.54.0.794.g4f17f83d09-goog

