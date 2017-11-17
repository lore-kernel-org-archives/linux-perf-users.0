From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/83] perf annotate: Align source and offset lines
Date: Fri, 17 Nov 2017 17:15:14 -0300
Message-ID: <20171117201601.24110-37-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Align source with offset lines, which are more advanced, because of the
address column.

  Before:
         :      static void *worker_thread(void *__tdata)
         :      {
    0.00 :        48a971:       push   %rbp
    0.00 :        48a972:       mov    %rsp,%rbp
    0.00 :        48a975:       sub    $0x30,%rsp
    0.00 :        48a979:       mov    %rdi,-0x28(%rbp)
    0.00 :        48a97d:       mov    %fs:0x28,%rax
    0.00 :        48a986:       mov    %rax,-0x8(%rbp)
    0.00 :        48a98a:       xor    %eax,%eax
         :              struct thread_data *td = __tdata;
    0.00 :        48a98c:       mov    -0x28(%rbp),%rax
    0.00 :        48a990:       mov    %rax,-0x10(%rbp)
         :              int m = 0, i;
    0.00 :        48a994:       movl   $0x0,-0x1c(%rbp)
         :              int ret;
         :
         :              for (i = 0; i < loops; i++) {
    0.00 :        48a99b:       movl   $0x0,-0x18(%rbp)

  After:
         :              static void *worker_thread(void *__tdata)
         :              {
    0.00 :       48a971:       push   %rbp
    0.00 :       48a972:       mov    %rsp,%rbp
    0.00 :       48a975:       sub    $0x30,%rsp
    0.00 :       48a979:       mov    %rdi,-0x28(%rbp)
    0.00 :       48a97d:       mov    %fs:0x28,%rax
    0.00 :       48a986:       mov    %rax,-0x8(%rbp)
    0.00 :       48a98a:       xor    %eax,%eax
         :                      struct thread_data *td = __tdata;
    0.00 :       48a98c:       mov    -0x28(%rbp),%rax
    0.00 :       48a990:       mov    %rax,-0x10(%rbp)
         :                      int m = 0, i;
    0.00 :       48a994:       movl   $0x0,-0x1c(%rbp)
         :                      int ret;
         :
         :                      for (i = 0; i < loops; i++) {
    0.00 :       48a99b:       movl   $0x0,-0x18(%rbp)

It makes bigger different when displaying script sources, where the
comment lines looks oddly shifted from the lines which actually hold
code. I'll send script support separately.

Committer note:

Do not use a fixed column width for the addresses, as kernel ones se
more than 10 columns, look at the last offset and get the right width.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-36-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index cb065ca431ee..eab4a8e3c679 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1092,15 +1092,14 @@ static void annotate__branch_printf(struct block_range *br, u64 addr)
 	}
 }
 
-
-static int disasm_line__print(struct disasm_line *dl, u64 start)
+static int disasm_line__print(struct disasm_line *dl, u64 start, int addr_fmt_width)
 {
 	s64 offset = dl->al.offset;
 	const u64 addr = start + offset;
 	struct block_range *br;
 
 	br = block_range__find(addr);
-	color_fprintf(stdout, annotate__address_color(br), "  %" PRIx64 ":", addr);
+	color_fprintf(stdout, annotate__address_color(br), "  %*" PRIx64 ":", addr_fmt_width, addr);
 	color_fprintf(stdout, annotate__asm_color(br), "%s", dl->al.line);
 	annotate__branch_printf(br, addr);
 	return 0;
@@ -1109,7 +1108,7 @@ static int disasm_line__print(struct disasm_line *dl, u64 start)
 static int
 annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
 		       struct perf_evsel *evsel, u64 len, int min_pcnt, int printed,
-		       int max_lines, struct annotation_line *queue)
+		       int max_lines, struct annotation_line *queue, int addr_fmt_width)
 {
 	struct disasm_line *dl = container_of(al, struct disasm_line, al);
 	static const char *prev_line;
@@ -1139,7 +1138,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 				if (queue == al)
 					break;
 				annotation_line__print(queue, sym, start, evsel, len,
-						       0, 0, 1, NULL);
+						       0, 0, 1, NULL, addr_fmt_width);
 			}
 		}
 
@@ -1174,9 +1173,9 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 				color_fprintf(stdout, color, " %7.2f", sample->percent);
 		}
 
-		printf(" :	");
+		printf(" : ");
 
-		disasm_line__print(dl, start);
+		disasm_line__print(dl, start, addr_fmt_width);
 		printf("\n");
 	} else if (max_lines && printed >= max_lines)
 		return 1;
@@ -1192,7 +1191,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		if (!*al->line)
 			printf(" %*s:\n", width, " ");
 		else
-			printf(" %*s:	%s\n", width, " ", al->line);
+			printf(" %*s:     %*s %s\n", width, " ", addr_fmt_width, " ", al->line);
 	}
 
 	return 0;
@@ -1796,6 +1795,19 @@ static void symbol__annotate_hits(struct symbol *sym, struct perf_evsel *evsel)
 	printf("%*s: %" PRIu64 "\n", BITS_PER_LONG / 2, "h->nr_samples", h->nr_samples);
 }
 
+static int annotated_source__addr_fmt_width(struct list_head *lines, u64 start)
+{
+	char bf[32];
+	struct annotation_line *line;
+
+	list_for_each_entry_reverse(line, lines, node) {
+		if (line->offset != -1)
+			return scnprintf(bf, sizeof(bf), "%" PRIx64, start + line->offset);
+	}
+
+	return 0;
+}
+
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
 			    struct perf_evsel *evsel, bool full_paths,
 			    int min_pcnt, int max_lines, int context)
@@ -1808,7 +1820,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	struct sym_hist *h = annotation__histogram(notes, evsel->idx);
 	struct annotation_line *pos, *queue = NULL;
 	u64 start = map__rip_2objdump(map, sym->start);
-	int printed = 2, queue_len = 0;
+	int printed = 2, queue_len = 0, addr_fmt_width;
 	int more = 0;
 	u64 len;
 	int width = symbol_conf.show_total_period ? 12 : 8;
@@ -1839,6 +1851,8 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	if (verbose > 0)
 		symbol__annotate_hits(sym, evsel);
 
+	addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source, start);
+
 	list_for_each_entry(pos, &notes->src->source, node) {
 		int err;
 
@@ -1849,7 +1863,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 
 		err = annotation_line__print(pos, sym, start, evsel, len,
 					     min_pcnt, printed, max_lines,
-					     queue);
+					     queue, addr_fmt_width);
 
 		switch (err) {
 		case 0:
-- 
2.13.6
