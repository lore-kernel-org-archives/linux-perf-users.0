From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 102/107] libperf: Add perf_evlist test
Date: Mon, 29 Jul 2019 23:56:05 -0300
Message-ID: <20190730025610.22603-103-acme@kernel.org>
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

Add 2 simple perf_evlist tests to test counters reading interface
through the struct evlist object.

Committer testing:

  # make -C tools/perf/lib tests
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     test-cpumap-a
    LINK     test-threadmap-a
    LINK     test-evlist-a
    LINK     test-cpumap-so
    LINK     test-threadmap-so
    LINK     test-evlist-so
  running static:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  running dynamic:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-76-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/Makefile      |   2 +-
 tools/perf/lib/tests/test-evlist.c | 123 +++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/lib/tests/test-evlist.c

diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index 5dc84003e3a7..e66ed090f08e 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
-TESTS = test-cpumap test-threadmap
+TESTS = test-cpumap test-threadmap test-evlist
 
 TESTS_SO := $(addsuffix -so,$(TESTS))
 TESTS_A  := $(addsuffix -a,$(TESTS))
diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
new file mode 100644
index 000000000000..f24c531afcb6
--- /dev/null
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/perf_event.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <perf/evlist.h>
+#include <perf/evsel.h>
+#include <internal/tests.h>
+
+static int test_stat_cpu(void)
+{
+	struct perf_cpu_map *cpus;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr1 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_CPU_CLOCK,
+	};
+	struct perf_event_attr attr2 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_TASK_CLOCK,
+	};
+	int err, cpu, tmp;
+
+	cpus = perf_cpu_map__new(NULL);
+	__T("failed to create cpus", cpus);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr1);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	evsel = perf_evsel__new(&attr2);
+	__T("failed to create evsel2", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, cpus, NULL);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evsel", err == 0);
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		cpus = perf_evsel__cpus(evsel);
+
+		perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
+			struct perf_counts_values counts = { .val = 0 };
+
+			perf_evsel__read(evsel, cpu, 0, &counts);
+			__T("failed to read value for evsel", counts.val != 0);
+		}
+	}
+
+	perf_evlist__close(evlist);
+	perf_evlist__delete(evlist);
+
+	perf_cpu_map__put(cpus);
+	return 0;
+}
+
+static int test_stat_thread(void)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr1 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_CPU_CLOCK,
+	};
+	struct perf_event_attr attr2 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_TASK_CLOCK,
+	};
+	int err;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr1);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	evsel = perf_evsel__new(&attr2);
+	__T("failed to create evsel2", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, NULL, threads);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evsel", err == 0);
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &counts);
+		__T("failed to read value for evsel", counts.val != 0);
+	}
+
+	perf_evlist__close(evlist);
+	perf_evlist__delete(evlist);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	__T_START;
+
+	test_stat_cpu();
+	test_stat_thread();
+
+	__T_OK;
+	return 0;
+}
-- 
2.21.0
