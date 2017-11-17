From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/83] perf annotate: Add symbol__calc_percent function
Date: Fri, 17 Nov 2017 17:14:56 -0300
Message-ID: <20171117201601.24110-19-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161361AbdKQURS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:18 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Add symbol__calc_percent function, that calculates annotation data for
symbol and put the data in the struct annotation_line::samples array.

Committer notes:

Made symbol__calc_percent non static to be used in the next two patches,
which will get some fixups from jolsa, doing it this way to keep this
bisectable.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 62 +++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/annotate.h |  1 +
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 313fb2e90dba..ff1036096347 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1628,6 +1628,62 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	goto out_remove_tmp;
 }
 
+static void calc_percent(struct sym_hist *hist,
+			 struct annotation_data *sample,
+			 s64 offset, s64 end)
+{
+	unsigned int hits = 0;
+	u64 period = 0;
+
+	while (offset < end) {
+		hits   += hist->addr[offset].nr_samples;
+		period += hist->addr[offset].period;
+		++offset;
+	}
+
+	if (hist->nr_samples) {
+		sample->he.period     = period;
+		sample->he.nr_samples = hits;
+		sample->percent = 100.0 * hits / hist->nr_samples;
+	}
+}
+
+static int annotation__calc_percent(struct annotation *notes,
+				    struct perf_evsel *evsel, s64 len)
+{
+	struct annotation_line *al, *next;
+
+	list_for_each_entry(al, &notes->src->source, node) {
+		s64 end;
+		int i;
+
+		if (al->offset == -1)
+			continue;
+
+		next = annotation_line__next(al, &notes->src->source);
+		end  = next ? next->offset : len;
+
+		for (i = 0; i < al->samples_nr; i++) {
+			struct annotation_data *sample;
+			struct sym_hist *hist;
+
+			hist   = annotation__histogram(notes, evsel->idx + i);
+			sample = &al->samples[i];
+
+			calc_percent(hist, sample, al->offset, end);
+		}
+	}
+
+	return 0;
+}
+
+int symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel)
+{
+	struct annotation *notes = symbol__annotation(sym);
+
+	return annotation__calc_percent(notes, evsel, symbol__size(sym));
+}
+
 int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct perf_evsel *evsel, size_t privsize,
 		     struct arch **parch, char *cpuid)
@@ -1663,7 +1719,11 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		}
 	}
 
-	return symbol__disassemble(sym, &args);
+	err = symbol__disassemble(sym, &args);
+	if (err)
+		return err;
+
+	return symbol__calc_percent(sym, evsel);
 }
 
 static void insert_source_line(struct rb_root *root, struct source_line *src_line)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 55bdd9015f33..6056840da4c9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -107,6 +107,7 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 			    s64 end, const char **path, struct sym_hist_entry *sample);
+int symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
 
 struct sym_hist {
 	u64		      nr_samples;
-- 
2.13.6
