Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9744A0C
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784147460; cv=none; b=gV2jn4D9bBP/+fTgY4RqKbUaO3lnxoqadJ6csZFd513L67bseizzZR5BtZeopwRxNEVwZxQs6QZVxbVv01M+pcSWr8dBsVgOLtJ/wkfK8PNlwFbj5Wh2cnLJtDW0IDSgZhVrMNLGOf/geks3P4PAPHM1PbnAZlOJcmBvdbHVejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784147460; c=relaxed/simple;
	bh=Cc7q1aV6D9RJp9nnMDZNoSJiisXV5MrqNJpCytO0yb0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QeNPtoiIQBLZwWVe/Z55Fnod2kFzOkLxV7BiLf2yPjJjBB5MUwP1NEIWqLPogATIP8DdCuS1Zd7lu+PbRoscdmZ2CjsVc9Wo8pxr0OIa3VRwM2NPlfuFoag7UHY3yny4S79qfC+0nHoFCkZDQ1NNh1Mlj+ZKl7BIi29rgRcIEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFwUjq9x; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFwUjq9x"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ca124bf0189so865417a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784147458; x=1784752258; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vZVHf6eclqEMpYBsawja8gmROgN0BYtvnwqT7xM1FQw=;
        b=vFwUjq9xGJ24B4dt0ZjMP/0OsecQNIxnUTOsDLVCiRMgbDoV+5eOu85T0kkh5B0aBi
         91UlSgXkmKfNFaQnPgvQQXdlI3nFLfNdC6KCxRU58ForeTPTEp0lv9khuD2AuB5qw4EQ
         ZoL3S3JDj/mM9uFZxaNpzYDSmdVlZpCcraNE4VuRqsiI8TECWaaFzIB+Sb6VigegOiZ9
         zX0hU1RNnHN47o/8/rZKxUkq6wHE0S8D6v5wm5Ul9nACLDpi3ZfyJPySUdZ/jbJoGwdS
         6Rt7QlIpz5ucwIQwJEydxXQ6EohybMmXLV9XjFCfnAFdis2ojNFft+jTr/Zr6MiWV2zs
         VvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784147458; x=1784752258;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZVHf6eclqEMpYBsawja8gmROgN0BYtvnwqT7xM1FQw=;
        b=C31+CAUkejVNNgIFQbqcLpw7NArEjvidfCgqUO8PZfQlWPDD/yOReyoi71b3ABydnK
         bSg3eEuZXQOirabY9W4SZJMB7l265u8+71FqbNUX0MmcBDJIuYyO+Lojg20AAlGQd1eg
         Re39SYYG6XO8U72Q0fWXFPVsNaxWtsWy82uHnfHzrhkRAEwvzaNSt2EhaCuwDT1f8X8F
         Ks0L06yrVKUSqambqT2e7eN4E5ce63TPZ9wVB/hgoh3hyNi4LTwRCzU/FQbZkYP86bjn
         czRRe50ia8G9Y+Mf/+EGyBa8UsZi4vE5GvLqyB3Yqmi3r9flxKt0mYwV5TTnhpPvX/vt
         LWwQ==
X-Forwarded-Encrypted: i=1; AHgh+RotYOcBwixv5MlJc4hIjZzDqKATo7plVPHymbAfaCqTXyzy1M6L5d1VJKL6DTrw5R+ZoAQDEdaW54nJuh3OSv6T@vger.kernel.org
X-Gm-Message-State: AOJu0YwwwMKi2lrq59mieao2doABhFA+f0xcV7GqA7cwS7tGFfvcGf6S
	7p69usjMjakRMxXL0w044uxvQIrkmcufyc4ajGEQ34NQEoMavC94Oov+XGaEV/9xU5LVhcY8xc5
	JmJ+RJg==
X-Received: from pgcv15.prod.google.com ([2002:a05:6a02:530f:b0:c91:7774:1541])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d502:b0:3c3:6d49:9c29
 with SMTP id adf61e73a8af0-3c384c0f335mr794022637.27.1784147457942; Wed, 15
 Jul 2026 13:30:57 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:30:55 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260715203055.2981363-1-ctshao@google.com>
Subject: [PATCH v2] perf stat: Include PMU name and split uncore events per
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

v2:
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
index f94f1324d24a..61d634f8be2e 100644
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
@@ -1143,13 +1146,34 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 				if (config->aggr_map->map[aggr_idx].cpu.cpu == cpu.cpu)
 					break;
 			}
+			if (aggr_idx >= config->aggr_map->nr)
+				continue;

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
+					if (config->json_output && line_open &&
+					    (!last_pmu || pmu != last_pmu)) {
+						print_metric_end(config, os);
+						line_open = false;
+					}
+					if (!line_open) {
+						print_metric_begin(config, evlist, os,
+								   aggr_idx, counter);
+						line_open = true;
+					}
+					last_pmu = pmu;
+				} else if (!line_open) {
+					print_metric_begin(config, evlist, os,
+							   aggr_idx, counter);
+					line_open = true;
+				}
 			}
+
 			val = ps->aggr[aggr_idx].counts.val;
 			ena = ps->aggr[aggr_idx].counts.ena;
 			run = ps->aggr[aggr_idx].counts.run;
@@ -1157,7 +1181,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			uval = val * counter->scale;
 			printout(config, os, uval, run, ena, 1.0, aggr_idx);
 		}
-		if (!first)
+		if (line_open)
 			print_metric_end(config, os);
 	}
 }
@@ -1520,7 +1544,7 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 				print_metric_end(config, os);

 			os->cgrp = counter->cgrp;
-			print_metric_begin(config, evlist, os, /*aggr_idx=*/0);
+			print_metric_begin(config, evlist, os, /*aggr_idx=*/0, NULL);
 		}

 		print_counter(config, counter, os);
@@ -1570,7 +1594,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
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

