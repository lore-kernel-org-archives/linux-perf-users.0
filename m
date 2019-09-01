From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/47] perf dso: Adopt DSO related macros from symbol.h
Date: Sun,  1 Sep 2019 09:23:01 -0300
Message-ID: <20190901122326.5793-23-acme@kernel.org>
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

Reducing the size of symbol.h by removing things that are better placed
somewhere else.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-edenkmjt1oe5fks2s6umd30b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c   | 1 +
 tools/perf/util/build-id.c   | 1 +
 tools/perf/util/dso.h        | 3 +++
 tools/perf/util/probe-file.c | 1 +
 tools/perf/util/symbol.c     | 1 +
 tools/perf/util/symbol.h     | 3 ---
 6 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3bd1691f0be7..67a7513077d0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -20,6 +20,7 @@
 #include "color.h"
 #include "config.h"
 #include "cache.h"
+#include "dso.h"
 #include "map.h"
 #include "symbol.h"
 #include "srcline.h"
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 4c96a33b09ff..e5fb77755d9e 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include "dso.h"
 #include "build-id.h"
 #include "event.h"
 #include "namespaces.h"
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 6e3f63781e51..ff0b81854628 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -16,6 +16,9 @@ struct machine;
 struct map;
 struct perf_env;
 
+#define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
+#define DSO__NAME_KCORE		"[kernel.kcore]"
+
 enum dso_binary_type {
 	DSO_BINARY_TYPE__KALLSYMS = 0,
 	DSO_BINARY_TYPE__GUEST_KALLSYMS,
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 5b4d49382932..10d2ab179c71 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -16,6 +16,7 @@
 #include "strlist.h"
 #include "strfilter.h"
 #include "debug.h"
+#include "dso.h"
 #include "cache.h"
 #include "color.h"
 #include "symbol.h"
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index c37cca690864..b11a69681662 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -18,6 +18,7 @@
 #include "annotate.h"
 #include "build-id.h"
 #include "cap.h"
+#include "dso.h"
 #include "util.h"
 #include "debug.h"
 #include "event.h"
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 183f630cb5f1..159c59652a5c 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -46,9 +46,6 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 #define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
 #endif
 
-#define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
-#define DSO__NAME_KCORE		"[kernel.kcore]"
-
 /** struct symbol - symtab entry
  *
  * @ignore - resolvable but tools ignore it (e.g. idle routines)
-- 
2.21.0
