From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/43] perf string: Move 'dots' and 'graph_dotted_line' out of sane_ctype.h
Date: Mon,  1 Jul 2019 23:25:48 -0300
Message-ID: <20190702022616.1259-16-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Those are not in that file in the git repo, lets move it from there so
that we get that sane ctype code fully isolated to allow getting it in
sync either with the git sources or better with the kernel sources
(include/linux/ctype.h + lib/ctype.h), that way we can use
check_headers.h to get notified when changes are made in the original
code so that we can cherry-pick.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ioh5sghn3943j0rxg6lb2dgs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kmem.c    | 1 +
 tools/perf/builtin-sched.c   | 1 +
 tools/perf/builtin-top.c     | 1 +
 tools/perf/util/ctype.c      | 9 ---------
 tools/perf/util/evsel.c      | 1 +
 tools/perf/util/sane_ctype.h | 3 ---
 tools/perf/util/string.c     | 9 +++++++++
 tools/perf/util/string2.h    | 3 +++
 8 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index b80eee455111..b833b03d7195 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -21,6 +21,7 @@
 #include "util/cpumap.h"
 
 #include "util/debug.h"
+#include "util/string2.h"
 
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 275f2d92a7bf..79577b67c898 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -15,6 +15,7 @@
 #include "util/thread_map.h"
 #include "util/color.h"
 #include "util/stat.h"
+#include "util/string2.h"
 #include "util/callchain.h"
 #include "util/time-utils.h"
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 12b6b15a9675..4ef02e6888ff 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -40,6 +40,7 @@
 #include "util/cpumap.h"
 #include "util/xyarray.h"
 #include "util/sort.h"
+#include "util/string2.h"
 #include "util/term.h"
 #include "util/intlist.h"
 #include "util/parse-branch-options.h"
diff --git a/tools/perf/util/ctype.c b/tools/perf/util/ctype.c
index 75c0da59c230..f84ecd9e5329 100644
--- a/tools/perf/util/ctype.c
+++ b/tools/perf/util/ctype.c
@@ -30,12 +30,3 @@ unsigned char sane_ctype[256] = {
 	A, A, A, A, A, A, A, A, A, A, A, R, R, P, P, 0,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
-
-const char *graph_dotted_line =
-	"---------------------------------------------------------------------"
-	"---------------------------------------------------------------------"
-	"---------------------------------------------------------------------";
-const char *dots =
-	"....................................................................."
-	"....................................................................."
-	".....................................................................";
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 04c4ed1573cb..4b175166d264 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -35,6 +35,7 @@
 #include "debug.h"
 #include "trace-event.h"
 #include "stat.h"
+#include "string2.h"
 #include "memswap.h"
 #include "util/parse-branch-options.h"
 
diff --git a/tools/perf/util/sane_ctype.h b/tools/perf/util/sane_ctype.h
index a2bb3890864f..c4dce9e3001b 100644
--- a/tools/perf/util/sane_ctype.h
+++ b/tools/perf/util/sane_ctype.h
@@ -2,9 +2,6 @@
 #ifndef _PERF_SANE_CTYPE_H
 #define _PERF_SANE_CTYPE_H
 
-extern const char *graph_dotted_line;
-extern const char *dots;
-
 /* Sane ctype - no locale, and works with signed chars */
 #undef isascii
 #undef isspace
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index d8bfd0c4d2cb..b18884bd673b 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -6,6 +6,15 @@
 
 #include "sane_ctype.h"
 
+const char *graph_dotted_line =
+	"---------------------------------------------------------------------"
+	"---------------------------------------------------------------------"
+	"---------------------------------------------------------------------";
+const char *dots =
+	"....................................................................."
+	"....................................................................."
+	".....................................................................";
+
 #define K 1024LL
 /*
  * perf_atoll()
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 4c68a09b97e8..07fd37568543 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -6,6 +6,9 @@
 #include <stddef.h>
 #include <string.h>
 
+extern const char *graph_dotted_line;
+extern const char *dots;
+
 s64 perf_atoll(const char *str);
 char **argv_split(const char *str, int *argcp);
 void argv_free(char **argv);
-- 
2.20.1
