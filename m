From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/83] perf annotate: Add arch into struct annotate_args
Date: Fri, 17 Nov 2017 17:14:46 -0300
Message-ID: <20171117201601.24110-9-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934936AbdKQUQp (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:45 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Add arch into struct annotate_args to reduce the number of arguments
that need to travel all the way to line allocation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f5bd6826fa66..b4d3454618b0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -880,12 +880,12 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 
 struct annotate_args {
 	size_t			 privsize;
+	struct arch		*arch;
 };
 
 static struct disasm_line *disasm_line__new(struct annotate_args *args,
 					    s64 offset, char *line,
 					    int line_nr,
-					    struct arch *arch,
 					    struct map *map)
 {
 	struct disasm_line *dl = zalloc(sizeof(*dl) + args->privsize);
@@ -902,7 +902,7 @@ static struct disasm_line *disasm_line__new(struct annotate_args *args,
 			if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
 				goto out_free_line;
 
-			disasm_line__init_ins(dl, arch, map);
+			disasm_line__init_ins(dl, args->arch, map);
 		}
 	}
 
@@ -1222,7 +1222,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
  * The ops.raw part will be parsed further according to type of the instruction.
  */
 static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
-				      struct arch *arch, FILE *file,
+				      FILE *file,
 				      struct annotate_args *args,
 				      int *line_nr)
 {
@@ -1269,7 +1269,7 @@ static int symbol__parse_objdump_line(struct symbol *sym, struct map *map,
 			parsed_line = tmp2 + 1;
 	}
 
-	dl = disasm_line__new(args, offset, parsed_line, *line_nr, arch, map);
+	dl = disasm_line__new(args, offset, parsed_line, *line_nr, map);
 	free(line);
 	(*line_nr)++;
 
@@ -1431,8 +1431,7 @@ static const char *annotate__norm_arch(const char *arch_name)
 }
 
 static int symbol__disassemble(struct symbol *sym, struct map *map,
-			       struct annotate_args *args,
-			       struct arch *arch)
+			       struct annotate_args *args)
 {
 	struct dso *dso = map->dso;
 	char command[PATH_MAX * 2];
@@ -1532,7 +1531,7 @@ static int symbol__disassemble(struct symbol *sym, struct map *map,
 		 * can associate it with the instructions till the next one.
 		 * See disasm_line__new() and struct disasm_line::line_nr.
 		 */
-		if (symbol__parse_objdump_line(sym, map, arch, file, args,
+		if (symbol__parse_objdump_line(sym, map, file, args,
 			    &lineno) < 0)
 			break;
 		nline++;
@@ -1580,7 +1579,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 	if (!arch_name)
 		return -1;
 
-	arch = arch__find(arch_name);
+	args.arch = arch = arch__find(arch_name);
 	if (arch == NULL)
 		return -ENOTSUP;
 
@@ -1595,7 +1594,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		}
 	}
 
-	return symbol__disassemble(sym, map, &args, arch);
+	return symbol__disassemble(sym, map, &args);
 }
 
 static void insert_source_line(struct rb_root *root, struct source_line *src_line)
-- 
2.13.6
