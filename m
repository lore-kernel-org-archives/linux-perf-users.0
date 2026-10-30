Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388342;
	b=yonOZvcSdFygGCcjbHfjOqtHWuOkGJ7hf2202n4lH770aZ8ReBY7CKNCk9ASGeP1+iPd
	 t5lgYUsMbSpXOH8XCcODo2EMtgmHheP9Y9LymB3A4rzWIm6Co4kbHZZuz+5QcEMWb3m5D
	 KRSFa36qzvMN6HNguPbNiUVZusWxU6k9Y5DRanF1rMwQrQyul8mQ5vbeIaNE4PtdZ2oHg
	 NoTbu/yMQWb+najxpPe5Ad5zxqUV1ta9a4/MQxvwxtIn4hGy5/Gv13pwhIJDRzg4GLzKd
	 +eALONpcSvG4GFgf3ug+u6sNkB0/qVdHxAqSrYq24ScklctHUVxs/uIfspiRwxlNLHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=QtvYQSHKHHZPR+kF1xQhxuuo5Lv7T/sFdG6Bmjlk//s=;
	b=wkcPtuSwO9BwYlC6rzcfGDMlaWs9GhrRQvwKaC2D/05GrR9X7Q6mZWh/1nScXvBSp18W
	 smf5ncdXJZmpPfBzPZlw4ZMpRy1DT3JZoZQNpNi5+fPGO3BGB3e2Vin7q4VFkYJgDeeMb
	 vt0vQeEy/0qJ4tgSaRsDqiAg0rEJ7+zxCXHT4WuNWmBpE363n+jleZPaBgW0MGKmME3Db
	 Hyb8mdQ0FOZBpK9RzK3+rX9GxwDgpufIEGfcI0AOGQv8Dr7hyeM/EkseXCdWZBMngHmXm
	 GTaEJFrFWTL+3snnSt8qt27ujOGWHmJ8LwNvYNCC4kKZr93cTLRWsXUtojD3EETAzTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l23WeI8M;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075F606A31F
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 19:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5075F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l23WeI8M
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad3fc547bfso1409470a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 12:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793388340; x=1793993140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QtvYQSHKHHZPR+kF1xQhxuuo5Lv7T/sFdG6Bmjlk//s=;
        b=l23WeI8M352UWof7qgUboTnXm3QCYim0liClP/ZXqUF1JU2xowU8ot99Bh3L/KtGpN
         n5BHfdlGmDztLYC88SW6tzy0033kSVS4PaB37zCM1CKboXg8bkRp2cP2T14Ig0gWeAeQ
         vYOYQoeKY8jN7jDVJ4AMW0BLhS+OKNtILDhllOqLrqLAILpDWL4nRi4/9Y7X9f9kyroM
         6bmmMb4tD2aII5zoViVihavc1V9EZiP3/HybeHqpYWsLUuyvNp26i6HZgtbqgZD5+q3e
         dtO1Rp6ztXOdnmVF52EwTgP2C4KIUwF6s+zew+lvXgR2JprIVa0wQ2Y+QLBjTDsup1Ld
         Z3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388340; x=1793993140;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QtvYQSHKHHZPR+kF1xQhxuuo5Lv7T/sFdG6Bmjlk//s=;
        b=L0ZW65sNDnkWWK1W0SU/2zXGasQxGiYbJj+dVkvvxsJP4GVXVpUJ6iwCmoqMDd9Z9c
         CzFQbNlqVoPUzV5P0JrC7mSaCYCVGohOs+a46Igo8UwV4gci4IpVwLUptD0yIreNSG0C
         usERllXp0/RDjHzVzEAvRKWFPXzuQXqBMLbQiuKiW6Ueoh6KqVl3xXvQHelDhNtSUYNf
         Y3eU2oPwM5KopeYEhvUvjde2qDDHzVDM7u6u4wcHsCsHKkvHsXpy3BZ+9TKWEnEYZAPR
         BnPdZcKxlE1qBaYCM3RpTZ11y2Q3LzNOE/VQ7LFYyASO5SAhyTPt2Y5/+8rG+M+3H66a
         ZiXQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3pf0+rIJaqrEIN4029+F7uADbtGTTaf3nvephVdEhe6lUGRnucaFJfFBH4oabTiKiazMwWuNm/24Y3RDK9r2w@vger.kernel.org
X-Gm-Message-State: AFq9FYJdYc7qGr+qLVQURWD0B3dLJe+Y7PB1Mnhaf6S7ryuQXoUcwMny
	GLynMxBFLMp6ao+1zzemOf4BSCilS6Vd84HxjxBjoKoOavnZdTa61ZqFjsVIwy7qVlxmZ2Mm2Ot
	AVlevqw==
X-Received: from pjwo8.prod.google.com ([2002:a17:90a:d248:b0:3ac:16a7:52de])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:184f:b0:3ac:83c1:2c0
 with SMTP id 98e67ed59e1d1-3ae897e06efmr2645634a91.64.1793388340380; Fri, 30
 Oct 2026 12:25:40 -0700 (PDT)
Date: Fri, 30 Oct 2026 12:25:37 -0700
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030192537.3079368-1-ctshao@google.com>
Subject: [PATCH v7] perf stat: Include PMU name and split uncore events per
 PMU in metric-only JSON output
From: Chun-Tse Shao <ctshao@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
JSON output mode (`-j`), `perf stat` evaluates metric expressions
across all matching PMUs (including uncore PMUs like `uncore_iio_0`,
`uncore_iio_1`, etc.).

However, `perf stat` previously formatted JSON output by printing only
"cpu" : "<id>" and grouping all metric values on a single line per CPU
without identifying which PMU instance evaluated each metric. As a
result, when an uncore event spans multiple PMU boxes, `perf stat`
printed repeated, ambiguous metric keys without PMU names.

Fix this by:
1. Including "pmu" : "<pmu_name>" in print_aggr_id_json when evsel->pmu
   is a non-core or hybrid PMU in AGGR_NONE mode (-A). Tool events are
   not labeled as they don't belong to a hardware PMU instance.
2. Starting a new JSON metric line in AGGR_NONE mode (-A) whenever the
   PMU name changes, so that a line only has metrics from the PMU it is
   labeled with.
3. Opening a metric line only for events that have a metric, as other
   events print nothing in metric-only mode. This avoids spurious lines
   like {"cpu" : "0", "pmu" : "tool"} for events like user_time, while
   metrics on tool events, like tma_info_system_time (duration_time),
   are still printed with the line prefix.
4. Updating perf_json_output_lint.py to recognize the new "pmu" key in
   the JSON test suite.

Before the fix:
  $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
  {"interval" : 1.001017947, "cpu" : "0", "MB/s  iio_bandwidth_read" : "0.0=
", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "22.5",=
 "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.2", "M=
B/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s=
  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  i=
io_bandwidth_read" : "0.0"}

There is no way to determine which uncore device generated the metrics.

After:
  $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
  {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_0", "MB/s  ii=
o_bandwidth_read" : "0.0"}
  {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_1", "MB/s  ii=
o_bandwidth_read" : "0.1"}
  {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_11", "MB/s  i=
io_bandwidth_read" : "0.0"}
  ...
  {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_0", "MB/s  i=
io_bandwidth_read" : "0.0"}
  {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "MB/s  i=
io_bandwidth_read" : "0.0"}
  {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "MB/s  =
iio_bandwidth_read" : "0.0"}

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v7:
  - Pass the evsel to print_metric_begin() explicitly from all callers
    instead of falling back to evlist__first(). (Ian)
v6: lore.kernel.org/20261027203115.2647914-1-ctshao@google.com
  - Open metric lines for events that have a metric instead of skipping
    tool events, so metrics on tool events (e.g. tma_info_system_time)
    keep the line prefix and are terminated properly. (Sashiko)
  - Split JSON lines only when the shown PMU name changes. Tool event
    metrics are no longer mislabeled with an uncore PMU name, and the
    STD and CSV output are no longer split.
  - Rebase onto the latest perf-tools-next.
v5: lore.kernel.org/20260811230518.3360-2-ctshao@google.com
  - Fix perf test "perf stat JSON output linter" failure.
v4: lore.kernel.org/20260804210659.112192-1-ctshao@google.com
  - Fix the line splitting issue, causing spurious empty {"pmu": "tool"}
    objects and order-dependent PMU mislabeling.
v3: lore.kernel.org/20260729170416.41904-1-ctshao@google.com
  - Add before the fix output.
v2: lore.kernel.org/20260715203055.2981363-1-ctshao@google.com
  - Fix print_metric_begin() initialization in print_no_aggr_metric()
    to ensure tool events always open lines cleanly.

 .../tests/shell/lib/perf_json_output_lint.py  |  5 +-
 tools/perf/util/stat-display.c                | 76 ++++++++++++++++---
 2 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/pe=
rf/tests/shell/lib/perf_json_output_lint.py
index 8cde22ac9d97..982be893bd69 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -65,6 +65,7 @@ def check_json_output(expected_count):
       'metricgroup': lambda x: True,
       'node': lambda x: True,
       'pcnt-running': isfloat,
+      'pmu': lambda x: True,
       'socket': lambda x: True,
       'thread': lambda x: True,
       'unit': lambda x: True,
@@ -99,8 +100,10 @@ def check_json_output(expected_count):
 try:
   if args.no_args or args.system_wide or args.event:
     expected_items =3D [5, 7]
-  elif args.interval or args.per_thread or args.system_wide_no_aggr:
+  elif args.interval or args.per_thread:
     expected_items =3D [6, 8]
+  elif args.system_wide_no_aggr:
+    expected_items =3D [6, 7, 8, 9]
   elif args.per_core or args.per_socket or args.per_node or args.per_die o=
r args.per_cluster or args.per_cache:
     expected_items =3D [7, 9]
   elif args.metric_only:
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.=
c
index b337cc23f413..6ba4fe02fb7a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1,6 +1,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <inttypes.h>
+#include <string.h>
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <math.h>
@@ -23,6 +24,7 @@
 #include "pmu.h"
 #include "pmus.h"
 #include "tool_pmu.h"
+#include "metricgroup.h"
=20
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -361,9 +363,33 @@ static void print_aggr_id_csv(struct perf_stat_config =
*config,
 	}
 }
=20
+/*
+ * In no-aggregation mode, JSON output includes the PMU name of non-core a=
nd
+ * hybrid events so that events and metrics from different PMU instances, =
like
+ * uncore_iio_0 and uncore_iio_1, can be told apart. Tool events don't bel=
ong
+ * to a hardware PMU instance and so are not labeled.
+ */
+static const char *json_pmu_name(const struct evsel *evsel)
+{
+	if (!evsel || !evsel->pmu || evsel__is_tool(evsel))
+		return NULL;
+	if (evsel->pmu->is_core && !evsel__is_hybrid(evsel))
+		return NULL;
+	return evsel->pmu->name;
+}
+
+static bool json_pmu_name_changed(const char *name, const char *prev)
+{
+	if (!name || !prev)
+		return name !=3D prev;
+	return strcmp(name, prev) !=3D 0;
+}
+
 static void print_aggr_id_json(struct perf_stat_config *config, struct out=
state *os,
 			       struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
 {
+	const char *pmu_name;
+
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
 		json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"counters\" : %d",
@@ -397,6 +423,9 @@ static void print_aggr_id_json(struct perf_stat_config =
*config, struct outstate
 			json_out(os, "\"cpu\" : \"%d\"",
 				id.cpu.cpu);
 		}
+		pmu_name =3D json_pmu_name(evsel);
+		if (pmu_name)
+			json_out(os, "\"pmu\" : \"%s\"", pmu_name);
 		break;
 	case AGGR_THREAD:
 		json_out(os, "\"thread\" : \"%s-%d\"",
@@ -1010,13 +1039,16 @@ static void print_counter_aggrdata(struct perf_stat=
_config *config,
 		fputc('\n', output);
 }
=20
+/*
+ * Start a metric-only line. @evsel only provides the line prefix: the
+ * aggregation id, the PMU name in JSON (see json_pmu_name()) and the cgro=
up.
+ */
 static void print_metric_begin(struct perf_stat_config *config,
-			       struct evlist *evlist,
+			       struct evsel *evsel,
 			       struct outstate *os, int aggr_idx)
 {
 	struct perf_stat_aggr *aggr;
 	struct aggr_cpu_id id;
-	struct evsel *evsel;
=20
 	os->first =3D true;
 	if (!config->metric_only)
@@ -1031,7 +1063,6 @@ static void print_metric_begin(struct perf_stat_confi=
g *config,
 		else
 			fprintf(config->output, "%s", os->timestamp);
 	}
-	evsel =3D evlist__first(evlist);
 	id =3D config->aggr_map->map[aggr_idx];
 	aggr =3D &evsel->stats->aggr[aggr_idx];
 	aggr_printout(config, os, evsel, id, aggr->nr);
@@ -1069,7 +1100,7 @@ static void print_aggr(struct perf_stat_config *confi=
g,
 	 * Without each counter has its own line.
 	 */
 	cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
-		print_metric_begin(config, evlist, os, aggr_idx);
+		print_metric_begin(config, evlist__first(evlist), os, aggr_idx);
=20
 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, aggr_idx, os);
@@ -1095,7 +1126,7 @@ static void print_aggr_cgroup(struct perf_stat_config=
 *config,
 		os->cgrp =3D evsel->cgrp;
=20
 		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
-			print_metric_begin(config, evlist, os, aggr_idx);
+			print_metric_begin(config, evsel, os, aggr_idx);
=20
 			evlist__for_each_entry(evlist, counter) {
 				if (counter->cgrp !=3D os->cgrp)
@@ -1131,7 +1162,8 @@ static void print_no_aggr_metric(struct perf_stat_con=
fig *config,
=20
 	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist__core(evlist)->user_reque=
sted_cpus) {
 		struct evsel *counter;
-		bool first =3D true;
+		const char *line_pmu =3D NULL;
+		bool line_open =3D false;
=20
 		evlist__for_each_entry(evlist, counter) {
 			u64 ena, run, val;
@@ -1146,12 +1178,32 @@ static void print_no_aggr_metric(struct perf_stat_c=
onfig *config,
 				if (config->aggr_map->map[aggr_idx].cpu.cpu =3D=3D cpu.cpu)
 					break;
 			}
+			if (aggr_idx >=3D config->aggr_map->nr)
+				continue;
=20
 			os->evsel =3D counter;
 			os->id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL);
-			if (first) {
-				print_metric_begin(config, evlist, os, aggr_idx);
-				first =3D false;
+
+			/*
+			 * Only events with a metric print something in metric-only
+			 * mode, so let the first of them open the line. For JSON,
+			 * start a new line when the PMU name changes so that all
+			 * metrics on a line share the same "cpu" and "pmu" prefix.
+			 */
+			if (config->iostat_run ||
+			    metricgroup__lookup(evlist__metric_events(evlist), counter, false))=
 {
+				const char *pmu_name =3D json_pmu_name(counter);
+
+				if (line_open && config->json_output &&
+				    json_pmu_name_changed(pmu_name, line_pmu)) {
+					print_metric_end(config, os);
+					line_open =3D false;
+				}
+				if (!line_open) {
+					print_metric_begin(config, counter, os, aggr_idx);
+					line_pmu =3D pmu_name;
+					line_open =3D true;
+				}
 			}
 			val =3D ps->aggr[aggr_idx].counts.val;
 			ena =3D ps->aggr[aggr_idx].counts.ena;
@@ -1160,7 +1212,7 @@ static void print_no_aggr_metric(struct perf_stat_con=
fig *config,
 			uval =3D val * counter->scale;
 			printout(config, os, uval, run, ena, 1.0, aggr_idx);
 		}
-		if (!first)
+		if (line_open)
 			print_metric_end(config, os);
 	}
 }
@@ -1523,7 +1575,7 @@ static void print_cgroup_counter(struct perf_stat_con=
fig *config, struct evlist
 				print_metric_end(config, os);
=20
 			os->cgrp =3D counter->cgrp;
-			print_metric_begin(config, evlist, os, /*aggr_idx=3D*/0);
+			print_metric_begin(config, counter, os, /*aggr_idx=3D*/0);
 		}
=20
 		print_counter(config, counter, os);
@@ -1573,7 +1625,7 @@ void evlist__print_counters(struct evlist *evlist, st=
ruct perf_stat_config *conf
 		} else if (config->cgroup_list) {
 			print_cgroup_counter(config, evlist, &os);
 		} else {
-			print_metric_begin(config, evlist, &os, /*aggr_idx=3D*/0);
+			print_metric_begin(config, evlist__first(evlist), &os, /*aggr_idx=3D*/0=
);
 			evlist__for_each_entry(evlist, counter) {
 				print_counter(config, counter, &os);
 			}
--=20
2.56.0.317.g454f8302e1-goog

