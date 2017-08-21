From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/13] perf tools: Remove unused cpu_relax() macros
Date: Mon, 21 Aug 2017 16:25:44 -0300
Message-ID: <20170821192549.17251-9-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since 195564390210 ("perf_counter: kerneltop: simplify data_head read")
we do not use it, and this was way back in 2009, remove it before some
other arch maintainer adds its implementation, like so many did,
needlessly :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-3l2su9c58eaq4twjzrf9uu08@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-sys.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
index e4b717e9eb6c..2aaa7366cdc2 100644
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -10,12 +10,10 @@
 #include <asm/barrier.h>
 
 #if defined(__i386__)
-#define cpu_relax()	asm volatile("rep; nop" ::: "memory");
 #define CPUINFO_PROC	{"model name"}
 #endif
 
 #if defined(__x86_64__)
-#define cpu_relax()	asm volatile("rep; nop" ::: "memory");
 #define CPUINFO_PROC	{"model name"}
 #endif
 
@@ -44,7 +42,6 @@
 #endif
 
 #ifdef __ia64__
-#define cpu_relax()	asm volatile ("hint @pause" ::: "memory")
 #define CPUINFO_PROC	{"model name"}
 #endif
 
@@ -53,7 +50,6 @@
 #endif
 
 #ifdef __aarch64__
-#define cpu_relax()	asm volatile("yield" ::: "memory")
 #endif
 
 #ifdef __mips__
@@ -73,14 +69,9 @@
 #endif
 
 #ifdef __tile__
-#define cpu_relax()	asm volatile ("mfspr zero, PASS" ::: "memory")
 #define CPUINFO_PROC    {"model name"}
 #endif
 
-#ifndef cpu_relax
-#define cpu_relax() barrier()
-#endif
-
 static inline int
 sys_perf_event_open(struct perf_event_attr *attr,
 		      pid_t pid, int cpu, int group_fd,
-- 
2.13.5
