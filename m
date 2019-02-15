From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/43] perf cs-etm: Remove unused structure field "time" and "timestamp"
Date: Thu, 14 Feb 2019 21:45:20 -0300
Message-ID: <20190215004539.23571-25-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki K Poulouse <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Field "time" and "timestamp" in structure cs_etm_queue are no longer
used and need to be removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-3-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ebd68eb43da9..1d9419a0cf0c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -69,8 +69,6 @@ struct cs_etm_queue {
 	unsigned int queue_nr;
 	pid_t pid, tid;
 	int cpu;
-	u64 time;
-	u64 timestamp;
 	u64 offset;
 	u64 period_instructions;
 	struct branch_stack *last_branch;
@@ -82,7 +80,7 @@ struct cs_etm_queue {
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
-					   pid_t tid, u64 time_);
+					   pid_t tid);
 
 /* PTMs ETMIDR [11:8] set to b0011 */
 #define ETMIDR_PTM_VERSION 0x00000300
@@ -234,7 +232,7 @@ static int cs_etm__flush_events(struct perf_session *session,
 	if (ret < 0)
 		return ret;
 
-	return cs_etm__process_timeless_queues(etm, -1, MAX_TIMESTAMP - 1);
+	return cs_etm__process_timeless_queues(etm, -1);
 }
 
 static void cs_etm__free_queue(void *priv)
@@ -1583,7 +1581,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 }
 
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
-					   pid_t tid, u64 time_)
+					   pid_t tid)
 {
 	unsigned int i;
 	struct auxtrace_queues *queues = &etm->queues;
@@ -1593,7 +1591,6 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 		struct cs_etm_queue *etmq = queue->priv;
 
 		if (etmq && ((tid == -1) || (etmq->tid == tid))) {
-			etmq->time = time_;
 			cs_etm__set_pid_tid_cpu(etm, queue);
 			cs_etm__run_decoder(etmq);
 		}
@@ -1637,8 +1634,7 @@ static int cs_etm__process_event(struct perf_session *session,
 
 	if (event->header.type == PERF_RECORD_EXIT)
 		return cs_etm__process_timeless_queues(etm,
-						       event->fork.tid,
-						       sample->time);
+						       event->fork.tid);
 
 	return 0;
 }
-- 
2.19.1
