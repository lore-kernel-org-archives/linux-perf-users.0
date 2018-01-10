From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/27] perf report: Add --tasks option to display monitored tasks
Date: Wed, 10 Jan 2018 18:28:42 -0300
Message-ID: <20180110212844.12441-26-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753997AbeAJVaJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Jan 2018 16:30:09 -0500
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Add --tasks option to display monitored tasks stored in perf.data.
Displaying pid/tid/ppid plus the command string aligned to distinguish
parent and child tasks.

  $ perf record -a
  ...
  $ perf report --tasks
  #     pid     tid    ppid  comm
          0       0      -1 |swapper
          2       2       0 | kthreadd
      14080   14080       2 |  kworker/u17:1
          4       4       2 |  kworker/0:0H
          6       6       2 |  mm_percpu_wq
  ...
          1       1       0 | systemd
      23242   23242       1 |  firefox
      23242   23298   23242 |   Cache2 I/O
      23242   23304   23242 |   GMPThread
  ...
       1195    1195       1 |  login
       1611    1611    1195 |   bash
       1639    1639    1611 |    startx
       1663    1663    1639 |     xinit
       1673    1673    1663 |      xmonad-x86_64-l
      23939   23939    1673 |       xterm
      23941   23941   23939 |        bash
      23963   23963   23941 |         mutt
      24954   24954   23963 |          offlineimap

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180107160356.28203-13-jolsa@kernel.org
[ Make it --tasks, plural, --task works as well, as its unambiguous ]
[ Use machine__find_thread(), not findnew(), as pointed out by Namhyung ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |   4 +
 tools/perf/builtin-report.c              | 136 ++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index a7d11ef2fe25..856c3c7e94fa 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -461,6 +461,10 @@ include::itrace.txt[]
 	Display overall events statistics without any further processing.
 	(like the one at the end of the perf report -D command)
 
+--tasks::
+	Display monitored tasks stored in perf data. Displaying pid/tid/ppid
+	plus the command string aligned to distinguish parent and child tasks.
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 8e67a8c25ab1..2c7bd85651dc 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -15,6 +15,7 @@
 #include "util/color.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
+#include <linux/err.h>
 #include "util/symbol.h"
 #include "util/callchain.h"
 #include "util/values.h"
@@ -63,6 +64,7 @@ struct report {
 	bool			inverted_callchain;
 	bool			mem_mode;
 	bool			stats_mode;
+	bool			tasks_mode;
 	bool			header;
 	bool			header_only;
 	bool			nonany_branch_mode;
@@ -603,6 +605,124 @@ static int stats_print(struct report *rep)
 	return 0;
 }
 
+static void tasks_setup(struct report *rep)
+{
+	memset(&rep->tool, 0, sizeof(rep->tool));
+	rep->tool.comm = perf_event__process_comm;
+	rep->tool.exit = perf_event__process_exit;
+	rep->tool.fork = perf_event__process_fork;
+	rep->tool.no_warn = true;
+}
+
+struct task {
+	struct thread		*thread;
+	struct list_head	 list;
+	struct list_head	 children;
+};
+
+static struct task *tasks_list(struct task *task, struct machine *machine)
+{
+	struct thread *parent_thread, *thread = task->thread;
+	struct task   *parent_task;
+
+	/* Already listed. */
+	if (!list_empty(&task->list))
+		return NULL;
+
+	/* Last one in the chain. */
+	if (thread->ppid == -1)
+		return task;
+
+	parent_thread = machine__find_thread(machine, -1, thread->ppid);
+	if (!parent_thread)
+		return ERR_PTR(-ENOENT);
+
+	parent_task = thread__priv(parent_thread);
+	list_add_tail(&task->list, &parent_task->children);
+	return tasks_list(parent_task, machine);
+}
+
+static void task__print_level(struct task *task, FILE *fp, int level)
+{
+	struct thread *thread = task->thread;
+	struct task *child;
+
+	fprintf(fp, "  %8d %8d %8d |%*s%s\n",
+		thread->pid_, thread->tid, thread->ppid,
+		level, "", thread__comm_str(thread));
+
+	if (!list_empty(&task->children)) {
+		list_for_each_entry(child, &task->children, list)
+			task__print_level(child, fp, level + 1);
+	}
+}
+
+static int tasks_print(struct report *rep, FILE *fp)
+{
+	struct perf_session *session = rep->session;
+	struct machine      *machine = &session->machines.host;
+	struct task *tasks, *task;
+	unsigned int nr = 0, itask = 0, i;
+	struct rb_node *nd;
+	LIST_HEAD(list);
+
+	/*
+	 * No locking needed while accessing machine->threads,
+	 * because --tasks is single threaded command.
+	 */
+
+	/* Count all the threads. */
+	for (i = 0; i < THREADS__TABLE_SIZE; i++)
+		nr += machine->threads[i].nr;
+
+	tasks = malloc(sizeof(*tasks) * nr);
+	if (!tasks)
+		return -ENOMEM;
+
+	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads *threads = &machine->threads[i];
+
+		for (nd = rb_first(&threads->entries); nd; nd = rb_next(nd)) {
+			task = tasks + itask++;
+
+			task->thread = rb_entry(nd, struct thread, rb_node);
+			INIT_LIST_HEAD(&task->children);
+			INIT_LIST_HEAD(&task->list);
+			thread__set_priv(task->thread, task);
+		}
+	}
+
+	/*
+	 * Iterate every task down to the unprocessed parent
+	 * and link all in task children list. Task with no
+	 * parent is added into 'list'.
+	 */
+	for (itask = 0; itask < nr; itask++) {
+		task = tasks + itask;
+
+		if (!list_empty(&task->list))
+			continue;
+
+		task = tasks_list(task, machine);
+		if (IS_ERR(task)) {
+			pr_err("Error: failed to process tasks\n");
+			free(tasks);
+			return PTR_ERR(task);
+		}
+
+		if (task)
+			list_add_tail(&task->list, &list);
+	}
+
+	fprintf(fp, "# %8s %8s %8s  %s\n", "pid", "tid", "ppid", "comm");
+
+	list_for_each_entry(task, &list, list)
+		task__print_level(task, fp, 0);
+
+	free(tasks);
+	return 0;
+}
+
 static int __cmd_report(struct report *rep)
 {
 	int ret;
@@ -637,6 +757,9 @@ static int __cmd_report(struct report *rep)
 	if (rep->stats_mode)
 		stats_setup(rep);
 
+	if (rep->tasks_mode)
+		tasks_setup(rep);
+
 	ret = perf_session__process_events(session);
 	if (ret) {
 		ui__error("failed to process sample\n");
@@ -646,6 +769,9 @@ static int __cmd_report(struct report *rep)
 	if (rep->stats_mode)
 		return stats_print(rep);
 
+	if (rep->tasks_mode)
+		return tasks_print(rep, stdout);
+
 	report__warn_kptr_restrict(rep);
 
 	evlist__for_each_entry(session->evlist, pos)
@@ -803,6 +929,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
 	OPT_BOOLEAN(0, "stats", &report.stats_mode, "Display event stats"),
+	OPT_BOOLEAN(0, "tasks", &report.tasks_mode, "Display recorded tasks"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
@@ -1064,8 +1191,12 @@ int cmd_report(int argc, const char **argv)
 		report.tool.show_feat_hdr = SHOW_FEAT_HEADER;
 	if (report.show_full_info)
 		report.tool.show_feat_hdr = SHOW_FEAT_HEADER_FULL_INFO;
-	if (report.stats_mode)
+	if (report.stats_mode || report.tasks_mode)
 		use_browser = 0;
+	if (report.stats_mode && report.tasks_mode) {
+		pr_err("Error: --tasks and --stats options cannot be used together\n");
+		goto error;
+	}
 
 	if (strcmp(input_name, "-") != 0)
 		setup_browser(true);
@@ -1088,7 +1219,8 @@ int cmd_report(int argc, const char **argv)
 			ret = 0;
 			goto error;
 		}
-	} else if (use_browser == 0 && !quiet && !report.stats_mode) {
+	} else if (use_browser == 0 && !quiet &&
+		   !report.stats_mode && !report.tasks_mode) {
 		fputs("# To display the perf.data header info, please use --header/--header-only options.\n#\n",
 		      stdout);
 	}
-- 
2.14.3
