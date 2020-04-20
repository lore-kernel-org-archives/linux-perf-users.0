From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 52/60] perf thread: Add a knob for LBR stitch approach
Date: Mon, 20 Apr 2020 08:53:08 -0300
Message-ID: <20200420115316.18781-53-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Gerasimov <pavel.gerasimov@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The LBR stitch approach should be disabled by default. Because

- The stitching approach base on LBR call stack technology. The known
  limitations of LBR call stack technology still apply to the approach,
  e.g. Exception handing such as setjmp/longjmp will have calls/returns
  not match.

- This approach is not foolproof. There can be cases where it creates
  incorrect call stacks from incorrect matches. There is no attempt to
  validate any matches in another way.

The 'lbr_stitch_enable' is used to indicate whether enable LBR stitch
approach, which is disabled by default. The following patch will
introduce a new option for each tools to enable the LBR stitch
approach.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-10-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.c | 1 +
 tools/perf/util/thread.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 28b719388028..1f080db23615 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -47,6 +47,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread->tid = tid;
 		thread->ppid = -1;
 		thread->cpu = -1;
+		thread->lbr_stitch_enable = false;
 		INIT_LIST_HEAD(&thread->namespaces_list);
 		INIT_LIST_HEAD(&thread->comm_list);
 		init_rwsem(&thread->namespaces_lock);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 20b96b5d1f15..95294050cff2 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -46,6 +46,9 @@ struct thread {
 	struct srccode_state	srccode_state;
 	bool			filter;
 	int			filter_entry_depth;
+
+	/* LBR call stack stitch */
+	bool			lbr_stitch_enable;
 };
 
 struct machine;
-- 
2.21.1
