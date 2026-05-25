Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3529368D42
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751174; cv=none; b=hNNtnLqrFnYDgt7Uiziu1IiKdNUp5XNVab68pNSACsbjDVHGjEsNzDF0OK4k4c924SvQsNjk5ZjhApVDNYsriBOSZ0y2AloajO8BSkesRbYNCQpmfeJ6L9/gHhQWj7pS+dlpTSPiwyqtWxjYIDzNRjyjRcpEJ3/DIt7R2xYlJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751174; c=relaxed/simple;
	bh=UpO1gaEZ2KS8z0UYLzPd3sSYWFgNZ9Kaf057qRhpFV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W4AdZFZPBqmy3a6nz4X3pX/+wo1u2oLv16tnQ6Ij7e9R1AV0HL4qhq77txqQfU015OWt1prrjA2Y+yDLAIuvp0CErtwxt9VckaV1Z5GgJxzWI1lal+LXOcGWSfrPanrteVp6o6OkjqQwupfc6ES8EF0KyQhoGJPW4PTlyEt3Xsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sERoZICa; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sERoZICa"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee34588671so10990841eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751172; x=1780355972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8Hnr9DfV8xYtjeCIEgx34YHn89jhF6OWLrXqsen2mg=;
        b=sERoZICadTi8fnUENbbDcZzZCZ96a2dYnTwvmoK5LzuwNWYYZfnuKxH2sOVgTOmx+U
         uG5ZjToLV5ANt9vGZ6fRz24HiT+5yN0CmRTeNKFN2DBBKBSvozh3GFaYzNCGn9wgrP44
         7bO5WjxFgDMzMru2LnnmjRM81zP87nfMFPa6XIzrNv8nKMYguZjwJZ5luU0tfwwlmQnF
         7DCA+gRAEl2KwiHfmDh09gR1BcxfcLUtenZZBbArYQOpyJ4nymlVf4P1G6pfXED4MjSw
         B2WBk3jNXBEe5jDGPi0kDrmqg72g0Rv6DtV7D4/T5kR5ENuHnvCpeq1tj5onkBc6Ey3h
         UjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751172; x=1780355972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8Hnr9DfV8xYtjeCIEgx34YHn89jhF6OWLrXqsen2mg=;
        b=QNt0S7yRNfii9ZjuVYzqfivqToE5PxkkRgJPT4udd9xx+jhJLgxLTRIT9c3mkFFPOf
         SLBjEfI3xFG1A8D3KqGN/SwljIklYXAuxz1Oc8tVv9520cXs0Wg8IQoqzTTVPlynSDaA
         Yv4mdJvgK1zmuPTFZsCZ/2LWnckwWsZso5ohhDdTPU2egIfUe9kt7e/JngAt4W19RgBl
         +DEYKLekmMS5B/V2HhXgCcjgLS4ug1G6se+XfP2lX/xPtpfK6fM6REvxRs/EJTIDxf9P
         6dVmiTPez1iBcTaYNTUaWueMzVTMmT/h7tpbC7SuYmU58dAY5ZwHYJ9KUoFHfOv6wDyi
         mRog==
X-Forwarded-Encrypted: i=1; AFNElJ/eNBbB7cwILCub2IEu8y1Wguy+jEOnCgMKoYWV0VKfcKWg6VQJQKdNa+sCQ62wW0jVYXignDtKJgCXGyZl62Sg@vger.kernel.org
X-Gm-Message-State: AOJu0YwoIS9xcyMAHDkmIvaWcudSC6+BFVw+6KZuxV4DLrieQrffU8yK
	Uc6piquamxsGEpw+RDot0rpyqL0Psr9BWQxGHtDqdBfJ23zKQsis47yQnVCz3Fw0VB8lCoZTqhc
	oLQxb7l7CSw==
X-Received: from dybux5.prod.google.com ([2002:a05:7301:5005:b0:2f2:3f95:c586])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e605:b0:2d4:94cc:eebb
 with SMTP id 5a478bee46e88-30449001e3bmr7127132eec.13.1779751171638; Mon, 25
 May 2026 16:19:31 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:56 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-11-irogers@google.com>
Subject: [RFC PATCH v2 10/14] perf stat: Implement streaming JSON formatting callbacks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/util/stat-print-json.c | 333 +++++++++++++++++++++++++++++-
 1 file changed, 325 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-print-json.c b/tools/perf/util/stat-print-json.c
index 72df7a94095d..f168dca70ee0 100644
--- a/tools/perf/util/stat-print-json.c
+++ b/tools/perf/util/stat-print-json.c
@@ -1,13 +1,330 @@
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
+
+/**
+ * print_aggr_id_json - Print the aggregation prefix for JSON format.
+ *
+ * Copied and adapted from stat-display.c.
+ */
+static void print_aggr_id_json(const struct perf_stat_config *config, FILE *output,
+			       struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
+{
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
+	return 0;
+}
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
 
-int perf_stat__print_json(struct evlist *evlist __maybe_unused,
-			  const struct perf_stat_config *config __maybe_unused,
-			  const struct target *target __maybe_unused,
-			  const struct timespec *ts __maybe_unused,
-			  int argc __maybe_unused,
-			  const char **argv __maybe_unused)
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
 {
 	return 0;
 }
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
+	/* Initialize to -2 to distinguish from -1 (a valid index in AGGR_GLOBAL mode) */
+	ps->last_aggr_idx = -2;
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
+
+
+	if (aggr_idx != ps->last_aggr_idx) {
+		if (ps->last_aggr_idx != -2)
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
+	if (unit && unit[0])
+		fprintf(output, "\"%s  %s\" : \"%.1f\"", unit, name, val);
+	else
+		fprintf(output, "\"%s\" : \"%.1f\"", name, val);
+	return 0;
+}
+
+static int json_metric_only_print_end(void *ctx,
+				      const struct perf_stat_config *config __maybe_unused)
+{
+	struct json_metric_only_print_state *ps = ctx;
+	FILE *output = ps->fp;
+
+	if (ps->last_aggr_idx != -2)
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

