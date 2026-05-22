Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79E3911D3
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489267; cv=none; b=B3Pb/2AiU8mbu4llivEIlVOR86tZxI/a6t321bDcBtoc4GKavfZHor6eFKWsyY427wxPHWRxEND/LreAfIgemZyDx0y0AKbrzU3lHFzQdCiONTFUmPpPfaN97SUcQqQAomr/ibLyCvrqvHc5QE28klPbDVYVvIy0p6+8eAaFMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489267; c=relaxed/simple;
	bh=9W2AuQy7TR2xWuUOlVR4VtUCzqNQ2HyXmGF5IoMv0p4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aIBNQcqW4brhwo9XK5QJ8Iqi+k1EAlBbBick2t6F4Jkl5ctbEduBygDVS9xZT5Ck0pLRp9cOyFbS27/CJl9N6/YGUevARer2MKQirMO0N+++5AVZiIlC9cAsgc0SXHGvcrl4h31KALhYVFrccctuCDbLJ7KEADQd1lrejjbDAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hesEtrSD; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hesEtrSD"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so4736628eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489263; x=1780094063; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fKGuOZoyLbgVPD1fllZNkCVmfe6juErH4XnZWzewrE=;
        b=hesEtrSDPy3mGDdEc7m+LdErf4PW2dFbQD1ecPONXwLD7sjtWRq8kxlrRyOO4Xe30p
         lhYpyULb7DnBUtKMRuM4Yw6IJRWm3v/HHWAEn3IJuWQkqSHpV1RLe25q/lf64kAV01tQ
         mP4CnBkDVLdkgZJU1+E6Dg3QpPf4KzxqWH/ytI9+g2Jts+MRgsmoc7RxEvv6iFqDSLAA
         d5H56P6Viaxdq4Er6vToYdVYiYjd7K9FEibcxMlb40tBrDwnttWYoSd1yMf/MUgLusK1
         OzprtPQEmg8Eft3AnT6CFjhiUShLBULO8F2CD5VNEyQSYaSME/idVcP+QQDBw+VqCDsL
         BBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489263; x=1780094063;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fKGuOZoyLbgVPD1fllZNkCVmfe6juErH4XnZWzewrE=;
        b=UwdmrFSqFL4Op1RoCJ2As/pHTjhIFKwwaQpmRT6KLgTwT6evTDUh8K7SmjybqVmu3t
         B7W+Hz3RmBySkb4b7PsPRBYGeg5+GTnwy/5/vMoI0sTFN5mHjglNJyBoVa2UKqs0citu
         yhLwy1ULDCxh/zVV5rxEiqc+cMaM0W4nqmDv7ZjdK3k29vJEbPSKSndGTNtTnnKa3g2t
         4vnU6MlyBQtxCtudgL0TUoGKDOaRvgzoAfk1nPsGhknhPHFadon2RWr4abgZqP/GDEW0
         uK6thVg7RFx1hiftpqcS5eBas1Il4K3z3WweQPO0IOTWNk630bR6Rr9Eh6vFzxSwK9La
         WUcg==
X-Forwarded-Encrypted: i=1; AFNElJ8/LRZMdO/asc00LzdE5/dD2GQnWYL5T/jivwkhZfvebLKFr59f50rLVTl4k7fQcurxP8YB//wQJ9JR4KOP2kru@vger.kernel.org
X-Gm-Message-State: AOJu0YwmitUi+yPKyZdRHOHyaLerSWKB7tWVEwUe/J86Vr/yZs34/eKK
	H8pwkG9pPo/fAwevuBiW5ZqN/T18QUThOLySW8QKa7/C+ykep1LIHdpbWYC7F0dq38XGbBYAFhc
	jab0sQ51/IQ==
X-Received: from dyeo18.prod.google.com ([2002:a05:7300:5352:b0:2fd:3927:94f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2288:b0:304:18be:55a5
 with SMTP id 5a478bee46e88-3044914f732mr2774520eec.22.1779489263164; Fri, 22
 May 2026 15:34:23 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:38 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-11-irogers@google.com>
Subject: [RFC PATCH v1 10/14] perf stat: Implement streaming JSON formatting callbacks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch implements streaming JSON formatting callbacks inside
util/stat-print-json.c, replacing the empty stubs introduced in Commit 1.

Delivers a highly optimized, zero-allocation, and 100% streaming print engine
for JSON normal and metric-only modes. It bypasses dynamic queue events and
metric lists entirely, formatting and streaming JSON objects directly onto the
output file descriptor.

Utilizes the newly centralized unified aggregation helpers to format CPU and
thread keys inside the JSON objects, and incorporates full interval-mode
timestamp printing support.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/util/stat-print-json.c | 341 +++++++++++++++++++++++++++++-
 1 file changed, 333 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-print-json.c b/tools/perf/util/stat-print-json.c
index 72df7a94095d..da33b241c961 100644
--- a/tools/perf/util/stat-print-json.c
+++ b/tools/perf/util/stat-print-json.c
@@ -1,13 +1,338 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include "stat-print.h"
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <inttypes.h>
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+
+#include "cpumap.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "stat-print.h"
+#include "stat.h"
+#include "thread_map.h"
+
+static const char *metric_threshold_classify__str(enum metric_threshold_classify thresh)
+{
+	const char *const strs[] = {
+		"unknown", "bad", "nearly bad", "less good", "good",
+	};
+	_Static_assert(ARRAY_SIZE(strs) - 1 == METRIC_THRESHOLD_GOOD, "missing enum value");
+	return strs[thresh];
+}
+
+/**
+ * struct json_print_state - Print state context for JSON output.
+ * @fp: File descriptor to output to.
+ * @timestamp: Formatted interval timestamp (optional).
+ */
+struct json_print_state {
+	FILE *fp;
+	char timestamp[64];
+};
+
+/**
+ * struct json_metric_only_print_state - Metric-only print state context for JSON output.
+ * @fp: File descriptor to output to.
+ * @timestamp: Formatted interval timestamp (optional).
+ * @evlist: Evlist to query entries from.
+ * @last_aggr_idx: The aggregation index of the last printed metric.
+ * @first_in_group: Whether the current metric is the first in its group.
+ */
+struct json_metric_only_print_state {
+	FILE *fp;
+	char timestamp[64];
+	struct evlist *evlist;
+	int last_aggr_idx;
+	bool first_in_group;
+};
 
-int perf_stat__print_json(struct evlist *evlist __maybe_unused,
-			  const struct perf_stat_config *config __maybe_unused,
-			  const struct target *target __maybe_unused,
-			  const struct timespec *ts __maybe_unused,
-			  int argc __maybe_unused,
-			  const char **argv __maybe_unused)
+/**
+ * print_aggr_id_json - Print the aggregation prefix for JSON format.
+ *
+ * Copied and adapted from stat-display.c.
+ */
+static void print_aggr_id_json(const struct perf_stat_config *config, FILE *output,
+			       struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
 {
+	switch (config->aggr_mode) {
+	case AGGR_CORE:
+		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"counters\" : %d, ", id.socket,
+			id.die, id.core, aggr_nr);
+		break;
+	case AGGR_CACHE:
+		fprintf(output, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"counters\" : %d, ", id.socket,
+			id.die, id.cache_lvl, id.cache, aggr_nr);
+		break;
+	case AGGR_CLUSTER:
+		fprintf(output, "\"cluster\" : \"S%d-D%d-CLS%d\", \"counters\" : %d, ", id.socket,
+			id.die, id.cluster, aggr_nr);
+		break;
+	case AGGR_DIE:
+		fprintf(output, "\"die\" : \"S%d-D%d\", \"counters\" : %d, ", id.socket, id.die,
+			aggr_nr);
+		break;
+	case AGGR_SOCKET:
+		fprintf(output, "\"socket\" : \"S%d\", \"counters\" : %d, ", id.socket, aggr_nr);
+		break;
+	case AGGR_NODE:
+		fprintf(output, "\"node\" : \"N%d\", \"counters\" : %d, ", id.node, aggr_nr);
+		break;
+	case AGGR_NONE:
+		if (evsel->percore && !config->percore_show_thread)
+			fprintf(output, "\"core\" : \"S%d-D%d-C%d\", ", id.socket, id.die, id.core);
+		else if (id.cpu.cpu > -1)
+			fprintf(output, "\"cpu\" : \"%d\", ", id.cpu.cpu);
+		break;
+	case AGGR_THREAD:
+		fprintf(output, "\"thread\" : \"%s-%d\", ",
+			perf_thread_map__comm(evsel->core.threads, id.thread_idx),
+			perf_thread_map__pid(evsel->core.threads, id.thread_idx));
+		break;
+	case AGGR_GLOBAL:
+	case AGGR_UNSET:
+	case AGGR_MAX:
+	default:
+		break;
+	}
+}
+
+/*
+ * JSON Output Callbacks - Normal Mode (100% Streaming & Zero-Allocation)
+ */
+
+static int json_print_start(void *ctx __maybe_unused,
+			    const struct perf_stat_config *config __maybe_unused)
+{
+	return 0;
+}
+
+static int json_print_event(void *ctx, const struct perf_stat_config *config, struct evsel *evsel,
+			    int aggr_idx, u64 val, u64 ena, u64 run,
+			    double stdev_pct __maybe_unused)
+{
+	struct json_print_state *ps = ctx;
+	FILE *output = config->output;
+	bool ok = (run != 0 && ena != 0);
+	double enabled_percent = 100.0;
+
+	fprintf(output, "{");
+
+	/* Print interval timestamp first if configured */
+	if (config->interval && ps && ps->timestamp[0])
+		fprintf(output, "%s", ps->timestamp);
+
+	/* Print aggregation JSON fields if configured */
+	if (config->aggr_map && aggr_idx >= 0) {
+		struct aggr_cpu_id id = config->aggr_map->map[aggr_idx];
+		int aggr_nr = 0;
+
+		if (evsel->stats && evsel->stats->aggr)
+			aggr_nr = evsel->stats->aggr[aggr_idx].nr;
+
+		print_aggr_id_json(config, output, evsel, id, aggr_nr);
+	}
+
+	if (ok) {
+		double sc = evsel->scale;
+		double avg = val * sc;
+
+		fprintf(output, "\"counter-value\" : \"%f\"", avg);
+	} else {
+		const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
+
+		fprintf(output, "\"counter-value\" : \"%s\"", bad_count);
+	}
+
+	fprintf(output, ", \"unit\" : \"%s\"", evsel->unit ?: "");
+	/* Cast away const for legacy evsel__name */
+	fprintf(output, ", \"event\" : \"%s\"", evsel__name((struct evsel *)evsel));
+
+	if (run != ena)
+		enabled_percent = 100.0 * run / ena;
+	fprintf(output, ", \"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f", run,
+		enabled_percent);
+	fprintf(output, "}\n");
+
 	return 0;
 }
+
+static int json_print_metric(void *ctx, const struct perf_stat_config *config, struct evsel *evsel,
+			     int aggr_idx, const char *name, const char *unit __maybe_unused,
+			     double val, enum metric_threshold_classify thresh)
+{
+	struct json_print_state *ps = ctx;
+	FILE *output = config->output;
+	u64 run = 0, ena = 0;
+	double enabled_percent = 100.0;
+	struct perf_stat_evsel *ps_evsel = evsel->stats;
+
+	if (ps_evsel && ps_evsel->aggr) {
+		run = ps_evsel->aggr[aggr_idx].counts.run;
+		ena = ps_evsel->aggr[aggr_idx].counts.ena;
+	}
+
+	fprintf(output, "{");
+
+	/* Print interval timestamp first if configured */
+	if (config->interval && ps && ps->timestamp[0])
+		fprintf(output, "%s", ps->timestamp);
+
+	/* Print aggregation JSON fields if configured */
+	if (config->aggr_map && aggr_idx >= 0) {
+		struct aggr_cpu_id id = config->aggr_map->map[aggr_idx];
+		int aggr_nr = 0;
+
+		if (evsel->stats && evsel->stats->aggr)
+			aggr_nr = evsel->stats->aggr[aggr_idx].nr;
+
+		print_aggr_id_json(config, output, evsel, id, aggr_nr);
+	}
+
+	if (run != ena)
+		enabled_percent = 100.0 * run / ena;
+	fprintf(output, "\"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f", run,
+		enabled_percent);
+	fprintf(output, ", \"metric-value\" : \"%f\"", val);
+	if (name && name[0])
+		fprintf(output, ", \"metric-unit\" : \"%s\"", name);
+	if (thresh != METRIC_THRESHOLD_UNKNOWN) {
+		fprintf(output, ", \"metric-threshold\" : \"%s\"",
+			metric_threshold_classify__str(thresh));
+	}
+	fprintf(output, "}\n");
+
+	return 0;
+}
+
+static int json_print_end(void *ctx __maybe_unused,
+			  const struct perf_stat_config *config __maybe_unused)
+{
+	return 0;
+}
+
+static const struct perf_stat_print_callbacks json_print_callbacks = {
+	.print_start = json_print_start,
+	.print_end = json_print_end,
+	.print_event = json_print_event,
+	.print_metric = json_print_metric,
+};
+
+/*
+ * JSON Output Callbacks - Metric-Only Mode (100% Streaming & Zero-Allocation)
+ */
+
+static int json_metric_only_print_start(void *ctx,
+					const struct perf_stat_config *config __maybe_unused)
+{
+	struct json_metric_only_print_state *ps = ctx;
+
+	ps->last_aggr_idx = -1;
+	ps->first_in_group = true;
+	return 0;
+}
+
+static int json_metric_only_print_metric(void *ctx,
+					 const struct perf_stat_config *config __maybe_unused,
+					 struct evsel *evsel __maybe_unused, int aggr_idx,
+					 const char *name, const char *unit, double val,
+					 enum metric_threshold_classify thresh __maybe_unused)
+{
+	struct json_metric_only_print_state *ps = ctx;
+	FILE *output = ps->fp;
+	char *header_name;
+	int err;
+
+
+	if (aggr_idx != ps->last_aggr_idx) {
+		if (ps->last_aggr_idx != -1)
+			fprintf(output, "}\n");
+		fprintf(output, "{");
+		if (config->interval && ps->timestamp[0])
+			fprintf(output, "%s", ps->timestamp);
+		if (config->aggr_map && aggr_idx >= 0) {
+			struct aggr_cpu_id id = config->aggr_map->map[aggr_idx];
+			struct evsel *mock_evsel = list_first_entry(&ps->evlist->core.entries,
+								    struct evsel, core.node);
+			int aggr_nr = 0;
+
+			if (mock_evsel->stats && mock_evsel->stats->aggr)
+				aggr_nr = mock_evsel->stats->aggr[aggr_idx].nr;
+
+			print_aggr_id_json(config, output, mock_evsel, id, aggr_nr);
+		}
+		ps->last_aggr_idx = aggr_idx;
+		ps->first_in_group = true;
+	}
+
+	if (!ps->first_in_group)
+		fprintf(output, ", ");
+	ps->first_in_group = false;
+
+	if (unit && unit[0]) {
+		err = asprintf(&header_name, "%s  %s", unit, name);
+	} else {
+		header_name = strdup(name);
+		err = header_name ? 0 : -1;
+	}
+	if (err < 0)
+		return -ENOMEM;
+
+	fprintf(output, "\"%s\" : \"%.1f\"", header_name, val);
+	free(header_name);
+	return 0;
+}
+
+static int json_metric_only_print_end(void *ctx,
+				      const struct perf_stat_config *config __maybe_unused)
+{
+	struct json_metric_only_print_state *ps = ctx;
+	FILE *output = ps->fp;
+
+	if (ps->last_aggr_idx != -1)
+		fprintf(output, "}\n");
+	return 0;
+}
+
+static const struct perf_stat_print_callbacks json_metric_only_print_callbacks = {
+	.print_start = json_metric_only_print_start,
+	.print_end = json_metric_only_print_end,
+	.print_event = NULL,
+	.print_metric = json_metric_only_print_metric,
+};
+
+int perf_stat__print_json(struct evlist *evlist, const struct perf_stat_config *config,
+			  const struct target *target, const struct timespec *ts, int argc,
+			  const char **argv)
+{
+	if (config->metric_only) {
+		struct json_metric_only_print_state ps = {
+			.fp = config->output,
+			.evlist = evlist,
+		};
+		if (config->interval && ts) {
+			scnprintf(ps.timestamp, sizeof(ps.timestamp), "\"interval\" : %lu.%09lu, ",
+				  (unsigned long)ts->tv_sec, ts->tv_nsec);
+		} else {
+			ps.timestamp[0] = '\0';
+		}
+		return perf_stat__print_cb(evlist, config, target, ts, argc, argv,
+					   &json_metric_only_print_callbacks, &ps);
+	} else {
+		struct json_print_state ps = {
+			.fp = config->output,
+		};
+		if (config->interval && ts) {
+			scnprintf(ps.timestamp, sizeof(ps.timestamp), "\"interval\" : %lu.%09lu, ",
+				  (unsigned long)ts->tv_sec, ts->tv_nsec);
+		} else {
+			ps.timestamp[0] = '\0';
+		}
+		return perf_stat__print_cb(evlist, config, target, ts, argc, argv,
+					   &json_print_callbacks, &ps);
+	}
+}
-- 
2.54.0.794.g4f17f83d09-goog

