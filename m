Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6C412C0E
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050870; cv=none; b=R6k1jZ0QMaIqIOlecYVLjX2JAfRl4uUI0MGptKF6eZElCcsPsmkL4nHSNgEAxTafPEyfBplmG0n4+y3SLi4ONcqsag6nQtFLIe6oxbM2/ErdTusbND6jurNo50niWfvqK9KLkPi6QdQ4SoNl1Y30E+G9GtpVOCc1BXJoZjAD/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050870; c=relaxed/simple;
	bh=qmrtKiGF0ZVk8eUpawKEpUhSUqva96lDh69er5MYvQA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZH8wXA0+ofwdRjSjbQYtvroAQGNjjl2EpbAq/JADqshxeFIizVw0iHXfrXONA10dD8tJax/gnuDZR3wcTqWM+7Mb/4NmCSOOLWQ+1RE2xJPIRctjN7pO+Ld1UUALS++/zoi9Q5LEoH3Qoekg0S1skDUV7XZYzLCa1nMudIZjLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLJHi+r2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLJHi+r2"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845317fa7e6so8329874b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784050866; x=1784655666; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7rvBy7DlOMve5rkrpKhLf6NBngXNk1okw769cOawHiY=;
        b=dLJHi+r2dIhITXBh04Dj02nx0NXK7wO7afgzRrdLFBpkJOCpwgkaU95N5WHoTp3UJu
         C7OxbOSDFQxVGpSNVVzaX874lZwlfBGUCJ8aRqMReW+kO5t+DljEBdogeKA6FfltSzzb
         QcaLoQixTV5mKm9a+16pMPpAwzydgu6s34VMrtI/5MS+umQQoACFVtlCmKSRHPCVs0Ej
         EFvFE6tLtMW2kmoCfQbft+B3Ow44yd1AyOnPXoDBvRWPxI1Dq37SXrbQOkg5tjiHKhws
         aQJHVBXtynhUEdZQX6tBeAEinN7Jetv5U8yMe9lyRHzXImgRHtlOwvVzyl6r4MD70P6s
         x3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784050866; x=1784655666;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rvBy7DlOMve5rkrpKhLf6NBngXNk1okw769cOawHiY=;
        b=swDK1ecCABE58pP/JlZqpSGrrgPWPpQsKo0gd4tdz64uRRJbGEN+ulNnWEVEsUp7aO
         7Zw85DKowUj13MuoXcGdGpPNpSOZfToMCtvIzYrmbDYJBeETjaDEXRSGQiNDG0c53iWJ
         chNduAL16fD5nkJuLRfJH5OWZDcJrQ5X4wY+LMBeRBeVUGOIiZEH67wWIgxr42Bm1J44
         slDxlEtGqG4Qwzc0C+FCLnMftdGGblVdOY8ueV4/BjP2H4qRgpGDg8xKxDap4IeXjI/B
         hFeWZJ5Q4YDS6rYNESeSgWPE9vaJvzO+WZgNALtQFNyS6qEliXqA0xAXVoinh269Eujf
         95CA==
X-Forwarded-Encrypted: i=1; AHgh+Rqcu6dHdofVa5TfFQfe3mmweYqQcd9IgdkNEXCafZQZczaToKXf/Ji9c/vx0ByIFMyziJO+pppz42Vs5aFLrp/U@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9squQVwbt8uhx9HccTKY/XETdX8rxfMWgWhGzwxLj17HRv7Ik
	Fmna53+rHWsJzQL0hSMg63zp2obdZiVfQsp9Yu0Ed9zdZilPScMgFaRGlmIWpNUwz0q60gqUssh
	eWcKLsw==
X-Received: from pfblh15.prod.google.com ([2002:a05:6a00:710f:b0:845:eada:32d2])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cd4:b0:847:8b1d:230d
 with SMTP id d2e1a72fcca58-84889611e43mr14054895b3a.3.1784050865536; Tue, 14
 Jul 2026 10:41:05 -0700 (PDT)
Date: Tue, 14 Jul 2026 10:40:52 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714174052.1826692-1-ctshao@google.com>
Subject: [PATCH] perf stat: Include PMU name and split uncore events per PMU
 in metric-only JSON output
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

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

Example output:
  $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
  {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_0", "MB/s  iio_bandwidth_read" : "0.0"}
  {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_1", "MB/s  iio_bandwidth_read" : "0.1"}
  {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_11", "MB/s  iio_bandwidth_read" : "0.0"}
  ...
  {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_0", "MB/s  iio_bandwidth_read" : "0.0"}
  {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "MB/s  iio_bandwidth_read" : "0.0"}
  {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "MB/s  iio_bandwidth_read" : "0.0"}

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 .../tests/shell/lib/perf_json_output_lint.py  |  1 +
 tools/perf/util/stat-display.c                | 41 +++++++++++++------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index dafbde56cc76..36767905fcdb 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -64,6 +64,7 @@ def check_json_output(expected_items):
       'metric-threshold': lambda x: x in ['unknown', 'good', 'less good', 'nearly bad', 'bad'],
       'metricgroup': lambda x: True,
       'node': lambda x: True,
+      'pmu': lambda x: True,
       'pcnt-running': lambda x: isfloat(x),
       'socket': lambda x: True,
       'thread': lambda x: True,
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f94f1324d24a..d7f1feb63878 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -397,6 +397,8 @@ static void print_aggr_id_json(struct perf_stat_config *config, struct outstate
 			json_out(os, "\"cpu\" : \"%d\"",
 				id.cpu.cpu);
 		}
+		if (evsel && evsel->pmu && (!evsel->pmu->is_core || evsel__is_hybrid(evsel)))
+			json_out(os, "\"pmu\" : \"%s\"", evsel->pmu->name);
 		break;
 	case AGGR_THREAD:
 		json_out(os, "\"thread\" : \"%s-%d\"",
@@ -1009,11 +1011,12 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 
 static void print_metric_begin(struct perf_stat_config *config,
 			       struct evlist *evlist,
-			       struct outstate *os, int aggr_idx)
+			       struct outstate *os, int aggr_idx,
+			       struct evsel *counter)
 {
 	struct perf_stat_aggr *aggr;
 	struct aggr_cpu_id id;
-	struct evsel *evsel;
+	struct evsel *evsel = counter ?: evlist__first(evlist);
 
 	os->first = true;
 	if (!config->metric_only)
@@ -1028,7 +1031,6 @@ static void print_metric_begin(struct perf_stat_config *config,
 		else
 			fprintf(config->output, "%s", os->timestamp);
 	}
-	evsel = evlist__first(evlist);
 	id = config->aggr_map->map[aggr_idx];
 	aggr = &evsel->stats->aggr[aggr_idx];
 	aggr_printout(config, os, evsel, id, aggr->nr);
@@ -1066,7 +1068,7 @@ static void print_aggr(struct perf_stat_config *config,
 	 * Without each counter has its own line.
 	 */
 	cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
-		print_metric_begin(config, evlist, os, aggr_idx);
+		print_metric_begin(config, evlist, os, aggr_idx, NULL);
 
 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, aggr_idx, os);
@@ -1092,7 +1094,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 		os->cgrp = evsel->cgrp;
 
 		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
-			print_metric_begin(config, evlist, os, aggr_idx);
+			print_metric_begin(config, evlist, os, aggr_idx, NULL);
 
 			evlist__for_each_entry(evlist, counter) {
 				if (counter->cgrp != os->cgrp)
@@ -1128,7 +1130,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 
 	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist__core(evlist)->user_requested_cpus) {
 		struct evsel *counter;
-		bool first = true;
+		struct perf_pmu *last_pmu = NULL;
+		bool line_open = false;
 
 		evlist__for_each_entry(evlist, counter) {
 			u64 ena, run, val;
@@ -1146,10 +1149,24 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 
 			os->evsel = counter;
 			os->id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
-			if (first) {
-				print_metric_begin(config, evlist, os, aggr_idx);
-				first = false;
+
+			if (config->metric_only) {
+				struct perf_pmu *pmu = counter->pmu;
+
+				if (!evsel__is_tool(counter)) {
+					if (config->json_output && line_open && pmu != last_pmu) {
+						print_metric_end(config, os);
+						line_open = false;
+					}
+					if (!line_open) {
+						print_metric_begin(config, evlist, os,
+								   aggr_idx, counter);
+						line_open = true;
+						last_pmu = pmu;
+					}
+				}
 			}
+
 			val = ps->aggr[aggr_idx].counts.val;
 			ena = ps->aggr[aggr_idx].counts.ena;
 			run = ps->aggr[aggr_idx].counts.run;
@@ -1157,7 +1174,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			uval = val * counter->scale;
 			printout(config, os, uval, run, ena, 1.0, aggr_idx);
 		}
-		if (!first)
+		if (line_open)
 			print_metric_end(config, os);
 	}
 }
@@ -1520,7 +1537,7 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 				print_metric_end(config, os);
 
 			os->cgrp = counter->cgrp;
-			print_metric_begin(config, evlist, os, /*aggr_idx=*/0);
+			print_metric_begin(config, evlist, os, /*aggr_idx=*/0, NULL);
 		}
 
 		print_counter(config, counter, os);
@@ -1570,7 +1587,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		} else if (config->cgroup_list) {
 			print_cgroup_counter(config, evlist, &os);
 		} else {
-			print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
+			print_metric_begin(config, evlist, &os, /*aggr_idx=*/0, NULL);
 			evlist__for_each_entry(evlist, counter) {
 				print_counter(config, counter, &os);
 			}
-- 
2.55.0.141.g00534a21ce-goog

