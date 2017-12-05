From: Mengting Zhang <zhangmengting@huawei.com>
Subject: [PATCH] perf evsel: Enable ignore_missing_thread for pid option
Date: Tue, 5 Dec 2017 16:53:47 +0800
Message-ID: <1512464027-36169-1-git-send-email-zhangmengting@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:11505 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbdLEJCe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Dec 2017 04:02:34 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@redhat.com, jolsa@redhat.com, huawei.libin@huawei.com, wangnan0@huawei.com, cj.chengjian@huawei.com, zhangmengting@huawei.com

While monitoring a multithread process with pid option, perf sometimes
may return sys_perf_event_open failure with 3(No such process) if any
of the process's threads die before we open the event. However, we want
perf continue monitoring the remaining threads and do not exit with error.

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

This patch also fixes this bug by introducing group_fd__remove() to allow
removing fds for the missing thread.

Signed-off-by: Mengting Zhang <zhangmengting@huawei.com>
Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 tools/perf/builtin-record.c |  4 ++--
 tools/perf/util/evsel.c     | 42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3d7f33e..86b2e03 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1763,8 +1763,8 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
-	/* Enable ignoring missing threads when -u option is defined. */
-	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX;
+	/* Enable ignoring missing threads when -u/-p option is defined. */
+	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
 
 	err = -ENOMEM;
 	if (perf_evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f894893..5ca335d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1592,10 +1592,42 @@ static int __open_attr__fprintf(FILE *fp, const char *name, const char *val,
 	return fprintf(fp, "  %-32s %s\n", name, val);
 }
 
+static int group_fd__remove(struct perf_evsel *evsel,
+			    int nr_cpus, int cpu_idx,
+			    int nr_threads, int thread_idx)
+{
+	struct perf_evsel *pos;
+	struct perf_evlist *evlist = evsel->evlist;
+
+	if (nr_cpus < 1 || nr_threads < 1)
+		return -EINVAL;
+
+	if (cpu_idx >= nr_cpus || thread_idx >= nr_threads)
+		return -EINVAL;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (pos != evsel) {
+			for (int cpu = 0; cpu < nr_cpus; cpu++)
+				for (int thread = thread_idx; thread < nr_threads; thread++)
+					FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
+		}
+		else {
+			for (int cpu = 0; cpu < cpu_idx; cpu++)
+				for (int thread = thread_idx; thread < nr_threads; thread++)
+					FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
+			break;
+		}
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
 
@@ -1611,11 +1643,17 @@ static bool ignore_missing_thread(struct perf_evsel *evsel,
 	if (threads->nr == 1)
 		return false;
 
+	/* We should remove group_fd for missing_thread first
+	 * because thread_map__remove() will decrease threads->nr.
+	 */
+	if (group_fd__remove(evsel, nr_cpus, cpu, threads->nr, thread))
+		return false;
+
 	if (thread_map__remove(threads, thread))
 		return false;
 
 	pr_warning("WARNING: Ignored open failure for pid %d\n",
-		   thread_map__pid(threads, thread));
+		   ignore_pid);
 	return true;
 }
 
@@ -1720,7 +1758,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 			if (fd < 0) {
 				err = -errno;
 
-				if (ignore_missing_thread(evsel, threads, thread, err)) {
+				if (ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
 					/*
 					 * We just removed 1 thread, so take a step
 					 * back on thread index and lower the upper
-- 
1.8.3.1
