From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/73] perf annotate: Remove hist__account_cycles() from callback
Date: Fri, 17 May 2019 16:34:59 -0300
Message-ID: <20190517193611.4974-2-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The hist__account_cycles() function is executed when the
hist_iter__branch_callback() is called.

But it looks it's not necessary.  In hist__account_cycles, it already
walks on all branch entries.

This patch moves the hist__account_cycles out of callback, now the data
processing is much faster than before.

Previous code has an issue that the ch[offset].num++ (in
__symbol__account_cycles) is executed repeatedly since
hist__account_cycles is called in each hist_iter__branch_callback, so
the counting of ch[offset].num is not correct (too big).

With this patch, the issue is fixed. And we don't need the code of
"ch->reset >= ch->num / 2" to check if there are too many overlaps (in
annotation__count_and_fill), otherwise some data would be hidden.

Now, we can try, for example:

  perf record -b ...
  perf annotate or perf report -s symbol

The before/after output should be no change.

 v3:
 ---
 Fix the crash in stdio mode.
 Like previous code, it needs the checking of ui__has_annotation()
 before hist__account_cycles()

 v2:
 ---
 1. Cover the similar perf report
 2. Remove the checking code "ch->reset >= ch->num / 2"

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1552684577-29041-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c |  4 ++--
 tools/perf/builtin-report.c   | 11 +++++------
 tools/perf/util/annotate.c    |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 67f9d9ffacfb..77deb3a40596 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -159,8 +159,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct perf_evsel *evsel = iter->evsel;
 	int err;
 
-	hist__account_cycles(sample->branch_stack, al, sample, false);
-
 	bi = he->branch_info;
 	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 
@@ -199,6 +197,8 @@ static int process_branch_callback(struct perf_evsel *evsel,
 	if (a.map != NULL)
 		a.map->dso->hit = 1;
 
+	hist__account_cycles(sample->branch_stack, al, sample, false);
+
 	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
 	return ret;
 }
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4054eb1f98ac..91e27ac297c2 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -136,9 +136,6 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
-	hist__account_cycles(sample->branch_stack, al, sample,
-			     rep->nonany_branch_mode);
-
 	if (sort__mode == SORT_MODE__BRANCH) {
 		bi = he->branch_info;
 		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
@@ -181,9 +178,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
-	hist__account_cycles(sample->branch_stack, al, sample,
-			     rep->nonany_branch_mode);
-
 	bi = he->branch_info;
 	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 	if (err)
@@ -282,6 +276,11 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.map != NULL)
 		al.map->dso->hit = 1;
 
+	if (ui__has_annotation() || rep->symbol_ipc) {
+		hist__account_cycles(sample->branch_stack, &al, sample,
+				     rep->nonany_branch_mode);
+	}
+
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
 	if (ret < 0)
 		pr_debug("problem adding hist entry, skipping event\n");
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 09762985c713..0b8573fd9b05 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1021,7 +1021,7 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 		float ipc = n_insn / ((double)ch->cycles / (double)ch->num);
 
 		/* Hide data when there are too many overlaps. */
-		if (ch->reset >= 0x7fff || ch->reset >= ch->num / 2)
+		if (ch->reset >= 0x7fff)
 			return;
 
 		for (offset = start; offset <= end; offset++) {
-- 
2.20.1
