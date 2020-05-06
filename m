From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 49/91] perf evsel: Rename perf_evsel__nr_cpus() to evsel__nr_cpus()
Date: Wed,  6 May 2020 12:21:52 -0300
Message-ID: <20200506152234.21977-50-acme@kernel.org>
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
 tools/perf/builtin-script.c    |  2 +-
 tools/perf/util/evsel.h        |  2 +-
 tools/perf/util/stat-display.c | 10 +++++-----
 tools/perf/util/stat.c         |  4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3aadefd2791e..907b5c9f6a4e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1977,7 +1977,7 @@ static struct scripting_ops	*scripting_ops;
 static void __process_stat(struct evsel *counter, u64 tstamp)
 {
 	int nthreads = perf_thread_map__nr(counter->core.threads);
-	int ncpus = perf_evsel__nr_cpus(counter);
+	int ncpus = evsel__nr_cpus(counter);
 	int cpu, thread;
 	static int header_printed;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 7ff37c4cdf9f..e2a0ebe59365 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -143,7 +143,7 @@ static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 	return perf_evsel__cpus(&evsel->core);
 }
 
-static inline int perf_evsel__nr_cpus(struct evsel *evsel)
+static inline int evsel__nr_cpus(struct evsel *evsel)
 {
 	return evsel__cpus(evsel)->nr;
 }
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 679aaa655824..b0e5d8505f57 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -333,7 +333,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	if (config->aggr_mode == AGGR_GLOBAL)
 		return 0;
 
-	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
+	for (i = 0; i < evsel__nr_cpus(evsel); i++) {
 		int cpu2 = evsel__cpus(evsel)->map[i];
 
 		if (config->aggr_get_id(config, evlist->core.cpus, cpu2) == id)
@@ -508,7 +508,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 		id = config->aggr_map->map[s];
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
-			for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
+			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
 				s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);
 				if (s2 != id)
 					continue;
@@ -599,7 +599,7 @@ static void aggr_cb(struct perf_stat_config *config,
 	struct aggr_data *ad = data;
 	int cpu, s2;
 
-	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
+	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
 		struct perf_counts_values *counts;
 
 		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
@@ -847,7 +847,7 @@ static void print_counter(struct perf_stat_config *config,
 	double uval;
 	int cpu;
 
-	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
+	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
 		struct aggr_data ad = { .cpu = cpu };
 
 		if (!collect_data(config, counter, counter_cb, &ad))
@@ -1148,7 +1148,7 @@ static void print_percore_thread(struct perf_stat_config *config,
 	int s, s2, id;
 	bool first = true;
 
-	for (int i = 0; i < perf_evsel__nr_cpus(counter); i++) {
+	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
 		s2 = config->aggr_get_id(config, evsel__cpus(counter), i);
 		for (s = 0; s < config->aggr_map->nr; s++) {
 			id = config->aggr_map->map[s];
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 242476eb808c..da3a206e95f7 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -173,7 +173,7 @@ static void perf_evsel__reset_prev_raw_counts(struct evsel *evsel)
 
 static int perf_evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
 {
-	int ncpus = perf_evsel__nr_cpus(evsel);
+	int ncpus = evsel__nr_cpus(evsel);
 	int nthreads = perf_thread_map__nr(evsel->core.threads);
 
 	if (perf_evsel__alloc_stat_priv(evsel) < 0 ||
@@ -334,7 +334,7 @@ static int process_counter_maps(struct perf_stat_config *config,
 				struct evsel *counter)
 {
 	int nthreads = perf_thread_map__nr(counter->core.threads);
-	int ncpus = perf_evsel__nr_cpus(counter);
+	int ncpus = evsel__nr_cpus(counter);
 	int cpu, thread;
 
 	if (counter->core.system_wide)
-- 
2.21.1
