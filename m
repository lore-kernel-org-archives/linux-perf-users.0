Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B737D21745C;
	Thu,  7 Nov 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984002; cv=none; b=EWzcNZ7rkUko+AoK8u6+IPjW5qNqSKNMxJN54HNOsSw1Ad4vlF5CsFn0w7RDpgcO0MmHDv6U9kpUef9yB6k7psYVRLuPifOehL9L9XpoornvJMBRtukUjIRHEKqjpBHfbUwntzHK8D9c+krQU6oByIOjsk1eP0luZJdZm0gqBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984002; c=relaxed/simple;
	bh=mFdub3L/Oln7xr9DqTyi+3G9bZNYtUKvLJ5QOD/DXoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/cLZRvF0XxlANk9hmZFms3LpaaZ3leepPZy9xLLEmsDRrUppxCP77qD4XnMLQ63P2O88ZLoPlSWsc6oilWmh396COL9PWiiHRlNQNUftE82vZJPwIi/RHxzGHB2ahzjQG8Lm1sGurR14MYR0Wp2g2Fq+ghy5QbEzBme6U746YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7F231063;
	Thu,  7 Nov 2024 04:53:48 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51C233F66E;
	Thu,  7 Nov 2024 04:53:17 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 1/3] libperf cpumap: Refactor perf_cpu_map__merge()
Date: Thu,  7 Nov 2024 12:53:06 +0000
Message-Id: <20241107125308.41226-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107125308.41226-1-leo.yan@arm.com>
References: <20241107125308.41226-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf_cpu_map__merge() function has two arguments, 'orig' and
'other'.  The function definition might cause confusion as it could give
the impression that the CPU maps in the two arguments are copied into a
new allocated structure, which is then returned as the result.

The purpose of the function is to merge the CPU map 'other' into the CPU
map 'orig'.  This commit changes the 'orig' argument to a pointer to
pointer, so the new result will be updated into 'orig'.

The return value is changed to an int type, as an error number or 0 for
success.

Update callers and tests for the new function definition.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/lib/perf/cpumap.c              | 49 +++++++++++++++-------------
 tools/lib/perf/evlist.c              |  2 +-
 tools/lib/perf/include/perf/cpumap.h |  4 +--
 tools/perf/tests/cpumap.c            | 13 ++++----
 tools/perf/util/mem-events.c         |  5 ++-
 5 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index cae799ad44e1..a36e90d38142 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
 #include <perf/cpumap.h>
 #include <stdlib.h>
 #include <linux/refcount.h>
@@ -436,46 +437,49 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
 }
 
 /*
- * Merge two cpumaps
+ * Merge two cpumaps.
  *
- * orig either gets freed and replaced with a new map, or reused
- * with no reference count change (similar to "realloc")
- * other has its reference count increased.
+ * If 'other' is subset of '*orig', '*orig' keeps itself with no reference count
+ * change (similar to "realloc").
+ *
+ * If '*orig' is subset of 'other', '*orig' reuses 'other' with its reference
+ * count increased.
+ *
+ * Otherwise, '*orig' gets freed and replaced with a new map.
  */
-
-struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
-					 struct perf_cpu_map *other)
+int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
 {
 	struct perf_cpu *tmp_cpus;
 	int tmp_len;
 	int i, j, k;
 	struct perf_cpu_map *merged;
 
-	if (perf_cpu_map__is_subset(orig, other))
-		return orig;
-	if (perf_cpu_map__is_subset(other, orig)) {
-		perf_cpu_map__put(orig);
-		return perf_cpu_map__get(other);
+	if (perf_cpu_map__is_subset(*orig, other))
+		return 0;
+	if (perf_cpu_map__is_subset(other, *orig)) {
+		perf_cpu_map__put(*orig);
+		*orig = perf_cpu_map__get(other);
+		return 0;
 	}
 
-	tmp_len = __perf_cpu_map__nr(orig) + __perf_cpu_map__nr(other);
+	tmp_len = __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other);
 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
 	if (!tmp_cpus)
-		return NULL;
+		return -ENOMEM;
 
 	/* Standard merge algorithm from wikipedia */
 	i = j = k = 0;
-	while (i < __perf_cpu_map__nr(orig) && j < __perf_cpu_map__nr(other)) {
-		if (__perf_cpu_map__cpu(orig, i).cpu <= __perf_cpu_map__cpu(other, j).cpu) {
-			if (__perf_cpu_map__cpu(orig, i).cpu == __perf_cpu_map__cpu(other, j).cpu)
+	while (i < __perf_cpu_map__nr(*orig) && j < __perf_cpu_map__nr(other)) {
+		if (__perf_cpu_map__cpu(*orig, i).cpu <= __perf_cpu_map__cpu(other, j).cpu) {
+			if (__perf_cpu_map__cpu(*orig, i).cpu == __perf_cpu_map__cpu(other, j).cpu)
 				j++;
-			tmp_cpus[k++] = __perf_cpu_map__cpu(orig, i++);
+			tmp_cpus[k++] = __perf_cpu_map__cpu(*orig, i++);
 		} else
 			tmp_cpus[k++] = __perf_cpu_map__cpu(other, j++);
 	}
 
-	while (i < __perf_cpu_map__nr(orig))
-		tmp_cpus[k++] = __perf_cpu_map__cpu(orig, i++);
+	while (i < __perf_cpu_map__nr(*orig))
+		tmp_cpus[k++] = __perf_cpu_map__cpu(*orig, i++);
 
 	while (j < __perf_cpu_map__nr(other))
 		tmp_cpus[k++] = __perf_cpu_map__cpu(other, j++);
@@ -483,8 +487,9 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 
 	merged = cpu_map__trim_new(k, tmp_cpus);
 	free(tmp_cpus);
-	perf_cpu_map__put(orig);
-	return merged;
+	perf_cpu_map__put(*orig);
+	*orig = merged;
+	return 0;
 }
 
 struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index c6d67fc9e57e..94b7369f3efe 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -75,7 +75,7 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		evsel->threads = perf_thread_map__get(evlist->threads);
 	}
 
-	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
+	perf_cpu_map__merge(&evlist->all_cpus, evsel->cpus);
 }
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 90457d17fb2f..c83bfb2c36ff 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -39,8 +39,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
-LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
-						     struct perf_cpu_map *other);
+LIBPERF_API int perf_cpu_map__merge(struct perf_cpu_map **orig,
+				    struct perf_cpu_map *other);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
 							 struct perf_cpu_map *other);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 2f0168b2a5a9..7f189d57232f 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -160,14 +160,14 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
 {
 	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
 	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
-	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
 	char buf[100];
 
-	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
-	cpu_map__snprint(c, buf, sizeof(buf));
+	perf_cpu_map__merge(&a, b);
+	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(a) == 5);
+	cpu_map__snprint(a, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
 	perf_cpu_map__put(b);
-	perf_cpu_map__put(c);
+	perf_cpu_map__put(a);
 	return 0;
 }
 
@@ -233,9 +233,8 @@ static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subte
 	}
 
 	/* Maps equal made maps. */
-	tmp = perf_cpu_map__merge(perf_cpu_map__get(one), two);
-	TEST_ASSERT_VAL("pair", perf_cpu_map__equal(pair, tmp));
-	perf_cpu_map__put(tmp);
+	perf_cpu_map__merge(&two, one);
+	TEST_ASSERT_VAL("pair", perf_cpu_map__equal(pair, two));
 
 	tmp = perf_cpu_map__intersect(pair, one);
 	TEST_ASSERT_VAL("one", perf_cpu_map__equal(one, tmp));
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index bf5090f5220b..3692e988c86e 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -258,6 +258,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 	const char *s;
 	char *copy;
 	struct perf_cpu_map *cpu_map = NULL;
+	int ret;
 
 	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
 		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
@@ -283,7 +284,9 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 			rec_argv[i++] = "-e";
 			rec_argv[i++] = copy;
 
-			cpu_map = perf_cpu_map__merge(cpu_map, pmu->cpus);
+			ret = perf_cpu_map__merge(&cpu_map, pmu->cpus);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
-- 
2.34.1

