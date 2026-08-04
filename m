Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD984399E2
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877636; cv=none; b=GkWU+ijCTfPzODJhq2ITVXIJRCK++15kD09kouJFSae4E3ViYdF42QKnn8FYqage8QxT62y+sHl8/Hq/FaBcROPNKJwCe7Sxsy+o/jU1r6AUTBMBk4x6qe9JgMcDIdH32TebxaVcr7IMuPrq5Hm4nsdIAC5aHlZ6NBhQgbOTDYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877636; c=relaxed/simple;
	bh=Db0r9KExC2kHjk21Z5Mzc886/cJBw8aUc7g53hi/VSo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XsyBybUp2E6qVJMfUiyuQqvV0armtk4+qqr401fKHUMnO+R8AY92z9TLEQtmjfLEE8Qd7NBkbimtZ+pz4pZVMtzPlhF8MKJ/Mojx+0H+nQC3r3dvopJ6mh40kzp2CAQdFYNfN+xKJtKzoFMS7Bcs2u5aNS9XWJF6uq18XiNKOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mc5wvCcr; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mc5wvCcr"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso330508a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Aug 2026 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785877634; x=1786482434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wweMmvmBP5UOlMtUNWCLKhh7nVd00D8+jUX20XzqKgc=;
        b=Mc5wvCcrJ160J7JsotZstw5APKqLRAU1JA66v2226CuVt3Zm8zo3zK//wAQCuF39ve
         RpurN4GX4qFV+SH2OdbcJNk0shO+O9TuW9IfgFkjcaX9S5Y3JcD8Y3dio5c3U5oQVmkQ
         47tu0m1FvRcGC3+QRtm6ctdsEYIcdPy31JvGY3qRnP5bk081RDEth3ssq/LakNUciS0E
         Khr4MEWdmN7/mBfCZcvXAFEAYhSUIEhmKnU5p0oNbyb/UuZ9kv9MRY7HB4Irlta72+S5
         ucZ/JYwzWIo0mhvsPujzHKfNToW/5oxrkrmWRsg+DwXFlwdi5py2a6U+xwMnsMYF0DVH
         kxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877634; x=1786482434;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wweMmvmBP5UOlMtUNWCLKhh7nVd00D8+jUX20XzqKgc=;
        b=jOe92Tpei4eC/P/8CVu2vTXEJAdq1pMlBNXMzdYbs2XIAUU9Y/FjD1WAFRP5IYlSpF
         hMfBWSrNd01iIobWEtzsf2IONU11F5OIeno+639x64wYaboHqiMDtJTNRp0+KyrQI5pV
         76oJDRu/kw0CM6+1AK4ZhI6tVojYL4q1n1V81gWgUUv101u96RPno8mb85qCrn1EY5gQ
         i9tuUvRV0BTh1kYLRwx0U/RfKrFycSmj9jwD+kC1y1y7dnM9f0mRmhoZ7zN87mA1pppa
         pTMMJq3EhAcYNXo9sCbvoJUHCRBxP3MXlmdM7Qzdl29ef8p55tBRGXZXmQ7Rw2u0yR+m
         GEww==
X-Forwarded-Encrypted: i=1; AHgh+RoARDG9FGJiT+K5ghlgr878omOFRhmc1T11hfQ/Rz90lLxqX9QAw+56vMXNQSY49ryqZxqW81fiKn0mjETzMfxR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uUhgM+AadHUl3fMYS4f9szltqQSS0CYwKIJQM84GJgD+Bg2M
	V7BXRbKpSbcFqF8b0TAVOHEZJoLARgfYSeo8z2F0iT4THp3oe4nzj1ttlavhn+bkwMNdxncUjxI
	tRWNNrA==
X-Received: from pjye9.prod.google.com ([2002:a17:90a:ee09:b0:38f:659:4491])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2248:b0:38d:adae:4866
 with SMTP id 98e67ed59e1d1-3903c63c51dmr1230763a91.21.1785877633439; Tue, 04
 Aug 2026 14:07:13 -0700 (PDT)
Date: Tue,  4 Aug 2026 14:06:59 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804210659.112192-1-ctshao@google.com>
Subject: [PATCH v4] perf stat: Include PMU name and split uncore events per
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
Reviewed-by: Ian Rogers <irogers@google.com>
---
v4:
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

 .../tests/shell/lib/perf_json_output_lint.py  |  1 +
 tools/perf/util/stat-display.c                | 62 +++++++++++++++----
 2 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/pe=
rf/tests/shell/lib/perf_json_output_lint.py
index dafbde56cc76..36767905fcdb 100644
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
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.=
c
index b337cc23f413..681f83c7295d 100644
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
@@ -1146,13 +1151,46 @@ static void print_no_aggr_metric(struct perf_stat_c=
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
+				if (config->json_output && line_open) {
+					bool pmu_changed;
+
+					if (is_tool) {
+						pmu_changed =3D last_pmu &&
+							(!last_pmu->is_core ||
+							 (last_evsel &&
+							  evsel__is_hybrid(last_evsel)));
+					} else if (last_pmu) {
+						pmu_changed =3D (pmu !=3D last_pmu);
+					} else {
+						pmu_changed =3D pmu &&
+							(!pmu->is_core ||
+							 evsel__is_hybrid(counter));
+					}
+
+					if (pmu_changed) {
+						print_metric_end(config, os);
+						line_open =3D false;
+					}
+				}
+				if (!line_open) {
+					print_metric_begin(config, evlist, os,
+							   aggr_idx, counter);
+					line_open =3D true;
+				}
+				last_pmu =3D is_tool ? NULL : pmu;
+				last_evsel =3D counter;
 			}
+
 			val =3D ps->aggr[aggr_idx].counts.val;
 			ena =3D ps->aggr[aggr_idx].counts.ena;
 			run =3D ps->aggr[aggr_idx].counts.run;
@@ -1160,7 +1198,7 @@ static void print_no_aggr_metric(struct perf_stat_con=
fig *config,
 			uval =3D val * counter->scale;
 			printout(config, os, uval, run, ena, 1.0, aggr_idx);
 		}
-		if (!first)
+		if (line_open)
 			print_metric_end(config, os);
 	}
 }
@@ -1523,7 +1561,7 @@ static void print_cgroup_counter(struct perf_stat_con=
fig *config, struct evlist
 				print_metric_end(config, os);

 			os->cgrp =3D counter->cgrp;
-			print_metric_begin(config, evlist, os, /*aggr_idx=3D*/0);
+			print_metric_begin(config, evlist, os, /*aggr_idx=3D*/0, NULL);
 		}

 		print_counter(config, counter, os);
@@ -1573,7 +1611,7 @@ void evlist__print_counters(struct evlist *evlist, st=
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
2.55.0.571.g244d577d93-goog

