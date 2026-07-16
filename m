Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203E38AC8E
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176398; cv=none; b=HkwChhnSG4CRBNAYa5/iaVKpd+9S17n377razkc7qrey46WBqKU0KE3lHhAmeaKBTAMCk87Uk5/bbPU88G/y6UkOtICGqbTiVFqvV83JC/bBqZ2BEYxCZXxkMCt4ACEgtD5L9vNoeqpk+Hl7JGrlwe6ihReT2TtDIxEVsyVdAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176398; c=relaxed/simple;
	bh=Z/JBNSMqvJiYPoWJcHV2jwKGt2fXurEJ2l3bGBPkX9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=axIRqxEMOJsDZn05mCQub/IYk2D5oILccFR1QU8gFUs7B4i44bCoAkjBRvqFvygtDW3nc0hz+lPYFsMq2JlvkO0gk8EeEeTVkCboKB5h3O486Ku9ZQmDrTDsHd/qEnIipGuBPstoz7dIOiVSolr8DjwlYW4wTp2K0kCFcm+KLnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZOBA9qo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZOBA9qo"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so5181469a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176395; x=1784781195; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cCpmfC9ncJYNju5loOzVLdBvPgwOC9w3yOrCEls1z5I=;
        b=DZOBA9qo9B22Ztvyz+9BRYyVywt9MMoeRYTLVBT/aozjSABxJMshFDJFhWQzCRT/6k
         N49poKiUkTm4GB5LVveZ7BxeMffwHnMQbQRYRokTdvOthBx5iVS40VeoLHYaPnQGuk7d
         XpB5PIs0YDUni9fe1+AxBcrGJwrGsCvHOds5rOkxv038FOB6Jn5EHXl0AuFD9DUQqxmX
         EGE1Z1F/QT+l73uqvB2oyFS3LGJeKVb53U7KO13LAeMjmGjXrHYSTY5BbaIgxAOc7JCd
         cfdLKqMsAn7c7dvat0O8GfkwTS1riLB9eep+4B84BQIiVPPYiepp283x/OlDqntdR2cK
         3C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176395; x=1784781195;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cCpmfC9ncJYNju5loOzVLdBvPgwOC9w3yOrCEls1z5I=;
        b=cmLuokwh7fEQ0rm2TRwLfPpzwNXsLGUHnooUIInjau+k/lXcob3q2rs6Ig/c0IkvfN
         fjayRauTRIFqA3m/0vFMYg3KKUHodZeJ/4B2I5nKVVrtVo4R3koznAubsGsl8rT8F7QE
         kC6ZW/67nXvnPDrwhQA/8T7418AsSuuASISBjGjWTg64MuTI+zyRe3BF1Esk4Ypc5xQp
         tLCP6Vkdb68G+hSOkstu/JC0rYAYYq9dEZNOVjYR5Sw3Jaw8O6GwBHq3vQbpvJfzt4MB
         OvXTzbrBqWHhqeCoUjgP+/CzsXTBielL1pLV6GLy/28pLsAU7PxxN+CoAWf5lrOsVghs
         xfNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmsrMAbeqimyN+dI4Zz1Q8uO2KA0K1Cw5sgbYzmEGpnvuXC/rL2007p1ITCjLifs7ejsAixnC7kxRjhq2OxtHj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2wdbzIhhB9UE2rakC4P6XsGDSHfBu57gy5pYqrz9hjIoX4GW
	U3ESAQIDxJxixTifrrt7hNuuF6aH5n9jtKVYQP/E0k6MSGvrPbx0q6FetWPty5tDew/q2RB4rSv
	i9ER06/EuiQ==
X-Received: from dycne10.prod.google.com ([2002:a05:7301:c8a:b0:30f:3ca0:fb5d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0c:b0:367:d850:6a5f
 with SMTP id 98e67ed59e1d1-38e2a077fd0mr4874856a91.25.1784176395211; Wed, 15
 Jul 2026 21:33:15 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:19 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-11-irogers@google.com>
Subject: [PATCH v3 10/14] perf stat: Implement streaming JSON formatting callbacks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
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
 tools/perf/util/stat-print-json.c | 331 +++++++++++++++++++++++++++++-
 1 file changed, 324 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-print-json.c b/tools/perf/util/stat-print-json.c
index 4690c4286fd2..f168dca70ee0 100644
--- a/tools/perf/util/stat-print-json.c
+++ b/tools/perf/util/stat-print-json.c
@@ -1,13 +1,330 @@
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
2.55.0.141.g00534a21ce-goog

