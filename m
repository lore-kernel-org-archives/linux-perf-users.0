From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/53] perf symbols: Introduce map_symbol.h
Date: Wed,  6 Feb 2019 15:48:15 -0300
Message-ID: <20190206184903.24054-6-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To allow headers just wanting this definition to be able to get it
without all the things in symbol.h, to reduce the include dep tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-l32z2qyhs6fe8unf4gk2ead2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.h  |  2 +-
 tools/perf/util/hist.h       |  1 +
 tools/perf/util/map_symbol.h | 22 ++++++++++++++++++++++
 tools/perf/util/sort.h       |  3 ++-
 tools/perf/util/symbol.h     | 14 +-------------
 5 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100644 tools/perf/util/map_symbol.h

diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index b6f18c2d4b14..80e056a3d882 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -5,7 +5,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include "event.h"
-#include "symbol.h"
+#include "map_symbol.h"
 #include "branch.h"
 
 struct map;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 08267af7439c..f50aad24928e 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -8,6 +8,7 @@
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
+#include "symbol.h"
 #include "ui/progress.h"
 
 struct hist_entry;
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
new file mode 100644
index 000000000000..5a1aed9f6bb4
--- /dev/null
+++ b/tools/perf/util/map_symbol.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __PERF_MAP_SYMBOL
+#define __PERF_MAP_SYMBOL 1
+
+#include <linux/types.h>
+
+struct map;
+struct symbol;
+
+struct map_symbol {
+	struct map    *map;
+	struct symbol *sym;
+};
+
+struct addr_map_symbol {
+	struct map    *map;
+	struct symbol *sym;
+	u64	      addr;
+	u64	      al_addr;
+	u64	      phys_addr;
+};
+#endif // __PERF_MAP_SYMBOL
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index dd6312876492..2fbee0b1011c 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -9,7 +9,8 @@
 #include <linux/list.h>
 #include "cache.h"
 #include <linux/rbtree.h>
-#include "symbol.h"
+#include "map_symbol.h"
+#include "symbol_conf.h"
 #include "string.h"
 #include "callchain.h"
 #include "values.h"
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 56e2bcb907cc..9a8fe012910a 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdio.h>
+#include "map_symbol.h"
 #include "branch.h"
 #include "path.h"
 #include "symbol_conf.h"
@@ -115,19 +116,6 @@ struct ref_reloc_sym {
 	u64		unrelocated_addr;
 };
 
-struct map_symbol {
-	struct map    *map;
-	struct symbol *sym;
-};
-
-struct addr_map_symbol {
-	struct map    *map;
-	struct symbol *sym;
-	u64	      addr;
-	u64	      al_addr;
-	u64	      phys_addr;
-};
-
 struct branch_info {
 	struct addr_map_symbol from;
 	struct addr_map_symbol to;
-- 
2.20.1
