From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/53] perf srccode: Move struct definition from map.h to srccode.h
Date: Wed,  6 Feb 2019 15:48:13 -0300
Message-ID: <20190206184903.24054-4-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To reduce the header dependencies, since we already have a srccode.h
header, then there is where the 'struct srccode_state' should be, and
map.h, that is more widely used should have just a forward declaraion
of 'struct srccode_state'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-64lrkjjaa7wlo1zi2gr5u3es@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h     | 13 +------------
 tools/perf/util/srccode.h | 13 +++++++++++++
 tools/perf/util/thread.h  |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 09282aa45c80..5a889db4fca5 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -174,18 +174,7 @@ char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
 
-struct srccode_state {
-	char *srcfile;
-	unsigned line;
-};
-
-static inline void srccode_state_init(struct srccode_state *state)
-{
-	state->srcfile = NULL;
-	state->line = 0;
-}
-
-void srccode_state_free(struct srccode_state *state);
+struct srccode_state;
 
 int map__fprintf_srccode(struct map *map, u64 addr,
 			 FILE *fp, struct srccode_state *state);
diff --git a/tools/perf/util/srccode.h b/tools/perf/util/srccode.h
index e500a746d5f1..1b5ed769779c 100644
--- a/tools/perf/util/srccode.h
+++ b/tools/perf/util/srccode.h
@@ -1,6 +1,19 @@
 #ifndef SRCCODE_H
 #define SRCCODE_H 1
 
+struct srccode_state {
+	char	 *srcfile;
+	unsigned line;
+};
+
+static inline void srccode_state_init(struct srccode_state *state)
+{
+	state->srcfile = NULL;
+	state->line    = 0;
+}
+
+void srccode_state_free(struct srccode_state *state);
+
 /* Result is not 0 terminated */
 char *find_sourceline(char *fn, unsigned line, int *lenp);
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index f3c939150f90..856cf1a9040a 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -7,8 +7,8 @@
 #include <linux/list.h>
 #include <unistd.h>
 #include <sys/types.h>
+#include "srccode.h"
 #include "symbol.h"
-#include "map.h"
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
-- 
2.20.1
