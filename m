From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/57] perf annotate: Avoid reallocation in objdump parsing
Date: Mon, 21 Oct 2019 10:37:44 -0300
Message-ID: <20191021133834.25998-8-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Stephane Eranian <eranian@google.com>, clang-built-linux@googlegroups.com
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

Objdump output is parsed using getline which allocates memory for the
read. Getline will realloc if the memory is too small, but currently the
line is always freed after the call.

Simplify parse_objdump_line by performing the reading in symbol__disassemble.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20191010183649.23768-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2b856b6b46f6..f9c39a742418 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1489,24 +1489,17 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
  * means that it's not a disassembly line so should be treated differently.
  * The ops.raw part will be parsed further according to type of the instruction.
  */
-static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
+static int symbol__parse_objdump_line(struct symbol *sym,
 				      struct annotate_args *args,
-				      int *line_nr)
+				      char *line, int *line_nr)
 {
 	struct map *map = args->ms.map;
 	struct annotation *notes = symbol__annotation(sym);
 	struct disasm_line *dl;
-	char *line = NULL, *parsed_line, *tmp, *tmp2;
-	size_t line_len;
+	char *parsed_line, *tmp, *tmp2;
 	s64 line_ip, offset = -1;
 	regmatch_t match[2];
 
-	if (getline(&line, &line_len, file) < 0)
-		return -1;
-
-	if (!line)
-		return -1;
-
 	line_ip = -1;
 	parsed_line = strim(line);
 
@@ -1543,7 +1536,6 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 	args->ms.sym  = sym;
 
 	dl = disasm_line__new(args);
-	free(line);
 	(*line_nr)++;
 
 	if (dl == NULL)
@@ -1876,6 +1868,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	int lineno = 0;
 	int nline;
 	pid_t pid;
+	char *line;
+	size_t line_len;
 	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
 
 	if (err)
@@ -1964,18 +1958,26 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		goto out_free_command;
 	}
 
+	/* Storage for getline. */
+	line = NULL;
+	line_len = 0;
+
 	nline = 0;
 	while (!feof(file)) {
+		if (getline(&line, &line_len, file) < 0 || !line)
+			break;
+
 		/*
 		 * The source code line number (lineno) needs to be kept in
 		 * across calls to symbol__parse_objdump_line(), so that it
 		 * can associate it with the instructions till the next one.
 		 * See disasm_line__new() and struct disasm_line::line_nr.
 		 */
-		if (symbol__parse_objdump_line(sym, file, args, &lineno) < 0)
+		if (symbol__parse_objdump_line(sym, args, line, &lineno) < 0)
 			break;
 		nline++;
 	}
+	free(line);
 
 	if (nline == 0)
 		pr_err("No output from %s\n", command);
-- 
2.21.0
