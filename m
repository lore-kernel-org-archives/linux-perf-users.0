From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 065/107] libperf: Add perf_evlist__init() function
Date: Mon, 29 Jul 2019 23:55:28 -0300
Message-ID: <20190730025610.22603-66-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the perf_evlist__init() function to initialize a perf_evlist struct.

Committer testing:

Fix a change in init ordering that was causing this backtrace:

  (gdb) run stat sleep 1
  Starting program: /root/bin/perf stat sleep 1
  Program received signal SIGSEGV, Segmentation fault.
  0x00000000004f6b55 in __perf_evlist__propagate_maps (evlist=0xbb34c0, evsel=0x0) at util/evlist.c:161
  161		if (!evsel->own_cpus || evlist->has_user_cpus) {
  Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-29.fc30.x86_64 elfutils-libelf-0.176-3.fc30.x86_64 elfutils-libs-0.176-3.fc30.x86_64 glib2-2.60.4-1.fc30.x86_64 libbabeltrace-1.5.6-2.fc30.x86_64 libgcc-9.1.1-1.fc30.x86_64 libunwind-1.3.1-2.fc30.x86_64 libuuid-2.33.2-1.fc30.x86_64 libxcrypt-4.4.6-2.fc30.x86_64 libzstd-1.4.0-1.fc30.x86_64 numactl-libs-2.0.12-2.fc30.x86_64 pcre-8.43-2.fc30.x86_64 perl-libs-5.28.2-436.fc30.x86_64 popt-1.16-17.fc30.x86_64 python2-libs-2.7.16-2.fc30.x86_64 slang-2.3.2-5.fc30.x86_64 xz-libs-5.2.4-5.fc30.x86_64 zlib-1.2.11-15.fc30.x86_64
  (gdb) bt
  #0  0x00000000004f6b55 in __perf_evlist__propagate_maps (evlist=0xbb34c0, evsel=0x0) at util/evlist.c:161
  #1  0x00000000004f6c7a in perf_evlist__propagate_maps (evlist=0xbb34c0) at util/evlist.c:178
  #2  0x00000000004f955e in perf_evlist__set_maps (evlist=0xbb34c0, cpus=0x0, threads=0x0) at util/evlist.c:1128
  #3  0x00000000004f66f8 in evlist__init (evlist=0xbb34c0, cpus=0x0, threads=0x0) at util/evlist.c:52
  #4  0x00000000004f6790 in evlist__new () at util/evlist.c:64
  #5  0x0000000000456071 in cmd_stat (argc=3, argv=0x7fffffffd670) at builtin-stat.c:1705
  #6  0x00000000004dd0fa in run_builtin (p=0xa21e00 <commands+288>, argc=3, argv=0x7fffffffd670) at perf.c:304
  #7  0x00000000004dd367 in handle_internal_command (argc=3, argv=0x7fffffffd670) at perf.c:356
  #8  0x00000000004dd4ae in run_argv (argcp=0x7fffffffd4cc, argv=0x7fffffffd4c0) at perf.c:400
  #9  0x00000000004dd81a in main (argc=3, argv=0x7fffffffd670) at perf.c:522
  (gdb) bt

So move the initialization of the core evlist (calling
perf_evlist__init()) to before perf_evlist__set_maps() in
evlist__init().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-39-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 5 +++++
 tools/perf/lib/include/perf/evlist.h | 4 ++++
 tools/perf/lib/libperf.map           | 1 +
 tools/perf/util/evlist.c             | 3 ++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 646bdd518793..fdc8c1894b37 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -2,3 +2,8 @@
 #include <perf/evlist.h>
 #include <linux/list.h>
 #include <internal/evlist.h>
+
+void perf_evlist__init(struct perf_evlist *evlist)
+{
+	INIT_LIST_HEAD(&evlist->entries);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 92b0eb39caec..1ddfcca0bd01 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -2,6 +2,10 @@
 #ifndef __LIBPERF_EVLIST_H
 #define __LIBPERF_EVLIST_H
 
+#include <perf/core.h>
+
 struct perf_evlist;
 
+LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
+
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 54f8503c6d82..5ca6ff6fcdfa 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -10,6 +10,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__get;
 		perf_thread_map__put;
 		perf_evsel__init;
+		perf_evlist__init;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index faf3ffd81d4c..f4aa6cf80559 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -33,6 +33,7 @@
 #include <linux/log2.h>
 #include <linux/err.h>
 #include <linux/zalloc.h>
+#include <perf/evlist.h>
 
 #ifdef LACKS_SIGQUEUE_PROTOTYPE
 int sigqueue(pid_t pid, int sig, const union sigval value);
@@ -48,7 +49,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 
 	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
-	INIT_LIST_HEAD(&evlist->core.entries);
+	perf_evlist__init(&evlist->core);
 	perf_evlist__set_maps(evlist, cpus, threads);
 	fdarray__init(&evlist->pollfd, 64);
 	evlist->workload.pid = -1;
-- 
2.21.0
