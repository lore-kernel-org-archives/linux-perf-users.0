Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3E387341
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185410; cv=none; b=KydO3UEpDqBX+IWyrHuqmjLdXfYVcKMfL3K9R97CsxLa0+P5MnNefH4jR+jcZ+wdGvUTnJU0n1X3XPhYh+6QFDKB6RCxOZXsWC2mFmH15ddAdRCayWc+QPozsCvv36TFMn1SumcOWRwK9qYms2GthdoRTzYhUkOISKWO8vV+jgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185410; c=relaxed/simple;
	bh=bJn2dSlAtNjkN0pqwISvOmQIcdAlFhaQ3l8Q6czi+fQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gGJ70flqVP8+G/ZEhCY9sWQEsmRoTAT/pG5Cksmow5/nOYXn9XnQMQ25gvnymFGytlBNStzyVDWoR4H/cEv2UjaS0fjVieZfRo4yTxk46wcmUwzsTlvGmLV3ZSLLq/rFqgVKxQXzwsmJaDnnjFWsUPMJtz5DNvetNlcezNcHFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzsXFUtd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzsXFUtd"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c890bac374eso15672313a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185406; x=1784790206; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gD77hpfjwozG6ZVYj8Tm71/tl5Acvufs/zc7tAqWd3s=;
        b=JzsXFUtdnfdmbx2JmgaiwU9yqNRJuygH2g8vi9VqtsGpsrip6AyiPa36MxyviNutGx
         wWY/sngd7u2RPGEwC6JbmfKFIYtApT5YVB9ZbMAkBtyJGI4oif24OuEFGdE7CaVQLeay
         TGalRlHydwOgvDfx9eK6opdQylw1H2lCa6FVNB9hOfUspRdVYK8F3RRpNCZjy9GIWuz1
         D8O1aRbMzK2srdER07p6wuYQaVxtT2IIMiYxJjccwCA04itGilabzYMBdd3eL20PblYm
         +IEdVPfN+gK/TmvZjxWVPbTidoLQic+01+hjL1kve8biVu8vQHDQ2syPzJNtuYvc/Irk
         z+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185406; x=1784790206;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gD77hpfjwozG6ZVYj8Tm71/tl5Acvufs/zc7tAqWd3s=;
        b=TAxok1Kyuok0m48hGUY88WJ9KgZCfitUUpgH0Np+zIVP92wDEV0lwdT3xW7D74xuf5
         p1a36ulj3BKD7S7uhZr2Lq3y/DmmJLp4V4Ug87X/HiS/acFR+XOZqySBf3loDaDRRmJf
         rmrd2lBGZvZXKpEmDnG0Ksv7kEIAuYn+C9k6JxuaZylKM2mz0cRIAzgJFipTlVd9VgYL
         9OjzwqWz1HiLRD3bjOsfSxFivc+iDKsLwLiA758q+yV6l/Yp1fkLIXCFglJ4Cfd3fJQ7
         1vUE/vwzMdSi9DEx6MDVC8T6g5WIsLnSgZGIc3UKiWVY3sjnVif4lKu3ezHBASxLpl6X
         4+6w==
X-Forwarded-Encrypted: i=1; AHgh+RpGVwVsK6blDt0kgT5QcAbeuGrvIQiK5FeZSwgln0B/o6078HZtgoxoJ9yOUE5MwyeZ/0LMLvnXd+Zr2TIRsJOr@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVhT+2NeonWMjvYtFa4H3MR4EnZxGtp97P4VrmwdOxPncd5G/
	PQjFwnKGaVHYwBjpwMUX9lPU71bdVgF8qYCXPpwPyMyKuBu3thEmR8NIPgI1Ebn65G/e0esspAg
	/iEYhqz6weg==
X-Received: from dlaj18.prod.google.com ([2002:a05:701b:2812:b0:13c:ca64:1675])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a2:b0:3c3:83e6:c705
 with SMTP id adf61e73a8af0-3c383e71c7cmr3044127637.35.1784185406076; Thu, 16
 Jul 2026 00:03:26 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:02:56 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-8-irogers@google.com>
Subject: [PATCH v4 07/14] perf stat: Implement CSV formatting callbacks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
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
 tools/perf/util/stat-print-csv.c | 678 ++++++++++++++++++++++++++++++-
 1 file changed, 671 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-print-csv.c b/tools/perf/util/stat-print-csv.c
index ee86d07636ea..f93ca1885d46 100644
--- a/tools/perf/util/stat-print-csv.c
+++ b/tools/perf/util/stat-print-csv.c
@@ -1,13 +1,677 @@
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
+	struct evsel *evsel;
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
+ * @cgrp: Cgroup name (optional).
+ * @val: Raw aggregated counter value.
+ * @ena: Enabled time for multiplexing percentage.
+ * @run: Running time for multiplexing percentage.
+ * @scale: Event scale factor.
+ * @stdev_pct: Standard deviation percentage.
+ * @supported: Event hardware support indicator.
+ * @aggr_idx: Aggregation index.
+ * @metrics_list: Linked list head containing nested queued_metric structures.
+ */
+struct queued_event {
+	struct list_head list;
+	struct evsel *evsel;
+	char *name;
+	char *unit;
+	char *cgrp;
+	u64 val, ena, run;
+	double scale;
+	double stdev_pct;
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
+	case AGGR_THREAD: {
+		const char *comm = "unknown";
+		int pid = -1;
+
+		if (evsel && evsel->core.threads && id.thread_idx >= 0 &&
+		    id.thread_idx < perf_thread_map__nr(evsel->core.threads)) {
+			comm = perf_thread_map__comm(evsel->core.threads,
+						      id.thread_idx);
+			pid = perf_thread_map__pid(evsel->core.threads,
+						    id.thread_idx);
+		}
+		fprintf(output, "%s-%d%s", comm, pid, sep);
+		break;
+	}
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
+static int csv_print_start(void *ctx, struct perf_stat_config *config __maybe_unused)
+{
+	struct csv_print_state *ps = ctx;
+
+	INIT_LIST_HEAD(&ps->events_list);
+	ps->current_event = NULL;
+	return 0;
+}
+
+static int csv_print_event(void *ctx, struct perf_stat_config *config,
+			   struct evsel *evsel, int aggr_idx, u64 val, u64 ena,
+			   u64 run, double stdev_pct, const char *cgrp)
+{
+	struct csv_print_state *ps = ctx;
+	struct queued_event *ev;
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	if (config && config->aggr_map && aggr_idx >= 0 &&
+	    aggr_idx < config->aggr_map->nr)
+		id = config->aggr_map->map[aggr_idx];
+
+	/* Skip zero counters in CSV callbacks if they qualify */
+	if (val == 0 && should_skip_zero_counter(config, evsel, &id)) {
+		ps->current_event = NULL;
+		return 0;
+	}
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
+	if (cgrp && cgrp[0]) {
+		ev->cgrp = strdup(cgrp);
+		if (!ev->cgrp) {
+			free(ev->unit);
+			free(ev->name);
+			free(ev);
+			return -ENOMEM;
+		}
+	} else {
+		ev->cgrp = NULL;
+	}
+
+	ev->evsel = evsel;
+	ev->val = val;
+	ev->ena = ena;
+	ev->run = run;
+	ev->scale = evsel->scale;
+	ev->stdev_pct = stdev_pct;
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
+static int csv_print_metric(void *ctx, struct perf_stat_config *config __maybe_unused,
+			    struct evsel *evsel, int aggr_idx,
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
+	b->evsel = evsel;
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
+	list_add_tail(&b->list, &ps->current_event->metrics_list);
+
+	return 0;
+}
+
+static int csv_print_end(void *ctx, struct perf_stat_config *config)
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
+
+		/* 1. Print Value, Unit, Name (Columns 1, 2, 3) */
+		if (ok) {
+			double sc = ev->scale;
+			double avg = ev->val * sc;
+			const char *fmt = floor(sc) != sc ? "%.2f%s" : "%.0f%s";
+
+			fprintf(output, fmt, avg, sep);
+		} else {
+			fprintf(output, "%s%s", bad_count, sep);
+		}
 
-int perf_stat__print_csv(struct evlist *evlist __maybe_unused,
-			 const struct perf_stat_config *config __maybe_unused,
-			 const struct target *target __maybe_unused,
-			 const struct timespec *ts __maybe_unused,
-			 int argc __maybe_unused,
-			 const char **argv __maybe_unused)
+		if (ev->unit)
+			fprintf(output, "%s%s", ev->unit, sep);
+		else
+			fprintf(output, "%s", sep);
+
+		fprintf(output, "%s", ev->name);
+
+		/* 2. Print Runtime and Enabled Percentage (Columns 4, 5) */
+		if (ev->run != ev->ena)
+			enabled_percent = 100.0 * ev->run / ev->ena;
+		fprintf(output, "%s%" PRIu64 "%s%.2f", sep, ev->run, sep,
+			enabled_percent);
+
+		/* 3. Print Metrics (Columns 6, 7) */
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
+				/*
+				 * Pad exactly 4 commas (Value, Unit, Name, Run, Enabled)
+				 * to line up with the Metric Value column.
+				 */
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
+		free(ev->cgrp);
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
+				       struct perf_stat_config *config __maybe_unused)
 {
+	struct csv_metric_only_print_state *ps = ctx;
+
+	INIT_LIST_HEAD(&ps->queued_metrics);
 	return 0;
 }
+
+static int csv_metric_only_print_metric(void *ctx,
+					struct perf_stat_config *config __maybe_unused,
+					struct evsel *evsel, int aggr_idx,
+					const char *name, const char *unit, double val,
+					enum metric_threshold_classify thresh __maybe_unused)
+{
+	struct csv_metric_only_print_state *ps = ctx;
+	struct queued_metric *b = malloc(sizeof(*b));
+
+	if (!b)
+		return -ENOMEM;
+
+	b->evsel = evsel;
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
+	return 0;
+}
+
+static int csv_metric_only_print_end(void *ctx, struct perf_stat_config *config)
+{
+	struct csv_metric_only_print_state *ps = ctx;
+	FILE *output = ps->fp;
+	const char *sep = ps->sep;
+	struct queued_metric *b, *tmp;
+	char **unique_names = NULL;
+	size_t num_unique = 0;
+	size_t unique_alloc = 0;
+	int *unique_aggrs = NULL;
+	size_t num_aggrs = 0;
+	size_t aggr_alloc = 0;
+	size_t i, j;
+	int ret = 0;
+	int err;
+
+	if (list_empty(&ps->queued_metrics))
+		return 0;
+
+	/* 1. Build unique metric names and unique aggr_idx lists */
+	list_for_each_entry(b, &ps->queued_metrics, list) {
+		bool found_metric = false;
+		bool found_aggr = false;
+
+		for (i = 0; i < num_unique; i++) {
+			if (!strcmp(unique_names[i], b->name)) {
+				found_metric = true;
+				break;
+			}
+		}
+		if (!found_metric) {
+			if (num_unique >= unique_alloc) {
+				unique_alloc = unique_alloc ? unique_alloc * 2 : 16;
+				unique_names = realloc(unique_names,
+						       unique_alloc * sizeof(char *));
+				if (!unique_names) {
+					ret = -ENOMEM;
+					goto cleanup_grid;
+				}
+			}
+			unique_names[num_unique++] = strdup(b->name);
+			if (!unique_names[num_unique - 1]) {
+				num_unique--;
+				ret = -ENOMEM;
+				goto cleanup_grid;
+			}
+		}
+
+		for (i = 0; i < num_aggrs; i++) {
+			if (unique_aggrs[i] == b->aggr_idx) {
+				found_aggr = true;
+				break;
+			}
+		}
+		if (!found_aggr) {
+			if (num_aggrs >= aggr_alloc) {
+				aggr_alloc = aggr_alloc ? aggr_alloc * 2 : 16;
+				unique_aggrs = realloc(unique_aggrs,
+						       aggr_alloc * sizeof(int));
+				if (!unique_aggrs) {
+					ret = -ENOMEM;
+					goto cleanup_grid;
+				}
+			}
+			unique_aggrs[num_aggrs++] = b->aggr_idx;
+		}
+	}
+
+	/* 2. Print Headers (if not already printed) */
+	if (!config->metric_only_headers_printed) {
+		if (config->interval) {
+			fprintf(output, "#%s%s", "time", sep);
+		} else {
+			if (config->aggr_map && num_aggrs > 0 &&
+			    config->aggr_mode != AGGR_GLOBAL) {
+				const char *header = aggr_header_csv[config->aggr_mode];
+				const char *p = header;
+
+				while (*p) {
+					if (*p == ',')
+						fputs(sep, output);
+					else
+						fputc(*p, output);
+					p++;
+				}
+			}
+		}
+
+		/* Print uniquely collected headers in exact columnar order */
+		for (i = 0; i < num_unique; i++) {
+			char *header_name = NULL;
+			/* Find first matching metric to grab its unit for the header */
+			char *unit = NULL;
+
+			list_for_each_entry(b, &ps->queued_metrics, list) {
+				if (!strcmp(b->name, unique_names[i])) {
+					unit = b->unit;
+					break;
+				}
+			}
+
+			if (unit && unit[0])
+				err = asprintf(&header_name, "%s  %s", unit,
+					       unique_names[i]);
+			else
+				err = asprintf(&header_name, "%s",
+					       unique_names[i]);
+
+			if (err < 0 || !header_name) {
+				ret = -ENOMEM;
+				goto cleanup_grid;
+			}
+			fprintf(output, "%s%s", header_name, sep);
+			free(header_name);
+		}
+		fprintf(output, "\n");
+		config->metric_only_headers_printed = true;
+	}
+
+	/* 3. Print Values for Each Aggregation Node */
+	for (i = 0; i < num_aggrs; i++) {
+		int current_aggr = unique_aggrs[i];
+		struct evsel *last_evsel = NULL;
+
+		/* Print aggregation prefix */
+		if (config->interval && ps->timestamp[0])
+			fprintf(output, "%s", ps->timestamp);
+
+		if (config->aggr_map && current_aggr >= 0 &&
+		    current_aggr < config->aggr_map->nr) {
+			struct aggr_cpu_id id = config->aggr_map->map[current_aggr];
+			int aggr_nr = 0;
+
+			/* Find evsel for this aggr_idx */
+			list_for_each_entry(b, &ps->queued_metrics, list) {
+				if (b->aggr_idx == current_aggr) {
+					last_evsel = b->evsel;
+					break;
+				}
+			}
+
+			if (last_evsel && last_evsel->stats &&
+			    last_evsel->stats->aggr &&
+			    current_aggr < last_evsel->stats->nr_aggr)
+				aggr_nr = last_evsel->stats->aggr[current_aggr].nr;
+
+			print_aggr_id_csv(config, output, last_evsel, id, aggr_nr);
+		}
+
+		/* Print each metric, or pad with empty comma if missing for this node */
+		for (j = 0; j < num_unique; j++) {
+			struct queued_metric *found_metric = NULL;
+
+			list_for_each_entry(b, &ps->queued_metrics, list) {
+				if (b->aggr_idx == current_aggr &&
+				    !strcmp(b->name, unique_names[j])) {
+					found_metric = b;
+					break;
+				}
+			}
+
+			if (found_metric) {
+				if (isnan(found_metric->val))
+					fprintf(output, "%s", sep);
+				else
+					fprintf(output, "%.1f%s",
+						found_metric->val, sep);
+			} else {
+				/* Padding for missing metric to preserve column alignment */
+				fprintf(output, "%s", sep);
+			}
+		}
+		fprintf(output, "\n");
+	}
+
+cleanup_grid:
+	for (i = 0; i < num_unique; i++)
+		free(unique_names[i]);
+	free(unique_names);
+	free(unique_aggrs);
+
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
+int perf_stat__print_csv(struct evlist *evlist, struct perf_stat_config *config,
+			 const struct target *target, const struct timespec *ts,
+			 int argc, const char **argv)
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

