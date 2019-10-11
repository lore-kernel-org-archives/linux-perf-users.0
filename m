From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 55/69] libperf: Introduce perf_evlist__mmap_ops()
Date: Fri, 11 Oct 2019 17:05:45 -0300
Message-ID: <20191011200559.7156-56-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To be able to pass specific callbacks to evlist's mmap.

There will be a specific call to this function from perf's
evlist__mmap() and libperf's perf_evlist__mmap() functions in following
changes.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-15-jolsa@kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 24 ++++++++++++++++++------
 tools/perf/lib/include/internal/evlist.h |  8 ++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 250ad5752589..88d63f5cd9ca 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -472,12 +472,16 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 	return -1;
 }
 
-int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
+int perf_evlist__mmap_ops(struct perf_evlist *evlist,
+			  struct perf_evlist_mmap_ops *ops,
+			  struct perf_mmap_param *mp)
 {
 	struct perf_evsel *evsel;
 	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct perf_thread_map *threads = evlist->threads;
-	struct perf_mmap_param mp;
+
+	if (!ops)
+		return -EINVAL;
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -491,13 +495,21 @@ int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 			return -ENOMEM;
 	}
 
+	if (perf_cpu_map__empty(cpus))
+		return mmap_per_thread(evlist, mp);
+
+	return mmap_per_cpu(evlist, mp);
+}
+
+int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
+{
+	struct perf_mmap_param mp;
+	struct perf_evlist_mmap_ops ops;
+
 	evlist->mmap_len = (pages + 1) * page_size;
 	mp.mask = evlist->mmap_len - page_size - 1;
 
-	if (perf_cpu_map__empty(cpus))
-		return mmap_per_thread(evlist, &mp);
-
-	return mmap_per_cpu(evlist, &mp);
+	return perf_evlist__mmap_ops(evlist, &ops, &mp);
 }
 
 void perf_evlist__munmap(struct perf_evlist *evlist)
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 4438a19ceba3..e5f092ff6202 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -11,6 +11,7 @@
 
 struct perf_cpu_map;
 struct perf_thread_map;
+struct perf_mmap_param;
 
 struct perf_evlist {
 	struct list_head	 entries;
@@ -26,10 +27,17 @@ struct perf_evlist {
 	struct perf_mmap	*mmap_ovw;
 };
 
+struct perf_evlist_mmap_ops {
+};
+
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
 int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
 			    void *ptr, short revent);
 
+int perf_evlist__mmap_ops(struct perf_evlist *evlist,
+			  struct perf_evlist_mmap_ops *ops,
+			  struct perf_mmap_param *mp);
+
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
  * @list: list_head instance to iterate
-- 
2.21.0
