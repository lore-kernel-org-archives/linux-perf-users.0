From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/60] perf intel-pt: Add support for synthesizing callchains for regular events
Date: Mon, 20 Apr 2020 08:52:52 -0300
Message-ID: <20200420115316.18781-37-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Currently, callchains can be synthesized only for synthesized events.
Support also synthesizing callchains for regular events.

Example:

 # perf record --kcore --aux-sample -e '{intel_pt//,cycles}' -c 10000 uname
 Linux
 [ perf record: Woken up 3 times to write data ]
 [ perf record: Captured and wrote 0.532 MB perf.data ]
 # perf script --itrace=Ge | head -20
 uname  4864 2419025.358181:      10000     cycles:
        ffffffffbba56965 apparmor_bprm_committing_creds+0x35 ([kernel.kallsyms])
        ffffffffbc400cd5 __indirect_thunk_start+0x5 ([kernel.kallsyms])
        ffffffffbba07422 security_bprm_committing_creds+0x22 ([kernel.kallsyms])
        ffffffffbb89805d install_exec_creds+0xd ([kernel.kallsyms])
        ffffffffbb90d9ac load_elf_binary+0x3ac ([kernel.kallsyms])

 uname  4864 2419025.358185:      10000     cycles:
        ffffffffbba56db0 apparmor_bprm_committed_creds+0x20 ([kernel.kallsyms])
        ffffffffbc400cd5 __indirect_thunk_start+0x5 ([kernel.kallsyms])
        ffffffffbba07452 security_bprm_committed_creds+0x22 ([kernel.kallsyms])
        ffffffffbb89809a install_exec_creds+0x4a ([kernel.kallsyms])
        ffffffffbb90d9ac load_elf_binary+0x3ac ([kernel.kallsyms])

 uname  4864 2419025.358189:      10000     cycles:
        ffffffffbb86fdf6 vma_adjust_trans_huge+0x6 ([kernel.kallsyms])
        ffffffffbb821660 __vma_adjust+0x160 ([kernel.kallsyms])
        ffffffffbb897be7 shift_arg_pages+0x97 ([kernel.kallsyms])
        ffffffffbb897ed9 setup_arg_pages+0x1e9 ([kernel.kallsyms])
        ffffffffbb90d9f2 load_elf_binary+0x3f2 ([kernel.kallsyms])

Committer testing:

  # perf record --kcore --aux-sample -e '{intel_pt//,cycles}' -c 10000 uname
  Linux
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.233 MB perf.data ]
  #

Then, before this patch:

  # perf script --itrace=Ge | head -20
     uname 28642 168664.856384: 10000 cycles: ffffffff9810aeaa commit_creds+0x2a ([kernel.kallsyms])
     uname 28642 168664.856388: 10000 cycles: ffffffff982a24f1 mprotect_fixup+0x151 ([kernel.kallsyms])
     uname 28642 168664.856392: 10000 cycles: ffffffff982a385b move_page_tables+0xbcb ([kernel.kallsyms])
     uname 28642 168664.856396: 10000 cycles: ffffffff982fd4ec __mod_memcg_state+0x1c ([kernel.kallsyms])
     uname 28642 168664.856400: 10000 cycles: ffffffff9829fddd do_mmap+0xfd ([kernel.kallsyms])
     uname 28642 168664.856404: 10000 cycles: ffffffff9829c879 __vma_adjust+0x479 ([kernel.kallsyms])
     uname 28642 168664.856408: 10000 cycles: ffffffff98238e94 __perf_addr_filters_adjust+0x34 ([kernel.kallsyms])
     uname 28642 168664.856412: 10000 cycles: ffffffff98a38e0b down_write+0x1b ([kernel.kallsyms])
     uname 28642 168664.856416: 10000 cycles: ffffffff983006a0 memcg_kmem_get_cache+0x0 ([kernel.kallsyms])
     uname 28642 168664.856421: 10000 cycles: ffffffff98396eaf load_elf_binary+0x92f ([kernel.kallsyms])
     uname 28642 168664.856425: 10000 cycles: ffffffff982e0222 kfree+0x62 ([kernel.kallsyms])
     uname 28642 168664.856428: 10000 cycles: ffffffff9846dfd4 file_has_perm+0x54 ([kernel.kallsyms])
     uname 28642 168664.856433: 10000 cycles: ffffffff98288911 vma_interval_tree_insert+0x51 ([kernel.kallsyms])
     uname 28642 168664.856437: 10000 cycles: ffffffff9823e577 perf_event_mmap_output+0x27 ([kernel.kallsyms])
     uname 28642 168664.856441: 10000 cycles: ffffffff98a26fa0 xas_load+0x40 ([kernel.kallsyms])
     uname 28642 168664.856445: 10000 cycles: ffffffff98004f30 arch_setup_additional_pages+0x0 ([kernel.kallsyms])
     uname 28642 168664.856448: 10000 cycles: ffffffff98a297c0 copy_user_generic_unrolled+0xa0 ([kernel.kallsyms])
     uname 28642 168664.856452: 10000 cycles: ffffffff9853a87a strnlen_user+0x10a ([kernel.kallsyms])
     uname 28642 168664.856456: 10000 cycles: ffffffff986638a7 randomize_page+0x27 ([kernel.kallsyms])
     uname 28642 168664.856460: 10000 cycles: ffffffff98a3b645 _raw_spin_lock+0x5 ([kernel.kallsyms])

  #

And after:

  # perf script --itrace=Ge | head -20
  uname 28642 168664.856384:      10000     cycles:
  	ffffffff9810aeaa commit_creds+0x2a ([kernel.kallsyms])
  	ffffffff9831fe87 install_exec_creds+0x17 ([kernel.kallsyms])
  	ffffffff983968d9 load_elf_binary+0x359 ([kernel.kallsyms])
  	ffffffff98e00c45 __x86_indirect_thunk_rax+0x5 ([kernel.kallsyms])
  	ffffffff98e00c45 __x86_indirect_thunk_rax+0x5 ([kernel.kallsyms])

  uname 28642 168664.856388:      10000     cycles:
  	ffffffff982a24f1 mprotect_fixup+0x151 ([kernel.kallsyms])
  	ffffffff9831fa83 setup_arg_pages+0x123 ([kernel.kallsyms])
  	ffffffff9839691f load_elf_binary+0x39f ([kernel.kallsyms])
  	ffffffff98e00c45 __x86_indirect_thunk_rax+0x5 ([kernel.kallsyms])
  	ffffffff98e00c45 __x86_indirect_thunk_rax+0x5 ([kernel.kallsyms])

  uname 28642 168664.856392:      10000     cycles:
  	ffffffff982a385b move_page_tables+0xbcb ([kernel.kallsyms])
  	ffffffff9831f889 shift_arg_pages+0xa9 ([kernel.kallsyms])
  	ffffffff9831fb4f setup_arg_pages+0x1ef ([kernel.kallsyms])
  	ffffffff9839691f load_elf_binary+0x39f ([kernel.kallsyms])
  	ffffffff98e00c45 __x86_indirect_thunk_rax+0x5 ([kernel.kallsyms])
  #

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-12-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 68 ++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index db25c77d82f3..a659b4a1b3f2 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -124,6 +124,8 @@ struct intel_pt {
 
 	struct range *time_ranges;
 	unsigned int range_cnt;
+
+	struct ip_callchain *chain;
 };
 
 enum switch_state {
@@ -868,6 +870,45 @@ static u64 intel_pt_ns_to_ticks(const struct intel_pt *pt, u64 ns)
 		pt->tc.time_mult;
 }
 
+static struct ip_callchain *intel_pt_alloc_chain(struct intel_pt *pt)
+{
+	size_t sz = sizeof(struct ip_callchain);
+
+	/* Add 1 to callchain_sz for callchain context */
+	sz += (pt->synth_opts.callchain_sz + 1) * sizeof(u64);
+	return zalloc(sz);
+}
+
+static int intel_pt_callchain_init(struct intel_pt *pt)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(pt->session->evlist, evsel) {
+		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+			evsel->synth_sample_type |= PERF_SAMPLE_CALLCHAIN;
+	}
+
+	pt->chain = intel_pt_alloc_chain(pt);
+	if (!pt->chain)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void intel_pt_add_callchain(struct intel_pt *pt,
+				   struct perf_sample *sample)
+{
+	struct thread *thread = machine__findnew_thread(pt->machine,
+							sample->pid,
+							sample->tid);
+
+	thread_stack__sample_late(thread, sample->cpu, pt->chain,
+				  pt->synth_opts.callchain_sz + 1, sample->ip,
+				  pt->kernel_start);
+
+	sample->callchain = pt->chain;
+}
+
 static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 						   unsigned int queue_nr)
 {
@@ -880,11 +921,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 		return NULL;
 
 	if (pt->synth_opts.callchain) {
-		size_t sz = sizeof(struct ip_callchain);
-
-		/* Add 1 to callchain_sz for callchain context */
-		sz += (pt->synth_opts.callchain_sz + 1) * sizeof(u64);
-		ptq->chain = zalloc(sz);
+		ptq->chain = intel_pt_alloc_chain(pt);
 		if (!ptq->chain)
 			goto out_free;
 	}
@@ -1992,7 +2029,8 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	if (!(state->type & INTEL_PT_BRANCH))
 		return 0;
 
-	if (pt->synth_opts.callchain || pt->synth_opts.thread_stack)
+	if (pt->synth_opts.callchain || pt->synth_opts.add_callchain ||
+	    pt->synth_opts.thread_stack)
 		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags, state->from_ip,
 				    state->to_ip, ptq->insn_len,
 				    state->trace_nr);
@@ -2639,6 +2677,11 @@ static int intel_pt_process_event(struct perf_session *session,
 	if (err)
 		return err;
 
+	if (event->header.type == PERF_RECORD_SAMPLE) {
+		if (pt->synth_opts.add_callchain && !sample->callchain)
+			intel_pt_add_callchain(pt, sample);
+	}
+
 	if (event->header.type == PERF_RECORD_AUX &&
 	    (event->aux.flags & PERF_AUX_FLAG_TRUNCATED) &&
 	    pt->synth_opts.errors) {
@@ -2710,6 +2753,7 @@ static void intel_pt_free(struct perf_session *session)
 	session->auxtrace = NULL;
 	thread__put(pt->unknown_thread);
 	addr_filters__exit(&pt->filts);
+	zfree(&pt->chain);
 	zfree(&pt->filter);
 	zfree(&pt->time_ranges);
 	free(pt);
@@ -3348,6 +3392,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		    !session->itrace_synth_opts->inject) {
 			pt->synth_opts.branches = false;
 			pt->synth_opts.callchain = true;
+			pt->synth_opts.add_callchain = true;
 		}
 		pt->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
@@ -3380,14 +3425,22 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		pt->branches_filter |= PERF_IP_FLAG_RETURN |
 				       PERF_IP_FLAG_TRACE_BEGIN;
 
-	if (pt->synth_opts.callchain && !symbol_conf.use_callchain) {
+	if ((pt->synth_opts.callchain || pt->synth_opts.add_callchain) &&
+	    !symbol_conf.use_callchain) {
 		symbol_conf.use_callchain = true;
 		if (callchain_register_param(&callchain_param) < 0) {
 			symbol_conf.use_callchain = false;
 			pt->synth_opts.callchain = false;
+			pt->synth_opts.add_callchain = false;
 		}
 	}
 
+	if (pt->synth_opts.add_callchain) {
+		err = intel_pt_callchain_init(pt);
+		if (err)
+			goto err_delete_thread;
+	}
+
 	err = intel_pt_synth_events(pt, session);
 	if (err)
 		goto err_delete_thread;
@@ -3410,6 +3463,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	return 0;
 
 err_delete_thread:
+	zfree(&pt->chain);
 	thread__zput(pt->unknown_thread);
 err_free_queues:
 	intel_pt_log_disable();
-- 
2.21.1
