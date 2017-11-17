From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/83] perf annotate: Add struct annotate_args
Date: Fri, 17 Nov 2017 17:14:45 -0300
Message-ID: <20171117201601.24110-8-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934443AbdKQUQm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:42 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Adding struct annotate_args to reduce the number of arguments, that need
to travel all the way to line allocation. This makes the code easier to
read and ease up the changes for following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f0093918882d..f5bd6826fa66 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -878,12 +878,17 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 	return -1;
 }
 
-static struct disasm_line *disasm_line__new(s64 offset, char *line,
-					    size_t privsize, int line_nr,
+struct annotate_args {
+	size_t			 privsize;
+};
+
+static struct disasm_line *disasm_line__new(struct annotate_args *args,
+					    s64 offset, char *line,
+					    int line_nr,
 					    struct arch *arch,
 					    struct map *map)
 {
-	struct disasm_line *dl = zalloc(sizeof(*dl) + privsize);
+	struct disasm_line *dl = zalloc(sizeof(*dl) + args->privsize);
 
 	if (dl != NULL) {
 		dl->al.offset  = offset;
@@ -1217,8 +1222,8 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
  * The ops.raw part will be parsed further according to type of the instruction.
  */
 static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
-				      struct arch *arch,
-				      FILE *file, size_t privsize,
+				      struct arch *arch, FILE *file,
+				      struct annotate_args *args,
 				      int *line_nr)
 {
 	struct annotation *notes = symbol__annotation(sym);
@@ -1264,7 +1269,7 @@ static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
 			parsed_line = tmp2 + 1;
 	}
 
-	dl = disasm_line__new(offset, parsed_line, privsize, *line_nr, arch, map);
+	dl = disasm_line__new(args, offset, parsed_line, *line_nr, arch, map);
 	free(line);
 	(*line_nr)++;
 
@@ -1426,7 +1431,8 @@ static const char *annotate__norm_arch(const char *arch_name)
 }
 
 static int symbol__disassemble(struct symbol *sym, struct map *map,
-			       size_t privsize, struct arch *arch)
+			       struct annotate_args *args,
+			       struct arch *arch)
 {
 	struct dso *dso = map->dso;
 	char command[PATH_MAX * 2];
@@ -1526,7 +1532,7 @@ static int symbol__disassemble(struct symbol *sym, struct map *map,
 		 * can associate it with the instructions till the next one.
 		 * See disasm_line__new() and struct disasm_line::line_nr.
 		 */
-		if (symbol__parse_objdump_line(sym, map, arch, file, privsize,
+		if (symbol__parse_objdump_line(sym, map, arch, file, args,
 			    &lineno) < 0)
 			break;
 		nline++;
@@ -1564,6 +1570,9 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		     const char *arch_name, size_t privsize,
 		     struct arch **parch, char *cpuid)
 {
+	struct annotate_args args = {
+		.privsize	= privsize,
+	};
 	struct arch *arch;
 	int err;
 
@@ -1586,7 +1595,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		}
 	}
 
-	return symbol__disassemble(sym, map, privsize, arch);
+	return symbol__disassemble(sym, map, &args, arch);
 }
 
 static void insert_source_line(struct rb_root *root, struct source_line *src_line)
-- 
2.13.6
