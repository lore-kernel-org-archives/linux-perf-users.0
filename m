From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 83/86] perf report: Refactor the branch info printing code
Date: Wed, 19 Jul 2017 11:29:47 -0300
Message-ID: <20170719142950.3747-84-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The branch info such as predicted/cycles/... are printed at the
callchain entries.

For example: perf report --branch-history --no-children --stdio

    --1.07%--main div.c:39 (predicted:52.4% cycles:1 iterations:17)
              main div.c:44 (predicted:52.4% cycles:1)
              main div.c:42 (cycles:2)
              compute_flag div.c:28 (cycles:2)
              compute_flag div.c:27 (cycles:1)
              rand rand.c:28 (cycles:1)
              rand rand.c:28 (cycles:1)
              __random random.c:298 (cycles:1)
              __random random.c:297 (cycles:1)
              __random random.c:295 (cycles:1)
              __random random.c:295 (cycles:1)
              __random random.c:295 (cycles:1)

But the current code is difficult to maintain and extend. This patch
refactors the code for easy maintenance.

Change log:

v6: 1. Put the multiline condition code into {} brackets in
       counts_str_build()

    2. Keep the original display order, that is:
       predicted, abort, cycles, iterations

v5: It's a new patch in v5 patch series.

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1500379995-6449-5-git-send-email-yao.jin@linux.intel.com
[ Don't use 'index' as a name for a variable, it shadows a globa decl in older distros ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 100 ++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 59 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index b4204b43ed58..917f4d6510ae 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1214,83 +1214,65 @@ int callchain_branch_counts(struct callchain_root *root,
 						  cycles_count);
 }
 
+static int count_pri64_printf(int idx, const char *str, u64 value, char *bf, int bfsize)
+{
+	int printed;
+
+	printed = scnprintf(bf, bfsize, "%s%s:%" PRId64 "", (idx) ? " " : " (", str, value);
+
+	return printed;
+}
+
+static int count_float_printf(int idx, const char *str, float value, char *bf, int bfsize)
+{
+	int printed;
+
+	printed = scnprintf(bf, bfsize, "%s%s:%.1f%%", (idx) ? " " : " (", str, value);
+
+	return printed;
+}
+
 static int counts_str_build(char *bf, int bfsize,
 			     u64 branch_count, u64 predicted_count,
 			     u64 abort_count, u64 cycles_count,
 			     u64 iter_count, u64 samples_count)
 {
-	double predicted_percent = 0.0;
-	const char *null_str = "";
-	char iter_str[32];
-	char cycle_str[32];
-	char *istr, *cstr;
 	u64 cycles;
+	int printed = 0, i = 0;
 
 	if (branch_count == 0)
 		return scnprintf(bf, bfsize, " (calltrace)");
 
-	cycles = cycles_count / branch_count;
-
-	if (iter_count && samples_count) {
-		if (cycles > 0)
-			scnprintf(iter_str, sizeof(iter_str),
-				 " iterations:%" PRId64 "",
-				 iter_count / samples_count);
-		else
-			scnprintf(iter_str, sizeof(iter_str),
-				 "iterations:%" PRId64 "",
-				 iter_count / samples_count);
-		istr = iter_str;
-	} else
-		istr = (char *)null_str;
-
-	if (cycles > 0) {
-		scnprintf(cycle_str, sizeof(cycle_str),
-			  "cycles:%" PRId64 "", cycles);
-		cstr = cycle_str;
-	} else
-		cstr = (char *)null_str;
-
-	predicted_percent = predicted_count * 100.0 / branch_count;
+	if (predicted_count < branch_count) {
+		printed += count_float_printf(i++, "predicted",
+				predicted_count * 100.0 / branch_count,
+				bf + printed, bfsize - printed);
+	}
 
-	if ((predicted_count == branch_count) && (abort_count == 0)) {
-		if ((cycles > 0) || (istr != (char *)null_str))
-			return scnprintf(bf, bfsize, " (%s%s)", cstr, istr);
-		else
-			return scnprintf(bf, bfsize, "%s", (char *)null_str);
+	if (abort_count) {
+		printed += count_float_printf(i++, "abort",
+				abort_count * 100.0 / branch_count,
+				bf + printed, bfsize - printed);
 	}
 
-	if ((predicted_count < branch_count) && (abort_count == 0)) {
-		if ((cycles > 0) || (istr != (char *)null_str))
-			return scnprintf(bf, bfsize,
-				" (predicted:%.1f%% %s%s)",
-				predicted_percent, cstr, istr);
-		else {
-			return scnprintf(bf, bfsize,
-				" (predicted:%.1f%%)",
-				predicted_percent);
-		}
+	cycles = cycles_count / branch_count;
+	if (cycles) {
+		printed += count_pri64_printf(i++, "cycles",
+				cycles,
+				bf + printed, bfsize - printed);
 	}
 
-	if ((predicted_count == branch_count) && (abort_count > 0)) {
-		if ((cycles > 0) || (istr != (char *)null_str))
-			return scnprintf(bf, bfsize,
-				" (abort:%" PRId64 " %s%s)",
-				abort_count, cstr, istr);
-		else
-			return scnprintf(bf, bfsize,
-				" (abort:%" PRId64 ")",
-				abort_count);
+	if (iter_count && samples_count) {
+		printed += count_pri64_printf(i++, "iterations",
+				iter_count / samples_count,
+				bf + printed, bfsize - printed);
 	}
 
-	if ((cycles > 0) || (istr != (char *)null_str))
-		return scnprintf(bf, bfsize,
-			" (predicted:%.1f%% abort:%" PRId64 " %s%s)",
-			predicted_percent, abort_count, cstr, istr);
+	if (i)
+		return scnprintf(bf + printed, bfsize - printed, ")");
 
-	return scnprintf(bf, bfsize,
-			" (predicted:%.1f%% abort:%" PRId64 ")",
-			predicted_percent, abort_count);
+	bf[0] = 0;
+	return 0;
 }
 
 static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
-- 
2.9.4
