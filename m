From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 50/91] perf evsel: Rename perf_evsel__compute_deltas() to evsel__compute_deltas()
Date: Wed,  6 May 2020 12:21:53 -0300
Message-ID: <20200506152234.21977-51-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 6 +++---
 tools/perf/util/evsel.h | 4 ++--
 tools/perf/util/stat.c  | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6a571d322bb2..db6d2a5f9b3c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1283,8 +1283,8 @@ void evsel__delete(struct evsel *evsel)
 	free(evsel);
 }
 
-void perf_evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
-				struct perf_counts_values *count)
+void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
+			   struct perf_counts_values *count)
 {
 	struct perf_counts_values tmp;
 
@@ -1440,7 +1440,7 @@ int __perf_evsel__read_on_cpu(struct evsel *evsel,
 	if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) <= 0)
 		return -errno;
 
-	perf_evsel__compute_deltas(evsel, cpu, thread, &count);
+	evsel__compute_deltas(evsel, cpu, thread, &count);
 	perf_counts_values__scale(&count, scale, NULL);
 	*perf_counts(evsel->counts, cpu, thread) = count;
 	return 0;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e2a0ebe59365..32015057429c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -151,8 +151,8 @@ static inline int evsel__nr_cpus(struct evsel *evsel)
 void perf_counts_values__scale(struct perf_counts_values *count,
 			       bool scale, s8 *pscaled);
 
-void perf_evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
-				struct perf_counts_values *count);
+void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
+			   struct perf_counts_values *count);
 
 int perf_evsel__object_config(size_t object_size,
 			      int (*init)(struct evsel *evsel),
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index da3a206e95f7..4e6e770f39aa 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -302,7 +302,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 	case AGGR_NODE:
 	case AGGR_NONE:
 		if (!evsel->snapshot)
-			perf_evsel__compute_deltas(evsel, cpu, thread, count);
+			evsel__compute_deltas(evsel, cpu, thread, count);
 		perf_counts_values__scale(count, config->scale, NULL);
 		if ((config->aggr_mode == AGGR_NONE) && (!evsel->percore)) {
 			perf_stat__update_shadow_stats(evsel, count->val,
@@ -384,7 +384,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 		return 0;
 
 	if (!counter->snapshot)
-		perf_evsel__compute_deltas(counter, -1, -1, aggr);
+		evsel__compute_deltas(counter, -1, -1, aggr);
 	perf_counts_values__scale(aggr, config->scale, &counter->counts->scaled);
 
 	for (i = 0; i < 3; i++)
-- 
2.21.1
