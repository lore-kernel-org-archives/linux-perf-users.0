From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/21] perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
Date: Wed,  1 Aug 2018 18:36:40 -0300
Message-ID: <20180801213648.4814-14-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Mike Leach <mike.leach@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Robert Walker <robert.walker@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

For CS_ETM_TRACE_ON packet, its fields 'packet->start_addr' and
'packet->end_addr' equal to 0xdeadbeefdeadbeefUL which are emitted in
the decoder layer as dummy value, but the dummy value is pointless for
branch sample when we use 'perf script' command to check program flow.

This patch is a preparation to support CS_ETM_TRACE_ON packet for branch
sample, it converts the dummy address value to zero for more readable;
this is accomplished by cs_etm__last_executed_instr() and
cs_etm__first_executed_instr().  The later one is a new function
introduced by this patch.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1531295145-596-5-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ae7c9c880cb2..976db8483478 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -494,6 +494,10 @@ static inline void cs_etm__reset_last_branch_rb(struct cs_etm_queue *etmq)
 
 static inline u64 cs_etm__last_executed_instr(struct cs_etm_packet *packet)
 {
+	/* Returns 0 for the CS_ETM_TRACE_ON packet */
+	if (packet->sample_type == CS_ETM_TRACE_ON)
+		return 0;
+
 	/*
 	 * The packet records the execution range with an exclusive end address
 	 *
@@ -505,6 +509,15 @@ static inline u64 cs_etm__last_executed_instr(struct cs_etm_packet *packet)
 	return packet->end_addr - A64_INSTR_SIZE;
 }
 
+static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
+{
+	/* Returns 0 for the CS_ETM_TRACE_ON packet */
+	if (packet->sample_type == CS_ETM_TRACE_ON)
+		return 0;
+
+	return packet->start_addr;
+}
+
 static inline u64 cs_etm__instr_count(const struct cs_etm_packet *packet)
 {
 	/*
@@ -546,7 +559,7 @@ static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq)
 
 	be       = &bs->entries[etmq->last_branch_pos];
 	be->from = cs_etm__last_executed_instr(etmq->prev_packet);
-	be->to	 = etmq->packet->start_addr;
+	be->to	 = cs_etm__first_executed_instr(etmq->packet);
 	/* No support for mispredict */
 	be->flags.mispred = 0;
 	be->flags.predicted = 1;
@@ -701,7 +714,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
 	sample.ip = cs_etm__last_executed_instr(etmq->prev_packet);
 	sample.pid = etmq->pid;
 	sample.tid = etmq->tid;
-	sample.addr = etmq->packet->start_addr;
+	sample.addr = cs_etm__first_executed_instr(etmq->packet);
 	sample.id = etmq->etm->branches_id;
 	sample.stream_id = etmq->etm->branches_id;
 	sample.period = 1;
-- 
2.14.4
