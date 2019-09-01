From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/47] perf header: Move CPUINFO_PROC to the only file where it is used
Date: Sun,  1 Sep 2019 09:22:49 -0300
Message-ID: <20190901122326.5793-11-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To reduce perf-sys.h and eventually nuke it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ars2j5m3if3gypsvkbbijucq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-sys.h    | 44 ----------------------------------------
 tools/perf/util/header.c | 18 ++++++++++++++++
 2 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
index 3eb7a39169f6..6ffb0fbd6237 100644
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -10,50 +10,6 @@
 #include <linux/perf_event.h>
 #include <asm/barrier.h>
 
-#ifdef __powerpc__
-#define CPUINFO_PROC	{"cpu"}
-#endif
-
-#ifdef __s390__
-#define CPUINFO_PROC	{"vendor_id"}
-#endif
-
-#ifdef __sh__
-#define CPUINFO_PROC	{"cpu type"}
-#endif
-
-#ifdef __hppa__
-#define CPUINFO_PROC	{"cpu"}
-#endif
-
-#ifdef __sparc__
-#define CPUINFO_PROC	{"cpu"}
-#endif
-
-#ifdef __alpha__
-#define CPUINFO_PROC	{"cpu model"}
-#endif
-
-#ifdef __arm__
-#define CPUINFO_PROC	{"model name", "Processor"}
-#endif
-
-#ifdef __mips__
-#define CPUINFO_PROC	{"cpu model"}
-#endif
-
-#ifdef __arc__
-#define CPUINFO_PROC	{"Processor"}
-#endif
-
-#ifdef __xtensa__
-#define CPUINFO_PROC	{"core ID"}
-#endif
-
-#ifndef CPUINFO_PROC
-#define CPUINFO_PROC	{ "model name", }
-#endif
-
 static inline int
 sys_perf_event_open(struct perf_event_attr *attr,
 		      pid_t pid, int cpu, int group_fd,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dd2bb0861ab1..d252124f926d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -436,7 +436,25 @@ static int __write_cpudesc(struct feat_fd *ff, const char *cpuinfo_proc)
 static int write_cpudesc(struct feat_fd *ff,
 		       struct evlist *evlist __maybe_unused)
 {
+#if defined(__powerpc__) || defined(__hppa__) || defined(__sparc__)
+#define CPUINFO_PROC	{ "cpu", }
+#elif defined(__s390__)
+#define CPUINFO_PROC	{ "vendor_id", }
+#elif defined(__sh__)
+#define CPUINFO_PROC	{ "cpu type", }
+#elif defined(__alpha__) || defined(__mips__)
+#define CPUINFO_PROC	{ "cpu model", }
+#elif defined(__arm__)
+#define CPUINFO_PROC	{ "model name", "Processor", }
+#elif defined(__arc__)
+#define CPUINFO_PROC	{ "Processor", }
+#elif defined(__xtensa__)
+#define CPUINFO_PROC	{ "core ID", }
+#else
+#define CPUINFO_PROC	{ "model name", }
+#endif
 	const char *cpuinfo_procs[] = CPUINFO_PROC;
+#undef CPUINFO_PROC
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(cpuinfo_procs); i++) {
-- 
2.21.0
