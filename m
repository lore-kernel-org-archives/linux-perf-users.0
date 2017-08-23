From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/15] perf test: Add test cases for new data source encoding
Date: Wed, 23 Aug 2017 16:36:10 -0300
Message-ID: <20170823193614.20394-12-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add some simple tests to perf test to test data source printing.

v2: Make the tests actually checked for the correct name of Forward
v3: Adjust to new encoding

Committer notes:

Avoid the in place declaration to make this build with older compilers,
for instance, in Debian 7 we get:

  tests/mem.c: In function 'test__mem':
  tests/mem.c:30:5: error: missing initializer [-Werror=missing-field-initializers]
  tests/mem.c:30:5: error: (near initialization for '(anonymous).<anonymous>.mem_snoop') [-Werror=missing-field-initializers]

So just zero a struct, then go on building the unions as needed,
reusing settings from the previous test, i.e. local -> remote, etc.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170816222156.19953-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |  1 +
 tools/perf/tests/builtin-test.c |  4 +++
 tools/perf/tests/mem.c          | 56 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |  1 +
 4 files changed, 62 insertions(+)
 create mode 100644 tools/perf/tests/mem.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 84222bdb8689..87bf3edb037c 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -34,6 +34,7 @@ perf-y += thread-map.o
 perf-y += llvm.o llvm-src-base.o llvm-src-kbuild.o llvm-src-prologue.o llvm-src-relocation.o
 perf-y += bpf.o
 perf-y += topology.o
+perf-y += mem.o
 perf-y += cpumap.o
 perf-y += stat.o
 perf-y += event_update.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 9ecc44e68990..377bea009163 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -48,6 +48,10 @@ static struct test generic_tests[] = {
 		.func = test__basic_mmap,
 	},
 	{
+		.desc = "Test data source output",
+		.func = test__mem,
+	},
+	{
 		.desc = "Parse event definition strings",
 		.func = test__parse_events,
 	},
diff --git a/tools/perf/tests/mem.c b/tools/perf/tests/mem.c
new file mode 100644
index 000000000000..21952e1e6e6d
--- /dev/null
+++ b/tools/perf/tests/mem.c
@@ -0,0 +1,56 @@
+#include "util/mem-events.h"
+#include "util/symbol.h"
+#include "linux/perf_event.h"
+#include "util/debug.h"
+#include "tests.h"
+#include <string.h>
+
+static int check(union perf_mem_data_src data_src,
+		  const char *string)
+{
+	char out[100];
+	char failure[100];
+	struct mem_info mi = { .data_src = data_src };
+
+	int n;
+
+	n = perf_mem__snp_scnprintf(out, sizeof out, &mi);
+	n += perf_mem__lvl_scnprintf(out + n, sizeof out - n, &mi);
+	snprintf(failure, sizeof failure, "unexpected %s", out);
+	TEST_ASSERT_VAL(failure, !strcmp(string, out));
+	return 0;
+}
+
+int test__mem(struct test *text __maybe_unused, int subtest __maybe_unused)
+{
+	int ret = 0;
+	union perf_mem_data_src src;
+
+	memset(&src, 0, sizeof(src));
+
+	src.mem_lvl = PERF_MEM_LVL_HIT;
+	src.mem_lvl_num = 4;
+
+	ret |= check(src, "N/AL4 hit");
+
+	src.mem_remote = 1;
+
+	ret |= check(src, "N/ARemote L4 hit");
+
+	src.mem_lvl = PERF_MEM_LVL_MISS;
+	src.mem_lvl_num = PERF_MEM_LVLNUM_PMEM;
+	src.mem_remote = 0;
+
+	ret |= check(src, "N/APMEM miss");
+
+	src.mem_remote = 1;
+
+	ret |= check(src, "N/ARemote PMEM miss");
+
+	src.mem_snoopx = PERF_MEM_SNOOPX_FWD;
+	src.mem_lvl_num = PERF_MEM_LVLNUM_RAM;
+
+	ret |= check(src , "FwdRemote RAM miss");
+
+	return ret;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index c46ae818aac8..921412a6a880 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -58,6 +58,7 @@ int test__python_use(struct test *test, int subtest);
 int test__bp_signal(struct test *test, int subtest);
 int test__bp_signal_overflow(struct test *test, int subtest);
 int test__task_exit(struct test *test, int subtest);
+int test__mem(struct test *test, int subtest);
 int test__sw_clock_freq(struct test *test, int subtest);
 int test__code_reading(struct test *test, int subtest);
 int test__sample_parsing(struct test *test, int subtest);
-- 
2.13.5
