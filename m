From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/19] perf evsel: Restore evsel->priv as a tool private area
Date: Fri,  3 Nov 2017 10:54:48 -0300
Message-ID: <20171103135503.4921-5-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, yuzhoujian <yuzhoujian@didichuxing.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we started using it for stats and did it not just in
builtin-stat.c, but also for builtin-script.c, then it stopped being a
tool private area, so introduce a new pointer for these stats and leave
->priv to its original purpose.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: yuzhoujian <yuzhoujian@didichuxing.com>
Fixes: cfc8874a4859 ("perf script: Process cpu/threads maps")
Link: http://lkml.kernel.org/n/tip-jtpzx3rjqo78snmmsdzwb2eb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c |  4 ++--
 tools/perf/util/evsel.h   |  3 +++
 tools/perf/util/stat.c    | 16 ++++++++--------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index dd525417880a..988bdfa5d832 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -845,7 +845,7 @@ static void print_noise(struct perf_evsel *evsel, double avg)
 	if (run_count == 1)
 		return;
 
-	ps = evsel->priv;
+	ps = evsel->stats;
 	print_noise_pct(stddev_stats(&ps->res_stats[0]), avg);
 }
 
@@ -1432,7 +1432,7 @@ static void counter_aggr_cb(struct perf_evsel *counter, void *data,
 			    bool first __maybe_unused)
 {
 	struct caggr_data *cd = data;
-	struct perf_stat_evsel *ps = counter->priv;
+	struct perf_stat_evsel *ps = counter->stats;
 
 	cd->avg += avg_stats(&ps->res_stats[0]);
 	cd->avg_enabled += avg_stats(&ps->res_stats[1]);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index db658785d828..64782b19089d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -68,6 +68,8 @@ struct perf_evsel_config_term {
 	} val;
 };
 
+struct perf_stat_evsel;
+
 /** struct perf_evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -101,6 +103,7 @@ struct perf_evsel {
 	const char		*unit;
 	struct event_format	*tp_format;
 	off_t			id_offset;
+	struct perf_stat_evsel  *stats;
 	void			*priv;
 	u64			db_id;
 	struct cgroup_sel	*cgrp;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 35e9848734d6..933de91831fa 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -69,7 +69,7 @@ double rel_stddev_stats(double stddev, double avg)
 bool __perf_evsel_stat__is(struct perf_evsel *evsel,
 			   enum perf_stat_evsel_id id)
 {
-	struct perf_stat_evsel *ps = evsel->priv;
+	struct perf_stat_evsel *ps = evsel->stats;
 
 	return ps->id == id;
 }
@@ -93,7 +93,7 @@ static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 
 void perf_stat_evsel_id_init(struct perf_evsel *evsel)
 {
-	struct perf_stat_evsel *ps = evsel->priv;
+	struct perf_stat_evsel *ps = evsel->stats;
 	int i;
 
 	/* ps->id is 0 hence PERF_STAT_EVSEL_ID__NONE by default */
@@ -109,7 +109,7 @@ void perf_stat_evsel_id_init(struct perf_evsel *evsel)
 static void perf_evsel__reset_stat_priv(struct perf_evsel *evsel)
 {
 	int i;
-	struct perf_stat_evsel *ps = evsel->priv;
+	struct perf_stat_evsel *ps = evsel->stats;
 
 	for (i = 0; i < 3; i++)
 		init_stats(&ps->res_stats[i]);
@@ -119,8 +119,8 @@ static void perf_evsel__reset_stat_priv(struct perf_evsel *evsel)
 
 static int perf_evsel__alloc_stat_priv(struct perf_evsel *evsel)
 {
-	evsel->priv = zalloc(sizeof(struct perf_stat_evsel));
-	if (evsel->priv == NULL)
+	evsel->stats = zalloc(sizeof(struct perf_stat_evsel));
+	if (evsel->stats == NULL)
 		return -ENOMEM;
 	perf_evsel__reset_stat_priv(evsel);
 	return 0;
@@ -128,11 +128,11 @@ static int perf_evsel__alloc_stat_priv(struct perf_evsel *evsel)
 
 static void perf_evsel__free_stat_priv(struct perf_evsel *evsel)
 {
-	struct perf_stat_evsel *ps = evsel->priv;
+	struct perf_stat_evsel *ps = evsel->stats;
 
 	if (ps)
 		free(ps->group_data);
-	zfree(&evsel->priv);
+	zfree(&evsel->stats);
 }
 
 static int perf_evsel__alloc_prev_raw_counts(struct perf_evsel *evsel,
@@ -318,7 +318,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct perf_evsel *counter)
 {
 	struct perf_counts_values *aggr = &counter->counts->aggr;
-	struct perf_stat_evsel *ps = counter->priv;
+	struct perf_stat_evsel *ps = counter->stats;
 	u64 *count = counter->counts->aggr.values;
 	u64 val;
 	int i, ret;
-- 
2.13.6
