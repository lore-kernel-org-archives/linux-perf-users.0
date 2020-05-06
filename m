From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 45/91] perf intel-pt: Add support for synthesizing branch stacks for regular events
Date: Wed,  6 May 2020 12:21:48 -0300
Message-ID: <20200506152234.21977-46-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Use the new thread_stack__br_sample_late() function to create a thread
stack for regular events.

Example:

 # perf record --kcore --aux-sample -e '{intel_pt//,cycles:ppp}' -c 10000 uname
 Linux
 [ perf record: Woken up 2 times to write data ]
 [ perf record: Captured and wrote 0.743 MB perf.data ]
 # perf report --itrace=Le --stdio | head -30 | tail -18

 # Samples: 11K of event 'cycles:ppp'
 # Event count (approx.): 11648
 #
 # Overhead  Command  Source Shared Object  Source Symbol                 Target Symbol                 Basic Block Cycles
 # ........  .......  ....................  ............................  ............................  ..................
 #
      5.49%  uname    libc-2.30.so          [.] _dl_addr                  [.] _dl_addr                  -
      2.41%  uname    ld-2.30.so            [.] _dl_relocate_object       [.] _dl_relocate_object       -
      2.31%  uname    ld-2.30.so            [.] do_lookup_x               [.] do_lookup_x               -
      2.17%  uname    [kernel.kallsyms]     [k] unmap_page_range          [k] unmap_page_range          -
      2.05%  uname    ld-2.30.so            [k] _dl_start                 [k] _dl_start                 -
      1.97%  uname    ld-2.30.so            [.] _dl_lookup_symbol_x       [.] _dl_lookup_symbol_x       -
      1.94%  uname    [kernel.kallsyms]     [k] filemap_map_pages         [k] filemap_map_pages         -
      1.60%  uname    [kernel.kallsyms]     [k] __handle_mm_fault         [k] __handle_mm_fault         -
      1.44%  uname    [kernel.kallsyms]     [k] page_add_file_rmap        [k] page_add_file_rmap        -
      1.12%  uname    [kernel.kallsyms]     [k] vma_interval_tree_insert  [k] vma_interval_tree_insert  -
      0.94%  uname    [kernel.kallsyms]     [k] perf_iterate_ctx          [k] perf_iterate_ctx          -

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 73 ++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 03b76904ca52..59811b39430c 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -72,6 +72,7 @@ struct intel_pt {
 	bool use_thread_stack;
 	bool callstack;
 	unsigned int br_stack_sz;
+	unsigned int br_stack_sz_plus;
 	int have_sched_switch;
 	u32 pmu_type;
 	u64 kernel_start;
@@ -130,6 +131,7 @@ struct intel_pt {
 	unsigned int range_cnt;
 
 	struct ip_callchain *chain;
+	struct branch_stack *br_stack;
 };
 
 enum switch_state {
@@ -911,6 +913,44 @@ static void intel_pt_add_callchain(struct intel_pt *pt,
 	sample->callchain = pt->chain;
 }
 
+static struct branch_stack *intel_pt_alloc_br_stack(struct intel_pt *pt)
+{
+	size_t sz = sizeof(struct branch_stack);
+
+	sz += pt->br_stack_sz * sizeof(struct branch_entry);
+	return zalloc(sz);
+}
+
+static int intel_pt_br_stack_init(struct intel_pt *pt)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(pt->session->evlist, evsel) {
+		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK))
+			evsel->synth_sample_type |= PERF_SAMPLE_BRANCH_STACK;
+	}
+
+	pt->br_stack = intel_pt_alloc_br_stack(pt);
+	if (!pt->br_stack)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void intel_pt_add_br_stack(struct intel_pt *pt,
+				  struct perf_sample *sample)
+{
+	struct thread *thread = machine__findnew_thread(pt->machine,
+							sample->pid,
+							sample->tid);
+
+	thread_stack__br_sample_late(thread, sample->cpu, pt->br_stack,
+				     pt->br_stack_sz, sample->ip,
+				     pt->kernel_start);
+
+	sample->branch_stack = pt->br_stack;
+}
+
 static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 						   unsigned int queue_nr)
 {
@@ -929,10 +969,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	}
 
 	if (pt->synth_opts.last_branch) {
-		size_t sz = sizeof(struct branch_stack);
-
-		sz += pt->br_stack_sz * sizeof(struct branch_entry);
-		ptq->last_branch = zalloc(sz);
+		ptq->last_branch = intel_pt_alloc_br_stack(pt);
 		if (!ptq->last_branch)
 			goto out_free;
 	}
@@ -1963,7 +2000,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags,
 				    state->from_ip, state->to_ip, ptq->insn_len,
 				    state->trace_nr, pt->callstack,
-				    pt->br_stack_sz,
+				    pt->br_stack_sz_plus,
 				    pt->mispred_all);
 	} else {
 		thread_stack__set_trace_nr(ptq->thread, ptq->cpu, state->trace_nr);
@@ -2609,6 +2646,8 @@ static int intel_pt_process_event(struct perf_session *session,
 	if (event->header.type == PERF_RECORD_SAMPLE) {
 		if (pt->synth_opts.add_callchain && !sample->callchain)
 			intel_pt_add_callchain(pt, sample);
+		if (pt->synth_opts.add_last_branch && !sample->branch_stack)
+			intel_pt_add_br_stack(pt, sample);
 	}
 
 	if (event->header.type == PERF_RECORD_AUX &&
@@ -3370,13 +3409,33 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 			goto err_delete_thread;
 	}
 
-	if (pt->synth_opts.last_branch)
+	if (pt->synth_opts.last_branch || pt->synth_opts.add_last_branch) {
 		pt->br_stack_sz = pt->synth_opts.last_branch_sz;
+		pt->br_stack_sz_plus = pt->br_stack_sz;
+	}
+
+	if (pt->synth_opts.add_last_branch) {
+		err = intel_pt_br_stack_init(pt);
+		if (err)
+			goto err_delete_thread;
+		/*
+		 * Additional branch stack size to cater for tracing from the
+		 * actual sample ip to where the sample time is recorded.
+		 * Measured at about 200 branches, but generously set to 1024.
+		 * If kernel space is not being traced, then add just 1 for the
+		 * branch to kernel space.
+		 */
+		if (intel_pt_tracing_kernel(pt))
+			pt->br_stack_sz_plus += 1024;
+		else
+			pt->br_stack_sz_plus += 1;
+	}
 
 	pt->use_thread_stack = pt->synth_opts.callchain ||
 			       pt->synth_opts.add_callchain ||
 			       pt->synth_opts.thread_stack ||
-			       pt->synth_opts.last_branch;
+			       pt->synth_opts.last_branch ||
+			       pt->synth_opts.add_last_branch;
 
 	pt->callstack = pt->synth_opts.callchain ||
 			pt->synth_opts.add_callchain ||
-- 
2.21.1
