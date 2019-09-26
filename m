From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/66] perf tools: Rename perf_evlist__munmap() to evlist__munmap()
Date: Wed, 25 Sep 2019 21:31:55 -0300
Message-ID: <20190926003244.13962-18-acme@kernel.org>
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

Rename perf_evlist__munmap() to evlist__munmap(), so we don't have a
name clash when we add perf_evlist__munmap() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/backward-ring-buffer.c |  2 +-
 tools/perf/util/evlist.c                | 12 ++++++------
 tools/perf/util/evlist.h                |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index f1eb7e9c1d7d..3073a68d17b9 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -75,7 +75,7 @@ static int do_test(struct evlist *evlist, int mmap_pages,
 	evlist__disable(evlist);
 
 	err = count_samples(evlist, sample_count, comm_count);
-	perf_evlist__munmap(evlist);
+	evlist__munmap(evlist);
 	return err;
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e8afe4fdc1b2..888472c7bf9c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -149,7 +149,7 @@ void evlist__delete(struct evlist *evlist)
 	if (evlist == NULL)
 		return;
 
-	perf_evlist__munmap(evlist);
+	evlist__munmap(evlist);
 	evlist__close(evlist);
 	perf_cpu_map__put(evlist->core.cpus);
 	perf_thread_map__put(evlist->core.threads);
@@ -673,7 +673,7 @@ static int perf_evlist__resume(struct evlist *evlist)
 	return perf_evlist__set_paused(evlist, false);
 }
 
-static void perf_evlist__munmap_nofree(struct evlist *evlist)
+static void evlist__munmap_nofree(struct evlist *evlist)
 {
 	int i;
 
@@ -686,9 +686,9 @@ static void perf_evlist__munmap_nofree(struct evlist *evlist)
 			perf_mmap__munmap(&evlist->overwrite_mmap[i]);
 }
 
-void perf_evlist__munmap(struct evlist *evlist)
+void evlist__munmap(struct evlist *evlist)
 {
-	perf_evlist__munmap_nofree(evlist);
+	evlist__munmap_nofree(evlist);
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
 }
@@ -835,7 +835,7 @@ static int evlist__mmap_per_cpu(struct evlist *evlist,
 	return 0;
 
 out_unmap:
-	perf_evlist__munmap_nofree(evlist);
+	evlist__munmap_nofree(evlist);
 	return -1;
 }
 
@@ -861,7 +861,7 @@ static int evlist__mmap_per_thread(struct evlist *evlist,
 	return 0;
 
 out_unmap:
-	perf_evlist__munmap_nofree(evlist);
+	evlist__munmap_nofree(evlist);
 	return -1;
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index aaf06182c1b8..f07501602353 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -175,7 +175,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 			 bool auxtrace_overwrite, int nr_cblocks,
 			 int affinity, int flush, int comp_level);
 int evlist__mmap(struct evlist *evlist, unsigned int pages);
-void perf_evlist__munmap(struct evlist *evlist);
+void evlist__munmap(struct evlist *evlist);
 
 size_t evlist__mmap_size(unsigned long pages);
 
-- 
2.21.0
