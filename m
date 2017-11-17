From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/83] perf annotate: Add map into struct annotate_args
Date: Fri, 17 Nov 2017 17:14:47 -0300
Message-ID: <20171117201601.24110-10-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752640AbdKQUQs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:48 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Add map into struct annotate_args to reduce the number of arguments
that need to travel all the way to line allocation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b4d3454618b0..30da4402a3e4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -881,12 +881,12 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 struct annotate_args {
 	size_t			 privsize;
 	struct arch		*arch;
+	struct map		*map;
 };
 
 static struct disasm_line *disasm_line__new(struct annotate_args *args,
 					    s64 offset, char *line,
-					    int line_nr,
-					    struct map *map)
+					    int line_nr)
 {
 	struct disasm_line *dl = zalloc(sizeof(*dl) + args->privsize);
 
@@ -902,7 +902,7 @@ static struct disasm_line *disasm_line__new(struct annotate_args *args,
 			if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
 				goto out_free_line;
 
-			disasm_line__init_ins(dl, args->arch, map);
+			disasm_line__init_ins(dl, args->arch, args->map);
 		}
 	}
 
@@ -1221,11 +1221,11 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
  * means that it's not a disassembly line so should be treated differently.
  * The ops.raw part will be parsed further according to type of the instruction.
  */
-static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
-				      FILE *file,
+static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 				      struct annotate_args *args,
 				      int *line_nr)
 {
+	struct map *map = args->map;
 	struct annotation *notes = symbol__annotation(sym);
 	struct disasm_line *dl;
 	char *line = NULL, *parsed_line, *tmp, *tmp2;
@@ -1269,7 +1269,7 @@ static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
 			parsed_line = tmp2 + 1;
 	}
 
-	dl = disasm_line__new(args, offset, parsed_line, *line_nr, map);
+	dl = disasm_line__new(args, offset, parsed_line, *line_nr);
 	free(line);
 	(*line_nr)++;
 
@@ -1430,9 +1430,9 @@ static const char *annotate__norm_arch(const char *arch_name)
 	return normalize_arch((char *)arch_name);
 }
 
-static int symbol__disassemble(struct symbol *sym, struct map *map,
-			       struct annotate_args *args)
+static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
+	struct map *map = args->map;
 	struct dso *dso = map->dso;
 	char command[PATH_MAX * 2];
 	FILE *file;
@@ -1531,8 +1531,7 @@ static int symbol__disassemble(struct symbol *sym, struct map *map,
 		 * can associate it with the instructions till the next one.
 		 * See disasm_line__new() and struct disasm_line::line_nr.
 		 */
-		if (symbol__parse_objdump_line(sym, map, file, args,
-			    &lineno) < 0)
+		if (symbol__parse_objdump_line(sym, file, args, &lineno) < 0)
 			break;
 		nline++;
 	}
@@ -1571,6 +1570,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 {
 	struct annotate_args args = {
 		.privsize	= privsize,
+		.map		= map,
 	};
 	struct arch *arch;
 	int err;
@@ -1594,7 +1594,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		}
 	}
 
-	return symbol__disassemble(sym, map, &args);
+	return symbol__disassemble(sym, &args);
 }
 
 static void insert_source_line(struct rb_root *root, struct source_line *src_line)
-- 
2.13.6
