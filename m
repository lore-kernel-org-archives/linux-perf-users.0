From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/66] libperf: Move 'heads' from 'struct evlist' to 'struct perf_evlist'
Date: Wed, 25 Sep 2019 21:32:18 -0300
Message-ID: <20190926003244.13962-41-acme@kernel.org>
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

Move 'heads' hash table from 'struct evlist' to 'struct perf_evlist'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-27-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  |  4 ++++
 tools/perf/lib/include/internal/evlist.h |  4 ++++
 tools/perf/util/evlist.c                 | 10 +++-------
 tools/perf/util/evlist.h                 |  4 ----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index f4dc9a208332..2bdd9d2c79d9 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -11,6 +11,10 @@
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
+	int i;
+
+	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
+		INIT_HLIST_HEAD(&evlist->heads[i]);
 	INIT_LIST_HEAD(&evlist->entries);
 	evlist->nr_entries = 0;
 }
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 8a4eb66fbf3a..c5a06890fd6a 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -5,6 +5,9 @@
 #include <linux/list.h>
 #include <api/fd/array.h>
 
+#define PERF_EVLIST__HLIST_BITS 8
+#define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
+
 struct perf_cpu_map;
 struct perf_thread_map;
 
@@ -17,6 +20,7 @@ struct perf_evlist {
 	int			 nr_mmaps;
 	size_t			 mmap_len;
 	struct fdarray		 pollfd;
+	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
 };
 
 /**
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5e43fb9da359..c6af7c622612 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -55,10 +55,6 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads)
 {
-	int i;
-
-	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
-		INIT_HLIST_HEAD(&evlist->heads[i]);
 	perf_evlist__init(&evlist->core);
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 	fdarray__init(&evlist->core.pollfd, 64);
@@ -475,7 +471,7 @@ static void perf_evlist__id_hash(struct evlist *evlist,
 	sid->id = id;
 	sid->evsel = evsel;
 	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
-	hlist_add_head(&sid->node, &evlist->heads[hash]);
+	hlist_add_head(&sid->node, &evlist->core.heads[hash]);
 }
 
 void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
@@ -549,7 +545,7 @@ struct perf_sample_id *perf_evlist__id2sid(struct evlist *evlist, u64 id)
 	int hash;
 
 	hash = hash_64(id, PERF_EVLIST__HLIST_BITS);
-	head = &evlist->heads[hash];
+	head = &evlist->core.heads[hash];
 
 	hlist_for_each_entry(sid, head, node)
 		if (sid->id == id)
@@ -635,7 +631,7 @@ struct evsel *perf_evlist__event2evsel(struct evlist *evlist,
 		return first;
 
 	hash = hash_64(id, PERF_EVLIST__HLIST_BITS);
-	head = &evlist->heads[hash];
+	head = &evlist->core.heads[hash];
 
 	hlist_for_each_entry(sid, head, node) {
 		if (sid->id == id)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 4fcdf93eb19c..ad9c0ba57a91 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -48,12 +48,8 @@ enum bkw_mmap_state {
 	BKW_MMAP_EMPTY,
 };
 
-#define PERF_EVLIST__HLIST_BITS 8
-#define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
-
 struct evlist {
 	struct perf_evlist core;
-	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_groups;
 	bool		 enabled;
 	int		 id_pos;
-- 
2.21.0
