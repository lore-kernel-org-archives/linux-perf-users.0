From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/66] perf tools: Rename perf_evlist__exit() to evlist__exit()
Date: Wed, 25 Sep 2019 21:31:57 -0300
Message-ID: <20190926003244.13962-20-acme@kernel.org>
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

Rename perf_evlist__exit() to evlist__exit(), so we don't have a name
clash when we add perf_evlist__exit() to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 4 ++--
 tools/perf/util/evlist.h | 2 +-
 tools/perf/util/python.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5bde2e5bf0e3..4c5b7040c02b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -137,7 +137,7 @@ static void perf_evlist__purge(struct evlist *evlist)
 	evlist->core.nr_entries = 0;
 }
 
-void perf_evlist__exit(struct evlist *evlist)
+void evlist__exit(struct evlist *evlist)
 {
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
@@ -156,7 +156,7 @@ void evlist__delete(struct evlist *evlist)
 	evlist->core.cpus = NULL;
 	evlist->core.threads = NULL;
 	perf_evlist__purge(evlist);
-	perf_evlist__exit(evlist);
+	evlist__exit(evlist);
 	free(evlist);
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f07501602353..b33c5d67410a 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -65,7 +65,7 @@ struct evlist *perf_evlist__new_default(void);
 struct evlist *perf_evlist__new_dummy(void);
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads);
-void perf_evlist__exit(struct evlist *evlist);
+void evlist__exit(struct evlist *evlist);
 void evlist__delete(struct evlist *evlist);
 
 void evlist__add(struct evlist *evlist, struct evsel *entry);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b102d174b868..60a6b6e8e176 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -884,7 +884,7 @@ static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
 
 static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
 {
-	perf_evlist__exit(&pevlist->evlist);
+	evlist__exit(&pevlist->evlist);
 	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
 }
 
-- 
2.21.0
