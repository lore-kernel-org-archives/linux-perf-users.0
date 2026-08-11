Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975436196B
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786489528; cv=none; b=t8FE0W0v1df0YSApdKFH+tCUsDGF6gErF07Ik9NjA+/zbfQRnKuM4UZRyFDnWxQOXabG8HkAaovLaaiqUF36yWZvSTCjeTI669J2NBzuBXbl4gTw67XKDFj7yqDPVBwYpZnx0tX9R7pfuzeNO3H09EMEIPLdFwekZsO+FR5Tf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786489528; c=relaxed/simple;
	bh=owDiWb5AGoB1+qqnHF1IBHcmEF4CwrqEde3k14fxLHU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BBk8h9cGPN5toNQMsg+hW3k6TAaep4t4AirVZb2wkt+kiE5sW7AvtEsZORFsVZURg4eAQ6/XR64DeDkZfoIOqhgYn67iQs1jFuWmHX4MRsf+JOQ/gaG7Z0o5UMqUAcx7I2rkT580LYA02eN7YxFFdhOLAetv6Ha2YN//Yb+lXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOmAn5ca; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOmAn5ca"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so351441a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786489526; x=1787094326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JpCJxW+LvvRGimiXWuRAz9IsAqYHM0AigVAqXTP+JYc=;
        b=nOmAn5cakpSxbZHl6FRJgG3q/uQ5Gm8tVlEGWBdigOyGPvLawuLFL/jp0+v2bzYgP8
         h9iZgsdR7O54Dj1wGdnKkwwOjKBF4JNfSQoNovDEp6u4aYZEn/3NTqE/M8XGTC5buGKl
         +iAwS3fi/HcfKEwhUHjzqqTZJ0B82ok2i2My2nA1eIv+ET4mxO3xqRaZRTjaV1r+IOS0
         StqY6YZ/R3fuzk90KEKxDFyozXUlUMhxxHeWKZIwmkyjAWpK8uxj+CbWUNguLaDHxAYj
         XEIHQ8vhm+TDFX9D4lLnCMkeVvPJxgAudqywa/S+Ud5juyc5gRoLw9o5wpG3DFR6Ruw2
         OfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786489526; x=1787094326;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JpCJxW+LvvRGimiXWuRAz9IsAqYHM0AigVAqXTP+JYc=;
        b=d0ZS27qGVPd7pH0I0f2ljaY588/k7gqIndaFl8TA4hn6EEZaUMzU7d6R3qpnQ6gykg
         XgBiJTXUwn5me90uRfFTTht/MYbIIg7WpVymFMyW9XVA+R2UBq0fz/RsAicXi84ptje1
         guHzBOQir43beWqvW0aomOFRKvLeUKMzjt1TdYi2D05jpArQBuy87SMXlNg/O/Ay8hvF
         WKi4mTPRy5FO7EJpcXmLYeK5DuDE+kJKa5T4+iGKi6EIVMzFHk/VF2xQ8RB9nAZALQrf
         FvAX4VRdIaNWPLVUzvyngT0Ol8zMKAIE8loLjYqopP9t9X6CfgfWPODy1QatA6AvzULv
         YEMw==
X-Forwarded-Encrypted: i=1; AHgh+RrG1Oak5qH930yAAEmOeMNih6WKvEZIuFMewB52lr3tPA1theWi6cFQUZhMGxOZBLfCAvw10cW1drW9D4Ss/HpA@vger.kernel.org
X-Gm-Message-State: AOJu0YwYvDsmFKsVw7Mk3FJjhl56rbMDbEpZb/dtruNnPvC92tLFiOzT
	Znb8gvr+gDXKdBFHeH4zc3SSegeiqOCMluVb52H5G6cLSSY3qiORg5jZ/eVNs69BhyxIuPCiC08
	JLUkepw==
X-Received: from pgcc19.prod.google.com ([2002:a63:1c13:0:b0:cbe:9dc7:9ef6])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cfa2:b0:3c4:46ca:3347
 with SMTP id adf61e73a8af0-3cc3f51e24emr504821637.2.1786489526201; Tue, 11
 Aug 2026 16:05:26 -0700 (PDT)
Date: Tue, 11 Aug 2026 16:05:19 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811230518.3360-2-ctshao@google.com>
Subject: [PATCH v5] perf stat: Include PMU name and split uncore events per
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
   is a non-core or hybrid PMU in AGGR_NONE mode (-A).
2. Starting a new JSON metric line in AGGR_NONE mode (-A) whenever the
   underlying hardware PMU instance changes across PMU events.
3. Bypassing line initialization for tool events (e.g. -e user_time) in
   metric-only mode so that JSON lines are opened only by hardware PMUs,
   preventing tool events from corrupting PMU name labels or creating
   spurious empty {"pmu": "tool"} JSON objects.
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

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
v5:
  - Fix perf test "perf stat JSON output linter" failure.

v4: lore.kernel.org/20260804210659.112192-1-ctshao@google.com
  - Fix the line splitting issue, causing spurious empty {"pmu": "tool"}
    objects and order-dependent PMU mislabeling.

v3: lore.kernel.org/20260729170416.41904-1-ctshao@google.com
  - Add before the fix output.

v2: lore.kernel.org/20260715203055.2981363-1-ctshao@google.com
  - Fix print_metric_begin() initialization in print_no_aggr_metric()
    to ensure tool events always open lines cleanly.
  - Simplify and fix PMU line-split transition tracking when switching
    between different PMU instances or transitioning from tool events.
  - Add bounds check on aggr_map index in print_no_aggr_metric() to
    prevent out-of-bounds array reads if sysfs CPU topology is incomplete.

v1: lore.kernel.org/20260714174052.1826692-1-ctshao@google.com

 .../tests/shell/lib/perf_json_output_lint.py  |  5 +-
 tools/perf/util/stat-display.c                | 59 +++++++++++++++----
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/pe=
rf/tests/shell/lib/perf_json_output_lint.py
index dafbde56cc76..645b76577abb 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -64,6 +64,7 @@ def check_json_output(expected_items):
       'metric-threshold': lambda x: x in ['unknown', 'good', 'less good', =
'nearly bad', 'bad'],
       'metricgroup': lambda x: True,
       'node': lambda x: True,
+      'pmu': lambda x: True,
       'pcnt-running': lambda x: isfloat(x),
       'socket': lambda x: True,
       'thread': lambda x: True,
@@ -99,8 +100,10 @@ def check_json_output(expected_items):
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
index b337cc23f413..fa5fdb33bba3 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -397,6 +397,9 @@ static void print_aggr_id_json(struct perf_stat_config =
*config, struct outstate
 			json_out(os, "\"cpu\" : \"%d\"",
 				id.cpu.cpu);
 		}
+		if (evsel && !evsel__is_tool(evsel) && evsel->pmu &&
+		    (!evsel->pmu->is_core || evsel__is_hybrid(evsel)))
+			json_out(os, "\"pmu\" : \"%s\"", evsel->pmu->name);
 		break;
 	case AGGR_THREAD:
 		json_out(os, "\"thread\" : \"%s-%d\"",
@@ -1012,11 +1015,12 @@ static void print_counter_aggrdata(struct perf_stat=
_config *config,

 static void print_metric_begin(struct perf_stat_config *config,
 			       struct evlist *evlist,
-			       struct outstate *os, int aggr_idx)
+			       struct outstate *os, int aggr_idx,
+			       struct evsel *counter)
 {
 	struct perf_stat_aggr *aggr;
 	struct aggr_cpu_id id;
-	struct evsel *evsel;
+	struct evsel *evsel =3D counter ?: evlist__first(evlist);

 	os->first =3D true;
 	if (!config->metric_only)
@@ -1031,7 +1035,6 @@ static void print_metric_begin(struct perf_stat_confi=
g *config,
 		else
 			fprintf(config->output, "%s", os->timestamp);
 	}
-	evsel =3D evlist__first(evlist);
 	id =3D config->aggr_map->map[aggr_idx];
 	aggr =3D &evsel->stats->aggr[aggr_idx];
 	aggr_printout(config, os, evsel, id, aggr->nr);
@@ -1069,7 +1072,7 @@ static void print_aggr(struct perf_stat_config *confi=
g,
 	 * Without each counter has its own line.
 	 */
 	cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
-		print_metric_begin(config, evlist, os, aggr_idx);
+		print_metric_begin(config, evlist, os, aggr_idx, NULL);

 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, aggr_idx, os);
@@ -1095,7 +1098,7 @@ static void print_aggr_cgroup(struct perf_stat_config=
 *config,
 		os->cgrp =3D evsel->cgrp;

 		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
-			print_metric_begin(config, evlist, os, aggr_idx);
+			print_metric_begin(config, evlist, os, aggr_idx, NULL);

 			evlist__for_each_entry(evlist, counter) {
 				if (counter->cgrp !=3D os->cgrp)
@@ -1131,7 +1134,9 @@ static void print_no_aggr_metric(struct perf_stat_con=
fig *config,

 	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist__core(evlist)->user_reque=
sted_cpus) {
 		struct evsel *counter;
-		bool first =3D true;
+		struct evsel *last_evsel =3D NULL;
+		struct perf_pmu *last_pmu =3D NULL;
+		bool line_open =3D false;

 		evlist__for_each_entry(evlist, counter) {
 			u64 ena, run, val;
@@ -1146,12 +1151,42 @@ static void print_no_aggr_metric(struct perf_stat_c=
onfig *config,
 				if (config->aggr_map->map[aggr_idx].cpu.cpu =3D=3D cpu.cpu)
 					break;
 			}
+			if (aggr_idx >=3D config->aggr_map->nr)
+				continue;

 			os->evsel =3D counter;
 			os->id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL);
-			if (first) {
-				print_metric_begin(config, evlist, os, aggr_idx);
-				first =3D false;
+
+			if (config->metric_only) {
+				struct perf_pmu *pmu =3D counter->pmu;
+				bool is_tool =3D evsel__is_tool(counter);
+
+				if (!is_tool && pmu) {
+					bool pmu_changed =3D false;
+
+					if (line_open && last_pmu) {
+						bool non_core =3D !pmu->is_core ||
+								evsel__is_hybrid(counter) ||
+								!last_pmu->is_core ||
+								evsel__is_hybrid(last_evsel);
+
+						if (non_core &&
+						    strcmp(pmu->name, last_pmu->name) !=3D 0)
+							pmu_changed =3D true;
+					}
+
+					if (pmu_changed) {
+						print_metric_end(config, os);
+						line_open =3D false;
+					}
+					if (!line_open) {
+						print_metric_begin(config, evlist, os,
+								   aggr_idx, counter);
+						line_open =3D true;
+					}
+					last_pmu =3D pmu;
+					last_evsel =3D counter;
+				}
 			}
 			val =3D ps->aggr[aggr_idx].counts.val;
 			ena =3D ps->aggr[aggr_idx].counts.ena;
@@ -1160,7 +1195,7 @@ static void print_no_aggr_metric(struct perf_stat_con=
fig *config,
 			uval =3D val * counter->scale;
 			printout(config, os, uval, run, ena, 1.0, aggr_idx);
 		}
-		if (!first)
+		if (line_open)
 			print_metric_end(config, os);
 	}
 }
@@ -1523,7 +1558,7 @@ static void print_cgroup_counter(struct perf_stat_con=
fig *config, struct evlist
 				print_metric_end(config, os);

 			os->cgrp =3D counter->cgrp;
-			print_metric_begin(config, evlist, os, /*aggr_idx=3D*/0);
+			print_metric_begin(config, evlist, os, /*aggr_idx=3D*/0, NULL);
 		}

 		print_counter(config, counter, os);
@@ -1573,7 +1608,7 @@ void evlist__print_counters(struct evlist *evlist, st=
ruct perf_stat_config *conf
 		} else if (config->cgroup_list) {
 			print_cgroup_counter(config, evlist, &os);
 		} else {
-			print_metric_begin(config, evlist, &os, /*aggr_idx=3D*/0);
+			print_metric_begin(config, evlist, &os, /*aggr_idx=3D*/0, NULL);
 			evlist__for_each_entry(evlist, counter) {
 				print_counter(config, counter, &os);
 			}
--
2.55.0.679.g6767b8d81c-goog

