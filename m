From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/83] perf annotate: Add annotation_line__(new|delete) functions
Date: Fri, 17 Nov 2017 17:14:53 -0300
Message-ID: <20171117201601.24110-16-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Changing the way the annotation lines are allocated and adding
annotation_line__(new|delete) functions to deal with this.

Before the allocation schema was as follows:

  -----------------------------------------------------------
  struct disasm_line | struct annotation_line | private space
  -----------------------------------------------------------

Where the private space is used in TUI code to store computed
annotation data for events. The stdio code computes the data
on the fly.

The goal is to compute and store annotation line's data directly
in the struct annotation_line itself, so this patch changes the
line allocation schema as follows:

  ------------------------------------------------------------
  privsize space | struct disasm_line | struct annotation_line
  ------------------------------------------------------------

Moving struct annotation_line to the end, because in following
changes we will move here the non-fixed length event's data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  4 ++-
 tools/perf/util/annotate.c        | 63 ++++++++++++++++++++++++++++++++++-----
 tools/perf/util/annotate.h        | 10 ++++++-
 3 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index cfde5a2ca3f4..7ca5ae625cc9 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -76,7 +76,9 @@ struct annotate_browser {
 
 static inline struct browser_disasm_line *disasm_line__browser(struct disasm_line *dl)
 {
-	return (struct browser_disasm_line *)(dl + 1);
+	struct annotation_line *al = &dl->al;
+
+	return (void *) al - al->privsize;
 }
 
 static bool disasm_line__filter(struct ui_browser *browser __maybe_unused,
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 11c7743203a0..7c74700ae6d7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -888,14 +888,64 @@ struct annotate_args {
 	int			 line_nr;
 };
 
+static void annotation_line__delete(struct annotation_line *al)
+{
+	void *ptr = (void *) al - al->privsize;
+
+	zfree(&al->line);
+	free(ptr);
+}
+
+/*
+ * Allocating the annotation line data with following
+ * structure:
+ *
+ *    --------------------------------------
+ *    private space | struct annotation_line
+ *    --------------------------------------
+ *
+ * Size of the private space is stored in 'struct annotation_line'.
+ *
+ */
+static struct annotation_line *
+annotation_line__new(struct annotate_args *args, size_t privsize)
+{
+	struct annotation_line *al;
+	size_t size = privsize + sizeof(*al);
+
+	al = zalloc(size);
+	if (al) {
+		al = (void *) al + privsize;
+		al->privsize   = privsize;
+		al->offset     = args->offset;
+		al->line       = strdup(args->line);
+		al->line_nr    = args->line_nr;
+	}
+
+	return al;
+}
+
+/*
+ * Allocating the disasm annotation line data with
+ * following structure:
+ *
+ *    ------------------------------------------------------------
+ *    privsize space | struct disasm_line | struct annotation_line
+ *    ------------------------------------------------------------
+ *
+ * We have 'struct annotation_line' member as last member
+ * of 'struct disasm_line' to have an easy access.
+ *
+ */
 static struct disasm_line *disasm_line__new(struct annotate_args *args)
 {
-	struct disasm_line *dl = zalloc(sizeof(*dl) + args->privsize);
+	struct disasm_line *dl = NULL;
+	struct annotation_line *al;
+	size_t privsize = args->privsize + offsetof(struct disasm_line, al);
 
-	if (dl != NULL) {
-		dl->al.offset  = args->offset;
-		dl->al.line    = strdup(args->line);
-		dl->al.line_nr = args->line_nr;
+	al = annotation_line__new(args, privsize);
+	if (al != NULL) {
+		dl = disasm_line(al);
 
 		if (dl->al.line == NULL)
 			goto out_delete;
@@ -919,14 +969,13 @@ static struct disasm_line *disasm_line__new(struct annotate_args *args)
 
 void disasm_line__free(struct disasm_line *dl)
 {
-	zfree(&dl->al.line);
 	if (dl->ins.ops && dl->ins.ops->free)
 		dl->ins.ops->free(&dl->ops);
 	else
 		ins__delete(&dl->ops);
 	free((void *)dl->ins.name);
 	dl->ins.name = NULL;
-	free(dl);
+	annotation_line__delete(&dl->al);
 }
 
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 6f01e6117936..2e7a08afb04f 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -67,14 +67,22 @@ struct annotation_line {
 	int			 line_nr;
 	float			 ipc;
 	u64			 cycles;
+	size_t			 privsize;
 };
 
 struct disasm_line {
-	struct annotation_line	 al;
 	struct ins		 ins;
 	struct ins_operands	 ops;
+
+	/* This needs to be at the end. */
+	struct annotation_line	 al;
 };
 
+static inline struct disasm_line *disasm_line(struct annotation_line *al)
+{
+	return al ? container_of(al, struct disasm_line, al) : NULL;
+}
+
 static inline bool disasm_line__has_offset(const struct disasm_line *dl)
 {
 	return dl->ops.target.offset_avail;
-- 
2.13.6
