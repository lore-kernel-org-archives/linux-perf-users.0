From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/23] perf evlist: Maintain evlist->all_cpus
Date: Tue,  3 Dec 2019 10:55:45 -0300
Message-ID: <20191203135606.24902-3-acme@kernel.org>
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

Maintain a cpumap in the evlist that is the union of all the cpus of the
events.

This needs a cpumap merge operation, which is added together with tests.

v2:
Add tests for cpu map merge
Fix handling of duplicates
Rename _update to _merge
Factor out sorting.
Fix handling of NULL maps in merge

v3:
Add comments and empty lines to _merge

Committer testing:

  # perf test "Merge cpu map"
  52: Merge cpu map                                         : Ok
  #

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lore.kernel.org/lkml/20191121001522.180827-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/cpumap.c                  | 57 ++++++++++++++++++++++++
 tools/perf/lib/evlist.c                  |  1 +
 tools/perf/lib/include/internal/evlist.h |  1 +
 tools/perf/lib/include/perf/cpumap.h     |  2 +
 tools/perf/tests/builtin-test.c          |  5 +++
 tools/perf/tests/cpumap.c                | 16 +++++++
 tools/perf/tests/tests.h                 |  1 +
 7 files changed, 83 insertions(+)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index d81656b4635e..f93f4e703e4c 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -286,3 +286,60 @@ int perf_cpu_map__max(struct perf_cpu_map *map)
 
 	return max;
 }
+
+/*
+ * Merge two cpumaps
+ *
+ * orig either gets freed and replaced with a new map, or reused
+ * with no reference count change (similar to "realloc")
+ * other has its reference count increased.
+ */
+
+struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
+					 struct perf_cpu_map *other)
+{
+	int *tmp_cpus;
+	int tmp_len;
+	int i, j, k;
+	struct perf_cpu_map *merged;
+
+	if (!orig && !other)
+		return NULL;
+	if (!orig) {
+		perf_cpu_map__get(other);
+		return other;
+	}
+	if (!other)
+		return orig;
+	if (orig->nr == other->nr &&
+	    !memcmp(orig->map, other->map, orig->nr * sizeof(int)))
+		return orig;
+
+	tmp_len = orig->nr + other->nr;
+	tmp_cpus = malloc(tmp_len * sizeof(int));
+	if (!tmp_cpus)
+		return NULL;
+
+	/* Standard merge algorithm from wikipedia */
+	i = j = k = 0;
+	while (i < orig->nr && j < other->nr) {
+		if (orig->map[i] <= other->map[j]) {
+			if (orig->map[i] == other->map[j])
+				j++;
+			tmp_cpus[k++] = orig->map[i++];
+		} else
+			tmp_cpus[k++] = other->map[j++];
+	}
+
+	while (i < orig->nr)
+		tmp_cpus[k++] = orig->map[i++];
+
+	while (j < other->nr)
+		tmp_cpus[k++] = other->map[j++];
+	assert(k <= tmp_len);
+
+	merged = cpu_map__trim_new(k, tmp_cpus);
+	free(tmp_cpus);
+	perf_cpu_map__put(orig);
+	return merged;
+}
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 205ddbb80bc1..ae9e65aa2491 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -54,6 +54,7 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 	perf_thread_map__put(evsel->threads);
 	evsel->threads = perf_thread_map__get(evlist->threads);
+	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
 }
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index a2fbccf1922f..74dc8c3f0b66 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -18,6 +18,7 @@ struct perf_evlist {
 	int			 nr_entries;
 	bool			 has_user_cpus;
 	struct perf_cpu_map	*cpus;
+	struct perf_cpu_map	*all_cpus;
 	struct perf_thread_map	*threads;
 	int			 nr_mmaps;
 	size_t			 mmap_len;
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index ac9aa497f84a..6a17ad730cbc 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -12,6 +12,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
+						     struct perf_cpu_map *other);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7115aa32a51e..82d19a8fcac7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -259,6 +259,11 @@ static struct test generic_tests[] = {
 		.desc = "Print cpu map",
 		.func = test__cpu_map_print,
 	},
+	{
+		.desc = "Merge cpu map",
+		.func = test__cpu_map_merge,
+	},
+
 	{
 		.desc = "Probe SDT events",
 		.func = test__sdt_event,
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 8a0d236202b0..4ac56741ac5f 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -120,3 +120,19 @@ int test__cpu_map_print(struct test *test __maybe_unused, int subtest __maybe_un
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1-10,12-20,22-30,32-40"));
 	return 0;
 }
+
+int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
+	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
+	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
+	char buf[100];
+
+	TEST_ASSERT_VAL("failed to merge map: bad nr", c->nr == 5);
+	cpu_map__snprint(c, buf, sizeof(buf));
+	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
+	perf_cpu_map__put(a);
+	perf_cpu_map__put(b);
+	perf_cpu_map__put(c);
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 25aea387e2bf..4f9ae6af78ec 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -98,6 +98,7 @@ int test__event_update(struct test *test, int subtest);
 int test__event_times(struct test *test, int subtest);
 int test__backward_ring_buffer(struct test *test, int subtest);
 int test__cpu_map_print(struct test *test, int subtest);
+int test__cpu_map_merge(struct test *test, int subtest);
 int test__sdt_event(struct test *test, int subtest);
 int test__is_printable_array(struct test *test, int subtest);
 int test__bitmap_print(struct test *test, int subtest);
-- 
2.21.0
