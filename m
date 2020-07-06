From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 3/3] perf bench numa: fix wrong benchmark configuration
Date: Mon,  6 Jul 2020 11:42:54 +0200
Message-ID: <ec0af179404329c21923f6da3f490ae4418efc1f.1594028311.git.agordeev@linux.ibm.com>
References: <cover.1594028310.git.agordeev@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1594028310.git.agordeev@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

This update fixes a wrong number of processes for one
benchmark and consolidates two others in a unified way.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/bench/numa.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 6574004..c4b24d8 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1753,7 +1753,7 @@ static int run_bench_numa(const char *name, const char **argv)
    { " 1x3-convergence,", "mem",  "-p",  "1", "-t",  "3", "-P",  "512", OPT_CONV },
    { " 1x4-convergence,", "mem",  "-p",  "1", "-t",  "4", "-P",  "512", OPT_CONV },
    { " 1x6-convergence,", "mem",  "-p",  "1", "-t",  "6", "-P", "1020", OPT_CONV },
-   { " 2x3-convergence,", "mem",  "-p",  "3", "-t",  "3", "-P", "1020", OPT_CONV },
+   { " 2x3-convergence,", "mem",  "-p",  "2", "-t",  "3", "-P", "1020", OPT_CONV },
    { " 3x3-convergence,", "mem",  "-p",  "3", "-t",  "3", "-P", "1020", OPT_CONV },
    { " 4x4-convergence,", "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_CONV },
    { " 4x4-convergence-NOTHP,",
@@ -1782,6 +1782,8 @@ static int run_bench_numa(const char *name, const char **argv)
    { " 1x8-bw-thread,",   "mem",  "-p",  "1", "-t",  "8", "-T",  "256", OPT_BW },
    { "1x16-bw-thread,",   "mem",  "-p",  "1", "-t", "16", "-T",  "128", OPT_BW },
    { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "64", OPT_BW },
+   { "1x32-bw-thread-NOTHP,",
+			  "mem",  "-p",  "1", "-t", "32", "-T",   "64", OPT_BW_NOTHP },
 
    { " 2x3-bw-process,",  "mem",  "-p",  "2", "-t",  "3", "-P",  "512", OPT_BW },
    { " 4x4-bw-process,",  "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_BW },
@@ -1795,9 +1797,6 @@ static int run_bench_numa(const char *name, const char **argv)
    { "2x16-bw-process,",  "mem",  "-p",  "2", "-t", "16", "-P",  "512", OPT_BW },
    { "1x32-bw-process,",  "mem",  "-p",  "1", "-t", "32", "-P", "2048", OPT_BW },
 
-   { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW },
-   { "1x32-bw-thread-NOTHP,",
-			  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW_NOTHP },
    { "2x16-bw-thread,",   "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW },
    { "2x16-bw-thread-NOTHP,",
 			  "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW_NOTHP },
-- 
1.8.3.1
