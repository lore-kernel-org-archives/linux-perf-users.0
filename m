Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421934;
	b=oJH8i+vMDAbriCqAy8DPaFs/jcL4b9md4u0XuKmykEkIbkJzLh736rIS27GgLBJkGBkZ
	 RCgZ7CvDdx9vmAEqvN7UIU0XCczR3CoPNQB4pns2Czk89PsD1jXu0j/zhfe4dmzF/uW1U
	 qfhd/z6t/xWc0qoC7wpNbgc1ynJjITw1J/hlFoHF9qaX0CmkTbpm/IrxVun8IX+bvBrQZ
	 5AUVNxx/USWrKBXE9cnTwVsJCy6XjfoiOULguUcvr0qIMJ9AulUET8yXUF9eVVYwCGCx5
	 SUC6xJZMhjvdsyBcHLHvEwxGnhGw/xrSjO4bYCG8YmLorQhcq294rtIUPJe0mhXUvIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=vZmzfUzzweDILEhd2+M+U3xfy6iAuTlSFuI18jyrNso=;
	b=U4WwLUNx6+xaprgOjYmn0pYFCuohdEkGogGDRwSg92uelwcCjn8yAF11ErCrvHVcw80R
	 x7FuTqMCyTW5Z+hcM+3jlnASrepvazfYUHcu4J2/0BOp5curc404hcPhxCLGy/ruzXH/L
	 lOOJkp9KGL6BOx42lvRgteuRjEdJ2S3j2hcJ9m60HOBtj1f8K4SWYgpr3/bCujGfXbZ2P
	 S+3s+JzduntpCpvXf+6GksBLX+hmCD5apjDmfExKgwR6LmNtFkWTZzi2oZ7tPnSd//ULg
	 gSAHT7MkM+yvA7pr4jbgFpLKtF1G8qYvpehJ3xEsWIcDd9pCDqd2xitYvW1J0pKNWcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dS73KLWm;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA7606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 18:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FBA7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dS73KLWm
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-8488f31d754so2318135a34.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794421933; x=1795026733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vZmzfUzzweDILEhd2+M+U3xfy6iAuTlSFuI18jyrNso=;
        b=dS73KLWm8Cj1YP2E11u/jG6biyWe+l4V1QVgIA+7xF2dJbbm+iX38lzP2aqChQCxw2
         amuaAtY1lQWALElhJyn5xKZfOOy1tWLYPW9jT0jZJNkMysb/vSPTDuQggX7JnHKlKjka
         JmHIa9ysIusPvvyEPRwB8NUwI0CsXnPb+GWFMxUifkknyloPFsqUNC1JqmoAamo8+Nwb
         RJAwRDuygNKYAkkRBdaQPlgBmUX6BZrY39oxOPrkJZBabtMJy3adfMlnqJ5Tg2qpZN7F
         qyQkZJgNclY4ZvKt4eO942ua+E8hhxyvIjiI19IKfyj4S79HtZfmLNc75TCJCseVpKbE
         lJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421933; x=1795026733;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vZmzfUzzweDILEhd2+M+U3xfy6iAuTlSFuI18jyrNso=;
        b=J4cWIbCrcWQRLD/Lb1t5aX2AIJLJ635RfcTsJ0VhOGw7RvrXvbdMDZOc07i2Tn8BsQ
         swZH/8RspTURKHUppettVE//iyZtsYjv48FbskIqYnqNsu/PmRs73dPWmj5S8O/fsEKo
         /0edx5hdMg4yQ/miz49GBndRW0MRjxVXbVtaTSqTA0/4R6afbfAHLUKS1pgnUkrLyfYZ
         yLfPbUceHA6/P7usXum6v+UwB6SztRNvbWC8B3z3NS8qiKjMVxp/8oiNgmajylaW6Nx5
         AWhARjNBDpTpzICs5d3kRSlYMFm4Z1gMw4W9hL9J6yZFomPHxwpSdFzmLoxOTSveInYd
         4frA==
X-Forwarded-Encrypted: i=1; AL+hErEIIQg4EG24AarRLpwo/+TcA2ox4ldMPVLQpEzd7PwHYujRQoDw2cS13Ui0qnGAIOe8yBsxpUBP6WjydgPFAldn@vger.kernel.org
X-Gm-Message-State: APuU4Z8JYpsCgqBt8iy0t2Na/MpXiQ9iGYbOEwKaM9/hvi0p1v2+6vDD
	IISq9HCQjDEP05qN5capbsCUbjetUZH/I8Zb/3UGIbNy80ZN8MfQ0EYYevZdaNLd0YqHFF2qrv2
	7U8YwMw==
X-Received: from jahi21.prod.google.com ([2002:a05:6638:8b55:b0:615:c1f0:a936])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:5390:b0:4c3:e93e:e331
 with SMTP id 5614622812f47-56b967c2a3fmr2150104b6e.30.1794421932812; Wed, 11
 Nov 2026 10:32:12 -0800 (PST)
Date: Wed, 11 Nov 2026 10:32:09 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111183209.1892421-1-ctshao@google.com>
Subject: [PATCH v8] perf stat: Include PMU name and split uncore events per
 PMU in metric-only JSON output
From: Chun-Tse Shao <ctshao@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Hang Zhengyang <hang.zhengyang1010@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
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
1. Including "pmu" : "<pmu_name>" in print_aggr_id_json in metric-only
   AGGR_NONE mode (-A) when evsel->pmu is a non-core hardware or hybrid
   PMU. Software and tool events don't belong to a hardware PMU instance
   and so are not labeled.
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
v8:
  - Gate "pmu" output in print_aggr_id_json() on metric-only mode and
    skip software PMUs via perf_pmu__is_software(), keeping plain
    `perf stat -a -A -j` unchanged and avoiding splitting default
    metrics onto a separate "software" line. (Hang Zhengyang)
  - Rebase onto the latest perf-tools-next.
v7: lore.kernel.org/20261030192537.3079368-1-ctshao@google.com
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

 .../tests/shell/lib/perf_json_output_lint.py  |  1 +
 tools/perf/util/stat-display.c                | 79 ++++++++++++++++---
 2 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/pe=
rf/tests/shell/lib/perf_json_output_lint.py
index 8cde22ac9d97..0a16cae92766 100644
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
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.=
c
index b337cc23f413..6c9358b64b38 100644
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
@@ -361,9 +363,34 @@ static void print_aggr_id_csv(struct perf_stat_config =
*config,
 	}
 }
=20
+/*
+ * In no-aggregation metric-only mode, JSON output includes the PMU name o=
f
+ * non-core hardware and hybrid events so that metrics from different PMU
+ * instances, like uncore_iio_0 and uncore_iio_1, can be told apart. Softw=
are
+ * and tool events don't belong to a hardware PMU instance and so are not
+ * labeled.
+ */
+static const char *json_pmu_name(const struct evsel *evsel)
+{
+	if (!evsel || !evsel->pmu || perf_pmu__is_software(evsel->pmu))
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
@@ -397,6 +424,11 @@ static void print_aggr_id_json(struct perf_stat_config=
 *config, struct outstate
 			json_out(os, "\"cpu\" : \"%d\"",
 				id.cpu.cpu);
 		}
+		if (config->metric_only) {
+			pmu_name =3D json_pmu_name(evsel);
+			if (pmu_name)
+				json_out(os, "\"pmu\" : \"%s\"", pmu_name);
+		}
 		break;
 	case AGGR_THREAD:
 		json_out(os, "\"thread\" : \"%s-%d\"",
@@ -1010,13 +1042,16 @@ static void print_counter_aggrdata(struct perf_stat=
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
@@ -1031,7 +1066,6 @@ static void print_metric_begin(struct perf_stat_confi=
g *config,
 		else
 			fprintf(config->output, "%s", os->timestamp);
 	}
-	evsel =3D evlist__first(evlist);
 	id =3D config->aggr_map->map[aggr_idx];
 	aggr =3D &evsel->stats->aggr[aggr_idx];
 	aggr_printout(config, os, evsel, id, aggr->nr);
@@ -1069,7 +1103,7 @@ static void print_aggr(struct perf_stat_config *confi=
g,
 	 * Without each counter has its own line.
 	 */
 	cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
-		print_metric_begin(config, evlist, os, aggr_idx);
+		print_metric_begin(config, evlist__first(evlist), os, aggr_idx);
=20
 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, aggr_idx, os);
@@ -1095,7 +1129,7 @@ static void print_aggr_cgroup(struct perf_stat_config=
 *config,
 		os->cgrp =3D evsel->cgrp;
=20
 		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
-			print_metric_begin(config, evlist, os, aggr_idx);
+			print_metric_begin(config, evsel, os, aggr_idx);
=20
 			evlist__for_each_entry(evlist, counter) {
 				if (counter->cgrp !=3D os->cgrp)
@@ -1131,7 +1165,8 @@ static void print_no_aggr_metric(struct perf_stat_con=
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
@@ -1146,12 +1181,32 @@ static void print_no_aggr_metric(struct perf_stat_c=
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
@@ -1160,7 +1215,7 @@ static void print_no_aggr_metric(struct perf_stat_con=
fig *config,
 			uval =3D val * counter->scale;
 			printout(config, os, uval, run, ena, 1.0, aggr_idx);
 		}
-		if (!first)
+		if (line_open)
 			print_metric_end(config, os);
 	}
 }
@@ -1523,7 +1578,7 @@ static void print_cgroup_counter(struct perf_stat_con=
fig *config, struct evlist
 				print_metric_end(config, os);
=20
 			os->cgrp =3D counter->cgrp;
-			print_metric_begin(config, evlist, os, /*aggr_idx=3D*/0);
+			print_metric_begin(config, counter, os, /*aggr_idx=3D*/0);
 		}
=20
 		print_counter(config, counter, os);
@@ -1573,7 +1628,7 @@ void evlist__print_counters(struct evlist *evlist, st=
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
2.56.0.542.g3ef89b7020-goog

