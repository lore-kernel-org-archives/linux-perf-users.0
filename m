Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B83876BB
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176394; cv=none; b=g2rFZELnIGk3Xcz9kOBdHIlKc5hJjXGoGsRIiLaIhcdKKzgInc6lzYCJCNITH/7JTY85lan38CaSf57A5nNjES6FkBFzNf6gS3iv6PQzNg4fbbrTuzaDi7Bfs20IUo7x68PQayN0bAbwrYwfzApwp68lUafccjqtu6EeqbiWEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176394; c=relaxed/simple;
	bh=7NG3Bdscz/VsB7Q9lzcB4ue8bbyP7NoLsT9Utsud4/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pinR4eqIrRD0NiKshBaVK97+8YyJtHcfH08KgYFfnby1K8l4Az7Fp8KXehgnDghRGG6PpWIdBJ93xmIkvU94t5d2Gx+ONl2sOHufS/XcKzMpZFD4N/ZggAx8QHwGyQx+uFtN+xfH05CyMJ64zLi6+zPHHMiZi1EMS2Is3E5Zrac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZCwLzMA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZCwLzMA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so9049876a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176390; x=1784781190; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sq/4iQ48wRC89XmU0lzntzZ6QgO63vZ7PoiupUrpu3A=;
        b=BZCwLzMAWnC4QZLdjdcrLX7HL+U0pqXtWwSKBa9HkkHgTL30s++FtA30UwxKn6hjKF
         6U5UV2yMcdcw3A9uDUZuCXKmAgzxxdKa+SdAKY3vZVcoN+YwsgFKio2QfRRjZ5Piinja
         JjCkNCl3k71L5GRU4QjHwwasQIqR6roa4wrDv2Qfv/09TZyplIHpv9O0nzonycCG5xhu
         ZdyLEKAaVgZvlFUSdFkE2rKEmXVtxDVUOews0RdPpYour7YkEr9EqGhp8NDJ7bK/l+CK
         IGyZOYxii9RSC30VT8OqvuGJXgWb48+bzYwSVOz+XtdyNhfjsZI1FH/oWLW6o/MWut4+
         4k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176390; x=1784781190;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sq/4iQ48wRC89XmU0lzntzZ6QgO63vZ7PoiupUrpu3A=;
        b=E2PraF4zQhoXaEvwQ7Vjks/UtrGQ1ZectYCej+9mzB//oNBATTBHDoImP1eZcvS7u+
         yZEP3HV0pc2iDuJCf3HTyZds8VN+cwPna8SaqoUvf4huuOpdVwyFPTGiaDEvAmugQcPC
         FOmDdEL784JjOtl3Uu3wExi7suBQL2mGGlY3QWeuV0IaZZIhpqWzPfcbpQCiyJWyKzMQ
         eJuqZO0y3SZxlOXyr/cdHKC9ic/Sqpd/SaM4UIP6c0Gr2dbD5eAR1cDT1VoN1fTL67dB
         mxBTOA8pV17BLNQJMh7Mw4fw14mFOWf1XkE2+EjKsOoPNrru36gQlC0NXGfd6Qaj/0U1
         XGpg==
X-Forwarded-Encrypted: i=1; AHgh+Rqa+LaAXpb1bxJoRoPVhX8Pkk5AZCendNLBIlyAfHXmL2q60ZS0tCxNKSShHv4hHBV9SCYf0GCNceDiJRVWB0H/@vger.kernel.org
X-Gm-Message-State: AOJu0YyEP+F23nNGV+q6pKuxE6y1hqFpquXEBmgzOYFcB3Ky9Fc8ccuj
	farR0RLA5ZIoShTcF6cZrvqmpx8XR14WTq7x4h4iM3c2Azm2VK/setriVCW+HSjtGS9OcEShuBZ
	qw9OZ90fDAQ==
X-Received: from dlbbo4.prod.google.com ([2002:a05:7022:4384:b0:13b:2994:d65a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c6c9:b0:3bf:735d:7fb8
 with SMTP id adf61e73a8af0-3c357021bb1mr10776416637.27.1784176389834; Wed, 15
 Jul 2026 21:33:09 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:16 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-8-irogers@google.com>
Subject: [PATCH v3 07/14] perf stat: Implement CSV formatting callbacks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch implements CSV output formatting callbacks inside
util/stat-print-csv.c, replacing the empty stubs introduced in Commit 1.

Defines the format-private `struct queued_event` and `struct
queued_metric` DOM nodes to buffer traversal streams, and fully
encapsulates CSV queued lists lifecycle and deallocations inside
csv_print_start() and csv_print_end().

Utilizes the newly centralized unified aggregation helpers to format CPU
and thread column prefixes cleanly, fixes metrics separators padding,
and incorporates full interval-mode timestamp printing support.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash

Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/stat-print-csv.c | 535 ++++++++++++++++++++++++++++++-
 1 file changed, 528 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-print-csv.c b/tools/perf/util/stat-print-csv.c
index ee86d07636ea..35cd4505c6c1 100644
--- a/tools/perf/util/stat-print-csv.c
+++ b/tools/perf/util/stat-print-csv.c
@@ -1,13 +1,534 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "stat-print.h"
+#include <errno.h>
+#include <inttypes.h>
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
 #include <linux/compiler.h>
+#include <linux/list.h>
+
+#include "cpumap.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "stat-print.h"
+#include "stat.h"
+#include "thread_map.h"
+#include "debug.h"
+
+#define COMM_LEN 16
+#define PID_LEN 7
+
+struct queued_metric {
+	struct list_head list;
+	char *name;
+	char *unit;
+	double val;
+	int aggr_idx;
+};
+
+/**
+ * struct queued_event - In-memory record of a buffered CSV counter event.
+ * @list: Linked list node for queueing.
+ * @evsel: The associated performance event selector.
+ * @name: The uniquely formatted/resolved event name.
+ * @unit: The event's unit (e.g. "msec", "cycles").
+ * @val: Raw aggregated counter value.
+ * @ena: Enabled time for multiplexing percentage.
+ * @run: Running time for multiplexing percentage.
+ * @scale: Event scale factor.
+ * @supported: Event hardware support indicator.
+ * @aggr_idx: Aggregation index.
+ * @metrics_list: Linked list head containing nested queued_metric structures.
+ */
+struct queued_event {
+	struct list_head list;
+	struct evsel *evsel;
+	char *name;
+	char *unit;
+	u64 val, ena, run;
+	double scale;
+	bool supported;
+	int aggr_idx;
+	struct list_head metrics_list;
+};
+
+/**
+ * struct csv_print_state - Print state context for CSV output.
+ * @fp: File descriptor to output to.
+ * @sep: CSV column separator character/string.
+ * @timestamp: Formatted interval timestamp (optional).
+ * @events_list: Linked list head containing queued_event nodes.
+ * @current_event: Pointer to the currently active event being printed.
+ *                 Serves as a temporary bridge to associate streaming metrics back to
+ *                 their parent event node during list buffering. This relies on a
+ *                 strict temporal coupling in the traversal driver: the driver always
+ *                 invokes print_metric() callbacks for a counter synchronously and
+ *                 immediately after its print_event() callback, prior to advancing
+ *                 to the next event or aggregation node. This pointer is completely
+ *                 private to CSV printing, keeping the traversal driver decoupled
+ *                 and preserving strict encapsulation.
+ */
+struct csv_print_state {
+	FILE *fp;
+	const char *sep;
+	char timestamp[64];
+	struct list_head events_list;
+	struct queued_event *current_event;
+};
+
+/**
+ * struct csv_metric_only_print_state - Metric-only print state context for CSV output.
+ * @fp: File descriptor to output to.
+ * @sep: CSV column separator.
+ * @timestamp: Formatted interval timestamp (optional).
+ * @evlist: Evlist to query entries from.
+ * @queued_metrics: Linked list head containing queued_metric nodes.
+ */
+struct csv_metric_only_print_state {
+	FILE *fp;
+	const char *sep;
+	char timestamp[64];
+	struct evlist *evlist;
+	struct list_head queued_metrics;
+};
+
+/**
+ * print_aggr_id_csv - Print the aggregation prefix for CSV format.
+ *
+ * Copied and adapted from stat-display.c.
+ */
+static void print_aggr_id_csv(const struct perf_stat_config *config, FILE *output,
+			      struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
+{
+	const char *sep = config->csv_sep;
+
+	switch (config->aggr_mode) {
+	case AGGR_CORE:
+		fprintf(output, "S%d-D%d-C%d%s%d%s", id.socket, id.die, id.core, sep, aggr_nr, sep);
+		break;
+	case AGGR_CACHE:
+		fprintf(output, "S%d-D%d-L%d-ID%d%s%d%s", id.socket, id.die, id.cache_lvl, id.cache,
+			sep, aggr_nr, sep);
+		break;
+	case AGGR_CLUSTER:
+		fprintf(output, "S%d-D%d-CLS%d%s%d%s", id.socket, id.die, id.cluster, sep, aggr_nr,
+			sep);
+		break;
+	case AGGR_DIE:
+		fprintf(output, "S%d-D%d%s%d%s", id.socket, id.die, sep, aggr_nr, sep);
+		break;
+	case AGGR_SOCKET:
+		fprintf(output, "S%d%s%d%s", id.socket, sep, aggr_nr, sep);
+		break;
+	case AGGR_NODE:
+		fprintf(output, "N%d%s%d%s", id.node, sep, aggr_nr, sep);
+		break;
+	case AGGR_NONE:
+		if (evsel->percore && !config->percore_show_thread)
+			fprintf(output, "S%d-D%d-C%d%s", id.socket, id.die, id.core, sep);
+		else if (id.cpu.cpu > -1)
+			fprintf(output, "CPU%d%s", id.cpu.cpu, sep);
+		break;
+	case AGGR_THREAD:
+		fprintf(output, "%s-%d%s",
+			perf_thread_map__comm(evsel->core.threads, id.thread_idx),
+			perf_thread_map__pid(evsel->core.threads, id.thread_idx), sep);
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
+ * CSV Output Callbacks - Normal Mode
+ */
+
+static int csv_print_start(void *ctx, const struct perf_stat_config *config __maybe_unused)
+{
+	struct csv_print_state *ps = ctx;
+
+	INIT_LIST_HEAD(&ps->events_list);
+	ps->current_event = NULL;
+	return 0;
+}
+
+static int csv_print_event(void *ctx, const struct perf_stat_config *config __maybe_unused,
+			   struct evsel *evsel, int aggr_idx, u64 val, u64 ena, u64 run,
+			   double stdev_pct __maybe_unused)
+{
+	struct csv_print_state *ps = ctx;
+	struct queued_event *ev = malloc(sizeof(*ev));
+
+	if (!ev)
+		return -ENOMEM;
+
+	ev->name = strdup(evsel__name(evsel));
+	if (!ev->name) {
+		free(ev);
+		return -ENOMEM;
+	}
+
+	if (evsel->unit) {
+		ev->unit = strdup(evsel->unit);
+		if (!ev->unit) {
+			free(ev->name);
+			free(ev);
+			return -ENOMEM;
+		}
+	} else {
+		ev->unit = NULL;
+	}
+
+	ev->evsel = evsel;
+	ev->val = val;
+	ev->ena = ena;
+	ev->run = run;
+	ev->scale = evsel->scale;
+	ev->supported = evsel->supported;
+	ev->aggr_idx = aggr_idx;
+	INIT_LIST_HEAD(&ev->metrics_list);
+
+	list_add_tail(&ev->list, &ps->events_list);
+	ps->current_event = ev;
+
+	return 0;
+}
+
+static int csv_print_metric(void *ctx, const struct perf_stat_config *config __maybe_unused,
+			    struct evsel *evsel __maybe_unused, int aggr_idx __maybe_unused,
+			    const char *name, const char *unit, double val,
+			    enum metric_threshold_classify thresh __maybe_unused)
+{
+	struct csv_print_state *ps = ctx;
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
+	list_add_tail(&b->list, &ps->current_event->metrics_list);
+
+	return 0;
+}
+
+static int csv_print_end(void *ctx, const struct perf_stat_config *config)
+{
+	struct csv_print_state *ps = ctx;
+	struct queued_event *ev, *tmp_ev;
+	struct queued_metric *met, *tmp_met;
+	FILE *output = ps->fp;
+	const char *sep = ps->sep;
+	bool has_metrics;
+
+	list_for_each_entry_safe(ev, tmp_ev, &ps->events_list, list) {
+		struct evsel *evsel = ev->evsel;
+		bool ok = (ev->run != 0 && ev->ena != 0);
+		const char *bad_count = ev->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
+		double enabled_percent = 100;
+
+		/* Print interval timestamp first if configured */
+		if (config->interval && ps->timestamp[0])
+			fprintf(output, "%s", ps->timestamp);
+
+		/* Print aggregation prefix first in CSV normal mode */
+		if (config->aggr_map && ev->aggr_idx >= 0) {
+			struct aggr_cpu_id id = config->aggr_map->map[ev->aggr_idx];
+			int aggr_nr = 0;
+
+			if (evsel->stats && evsel->stats->aggr)
+				aggr_nr = evsel->stats->aggr[ev->aggr_idx].nr;
+
+			print_aggr_id_csv(config, output, evsel, id, aggr_nr);
+		}
 
-int perf_stat__print_csv(struct evlist *evlist __maybe_unused,
-			 const struct perf_stat_config *config __maybe_unused,
-			 const struct target *target __maybe_unused,
-			 const struct timespec *ts __maybe_unused,
-			 int argc __maybe_unused,
-			 const char **argv __maybe_unused)
+		if (ok) {
+			double sc = ev->scale;
+			double avg = ev->val * sc;
+			const char *fmt = floor(sc) != sc ? "%.2f%s" : "%.0f%s";
+
+			fprintf(output, fmt, avg, sep);
+		} else {
+			fprintf(output, "%s%s", bad_count, sep);
+		}
+
+		if (ev->unit)
+			fprintf(output, "%s%s", ev->unit, sep);
+		else
+			fprintf(output, "%s", sep);
+
+		fprintf(output, "%s", ev->name);
+
+		if (ev->run != ev->ena)
+			enabled_percent = 100.0 * ev->run / ev->ena;
+		fprintf(output, "%s%" PRIu64 "%s%.2f", sep, ev->run, sep, enabled_percent);
+
+		/* Print metrics */
+		has_metrics = false;
+		list_for_each_entry_safe(met, tmp_met, &ev->metrics_list, list) {
+			if (!has_metrics) {
+				has_metrics = true;
+			} else {
+				fprintf(output, "\n");
+				if (config->interval && ps->timestamp[0])
+					fprintf(output, "%s", ps->timestamp);
+				if (config->aggr_map && ev->aggr_idx >= 0) {
+					struct aggr_cpu_id id = config->aggr_map->map[ev->aggr_idx];
+					int aggr_nr = 0;
+
+					if (evsel->stats && evsel->stats->aggr)
+						aggr_nr = evsel->stats->aggr[ev->aggr_idx].nr;
+
+					print_aggr_id_csv(config, output, evsel, id, aggr_nr);
+				}
+				/* Subsequent metrics have exactly 4 padding separators */
+				fprintf(output, "%s%s%s%s", sep, sep, sep, sep);
+			}
+			fprintf(output, "%s%.2f%s", sep, met->val, sep);
+			if (met->name && met->name[0])
+				fprintf(output, "%s", met->name);
+
+			list_del(&met->list);
+			free(met->name);
+			free(met->unit);
+			free(met);
+		}
+		if (!has_metrics)
+			fprintf(output, "%s%s", sep, sep);
+		fprintf(output, "\n");
+
+		list_del(&ev->list);
+		free(ev->name);
+		free(ev->unit);
+		free(ev);
+	}
+	return 0;
+}
+
+static const struct perf_stat_print_callbacks csv_print_callbacks = {
+	.print_start = csv_print_start,
+	.print_end = csv_print_end,
+	.print_event = csv_print_event,
+	.print_metric = csv_print_metric,
+};
+
+/*
+ * CSV Output Callbacks - Metric-Only Mode
+ */
+
+static int csv_metric_only_print_start(void *ctx,
+				       const struct perf_stat_config *config __maybe_unused)
+{
+	struct csv_metric_only_print_state *ps = ctx;
+
+	INIT_LIST_HEAD(&ps->queued_metrics);
+	return 0;
+}
+
+static int csv_metric_only_print_metric(void *ctx,
+					const struct perf_stat_config *config __maybe_unused,
+					struct evsel *evsel __maybe_unused, int aggr_idx,
+					const char *name, const char *unit, double val,
+					enum metric_threshold_classify thresh __maybe_unused)
 {
+	struct csv_metric_only_print_state *ps = ctx;
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
+	b->aggr_idx = aggr_idx;
+	list_add_tail(&b->list, &ps->queued_metrics);
+
 	return 0;
 }
+
+static int csv_metric_only_print_end(void *ctx, const struct perf_stat_config *config)
+{
+	struct csv_metric_only_print_state *ps = ctx;
+	FILE *output = ps->fp;
+	const char *sep = ps->sep;
+	struct queued_metric *b, *tmp;
+	int first_aggr = -1;
+	/* Initialize to -2 to distinguish from -1 (a valid index in AGGR_GLOBAL mode) */
+	int current_aggr = -2;
+	int ret = 0;
+	int err;
+
+	if (list_empty(&ps->queued_metrics))
+		return 0;
+
+	first_aggr = list_first_entry(&ps->queued_metrics, struct queued_metric, list)->aggr_idx;
+
+	if (!config->metric_only_headers_printed) {
+		/* Print interval timestamp header if configured */
+		if (config->interval)
+			fprintf(output, "time%s", sep);
+
+		/* Print static aggregation prefix header in CSV metric-only mode */
+		if (config->aggr_map && first_aggr >= 0) {
+			const char *p = aggr_header_csv[config->aggr_mode];
+
+			while (*p) {
+				if (*p == ',')
+					fputs(sep, output);
+				else
+					fputc(*p, output);
+				p++;
+			}
+		}
+
+		/* Print headers */
+		list_for_each_entry(b, &ps->queued_metrics, list) {
+			if (b->aggr_idx == first_aggr) {
+				char *header_name;
+
+				if (b->unit && b->unit[0]) {
+					err = asprintf(&header_name, "%s  %s", b->unit, b->name);
+				} else {
+					header_name = strdup(b->name);
+					err = header_name ? 0 : -1;
+				}
+				if (err < 0) {
+					ret = -ENOMEM;
+					goto cleanup;
+				}
+				fprintf(output, "%s%s", header_name, sep);
+				free(header_name);
+			}
+		}
+		fprintf(output, "\n");
+		((struct perf_stat_config *)config)->metric_only_headers_printed = true;
+	}
+
+	/* Print values */
+	list_for_each_entry_safe(b, tmp, &ps->queued_metrics, list) {
+		if (b->aggr_idx != current_aggr) {
+			if (current_aggr != -2)
+				fprintf(output, "\n");
+			current_aggr = b->aggr_idx;
+			if (config->interval && ps->timestamp[0])
+				fprintf(output, "%s", ps->timestamp);
+			if (config->aggr_map && current_aggr >= 0) {
+				struct aggr_cpu_id id = config->aggr_map->map[current_aggr];
+				struct evsel *mock_evsel = list_first_entry(
+					&ps->evlist->core.entries, struct evsel, core.node);
+				int aggr_nr = 0;
+
+				if (mock_evsel->stats && mock_evsel->stats->aggr)
+					aggr_nr = mock_evsel->stats->aggr[current_aggr].nr;
+
+				print_aggr_id_csv(config, output, mock_evsel, id, aggr_nr);
+			}
+		}
+		fprintf(output, "%.1f%s", b->val, sep);
+
+		list_del(&b->list);
+		free(b->name);
+		free(b->unit);
+		free(b);
+	}
+	fprintf(output, "\n");
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
+static const struct perf_stat_print_callbacks csv_metric_only_print_callbacks = {
+	.print_start = csv_metric_only_print_start,
+	.print_end = csv_metric_only_print_end,
+	.print_event = NULL,
+	.print_metric = csv_metric_only_print_metric,
+};
+
+int perf_stat__print_csv(struct evlist *evlist, const struct perf_stat_config *config,
+			 const struct target *target, const struct timespec *ts, int argc,
+			 const char **argv)
+{
+	if (config->metric_only) {
+		struct csv_metric_only_print_state ps = {
+			.fp = config->output,
+			.sep = config->csv_sep,
+			.evlist = evlist,
+		};
+		if (config->interval && ts) {
+			scnprintf(ps.timestamp, sizeof(ps.timestamp), "%lu.%09lu%s",
+				  (unsigned long)ts->tv_sec, ts->tv_nsec, config->csv_sep);
+		} else {
+			ps.timestamp[0] = '\0';
+		}
+		return perf_stat__print_cb(evlist, config, target, ts, argc, argv,
+					   &csv_metric_only_print_callbacks, &ps);
+	} else {
+		struct csv_print_state ps = {
+			.fp = config->output,
+			.sep = config->csv_sep,
+		};
+
+
+
+		if (config->interval && ts) {
+			scnprintf(ps.timestamp, sizeof(ps.timestamp), "%lu.%09lu%s",
+				  (unsigned long)ts->tv_sec, ts->tv_nsec, config->csv_sep);
+		} else {
+			ps.timestamp[0] = '\0';
+		}
+		return perf_stat__print_cb(evlist, config, target, ts, argc, argv,
+					   &csv_print_callbacks, &ps);
+	}
+}
-- 
2.55.0.141.g00534a21ce-goog

