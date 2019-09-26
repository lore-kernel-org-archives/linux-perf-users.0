From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/66] libperf: Move 'sample_id' from 'struct evsel' to 'struct perf_evsel'
Date: Wed, 25 Sep 2019 21:32:15 -0300
Message-ID: <20190926003244.13962-38-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move 'sample_id' array from 'struct evsel' to libperf's 'struct perf_evsel'.

Committer notes:

Removed the 'struct xyarray' from util/evsel.h, not needed anymore
there.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c               |  2 +-
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/util/evlist.c                |  4 ++--
 tools/perf/util/evsel.c                 | 12 ++++++------
 tools/perf/util/evsel.h                 |  2 --
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0d55eb6bd6e2..468fc49420ce 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -235,7 +235,7 @@ static int write_stat_round_event(u64 tm, u64 type)
 #define WRITE_STAT_ROUND_EVENT(time, interval) \
 	write_stat_round_event(time, PERF_STAT_ROUND_TYPE__ ## interval)
 
-#define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
+#define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
 static int
 perf_evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 60daee6db914..1ddb969f7807 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -17,6 +17,7 @@ struct perf_evsel {
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
+	struct xyarray		*sample_id;
 
 	/* parse modifier helper */
 	int			 nr_members;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 13595e8e6b4b..84b409802298 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -50,7 +50,7 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 #endif
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
-#define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
+#define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads)
@@ -1021,7 +1021,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 
 	evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->core.attr.read_format & PERF_FORMAT_ID) &&
-		    evsel->sample_id == NULL &&
+		    evsel->core.sample_id == NULL &&
 		    perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
 			return -ENOMEM;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 566c9413246c..cb1ada8cf4a4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1235,14 +1235,14 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 	if (evsel->core.system_wide)
 		nthreads = 1;
 
-	evsel->sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
-	if (evsel->sample_id == NULL)
+	evsel->core.sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
+	if (evsel->core.sample_id == NULL)
 		return -ENOMEM;
 
 	evsel->id = zalloc(ncpus * nthreads * sizeof(u64));
 	if (evsel->id == NULL) {
-		xyarray__delete(evsel->sample_id);
-		evsel->sample_id = NULL;
+		xyarray__delete(evsel->core.sample_id);
+		evsel->core.sample_id = NULL;
 		return -ENOMEM;
 	}
 
@@ -1251,8 +1251,8 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 
 static void perf_evsel__free_id(struct evsel *evsel)
 {
-	xyarray__delete(evsel->sample_id);
-	evsel->sample_id = NULL;
+	xyarray__delete(evsel->core.sample_id);
+	evsel->core.sample_id = NULL;
 	zfree(&evsel->id);
 	evsel->ids = 0;
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index f757ff449a17..2d2c6cad81f8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -96,7 +96,6 @@ enum perf_tool_event {
 
 struct bpf_object;
 struct perf_counts;
-struct xyarray;
 
 /** struct evsel - event selector
  *
@@ -117,7 +116,6 @@ struct evsel {
 	struct perf_evsel	core;
 	struct evlist	*evlist;
 	char			*filter;
-	struct xyarray		*sample_id;
 	u64			*id;
 	struct perf_counts	*counts;
 	struct perf_counts	*prev_raw_counts;
-- 
2.21.0
