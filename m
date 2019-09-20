From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/31] perf env: Remove needless cpumap.h header
Date: Fri, 20 Sep 2019 11:25:24 -0300
Message-ID: <20190920142542.12047-14-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Only a 'struct perf_cmp_map' forward allocation is necessary, fix the
places that need the header but were getting it indirectly, by luck,
from env.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3sj3n534zghxhk7ygzeaqlx9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/header.c                    | 4 +++-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c           | 1 -
 tools/perf/bench/epoll-ctl.c                           | 2 +-
 tools/perf/bench/epoll-wait.c                          | 2 +-
 tools/perf/bench/futex-hash.c                          | 2 +-
 tools/perf/bench/futex-lock-pi.c                       | 2 +-
 tools/perf/bench/futex-requeue.c                       | 2 +-
 tools/perf/bench/futex-wake-parallel.c                 | 3 ++-
 tools/perf/bench/futex-wake.c                          | 2 +-
 tools/perf/builtin-c2c.c                               | 1 +
 tools/perf/builtin-sched.c                             | 2 ++
 tools/perf/tests/bitmap.c                              | 2 +-
 tools/perf/tests/code-reading.c                        | 1 -
 tools/perf/tests/event_update.c                        | 1 +
 tools/perf/tests/keep-tracking.c                       | 3 +--
 tools/perf/tests/mem2node.c                            | 2 +-
 tools/perf/tests/mmap-basic.c                          | 3 +--
 tools/perf/tests/openat-syscall-all-cpus.c             | 5 +++--
 tools/perf/tests/switch-tracking.c                     | 1 -
 tools/perf/tests/task-exit.c                           | 2 +-
 tools/perf/tests/topology.c                            | 1 +
 tools/perf/util/arm-spe.c                              | 1 -
 tools/perf/util/auxtrace.c                             | 1 -
 tools/perf/util/env.h                                  | 3 ++-
 tools/perf/util/event.c                                | 2 ++
 tools/perf/util/evsel.c                                | 2 +-
 tools/perf/util/intel-bts.c                            | 1 -
 tools/perf/util/parse-events.c                         | 1 -
 tools/perf/util/pmu.c                                  | 1 -
 tools/perf/util/python.c                               | 1 -
 tools/perf/util/record.c                               | 1 -
 tools/perf/util/s390-cpumsf.c                          | 1 -
 tools/perf/util/scripting-engines/trace-event-python.c | 1 -
 tools/perf/util/session.c                              | 1 -
 tools/perf/util/stat.c                                 | 1 +
 tools/perf/util/svghelper.c                            | 2 +-
 tools/perf/util/top.c                                  | 1 -
 37 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index e41defaaa2e6..a32e4b72a98f 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,5 +1,7 @@
 #include <stdio.h>
 #include <stdlib.h>
+#include <perf/cpumap.h>
+#include <internal/cpumap.h>
 #include <api/fs/fs.h>
 #include "debug.h"
 #include "header.h"
@@ -29,7 +31,7 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 
 	/* read midr from list of cpus mapped to this pmu */
 	cpus = perf_cpu_map__get(pmu->cpus);
-	for (cpu = 0; cpu < cpus->nr; cpu++) {
+	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
 		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
 				sysfs, cpus->map[cpu]);
 
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index eb3635941c2b..0a4570b340fa 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -15,7 +15,6 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
-#include "cpumap.h"
 #include "record.h"
 #include "tsc.h"
 #include "tests/tests.h"
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index d1caa4a0a12a..bb617e568841 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -21,12 +21,12 @@
 #include <sys/resource.h>
 #include <sys/epoll.h>
 #include <sys/eventfd.h>
+#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
-#include "cpumap.h"
 
 #include <err.h>
 
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index f6b4472847d2..7af694437f4e 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -76,12 +76,12 @@
 #include <sys/epoll.h>
 #include <sys/eventfd.h>
 #include <sys/types.h>
+#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
-#include "cpumap.h"
 
 #include <err.h>
 
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 80e138904c66..8ba0c3330a9a 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -20,13 +20,13 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <sys/time.h>
+#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
 #include "futex.h"
-#include "cpumap.h"
 
 #include <err.h>
 
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index c5d6d0abbaa9..d0cae8125423 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -14,10 +14,10 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <errno.h>
+#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 #include "bench.h"
 #include "futex.h"
-#include "cpumap.h"
 
 #include <err.h>
 #include <stdlib.h>
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 75d3418c1a88..a00a6891447a 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -20,10 +20,10 @@
 #include <linux/kernel.h>
 #include <linux/time64.h>
 #include <errno.h>
+#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 #include "bench.h"
 #include "futex.h"
-#include "cpumap.h"
 
 #include <err.h>
 #include <stdlib.h>
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 163fe16c275a..a053cf2b7039 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -29,7 +29,8 @@ int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe
 #include <linux/time64.h>
 #include <errno.h>
 #include "futex.h"
-#include "cpumap.h"
+#include <internal/cpumap.h>
+#include <perf/cpumap.h>
 
 #include <err.h>
 #include <stdlib.h>
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 77dcdc13618a..df810096abfe 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -20,10 +20,10 @@
 #include <linux/kernel.h>
 #include <linux/time64.h>
 #include <errno.h>
+#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 #include "bench.h"
 #include "futex.h"
-#include "cpumap.h"
 
 #include <err.h>
 #include <stdlib.h>
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index b09b12e0976b..61aaacc2aedd 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -20,6 +20,7 @@
 #include <sys/param.h>
 #include "debug.h"
 #include "builtin.h"
+#include <perf/cpumap.h>
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "map_symbol.h"
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index ec96d64aec69..511e19a7aafa 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3,6 +3,7 @@
 #include "perf.h"
 #include "perf-sys.h"
 
+#include "util/cpumap.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/symbol.h"
@@ -36,6 +37,7 @@
 #include <pthread.h>
 #include <math.h>
 #include <api/fs/fs.h>
+#include <perf/cpumap.h>
 #include <linux/time64.h>
 
 #include <linux/ctype.h>
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index db2aadff3708..96c137360918 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -2,8 +2,8 @@
 #include <linux/compiler.h>
 #include <linux/bitmap.h>
 #include <perf/cpumap.h>
+#include <internal/cpumap.h>
 #include "tests.h"
-#include "cpumap.h"
 #include "debug.h"
 
 #define NBITS 100
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index c1c29e08e7fb..8d9020c46ca9 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -19,7 +19,6 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
-#include "cpumap.h"
 #include "machine.h"
 #include "map.h"
 #include "symbol.h"
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index cac4290e233a..317eb8c5ccd4 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -2,6 +2,7 @@
 #include <linux/compiler.h>
 #include <perf/cpumap.h>
 #include <string.h>
+#include "cpumap.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "header.h"
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 9f0762d987fa..df0fd5a44e04 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -12,7 +12,6 @@
 #include "evsel.h"
 #include "record.h"
 #include "thread_map.h"
-#include "cpumap.h"
 #include "tests.h"
 
 #define CHECK__(x) {				\
@@ -143,7 +142,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 
 	found = find_comm(evlist, comm);
 	if (found != 1) {
-		pr_debug("Seconf time, failed to find tracking event.\n");
+		pr_debug("Second time, failed to find tracking event.\n");
 		goto out_err;
 	}
 
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 7672ade70f20..a258bd51f1a4 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -4,7 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
-#include "cpumap.h"
+#include <internal/cpumap.h>
 #include "debug.h"
 #include "env.h"
 #include "mem2node.h"
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 85e1d7337dc0..042757629e90 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -10,7 +10,6 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
-#include "cpumap.h"
 #include "tests.h"
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -53,7 +52,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 
 	cpus = perf_cpu_map__new(NULL);
 	if (cpus == NULL) {
-		pr_debug("cpu_map__new\n");
+		pr_debug("perf_cpu_map__new\n");
 		goto out_free_threads;
 	}
 
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 9171f77cd9cd..93c176523e38 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -14,7 +14,8 @@
 #include "evsel.h"
 #include "tests.h"
 #include "thread_map.h"
-#include "cpumap.h"
+#include <perf/cpumap.h>
+#include <internal/cpumap.h>
 #include "debug.h"
 #include "stat.h"
 #include "util/counts.h"
@@ -37,7 +38,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 
 	cpus = perf_cpu_map__new(NULL);
 	if (cpus == NULL) {
-		pr_debug("cpu_map__new\n");
+		pr_debug("perf_cpu_map__new\n");
 		goto out_thread_map_delete;
 	}
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 1a60fa1219f5..3fb1ff7b8a2f 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -14,7 +14,6 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
-#include "cpumap.h"
 #include "record.h"
 #include "tests.h"
 
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index f610e8c0a083..088c7708b03a 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -4,12 +4,12 @@
 #include "evsel.h"
 #include "target.h"
 #include "thread_map.h"
-#include "cpumap.h"
 #include "tests.h"
 
 #include <errno.h>
 #include <signal.h>
 #include <linux/string.h>
+#include <perf/cpumap.h>
 #include <perf/evlist.h>
 
 static int exited;
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index c963f301d15e..7d845d913d7d 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <perf/cpumap.h>
+#include "cpumap.h"
 #include "tests.h"
 #include "session.h"
 #include "evlist.h"
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 8a7340f6a2a2..53be12b23ff4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -16,7 +16,6 @@
 #include <linux/log2.h>
 #include <linux/zalloc.h>
 
-#include "cpumap.h"
 #include "color.h"
 #include "evsel.h"
 #include "machine.h"
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 7ec0a6caa6cd..1c0ff5acff83 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -31,7 +31,6 @@
 #include "map.h"
 #include "pmu.h"
 #include "evsel.h"
-#include "cpumap.h"
 #include "symbol.h"
 #include "thread_map.h"
 #include "asm/bug.h"
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d8e083d42610..db40906e2937 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -4,9 +4,10 @@
 
 #include <linux/types.h>
 #include <linux/rbtree.h>
-#include "cpumap.h"
 #include "rwsem.h"
 
+struct perf_cpu_map;
+
 struct cpu_topology_map {
 	int	socket_id;
 	int	die_id;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f4afbb858ebb..d65ae7cf9316 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -4,6 +4,7 @@
 #include <inttypes.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <perf/cpumap.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -11,6 +12,7 @@
 #include <api/fs/fs.h>
 #include <linux/perf_event.h>
 #include <linux/zalloc.h>
+#include "cpumap.h"
 #include "dso.h"
 #include "event.h"
 #include "debug.h"
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c194ec787f96..5b40b840624c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -31,7 +31,7 @@
 #include "event.h"
 #include "evsel.h"
 #include "evlist.h"
-#include "cpumap.h"
+#include <perf/cpumap.h>
 #include "thread_map.h"
 #include "target.h"
 #include "perf_regs.h"
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index aacffa2b0362..15f87a09f4fe 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -14,7 +14,6 @@
 #include <linux/log2.h>
 #include <linux/zalloc.h>
 
-#include "cpumap.h"
 #include "color.h"
 #include "evsel.h"
 #include "evlist.h"
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5ec21d21113c..a33a1d5059a2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -30,7 +30,6 @@
 #include "parse-events-flex.h"
 #include "pmu.h"
 #include "thread_map.h"
-#include "cpumap.h"
 #include "probe-file.h"
 #include "asm/bug.h"
 #include "util/parse-branch-options.h"
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index fb597fa94234..5608da82ad23 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -20,7 +20,6 @@
 #include "debug.h"
 #include "pmu.h"
 #include "parse-events.h"
-#include "cpumap.h"
 #include "header.h"
 #include "pmu-events/pmu-events.h"
 #include "string2.h"
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 07ca4535e6f7..96dd3333c911 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -11,7 +11,6 @@
 #include "callchain.h"
 #include "evsel.h"
 #include "event.h"
-#include "cpumap.h"
 #include "print_binary.h"
 #include "thread_map.h"
 #include "trace-event.h"
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 860c48895ab6..8a015fc0aba0 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -2,7 +2,6 @@
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "cpumap.h"
 #include "parse-events.h"
 #include <errno.h>
 #include <limits.h>
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 24a99909d8b3..6785cd87aa4d 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -151,7 +151,6 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
-#include "cpumap.h"
 #include "color.h"
 #include "evsel.h"
 #include "evlist.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index bb6828532741..5d341efc3237 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -48,7 +48,6 @@
 #include "map.h"
 #include "symbol.h"
 #include "thread_map.h"
-#include "cpumap.h"
 #include "print_binary.h"
 #include "stat.h"
 #include "mem-events.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2b133bc22caa..2b583e6adb49 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -22,7 +22,6 @@
 #include "symbol.h"
 #include "session.h"
 #include "tool.h"
-#include "cpumap.h"
 #include "perf_regs.h"
 #include "asm/bug.h"
 #include "auxtrace.h"
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 8f1ea27f976f..d309c1cc13db 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -4,6 +4,7 @@
 #include <math.h>
 #include <string.h>
 #include "counts.h"
+#include "cpumap.h"
 #include "debug.h"
 #include "header.h"
 #include "stat.h"
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 582f4a69cd48..96f941e01681 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -17,11 +17,11 @@
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
+#include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
 #include "env.h"
 #include "svghelper.h"
-#include "cpumap.h"
 
 static u64 first_time, last_time;
 static u64 turbo_frequency, max_freq;
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 51fb574998bb..ef96e3dd6902 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -5,7 +5,6 @@
  * Refactored from builtin-top.c, see that files for further copyright notes.
  */
 
-#include "cpumap.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-- 
2.21.0
