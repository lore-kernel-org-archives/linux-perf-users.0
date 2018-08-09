From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/44] perf annotate: Loop group events directly in annotation__calc_percent()
Date: Thu,  9 Aug 2018 11:57:57 -0300
Message-ID: <20180809145822.21391-20-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need to bring in 'struct hists' object and for that we need 'struct
perf_evsel' object in the scope.

Switching the group data loop with the evsel group loop.  It does the
same thing, but it brings evsel object, that we can use later get the
'struct hists' object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 13 ++++++++-----
 tools/perf/util/evsel.h    |  7 +++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 728603636adc..34d4bb73aa84 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1774,13 +1774,14 @@ static void calc_percent(struct sym_hist *sym_hist,
 }
 
 static void annotation__calc_percent(struct annotation *notes,
-				     struct perf_evsel *evsel, s64 len)
+				     struct perf_evsel *leader, s64 len)
 {
 	struct annotation_line *al, *next;
+	struct perf_evsel *evsel;
 
 	list_for_each_entry(al, &notes->src->source, node) {
 		s64 end;
-		int i;
+		int i = 0;
 
 		if (al->offset == -1)
 			continue;
@@ -1788,12 +1789,14 @@ static void annotation__calc_percent(struct annotation *notes,
 		next = annotation_line__next(al, &notes->src->source);
 		end  = next ? next->offset : len;
 
-		for (i = 0; i < al->data_nr; i++) {
+		for_each_group_evsel(evsel, leader) {
 			struct annotation_data *data;
 			struct sym_hist *sym_hist;
 
-			sym_hist = annotation__histogram(notes, evsel->idx + i);
-			data = &al->data[i];
+			BUG_ON(i >= al->data_nr);
+
+			sym_hist = annotation__histogram(notes, evsel->idx);
+			data = &al->data[i++];
 
 			calc_percent(sym_hist, data, al->offset, end);
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 973c03167947..163c960614d3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -452,11 +452,18 @@ static inline int perf_evsel__group_idx(struct perf_evsel *evsel)
 	return evsel->idx - evsel->leader->idx;
 }
 
+/* Iterates group WITHOUT the leader. */
 #define for_each_group_member(_evsel, _leader) 					\
 for ((_evsel) = list_entry((_leader)->node.next, struct perf_evsel, node); 	\
      (_evsel) && (_evsel)->leader == (_leader);					\
      (_evsel) = list_entry((_evsel)->node.next, struct perf_evsel, node))
 
+/* Iterates group WITH the leader. */
+#define for_each_group_evsel(_evsel, _leader) 					\
+for ((_evsel) = _leader; 							\
+     (_evsel) && (_evsel)->leader == (_leader);					\
+     (_evsel) = list_entry((_evsel)->node.next, struct perf_evsel, node))
+
 static inline bool perf_evsel__has_branch_callstack(const struct perf_evsel *evsel)
 {
 	return evsel->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
-- 
2.14.4
