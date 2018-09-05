From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/77] perf evsel: Introduce perf_evsel__store_ids()
Date: Wed,  5 Sep 2018 19:03:55 -0300
Message-ID: <20180905220440.20256-33-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add perf_evsel__store_ids() from stat's store_counter_ids() code to the
evsel class, so that it can be used globally.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 33 +--------------------------------
 tools/perf/util/evsel.c   | 29 +++++++++++++++++++++++++++++
 tools/perf/util/evsel.h   |  1 +
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8291f503d0cc..45bbd156d496 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -497,37 +497,6 @@ static int perf_stat_synthesize_config(bool is_pipe)
 	return 0;
 }
 
-#define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
-
-static int __store_counter_ids(struct perf_evsel *counter)
-{
-	int cpu, thread;
-
-	for (cpu = 0; cpu < xyarray__max_x(counter->fd); cpu++) {
-		for (thread = 0; thread < xyarray__max_y(counter->fd);
-		     thread++) {
-			int fd = FD(counter, cpu, thread);
-
-			if (perf_evlist__id_add_fd(evsel_list, counter,
-						   cpu, thread, fd) < 0)
-				return -1;
-		}
-	}
-
-	return 0;
-}
-
-static int store_counter_ids(struct perf_evsel *counter)
-{
-	struct cpu_map *cpus = counter->cpus;
-	struct thread_map *threads = counter->threads;
-
-	if (perf_evsel__alloc_id(counter, cpus->nr, threads->nr))
-		return -ENOMEM;
-
-	return __store_counter_ids(counter);
-}
-
 static bool perf_evsel__should_store_id(struct perf_evsel *counter)
 {
 	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
@@ -658,7 +627,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			unit_width = l;
 
 		if (perf_evsel__should_store_id(counter) &&
-		    store_counter_ids(counter))
+		    perf_evsel__store_ids(counter, evsel_list))
 			return -1;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1a61628a1c12..4ec909d57e9c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2940,3 +2940,32 @@ struct perf_env *perf_evsel__env(struct perf_evsel *evsel)
 		return evsel->evlist->env;
 	return NULL;
 }
+
+static int store_evsel_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
+{
+	int cpu, thread;
+
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd);
+		     thread++) {
+			int fd = FD(evsel, cpu, thread);
+
+			if (perf_evlist__id_add_fd(evlist, evsel,
+						   cpu, thread, fd) < 0)
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
+{
+	struct cpu_map *cpus = evsel->cpus;
+	struct thread_map *threads = evsel->threads;
+
+	if (perf_evsel__alloc_id(evsel, cpus->nr, threads->nr))
+		return -ENOMEM;
+
+	return store_evsel_ids(evsel, evlist);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 163c960614d3..4f8430a85531 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -481,4 +481,5 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 
 struct perf_env *perf_evsel__env(struct perf_evsel *evsel);
 
+int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist);
 #endif /* __PERF_EVSEL_H */
-- 
2.14.4
