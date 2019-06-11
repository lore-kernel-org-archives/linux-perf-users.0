From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 47/85] perf cs-etm: Move thread to traceid_queue
Date: Tue, 11 Jun 2019 15:58:33 -0300
Message-ID: <20190611185911.11645-48-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

The thread field of structure cs_etm_queue is CPU dependent and as such
need to be part of the cs_etm_traceid_queue in order to support CPU-wide
trace scenarios.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-12-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 531bbb355ba4..0d51d6d9a594 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -65,6 +65,7 @@ struct cs_etm_traceid_queue {
 	u64 period_instructions;
 	size_t last_branch_pos;
 	union perf_event *event_buf;
+	struct thread *thread;
 	struct branch_stack *last_branch;
 	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
@@ -74,7 +75,6 @@ struct cs_etm_traceid_queue {
 
 struct cs_etm_queue {
 	struct cs_etm_auxtrace *etm;
-	struct thread *thread;
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
@@ -415,7 +415,7 @@ static void cs_etm__free_queue(void *priv)
 	if (!etmq)
 		return;
 
-	thread__zput(etmq->thread);
+	thread__zput(etmq->traceid_queues->thread);
 	cs_etm_decoder__free(etmq->decoder);
 	zfree(&etmq->traceid_queues->event_buf);
 	zfree(&etmq->traceid_queues->last_branch);
@@ -503,7 +503,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	machine = etmq->etm->machine;
 	cpumode = cs_etm__cpu_mode(etmq, address);
 
-	thread = etmq->thread;
+	thread = etmq->traceid_queues->thread;
 	if (!thread) {
 		if (cpumode != PERF_RECORD_MISC_KERNEL)
 			return 0;
@@ -819,18 +819,21 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
 				    struct auxtrace_queue *queue)
 {
+	struct cs_etm_traceid_queue *tidq;
 	struct cs_etm_queue *etmq = queue->priv;
 
+	tidq = cs_etm__etmq_get_traceid_queue(etmq, CS_ETM_PER_THREAD_TRACEID);
+
 	/* CPU-wide tracing isn't supported yet */
 	if (queue->tid == -1)
 		return;
 
-	if ((!etmq->thread) && (etmq->tid != -1))
-		etmq->thread = machine__find_thread(etm->machine, -1,
+	if ((!tidq->thread) && (etmq->tid != -1))
+		tidq->thread = machine__find_thread(etm->machine, -1,
 						    etmq->tid);
 
-	if (etmq->thread)
-		etmq->pid = etmq->thread->pid_;
+	if (tidq->thread)
+		etmq->pid = tidq->thread->pid_;
 }
 
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
-- 
2.20.1
