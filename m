From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/13] perf tools: Add 'struct perf_mmap' arg to record__write()
Date: Wed, 19 Sep 2018 11:25:34 -0300
Message-ID: <20180919142537.29985-11-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The struct perf_mmap map argument will hold the file pointer to write
the data to.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180913125450.21342-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 24 ++++++++++++++----------
 tools/perf/util/auxtrace.c  |  2 +-
 tools/perf/util/auxtrace.h  |  1 +
 tools/perf/util/mmap.c      |  6 +++---
 tools/perf/util/mmap.h      |  2 +-
 5 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fd8b12c5f4ae..0980dfe3396b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -106,9 +106,12 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
-static int record__write(struct record *rec, void *bf, size_t size)
+static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
+			 void *bf, size_t size)
 {
-	if (perf_data__write(rec->session->data, bf, size) < 0) {
+	struct perf_data_file *file = &rec->session->data->file;
+
+	if (perf_data_file__write(file, bf, size) < 0) {
 		pr_err("failed to write perf data, error: %m\n");
 		return -1;
 	}
@@ -127,15 +130,15 @@ static int process_synthesized_event(struct perf_tool *tool,
 				     struct machine *machine __maybe_unused)
 {
 	struct record *rec = container_of(tool, struct record, tool);
-	return record__write(rec, event, event->header.size);
+	return record__write(rec, NULL, event, event->header.size);
 }
 
-static int record__pushfn(void *to, void *bf, size_t size)
+static int record__pushfn(struct perf_mmap *map, void *to, void *bf, size_t size)
 {
 	struct record *rec = to;
 
 	rec->samples++;
-	return record__write(rec, bf, size);
+	return record__write(rec, map, bf, size);
 }
 
 static volatile int done;
@@ -170,6 +173,7 @@ static void record__sig_exit(void)
 #ifdef HAVE_AUXTRACE_SUPPORT
 
 static int record__process_auxtrace(struct perf_tool *tool,
+				    struct perf_mmap *map,
 				    union perf_event *event, void *data1,
 				    size_t len1, void *data2, size_t len2)
 {
@@ -197,11 +201,11 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	if (padding)
 		padding = 8 - padding;
 
-	record__write(rec, event, event->header.size);
-	record__write(rec, data1, len1);
+	record__write(rec, map, event, event->header.size);
+	record__write(rec, map, data1, len1);
 	if (len2)
-		record__write(rec, data2, len2);
-	record__write(rec, &pad, padding);
+		record__write(rec, map, data2, len2);
+	record__write(rec, map, &pad, padding);
 
 	return 0;
 }
@@ -549,7 +553,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	 * at least one event.
 	 */
 	if (bytes_written != rec->bytes_written)
-		rc = record__write(rec, &finished_round_event, sizeof(finished_round_event));
+		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
 
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 2fecee57f555..c4617bcfd521 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1285,7 +1285,7 @@ static int __auxtrace_mmap__read(struct perf_mmap *map,
 	ev.auxtrace.tid = mm->tid;
 	ev.auxtrace.cpu = mm->cpu;
 
-	if (fn(tool, &ev, data1, len1, data2, len2))
+	if (fn(tool, map, &ev, data1, len1, data2, len2))
 		return -1;
 
 	mm->prev = head;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 7eeb141361b9..a86b7eab6673 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -435,6 +435,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 				   bool per_cpu);
 
 typedef int (*process_auxtrace_t)(struct perf_tool *tool,
+				  struct perf_mmap *map,
 				  union perf_event *event, void *data1,
 				  size_t len1, void *data2, size_t len2);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 215f69f41672..cdb95b3a1213 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -281,7 +281,7 @@ int perf_mmap__read_init(struct perf_mmap *map)
 }
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size))
+		    int push(struct perf_mmap *map, void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
 	unsigned char *data = md->base + page_size;
@@ -300,7 +300,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 		size = md->mask + 1 - (md->start & md->mask);
 		md->start += size;
 
-		if (push(to, buf, size) < 0) {
+		if (push(md, to, buf, size) < 0) {
 			rc = -1;
 			goto out;
 		}
@@ -310,7 +310,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 	size = md->end - md->start;
 	md->start += size;
 
-	if (push(to, buf, size) < 0) {
+	if (push(md, to, buf, size) < 0) {
 		rc = -1;
 		goto out;
 	}
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 05a6d47c7956..e603314dc792 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -93,7 +93,7 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size));
+		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
-- 
2.14.4
