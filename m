From: yuzhoujian <ufo19890607@gmail.com>
Subject: [PATCH 3/4] Add the fp_selection_helper function to set the file pointer for the related functions
Date: Mon, 18 Sep 2017 13:55:21 +0800
Message-ID: <1505714122-39141-4-git-send-email-yuzhoujian@didichuxing.com>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 tools/perf/builtin-script.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f709f6f..89bab68 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1527,6 +1527,13 @@ static int cleanup_scripting(void)
 	return scripting_ops ? scripting_ops->stop_script() : 0;
 }
 
+static FILE *fp_selection_helper(bool per_event_dump)
+{
+	if (per_event_dump == false)
+		return stdout;
+	else
+		return per_event_dump_file;
+}
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -1566,7 +1573,7 @@ static int process_sample_event(struct perf_tool *tool,
 	if (scripting_ops)
 		scripting_ops->process_event(event, sample, evsel, &al);
 	else {
-		fp = stdout;
+		fp = fp_selection_helper(tool->per_event_dump);
 		process_event(scr, sample, evsel, &al, machine, fp);
 	}
 
@@ -1634,7 +1641,7 @@ static int process_comm_event(struct perf_tool *tool,
 		sample->tid = event->comm.tid;
 		sample->pid = event->comm.pid;
 	}
-	fp = stdout;
+	fp = fp_selection_helper(tool->per_event_dump);
 	fprint_sample_start(sample, thread, evsel, fp);
 	perf_event__fprintf(event, fp);
 	ret = 0;
@@ -1671,7 +1678,7 @@ static int process_namespaces_event(struct perf_tool *tool,
 		sample->tid = event->namespaces.tid;
 		sample->pid = event->namespaces.pid;
 	}
-	fp = stdout;
+	fp = fp_selection_helper(tool->per_event_dump);
 	fprint_sample_start(sample, thread, evsel, fp);
 	perf_event__fprintf(event, fp);
 	ret = 0;
@@ -1706,7 +1713,7 @@ static int process_fork_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	fp = stdout;
+	fp = fp_selection_helper(tool->per_event_dump);
 	fprint_sample_start(sample, thread, evsel, fp);
 	perf_event__fprintf(event, fp);
 	thread__put(thread);
@@ -1737,7 +1744,7 @@ static int process_exit_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	fp = stdout;
+	fp = fp_selection_helper(tool->per_event_dump);
 	fprint_sample_start(sample, thread, evsel, fp);
 	perf_event__fprintf(event, fp);
 
@@ -1774,7 +1781,7 @@ static int process_mmap_event(struct perf_tool *tool,
 		sample->tid = event->mmap.tid;
 		sample->pid = event->mmap.pid;
 	}
-	fp = stdout;
+	fp = fp_selection_helper(tool->per_event_dump);
 	fprint_sample_start(sample, thread, evsel, fp);
 	perf_event__fprintf(event, fp);
 	thread__put(thread);
@@ -1807,7 +1814,7 @@ static int process_mmap2_event(struct perf_tool *tool,
 		sample->tid = event->mmap2.tid;
 		sample->pid = event->mmap2.pid;
 	}
-	fp = stdout;
+	fp = fp_selection_helper(tool->per_event_dump);
 	fprint_sample_start(sample, thread, evsel, fp);
 	perf_event__fprintf(event, fp);
 	thread__put(thread);
@@ -1824,6 +1831,7 @@ static int process_switch_event(struct perf_tool *tool,
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	FILE *fp;
+
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
 
@@ -1834,7 +1842,7 @@ static int process_switch_event(struct perf_tool *tool,
 		return -1;
 	}
 
-	fp = stdout;
+	fp = fp_selection_helper(tool->per_event_dump);
 	fprint_sample_start(sample, thread, evsel, fp);
 	perf_event__fprintf(event, fp);
 	thread__put(thread);
-- 
1.8.3.1
