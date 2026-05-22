Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D037BE97
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489250; cv=none; b=ar/KfgIZT+x8jUzP9yqOwfkf3AXjBzCOmw8zAKg/APXRdYo6q77Ci08aDfPGoZUbwpOFDbkV8I8ixXFve/eSY2hqym4upIX1xow0J2Xt7Olp1wK/D07svCJaF/1eUyGn+3sCoS9WUJG+hhRnu/iKPJB1TslqFbvJgZqt3rT/Zqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489250; c=relaxed/simple;
	bh=7jEfVydiNd0BLHuEvAPUwiTsiqidCEHH7O04ZUgl3Dk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HwlofYR+MvNK/W+fZD35Ky6f3a0YOsEJU83/ujqEgC1RKPuPH6Bb+z3cJl1MpelqFXQcIfF+TIO5Nr41nZ1gP7xMc+wQrPDvFXWihU9HWd4xK7b4CrQk5HJbm18sMosVeTNutYeRsBCG3ykwrROYMNqnQzec1cs3N+dumAVLj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSMnJ6Xb; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSMnJ6Xb"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135fe34cb98so5966819c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489247; x=1780094047; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMIVgcABLtJN9wboli4jeVu+VRnrVXCSDVoPE8cpN5I=;
        b=mSMnJ6Xbv0olSAWpYtnHMD33QPKRTLoLOoWiT9XDiVZqOT+vllvHayN5VyyMcKvsaD
         l9oBqSIaofQX79h4C20cgj69XrXne+ozleP8BR/uy+VU+9GrSfNCNqnPvN6JSm8XKsrw
         FUPYdpVY6paKyUMS6oVRWOKJo08G2b2YBn020dDCv/QZ8XlQHJoWbq5tUQNzDTnvgnGO
         prdg0FEUwvoFWoMQNSRKHLShioz3Uwvi8SmN46qu3zOIHzHTRbf4+ArmcvksCFrQ0YHr
         5V3mEj2wlgYle02pbmhKxN7dDr8ypR1xpqFP7sRb76f1BGUPEkQokOQw5J8F0CM20lb3
         2QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489247; x=1780094047;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMIVgcABLtJN9wboli4jeVu+VRnrVXCSDVoPE8cpN5I=;
        b=AXsz98BTeS3uJzVWGnPBphSkWSC2mo4KW3m8cU2O6BFL5DNFa7zg7EbinCjXRai1pk
         pmdSPttVzy//gHkp4Scn2TM+KCGJDeljJUKbIZFnezV7utw1SIuAjLQhavcuR2/goisB
         PJ8c/pdGYQ+VsVHmhC+xavMgW3v/ZZ/9kDpOPaVtTV/N0D0R1yEePWsBfTCAjBczMvV2
         WN1lNbf+2Vk6n+siK6fSWs21CSVwH2IQvgfJsINJU1/7OV6L5HU6vBPSD+OVBdPuQdw2
         IGVZ91JMCjU95ibGmwVtBiYCCMddWU069dS+g0nbH/UErN8aUenmtz5KGWVHdbGWgXJT
         Sf/w==
X-Forwarded-Encrypted: i=1; AFNElJ8ZNvJVfGuQYmf9CBija7XwNOjj2y9BDrOaWTJmQsmXAH+WYXF9KII2LZLYXBmRtkpe/XnuONx1et2MnMPX9Uvt@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwcYBlJsF9iQv0xbmqTzKgrghvxKP64By2onYlvH7Guj899Gq
	arpacC6SoNd6prigPuHb+XLYBGwCKT6T3ZRjZkHBNf0wXkLFhjXUtES9RDc06oSr3p0rCuJPVT0
	b6xmZ3tzS4w==
X-Received: from dlj15.prod.google.com ([2002:a05:7022:50f:b0:12c:34da:e06e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6093:b0:12c:6e85:505c
 with SMTP id a92af1059eb24-1365f70f672mr2057630c88.4.1779489246785; Fri, 22
 May 2026 15:34:06 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:30 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-3-irogers@google.com>
Subject: [RFC PATCH v1 02/14] perf stat: Implement standard console (STD)
 formatting callbacks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch implements standard console formatting callbacks inside
util/stat-print-std.c, replacing the empty stubs introduced in Commit 1.

Introduces the format-private `struct queued_event` and `struct queued_metric`
DOM nodes to buffer traversal streams, and fully encapsulates DOM state
initialization and queue cleanups inside std_print_start() and std_print_end().

Utilizes the newly centralized unified aggregation helpers to resolve CPU and
thread prefixes cleanly, and incorporates full interval-mode timestamp
printing support across all rows.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/util/stat-print-std.c | 740 ++++++++++++++++++++++++++++++-
 1 file changed, 733 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-print-std.c b/tools/perf/util/stat-print-std.c
index 83987e97c889..0aa4e2669bba 100644
--- a/tools/perf/util/stat-print-std.c
+++ b/tools/perf/util/stat-print-std.c
@@ -1,13 +1,739 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include "stat-print.h"
+#include <errno.h>
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+
+#include "color.h"
+#include "cpumap.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "metricgroup.h"
+#include "stat-print.h"
+#include "stat.h"
+#include "target.h"
+#include "thread_map.h"
+#include "tool_pmu.h"
+
+#define COUNTS_LEN 18
+#define EVNAME_LEN 32
+#define COMM_LEN 16
+#define PID_LEN 7
+#define MGROUP_LEN 50
+#define METRIC_LEN 38
+
+static const int aggr_header_lens[] = {
+	[AGGR_CORE] = 18, [AGGR_CACHE] = 22,  [AGGR_CLUSTER] = 20,
+	[AGGR_DIE] = 12,  [AGGR_SOCKET] = 6,  [AGGR_NODE] = 6,
+	[AGGR_NONE] = 6,  [AGGR_THREAD] = 16, [AGGR_GLOBAL] = 0,
+};
+
+/**
+ * struct queued_metric - In-memory record of a buffered metric.
+ * @list: Linked list node for queueing.
+ * @name: The display name of the metric.
+ * @unit: The metric's unit (e.g., "%", "GHz", or NULL).
+ * @val: The calculated ratio/metric value.
+ * @thresh: Threshold classification for color coding.
+ * @aggr_idx: Aggregation index in evsel stats.
+ */
+struct queued_metric {
+	struct list_head list;
+	char *name;
+	char *unit;
+	double val;
+	enum metric_threshold_classify thresh;
+	int aggr_idx;
+};
+
+/**
+ * struct queued_event - In-memory record of a buffered counter event.
+ * @list: Linked list node for queueing.
+ * @evsel: The associated performance event selector.
+ * @name: The uniquely formatted/resolved event name.
+ * @val: Raw aggregated counter value.
+ * @ena: Enabled time for multiplexing percentage.
+ * @run: Running time for multiplexing percentage.
+ * @stdev_pct: Standard deviation percentage across repeated runs.
+ * @aggr_idx: Aggregation index.
+ * @is_metricgroup: Whether this represents a unified metricgroup header.
+ * @metrics_list: Linked list head containing nested queued_metric structures.
+ */
+struct queued_event {
+	struct list_head list;
+	struct evsel *evsel;
+	char *name;
+	u64 val, ena, run;
+	double stdev_pct;
+	int aggr_idx;
+	bool is_metricgroup;
+	struct list_head metrics_list;
+};
+
+/**
+ * struct std_print_state - Print state context for Standard console output.
+ * @fp: File descriptor to output to.
+ * @timestamp: Formatted interval timestamp (optional).
+ * @events_list: Linked list head containing queued_event nodes.
+ * @current_event: Pointer to the currently active event being printed.
+ *                 Serves as a temporary bridge to associate streaming metrics back to
+ *                 their parent event node during list buffering. This relies on a
+ *                 strict temporal coupling in the traversal driver: the driver always
+ *                 invokes print_metric() callbacks for a counter synchronously and
+ *                 immediately after its print_event() callback, prior to advancing
+ *                 to the next event or aggregation node. This pointer is completely
+ *                 private to standard printing, keeping the traversal driver decoupled
+ *                 and preserving strict encapsulation.
+ * @target: target query parameters for header printout.
+ * @argc: Command argument count.
+ * @argv: Command argument values.
+ */
+struct std_print_state {
+	FILE *fp;
+	char timestamp[64];
+	struct list_head events_list;
+	struct queued_event *current_event;
+	const struct target *target;
+	int argc;
+	const char **argv;
+};
+
+/**
+ * struct std_metric_only_print_state - Metric-only print state context for Standard console output.
+ * @fp: File descriptor to output to.
+ * @queued_metrics: Linked list head containing queued_metric nodes.
+ * @timestamp: Formatted interval timestamp (optional).
+ * @target: target query parameters.
+ * @argc: Command argument count.
+ * @argv: Command argument values.
+ */
+struct std_metric_only_print_state {
+	FILE *fp;
+	struct list_head queued_metrics;
+	char timestamp[64];
+	const struct target *target;
+	int argc;
+	const char **argv;
+};
+
+/**
+ * print_aggr_id_std - Print the aggregation prefix for STD format.
+ *
+ * Uses the unified perf_stat__get_aggr_id_char helper to format the base
+ * aggregation string, and pads it dynamically using aggr_header_lens.
+ */
+static void print_aggr_id_std(const struct perf_stat_config *config, FILE *output,
+			      struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
+{
+	char buf[128];
+
+	if (perf_stat__get_aggr_id_char(config, evsel, id, buf, sizeof(buf)) < 0)
+		return;
+
+	if (config->aggr_mode == AGGR_NONE) {
+		if (evsel->percore && !config->percore_show_thread) {
+			fprintf(output, "%-*s ", aggr_header_lens[AGGR_CORE], buf);
+		} else if (id.cpu.cpu > -1) {
+			/* For CPU none mode, prepend "CPU" during console print */
+			char cpu_buf[160];
+			snprintf(cpu_buf, sizeof(cpu_buf), "CPU%s", buf);
+			fprintf(output, "%-*s ", aggr_header_lens[AGGR_NONE], cpu_buf);
+		}
+		return;
+	}
+
+	if (config->aggr_mode == AGGR_THREAD) {
+		fprintf(output, "%-*s ", aggr_header_lens[AGGR_THREAD], buf);
+		return;
+	}
+
+	/* Socket/Die/Node/Cache/Cluster modes print base ID and aggr count */
+	fprintf(output, "%-s %*d ", buf, 4, aggr_nr);
+}
+
+/**
+ * should_skip_zero_counter - Check if a zero-valued counter should be skipped.
+ *
+ * Implemented locally for standard console formatting.
+ */
+static bool should_skip_zero_counter(const struct perf_stat_config *config, struct evsel *counter,
+				     int aggr_idx)
+{
+	struct perf_cpu cpu;
+	unsigned int idx;
+	struct aggr_cpu_id id;
+
+	if (verbose == 0 && counter->skippable && !counter->supported)
+		return true;
+
+	if (config->metric_only)
+		return false;
+
+	if (config->aggr_mode == AGGR_THREAD && config->system_wide)
+		return true;
+
+	if (!config->aggr_map || !config->aggr_get_id)
+		return false;
+
+	id = config->aggr_map->map[aggr_idx];
+
+	if (evsel__is_tool(counter)) {
+		struct aggr_cpu_id own_id = config->aggr_get_id((struct perf_stat_config *)config,
+								(struct perf_cpu){ .cpu = 0 });
+
+		return !aggr_cpu_id__equal(&id, &own_id);
+	}
+
+	perf_cpu_map__for_each_cpu(cpu, idx, counter->core.cpus) {
+		struct aggr_cpu_id own_id =
+			config->aggr_get_id((struct perf_stat_config *)config, cpu);
+
+		if (aggr_cpu_id__equal(&id, &own_id))
+			return false;
+	}
+	return true;
+}
+
+/*
+ * Standard (STD) Output Callbacks - Normal Mode
+ */
+
+static int std_print_start(void *ctx, const struct perf_stat_config *config __maybe_unused)
+{
+	struct std_print_state *ps = ctx;
+
+	INIT_LIST_HEAD(&ps->events_list);
+	ps->current_event = NULL;
+	return 0;
+}
+
+static int std_print_event(void *ctx, const struct perf_stat_config *config, struct evsel *evsel,
+			   int aggr_idx, u64 val, u64 ena, u64 run, double stdev_pct)
+{
+	struct std_print_state *ps = ctx;
+	struct queued_event *ev;
+
+	/* Skip zero counters locally in STD callbacks if they qualify */
+	if (val == 0 && should_skip_zero_counter(config, evsel, aggr_idx))
+		return 0;
+
+	ev = malloc(sizeof(*ev));
+	if (!ev)
+		return -ENOMEM;
+
+	ev->name = strdup(evsel__name(evsel));
+	if (!ev->name) {
+		free(ev);
+		return -ENOMEM;
+	}
+
+	ev->evsel = evsel;
+	ev->val = val;
+	ev->ena = ena;
+	ev->run = run;
+	ev->stdev_pct = stdev_pct;
+	ev->aggr_idx = aggr_idx;
+	INIT_LIST_HEAD(&ev->metrics_list);
+
+	list_add_tail(&ev->list, &ps->events_list);
+	ps->current_event = ev;
+
+	return 0;
+}
+
+static int std_print_metric(void *ctx, const struct perf_stat_config *config __maybe_unused,
+			    struct evsel *evsel __maybe_unused, int aggr_idx __maybe_unused,
+			    const char *name, const char *unit, double val,
+			    enum metric_threshold_classify thresh)
+{
+	struct std_print_state *ps = ctx;
+	struct queued_metric *b;
+
+	if (!ps->current_event)
+		return 0;
+
+	if (evsel != ps->current_event->evsel) {
+		pr_err("decoupled print engine: temporal coupling violation: evsel mismatch!\n");
+		return -EINVAL;
+	}
+
+	b = malloc(sizeof(*b));
+	if (!b)
+		return -ENOMEM;
+
+	b->name = strdup(name);
+	if (!b->name) {
+		free(b);
+		return -ENOMEM;
+	}
+
+	if (unit && unit[0]) {
+		b->unit = strdup(unit);
+		if (!b->unit) {
+			free(b->name);
+			free(b);
+			return -ENOMEM;
+		}
+	} else {
+		b->unit = NULL;
+	}
+
+	b->val = val;
+	b->thresh = thresh;
+	list_add_tail(&b->list, &ps->current_event->metrics_list);
+
+	return 0;
+}
+
+#define USEC_PER_SEC 1000000ULL
+#define NSEC_PER_SEC 1000000000ULL
+
+static double timeval2double(struct timeval *t)
+{
+	return t->tv_sec + (double)t->tv_usec / USEC_PER_SEC;
+}
+
+static void print_footer_std(const struct perf_stat_config *config)
+{
+	double avg = avg_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
+	FILE *output = config->output;
 
-int perf_stat__print_std(struct evlist *evlist __maybe_unused,
-			 const struct perf_stat_config *config __maybe_unused,
-			 const struct target *target __maybe_unused,
-			 const struct timespec *ts __maybe_unused,
-			 int argc __maybe_unused,
-			 const char **argv __maybe_unused)
+	if (config->interval)
+		return;
+
+	if (!config->null_run)
+		fprintf(output, "\n");
+
+	if (config->run_count == 1) {
+		fprintf(output, " %17.9f seconds time elapsed", avg);
+
+		if (config->ru_display) {
+			double ru_utime =
+				timeval2double((struct timeval *)&config->ru_data.ru_utime);
+			double ru_stime =
+				timeval2double((struct timeval *)&config->ru_data.ru_stime);
+
+			fprintf(output, "\n\n");
+			fprintf(output, " %17.9f seconds user\n", ru_utime);
+			fprintf(output, " %17.9f seconds sys\n", ru_stime);
+		}
+	} else {
+		double sd = stddev_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
+		fprintf(output, " %17.9f +- %-17.9f seconds time elapsed", avg, sd);
+	}
+	fprintf(output, "\n");
+}
+
+/**
+ * print_header_std - Print the header prefix matching old API.
+ *
+ * Copied and adapted from stat-display.c.
+ */
+static void print_header_std(const struct perf_stat_config *config, const struct target *target,
+			     int argc, const char **argv)
+{
+	FILE *output = config->output;
+	int i;
+
+	fprintf(output, "\n");
+	fprintf(output, " Performance counter stats for ");
+	if (target->bpf_str)
+		fprintf(output, "\'BPF program(s) %s", target->bpf_str);
+	else if (target->system_wide)
+		fprintf(output, "\'system wide");
+	else if (target->cpu_list)
+		fprintf(output, "\'CPU(s) %s", target->cpu_list);
+	else if (!target__has_task(target)) {
+		fprintf(output, "\'%s", argv ? argv[0] : "pipe");
+		for (i = 1; argv && (i < argc); i++)
+			fprintf(output, " %s", argv[i]);
+	} else if (target->pid)
+		fprintf(output, "process id \'%s", target->pid);
+	else
+		fprintf(output, "thread id \'%s", target->tid);
+
+	fprintf(output, "\'");
+	if (config->run_count > 1)
+		fprintf(output, " (%d runs)", config->run_count);
+	fprintf(output, ":\n\n");
+}
+
+static int std_print_end(void *ctx, const struct perf_stat_config *config)
+{
+	struct std_print_state *ps = ctx;
+	struct queued_event *ev, *tmp_ev;
+	struct queued_metric *met, *tmp_met;
+	FILE *out = ps->fp;
+	bool first;
+	const char *last_mg_name = NULL;
+	const struct perf_pmu *last_pmu = NULL;
+	int last_aggr_idx = -1;
+
+	/* Print the formatted header prefix (only in non-interval mode) */
+	if (!config->interval)
+		print_header_std(config, ps->target, ps->argc, ps->argv);
+
+	list_for_each_entry_safe(ev, tmp_ev, &ps->events_list, list) {
+		struct evsel *evsel = ev->evsel;
+		double sc = evsel->scale;
+		const char *fmt;
+		const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
+		struct metric_event *me =
+			metricgroup__lookup(&evsel->evlist->metric_events, evsel, false);
+		bool is_metricgroup = false;
+		bool skip_header = false;
+		char full_name[128] = "";
+
+		if (me && me->is_default && !evsel->default_show_events) {
+			struct metric_expr *mexp =
+				list_first_entry(&me->head, struct metric_expr, nd);
+			const char *mg_name = mexp->default_metricgroup_name;
+			bool need_full_name = perf_pmus__num_core_pmus() > 1;
+
+			if (need_full_name && evsel->pmu)
+				scnprintf(full_name, sizeof(full_name), "%s (%s)", mg_name,
+					  evsel->pmu->name);
+			else
+				scnprintf(full_name, sizeof(full_name), "%s", mg_name);
+			is_metricgroup = true;
+
+			if (last_mg_name && !strcmp(last_mg_name, mg_name) &&
+			    last_pmu == evsel->pmu && last_aggr_idx == ev->aggr_idx) {
+				skip_header = true;
+			}
+			last_mg_name = mg_name;
+			last_pmu = evsel->pmu;
+			last_aggr_idx = ev->aggr_idx;
+		}
+
+		/* Print interval timestamp if configured */
+		if (config->interval && ps->timestamp[0] && !skip_header)
+			fprintf(out, "%s", ps->timestamp);
+
+		/* 1. Print aggregation prefix first (if we don't skip header) */
+		if (!skip_header && config->aggr_map && ev->aggr_idx >= 0) {
+			struct aggr_cpu_id id = config->aggr_map->map[ev->aggr_idx];
+			int aggr_nr = 0;
+			if (evsel->stats && evsel->stats->aggr) {
+				aggr_nr = evsel->stats->aggr[ev->aggr_idx].nr;
+			}
+			print_aggr_id_std(config, out, evsel, id, aggr_nr);
+		}
+
+		/* 2. Print event value (scaled) or spaces if metricgroup */
+		if (is_metricgroup) {
+			if (!skip_header) {
+				int n = fprintf(out, " %*s", EVNAME_LEN, full_name);
+				fprintf(out, "%*s", MGROUP_LEN + config->unit_width + 2 - n, "");
+			}
+		} else {
+			if (config->big_num)
+				fmt = floor(sc) != sc ? "%'*.2f " : "%'*.0f ";
+			else
+				fmt = floor(sc) != sc ? "%*.2f " : "%*.0f ";
+
+			if (ev->run == 0 || ev->ena == 0) {
+				fprintf(out, "%*s ", COUNTS_LEN, bad_count);
+			} else {
+				double scaled = (double)ev->val;
+				double avg;
+				if (ev->ena < ev->run) {
+					scaled = (double)ev->val * ev->run / ev->ena;
+				}
+				avg = scaled * sc;
+				fprintf(out, fmt, COUNTS_LEN, avg);
+			}
+
+			/* 3. Print unit */
+			if (evsel->unit) {
+				fprintf(out, "%-*s ", config->unit_width, evsel->unit);
+			} else {
+				if (config->unit_width > 0)
+					fprintf(out, "%-*s ", config->unit_width, "");
+			}
+
+			/* 4. Print event name */
+			fprintf(out, "%-*s", EVNAME_LEN, evsel__name(evsel));
+
+			/* If there are no metrics, print noise and multiplexing percentage */
+			if (list_empty(&ev->metrics_list)) {
+				if (ev->stdev_pct)
+					fprintf(out, "  ( +-%6.2f%% )", ev->stdev_pct);
+				if (ev->run != ev->ena)
+					fprintf(out, "  (%.2f%%)", 100.0 * ev->run / ev->ena);
+			}
+		}
+
+		first = true;
+		list_for_each_entry_safe(met, tmp_met, &ev->metrics_list, list) {
+			const char *color = metric_threshold_classify__color(met->thresh);
+			char unit_name[128];
+			const char *m_fmt = (met->unit && met->unit[0]) ? "%8.1f" : "%8.2f";
+
+			if (met->unit && met->unit[0]) {
+				snprintf(unit_name, sizeof(unit_name), "%s  %s", met->unit,
+					 met->name);
+			} else {
+				snprintf(unit_name, sizeof(unit_name), "%s", met->name);
+			}
+
+			if (first) {
+				if (skip_header) {
+					if (config->interval && ps->timestamp[0])
+						fprintf(out, "%s", ps->timestamp);
+					if (config->aggr_map && ev->aggr_idx >= 0) {
+						struct aggr_cpu_id id =
+							config->aggr_map->map[ev->aggr_idx];
+						int aggr_nr = 0;
+						if (evsel->stats && evsel->stats->aggr) {
+							aggr_nr =
+								evsel->stats->aggr[ev->aggr_idx].nr;
+						}
+						print_aggr_id_std(config, out, evsel, id, aggr_nr);
+					}
+					fprintf(out, "%*s# ",
+						COUNTS_LEN + EVNAME_LEN + config->unit_width + 3,
+						"");
+				} else {
+					fprintf(out, " # ");
+				}
+				first = false;
+			} else {
+				/* Align subsequent metric lines */
+				fprintf(out, "\n");
+				if (config->interval && ps->timestamp[0])
+					fprintf(out, "%s", ps->timestamp);
+				if (config->aggr_map && ev->aggr_idx >= 0) {
+					struct aggr_cpu_id id = config->aggr_map->map[ev->aggr_idx];
+					int aggr_nr = 0;
+					if (evsel->stats && evsel->stats->aggr) {
+						aggr_nr = evsel->stats->aggr[ev->aggr_idx].nr;
+					}
+					print_aggr_id_std(config, out, evsel, id, aggr_nr);
+				}
+				fprintf(out, "%*s# ",
+					COUNTS_LEN + EVNAME_LEN + config->unit_width + 3, "");
+			}
+
+			if (color && color[0]) {
+				color_fprintf(out, color, m_fmt, met->val);
+			} else {
+				fprintf(out, m_fmt, met->val);
+			}
+			/* Print the metric unit and name left-aligned padded to METRIC_LEN - n - 1 = 26 */
+			fprintf(out, " %-26s", unit_name);
+
+			/* If this is the last metric in the list, print noise and multiplexing percentage */
+			if (list_is_last(&met->list, &ev->metrics_list)) {
+				if (ev->stdev_pct)
+					fprintf(out, "  ( +-%6.2f%% )", ev->stdev_pct);
+				if (ev->run != ev->ena)
+					fprintf(out, "  (%.2f%%)", 100.0 * ev->run / ev->ena);
+			}
+
+			list_del(&met->list);
+			free(met->name);
+			free(met->unit);
+			free(met);
+		}
+		fprintf(out, "\n");
+
+		list_del(&ev->list);
+		free(ev->name);
+		free(ev);
+	}
+	print_footer_std(config);
+	return 0;
+}
+
+static const struct perf_stat_print_callbacks std_print_callbacks = {
+	.print_start = std_print_start,
+	.print_end = std_print_end,
+	.print_event = std_print_event,
+	.print_metric = std_print_metric,
+};
+
+/*
+ * Standard (STD) Output Callbacks - Metric-Only Mode
+ */
+
+static int std_metric_only_print_start(void *ctx,
+				       const struct perf_stat_config *config __maybe_unused)
+{
+	struct std_metric_only_print_state *ps = ctx;
+	INIT_LIST_HEAD(&ps->queued_metrics);
+	return 0;
+}
+
+static int std_metric_only_print_metric(void *ctx,
+					const struct perf_stat_config *config __maybe_unused,
+					struct evsel *evsel __maybe_unused, int aggr_idx,
+					const char *name, const char *unit, double val,
+					enum metric_threshold_classify thresh)
 {
+	struct std_metric_only_print_state *ps = ctx;
+	struct queued_metric *b = malloc(sizeof(*b));
+
+	if (!b)
+		return -ENOMEM;
+
+	b->name = strdup(name);
+	if (!b->name) {
+		free(b);
+		return -ENOMEM;
+	}
+
+	if (unit && unit[0]) {
+		b->unit = strdup(unit);
+		if (!b->unit) {
+			free(b->name);
+			free(b);
+			return -ENOMEM;
+		}
+	} else {
+		b->unit = NULL;
+	}
+
+	b->val = val;
+	b->thresh = thresh;
+	b->aggr_idx = aggr_idx;
+	list_add_tail(&b->list, &ps->queued_metrics);
+
 	return 0;
 }
+
+static int std_metric_only_print_end(void *ctx, const struct perf_stat_config *config)
+{
+	struct std_metric_only_print_state *ps = ctx;
+	struct queued_metric *b, *tmp;
+	FILE *out = ps->fp;
+	int first_aggr = -1;
+	int current_aggr = -1;
+	const char *color;
+	char *str;
+	int mlen;
+	int ret = 0;
+	int err;
+
+	if (list_empty(&ps->queued_metrics))
+		return 0;
+
+	/* Print the formatted header prefix */
+	if (!config->interval)
+		print_header_std(config, ps->target, ps->argc, ps->argv);
+
+	first_aggr = list_first_entry(&ps->queued_metrics, struct queued_metric, list)->aggr_idx;
+
+	/* Print headers */
+	list_for_each_entry(b, &ps->queued_metrics, list) {
+		if (b->aggr_idx == first_aggr) {
+			char *header_name;
+			if (b->unit && b->unit[0]) {
+				err = asprintf(&header_name, "%s  %s", b->unit, b->name);
+			} else {
+				header_name = strdup(b->name);
+				err = header_name ? 0 : -1;
+			}
+			if (err < 0) {
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+			fprintf(out, "%*s ", config->metric_only_len, header_name);
+			free(header_name);
+		}
+	}
+	fprintf(out, "\n\n");
+
+	/* Print values */
+	list_for_each_entry_safe(b, tmp, &ps->queued_metrics, list) {
+		if (b->aggr_idx != current_aggr) {
+			if (current_aggr != -1)
+				fprintf(out, "\n");
+			current_aggr = b->aggr_idx;
+			if (config->interval && ps->timestamp[0])
+				fprintf(out, "%s", ps->timestamp);
+		}
+		color = metric_threshold_classify__color(b->thresh);
+		mlen = config->metric_only_len;
+
+		if (color && color[0]) {
+			err = asprintf(&str, "%s%.1f%s", color, b->val, PERF_COLOR_RESET);
+			mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
+		} else {
+			err = asprintf(&str, "%.1f", b->val);
+		}
+		if (err < 0) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		fprintf(out, "%*s ", mlen, str);
+		free(str);
+
+		list_del(&b->list);
+		free(b->name);
+		free(b->unit);
+		free(b);
+	}
+	print_footer_std(config);
+	return 0;
+
+cleanup:
+	list_for_each_entry_safe(b, tmp, &ps->queued_metrics, list) {
+		list_del(&b->list);
+		free(b->name);
+		free(b->unit);
+		free(b);
+	}
+	return ret;
+}
+
+static const struct perf_stat_print_callbacks std_metric_only_print_callbacks = {
+	.print_start = std_metric_only_print_start,
+	.print_end = std_metric_only_print_end,
+	.print_event = NULL,
+	.print_metric = std_metric_only_print_metric,
+};
+
+int perf_stat__print_std(struct evlist *evlist, const struct perf_stat_config *config,
+			 const struct target *target, const struct timespec *ts, int argc,
+			 const char **argv)
+{
+	struct std_print_state ps = {
+		.fp = config->output,
+		.target = target,
+		.argc = argc,
+		.argv = argv,
+	};
+
+	if (config->metric_only) {
+		struct std_metric_only_print_state mops = {
+			.fp = config->output,
+			.target = target,
+			.argc = argc,
+			.argv = argv,
+		};
+		if (config->interval && ts) {
+			scnprintf(mops.timestamp, sizeof(mops.timestamp), "%6lu.%09lu ",
+				  (unsigned long)ts->tv_sec, ts->tv_nsec);
+		} else {
+			mops.timestamp[0] = '\0';
+		}
+		return perf_stat__print_cb(evlist, config, target, ts, argc, argv,
+					   &std_metric_only_print_callbacks, &mops);
+	} else {
+		if (config->interval && ts) {
+			scnprintf(ps.timestamp, sizeof(ps.timestamp), "%6lu.%09lu ",
+				  (unsigned long)ts->tv_sec, ts->tv_nsec);
+		} else {
+			ps.timestamp[0] = '\0';
+		}
+		return perf_stat__print_cb(evlist, config, target, ts, argc, argv,
+					   &std_print_callbacks, &ps);
+	}
+}
-- 
2.54.0.794.g4f17f83d09-goog

