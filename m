From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 87/91] perf bench: Add kallsyms parsing
Date: Wed,  6 May 2020 12:22:30 -0300
Message-ID: <20200506152234.21977-88-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

Add a benchmark for kallsyms parsing. Example output:

  Running 'internals/kallsyms-parse' benchmark:
  Average kallsyms__parse took: 103.971 ms (+- 0.121 ms)

Committer testing:

Test Machine: AMD Ryzen 5 3600X 6-Core Processor

  [root@five ~]# perf bench internals kallsyms-parse
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 79.692 ms (+- 0.101 ms)
  [root@five ~]# perf stat -r5 perf bench internals kallsyms-parse
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 80.563 ms (+- 0.079 ms)
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 81.046 ms (+- 0.155 ms)
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 80.874 ms (+- 0.104 ms)
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 81.173 ms (+- 0.133 ms)
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 81.169 ms (+- 0.074 ms)

   Performance counter stats for 'perf bench internals kallsyms-parse' (5 runs):

            8,093.54 msec task-clock                #    0.999 CPUs utilized            ( +-  0.14% )
               3,165      context-switches          #    0.391 K/sec                    ( +-  0.18% )
                  10      cpu-migrations            #    0.001 K/sec                    ( +- 23.13% )
                 744      page-faults               #    0.092 K/sec                    ( +-  0.21% )
      34,551,564,954      cycles                    #    4.269 GHz                      ( +-  0.05% )  (83.33%)
       1,160,584,308      stalled-cycles-frontend   #    3.36% frontend cycles idle     ( +-  1.60% )  (83.33%)
      14,974,323,985      stalled-cycles-backend    #   43.34% backend cycles idle      ( +-  0.24% )  (83.33%)
      58,712,905,705      instructions              #    1.70  insn per cycle
                                                    #    0.26  stalled cycles per insn  ( +-  0.01% )  (83.34%)
      14,136,433,778      branches                  # 1746.632 M/sec                    ( +-  0.01% )  (83.33%)
         141,943,217      branch-misses             #    1.00% of all branches          ( +-  0.04% )  (83.33%)

              8.1040 +- 0.0115 seconds time elapsed  ( +-  0.14% )

  [root@five ~]#

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200501221315.54715-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/Build            |  1 +
 tools/perf/bench/bench.h          |  1 +
 tools/perf/bench/kallsyms-parse.c | 75 +++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c        |  1 +
 4 files changed, 78 insertions(+)
 create mode 100644 tools/perf/bench/kallsyms-parse.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 042827385c87..768e408757a0 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -9,6 +9,7 @@ perf-y += futex-lock-pi.o
 perf-y += epoll-wait.o
 perf-y += epoll-ctl.o
 perf-y += synthesize.o
+perf-y += kallsyms-parse.o
 
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 4d669c803237..61cae4966cae 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -44,6 +44,7 @@ int bench_futex_lock_pi(int argc, const char **argv);
 int bench_epoll_wait(int argc, const char **argv);
 int bench_epoll_ctl(int argc, const char **argv);
 int bench_synthesize(int argc, const char **argv);
+int bench_kallsyms_parse(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
 #define BENCH_FORMAT_DEFAULT		0
diff --git a/tools/perf/bench/kallsyms-parse.c b/tools/perf/bench/kallsyms-parse.c
new file mode 100644
index 000000000000..2b0d0f980ae9
--- /dev/null
+++ b/tools/perf/bench/kallsyms-parse.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Benchmark of /proc/kallsyms parsing.
+ *
+ * Copyright 2020 Google LLC.
+ */
+#include <stdlib.h>
+#include "bench.h"
+#include "../util/stat.h"
+#include <linux/time64.h>
+#include <subcmd/parse-options.h>
+#include <symbol/kallsyms.h>
+
+static unsigned int iterations = 100;
+
+static const struct option options[] = {
+	OPT_UINTEGER('i', "iterations", &iterations,
+		"Number of iterations used to compute average"),
+	OPT_END()
+};
+
+static const char *const bench_usage[] = {
+	"perf bench internals kallsyms-parse <options>",
+	NULL
+};
+
+static int bench_process_symbol(void *arg __maybe_unused,
+				const char *name __maybe_unused,
+				char type __maybe_unused,
+				u64 start __maybe_unused)
+{
+	return 0;
+}
+
+static int do_kallsyms_parse(void)
+{
+	struct timeval start, end, diff;
+	u64 runtime_us;
+	unsigned int i;
+	double time_average, time_stddev;
+	int err;
+	struct stats time_stats;
+
+	init_stats(&time_stats);
+
+	for (i = 0; i < iterations; i++) {
+		gettimeofday(&start, NULL);
+		err = kallsyms__parse("/proc/kallsyms", NULL,
+				bench_process_symbol);
+		if (err)
+			return err;
+
+		gettimeofday(&end, NULL);
+		timersub(&end, &start, &diff);
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&time_stats, runtime_us);
+	}
+
+	time_average = avg_stats(&time_stats) / USEC_PER_MSEC;
+	time_stddev = stddev_stats(&time_stats) / USEC_PER_MSEC;
+	printf("  Average kallsyms__parse took: %.3f ms (+- %.3f ms)\n",
+		time_average, time_stddev);
+	return 0;
+}
+
+int bench_kallsyms_parse(int argc, const char **argv)
+{
+	argc = parse_options(argc, argv, options, bench_usage, 0);
+	if (argc) {
+		usage_with_options(bench_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	return do_kallsyms_parse();
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 11c79a8d85d6..083273209c88 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -78,6 +78,7 @@ static struct bench epoll_benchmarks[] = {
 
 static struct bench internals_benchmarks[] = {
 	{ "synthesize", "Benchmark perf event synthesis",	bench_synthesize	},
+	{ "kallsyms-parse", "Benchmark kallsyms parsing",	bench_kallsyms_parse	},
 	{ NULL,		NULL,					NULL			}
 };
 
-- 
2.21.1
