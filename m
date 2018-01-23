From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/43] perf tools: Move conditional O_CLOEXEC to util.h
Date: Tue, 23 Jan 2018 10:12:14 -0300
Message-ID: <20180123131251.28197-7-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Wang YanQing <udknight@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To be more generally available and get the build on centos:5 to
work after we use O_CLOEXEC in the next patch, in the util/dso.c file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Wang YanQing <udknight@gmail.com>
Link: https://lkml.kernel.org/n/tip-vsjbiydh15pfqomxw1kx64ex@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 10 ----------
 tools/perf/util/util.h | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 48094fde0a68..d8cfc19ddb10 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -12,16 +12,6 @@
 #include "util.h"
 #include "debug.h"
 
-#ifndef O_CLOEXEC
-#ifdef __sparc__
-#define O_CLOEXEC	0x400000
-#elif defined(__alpha__) || defined(__hppa__)
-#define O_CLOEXEC	010000000
-#else
-#define O_CLOEXEC	02000000
-#endif
-#endif
-
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 01434509c2e9..9496365da3d7 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -68,4 +68,14 @@ extern bool perf_singlethreaded;
 void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
+#ifndef O_CLOEXEC
+#ifdef __sparc__
+#define O_CLOEXEC      0x400000
+#elif defined(__alpha__) || defined(__hppa__)
+#define O_CLOEXEC      010000000
+#else
+#define O_CLOEXEC      02000000
+#endif
+#endif
+
 #endif /* GIT_COMPAT_UTIL_H */
-- 
2.14.3
