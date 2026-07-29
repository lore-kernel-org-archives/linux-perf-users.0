Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42235C188
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344661; cv=none; b=eZPBA3uDEnfgLFT5fdqCcaUmObYZa+n2m3BIVIEMdPcnti5TWFs9iG6Fspl/Xn/aYAg3H2pJSkDqe8b7OWGML0O6B4nsY0bNVv2z1siT7IgzwKeJP9z+dvFs8eyAqAsZmIxcrZidw+Xt4pgsIg6gQrEppbjptq1+/t1Vd8LReLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344661; c=relaxed/simple;
	bh=Sl6jtyDcV3fn2EFhB3tEgtwspQXFjZbAikb6kdgfozo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hQnbOoa+ud/OitSFHf7CgUeHrjnbcZ8yDfoP79PijomWWtkSj6GWwrRl+VAjrMsO12K3cofCzZCHdxKQQYpPWIil51oj60AqH/DwqJg52wjPq8MlPps5QPBCcGHSdHLqcqlG/EVWFByjrJyi6ZkvqQxdaWy6I1cpNsREvq2myDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpADaH4v; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpADaH4v"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84877b362f6so2066292b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785344659; x=1785949459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2FTqa+wpV5gGUjsvj1qPbJvazcpSNH5mYFnUJHzzvsk=;
        b=LpADaH4vwskw+beP6xvOhGUSGAEeWvl++YvFAyOjjKfys3Aqo9KxkzgxxZUmh3KwUH
         DYLDr8VZzs2XGbllvNrKys/KZWOLp0ksW10NaJetCD2opbk71SafMIN9CY562w+sh7MV
         A3IGLvSs3ilA+Io9xpmoerZS6Ovi1CcizZHHUE1SCbcMg0xqmFmeOu3ngzXrxCmWes10
         By2NilzVMHxyFcTovHXA0SL3kVELvYyohfcPx0u03vebt374rkonxLrGLjosBb/JmGWM
         4jGvPoMukibryBtoTDJECa1L+5A4ovQSlzHZGfN0HoHLEULorRnDDIcXOPJ/RrzLy6VU
         VNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344659; x=1785949459;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2FTqa+wpV5gGUjsvj1qPbJvazcpSNH5mYFnUJHzzvsk=;
        b=EtUkL9A09XkkwfvTgObcf8PS5EaC9eAHBE/jntIKpcfpTyhNDV4GBvZysK2OMOv8uT
         wqtlSVOuJDaiR6qp3Hh1UrLXF0IKJw95lGuzgRkwW5ipaSTIPscHtM/uZQJXbdKhxOiD
         l27BO356RjBjUdJW/HsNX+JJGeuTNH3eUIWFaIUhOdyRqghWChN2dd3TG1iUl416FvGq
         CF+sIN2Kcot9QWmxf0bpBXeeW+SOhrxPplS+bvAmQS16Y02kAaruKaInFEusYzR2yN8s
         ptDE4feAkQej4pNByZjEkAhm0XVXGOoQTHEkWL32uTKBox0JgBT7/mu314Kab4v4+rrG
         iZvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrf5IJGQp1if64OxIzdRTtbu3fjyqsR4GCjjfJCQXEsbgTDthB0RjWjcJdPi2CpL0ynXlXMKoNCmZqOOb1A0z/t@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhj30GXBDYinCioR7+LiCh+cMYpLYx+u5gHCr7du1bKBEMgxy5
	E8Kym1wP/6cv0CrGPMURFX3z/DZVjZ2PuHb/tMbyOQLw3T8QSWCkPOwb0e/fDYF8EmKnSFPmmou
	1ZBm/0g==
X-Received: from pfob13.prod.google.com ([2002:aa7:870d:0:b0:845:e386:e036])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:148c:b0:84e:915:d7eb
 with SMTP id d2e1a72fcca58-84e93264378mr8131190b3a.37.1785344658393; Wed, 29
 Jul 2026 10:04:18 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:04:15 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729170416.41904-1-ctshao@google.com>
Subject: [PATCH v3] perf stat: Include PMU name and split uncore events per
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
   underlying PMU instance changes across PMU events.
3. Updating perf_json_output_lint.py to recognize the new "pmu" key in
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

v3:
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
 tools/perf/util/stat-display.c                | 48 ++++++++++++++-----
 2 files changed, 37 insertions(+), 12 deletions(-)

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
index b337cc23f413..6785e2c442bd 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -397,6 +397,8 @@ static void print_aggr_id_json(struct perf_stat_config =
*config, struct outstate
 			json_out(os, "\"cpu\" : \"%d\"",
 				id.cpu.cpu);
 		}
+		if (evsel && evsel->pmu && (!evsel->pmu->is_core || evsel__is_hybrid(evs=
el)))
+			json_out(os, "\"pmu\" : \"%s\"", evsel->pmu->name);
 		break;
 	case AGGR_THREAD:
 		json_out(os, "\"thread\" : \"%s-%d\"",
@@ -1012,11 +1014,12 @@ static void print_counter_aggrdata(struct perf_stat=
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
@@ -1031,7 +1034,6 @@ static void print_metric_begin(struct perf_stat_confi=
g *config,
 		else
 			fprintf(config->output, "%s", os->timestamp);
 	}
-	evsel =3D evlist__first(evlist);
 	id =3D config->aggr_map->map[aggr_idx];
 	aggr =3D &evsel->stats->aggr[aggr_idx];
 	aggr_printout(config, os, evsel, id, aggr->nr);
@@ -1069,7 +1071,7 @@ static void print_aggr(struct perf_stat_config *confi=
g,
 	 * Without each counter has its own line.
 	 */
 	cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
-		print_metric_begin(config, evlist, os, aggr_idx);
+		print_metric_begin(config, evlist, os, aggr_idx, NULL);

 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, aggr_idx, os);
@@ -1095,7 +1097,7 @@ static void print_aggr_cgroup(struct perf_stat_config=
 *config,
 		os->cgrp =3D evsel->cgrp;

 		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
-			print_metric_begin(config, evlist, os, aggr_idx);
+			print_metric_begin(config, evlist, os, aggr_idx, NULL);

 			evlist__for_each_entry(evlist, counter) {
 				if (counter->cgrp !=3D os->cgrp)
@@ -1131,7 +1133,8 @@ static void print_no_aggr_metric(struct perf_stat_con=
fig *config,

 	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist__core(evlist)->user_reque=
sted_cpus) {
 		struct evsel *counter;
-		bool first =3D true;
+		struct perf_pmu *last_pmu =3D NULL;
+		bool line_open =3D false;

 		evlist__for_each_entry(evlist, counter) {
 			u64 ena, run, val;
@@ -1146,13 +1149,34 @@ static void print_no_aggr_metric(struct perf_stat_c=
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
+
+				if (!evsel__is_tool(counter)) {
+					if (config->json_output && line_open &&
+					    (!last_pmu || pmu !=3D last_pmu)) {
+						print_metric_end(config, os);
+						line_open =3D false;
+					}
+					if (!line_open) {
+						print_metric_begin(config, evlist, os,
+								   aggr_idx, counter);
+						line_open =3D true;
+					}
+					last_pmu =3D pmu;
+				} else if (!line_open) {
+					print_metric_begin(config, evlist, os,
+							   aggr_idx, counter);
+					line_open =3D true;
+				}
 			}
+
 			val =3D ps->aggr[aggr_idx].counts.val;
 			ena =3D ps->aggr[aggr_idx].counts.ena;
 			run =3D ps->aggr[aggr_idx].counts.run;
@@ -1160,7 +1184,7 @@ static void print_no_aggr_metric(struct perf_stat_con=
fig *config,
 			uval =3D val * counter->scale;
 			printout(config, os, uval, run, ena, 1.0, aggr_idx);
 		}
-		if (!first)
+		if (line_open)
 			print_metric_end(config, os);
 	}
 }
@@ -1523,7 +1547,7 @@ static void print_cgroup_counter(struct perf_stat_con=
fig *config, struct evlist
 				print_metric_end(config, os);

 			os->cgrp =3D counter->cgrp;
-			print_metric_begin(config, evlist, os, /*aggr_idx=3D*/0);
+			print_metric_begin(config, evlist, os, /*aggr_idx=3D*/0, NULL);
 		}

 		print_counter(config, counter, os);
@@ -1573,7 +1597,7 @@ void evlist__print_counters(struct evlist *evlist, st=
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
2.55.0.508.g3f0d502094-goog

