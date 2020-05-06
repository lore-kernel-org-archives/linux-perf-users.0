From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 62/91] perf evsel: Rename perf_evsel__{str,int}val() and other tracepoint field metehods to to evsel__*()
Date: Wed,  6 May 2020 12:22:05 -0300
Message-ID: <20200506152234.21977-63-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As those are not 'struct evsel' methods, not part of tools/lib/perf/,
aka libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c     |  2 +-
 tools/perf/arch/s390/util/kvm-stat.c        |  8 +--
 tools/perf/arch/x86/util/kvm-stat.c         | 12 ++---
 tools/perf/builtin-inject.c                 |  2 +-
 tools/perf/builtin-kmem.c                   | 30 +++++------
 tools/perf/builtin-kvm.c                    |  5 +-
 tools/perf/builtin-lock.c                   | 20 ++++----
 tools/perf/builtin-sched.c                  | 57 ++++++++++-----------
 tools/perf/builtin-timechart.c              | 52 +++++++++----------
 tools/perf/builtin-trace.c                  | 20 ++++----
 tools/perf/tests/evsel-tp-sched.c           |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  2 +-
 tools/perf/tests/switch-tracking.c          |  4 +-
 tools/perf/util/evsel.c                     | 12 ++---
 tools/perf/util/evsel.h                     | 16 +++---
 tools/perf/util/intel-pt.c                  |  2 +-
 16 files changed, 119 insertions(+), 127 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 16807269317c..eed9e5a42935 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -39,7 +39,7 @@ static void hcall_event_get_key(struct evsel *evsel,
 				struct event_key *key)
 {
 	key->info = 0;
-	key->key = perf_evsel__intval(evsel, sample, "req");
+	key->key = evsel__intval(evsel, sample, "req");
 }
 
 static const char *get_hcall_exit_reason(u64 exit_code)
diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index 0fd4e9f49ed0..34da89ced29a 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -30,7 +30,7 @@ static void event_icpt_insn_get_key(struct evsel *evsel,
 {
 	unsigned long insn;
 
-	insn = perf_evsel__intval(evsel, sample, "instruction");
+	insn = evsel__intval(evsel, sample, "instruction");
 	key->key = icpt_insn_decoder(insn);
 	key->exit_reasons = sie_icpt_insn_codes;
 }
@@ -39,7 +39,7 @@ static void event_sigp_get_key(struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct event_key *key)
 {
-	key->key = perf_evsel__intval(evsel, sample, "order_code");
+	key->key = evsel__intval(evsel, sample, "order_code");
 	key->exit_reasons = sie_sigp_order_codes;
 }
 
@@ -47,7 +47,7 @@ static void event_diag_get_key(struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct event_key *key)
 {
-	key->key = perf_evsel__intval(evsel, sample, "code");
+	key->key = evsel__intval(evsel, sample, "code");
 	key->exit_reasons = sie_diagnose_codes;
 }
 
@@ -55,7 +55,7 @@ static void event_icpt_prog_get_key(struct evsel *evsel,
 				    struct perf_sample *sample,
 				    struct event_key *key)
 {
-	key->key = perf_evsel__intval(evsel, sample, "code");
+	key->key = evsel__intval(evsel, sample, "code");
 	key->exit_reasons = sie_icpt_prog_codes;
 }
 
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index c0775c39227f..072920475b65 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -31,8 +31,8 @@ const char *kvm_exit_trace = "kvm:kvm_exit";
 static void mmio_event_get_key(struct evsel *evsel, struct perf_sample *sample,
 			       struct event_key *key)
 {
-	key->key  = perf_evsel__intval(evsel, sample, "gpa");
-	key->info = perf_evsel__intval(evsel, sample, "type");
+	key->key  = evsel__intval(evsel, sample, "gpa");
+	key->info = evsel__intval(evsel, sample, "type");
 }
 
 #define KVM_TRACE_MMIO_READ_UNSATISFIED 0
@@ -48,7 +48,7 @@ static bool mmio_event_begin(struct evsel *evsel,
 
 	/* MMIO write begin event in kernel. */
 	if (!strcmp(evsel->name, "kvm:kvm_mmio") &&
-	    perf_evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_WRITE) {
+	    evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_WRITE) {
 		mmio_event_get_key(evsel, sample, key);
 		return true;
 	}
@@ -65,7 +65,7 @@ static bool mmio_event_end(struct evsel *evsel, struct perf_sample *sample,
 
 	/* MMIO read end event in kernel.*/
 	if (!strcmp(evsel->name, "kvm:kvm_mmio") &&
-	    perf_evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_READ) {
+	    evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_READ) {
 		mmio_event_get_key(evsel, sample, key);
 		return true;
 	}
@@ -94,8 +94,8 @@ static void ioport_event_get_key(struct evsel *evsel,
 				 struct perf_sample *sample,
 				 struct event_key *key)
 {
-	key->key  = perf_evsel__intval(evsel, sample, "port");
-	key->info = perf_evsel__intval(evsel, sample, "rw");
+	key->key  = evsel__intval(evsel, sample, "port");
+	key->info = evsel__intval(evsel, sample, "rw");
 }
 
 static bool ioport_event_begin(struct evsel *evsel,
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 952df5146d57..842e940523b7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -536,7 +536,7 @@ static int perf_inject__sched_stat(struct perf_tool *tool,
 	union perf_event *event_sw;
 	struct perf_sample sample_sw;
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
-	u32 pid = perf_evsel__intval(evsel, sample, "pid");
+	u32 pid = evsel__intval(evsel, sample, "pid");
 
 	list_for_each_entry(ent, &inject->samples, node) {
 		if (pid == ent->tid)
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index f91a050bda11..0a296fbf9194 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -172,10 +172,10 @@ static int insert_caller_stat(unsigned long call_site,
 static int perf_evsel__process_alloc_event(struct evsel *evsel,
 					   struct perf_sample *sample)
 {
-	unsigned long ptr = perf_evsel__intval(evsel, sample, "ptr"),
-		      call_site = perf_evsel__intval(evsel, sample, "call_site");
-	int bytes_req = perf_evsel__intval(evsel, sample, "bytes_req"),
-	    bytes_alloc = perf_evsel__intval(evsel, sample, "bytes_alloc");
+	unsigned long ptr = evsel__intval(evsel, sample, "ptr"),
+		      call_site = evsel__intval(evsel, sample, "call_site");
+	int bytes_req = evsel__intval(evsel, sample, "bytes_req"),
+	    bytes_alloc = evsel__intval(evsel, sample, "bytes_alloc");
 
 	if (insert_alloc_stat(call_site, ptr, bytes_req, bytes_alloc, sample->cpu) ||
 	    insert_caller_stat(call_site, bytes_req, bytes_alloc))
@@ -195,7 +195,7 @@ static int perf_evsel__process_alloc_node_event(struct evsel *evsel,
 
 	if (!ret) {
 		int node1 = cpu__get_node(sample->cpu),
-		    node2 = perf_evsel__intval(evsel, sample, "node");
+		    node2 = evsel__intval(evsel, sample, "node");
 
 		if (node1 != node2)
 			nr_cross_allocs++;
@@ -235,7 +235,7 @@ static struct alloc_stat *search_alloc_stat(unsigned long ptr,
 static int perf_evsel__process_free_event(struct evsel *evsel,
 					  struct perf_sample *sample)
 {
-	unsigned long ptr = perf_evsel__intval(evsel, sample, "ptr");
+	unsigned long ptr = evsel__intval(evsel, sample, "ptr");
 	struct alloc_stat *s_alloc, *s_caller;
 
 	s_alloc = search_alloc_stat(ptr, 0, &root_alloc_stat, ptr_cmp);
@@ -788,9 +788,9 @@ static int perf_evsel__process_page_alloc_event(struct evsel *evsel,
 						struct perf_sample *sample)
 {
 	u64 page;
-	unsigned int order = perf_evsel__intval(evsel, sample, "order");
-	unsigned int gfp_flags = perf_evsel__intval(evsel, sample, "gfp_flags");
-	unsigned int migrate_type = perf_evsel__intval(evsel, sample,
+	unsigned int order = evsel__intval(evsel, sample, "order");
+	unsigned int gfp_flags = evsel__intval(evsel, sample, "gfp_flags");
+	unsigned int migrate_type = evsel__intval(evsel, sample,
 						       "migratetype");
 	u64 bytes = kmem_page_size << order;
 	u64 callsite;
@@ -802,9 +802,9 @@ static int perf_evsel__process_page_alloc_event(struct evsel *evsel,
 	};
 
 	if (use_pfn)
-		page = perf_evsel__intval(evsel, sample, "pfn");
+		page = evsel__intval(evsel, sample, "pfn");
 	else
-		page = perf_evsel__intval(evsel, sample, "page");
+		page = evsel__intval(evsel, sample, "page");
 
 	nr_page_allocs++;
 	total_page_alloc_bytes += bytes;
@@ -861,7 +861,7 @@ static int perf_evsel__process_page_free_event(struct evsel *evsel,
 						struct perf_sample *sample)
 {
 	u64 page;
-	unsigned int order = perf_evsel__intval(evsel, sample, "order");
+	unsigned int order = evsel__intval(evsel, sample, "order");
 	u64 bytes = kmem_page_size << order;
 	struct page_stat *pstat;
 	struct page_stat this = {
@@ -869,9 +869,9 @@ static int perf_evsel__process_page_free_event(struct evsel *evsel,
 	};
 
 	if (use_pfn)
-		page = perf_evsel__intval(evsel, sample, "pfn");
+		page = evsel__intval(evsel, sample, "pfn");
 	else
-		page = perf_evsel__intval(evsel, sample, "page");
+		page = evsel__intval(evsel, sample, "page");
 
 	nr_page_frees++;
 	total_page_free_bytes += bytes;
@@ -1392,7 +1392,7 @@ static int __cmd_kmem(struct perf_session *session)
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		if (!strcmp(evsel__name(evsel), "kmem:mm_page_alloc") &&
-		    perf_evsel__field(evsel, "pfn")) {
+		    evsel__field(evsel, "pfn")) {
 			use_pfn = true;
 			break;
 		}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index ff74a9a0bbaa..95a77058023e 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -69,7 +69,7 @@ void exit_event_get_key(struct evsel *evsel,
 			struct event_key *key)
 {
 	key->info = 0;
-	key->key = perf_evsel__intval(evsel, sample, kvm_exit_reason);
+	key->key  = evsel__intval(evsel, sample, kvm_exit_reason);
 }
 
 bool kvm_exit_event(struct evsel *evsel)
@@ -416,8 +416,7 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
 			return NULL;
 		}
 
-		vcpu_record->vcpu_id = perf_evsel__intval(evsel, sample,
-							  vcpu_id_str);
+		vcpu_record->vcpu_id = evsel__intval(evsel, sample, vcpu_id_str);
 		thread__set_priv(thread, vcpu_record);
 	}
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 543d82fec556..5a19dc2f1636 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -48,7 +48,7 @@ struct lock_stat {
 	struct rb_node		rb;		/* used for sorting */
 
 	/*
-	 * FIXME: perf_evsel__intval() returns u64,
+	 * FIXME: evsel__intval() returns u64,
 	 * so address of lockdep_map should be dealed as 64bit.
 	 * Is there more better solution?
 	 */
@@ -404,9 +404,9 @@ static int report_lock_acquire_event(struct evsel *evsel,
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
-	const char *name = perf_evsel__strval(evsel, sample, "name");
-	u64 tmp = perf_evsel__intval(evsel, sample, "lockdep_addr");
-	int flag = perf_evsel__intval(evsel, sample, "flag");
+	const char *name = evsel__strval(evsel, sample, "name");
+	u64 tmp	 = evsel__intval(evsel, sample, "lockdep_addr");
+	int flag = evsel__intval(evsel, sample, "flag");
 
 	memcpy(&addr, &tmp, sizeof(void *));
 
@@ -477,8 +477,8 @@ static int report_lock_acquired_event(struct evsel *evsel,
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
 	u64 contended_term;
-	const char *name = perf_evsel__strval(evsel, sample, "name");
-	u64 tmp = perf_evsel__intval(evsel, sample, "lockdep_addr");
+	const char *name = evsel__strval(evsel, sample, "name");
+	u64 tmp = evsel__intval(evsel, sample, "lockdep_addr");
 
 	memcpy(&addr, &tmp, sizeof(void *));
 
@@ -539,8 +539,8 @@ static int report_lock_contended_event(struct evsel *evsel,
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
-	const char *name = perf_evsel__strval(evsel, sample, "name");
-	u64 tmp = perf_evsel__intval(evsel, sample, "lockdep_addr");
+	const char *name = evsel__strval(evsel, sample, "name");
+	u64 tmp = evsel__intval(evsel, sample, "lockdep_addr");
 
 	memcpy(&addr, &tmp, sizeof(void *));
 
@@ -594,8 +594,8 @@ static int report_lock_release_event(struct evsel *evsel,
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
-	const char *name = perf_evsel__strval(evsel, sample, "name");
-	u64 tmp = perf_evsel__intval(evsel, sample, "lockdep_addr");
+	const char *name = evsel__strval(evsel, sample, "name");
+	u64 tmp = evsel__intval(evsel, sample, "lockdep_addr");
 
 	memcpy(&addr, &tmp, sizeof(void *));
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5c005260bf13..b99398031131 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -811,8 +811,8 @@ replay_wakeup_event(struct perf_sched *sched,
 		    struct evsel *evsel, struct perf_sample *sample,
 		    struct machine *machine __maybe_unused)
 {
-	const char *comm = perf_evsel__strval(evsel, sample, "comm");
-	const u32 pid	 = perf_evsel__intval(evsel, sample, "pid");
+	const char *comm = evsel__strval(evsel, sample, "comm");
+	const u32 pid	 = evsel__intval(evsel, sample, "pid");
 	struct task_desc *waker, *wakee;
 
 	if (verbose > 0) {
@@ -833,11 +833,11 @@ static int replay_switch_event(struct perf_sched *sched,
 			       struct perf_sample *sample,
 			       struct machine *machine __maybe_unused)
 {
-	const char *prev_comm  = perf_evsel__strval(evsel, sample, "prev_comm"),
-		   *next_comm  = perf_evsel__strval(evsel, sample, "next_comm");
-	const u32 prev_pid = perf_evsel__intval(evsel, sample, "prev_pid"),
-		  next_pid = perf_evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = perf_evsel__intval(evsel, sample, "prev_state");
+	const char *prev_comm  = evsel__strval(evsel, sample, "prev_comm"),
+		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
+	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
+		  next_pid = evsel__intval(evsel, sample, "next_pid");
+	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
 	struct task_desc *prev, __maybe_unused *next;
 	u64 timestamp0, timestamp = sample->time;
 	int cpu = sample->cpu;
@@ -1106,9 +1106,9 @@ static int latency_switch_event(struct perf_sched *sched,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	const u32 prev_pid = perf_evsel__intval(evsel, sample, "prev_pid"),
-		  next_pid = perf_evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = perf_evsel__intval(evsel, sample, "prev_state");
+	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
+		  next_pid = evsel__intval(evsel, sample, "next_pid");
+	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
 	struct work_atoms *out_events, *in_events;
 	struct thread *sched_out, *sched_in;
 	u64 timestamp0, timestamp = sample->time;
@@ -1176,8 +1176,8 @@ static int latency_runtime_event(struct perf_sched *sched,
 				 struct perf_sample *sample,
 				 struct machine *machine)
 {
-	const u32 pid	   = perf_evsel__intval(evsel, sample, "pid");
-	const u64 runtime  = perf_evsel__intval(evsel, sample, "runtime");
+	const u32 pid	   = evsel__intval(evsel, sample, "pid");
+	const u64 runtime  = evsel__intval(evsel, sample, "runtime");
 	struct thread *thread = machine__findnew_thread(machine, -1, pid);
 	struct work_atoms *atoms = thread_atoms_search(&sched->atom_root, thread, &sched->cmp_pid);
 	u64 timestamp = sample->time;
@@ -1211,7 +1211,7 @@ static int latency_wakeup_event(struct perf_sched *sched,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	const u32 pid	  = perf_evsel__intval(evsel, sample, "pid");
+	const u32 pid	  = evsel__intval(evsel, sample, "pid");
 	struct work_atoms *atoms;
 	struct work_atom *atom;
 	struct thread *wakee;
@@ -1272,7 +1272,7 @@ static int latency_migrate_task_event(struct perf_sched *sched,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
-	const u32 pid = perf_evsel__intval(evsel, sample, "pid");
+	const u32 pid = evsel__intval(evsel, sample, "pid");
 	u64 timestamp = sample->time;
 	struct work_atoms *atoms;
 	struct work_atom *atom;
@@ -1526,7 +1526,7 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
 static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			    struct perf_sample *sample, struct machine *machine)
 {
-	const u32 next_pid = perf_evsel__intval(evsel, sample, "next_pid");
+	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
 	struct thread *sched_in;
 	struct thread_runtime *tr;
 	int new_shortname;
@@ -1670,8 +1670,8 @@ static int process_sched_switch_event(struct perf_tool *tool,
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 	int this_cpu = sample->cpu, err = 0;
-	u32 prev_pid = perf_evsel__intval(evsel, sample, "prev_pid"),
-	    next_pid = perf_evsel__intval(evsel, sample, "next_pid");
+	u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
+	    next_pid = evsel__intval(evsel, sample, "next_pid");
 
 	if (sched->curr_pid[this_cpu] != (u32)-1) {
 		/*
@@ -2004,8 +2004,8 @@ static void timehist_print_sample(struct perf_sched *sched,
 				  u64 t, int state)
 {
 	struct thread_runtime *tr = thread__priv(thread);
-	const char *next_comm = perf_evsel__strval(evsel, sample, "next_comm");
-	const u32 next_pid = perf_evsel__intval(evsel, sample, "next_pid");
+	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
+	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
 	u32 max_cpus = sched->max_cpu + 1;
 	char tstr[64];
 	char nstr[30];
@@ -2137,7 +2137,7 @@ static bool is_idle_sample(struct perf_sample *sample,
 {
 	/* pid 0 == swapper == idle task */
 	if (strcmp(evsel__name(evsel), "sched:sched_switch") == 0)
-		return perf_evsel__intval(evsel, sample, "prev_pid") == 0;
+		return evsel__intval(evsel, sample, "prev_pid") == 0;
 
 	return sample->pid == 0;
 }
@@ -2334,7 +2334,7 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 			itr->last_thread = thread;
 
 			/* copy task callchain when entering to idle */
-			if (perf_evsel__intval(evsel, sample, "next_pid") == 0)
+			if (evsel__intval(evsel, sample, "next_pid") == 0)
 				save_idle_callchain(sched, itr, sample);
 		}
 	}
@@ -2357,8 +2357,8 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 	if (sched->idle_hist) {
 		if (strcmp(evsel__name(evsel), "sched:sched_switch"))
 			rc = true;
-		else if (perf_evsel__intval(evsel, sample, "prev_pid") != 0 &&
-			 perf_evsel__intval(evsel, sample, "next_pid") != 0)
+		else if (evsel__intval(evsel, sample, "prev_pid") != 0 &&
+			 evsel__intval(evsel, sample, "next_pid") != 0)
 			rc = true;
 	}
 
@@ -2409,7 +2409,7 @@ static int timehist_sched_wakeup_event(struct perf_tool *tool,
 	struct thread *thread;
 	struct thread_runtime *tr = NULL;
 	/* want pid of awakened task not pid in sample */
-	const u32 pid = perf_evsel__intval(evsel, sample, "pid");
+	const u32 pid = evsel__intval(evsel, sample, "pid");
 
 	thread = machine__findnew_thread(machine, 0, pid);
 	if (thread == NULL)
@@ -2445,8 +2445,8 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 		return;
 
 	max_cpus = sched->max_cpu + 1;
-	ocpu = perf_evsel__intval(evsel, sample, "orig_cpu");
-	dcpu = perf_evsel__intval(evsel, sample, "dest_cpu");
+	ocpu = evsel__intval(evsel, sample, "orig_cpu");
+	dcpu = evsel__intval(evsel, sample, "dest_cpu");
 
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
 	if (thread == NULL)
@@ -2493,7 +2493,7 @@ static int timehist_migrate_task_event(struct perf_tool *tool,
 	struct thread *thread;
 	struct thread_runtime *tr = NULL;
 	/* want pid of migrated task not pid in sample */
-	const u32 pid = perf_evsel__intval(evsel, sample, "pid");
+	const u32 pid = evsel__intval(evsel, sample, "pid");
 
 	thread = machine__findnew_thread(machine, 0, pid);
 	if (thread == NULL)
@@ -2524,8 +2524,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 	struct thread_runtime *tr = NULL;
 	u64 tprev, t = sample->time;
 	int rc = 0;
-	int state = perf_evsel__intval(evsel, sample, "prev_state");
-
+	int state = evsel__intval(evsel, sample, "prev_state");
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_err("problem processing %d event. skipping it\n",
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 9e84fae9b096..c76f84b174c4 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -579,8 +579,8 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 			struct perf_sample *sample,
 			const char *backtrace __maybe_unused)
 {
-	u32 state = perf_evsel__intval(evsel, sample, "state");
-	u32 cpu_id = perf_evsel__intval(evsel, sample, "cpu_id");
+	u32 state  = evsel__intval(evsel, sample, "state");
+	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
 
 	if (state == (u32)PWR_EVENT_EXIT)
 		c_state_end(tchart, cpu_id, sample->time);
@@ -595,8 +595,8 @@ process_sample_cpu_frequency(struct timechart *tchart,
 			     struct perf_sample *sample,
 			     const char *backtrace __maybe_unused)
 {
-	u32 state = perf_evsel__intval(evsel, sample, "state");
-	u32 cpu_id = perf_evsel__intval(evsel, sample, "cpu_id");
+	u32 state  = evsel__intval(evsel, sample, "state");
+	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
 
 	p_state_change(tchart, cpu_id, sample->time, state);
 	return 0;
@@ -608,9 +608,9 @@ process_sample_sched_wakeup(struct timechart *tchart,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
-	u8 flags = perf_evsel__intval(evsel, sample, "common_flags");
-	int waker = perf_evsel__intval(evsel, sample, "common_pid");
-	int wakee = perf_evsel__intval(evsel, sample, "pid");
+	u8 flags  = evsel__intval(evsel, sample, "common_flags");
+	int waker = evsel__intval(evsel, sample, "common_pid");
+	int wakee = evsel__intval(evsel, sample, "pid");
 
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
 	return 0;
@@ -622,9 +622,9 @@ process_sample_sched_switch(struct timechart *tchart,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
-	int prev_pid = perf_evsel__intval(evsel, sample, "prev_pid");
-	int next_pid = perf_evsel__intval(evsel, sample, "next_pid");
-	u64 prev_state = perf_evsel__intval(evsel, sample, "prev_state");
+	int prev_pid   = evsel__intval(evsel, sample, "prev_pid");
+	int next_pid   = evsel__intval(evsel, sample, "next_pid");
+	u64 prev_state = evsel__intval(evsel, sample, "prev_state");
 
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
 		     prev_state, backtrace);
@@ -638,8 +638,8 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 			   struct perf_sample *sample,
 			   const char *backtrace __maybe_unused)
 {
-	u64 cpu_id = perf_evsel__intval(evsel, sample, "cpu_id");
-	u64 value = perf_evsel__intval(evsel, sample, "value");
+	u64 cpu_id = evsel__intval(evsel, sample, "cpu_id");
+	u64 value  = evsel__intval(evsel, sample, "value");
 
 	c_state_start(cpu_id, sample->time, value);
 	return 0;
@@ -661,8 +661,8 @@ process_sample_power_frequency(struct timechart *tchart,
 			       struct perf_sample *sample,
 			       const char *backtrace __maybe_unused)
 {
-	u64 cpu_id = perf_evsel__intval(evsel, sample, "cpu_id");
-	u64 value = perf_evsel__intval(evsel, sample, "value");
+	u64 cpu_id = evsel__intval(evsel, sample, "cpu_id");
+	u64 value  = evsel__intval(evsel, sample, "value");
 
 	p_state_change(tchart, cpu_id, sample->time, value);
 	return 0;
@@ -843,7 +843,7 @@ process_enter_read(struct timechart *tchart,
 		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
-	long fd = perf_evsel__intval(evsel, sample, "fd");
+	long fd = evsel__intval(evsel, sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_READ,
 				   sample->time, fd);
 }
@@ -853,7 +853,7 @@ process_exit_read(struct timechart *tchart,
 		  struct evsel *evsel,
 		  struct perf_sample *sample)
 {
-	long ret = perf_evsel__intval(evsel, sample, "ret");
+	long ret = evsel__intval(evsel, sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_READ,
 				 sample->time, ret);
 }
@@ -863,7 +863,7 @@ process_enter_write(struct timechart *tchart,
 		    struct evsel *evsel,
 		    struct perf_sample *sample)
 {
-	long fd = perf_evsel__intval(evsel, sample, "fd");
+	long fd = evsel__intval(evsel, sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_WRITE,
 				   sample->time, fd);
 }
@@ -873,7 +873,7 @@ process_exit_write(struct timechart *tchart,
 		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
-	long ret = perf_evsel__intval(evsel, sample, "ret");
+	long ret = evsel__intval(evsel, sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_WRITE,
 				 sample->time, ret);
 }
@@ -883,7 +883,7 @@ process_enter_sync(struct timechart *tchart,
 		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
-	long fd = perf_evsel__intval(evsel, sample, "fd");
+	long fd = evsel__intval(evsel, sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_SYNC,
 				   sample->time, fd);
 }
@@ -893,7 +893,7 @@ process_exit_sync(struct timechart *tchart,
 		  struct evsel *evsel,
 		  struct perf_sample *sample)
 {
-	long ret = perf_evsel__intval(evsel, sample, "ret");
+	long ret = evsel__intval(evsel, sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_SYNC,
 				 sample->time, ret);
 }
@@ -903,7 +903,7 @@ process_enter_tx(struct timechart *tchart,
 		 struct evsel *evsel,
 		 struct perf_sample *sample)
 {
-	long fd = perf_evsel__intval(evsel, sample, "fd");
+	long fd = evsel__intval(evsel, sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_TX,
 				   sample->time, fd);
 }
@@ -913,7 +913,7 @@ process_exit_tx(struct timechart *tchart,
 		struct evsel *evsel,
 		struct perf_sample *sample)
 {
-	long ret = perf_evsel__intval(evsel, sample, "ret");
+	long ret = evsel__intval(evsel, sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_TX,
 				 sample->time, ret);
 }
@@ -923,7 +923,7 @@ process_enter_rx(struct timechart *tchart,
 		 struct evsel *evsel,
 		 struct perf_sample *sample)
 {
-	long fd = perf_evsel__intval(evsel, sample, "fd");
+	long fd = evsel__intval(evsel, sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_RX,
 				   sample->time, fd);
 }
@@ -933,7 +933,7 @@ process_exit_rx(struct timechart *tchart,
 		struct evsel *evsel,
 		struct perf_sample *sample)
 {
-	long ret = perf_evsel__intval(evsel, sample, "ret");
+	long ret = evsel__intval(evsel, sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_RX,
 				 sample->time, ret);
 }
@@ -943,7 +943,7 @@ process_enter_poll(struct timechart *tchart,
 		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
-	long fd = perf_evsel__intval(evsel, sample, "fd");
+	long fd = evsel__intval(evsel, sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_POLL,
 				   sample->time, fd);
 }
@@ -953,7 +953,7 @@ process_exit_poll(struct timechart *tchart,
 		  struct evsel *evsel,
 		  struct perf_sample *sample)
 {
-	long ret = perf_evsel__intval(evsel, sample, "ret");
+	long ret = evsel__intval(evsel, sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_POLL,
 				 sample->time, ret);
 }
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 12b770abb87a..871d43d68a1b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -370,7 +370,7 @@ static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
 					  struct tp_field *field,
 					  const char *name)
 {
-	struct tep_format_field *format_field = perf_evsel__field(evsel, name);
+	struct tep_format_field *format_field = evsel__field(evsel, name);
 
 	if (format_field == NULL)
 		return -1;
@@ -386,7 +386,7 @@ static int perf_evsel__init_tp_ptr_field(struct evsel *evsel,
 					 struct tp_field *field,
 					 const char *name)
 {
-	struct tep_format_field *format_field = perf_evsel__field(evsel, name);
+	struct tep_format_field *format_field = evsel__field(evsel, name);
 
 	if (format_field == NULL)
 		return -1;
@@ -423,9 +423,9 @@ static int perf_evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evs
 	struct syscall_tp *sc = evsel__syscall_tp(evsel);
 
 	if (sc != NULL) {
-		struct tep_format_field *syscall_id = perf_evsel__field(tp, "id");
+		struct tep_format_field *syscall_id = evsel__field(tp, "id");
 		if (syscall_id == NULL)
-			syscall_id = perf_evsel__field(tp, "__syscall_nr");
+			syscall_id = evsel__field(tp, "__syscall_nr");
 		if (syscall_id == NULL ||
 		    __tp_field__init_uint(&sc->id, syscall_id->size, syscall_id->offset, evsel->needs_swap))
 			return -EINVAL;
@@ -2531,7 +2531,7 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel,
 	size_t filename_len, entry_str_len, to_move;
 	ssize_t remaining_space;
 	char *pos;
-	const char *filename = perf_evsel__rawptr(evsel, sample, "pathname");
+	const char *filename = evsel__rawptr(evsel, sample, "pathname");
 
 	if (!thread)
 		goto out;
@@ -2587,7 +2587,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 				     union perf_event *event __maybe_unused,
 				     struct perf_sample *sample)
 {
-        u64 runtime = perf_evsel__intval(evsel, sample, "runtime");
+        u64 runtime = evsel__intval(evsel, sample, "runtime");
 	double runtime_ms = (double)runtime / NSEC_PER_MSEC;
 	struct thread *thread = machine__findnew_thread(trace->host,
 							sample->pid,
@@ -2606,10 +2606,10 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 out_dump:
 	fprintf(trace->output, "%s: comm=%s,pid=%u,runtime=%" PRIu64 ",vruntime=%" PRIu64 ")\n",
 	       evsel->name,
-	       perf_evsel__strval(evsel, sample, "comm"),
-	       (pid_t)perf_evsel__intval(evsel, sample, "pid"),
+	       evsel__strval(evsel, sample, "comm"),
+	       (pid_t)evsel__intval(evsel, sample, "pid"),
 	       runtime,
-	       perf_evsel__intval(evsel, sample, "vruntime"));
+	       evsel__intval(evsel, sample, "vruntime"));
 	goto out_put;
 }
 
@@ -3035,7 +3035,7 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
 		if (!strstarts(evsel__name(evsel), "probe:vfs_getname"))
 			continue;
 
-		if (perf_evsel__field(evsel, "pathname")) {
+		if (evsel__field(evsel, "pathname")) {
 			evsel->handler = trace__vfs_getname;
 			found = true;
 			continue;
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 261e6eaaee99..ce8aa32bc3ee 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -8,7 +8,7 @@
 static int perf_evsel__test_field(struct evsel *evsel, const char *name,
 				  int size, bool should_be_signed)
 {
-	struct tep_format_field *field = perf_evsel__field(evsel, name);
+	struct tep_format_field *field = evsel__field(evsel, name);
 	int is_signed;
 	int ret = 0;
 
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index a77492bcb4bc..6d026e8a7fa6 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -114,7 +114,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 					goto out_delete_evlist;
 				}
 
-				tp_flags = perf_evsel__intval(evsel, &sample, "flags");
+				tp_flags = evsel__intval(evsel, &sample, "flags");
 
 				if (flags != tp_flags) {
 					pr_debug("%s: Expected flags=%#x, got %#x\n",
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index b08c8a0898d3..db5e1f70053a 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -135,8 +135,8 @@ static int process_sample_event(struct evlist *evlist,
 
 	evsel = perf_evlist__id2evsel(evlist, sample.id);
 	if (evsel == switch_tracking->switch_evsel) {
-		next_tid = perf_evsel__intval(evsel, &sample, "next_pid");
-		prev_tid = perf_evsel__intval(evsel, &sample, "prev_pid");
+		next_tid = evsel__intval(evsel, &sample, "next_pid");
+		prev_tid = evsel__intval(evsel, &sample, "prev_pid");
 		cpu = sample.cpu;
 		pr_debug3("sched_switch: cpu: %d prev_tid %d next_tid %d\n",
 			  cpu, prev_tid, next_tid);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bbd57e8fde7d..aedd554fb4bb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2314,15 +2314,14 @@ int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
 	return 0;
 }
 
-struct tep_format_field *perf_evsel__field(struct evsel *evsel, const char *name)
+struct tep_format_field *evsel__field(struct evsel *evsel, const char *name)
 {
 	return tep_find_field(evsel->tp_format, name);
 }
 
-void *perf_evsel__rawptr(struct evsel *evsel, struct perf_sample *sample,
-			 const char *name)
+void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name)
 {
-	struct tep_format_field *field = perf_evsel__field(evsel, name);
+	struct tep_format_field *field = evsel__field(evsel, name);
 	int offset;
 
 	if (!field)
@@ -2377,10 +2376,9 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 	return 0;
 }
 
-u64 perf_evsel__intval(struct evsel *evsel, struct perf_sample *sample,
-		       const char *name)
+u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *name)
 {
-	struct tep_format_field *field = perf_evsel__field(evsel, name);
+	struct tep_format_field *field = evsel__field(evsel, name);
 
 	if (!field)
 		return 0;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e16a9b23556b..d83f7007d6d7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -241,23 +241,19 @@ void evsel__close(struct evsel *evsel);
 
 struct perf_sample;
 
-void *perf_evsel__rawptr(struct evsel *evsel, struct perf_sample *sample,
-			 const char *name);
-u64 perf_evsel__intval(struct evsel *evsel, struct perf_sample *sample,
-		       const char *name);
-
-static inline char *perf_evsel__strval(struct evsel *evsel,
-				       struct perf_sample *sample,
-				       const char *name)
+void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
+u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *name);
+
+static inline char *evsel__strval(struct evsel *evsel, struct perf_sample *sample, const char *name)
 {
-	return perf_evsel__rawptr(evsel, sample, name);
+	return evsel__rawptr(evsel, sample, name);
 }
 
 struct tep_format_field;
 
 u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample, bool needs_swap);
 
-struct tep_format_field *perf_evsel__field(struct evsel *evsel, const char *name);
+struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
 
 #define perf_evsel__match(evsel, t, c)		\
 	(evsel->core.attr.type == PERF_TYPE_##t &&	\
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 59829f28cbb6..f17b1e769ae4 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2488,7 +2488,7 @@ static int intel_pt_process_switch(struct intel_pt *pt,
 	if (evsel != pt->switch_evsel)
 		return 0;
 
-	tid = perf_evsel__intval(evsel, sample, "next_pid");
+	tid = evsel__intval(evsel, sample, "next_pid");
 	cpu = sample->cpu;
 
 	intel_pt_log("sched_switch: cpu %d tid %d time %"PRIu64" tsc %#"PRIx64"\n",
-- 
2.21.1
