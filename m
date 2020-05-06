From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/91] perf intel-pt: Change branch stack support to use thread-stacks
Date: Wed,  6 May 2020 12:21:44 -0300
Message-ID: <20200506152234.21977-42-acme@kernel.org>
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

Change Intel PT's branch stack support to use thread stacks. The
advantages of using branch stack support from the thread-stack are:

1. the branches are accumulated separately for each thread
2. the branch stack is cleared only in between continuous traces

This helps pave the way for adding branch stacks to regular events, not
just synthesized events as at present.

While the 2 approaches are not identical, in simple cases the results
can be identical e.g.

  Before:

    # perf record --kcore -e intel_pt// uname
    # perf script --itrace=i10usl -F+brstacksym,+addr,+flags > cmp1.txt

  After:

    # perf script --itrace=i10usl -F+brstacksym,+addr,+flags > cmp2.txt
    # diff -s cmp1.txt cmp2.txt
    Files cmp1.txt and cmp2.txt are identical

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 141 ++++++++++---------------------------
 1 file changed, 39 insertions(+), 102 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index b3c45276b664..03b76904ca52 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -70,6 +70,8 @@ struct intel_pt {
 	bool sync_switch;
 	bool mispred_all;
 	bool use_thread_stack;
+	bool callstack;
+	unsigned int br_stack_sz;
 	int have_sched_switch;
 	u32 pmu_type;
 	u64 kernel_start;
@@ -147,8 +149,6 @@ struct intel_pt_queue {
 	const struct intel_pt_state *state;
 	struct ip_callchain *chain;
 	struct branch_stack *last_branch;
-	struct branch_stack *last_branch_rb;
-	size_t last_branch_pos;
 	union perf_event *event_buf;
 	bool on_heap;
 	bool stop;
@@ -931,14 +931,10 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	if (pt->synth_opts.last_branch) {
 		size_t sz = sizeof(struct branch_stack);
 
-		sz += pt->synth_opts.last_branch_sz *
-		      sizeof(struct branch_entry);
+		sz += pt->br_stack_sz * sizeof(struct branch_entry);
 		ptq->last_branch = zalloc(sz);
 		if (!ptq->last_branch)
 			goto out_free;
-		ptq->last_branch_rb = zalloc(sz);
-		if (!ptq->last_branch_rb)
-			goto out_free;
 	}
 
 	ptq->event_buf = malloc(PERF_SAMPLE_MAX_SIZE);
@@ -1007,7 +1003,6 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 out_free:
 	zfree(&ptq->event_buf);
 	zfree(&ptq->last_branch);
-	zfree(&ptq->last_branch_rb);
 	zfree(&ptq->chain);
 	free(ptq);
 	return NULL;
@@ -1023,7 +1018,6 @@ static void intel_pt_free_queue(void *priv)
 	intel_pt_decoder_free(ptq->decoder);
 	zfree(&ptq->event_buf);
 	zfree(&ptq->last_branch);
-	zfree(&ptq->last_branch_rb);
 	zfree(&ptq->chain);
 	free(ptq);
 }
@@ -1191,58 +1185,6 @@ static int intel_pt_setup_queues(struct intel_pt *pt)
 	return 0;
 }
 
-static inline void intel_pt_copy_last_branch_rb(struct intel_pt_queue *ptq)
-{
-	struct branch_stack *bs_src = ptq->last_branch_rb;
-	struct branch_stack *bs_dst = ptq->last_branch;
-	size_t nr = 0;
-
-	bs_dst->nr = bs_src->nr;
-
-	if (!bs_src->nr)
-		return;
-
-	nr = ptq->pt->synth_opts.last_branch_sz - ptq->last_branch_pos;
-	memcpy(&bs_dst->entries[0],
-	       &bs_src->entries[ptq->last_branch_pos],
-	       sizeof(struct branch_entry) * nr);
-
-	if (bs_src->nr >= ptq->pt->synth_opts.last_branch_sz) {
-		memcpy(&bs_dst->entries[nr],
-		       &bs_src->entries[0],
-		       sizeof(struct branch_entry) * ptq->last_branch_pos);
-	}
-}
-
-static inline void intel_pt_reset_last_branch_rb(struct intel_pt_queue *ptq)
-{
-	ptq->last_branch_pos = 0;
-	ptq->last_branch_rb->nr = 0;
-}
-
-static void intel_pt_update_last_branch_rb(struct intel_pt_queue *ptq)
-{
-	const struct intel_pt_state *state = ptq->state;
-	struct branch_stack *bs = ptq->last_branch_rb;
-	struct branch_entry *be;
-
-	if (!ptq->last_branch_pos)
-		ptq->last_branch_pos = ptq->pt->synth_opts.last_branch_sz;
-
-	ptq->last_branch_pos -= 1;
-
-	be              = &bs->entries[ptq->last_branch_pos];
-	be->from        = state->from_ip;
-	be->to          = state->to_ip;
-	be->flags.abort = !!(state->flags & INTEL_PT_ABORT_TX);
-	be->flags.in_tx = !!(state->flags & INTEL_PT_IN_TX);
-	/* No support for mispredict */
-	be->flags.mispred = ptq->pt->mispred_all;
-
-	if (bs->nr < ptq->pt->synth_opts.last_branch_sz)
-		bs->nr += 1;
-}
-
 static inline bool intel_pt_skip_event(struct intel_pt *pt)
 {
 	return pt->synth_opts.initial_skip &&
@@ -1310,9 +1252,9 @@ static inline int intel_pt_opt_inject(struct intel_pt *pt,
 	return intel_pt_inject_event(event, sample, type);
 }
 
-static int intel_pt_deliver_synth_b_event(struct intel_pt *pt,
-					  union perf_event *event,
-					  struct perf_sample *sample, u64 type)
+static int intel_pt_deliver_synth_event(struct intel_pt *pt,
+					union perf_event *event,
+					struct perf_sample *sample, u64 type)
 {
 	int ret;
 
@@ -1372,8 +1314,8 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 		ptq->last_br_cyc_cnt = ptq->ipc_cyc_cnt;
 	}
 
-	return intel_pt_deliver_synth_b_event(pt, event, &sample,
-					      pt->branches_sample_type);
+	return intel_pt_deliver_synth_event(pt, event, &sample,
+					    pt->branches_sample_type);
 }
 
 static void intel_pt_prep_sample(struct intel_pt *pt,
@@ -1391,27 +1333,12 @@ static void intel_pt_prep_sample(struct intel_pt *pt,
 	}
 
 	if (pt->synth_opts.last_branch) {
-		intel_pt_copy_last_branch_rb(ptq);
+		thread_stack__br_sample(ptq->thread, ptq->cpu, ptq->last_branch,
+					pt->br_stack_sz);
 		sample->branch_stack = ptq->last_branch;
 	}
 }
 
-static inline int intel_pt_deliver_synth_event(struct intel_pt *pt,
-					       struct intel_pt_queue *ptq,
-					       union perf_event *event,
-					       struct perf_sample *sample,
-					       u64 type)
-{
-	int ret;
-
-	ret = intel_pt_deliver_synth_b_event(pt, event, sample, type);
-
-	if (pt->synth_opts.last_branch)
-		intel_pt_reset_last_branch_rb(ptq);
-
-	return ret;
-}
-
 static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
@@ -1436,7 +1363,7 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 
 	ptq->last_insn_cnt = ptq->state->tot_insn_cnt;
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->instructions_sample_type);
 }
 
@@ -1454,7 +1381,7 @@ static int intel_pt_synth_transaction_sample(struct intel_pt_queue *ptq)
 	sample.id = ptq->pt->transactions_id;
 	sample.stream_id = ptq->pt->transactions_id;
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->transactions_sample_type);
 }
 
@@ -1495,7 +1422,7 @@ static int intel_pt_synth_ptwrite_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->ptwrites_sample_type);
 }
 
@@ -1525,7 +1452,7 @@ static int intel_pt_synth_cbr_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->pwr_events_sample_type);
 }
 
@@ -1550,7 +1477,7 @@ static int intel_pt_synth_mwait_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->pwr_events_sample_type);
 }
 
@@ -1575,7 +1502,7 @@ static int intel_pt_synth_pwre_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->pwr_events_sample_type);
 }
 
@@ -1600,7 +1527,7 @@ static int intel_pt_synth_exstop_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->pwr_events_sample_type);
 }
 
@@ -1625,7 +1552,7 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->pwr_events_sample_type);
 }
 
@@ -1845,7 +1772,9 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 			intel_pt_add_lbrs(&br.br_stack, items);
 			sample.branch_stack = &br.br_stack;
 		} else if (pt->synth_opts.last_branch) {
-			intel_pt_copy_last_branch_rb(ptq);
+			thread_stack__br_sample(ptq->thread, ptq->cpu,
+						ptq->last_branch,
+						pt->br_stack_sz);
 			sample.branch_stack = ptq->last_branch;
 		} else {
 			br.br_stack.nr = 0;
@@ -1880,7 +1809,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 		sample.transaction = txn;
 	}
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
+	return intel_pt_deliver_synth_event(pt, event, &sample, sample_type);
 }
 
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
@@ -2030,12 +1959,15 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	if (!(state->type & INTEL_PT_BRANCH))
 		return 0;
 
-	if (pt->use_thread_stack)
-		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags, state->from_ip,
-				    state->to_ip, ptq->insn_len,
-				    state->trace_nr, true, 0, 0);
-	else
+	if (pt->use_thread_stack) {
+		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags,
+				    state->from_ip, state->to_ip, ptq->insn_len,
+				    state->trace_nr, pt->callstack,
+				    pt->br_stack_sz,
+				    pt->mispred_all);
+	} else {
 		thread_stack__set_trace_nr(ptq->thread, ptq->cpu, state->trace_nr);
+	}
 
 	if (pt->sample_branches) {
 		err = intel_pt_synth_branch_sample(ptq);
@@ -2043,9 +1975,6 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 			return err;
 	}
 
-	if (pt->synth_opts.last_branch)
-		intel_pt_update_last_branch_rb(ptq);
-
 	if (!ptq->sync_switch)
 		return 0;
 
@@ -3441,9 +3370,17 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 			goto err_delete_thread;
 	}
 
+	if (pt->synth_opts.last_branch)
+		pt->br_stack_sz = pt->synth_opts.last_branch_sz;
+
 	pt->use_thread_stack = pt->synth_opts.callchain ||
 			       pt->synth_opts.add_callchain ||
-			       pt->synth_opts.thread_stack;
+			       pt->synth_opts.thread_stack ||
+			       pt->synth_opts.last_branch;
+
+	pt->callstack = pt->synth_opts.callchain ||
+			pt->synth_opts.add_callchain ||
+			pt->synth_opts.thread_stack;
 
 	err = intel_pt_synth_events(pt, session);
 	if (err)
-- 
2.21.1
