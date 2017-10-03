From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/8] perf top: Implement multithreading for perf_event__synthesize_threads
Date: Tue,  3 Oct 2017 09:55:38 -0300
Message-ID: <20171003125540.331-7-acme@kernel.org>
References: <20171003125540.331-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171003125540.331-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

The proc files which is sorted with alphabetical order are evenly
assigned to several synthesize threads to be processed in parallel.

For 'perf top', the threads number hard code to online CPU number. The
following patch will introduce an option to set it.

For other perf tools, the thread number is 1. Because the process
function is not ready for multithreading, e.g.
process_synthesized_event.

This patch series only support event synthesize multithreading for 'perf
top'. For other tools, it can be done separately later.

With multithread applied, the total processing time can get up to 1.56x
speedup on Knights Mill for 'perf top'.

For specific single event processing, the processing time could increase
because of the lock contention. So proc_map_timeout may need to be
increased. Otherwise some proc maps will be truncated.

Based on my test, increasing the proc_map_timeout has small impact
on the total processing time. The total processing time still get 1.49x
speedup on Knights Mill after increasing the proc_map_timeout.
The patch itself doesn't increase the proc_map_timeout.

Doesn't need to implement multithreading for per task monitoring,
perf_event__synthesize_thread_map. It doesn't have performance issue.

Committer testing:

  # getconf _NPROCESSORS_ONLN
  4
  # perf trace --no-inherit -e clone -o /tmp/output perf top
  # tail -4 /tmp/bla
     0.124 ( 0.041 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7fc3eb3a8f30, parent_tidptr: 0x7fc3eb3a99d0, child_tidptr: 0x7fc3eb3a99d0, tls: 0x7fc3eb3a9700) = 9548 (perf)
     0.246 ( 0.023 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7fc3eaba7f30, parent_tidptr: 0x7fc3eaba89d0, child_tidptr: 0x7fc3eaba89d0, tls: 0x7fc3eaba8700) = 9549 (perf)
     0.286 ( 0.019 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7fc3ea3a6f30, parent_tidptr: 0x7fc3ea3a79d0, child_tidptr: 0x7fc3ea3a79d0, tls: 0x7fc3ea3a7700) = 9550 (perf)
   246.540 ( 0.047 ms): clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7fc3ea3a6f30, parent_tidptr: 0x7fc3ea3a79d0, child_tidptr: 0x7fc3ea3a79d0, tls: 0x7fc3ea3a7700) = 9551 (perf)
  #

Signed-off-by: Kan Liang <kan.liang@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1506696477-146932-4-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c              |   3 +-
 tools/perf/builtin-record.c           |   2 +-
 tools/perf/builtin-top.c              |   8 +-
 tools/perf/builtin-trace.c            |   2 +-
 tools/perf/tests/mmap-thread-lookup.c |   2 +-
 tools/perf/util/event.c               | 160 +++++++++++++++++++++++++++-------
 tools/perf/util/event.h               |   3 +-
 tools/perf/util/machine.c             |   8 +-
 tools/perf/util/machine.h             |   9 +-
 9 files changed, 155 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index c747a1af49fe..721f4f91291a 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1441,7 +1441,8 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	perf_session__set_id_hdr_size(kvm->session);
 	ordered_events__set_copy_on_queue(&kvm->session->ordered_events, true);
 	machine__synthesize_threads(&kvm->session->machines.host, &kvm->opts.target,
-				    kvm->evlist->threads, false, kvm->opts.proc_map_timeout);
+				    kvm->evlist->threads, false,
+				    kvm->opts.proc_map_timeout, 1);
 	err = kvm_live_open_events(kvm);
 	if (err)
 		goto out;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9b379f3a3d99..234fdf4734f6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -863,7 +863,7 @@ static int record__synthesize(struct record *rec, bool tail)
 
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
 					    process_synthesized_event, opts->sample_address,
-					    opts->proc_map_timeout);
+					    opts->proc_map_timeout, 1);
 out:
 	return err;
 }
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ee954bde7e3e..bc31b93cc1d8 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -958,8 +958,14 @@ static int __cmd_top(struct perf_top *top)
 	if (perf_session__register_idle_thread(top->session) < 0)
 		goto out_delete;
 
+	perf_set_multithreaded();
+
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
-				    top->evlist->threads, false, opts->proc_map_timeout);
+				    top->evlist->threads, false,
+				    opts->proc_map_timeout,
+				    (unsigned int)sysconf(_SC_NPROCESSORS_ONLN));
+
+	perf_set_singlethreaded();
 
 	if (perf_hpp_list.socket) {
 		ret = perf_env__read_cpu_topology_map(&perf_env);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 967bd351b58d..afef6fe46c45 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1131,7 +1131,7 @@ static int trace__symbols_init(struct trace *trace, struct perf_evlist *evlist)
 
 	err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
 					    evlist->threads, trace__tool_process, false,
-					    trace->opts.proc_map_timeout);
+					    trace->opts.proc_map_timeout, 1);
 	if (err)
 		symbol__exit();
 
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index f94a4196e7c9..2a0068afe3bf 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -131,7 +131,7 @@ static int synth_all(struct machine *machine)
 {
 	return perf_event__synthesize_threads(NULL,
 					      perf_event__process,
-					      machine, 0, 500);
+					      machine, 0, 500, 1);
 }
 
 static int synth_process(struct machine *machine)
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 10366b87d0b5..0e678dd6bdbe 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -678,23 +678,21 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
 	return err;
 }
 
-int perf_event__synthesize_threads(struct perf_tool *tool,
-				   perf_event__handler_t process,
-				   struct machine *machine,
-				   bool mmap_data,
-				   unsigned int proc_map_timeout)
+static int __perf_event__synthesize_threads(struct perf_tool *tool,
+					    perf_event__handler_t process,
+					    struct machine *machine,
+					    bool mmap_data,
+					    unsigned int proc_map_timeout,
+					    struct dirent **dirent,
+					    int start,
+					    int num)
 {
 	union perf_event *comm_event, *mmap_event, *fork_event;
 	union perf_event *namespaces_event;
-	char proc_path[PATH_MAX];
-	struct dirent **dirent;
 	int err = -1;
 	char *end;
 	pid_t pid;
-	int n, i;
-
-	if (machine__is_default_guest(machine))
-		return 0;
+	int i;
 
 	comm_event = malloc(sizeof(comm_event->comm) + machine->id_hdr_size);
 	if (comm_event == NULL)
@@ -714,34 +712,25 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 	if (namespaces_event == NULL)
 		goto out_free_fork;
 
-	snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
-	n = scandir(proc_path, &dirent, 0, alphasort);
-
-	if (n < 0)
-		goto out_free_namespaces;
-
-	for (i = 0; i < n; i++) {
+	for (i = start; i < start + num; i++) {
 		if (!isdigit(dirent[i]->d_name[0]))
 			continue;
 
 		pid = (pid_t)strtol(dirent[i]->d_name, &end, 10);
 		/* only interested in proper numerical dirents */
-		if (!*end) {
-			/*
-			 * We may race with exiting thread, so don't stop just because
-			 * one thread couldn't be synthesized.
-			 */
-			__event__synthesize_thread(comm_event, mmap_event, fork_event,
-						   namespaces_event, pid, 1, process,
-						   tool, machine, mmap_data,
-						   proc_map_timeout);
-		}
-		free(dirent[i]);
+		if (*end)
+			continue;
+		/*
+		 * We may race with exiting thread, so don't stop just because
+		 * one thread couldn't be synthesized.
+		 */
+		__event__synthesize_thread(comm_event, mmap_event, fork_event,
+					   namespaces_event, pid, 1, process,
+					   tool, machine, mmap_data,
+					   proc_map_timeout);
 	}
-	free(dirent);
 	err = 0;
 
-out_free_namespaces:
 	free(namespaces_event);
 out_free_fork:
 	free(fork_event);
@@ -753,6 +742,115 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 	return err;
 }
 
+struct synthesize_threads_arg {
+	struct perf_tool *tool;
+	perf_event__handler_t process;
+	struct machine *machine;
+	bool mmap_data;
+	unsigned int proc_map_timeout;
+	struct dirent **dirent;
+	int num;
+	int start;
+};
+
+static void *synthesize_threads_worker(void *arg)
+{
+	struct synthesize_threads_arg *args = arg;
+
+	__perf_event__synthesize_threads(args->tool, args->process,
+					 args->machine, args->mmap_data,
+					 args->proc_map_timeout, args->dirent,
+					 args->start, args->num);
+	return NULL;
+}
+
+int perf_event__synthesize_threads(struct perf_tool *tool,
+				   perf_event__handler_t process,
+				   struct machine *machine,
+				   bool mmap_data,
+				   unsigned int proc_map_timeout,
+				   unsigned int nr_threads_synthesize)
+{
+	struct synthesize_threads_arg *args = NULL;
+	pthread_t *synthesize_threads = NULL;
+	char proc_path[PATH_MAX];
+	struct dirent **dirent;
+	int num_per_thread;
+	int m, n, i, j;
+	int thread_nr;
+	int base = 0;
+	int err = -1;
+
+
+	if (machine__is_default_guest(machine))
+		return 0;
+
+	snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
+	n = scandir(proc_path, &dirent, 0, alphasort);
+	if (n < 0)
+		return err;
+
+	thread_nr = nr_threads_synthesize;
+
+	if (thread_nr <= 1) {
+		err = __perf_event__synthesize_threads(tool, process,
+						       machine, mmap_data,
+						       proc_map_timeout,
+						       dirent, base, n);
+		goto free_dirent;
+	}
+	if (thread_nr > n)
+		thread_nr = n;
+
+	synthesize_threads = calloc(sizeof(pthread_t), thread_nr);
+	if (synthesize_threads == NULL)
+		goto free_dirent;
+
+	args = calloc(sizeof(*args), thread_nr);
+	if (args == NULL)
+		goto free_threads;
+
+	num_per_thread = n / thread_nr;
+	m = n % thread_nr;
+	for (i = 0; i < thread_nr; i++) {
+		args[i].tool = tool;
+		args[i].process = process;
+		args[i].machine = machine;
+		args[i].mmap_data = mmap_data;
+		args[i].proc_map_timeout = proc_map_timeout;
+		args[i].dirent = dirent;
+	}
+	for (i = 0; i < m; i++) {
+		args[i].num = num_per_thread + 1;
+		args[i].start = i * args[i].num;
+	}
+	if (i != 0)
+		base = args[i-1].start + args[i-1].num;
+	for (j = i; j < thread_nr; j++) {
+		args[j].num = num_per_thread;
+		args[j].start = base + (j - i) * args[i].num;
+	}
+
+	for (i = 0; i < thread_nr; i++) {
+		if (pthread_create(&synthesize_threads[i], NULL,
+				   synthesize_threads_worker, &args[i]))
+			goto out_join;
+	}
+	err = 0;
+out_join:
+	for (i = 0; i < thread_nr; i++)
+		pthread_join(synthesize_threads[i], NULL);
+	free(args);
+free_threads:
+	free(synthesize_threads);
+free_dirent:
+	for (i = 0; i < n; i++)
+		free(dirent[i]);
+	free(dirent);
+
+	return err;
+}
+
 struct process_symbol_args {
 	const char *name;
 	u64	   start;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ee7bcc898d35..d6cbb0a0d919 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -680,7 +680,8 @@ int perf_event__synthesize_cpu_map(struct perf_tool *tool,
 int perf_event__synthesize_threads(struct perf_tool *tool,
 				   perf_event__handler_t process,
 				   struct machine *machine, bool mmap_data,
-				   unsigned int proc_map_timeout);
+				   unsigned int proc_map_timeout,
+				   unsigned int nr_threads_synthesize);
 int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 				       perf_event__handler_t process,
 				       struct machine *machine);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 585b4a3d64a4..7c3aa479201a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2218,12 +2218,16 @@ int machines__for_each_thread(struct machines *machines,
 int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
 				  struct target *target, struct thread_map *threads,
 				  perf_event__handler_t process, bool data_mmap,
-				  unsigned int proc_map_timeout)
+				  unsigned int proc_map_timeout,
+				  unsigned int nr_threads_synthesize)
 {
 	if (target__has_task(target))
 		return perf_event__synthesize_thread_map(tool, threads, process, machine, data_mmap, proc_map_timeout);
 	else if (target__has_cpu(target))
-		return perf_event__synthesize_threads(tool, process, machine, data_mmap, proc_map_timeout);
+		return perf_event__synthesize_threads(tool, process,
+						      machine, data_mmap,
+						      proc_map_timeout,
+						      nr_threads_synthesize);
 	/* command specified */
 	return 0;
 }
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index b1cd516f2025..c6a299ea506c 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -257,15 +257,18 @@ int machines__for_each_thread(struct machines *machines,
 int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
 				  struct target *target, struct thread_map *threads,
 				  perf_event__handler_t process, bool data_mmap,
-				  unsigned int proc_map_timeout);
+				  unsigned int proc_map_timeout,
+				  unsigned int nr_threads_synthesize);
 static inline
 int machine__synthesize_threads(struct machine *machine, struct target *target,
 				struct thread_map *threads, bool data_mmap,
-				unsigned int proc_map_timeout)
+				unsigned int proc_map_timeout,
+				unsigned int nr_threads_synthesize)
 {
 	return __machine__synthesize_threads(machine, NULL, target, threads,
 					     perf_event__process, data_mmap,
-					     proc_map_timeout);
+					     proc_map_timeout,
+					     nr_threads_synthesize);
 }
 
 pid_t machine__get_current_tid(struct machine *machine, int cpu);
-- 
2.13.6
