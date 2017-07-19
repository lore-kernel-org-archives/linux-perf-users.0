From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 85/86] perf report: Show branch type statistics for stdio mode
Date: Wed, 19 Jul 2017 11:29:49 -0300
Message-ID: <20170719142950.3747-86-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Show the branch type statistics at the end of perf report --stdio.

For example:

  perf report --stdio

  COND_FWD:  28.5%
  COND_BWD:   9.4%
  CROSS_4K:   0.7%
  CROSS_2M:  14.1%
      COND:  37.9%
    UNCOND:   0.2%
       IND:   6.7%
      CALL:  26.5%
       RET:  28.7%
    SYSRET:   0.0%

  The branch types are:

   COND_FWD: conditional forward
   COND_BWD: conditional backward
       COND: conditional branch
     UNCOND: unconditional branch
        IND: indirect
       CALL: function call
     IND_CALL: indirect function call
        RET: function return
    SYSCALL: syscall
     SYSRET: syscall return
  COND_CALL: conditional function call
   COND_RET: conditional function return

CROSS_4K and CROSS_2M:

They are the metrics checking for branches cross 4K or 2MB pages.
It's an approximate computing. We don't know if the area is 4K or
2MB, so always compute both.

To make the output simple, if a branch crosses 2M area, CROSS_4K
will not be incremented.

Change log

v7: Since the common branch type definitions are changed, some
    tags/strings are updated accordingly.

v6: Remove branch_type_stat_display() since it's moved to branch.c.

v5: Remove the unnecessary sort__mode checking in
    hist_iter__branch_callback().

v4: Comparing to previous version, the major changes are:

Add the computing of JCC forward/JCC backward and cross page checking
by using the from and to addresses.

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1500379995-6449-7-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 25 +++++++++++++++++++++++++
 tools/perf/util/hist.c      |  5 +----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 8e752ba5e887..cea25d03f4dd 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -38,6 +38,7 @@
 #include "util/time-utils.h"
 #include "util/auxtrace.h"
 #include "util/units.h"
+#include "util/branch.h"
 
 #include <dlfcn.h>
 #include <errno.h>
@@ -73,6 +74,7 @@ struct report {
 	u64			queue_size;
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+	struct branch_type_stat	brtype_stat;
 };
 
 static int report__config(const char *var, const char *value, void *cb)
@@ -150,6 +152,22 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	return err;
 }
 
+static int hist_iter__branch_callback(struct hist_entry_iter *iter,
+				      struct addr_location *al __maybe_unused,
+				      bool single __maybe_unused,
+				      void *arg)
+{
+	struct hist_entry *he = iter->he;
+	struct report *rep = arg;
+	struct branch_info *bi;
+
+	bi = he->branch_info;
+	branch_type_count(&rep->brtype_stat, &bi->flags,
+			  bi->from.addr, bi->to.addr);
+
+	return 0;
+}
+
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -188,6 +206,8 @@ static int process_sample_event(struct perf_tool *tool,
 		 */
 		if (!sample->branch_stack)
 			goto out_put;
+
+		iter.add_entry_cb = hist_iter__branch_callback;
 		iter.ops = &hist_iter_branch;
 	} else if (rep->mem_mode) {
 		iter.ops = &hist_iter_mem;
@@ -410,6 +430,9 @@ static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
 		perf_read_values_destroy(&rep->show_threads_values);
 	}
 
+	if (sort__mode == SORT_MODE__BRANCH)
+		branch_type_stat_display(stdout, &rep->brtype_stat);
+
 	return 0;
 }
 
@@ -944,6 +967,8 @@ int cmd_report(int argc, const char **argv)
 	if (has_br_stack && branch_call_mode)
 		symbol_conf.show_branchflag_count = true;
 
+	memset(&report.brtype_stat, 0, sizeof(struct branch_type_stat));
+
 	/*
 	 * Branch mode is a tristate:
 	 * -1 means default, so decide based on the file having branch data.
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index cf0186a088c1..2f6c5e6c16f9 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -749,12 +749,9 @@ iter_prepare_branch_entry(struct hist_entry_iter *iter, struct addr_location *al
 }
 
 static int
-iter_add_single_branch_entry(struct hist_entry_iter *iter,
+iter_add_single_branch_entry(struct hist_entry_iter *iter __maybe_unused,
 			     struct addr_location *al __maybe_unused)
 {
-	/* to avoid calling callback function */
-	iter->he = NULL;
-
 	return 0;
 }
 
-- 
2.9.4
