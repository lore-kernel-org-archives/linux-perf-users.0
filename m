From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 078/107] libperf: Add own_cpus to struct perf_evsel
Date: Mon, 29 Jul 2019 23:55:41 -0300
Message-ID: <20190730025610.22603-79-acme@kernel.org>
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

Move own_cpus from tools/perf's evsel to libbpf's perf_evsel.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-52-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/tests/event_update.c         |  4 ++--
 tools/perf/util/evlist.c                |  6 +++---
 tools/perf/util/evsel.c                 |  4 ++--
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/header.c                | 10 +++++-----
 tools/perf/util/parse-events.c          |  2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index b2c76e1a6244..d15d8ccfa3dc 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -11,6 +11,7 @@ struct perf_evsel {
 	struct list_head	 node;
 	struct perf_event_attr	 attr;
 	struct perf_cpu_map	*cpus;
+	struct perf_cpu_map	*own_cpus;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 2bc5145284c0..c37ff49c07c7 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -109,11 +109,11 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
 			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
 
-	evsel->own_cpus = perf_cpu_map__new("1,2,3");
+	evsel->core.own_cpus = perf_cpu_map__new("1,2,3");
 
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
 			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
 
-	perf_cpu_map__put(evsel->own_cpus);
+	perf_cpu_map__put(evsel->core.own_cpus);
 	return 0;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 713968130d1d..d203305ac187 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -159,12 +159,12 @@ static void __perf_evlist__propagate_maps(struct evlist *evlist,
 	 * We already have cpus for evsel (via PMU sysfs) so
 	 * keep it, if there's no target cpu list defined.
 	 */
-	if (!evsel->own_cpus || evlist->has_user_cpus) {
+	if (!evsel->core.own_cpus || evlist->has_user_cpus) {
 		perf_cpu_map__put(evsel->core.cpus);
 		evsel->core.cpus = perf_cpu_map__get(evlist->cpus);
-	} else if (evsel->core.cpus != evsel->own_cpus) {
+	} else if (evsel->core.cpus != evsel->core.own_cpus) {
 		perf_cpu_map__put(evsel->core.cpus);
-		evsel->core.cpus = perf_cpu_map__get(evsel->own_cpus);
+		evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
 	}
 
 	perf_thread_map__put(evsel->threads);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 651f66ee902e..c5f6ee6d5f3b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1125,7 +1125,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->own_cpus || evsel->unit)
+	if (evsel->core.own_cpus || evsel->unit)
 		evsel->core.attr.read_format |= PERF_FORMAT_ID;
 
 	/*
@@ -1326,7 +1326,7 @@ void perf_evsel__exit(struct evsel *evsel)
 	perf_evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
 	perf_cpu_map__put(evsel->core.cpus);
-	perf_cpu_map__put(evsel->own_cpus);
+	perf_cpu_map__put(evsel->core.own_cpus);
 	perf_thread_map__put(evsel->threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8ece5edf65ac..2eff837f10bd 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -123,7 +123,6 @@ struct evsel {
 	u64			db_id;
 	struct cgroup		*cgrp;
 	void			*handler;
-	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map *threads;
 	unsigned int		sample_size;
 	int			id_pos;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fa914ba8cd56..f97df418d661 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3861,10 +3861,10 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 	int max, err;
 	u16 type;
 
-	if (!evsel->own_cpus)
+	if (!evsel->core.own_cpus)
 		return 0;
 
-	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
+	ev = cpu_map_data__alloc(evsel->core.own_cpus, &size, &type, &max);
 	if (!ev)
 		return -ENOMEM;
 
@@ -3874,7 +3874,7 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 	ev->id   = evsel->id[0];
 
 	cpu_map_data__synthesize((struct cpu_map_data *) ev->data,
-				 evsel->own_cpus,
+				 evsel->core.own_cpus,
 				 type, max);
 
 	err = process(tool, (union perf_event*) ev, NULL, NULL);
@@ -3985,7 +3985,7 @@ int perf_event__synthesize_extra_attr(struct perf_tool *tool,
 			}
 		}
 
-		if (counter->own_cpus) {
+		if (counter->core.own_cpus) {
 			err = perf_event__synthesize_event_update_cpus(tool, counter, process);
 			if (err < 0) {
 				pr_err("Couldn't synthesize evsel cpus.\n");
@@ -4082,7 +4082,7 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 
 		map = cpu_map__new_data(&ev_cpus->cpus);
 		if (map)
-			evsel->own_cpus = map;
+			evsel->core.own_cpus = map;
 		else
 			pr_err("failed to get event_update cpus\n");
 	default:
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a27771eca9c2..8182b1e66ec6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -334,7 +334,7 @@ __add_event(struct list_head *list, int *idx,
 
 	(*idx)++;
 	evsel->core.cpus   = perf_cpu_map__get(cpus);
-	evsel->own_cpus    = perf_cpu_map__get(cpus);
+	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->system_wide = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 
-- 
2.21.0
