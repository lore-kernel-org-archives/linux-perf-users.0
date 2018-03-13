From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/31] perf c2c record: Record physical addresses in samples
Date: Tue, 13 Mar 2018 09:04:41 -0300
Message-ID: <20180313120508.29327-5-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Joe Mario <jmario@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We are going to display NUMA node information in following patches. For
this we need to have physical address data in the sample.

Adding --phys-data as a default option for perf c2c record.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-c2c.txt | 2 +-
 tools/perf/builtin-c2c.c              | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 822414235170..095aebdc5bb7 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -116,7 +116,7 @@ and calls standard perf record command.
 Following perf record options are configured by default:
 (check perf record man page for details)
 
-  -W,-d,--sample-cpu
+  -W,-d,--phys-data,--sample-cpu
 
 Unless specified otherwise with '-e' option, following events are monitored by
 default:
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 98d243fa0c06..95765a1db903 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2704,7 +2704,7 @@ static int perf_c2c__record(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	rec_argc = argc + 10; /* max number of arguments */
+	rec_argc = argc + 11; /* max number of arguments */
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (!rec_argv)
 		return -1;
@@ -2720,6 +2720,7 @@ static int perf_c2c__record(int argc, const char **argv)
 		rec_argv[i++] = "-W";
 
 	rec_argv[i++] = "-d";
+	rec_argv[i++] = "--phys-data";
 	rec_argv[i++] = "--sample-cpu";
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-- 
2.14.3
