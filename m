From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/22] perf tests: Rename thread-mg-share to thread-maps-share
Date: Thu, 28 Nov 2019 10:40:18 -0300
Message-ID: <20191128134027.23726-14-acme@kernel.org>
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

One more step in merging 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-naxsl3g4ou3fyxb8l8e0pn5e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build                        |  2 +-
 tools/perf/tests/builtin-test.c               |  4 ++--
 tools/perf/tests/tests.h                      |  2 +-
 ...{thread-mg-share.c => thread-maps-share.c} | 22 +++++++++----------
 4 files changed, 15 insertions(+), 15 deletions(-)
 rename tools/perf/tests/{thread-mg-share.c => thread-maps-share.c} (77%)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index e72accefd669..5b9b0a813916 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -27,7 +27,7 @@ perf-y += wp.o
 perf-y += task-exit.o
 perf-y += sw-clock.o
 perf-y += mmap-thread-lookup.o
-perf-y += thread-mg-share.o
+perf-y += thread-maps-share.o
 perf-y += switch-tracking.o
 perf-y += keep-tracking.o
 perf-y += code-reading.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8b286e9b7549..3a4b9837b54d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -166,8 +166,8 @@ static struct test generic_tests[] = {
 		.func = test__mmap_thread_lookup,
 	},
 	{
-		.desc = "Share thread mg",
-		.func = test__thread_mg_share,
+		.desc = "Share thread maps",
+		.func = test__thread_maps_share,
 	},
 	{
 		.desc = "Sort output of hist entries",
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9837b6e93023..f2b9bb024746 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -73,7 +73,7 @@ int test__dwarf_unwind(struct test *test, int subtest);
 int test__expr(struct test *test, int subtest);
 int test__hists_filter(struct test *test, int subtest);
 int test__mmap_thread_lookup(struct test *test, int subtest);
-int test__thread_mg_share(struct test *test, int subtest);
+int test__thread_maps_share(struct test *test, int subtest);
 int test__hists_output(struct test *test, int subtest);
 int test__hists_cumulate(struct test *test, int subtest);
 int test__switch_tracking(struct test *test, int subtest);
diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-maps-share.c
similarity index 77%
rename from tools/perf/tests/thread-mg-share.c
rename to tools/perf/tests/thread-maps-share.c
index e3b0d692d565..9371484973f2 100644
--- a/tools/perf/tests/thread-mg-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -4,7 +4,7 @@
 #include "thread.h"
 #include "debug.h"
 
-int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_unused)
+int test__thread_maps_share(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machines machines;
 	struct machine *machine;
@@ -16,7 +16,7 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 
 	/* other process */
 	struct thread *other, *other_leader;
-	struct maps *other_mg;
+	struct maps *other_maps;
 
 	/*
 	 * This test create 2 processes abstractions (struct thread)
@@ -45,14 +45,14 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	maps = leader->maps;
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 4);
 
-	/* test the map groups pointer is shared */
-	TEST_ASSERT_VAL("map groups don't match", maps == t1->maps);
-	TEST_ASSERT_VAL("map groups don't match", maps == t2->maps);
-	TEST_ASSERT_VAL("map groups don't match", maps == t3->maps);
+	/* test the maps pointer is shared */
+	TEST_ASSERT_VAL("maps don't match", maps == t1->maps);
+	TEST_ASSERT_VAL("maps don't match", maps == t2->maps);
+	TEST_ASSERT_VAL("maps don't match", maps == t3->maps);
 
 	/*
 	 * Verify the other leader was created by previous call.
-	 * It should have shared map groups with no change in
+	 * It should have shared maps with no change in
 	 * refcnt.
 	 */
 	other_leader = machine__find_thread(machine, 4, 4);
@@ -70,10 +70,10 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	machine__remove_thread(machine, other);
 	machine__remove_thread(machine, other_leader);
 
-	other_mg = other->maps;
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 2);
+	other_maps = other->maps;
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_maps->refcnt), 2);
 
-	TEST_ASSERT_VAL("map groups don't match", other_mg == other_leader->maps);
+	TEST_ASSERT_VAL("maps don't match", other_maps == other_leader->maps);
 
 	/* release thread group */
 	thread__put(leader);
@@ -89,7 +89,7 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 
 	/* release other group  */
 	thread__put(other_leader);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 1);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_maps->refcnt), 1);
 
 	thread__put(other);
 
-- 
2.21.0
