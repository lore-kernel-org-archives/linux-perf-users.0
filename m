From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 028/107] perf stat: Move loaded out of struct perf_counts_values
Date: Mon, 29 Jul 2019 23:54:51 -0300
Message-ID: <20190730025610.22603-29-acme@kernel.org>
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

Because we will make struct perf_counts_values public in following
patches and 'loaded' is implementation related.

No functional change is expected.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c |  4 ++--
 tools/perf/util/counts.c  | 11 +++++++++++
 tools/perf/util/counts.h  | 14 +++++++++++++-
 tools/perf/util/evsel.c   |  3 ++-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 352cf39d7c2f..7b9c26f9cf34 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -287,7 +287,7 @@ static int read_counter(struct perf_evsel *counter, struct timespec *rs)
 			 * The leader's group read loads data into its group members
 			 * (via perf_evsel__read_counter) and sets threir count->loaded.
 			 */
-			if (!count->loaded &&
+			if (!perf_counts__is_loaded(counter->counts, cpu, thread) &&
 			    read_single_counter(counter, cpu, thread, rs)) {
 				counter->counts->scaled = -1;
 				perf_counts(counter->counts, cpu, thread)->ena = 0;
@@ -295,7 +295,7 @@ static int read_counter(struct perf_evsel *counter, struct timespec *rs)
 				return -1;
 			}
 
-			count->loaded = false;
+			perf_counts__set_loaded(counter->counts, cpu, thread, false);
 
 			if (STAT_RECORD) {
 				if (perf_evsel__write_stat_event(counter, cpu, thread, count)) {
diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 88be9c4365e0..01ee81df3fe5 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -19,6 +19,15 @@ struct perf_counts *perf_counts__new(int ncpus, int nthreads)
 		}
 
 		counts->values = values;
+
+		values = xyarray__new(ncpus, nthreads, sizeof(bool));
+		if (!values) {
+			xyarray__delete(counts->values);
+			free(counts);
+			return NULL;
+		}
+
+		counts->loaded = values;
 	}
 
 	return counts;
@@ -27,6 +36,7 @@ struct perf_counts *perf_counts__new(int ncpus, int nthreads)
 void perf_counts__delete(struct perf_counts *counts)
 {
 	if (counts) {
+		xyarray__delete(counts->loaded);
 		xyarray__delete(counts->values);
 		free(counts);
 	}
@@ -34,6 +44,7 @@ void perf_counts__delete(struct perf_counts *counts)
 
 static void perf_counts__reset(struct perf_counts *counts)
 {
+	xyarray__reset(counts->loaded);
 	xyarray__reset(counts->values);
 }
 
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 0d1050ccc586..460b56ce3252 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -13,13 +13,13 @@ struct perf_counts_values {
 		};
 		u64 values[3];
 	};
-	bool	loaded;
 };
 
 struct perf_counts {
 	s8			  scaled;
 	struct perf_counts_values aggr;
 	struct xyarray		  *values;
+	struct xyarray		  *loaded;
 };
 
 
@@ -29,6 +29,18 @@ perf_counts(struct perf_counts *counts, int cpu, int thread)
 	return xyarray__entry(counts->values, cpu, thread);
 }
 
+static inline bool
+perf_counts__is_loaded(struct perf_counts *counts, int cpu, int thread)
+{
+	return *((bool *) xyarray__entry(counts->loaded, cpu, thread));
+}
+
+static inline void
+perf_counts__set_loaded(struct perf_counts *counts, int cpu, int thread, bool loaded)
+{
+	*((bool *) xyarray__entry(counts->loaded, cpu, thread)) = loaded;
+}
+
 struct perf_counts *perf_counts__new(int ncpus, int nthreads);
 void perf_counts__delete(struct perf_counts *counts);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7d1757a2ec46..d23b9574f793 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1439,7 +1439,8 @@ perf_evsel__set_count(struct perf_evsel *counter, int cpu, int thread,
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
-	count->loaded = true;
+
+	perf_counts__set_loaded(counter->counts, cpu, thread, true);
 }
 
 static int
-- 
2.21.0
