From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 100/107] libperf: Add perf_cpu_map test
Date: Mon, 29 Jul 2019 23:56:03 -0300
Message-ID: <20190730025610.22603-101-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add simple perf_cpu_map tests.

Committer testing:

One has to build it in the source tree, a limitation that should be
fixed in followup patches:

  $ make O=/tmp/build/perf -C tools/perf/lib
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     /tmp/build/perf/libperf.so.0.0.1
    GEN      /tmp/build/perf/libperf.pc
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  $ make O=/tmp/build/perf -C tools/perf/lib  tests
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     test-cpumap-a
  gcc: error: ../libperf.a: No such file or directory
  make[1]: *** [Makefile:22: test-cpumap-a] Error 1
  make: *** [Makefile:115: tests] Error 2
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  [acme@quaco perf]$ make -C tools/perf/lib
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    HOSTCC   fixdep.o
    HOSTLD   fixdep-in.o
    LINK     fixdep
    CC       core.o
    CC       cpumap.o
    CC       threadmap.o
    CC       evsel.o
    CC       evlist.o
    CC       zalloc.o
    CC       xyarray.o
    CC       lib.o
    LD       libperf-in.o
    AR       libperf.a
    LINK     libperf.so.0.0.1
    GEN      libperf.pc
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  $ make O=/tmp/build/perf -C tools/perf/lib  tests
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     test-cpumap-a
    LINK     test-cpumap-so
  running static:
  - running test-cpumap.c...OK
  running dynamic:
  - running test-cpumap.c...OK
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  $

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-74-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/Makefile      |  2 +-
 tools/perf/lib/tests/test-cpumap.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/lib/tests/test-cpumap.c

diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index de951ae38dea..b72c8c47df61 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
-TESTS =
+TESTS = test-cpumap
 
 TESTS_SO := $(addsuffix -so,$(TESTS))
 TESTS_A  := $(addsuffix -a,$(TESTS))
diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/perf/lib/tests/test-cpumap.c
new file mode 100644
index 000000000000..76a43cfb83a1
--- /dev/null
+++ b/tools/perf/lib/tests/test-cpumap.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/cpumap.h>
+#include <internal/tests.h>
+
+int main(int argc, char **argv)
+{
+	struct perf_cpu_map *cpus;
+
+	__T_START;
+
+	cpus = perf_cpu_map__dummy_new();
+	if (!cpus)
+		return -1;
+
+	perf_cpu_map__get(cpus);
+	perf_cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
+
+	__T_OK;
+	return 0;
+}
-- 
2.21.0
