From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 080/107] libperf: Add has_user_cpus to struct perf_evlist
Date: Mon, 29 Jul 2019 23:55:43 -0300
Message-ID: <20190730025610.22603-81-acme@kernel.org>
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

Move has_user_cpus from tools/perf's evlist to libbperf's perf_evlist struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-54-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/evlist.h | 1 +
 tools/perf/util/evlist.c                 | 4 ++--
 tools/perf/util/evlist.h                 | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index a12c712a9197..9964e4a9456e 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -5,6 +5,7 @@
 struct perf_evlist {
 	struct list_head	entries;
 	int			nr_entries;
+	bool			has_user_cpus;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5ce8fc730453..23a8ead4512f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -159,7 +159,7 @@ static void __perf_evlist__propagate_maps(struct evlist *evlist,
 	 * We already have cpus for evsel (via PMU sysfs) so
 	 * keep it, if there's no target cpu list defined.
 	 */
-	if (!evsel->core.own_cpus || evlist->has_user_cpus) {
+	if (!evsel->core.own_cpus || evlist->core.has_user_cpus) {
 		perf_cpu_map__put(evsel->core.cpus);
 		evsel->core.cpus = perf_cpu_map__get(evlist->cpus);
 	} else if (evsel->core.cpus != evsel->core.own_cpus) {
@@ -1095,7 +1095,7 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!cpus)
 		goto out_delete_threads;
 
-	evlist->has_user_cpus = !!target->cpu_list;
+	evlist->core.has_user_cpus = !!target->cpu_list;
 
 	perf_evlist__set_maps(evlist, cpus, threads);
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 17dd83021a79..35cca0242631 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -31,7 +31,6 @@ struct evlist {
 	int		 nr_groups;
 	int		 nr_mmaps;
 	bool		 enabled;
-	bool		 has_user_cpus;
 	size_t		 mmap_len;
 	int		 id_pos;
 	int		 is_pos;
-- 
2.21.0
