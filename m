From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 50/57] libperf: Do not export perf_evsel__init()/perf_evlist__init()
Date: Mon, 21 Oct 2019 10:38:27 -0300
Message-ID: <20191021133834.25998-51-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no point in exporting perf_evsel__init()/perf_evlist__init(),
it's called from perf_evsel__new()/perf_evlist__new() respectively.

It's used only from perf where perf_evsel()/perf_evlist() is embedded
perf's evsel/evlist.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/evlist.h | 1 +
 tools/perf/lib/include/internal/evsel.h  | 1 +
 tools/perf/lib/include/perf/evlist.h     | 1 -
 tools/perf/lib/include/perf/evsel.h      | 2 --
 tools/perf/lib/libperf.map               | 2 --
 5 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 20d90e29fc0e..a2fbccf1922f 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -50,6 +50,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp);
 
+void perf_evlist__init(struct perf_evlist *evlist);
 void perf_evlist__exit(struct perf_evlist *evlist);
 
 /**
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index a69b8299c36f..1ffd083b235e 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -50,6 +50,7 @@ struct perf_evsel {
 	bool			 system_wide;
 };
 
+void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr);
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__close_fd(struct perf_evsel *evsel);
 void perf_evsel__free_fd(struct perf_evsel *evsel);
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 8c4b3c28535e..0a7479dc13bf 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -10,7 +10,6 @@ struct perf_evsel;
 struct perf_cpu_map;
 struct perf_thread_map;
 
-LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
 LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 				  struct perf_evsel *evsel);
 LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 4388667f265c..557f5815a9c9 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -21,8 +21,6 @@ struct perf_counts_values {
 	};
 };
 
-LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
-				  struct perf_event_attr *attr);
 LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
 LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 8be02afc324b..7be1af8a546c 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -21,7 +21,6 @@ LIBPERF_0.0.1 {
 		perf_evsel__delete;
 		perf_evsel__enable;
 		perf_evsel__disable;
-		perf_evsel__init;
 		perf_evsel__open;
 		perf_evsel__close;
 		perf_evsel__read;
@@ -34,7 +33,6 @@ LIBPERF_0.0.1 {
 		perf_evlist__close;
 		perf_evlist__enable;
 		perf_evlist__disable;
-		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
 		perf_evlist__next;
-- 
2.21.0
