From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/24] perf tools: Introduce binary__fprintf()
Date: Mon, 23 Oct 2017 20:47:31 -0300
Message-ID: <20171023234736.5335-20-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, yuzhoujian <yuzhoujian@didichuxing.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Out of print_binary() but receiving a fp pointer and expecting that the
printer be a fprintf like function, i.e. receive a FILE pointer and
return the number of characters printed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: yuzhoujian <yuzhoujian@didichuxing.com>
Link: http://lkml.kernel.org/n/tip-6oqnxr6lmgqe6q6p3iugnscx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c    | 32 +++++++++++++++++---------------
 tools/perf/builtin-trace.c     | 14 +++++++-------
 tools/perf/util/debug.c        | 31 +++++++++++++++++--------------
 tools/perf/util/print_binary.c | 30 ++++++++++++++++--------------
 tools/perf/util/print_binary.h | 18 +++++++++++++-----
 5 files changed, 70 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7167df215a42..5a7dfc5691a1 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1164,40 +1164,40 @@ struct printer_data {
 	bool is_printable;
 };
 
-static void
-print_sample_bpf_output_printer(enum binary_printer_ops op,
-				unsigned int val,
-				void *extra)
+static int sample__fprintf_bpf_output(enum binary_printer_ops op,
+				      unsigned int val,
+				      void *extra, FILE *fp)
 {
 	unsigned char ch = (unsigned char)val;
 	struct printer_data *printer_data = extra;
+	int printed = 0;
 
 	switch (op) {
 	case BINARY_PRINT_DATA_BEGIN:
-		printf("\n");
+		printed += fprintf(fp, "\n");
 		break;
 	case BINARY_PRINT_LINE_BEGIN:
-		printf("%17s", !printer_data->line_no ? "BPF output:" :
+		printed += fprintf(fp, "%17s", !printer_data->line_no ? "BPF output:" :
 						        "           ");
 		break;
 	case BINARY_PRINT_ADDR:
-		printf(" %04x:", val);
+		printed += fprintf(fp, " %04x:", val);
 		break;
 	case BINARY_PRINT_NUM_DATA:
-		printf(" %02x", val);
+		printed += fprintf(fp, " %02x", val);
 		break;
 	case BINARY_PRINT_NUM_PAD:
-		printf("   ");
+		printed += fprintf(fp, "   ");
 		break;
 	case BINARY_PRINT_SEP:
-		printf("  ");
+		printed += fprintf(fp, "  ");
 		break;
 	case BINARY_PRINT_CHAR_DATA:
 		if (printer_data->hit_nul && ch)
 			printer_data->is_printable = false;
 
 		if (!isprint(ch)) {
-			printf("%c", '.');
+			printed += fprintf(fp, "%c", '.');
 
 			if (!printer_data->is_printable)
 				break;
@@ -1207,20 +1207,22 @@ print_sample_bpf_output_printer(enum binary_printer_ops op,
 			else
 				printer_data->is_printable = false;
 		} else {
-			printf("%c", ch);
+			printed += fprintf(fp, "%c", ch);
 		}
 		break;
 	case BINARY_PRINT_CHAR_PAD:
-		printf(" ");
+		printed += fprintf(fp, " ");
 		break;
 	case BINARY_PRINT_LINE_END:
-		printf("\n");
+		printed += fprintf(fp, "\n");
 		printer_data->line_no++;
 		break;
 	case BINARY_PRINT_DATA_END:
 	default:
 		break;
 	}
+
+	return printed;
 }
 
 static void print_sample_bpf_output(struct perf_sample *sample)
@@ -1229,7 +1231,7 @@ static void print_sample_bpf_output(struct perf_sample *sample)
 	struct printer_data printer_data = {0, false, true};
 
 	print_binary(sample->raw_data, nr_bytes, 8,
-		     print_sample_bpf_output_printer, &printer_data);
+		     sample__fprintf_bpf_output, &printer_data);
 
 	if (printer_data.is_printable && printer_data.hit_nul)
 		printf("%17s \"%s\"\n", "BPF string:",
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index afef6fe46c45..8b23982dd9f2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1828,16 +1828,14 @@ static int trace__sched_stat_runtime(struct trace *trace, struct perf_evsel *evs
 	goto out_put;
 }
 
-static void bpf_output__printer(enum binary_printer_ops op,
-				unsigned int val, void *extra)
+static int bpf_output__printer(enum binary_printer_ops op,
+			       unsigned int val, void *extra __maybe_unused, FILE *fp)
 {
-	FILE *output = extra;
 	unsigned char ch = (unsigned char)val;
 
 	switch (op) {
 	case BINARY_PRINT_CHAR_DATA:
-		fprintf(output, "%c", isprint(ch) ? ch : '.');
-		break;
+		return fprintf(fp, "%c", isprint(ch) ? ch : '.');
 	case BINARY_PRINT_DATA_BEGIN:
 	case BINARY_PRINT_LINE_BEGIN:
 	case BINARY_PRINT_ADDR:
@@ -1850,13 +1848,15 @@ static void bpf_output__printer(enum binary_printer_ops op,
 	default:
 		break;
 	}
+
+	return 0;
 }
 
 static void bpf_output__fprintf(struct trace *trace,
 				struct perf_sample *sample)
 {
-	print_binary(sample->raw_data, sample->raw_size, 8,
-		     bpf_output__printer, trace->output);
+	binary__fprintf(sample->raw_data, sample->raw_size, 8,
+			bpf_output__printer, NULL, trace->output);
 }
 
 static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index a5b3777ffee6..cd24ebf0da2f 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -111,50 +111,53 @@ int dump_printf(const char *fmt, ...)
 	return ret;
 }
 
-static void trace_event_printer(enum binary_printer_ops op,
-				unsigned int val, void *extra)
+static int trace_event_printer(enum binary_printer_ops op,
+			       unsigned int val, void *extra, FILE *fp)
 {
 	const char *color = PERF_COLOR_BLUE;
 	union perf_event *event = (union perf_event *)extra;
 	unsigned char ch = (unsigned char)val;
+	int printed = 0;
 
 	switch (op) {
 	case BINARY_PRINT_DATA_BEGIN:
-		printf(".");
-		color_fprintf(stdout, color, "\n. ... raw event: size %d bytes\n",
-				event->header.size);
+		printed += fprintf(fp, ".");
+		printed += color_fprintf(fp, color, "\n. ... raw event: size %d bytes\n",
+					 event->header.size);
 		break;
 	case BINARY_PRINT_LINE_BEGIN:
-		printf(".");
+		printed += fprintf(fp, ".");
 		break;
 	case BINARY_PRINT_ADDR:
-		color_fprintf(stdout, color, "  %04x: ", val);
+		printed += color_fprintf(fp, color, "  %04x: ", val);
 		break;
 	case BINARY_PRINT_NUM_DATA:
-		color_fprintf(stdout, color, " %02x", val);
+		printed += color_fprintf(fp, color, " %02x", val);
 		break;
 	case BINARY_PRINT_NUM_PAD:
-		color_fprintf(stdout, color, "   ");
+		printed += color_fprintf(fp, color, "   ");
 		break;
 	case BINARY_PRINT_SEP:
-		color_fprintf(stdout, color, "  ");
+		printed += color_fprintf(fp, color, "  ");
 		break;
 	case BINARY_PRINT_CHAR_DATA:
-		color_fprintf(stdout, color, "%c",
+		printed += color_fprintf(fp, color, "%c",
 			      isprint(ch) ? ch : '.');
 		break;
 	case BINARY_PRINT_CHAR_PAD:
-		color_fprintf(stdout, color, " ");
+		printed += color_fprintf(fp, color, " ");
 		break;
 	case BINARY_PRINT_LINE_END:
-		color_fprintf(stdout, color, "\n");
+		printed += color_fprintf(fp, color, "\n");
 		break;
 	case BINARY_PRINT_DATA_END:
-		printf("\n");
+		printed += fprintf(fp, "\n");
 		break;
 	default:
 		break;
 	}
+
+	return printed;
 }
 
 void trace_event(union perf_event *event)
diff --git a/tools/perf/util/print_binary.c b/tools/perf/util/print_binary.c
index e908177b9976..df55ad3b47a0 100644
--- a/tools/perf/util/print_binary.c
+++ b/tools/perf/util/print_binary.c
@@ -2,40 +2,42 @@
 #include <linux/log2.h>
 #include "sane_ctype.h"
 
-void print_binary(unsigned char *data, size_t len,
-		  size_t bytes_per_line, print_binary_t printer,
-		  void *extra)
+int binary__fprintf(unsigned char *data, size_t len,
+		    size_t bytes_per_line, binary__fprintf_t printer,
+		    void *extra, FILE *fp)
 {
 	size_t i, j, mask;
+	int printed = 0;
 
 	if (!printer)
-		return;
+		return 0;
 
 	bytes_per_line = roundup_pow_of_two(bytes_per_line);
 	mask = bytes_per_line - 1;
 
-	printer(BINARY_PRINT_DATA_BEGIN, 0, extra);
+	printed += printer(BINARY_PRINT_DATA_BEGIN, 0, extra, fp);
 	for (i = 0; i < len; i++) {
 		if ((i & mask) == 0) {
-			printer(BINARY_PRINT_LINE_BEGIN, -1, extra);
-			printer(BINARY_PRINT_ADDR, i, extra);
+			printed += printer(BINARY_PRINT_LINE_BEGIN, -1, extra, fp);
+			printed += printer(BINARY_PRINT_ADDR, i, extra, fp);
 		}
 
-		printer(BINARY_PRINT_NUM_DATA, data[i], extra);
+		printed += printer(BINARY_PRINT_NUM_DATA, data[i], extra, fp);
 
 		if (((i & mask) == mask) || i == len - 1) {
 			for (j = 0; j < mask-(i & mask); j++)
-				printer(BINARY_PRINT_NUM_PAD, -1, extra);
+				printed += printer(BINARY_PRINT_NUM_PAD, -1, extra, fp);
 
-			printer(BINARY_PRINT_SEP, i, extra);
+			printer(BINARY_PRINT_SEP, i, extra, fp);
 			for (j = i & ~mask; j <= i; j++)
-				printer(BINARY_PRINT_CHAR_DATA, data[j], extra);
+				printed += printer(BINARY_PRINT_CHAR_DATA, data[j], extra, fp);
 			for (j = 0; j < mask-(i & mask); j++)
-				printer(BINARY_PRINT_CHAR_PAD, i, extra);
-			printer(BINARY_PRINT_LINE_END, -1, extra);
+				printed += printer(BINARY_PRINT_CHAR_PAD, i, extra, fp);
+			printed += printer(BINARY_PRINT_LINE_END, -1, extra, fp);
 		}
 	}
-	printer(BINARY_PRINT_DATA_END, -1, extra);
+	printed += printer(BINARY_PRINT_DATA_END, -1, extra, fp);
+	return printed;
 }
 
 int is_printable_array(char *p, unsigned int len)
diff --git a/tools/perf/util/print_binary.h b/tools/perf/util/print_binary.h
index da0427263d2d..f97918a179db 100644
--- a/tools/perf/util/print_binary.h
+++ b/tools/perf/util/print_binary.h
@@ -2,6 +2,7 @@
 #define PERF_PRINT_BINARY_H
 
 #include <stddef.h>
+#include <stdio.h>
 
 enum binary_printer_ops {
 	BINARY_PRINT_DATA_BEGIN,
@@ -16,12 +17,19 @@ enum binary_printer_ops {
 	BINARY_PRINT_DATA_END,
 };
 
-typedef void (*print_binary_t)(enum binary_printer_ops op,
-			       unsigned int val, void *extra);
+typedef int (*binary__fprintf_t)(enum binary_printer_ops op,
+				 unsigned int val, void *extra, FILE *fp);
 
-void print_binary(unsigned char *data, size_t len,
-		  size_t bytes_per_line, print_binary_t printer,
-		  void *extra);
+int binary__fprintf(unsigned char *data, size_t len,
+		    size_t bytes_per_line, binary__fprintf_t printer,
+		    void *extra, FILE *fp);
+
+static inline void print_binary(unsigned char *data, size_t len,
+				size_t bytes_per_line, binary__fprintf_t printer,
+				void *extra)
+{
+	binary__fprintf(data, len, bytes_per_line, printer, extra, stdout);
+}
 
 int is_printable_array(char *p, unsigned int len);
 
-- 
2.13.6
