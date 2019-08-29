From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/37] perf evlist: Remove needless util.h from evlist.h
Date: Thu, 29 Aug 2019 11:38:48 -0300
Message-ID: <20190829143917.29745-9-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There is no need for that util/util.h include there and, remove it,
pruning the include tree, fix the fallout by adding necessary headers to
places that were getting needed includes indirectly from evlist.h ->
util.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-s9f7uve8wvykr5itcm7m7d8q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-bts.c | 1 +
 tools/perf/arch/x86/util/intel-pt.c  | 1 +
 tools/perf/builtin-report.c          | 1 +
 tools/perf/builtin-script.c          | 1 +
 tools/perf/builtin-top.c             | 1 +
 tools/perf/builtin-trace.c           | 1 +
 tools/perf/tests/sdt.c               | 1 +
 tools/perf/util/auxtrace.c           | 1 +
 tools/perf/util/evlist.c             | 1 +
 tools/perf/util/evlist.h             | 1 -
 tools/perf/util/evsel.c              | 1 +
 tools/perf/util/header.c             | 1 +
 tools/perf/util/session.c            | 1 +
 13 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 16d26ea701ad..e4bb5df9b731 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -22,6 +22,7 @@
 #include "../../util/tsc.h"
 #include "../../util/auxtrace.h"
 #include "../../util/intel-bts.h"
+#include "../../util/util.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 746981c82a16..04b424ad4d99 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -26,6 +26,7 @@
 #include "../../util/record.h"
 #include "../../util/target.h"
 #include "../../util/tsc.h"
+#include "../../util/util.h"
 #include "../../util/intel-pt.h"
 
 #define KiB(x) ((x) * 1024)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 318b0b95c14c..0338916af4bf 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -44,6 +44,7 @@
 #include "util/auxtrace.h"
 #include "util/units.h"
 #include "util/branch.h"
+#include "util/util.h"
 
 #include <dlfcn.h>
 #include <errno.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 51e7e6d0eee6..e005be0d359f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -52,6 +52,7 @@
 #include <subcmd/pager.h>
 #include <perf/evlist.h>
 #include "util/record.h"
+#include "util/util.h"
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 29e910fb2d9a..42ba733c9045 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -34,6 +34,7 @@
 #include "util/thread.h"
 #include "util/thread_map.h"
 #include "util/top.h"
+#include "util/util.h"
 #include <linux/rbtree.h>
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 58a75dd3a571..6d9805a8791b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -41,6 +41,7 @@
 #include "util/intlist.h"
 #include "util/thread_map.h"
 #include "util/stat.h"
+#include "util/util.h"
 #include "trace/beauty/beauty.h"
 #include "trace-event.h"
 #include "util/parse-events.h"
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 8bfaa630389c..dbc35a8912ed 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -9,6 +9,7 @@
 #include "debug.h"
 #include "probe-file.h"
 #include "build-id.h"
+#include "util.h"
 
 /* To test SDT event, we need libelf support to scan elf binary */
 #if defined(HAVE_SDT_EVENT) && defined(HAVE_LIBELF_SUPPORT)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 12e9b7acbb2c..112c24aa2cf2 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -50,6 +50,7 @@
 #include "intel-bts.h"
 #include "arm-spe.h"
 #include "s390-cpumsf.h"
+#include "util.h"
 
 #include <linux/ctype.h>
 #include "symbol/kallsyms.h"
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 47bc54111f57..5ad92fa72e78 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -16,6 +16,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "units.h"
+#include "util.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
 #include <signal.h>
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e31ddcc058f2..16796de7af3f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -13,7 +13,6 @@
 #include "event.h"
 #include "evsel.h"
 #include "mmap.h"
-#include "util.h"
 #include <signal.h>
 #include <unistd.h>
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4540bfe4574..dbc04e1053a9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -40,6 +40,7 @@
 #include "stat.h"
 #include "string2.h"
 #include "memswap.h"
+#include "util.h"
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1f2965a07bef..8e67faf4fe88 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -42,6 +42,7 @@
 #include "tool.h"
 #include "time-utils.h"
 #include "units.h"
+#include "util.h"
 #include "cputopo.h"
 #include "bpf-event.h"
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5786e9c807c5..a275f2e15b94 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,7 @@
 #include "thread-stack.h"
 #include "sample-raw.h"
 #include "stat.h"
+#include "util.h"
 #include "arch/common.h"
 
 #ifdef HAVE_ZSTD_SUPPORT
-- 
2.21.0
