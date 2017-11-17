From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/83] perf annotate: Add offset/line/line_nr into struct annotate_args
Date: Fri, 17 Nov 2017 17:14:48 -0300
Message-ID: <20171117201601.24110-11-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935618AbdKQUQv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:51 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Add offset/line/line_nr into struct annotate_args to reduce the number
of arguments that need to travel all the way to line allocation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 30da4402a3e4..681c9c4ce9f9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -882,23 +882,24 @@ struct annotate_args {
 	size_t			 privsize;
 	struct arch		*arch;
 	struct map		*map;
+	s64			 offset;
+	char			*line;
+	int			 line_nr;
 };
 
-static struct disasm_line *disasm_line__new(struct annotate_args *args,
-					    s64 offset, char *line,
-					    int line_nr)
+static struct disasm_line *disasm_line__new(struct annotate_args *args)
 {
 	struct disasm_line *dl = zalloc(sizeof(*dl) + args->privsize);
 
 	if (dl != NULL) {
-		dl->al.offset  = offset;
-		dl->al.line    = strdup(line);
-		dl->al.line_nr = line_nr;
+		dl->al.offset  = args->offset;
+		dl->al.line    = strdup(args->line);
+		dl->al.line_nr = args->line_nr;
 
 		if (dl->al.line == NULL)
 			goto out_delete;
 
-		if (offset != -1) {
+		if (args->offset != -1) {
 			if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
 				goto out_free_line;
 
@@ -1269,7 +1270,11 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 			parsed_line = tmp2 + 1;
 	}
 
-	dl = disasm_line__new(args, offset, parsed_line, *line_nr);
+	args->offset  = offset;
+	args->line    = parsed_line;
+	args->line_nr = *line_nr;
+
+	dl = disasm_line__new(args);
 	free(line);
 	(*line_nr)++;
 
-- 
2.13.6
