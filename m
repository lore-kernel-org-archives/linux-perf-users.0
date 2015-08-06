From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf trace: add total time column to summary.
Date: Thu,  6 Aug 2015 11:24:29 +0200
Message-ID: <1438853069-5902-1-git-send-email-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:51610 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbbHFJeR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Aug 2015 05:34:17 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

It is cumbersome to manually calculate the total time spent in a
given syscall by multiplying the average value with the number of
calls. Instead, we now do this directly inside perf trace. Note
that this is also done by strace, which even adds a column with
relative numbers - something we could do in the future.

Example:

perf trace -s find /some/folder > /dev/null

 Summary of events:

 find (19976), 700123 events, 100.0%, 0.000 msec

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   read                   4     0.006     0.001     0.002     0.003     27.42%
   write               8046     9.617     0.001     0.001     0.035      0.56%
   open               34196    40.384     0.001     0.001     0.071      0.30%
   close              68375    57.104     0.001     0.001     0.076      0.25%
   stat                   4     0.004     0.001     0.001     0.001      3.14%
   fstat              34189    27.518     0.001     0.001     0.060      0.34%
   mmap                  13     0.029     0.001     0.002     0.003     10.74%
   mprotect               6     0.018     0.002     0.003     0.005     17.04%
   munmap                 3     0.014     0.003     0.005     0.006     24.87%
   brk                   87     0.490     0.001     0.006     0.016      6.50%
   ioctl                  3     0.004     0.001     0.001     0.003     36.39%
   access                 1     0.004     0.004     0.004     0.004      0.00%
   uname                  1     0.001     0.001     0.001     0.001      0.00%
   getdents           68393   143.600     0.001     0.002     0.187      0.95%
   fchdir             68371    56.980     0.001     0.001     0.111      0.39%
   arch_prctl             1     0.001     0.001     0.001     0.001      0.00%
   openat             34184    41.737     0.001     0.001     0.102      0.41%
   newfstatat         34184    41.180     0.001     0.001     0.064      0.34%

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/builtin-trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d183d88..98e1d8b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2586,9 +2586,9 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
 
 	printed += fprintf(fp, "\n");
 
-	printed += fprintf(fp, "   syscall            calls      min       avg       max      stddev\n");
-	printed += fprintf(fp, "                               (msec)    (msec)    (msec)        (%%)\n");
-	printed += fprintf(fp, "   --------------- -------- --------- --------- ---------     ------\n");
+	printed += fprintf(fp, "   syscall            calls    total       min       avg       max      stddev\n");
+	printed += fprintf(fp, "                               (msec)    (msec)    (msec)    (msec)        (%%)\n");
+	printed += fprintf(fp, "   --------------- -------- --------- --------- --------- ---------     ------\n");
 
 	/* each int_node is a syscall */
 	while (inode) {
@@ -2605,8 +2605,8 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
 
 			sc = &trace->syscalls.table[inode->i];
 			printed += fprintf(fp, "   %-15s", sc->name);
-			printed += fprintf(fp, " %8" PRIu64 " %9.3f %9.3f",
-					   n, min, avg);
+			printed += fprintf(fp, " %8" PRIu64 " %9.3f %9.3f %9.3f",
+					   n, avg * n, min, avg);
 			printed += fprintf(fp, " %9.3f %9.2f%%\n", max, pct);
 		}
 
-- 
2.5.0
