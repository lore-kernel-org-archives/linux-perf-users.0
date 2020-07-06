From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 2/3] perf bench numa: fix benchmark names
Date: Mon,  6 Jul 2020 11:42:53 +0200
Message-ID: <e4c639c4ad7f77d47ed46dfc28ec213ff83de5da.1594028311.git.agordeev@linux.ibm.com>
References: <cover.1594028310.git.agordeev@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1594028310.git.agordeev@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Several benchmarks have names that do not correspond to
their configuration. Fix that and also some whitespace
inconsistencies.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/bench/numa.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 23e224e..6574004 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -812,12 +812,12 @@ static u64 do_work(u8 *__data, long bytes, int nr, int nr_max, int loop, u64 val
 			}
 		}
 	} else if (!g->p.data_backwards || (nr + loop) & 1) {
+		/* Process data forwards: */
 
 		d0 = data + off;
 		d  = data + off + 1;
 		d1 = data + words;
 
-		/* Process data forwards: */
 		for (;;) {
 			if (unlikely(d >= d1))
 				d = data;
@@ -835,7 +835,6 @@ static u64 do_work(u8 *__data, long bytes, int nr, int nr_max, int loop, u64 val
 		d  = data + off - 1;
 		d1 = data + words;
 
-		/* Process data forwards: */
 		for (;;) {
 			if (unlikely(d < data))
 				d = data + words-1;
@@ -1732,12 +1731,12 @@ static int run_bench_numa(const char *name, const char **argv)
  */
 static const char *tests[][MAX_ARGS] = {
    /* Basic single-stream NUMA bandwidth measurements: */
-   { "RAM-bw-local,",	  "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
+   { "RAM-bw-local,",     "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
 			  "-C" ,   "0", "-M",   "0", OPT_BW_RAM },
    { "RAM-bw-local-NOTHP,",
 			  "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
 			  "-C" ,   "0", "-M",   "0", OPT_BW_RAM_NOTHP },
-   { "RAM-bw-remote,",	  "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
+   { "RAM-bw-remote,",    "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
 			  "-C" ,   "0", "-M",   "1", OPT_BW_RAM },
 
    /* 2-stream NUMA bandwidth measurements: */
@@ -1779,27 +1778,28 @@ static int run_bench_numa(const char *name, const char **argv)
 			  "mem",  "-p",  "8", "-t",  "1", "-P", " 512", OPT_BW_NOTHP },
    { "16x1-bw-process,",  "mem",  "-p", "16", "-t",  "1", "-P",  "256", OPT_BW },
 
-   { " 4x1-bw-thread,",	  "mem",  "-p",  "1", "-t",  "4", "-T",  "256", OPT_BW },
-   { " 8x1-bw-thread,",	  "mem",  "-p",  "1", "-t",  "8", "-T",  "256", OPT_BW },
-   { "16x1-bw-thread,",   "mem",  "-p",  "1", "-t", "16", "-T",  "128", OPT_BW },
-   { "32x1-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "64", OPT_BW },
+   { " 1x4-bw-thread,",   "mem",  "-p",  "1", "-t",  "4", "-T",  "256", OPT_BW },
+   { " 1x8-bw-thread,",   "mem",  "-p",  "1", "-t",  "8", "-T",  "256", OPT_BW },
+   { "1x16-bw-thread,",   "mem",  "-p",  "1", "-t", "16", "-T",  "128", OPT_BW },
+   { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "64", OPT_BW },
 
-   { " 2x3-bw-thread,",	  "mem",  "-p",  "2", "-t",  "3", "-P",  "512", OPT_BW },
-   { " 4x4-bw-thread,",	  "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_BW },
-   { " 4x6-bw-thread,",	  "mem",  "-p",  "4", "-t",  "6", "-P",  "512", OPT_BW },
-   { " 4x8-bw-thread,",	  "mem",  "-p",  "4", "-t",  "8", "-P",  "512", OPT_BW },
-   { " 4x8-bw-thread-NOTHP,",
+   { " 2x3-bw-process,",  "mem",  "-p",  "2", "-t",  "3", "-P",  "512", OPT_BW },
+   { " 4x4-bw-process,",  "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_BW },
+   { " 4x6-bw-process,",  "mem",  "-p",  "4", "-t",  "6", "-P",  "512", OPT_BW },
+   { " 4x8-bw-process,",  "mem",  "-p",  "4", "-t",  "8", "-P",  "512", OPT_BW },
+   { " 4x8-bw-process-NOTHP,",
 			  "mem",  "-p",  "4", "-t",  "8", "-P",  "512", OPT_BW_NOTHP },
-   { " 3x3-bw-thread,",	  "mem",  "-p",  "3", "-t",  "3", "-P",  "512", OPT_BW },
-   { " 5x5-bw-thread,",	  "mem",  "-p",  "5", "-t",  "5", "-P",  "512", OPT_BW },
+   { " 3x3-bw-process,",  "mem",  "-p",  "3", "-t",  "3", "-P",  "512", OPT_BW },
+   { " 5x5-bw-process,",  "mem",  "-p",  "5", "-t",  "5", "-P",  "512", OPT_BW },
 
-   { "2x16-bw-thread,",   "mem",  "-p",  "2", "-t", "16", "-P",  "512", OPT_BW },
-   { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-P", "2048", OPT_BW },
+   { "2x16-bw-process,",  "mem",  "-p",  "2", "-t", "16", "-P",  "512", OPT_BW },
+   { "1x32-bw-process,",  "mem",  "-p",  "1", "-t", "32", "-P", "2048", OPT_BW },
 
-   { "numa02-bw,",	  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW },
-   { "numa02-bw-NOTHP,",  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW_NOTHP },
-   { "numa01-bw-thread,", "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW },
-   { "numa01-bw-thread-NOTHP,",
+   { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW },
+   { "1x32-bw-thread-NOTHP,",
+			  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW_NOTHP },
+   { "2x16-bw-thread,",   "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW },
+   { "2x16-bw-thread-NOTHP,",
 			  "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW_NOTHP },
 };
 
-- 
1.8.3.1
