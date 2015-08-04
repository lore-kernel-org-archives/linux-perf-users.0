From: Milian Wolff <mail@milianw.de>
Subject: Re: perf: add total time column to trace summary.
Date: Tue, 04 Aug 2015 19:15:12 +0200
Message-ID: <9076476.ez4BAPRGfD@milian-kdab2>
References: <1617726.5Fu7Vjy8Ds@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:54589 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbbHDRPO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Aug 2015 13:15:14 -0400
Received: from milian-kdab2.localnet (unknown [185.28.184.2])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id C51EF62803F8
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2015 19:15:12 +0200 (CEST)
In-Reply-To: <1617726.5Fu7Vjy8Ds@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

On Tuesday 04 August 2015 18:53:17 Milian Wolff wrote:
> See attached patch, it makes perf trace -s much more useful for me.

And again with the patch inline:

From a64d3e57cb2ba426311e4e3d8bd7dea14baa34fa Mon Sep 17 00:00:00 2001
From: Milian Wolff <milian.wolff@kdab.com>
Date: Tue, 4 Aug 2015 18:49:22 +0200
Subject: [PATCH] perf: add total time column to trace summary.

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
---
 tools/perf/builtin-trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d183d88..98e1d8b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2586,9 +2586,9 @@ static size_t thread__dump_stats(struct thread_trace 
*ttrace,
 
 	printed += fprintf(fp, "\n");
 
-	printed += fprintf(fp, "   syscall            calls      min       avg       
max      stddev\n");
-	printed += fprintf(fp, "                               (msec)    (msec)    
(msec)        (%%)\n");
-	printed += fprintf(fp, "   --------------- -------- --------- --------- 
---------     ------\n");
+	printed += fprintf(fp, "   syscall            calls    total       min       
avg       max      stddev\n");
+	printed += fprintf(fp, "                               (msec)    (msec)    
(msec)    (msec)        (%%)\n");
+	printed += fprintf(fp, "   --------------- -------- --------- --------- 
--------- ---------     ------\n");
 
 	/* each int_node is a syscall */
 	while (inode) {
@@ -2605,8 +2605,8 @@ static size_t thread__dump_stats(struct thread_trace 
*ttrace,
 
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



-- 
Milian Wolff
mail@milianw.de
http://milianw.de
