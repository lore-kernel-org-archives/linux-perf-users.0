From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/35] perf evsel: Enable ignore_missing_thread for pid option
Date: Thu, 28 Dec 2017 11:30:23 -0300
Message-ID: <20171228143027.30547-32-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mengting Zhang <zhangmengting@huawei.com>, Cheng Jian <cj.chengjian@huawei.com>, Li Bin <huawei.libin@huawei.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mengting Zhang <zhangmengting@huawei.com>

While monitoring a multithread process with pid option, perf sometimes
may return sys_perf_event_open failure with 3(No such process) if any of
the process's threads die before we open the event. However, we want
perf continue monitoring the remaining threads and do not exit with
error.

Here, the patch enables perf_evsel::ignore_missing_thread for -p option
to ignore complete failure if any of threads die before we open the event.
But it may still return sys_perf_event_open failure with 22(Invalid) if we
monitors several event groups.

        sys_perf_event_open: pid 28960  cpu 40  group_fd 118202  flags 0x8
        sys_perf_event_open: pid 28961  cpu 40  group_fd 118203  flags 0x8
        WARNING: Ignored open failure for pid 28962
        sys_perf_event_open: pid 28962  cpu 40  group_fd [118203]  flags 0x8
        sys_perf_event_open failed, error -22

That is because when we ignore a missing thread, we change the thread_idx
without dealing with its fds, FD(evsel, cpu, thread). Then get_group_fd()
may return a wrong group_fd for the next thread and sys_perf_event_open()
return with 22.

        sys_perf_event_open(){
           ...
           if (group_fd != -1)
               perf_fget_light()//to get corresponding group_leader by group_fd
           ...
           if (group_leader)
              if (group_leader->ctx->task != ctx->task)//should on the same task
                   goto err_context
           ...
        }

This patch also fixes this bug by introducing perf_evsel__remove_fd() and
update_fds to allow removing fds for the missing thread.

Changes since v1:
- Change group_fd__remove() into a more genetic way without changing code logic
- Remove redundant condition

Changes since v2:
- Use a proper function name and add some comment.
- Multiline comment style fixes.

Committer testing:

Before this patch the recently added 'perf stat --per-thread' for system
wide counting would race while enumerating all threads using /proc:

  [root@jouet ~]# perf stat --per-thread
  failed to parse CPUs map: No such file or directory

   Usage: perf stat [<options>] [<command>]

      -C, --cpu <cpu>       list of cpus to monitor in system-wide
      -a, --all-cpus        system-wide collection from all CPUs
  [root@jouet ~]# perf stat --per-thread
  failed to parse CPUs map: No such file or directory

   Usage: perf stat [<options>] [<command>]

      -C, --cpu <cpu>       list of cpus to monitor in system-wide
      -a, --all-cpus        system-wide collection from all CPUs
  [root@jouet ~]#

When, say, the kernel was being built, so lots of shortlived threads,
after this patch this doesn't happen.

Signed-off-by: Mengting Zhang <zhangmengting@huawei.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Cheng Jian <cj.chengjian@huawei.com>
Cc: Li Bin <huawei.libin@huawei.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1513148513-6974-1-git-send-email-zhangmengting@huawei.com
[ Remove one use 'evlist' alias variable ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |  4 ++--
 tools/perf/util/evsel.c     | 47 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 98da8cb8de93..50385d89c497 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1804,8 +1804,8 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
-	/* Enable ignoring missing threads when -u option is defined. */
-	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX;
+	/* Enable ignoring missing threads when -u/-p option is defined. */
+	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
 
 	err = -ENOMEM;
 	if (perf_evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1cf044cbae36..a4d256ea0dc4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1599,10 +1599,46 @@ static int __open_attr__fprintf(FILE *fp, const char *name, const char *val,
 	return fprintf(fp, "  %-32s %s\n", name, val);
 }
 
+static void perf_evsel__remove_fd(struct perf_evsel *pos,
+				  int nr_cpus, int nr_threads,
+				  int thread_idx)
+{
+	for (int cpu = 0; cpu < nr_cpus; cpu++)
+		for (int thread = thread_idx; thread < nr_threads - 1; thread++)
+			FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
+}
+
+static int update_fds(struct perf_evsel *evsel,
+		      int nr_cpus, int cpu_idx,
+		      int nr_threads, int thread_idx)
+{
+	struct perf_evsel *pos;
+
+	if (cpu_idx >= nr_cpus || thread_idx >= nr_threads)
+		return -EINVAL;
+
+	evlist__for_each_entry(evsel->evlist, pos) {
+		nr_cpus = pos != evsel ? nr_cpus : cpu_idx;
+
+		perf_evsel__remove_fd(pos, nr_cpus, nr_threads, thread_idx);
+
+		/*
+		 * Since fds for next evsel has not been created,
+		 * there is no need to iterate whole event list.
+		 */
+		if (pos == evsel)
+			break;
+	}
+	return 0;
+}
+
 static bool ignore_missing_thread(struct perf_evsel *evsel,
+				  int nr_cpus, int cpu,
 				  struct thread_map *threads,
 				  int thread, int err)
 {
+	pid_t ignore_pid = thread_map__pid(threads, thread);
+
 	if (!evsel->ignore_missing_thread)
 		return false;
 
@@ -1618,11 +1654,18 @@ static bool ignore_missing_thread(struct perf_evsel *evsel,
 	if (threads->nr == 1)
 		return false;
 
+	/*
+	 * We should remove fd for missing_thread first
+	 * because thread_map__remove() will decrease threads->nr.
+	 */
+	if (update_fds(evsel, nr_cpus, cpu, threads->nr, thread))
+		return false;
+
 	if (thread_map__remove(threads, thread))
 		return false;
 
 	pr_warning("WARNING: Ignored open failure for pid %d\n",
-		   thread_map__pid(threads, thread));
+		   ignore_pid);
 	return true;
 }
 
@@ -1727,7 +1770,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 			if (fd < 0) {
 				err = -errno;
 
-				if (ignore_missing_thread(evsel, threads, thread, err)) {
+				if (ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
 					/*
 					 * We just removed 1 thread, so take a step
 					 * back on thread index and lower the upper
-- 
2.13.6
