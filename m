From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/43] perf cs-etm: Introducing function cs_etm_decoder__init_dparams()
Date: Thu, 14 Feb 2019 21:45:22 -0300
Message-ID: <20190215004539.23571-27-acme@kernel.org>
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

Introducing function cs_etm_decoder__init_dparams() to avoid repeating
code at two different places.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-5-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
 tools/perf/util/cs-etm.c                      | 41 +++++++++++++------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 7e6a8850be4a..663309486784 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -105,9 +105,10 @@ enum {
 	CS_ETM_PROTO_PTM,
 };
 
-enum {
+enum cs_etm_decoder_operation {
 	CS_ETM_OPERATION_PRINT = 1,
 	CS_ETM_OPERATION_DECODE,
+	CS_ETM_OPERATION_MAX,
 };
 
 int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f396fee9bb95..3011c6cae531 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -136,6 +136,28 @@ static void cs_etm__packet_dump(const char *pkt_string)
 	fflush(stdout);
 }
 
+static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
+				       struct cs_etm_queue *etmq,
+				       enum cs_etm_decoder_operation mode)
+{
+	int ret = -EINVAL;
+
+	if (!(mode < CS_ETM_OPERATION_MAX))
+		goto out;
+
+	d_params->packet_printer = cs_etm__packet_dump;
+	d_params->operation = mode;
+	d_params->data = etmq;
+	d_params->formatted = true;
+	d_params->fsyncs = false;
+	d_params->hsyncs = false;
+	d_params->frame_aligned = true;
+
+	ret = 0;
+out:
+	return ret;
+}
+
 static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_buffer *buffer)
 {
@@ -182,12 +204,9 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-	d_params.packet_printer = cs_etm__packet_dump;
-	d_params.operation = CS_ETM_OPERATION_PRINT;
-	d_params.formatted = true;
-	d_params.fsyncs = false;
-	d_params.hsyncs = false;
-	d_params.frame_aligned = true;
+	if (cs_etm__init_decoder_params(&d_params, NULL,
+					CS_ETM_OPERATION_PRINT))
+		return;
 
 	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
@@ -436,13 +455,9 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-	d_params.packet_printer = cs_etm__packet_dump;
-	d_params.operation = CS_ETM_OPERATION_DECODE;
-	d_params.formatted = true;
-	d_params.fsyncs = false;
-	d_params.hsyncs = false;
-	d_params.frame_aligned = true;
-	d_params.data = etmq;
+	if (cs_etm__init_decoder_params(&d_params, etmq,
+					CS_ETM_OPERATION_DECODE))
+		goto out_free;
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-- 
2.19.1
