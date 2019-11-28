From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/22] perf tests: Rename tests/map_groups.c to tests/maps.c
Date: Thu, 28 Nov 2019 10:40:19 -0300
Message-ID: <20191128134027.23726-15-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step in mergint the maps and map_groups structs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bw6aagubqxc47m54k2maezfu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build                    | 2 +-
 tools/perf/tests/builtin-test.c           | 4 ++--
 tools/perf/tests/{map_groups.c => maps.c} | 2 +-
 tools/perf/tests/tests.h                  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename tools/perf/tests/{map_groups.c => maps.c} (97%)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5b9b0a813916..a3c595fba943 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -52,7 +52,7 @@ perf-y += perf-hooks.o
 perf-y += clang.o
 perf-y += unit_number__scnprintf.o
 perf-y += mem2node.o
-perf-y += map_groups.o
+perf-y += maps.o
 perf-y += time-utils-test.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3a4b9837b54d..7115aa32a51e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -297,8 +297,8 @@ static struct test generic_tests[] = {
 		.func = test__time_utils,
 	},
 	{
-		.desc = "map_groups__merge_in",
-		.func = test__map_groups__merge_in,
+		.desc = "maps__merge_in",
+		.func = test__maps__merge_in,
 	},
 	{
 		.func = NULL,
diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/maps.c
similarity index 97%
rename from tools/perf/tests/map_groups.c
rename to tools/perf/tests/maps.c
index 7febd02069ae..edcbc70ff9d6 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/maps.c
@@ -33,7 +33,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 	return TEST_OK;
 }
 
-int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
+int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct maps maps;
 	unsigned int i;
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f2b9bb024746..25aea387e2bf 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -107,7 +107,7 @@ const char *test__clang_subtest_get_desc(int subtest);
 int test__clang_subtest_get_nr(void);
 int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
-int test__map_groups__merge_in(struct test *t, int subtest);
+int test__maps__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
-- 
2.21.0
