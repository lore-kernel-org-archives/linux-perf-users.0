From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/27] perf report: Introduce --mmaps
Date: Wed, 10 Jan 2018 18:28:43 -0300
Message-ID: <20180110212844.12441-27-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Similar to --tasks, producing the same output plus /proc/<PID>/maps
similar lines for each mmap record present in a perf.data file.

Please note that not all mmaps are stored, for instance, some of the
non-executable mmaps are only stored when 'perf record --data' is used,
when the user wants to resolve data accesses in addition to asking for
executable mmaps to get the DSO with symtabs.

E.g.:

  # perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.018 MB perf.data (7 samples) ]
  [root@jouet ~]# perf report --mmaps
  #      pid      tid     ppid  comm
           0        0       -1 |swapper
        4137     4137       -1 |sleep
                                  5628a35a1000-5628a37aa000 r-xp 00000000 3147148 /usr/bin/sleep
                                  7fb65ad51000-7fb65b134000 r-xp 00000000 3149795 /usr/lib64/libc-2.26.so
                                  7fb65b134000-7fb65b35e000 r-xp 00000000 3149715 /usr/lib64/ld-2.26.so
                                  7ffd94b9f000-7ffd94ba1000 r-xp 00000000 0 [vdso]
  #
  # perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.019 MB perf.data (8 samples) ]
  # perf report --mmaps
  #      pid      tid     ppid  comm
           0        0       -1 |swapper
        4161     4161       -1 |sleep
                                  55afae69a000-55afae8a3000 r-xp 00000000 3147148 /usr/bin/sleep
                                  7f569f00d000-7f569f3f0000 r-xp 00000000 3149795 /usr/lib64/libc-2.26.so
                                  7f569f3f0000-7f569f61a000 r-xp 00000000 3149715 /usr/lib64/ld-2.26.so
                                  7fff6fffe000-7fff70000000 r-xp 00000000 0 [vdso]
  #
  # perf record time sleep 1
  0.00user 0.00system 0:01.00elapsed 0%CPU (0avgtext+0avgdata 2156maxresident)k
  0inputs+0outputs (0major+73minor)pagefaults 0swaps
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.019 MB perf.data (14 samples) ]
  # perf report --mmaps
  #      pid      tid     ppid  comm
           0        0       -1 |swapper
        4281     4281       -1 |time
                                  560560dca000-560560fcf000 r-xp 00000000 3190458 /usr/bin/time
                                  7fc175196000-7fc175579000 r-xp 00000000 3149795 /usr/lib64/libc-2.26.so
                                  7fc175579000-7fc1757a3000 r-xp 00000000 3149715 /usr/lib64/ld-2.26.so
                                  7ffc924f6000-7ffc924f8000 r-xp 00000000 0 [vdso]
        4282     4282     4281 | sleep
                                   560560dca000-560560fcf000 r-xp 00000000 3190458 /usr/bin/time
                                   564b4de3c000-564b4e045000 r-xp 00000000 3147148 /usr/bin/sleep
                                   7f6a5a716000-7f6a5aaf9000 r-xp 00000000 3149795 /usr/lib64/libc-2.26.so
                                   7f6a5aaf9000-7f6a5ad23000 r-xp 00000000 3149715 /usr/lib64/ld-2.26.so
                                   7fc175196000-7fc175579000 r-xp 00000000 3149795 /usr/lib64/libc-2.26.so
                                   7fc175579000-7fc1757a3000 r-xp 00000000 3149715 /usr/lib64/ld-2.26.so
                                   7ffc924f6000-7ffc924f8000 r-xp 00000000 0 [vdso]
                                   7ffcec7e6000-7ffcec7e8000 r-xp 00000000 0 [vdso]
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zulwdlg5rfowogr1qznorvvc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  9 +++++-
 tools/perf/builtin-report.c              | 50 +++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 856c3c7e94fa..63d0db3184c9 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -457,6 +457,13 @@ include::itrace.txt[]
 	will be printed. Each entry is function name or file/line. Enabled by
 	default, disable with --no-inline.
 
+--mmaps::
+	Show --tasks output plus mmap information in a format similar to
+	/proc/<PID>/maps.
+
+	Please note that not all mmaps are stored, options affecting which ones
+	are include 'perf record --data', for instance.
+
 --stats::
 	Display overall events statistics without any further processing.
 	(like the one at the end of the perf report -D command)
@@ -469,4 +476,4 @@ include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
 --------
-linkperf:perf-stat[1], linkperf:perf-annotate[1]
+linkperf:perf-stat[1], linkperf:perf-annotate[1], linkperf:perf-record[1]
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2c7bd85651dc..dd4df9a5cd06 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -52,6 +52,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <linux/mman.h>
 
 #define PTIME_RANGE_MAX	10
 
@@ -65,6 +66,7 @@ struct report {
 	bool			mem_mode;
 	bool			stats_mode;
 	bool			tasks_mode;
+	bool			mmaps_mode;
 	bool			header;
 	bool			header_only;
 	bool			nonany_branch_mode;
@@ -608,6 +610,10 @@ static int stats_print(struct report *rep)
 static void tasks_setup(struct report *rep)
 {
 	memset(&rep->tool, 0, sizeof(rep->tool));
+	if (rep->mmaps_mode) {
+		rep->tool.mmap = perf_event__process_mmap;
+		rep->tool.mmap2 = perf_event__process_mmap2;
+	}
 	rep->tool.comm = perf_event__process_comm;
 	rep->tool.exit = perf_event__process_exit;
 	rep->tool.fork = perf_event__process_fork;
@@ -642,14 +648,46 @@ static struct task *tasks_list(struct task *task, struct machine *machine)
 	return tasks_list(parent_task, machine);
 }
 
+static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
+{
+	size_t printed = 0;
+	struct rb_node *nd;
+
+	for (nd = rb_first(&maps->entries); nd; nd = rb_next(nd)) {
+		struct map *map = rb_entry(nd, struct map, rb_node);
+
+		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
+				   indent, "", map->start, map->end,
+				   map->prot & PROT_READ ? 'r' : '-',
+				   map->prot & PROT_WRITE ? 'w' : '-',
+				   map->prot & PROT_EXEC ? 'x' : '-',
+				   map->flags & MAP_SHARED ? 's' : 'p',
+				   map->pgoff,
+				   map->ino, map->dso->name);
+	}
+
+	return printed;
+}
+
+static int map_groups__fprintf_task(struct map_groups *mg, int indent, FILE *fp)
+{
+	int printed = 0, i;
+	for (i = 0; i < MAP__NR_TYPES; ++i)
+		printed += maps__fprintf_task(&mg->maps[i], indent, fp);
+	return printed;
+}
+
 static void task__print_level(struct task *task, FILE *fp, int level)
 {
 	struct thread *thread = task->thread;
 	struct task *child;
+	int comm_indent = fprintf(fp, "  %8d %8d %8d |%*s",
+				  thread->pid_, thread->tid, thread->ppid,
+				  level, "");
+
+	fprintf(fp, "%s\n", thread__comm_str(thread));
 
-	fprintf(fp, "  %8d %8d %8d |%*s%s\n",
-		thread->pid_, thread->tid, thread->ppid,
-		level, "", thread__comm_str(thread));
+	map_groups__fprintf_task(thread->mg, comm_indent, fp);
 
 	if (!list_empty(&task->children)) {
 		list_for_each_entry(child, &task->children, list)
@@ -930,6 +968,7 @@ int cmd_report(int argc, const char **argv)
 		    "dump raw trace in ASCII"),
 	OPT_BOOLEAN(0, "stats", &report.stats_mode, "Display event stats"),
 	OPT_BOOLEAN(0, "tasks", &report.tasks_mode, "Display recorded tasks"),
+	OPT_BOOLEAN(0, "mmaps", &report.mmaps_mode, "Display recorded tasks memory maps"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
@@ -1077,6 +1116,9 @@ int cmd_report(int argc, const char **argv)
 		report.symbol_filter_str = argv[0];
 	}
 
+	if (report.mmaps_mode)
+		report.tasks_mode = true;
+
 	if (quiet)
 		perf_quiet_option();
 
@@ -1194,7 +1236,7 @@ int cmd_report(int argc, const char **argv)
 	if (report.stats_mode || report.tasks_mode)
 		use_browser = 0;
 	if (report.stats_mode && report.tasks_mode) {
-		pr_err("Error: --tasks and --stats options cannot be used together\n");
+		pr_err("Error: --tasks and --mmaps can't be used together with --stats\n");
 		goto error;
 	}
 
-- 
2.14.3
