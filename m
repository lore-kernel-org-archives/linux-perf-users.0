From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/23] perf evsel: Add iterator to iterate over events ordered by CPU
Date: Tue,  3 Dec 2019 10:55:46 -0300
Message-ID: <20191203135606.24902-4-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add some common code that is needed to iterate over all events
in CPU order. Used in followon patches

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191121001522.180827-6-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.h |  1 +
 tools/perf/util/evlist.c | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  8 ++++++++
 tools/perf/util/evsel.h  |  1 +
 4 files changed, 42 insertions(+)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 57943f3685f8..3a442f021468 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -63,4 +63,5 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
+
 #endif /* __PERF_CPUMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index fdce590d2278..dae6e846b2f8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -342,6 +342,38 @@ static int perf_evlist__nr_threads(struct evlist *evlist,
 		return perf_thread_map__nr(evlist->core.threads);
 }
 
+void evlist__cpu_iter_start(struct evlist *evlist)
+{
+	struct evsel *pos;
+
+	/*
+	 * Reset the per evsel cpu_iter. This is needed because
+	 * each evsel's cpumap may have a different index space,
+	 * and some operations need the index to modify
+	 * the FD xyarray (e.g. open, close)
+	 */
+	evlist__for_each_entry(evlist, pos)
+		pos->cpu_iter = 0;
+}
+
+bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu)
+{
+	if (ev->cpu_iter >= ev->core.cpus->nr)
+		return true;
+	if (cpu >= 0 && ev->core.cpus->map[ev->cpu_iter] != cpu)
+		return true;
+	return false;
+}
+
+bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
+{
+	if (!evsel__cpu_iter_skip_no_inc(ev, cpu)) {
+		ev->cpu_iter++;
+		return false;
+	}
+	return true;
+}
+
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 3655b9ebb147..22e2f58eabea 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -334,9 +334,17 @@ void perf_evlist__to_front(struct evlist *evlist,
 #define evlist__for_each_entry_safe(evlist, tmp, evsel) \
 	__evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
 
+#define evlist__for_each_cpu(evlist, index, cpu)	\
+	evlist__cpu_iter_start(evlist);			\
+	perf_cpu_map__for_each_cpu (cpu, index, (evlist)->core.all_cpus)
+
 void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel);
 
+void evlist__cpu_iter_start(struct evlist *evlist);
+bool evsel__cpu_iter_skip(struct evsel *ev, int cpu);
+bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu);
+
 struct evsel *
 perf_evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ddc5ee6f6592..b10d5ba21966 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -95,6 +95,7 @@ struct evsel {
 	bool			collect_stat;
 	bool			weak_group;
 	bool			percore;
+	int			cpu_iter;
 	const char		*pmu_name;
 	struct {
 		perf_evsel__sb_cb_t	*cb;
-- 
2.21.0
