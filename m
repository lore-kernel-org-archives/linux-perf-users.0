Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531238C402
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185413; cv=none; b=faIKPW4vIpd9pZ2YqMyXcdenz9bTLJxltAspvZjWDQR3+cVU9EGnTyZavj1uaDTHbeEWVW85hphLSGPIfrVKBiCfqA8axFwCG/lOnhIf93RuSJST10M5z4LDhhFFqpKbzZrOu3VUKphEVa7VvdTp166yFikBH5m8AQszm3pVmCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185413; c=relaxed/simple;
	bh=PhANDbGWND/DrXbk580KY77RKwTd4rvJ06CKfQYVGoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R/vfw+lva9pyBXf1MwPUDb8BMRLjLo5bLXR7eGvUUffvvAe+vdujMgqCwnMohZ21bpQmmZ+voMVQbDEjND6R+PMPsIo0yGm8WU7QByIReD1f9O7pUXqcUquRlXBslNtf/Ijpj6TnYZtH87eKM6HE1JhHUhIoNbTRuzK2qxS7p7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWVTYYsS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWVTYYsS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso15055661a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185412; x=1784790212; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HwO/sP+rhydtkKNqO7NSv33UrBaqJY5nVaNGEQvI3j0=;
        b=IWVTYYsSG6cdX+KL7BI3RgSeUbBfsUGdEYGHuaDimKInKHrlL+0uNEg87h75n/BuPW
         oy05stTHceyJ+cSHvkyr/hGV2ycxy43Qd1xRPN9PSU56SaPSrnTqpcYQou+B6mvO/14a
         68qGi8hyHkyUr/dwrLi6RJ4Lqihlh6wCgIRkbKlXUyF+VLUcLKmjoLxwDCYC1wh2wQjy
         ahQU0GFNW6jSIsP89+Nqw6W8dYq7+Cm5Ybn+y3/K+V8ILqyVaWEyXb+VBG2JKUNbRcKi
         liTSsoPfwIcFpUc6OLbms8XSxlZOGX08ebnCORTDiznvzTnCTJIRQZn3TU1Xz2bxQInJ
         Ofaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185412; x=1784790212;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HwO/sP+rhydtkKNqO7NSv33UrBaqJY5nVaNGEQvI3j0=;
        b=ICo9tm5CqtWU2iK+ZsfuVi1gIpAzFY20oZU3ETJkRg/R9GBy/rdhGHSqV45uI7yyQK
         CYl3B8/op08tAVQSn7qzv6sTRSG+5QFs2PZ3PDjyQuFx1YISwf4ukhrMGZMIpZE4whPd
         O2i3mF6TVA+rM8TxZN/AivCMs+6hVyfH2qJatEY38858h4cA0LowhL433NzL1S/mFSgB
         j5JuP4hCBBRpNO0T3jQ++5tdJFpKpJxeS/Qkm9bhs4mOqmhwuDd21cdLE5jL7LcrLesd
         eW1qluNis/VZEYDJsG/OxvdWFIq2MQX7ultRq5Z7sdXEzPi/EqLHli8vh665sZsftaMm
         j8cA==
X-Forwarded-Encrypted: i=1; AHgh+RrR1T6/6mB7esCwCdwPw4dFUvaktv/uBpp9FQiOFxj6W2CAv7egJ78GBIMx/y51ROO6Eg4U7//KmpY8gavCQkbv@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrarFEHnZl3J4HpOumXSlRXTfS0aHSVusaiDf7FIzanGboeQP
	HHo49lT3uJ9bRgffu5Bn02mg3geWhRQScH4+sSMyx10H3yxJFuc+/gP2UXs4e7UqRhzJp/9Gx8S
	ZC7THpoP1uw==
X-Received: from dlbut12.prod.google.com ([2002:a05:7022:7e0c:b0:13b:9d65:a542])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6705:b0:3c3:8ce8:1fd
 with SMTP id adf61e73a8af0-3c38ce8075amr1824909637.73.1784185411403; Thu, 16
 Jul 2026 00:03:31 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:02:59 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-11-irogers@google.com>
Subject: [PATCH v4 10/14] perf stat: Implement streaming JSON formatting callbacks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch implements streaming JSON formatting callbacks inside
util/stat-print-json.c, replacing the empty stubs introduced in Commit
1.

Delivers a highly optimized, zero-allocation, and 100% streaming print
engine for JSON normal and metric-only modes. It bypasses dynamic queue
events and metric lists entirely, formatting and streaming JSON objects
directly onto the output file descriptor.

Utilizes the newly centralized unified aggregation helpers to format CPU
and thread keys inside the JSON objects, and incorporates full
interval-mode timestamp printing support.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/stat-print-json.c | 340 +++++++++++++++++++++++++++++-
 1 file changed, 333 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-print-json.c b/tools/perf/util/stat-print-json.c
index 4690c4286fd2..7ed00aae89f4 100644
--- a/tools/perf/util/stat-print-json.c
+++ b/tools/perf/util/stat-print-json.c
@@ -1,13 +1,339 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "stat-print.h"
+#include <errno.h>
+#include <inttypes.h>
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <time.h>
+#include <stdbool.h>
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
+			    struct perf_stat_config *config __maybe_unused)
+{
+	return 0;
+}
+
+static int json_print_event(void *ctx, struct perf_stat_config *config,
+			    struct evsel *evsel, int aggr_idx, u64 val,
+			    u64 ena, u64 run, double stdev_pct __maybe_unused,
+			    const char *cgrp __maybe_unused)
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
+static int json_print_metric(void *ctx, struct perf_stat_config *config,
+			     struct evsel *evsel, int aggr_idx,
+			     const char *name, const char *unit, double val,
+			     enum metric_threshold_classify thresh)
+{
+	struct json_print_state *ps = ctx;
+	FILE *output = config->output;
+	u64 run = 0, ena = 0;
+	double enabled_percent = 100.0;
+	struct perf_stat_evsel *ps_evsel = evsel->stats;
+
+	if (ps_evsel && ps_evsel->aggr && aggr_idx >= 0 &&
+	    aggr_idx < ps_evsel->nr_aggr) {
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
+	if (unit && unit[0] && name && name[0])
+		fprintf(output, ", \"metric-unit\" : \"%s  %s\"", unit, name);
+	else if (name && name[0])
+		fprintf(output, ", \"metric-unit\" : \"%s\"", name);
+	else if (unit && unit[0])
+		fprintf(output, ", \"metric-unit\" : \"%s\"", unit);
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
+			  struct perf_stat_config *config __maybe_unused)
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
+					struct perf_stat_config *config __maybe_unused)
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
+					 struct perf_stat_config *config __maybe_unused,
+					 struct evsel *evsel, int aggr_idx,
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
+		if (config->aggr_map && aggr_idx >= 0 &&
+		    aggr_idx < config->aggr_map->nr) {
+			struct aggr_cpu_id id = config->aggr_map->map[aggr_idx];
+			int aggr_nr = 0;
+
+			if (evsel && evsel->stats && evsel->stats->aggr &&
+			    aggr_idx < evsel->stats->nr_aggr)
+				aggr_nr = evsel->stats->aggr[aggr_idx].nr;
+
+			print_aggr_id_json(config, output, evsel, id, aggr_nr);
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
+				      struct perf_stat_config *config __maybe_unused)
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
+int perf_stat__print_json(struct evlist *evlist, struct perf_stat_config *config,
+			  const struct target *target, const struct timespec *ts,
+			  int argc, const char **argv)
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
2.55.0.141.g00534a21ce-goog

