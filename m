From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/54] perf intel-pt: Get rid of intel_pt_use_buffer_pid_tid()
Date: Thu,  8 Mar 2018 16:50:10 -0300
Message-ID: <20180308195029.14991-36-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

With the new way sampling support will be implemented,
intel_pt_use_buffer_pid_tid() will not be needed. Get rid of it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520431349-30689-7-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 0979a6e8b2b7..cfb3614f5def 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -222,32 +222,6 @@ static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *
 	return 0;
 }
 
-static void intel_pt_use_buffer_pid_tid(struct intel_pt_queue *ptq,
-					struct auxtrace_queue *queue,
-					struct auxtrace_buffer *buffer)
-{
-	if (queue->cpu == -1 && buffer->cpu != -1)
-		ptq->cpu = buffer->cpu;
-
-	ptq->pid = buffer->pid;
-	ptq->tid = buffer->tid;
-
-	intel_pt_log("queue %u cpu %d pid %d tid %d\n",
-		     ptq->queue_nr, ptq->cpu, ptq->pid, ptq->tid);
-
-	thread__zput(ptq->thread);
-
-	if (ptq->tid != -1) {
-		if (ptq->pid != -1)
-			ptq->thread = machine__findnew_thread(ptq->pt->machine,
-							      ptq->pid,
-							      ptq->tid);
-		else
-			ptq->thread = machine__find_thread(ptq->pt->machine, -1,
-							   ptq->tid);
-	}
-}
-
 /* This function assumes data is processed sequentially only */
 static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 {
@@ -311,10 +285,6 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 		b->consecutive = true;
 	}
 
-	if (ptq->use_buffer_pid_tid && (ptq->pid != buffer->pid ||
-					ptq->tid != buffer->tid))
-		intel_pt_use_buffer_pid_tid(ptq, queue, buffer);
-
 	if (ptq->step_through_buffers)
 		ptq->stop = true;
 
@@ -958,12 +928,9 @@ static int intel_pt_setup_queue(struct intel_pt *pt,
 			ptq->cpu = queue->cpu;
 		ptq->tid = queue->tid;
 
-		if (pt->sampling_mode) {
-			if (pt->timeless_decoding)
-				ptq->step_through_buffers = true;
-			if (pt->timeless_decoding || !pt->have_sched_switch)
-				ptq->use_buffer_pid_tid = true;
-		}
+		if (pt->sampling_mode && !pt->snapshot_mode &&
+		    pt->timeless_decoding)
+			ptq->step_through_buffers = true;
 
 		ptq->sync_switch = pt->sync_switch;
 	}
-- 
2.14.3
