From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 045/107] perf evsel: Rename perf_evsel__cpus() to evsel__cpus()
Date: Mon, 29 Jul 2019 23:55:08 -0300
Message-ID: <20190730025610.22603-46-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evsel__cpus() to evsel__cpus(), so we don't have a name
clash when we add perf_evsel__cpus() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h        | 4 ++--
 tools/perf/util/stat-display.c | 6 +++---
 tools/perf/util/stat.c         | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35f7e7ff3c5e..5fec1ca64f58 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -197,14 +197,14 @@ struct target;
 struct thread_map;
 struct record_opts;
 
-static inline struct perf_cpu_map *perf_evsel__cpus(struct evsel *evsel)
+static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 {
 	return evsel->cpus;
 }
 
 static inline int perf_evsel__nr_cpus(struct evsel *evsel)
 {
-	return perf_evsel__cpus(evsel)->nr;
+	return evsel__cpus(evsel)->nr;
 }
 
 void perf_counts_values__scale(struct perf_counts_values *count,
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index cdfceb5b4d72..f7666d2e6e0c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -109,7 +109,7 @@ static void aggr_printout(struct perf_stat_config *config,
 		} else {
 			fprintf(config->output, "CPU%*d%s ",
 				config->csv_output ? 0 : -5,
-				perf_evsel__cpus(evsel)->map[id],
+				evsel__cpus(evsel)->map[id],
 				config->csv_sep);
 		}
 		break;
@@ -325,7 +325,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 		return 0;
 
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
-		int cpu2 = perf_evsel__cpus(evsel)->map[i];
+		int cpu2 = evsel__cpus(evsel)->map[i];
 
 		if (config->aggr_get_id(config, evlist->cpus, cpu2) == id)
 			return cpu2;
@@ -593,7 +593,7 @@ static void aggr_cb(struct perf_stat_config *config,
 	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
 		struct perf_counts_values *counts;
 
-		s2 = config->aggr_get_id(config, perf_evsel__cpus(counter), cpu);
+		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
 		if (s2 != ad->id)
 			continue;
 		if (first)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index efd934ec02c3..63f7815ceb4f 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -215,7 +215,7 @@ static int check_per_pkg(struct evsel *counter,
 			 struct perf_counts_values *vals, int cpu, bool *skip)
 {
 	unsigned long *mask = counter->per_pkg_mask;
-	struct perf_cpu_map *cpus = perf_evsel__cpus(counter);
+	struct perf_cpu_map *cpus = evsel__cpus(counter);
 	int s;
 
 	*skip = false;
@@ -483,7 +483,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	}
 
 	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
+		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel));
 
 	return perf_evsel__open_per_thread(evsel, evsel->threads);
 }
-- 
2.21.0
