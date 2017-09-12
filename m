From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/41] perf tools: Use scandir() to replace readdir()
Date: Tue, 12 Sep 2017 12:10:12 -0300
Message-ID: <20170912151029.6612-25-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbdILPLw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2017 11:11:52 -0400
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Kan Liang <kan.liang@intel.com>

In perf_event__synthesize_threads() perf goes through all proc files
serially by readdir.

scandir() does a snapshoot of /proc, which is multithreading friendly.

It's possible that some threads which are added during event synthesize.
But the number of lost threads should be small.  They should not impact
the final analysis.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1504806954-150842-3-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 1c905ba3641b..17c21ea68a72 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -683,12 +683,14 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 				   bool mmap_data,
 				   unsigned int proc_map_timeout)
 {
-	DIR *proc;
-	char proc_path[PATH_MAX];
-	struct dirent *dirent;
 	union perf_event *comm_event, *mmap_event, *fork_event;
 	union perf_event *namespaces_event;
+	char proc_path[PATH_MAX];
+	struct dirent **dirent;
 	int err = -1;
+	char *end;
+	pid_t pid;
+	int n, i;
 
 	if (machine__is_default_guest(machine))
 		return 0;
@@ -712,29 +714,32 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 		goto out_free_fork;
 
 	snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
-	proc = opendir(proc_path);
+	n = scandir(proc_path, &dirent, 0, alphasort);
 
-	if (proc == NULL)
+	if (n < 0)
 		goto out_free_namespaces;
 
-	while ((dirent = readdir(proc)) != NULL) {
-		char *end;
-		pid_t pid = strtol(dirent->d_name, &end, 10);
-
-		if (*end) /* only interested in proper numerical dirents */
+	for (i = 0; i < n; i++) {
+		if (!isdigit(dirent[i]->d_name[0]))
 			continue;
-		/*
- 		 * We may race with exiting thread, so don't stop just because
- 		 * one thread couldn't be synthesized.
- 		 */
-		__event__synthesize_thread(comm_event, mmap_event, fork_event,
-					   namespaces_event, pid, 1, process,
-					   tool, machine, mmap_data,
-					   proc_map_timeout);
-	}
 
+		pid = (pid_t)strtol(dirent[i]->d_name, &end, 10);
+		/* only interested in proper numerical dirents */
+		if (!*end) {
+			/*
+			 * We may race with exiting thread, so don't stop just because
+			 * one thread couldn't be synthesized.
+			 */
+			__event__synthesize_thread(comm_event, mmap_event, fork_event,
+						   namespaces_event, pid, 1, process,
+						   tool, machine, mmap_data,
+						   proc_map_timeout);
+		}
+		free(dirent[i]);
+	}
+	free(dirent);
 	err = 0;
-	closedir(proc);
+
 out_free_namespaces:
 	free(namespaces_event);
 out_free_fork:
-- 
2.13.5
