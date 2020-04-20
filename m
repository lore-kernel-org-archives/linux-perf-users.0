From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 60/60] perf hist: Add fast path for duplicate entries check
Date: Mon, 20 Apr 2020 08:53:16 -0300
Message-ID: <20200420115316.18781-61-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Gerasimov <pavel.gerasimov@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf checks the duplicate entries in a callchain before adding an entry.
However the check is very slow especially with deeper call stack.
Almost ~50% elapsed time of perf report is spent on the check when the
call stack is always depth of 32.

The hist_entry__cmp() is used to compare the new entry with the old
entries. It will go through all the available sorts in the sort_list,
and call the specific cmp of each sort, which is very slow.

Actually, for most cases, there are no duplicate entries in callchain.
The symbols are usually different. It's much faster to do a quick check
for symbols first. Only do the full cmp when the symbols are exactly the
same.

The quick check is only to check symbols, not dso. Export
_sort__sym_cmp.

  $ perf record --call-graph lbr ./tchain_edit_64

  Without the patch
  $time perf report --stdio
  real    0m21.142s
  user    0m21.110s
  sys     0m0.033s

  With the patch
  $time perf report --stdio
  real    0m10.977s
  user    0m10.948s
  sys     0m0.027s

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-18-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 23 +++++++++++++++++++++++
 tools/perf/util/sort.c |  2 +-
 tools/perf/util/sort.h |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 283a69ff6a3d..c2550dbe7dc3 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1070,6 +1070,20 @@ iter_next_cumulative_entry(struct hist_entry_iter *iter,
 	return fill_callchain_info(al, node, iter->hide_unresolved);
 }
 
+static bool
+hist_entry__fast__sym_diff(struct hist_entry *left,
+			   struct hist_entry *right)
+{
+	struct symbol *sym_l = left->ms.sym;
+	struct symbol *sym_r = right->ms.sym;
+
+	if (!sym_l && !sym_r)
+		return left->ip != right->ip;
+
+	return !!_sort__sym_cmp(sym_l, sym_r);
+}
+
+
 static int
 iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			       struct addr_location *al)
@@ -1096,6 +1110,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	};
 	int i;
 	struct callchain_cursor cursor;
+	bool fast = hists__has(he_tmp.hists, sym);
 
 	callchain_cursor_snapshot(&cursor, &callchain_cursor);
 
@@ -1106,6 +1121,14 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	 * It's possible that it has cycles or recursive calls.
 	 */
 	for (i = 0; i < iter->curr; i++) {
+		/*
+		 * For most cases, there are no duplicate entries in callchain.
+		 * The symbols are usually different. Do a quick check for
+		 * symbols first.
+		 */
+		if (fast && hist_entry__fast__sym_diff(he_cache[i], &he_tmp))
+			continue;
+
 		if (hist_entry__cmp(he_cache[i], &he_tmp) == 0) {
 			/* to avoid calling callback function */
 			iter->he = NULL;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f14cc728c358..dc15ddc18b7d 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -237,7 +237,7 @@ static int64_t _sort__addr_cmp(u64 left_ip, u64 right_ip)
 	return (int64_t)(right_ip - left_ip);
 }
 
-static int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
+int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
 {
 	if (!sym_l || !sym_r)
 		return cmp_null(sym_l, sym_r);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index cfa6ac6f7d06..66d39c4cfe2b 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -311,5 +311,7 @@ int64_t
 sort__daddr_cmp(struct hist_entry *left, struct hist_entry *right);
 int64_t
 sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right);
+int64_t
+_sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r);
 char *hist_entry__srcline(struct hist_entry *he);
 #endif	/* __PERF_SORT_H */
-- 
2.21.1
