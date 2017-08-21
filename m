From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/13] perf tools: Use default CPUINFO_PROC where it fits
Date: Mon, 21 Aug 2017 16:25:45 -0300
Message-ID: <20170821192549.17251-10-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Several architectures don't need to define it since the string is the
same as the default one, so nuke them.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-v1e1jr1u474w9xcelpaoxamu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-sys.h    | 19 ++-----------------
 tools/perf/util/header.c |  3 ---
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
index 2aaa7366cdc2..c11f0c76e90c 100644
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -9,14 +9,6 @@
 #include <linux/perf_event.h>
 #include <asm/barrier.h>
 
-#if defined(__i386__)
-#define CPUINFO_PROC	{"model name"}
-#endif
-
-#if defined(__x86_64__)
-#define CPUINFO_PROC	{"model name"}
-#endif
-
 #ifdef __powerpc__
 #define CPUINFO_PROC	{"cpu"}
 #endif
@@ -41,17 +33,10 @@
 #define CPUINFO_PROC	{"cpu model"}
 #endif
 
-#ifdef __ia64__
-#define CPUINFO_PROC	{"model name"}
-#endif
-
 #ifdef __arm__
 #define CPUINFO_PROC	{"model name", "Processor"}
 #endif
 
-#ifdef __aarch64__
-#endif
-
 #ifdef __mips__
 #define CPUINFO_PROC	{"cpu model"}
 #endif
@@ -68,8 +53,8 @@
 #define CPUINFO_PROC	{"core ID"}
 #endif
 
-#ifdef __tile__
-#define CPUINFO_PROC    {"model name"}
+#ifndef CPUINFO_PROC
+#define CPUINFO_PROC	{ "model name", }
 #endif
 
 static inline int
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 28bf4442d577..605bbd5404fb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -380,9 +380,6 @@ static int __write_cpudesc(struct feat_fd *ff, const char *cpuinfo_proc)
 static int write_cpudesc(struct feat_fd *ff,
 		       struct perf_evlist *evlist __maybe_unused)
 {
-#ifndef CPUINFO_PROC
-#define CPUINFO_PROC {"model name", }
-#endif
 	const char *cpuinfo_procs[] = CPUINFO_PROC;
 	unsigned int i;
 
-- 
2.13.5
