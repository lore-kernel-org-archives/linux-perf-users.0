From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/83] perf annotate: Add samples into struct annotation_line
Date: Fri, 17 Nov 2017 17:14:55 -0300
Message-ID: <20171117201601.24110-18-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add samples array into struct annotation_line to hold the annotation
data. The data is populated in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c |  8 ++++++++
 tools/perf/util/annotate.h | 17 ++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0c2eb95ba90a..313fb2e90dba 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -911,7 +911,14 @@ static struct annotation_line *
 annotation_line__new(struct annotate_args *args, size_t privsize)
 {
 	struct annotation_line *al;
+	struct perf_evsel *evsel = args->evsel;
 	size_t size = privsize + sizeof(*al);
+	int nr = 1;
+
+	if (perf_evsel__is_group_event(evsel))
+		nr = evsel->nr_members;
+
+	size += sizeof(al->samples[0]) * nr;
 
 	al = zalloc(size);
 	if (al) {
@@ -920,6 +927,7 @@ annotation_line__new(struct annotate_args *args, size_t privsize)
 		al->offset     = args->offset;
 		al->line       = strdup(args->line);
 		al->line_nr    = args->line_nr;
+		al->samples_nr = nr;
 	}
 
 	return al;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index cb60cafae1fb..55bdd9015f33 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -59,6 +59,16 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 
 struct annotation;
 
+struct sym_hist_entry {
+	u64		nr_samples;
+	u64		period;
+};
+
+struct annotation_data {
+	double			 percent;
+	struct sym_hist_entry	 he;
+};
+
 struct annotation_line {
 	struct list_head	 node;
 	struct rb_node		 rb_node;
@@ -68,6 +78,8 @@ struct annotation_line {
 	float			 ipc;
 	u64			 cycles;
 	size_t			 privsize;
+	int			 samples_nr;
+	struct annotation_data	 samples[0];
 };
 
 struct disasm_line {
@@ -88,11 +100,6 @@ static inline bool disasm_line__has_offset(const struct disasm_line *dl)
 	return dl->ops.target.offset_avail;
 }
 
-struct sym_hist_entry {
-	u64		nr_samples;
-	u64		period;
-};
-
 void disasm_line__free(struct disasm_line *dl);
 struct annotation_line *
 annotation_line__next(struct annotation_line *pos, struct list_head *head);
-- 
2.13.6
