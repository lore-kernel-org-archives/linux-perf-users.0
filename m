From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/33] perf srcline: Add missing srcline.h header to files needing its defs
Date: Mon, 26 Aug 2019 22:36:06 -0300
Message-ID: <20190827013634.3173-6-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When srcline was introduced it wrongly added the include to util/sort.h,
even with that header not needing the definitions it provides, fix it by
adding it to the places that need it as a pre patch to remove srcline.h
from sort.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-shuebppedtye8hrgxk15qe3x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c   | 2 ++
 tools/perf/builtin-report.c | 1 +
 tools/perf/builtin-script.c | 1 +
 tools/perf/util/annotate.c  | 2 ++
 tools/perf/util/machine.c   | 2 ++
 tools/perf/util/sort.c      | 1 +
 6 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index e91c0d798181..51c37e53b3d8 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -15,6 +15,7 @@
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/sort.h"
+#include "util/srcline.h"
 #include "util/symbol.h"
 #include "util/data.h"
 #include "util/config.h"
@@ -22,6 +23,7 @@
 #include "util/annotate.h"
 #include "util/map.h"
 #include <linux/zalloc.h>
+#include <subcmd/parse-options.h>
 
 #include <errno.h>
 #include <inttypes.h>
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 79dfb1139f94..318b0b95c14c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -28,6 +28,7 @@
 #include "util/evswitch.h"
 #include "util/header.h"
 #include "util/session.h"
+#include "util/srcline.h"
 #include "util/tool.h"
 
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ee05621d3bd6..6f389b33fbe5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -11,6 +11,7 @@
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/map.h"
+#include "util/srcline.h"
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/trace-event.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e0518dc4c4d2..3bd1691f0be7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -22,6 +22,7 @@
 #include "cache.h"
 #include "map.h"
 #include "symbol.h"
+#include "srcline.h"
 #include "units.h"
 #include "debug.h"
 #include "annotate.h"
@@ -37,6 +38,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <bpf/libbpf.h>
+#include <subcmd/parse-options.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f7c1a7e6c4ba..47430afd3c2d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -10,11 +10,13 @@
 #include "hist.h"
 #include "machine.h"
 #include "map.h"
+#include "srcline.h"
 #include "symbol.h"
 #include "sort.h"
 #include "strlist.h"
 #include "target.h"
 #include "thread.h"
+#include "util.h"
 #include "vdso.h"
 #include <stdbool.h>
 #include <sys/types.h>
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 904ff4b2f57f..c522bdde3f71 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -13,6 +13,7 @@
 #include "thread.h"
 #include "evsel.h"
 #include "evlist.h"
+#include "srcline.h"
 #include "strlist.h"
 #include "strbuf.h"
 #include <traceevent/event-parse.h>
-- 
2.21.0
