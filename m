From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/43] perf cs-etm: Fix memory leak in error path
Date: Thu, 14 Feb 2019 21:45:23 -0300
Message-ID: <20190215004539.23571-28-acme@kernel.org>
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

Memory allocated for variable 't_params' isn't released properly in the
error path of function cs_etm_queue *cs_etm__alloc_queue() and
cs_etm__dump_event(), something this patch addresses.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-6-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3011c6cae531..aac07f950074 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -175,6 +175,10 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
+
+	if (!t_params)
+		return;
+
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
 			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
@@ -206,14 +210,12 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, NULL,
 					CS_ETM_OPERATION_PRINT))
-		return;
+		goto out_free;
 
 	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-	zfree(&t_params);
-
 	if (!decoder)
-		return;
+		goto out_free;
 	do {
 		size_t consumed;
 
@@ -228,6 +230,9 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	} while (buffer_used < buffer->size);
 
 	cs_etm_decoder__free(decoder);
+
+out_free:
+	zfree(&t_params);
 }
 
 static int cs_etm__flush_events(struct perf_session *session,
@@ -379,7 +384,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 {
 	int i;
 	struct cs_etm_decoder_params d_params;
-	struct cs_etm_trace_params  *t_params;
+	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
 	size_t szp = sizeof(struct cs_etm_packet);
 
@@ -461,8 +466,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-	zfree(&t_params);
-
 	if (!etmq->decoder)
 		goto out_free;
 
@@ -475,6 +478,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 					      cs_etm__mem_access))
 		goto out_free_decoder;
 
+	zfree(&t_params);
+
 	etmq->offset = 0;
 	etmq->period_instructions = 0;
 
@@ -483,6 +488,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 out_free_decoder:
 	cs_etm_decoder__free(etmq->decoder);
 out_free:
+	zfree(&t_params);
 	zfree(&etmq->event_buf);
 	zfree(&etmq->last_branch);
 	zfree(&etmq->last_branch_rb);
-- 
2.19.1
