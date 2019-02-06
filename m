From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/53] perf callchain: Uninline callchain_cursor_reset() to remove map.h dependency
Date: Wed,  6 Feb 2019 15:48:14 -0300
Message-ID: <20190206184903.24054-5-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That was the only thing that made including map.h in callchain.h a
requiriment, so uninline it and just add a 'struct map' forward
declaration.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7fjz4hvv1bpzqaeriku44fn4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/gtk/annotate.c |  1 +
 tools/perf/ui/stdio/hist.c   |  1 +
 tools/perf/util/callchain.c  | 15 +++++++++++++++
 tools/perf/util/callchain.h  | 18 +++---------------
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index f22a7d142ada..f42666ee0672 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -4,6 +4,7 @@
 #include "util/debug.h"
 #include "util/annotate.h"
 #include "util/evsel.h"
+#include "util/map.h"
 #include "ui/helpline.h"
 #include <inttypes.h>
 #include <signal.h>
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 2a9fa4dcbc2a..814abf5e9a5c 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -4,6 +4,7 @@
 
 #include "../../util/util.h"
 #include "../../util/hist.h"
+#include "../../util/map.h"
 #include "../../util/sort.h"
 #include "../../util/evsel.h"
 #include "../../util/srcline.h"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index dc2212e12184..2974950039ac 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1577,3 +1577,18 @@ int callchain_cursor__copy(struct callchain_cursor *dst,
 
 	return rc;
 }
+
+/*
+ * Initialize a cursor before adding entries inside, but keep
+ * the previously allocated entries as a cache.
+ */
+void callchain_cursor_reset(struct callchain_cursor *cursor)
+{
+	struct callchain_cursor_node *node;
+
+	cursor->nr = 0;
+	cursor->last = &cursor->first;
+
+	for (node = cursor->first; node != NULL; node = node->next)
+		map__zput(node->map);
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 8afe1622edf3..b6f18c2d4b14 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -5,10 +5,11 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include "event.h"
-#include "map.h"
 #include "symbol.h"
 #include "branch.h"
 
+struct map;
+
 #define HELP_PAD "\t\t\t\t"
 
 #define CALLCHAIN_HELP "setup and enables call-graph (stack chain/backtrace):\n\n"
@@ -187,20 +188,7 @@ int callchain_append(struct callchain_root *root,
 int callchain_merge(struct callchain_cursor *cursor,
 		    struct callchain_root *dst, struct callchain_root *src);
 
-/*
- * Initialize a cursor before adding entries inside, but keep
- * the previously allocated entries as a cache.
- */
-static inline void callchain_cursor_reset(struct callchain_cursor *cursor)
-{
-	struct callchain_cursor_node *node;
-
-	cursor->nr = 0;
-	cursor->last = &cursor->first;
-
-	for (node = cursor->first; node != NULL; node = node->next)
-		map__zput(node->map);
-}
+void callchain_cursor_reset(struct callchain_cursor *cursor);
 
 int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
 			    struct map *map, struct symbol *sym,
-- 
2.20.1
