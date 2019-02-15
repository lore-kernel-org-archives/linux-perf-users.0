From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/43] perf cs-etm: Modularize main decoder function
Date: Thu, 14 Feb 2019 21:45:29 -0300
Message-ID: <20190215004539.23571-34-acme@kernel.org>
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

Making the main decoder block modular so that it can be called from
different decoding context (timeless vs. non-timeless), avoiding
to repeat code.

No change in functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-12-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d2c90b369e7c..cfa686fe223e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1491,9 +1491,36 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
+{
+	int ret = 0;
+	size_t processed = 0;
+
+	/*
+	 * Packets are decoded and added to the decoder's packet queue
+	 * until the decoder packet processing callback has requested that
+	 * processing stops or there is nothing left in the buffer.  Normal
+	 * operations that stop processing are a timestamp packet or a full
+	 * decoder buffer queue.
+	 */
+	ret = cs_etm_decoder__process_data_block(etmq->decoder,
+						 etmq->offset,
+						 &etmq->buf[etmq->buf_used],
+						 etmq->buf_len,
+						 &processed);
+	if (ret)
+		goto out;
+
+	etmq->offset += processed;
+	etmq->buf_used += processed;
+	etmq->buf_len -= processed;
+
+out:
+	return ret;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	size_t processed;
 	int err = 0;
 
 	/* Go through each buffer in the queue and decode them one by one */
@@ -1513,20 +1540,10 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 		/* Run trace decoder until buffer consumed or end of trace */
 		do {
-			processed = 0;
-			err = cs_etm_decoder__process_data_block(
-				etmq->decoder,
-				etmq->offset,
-				&etmq->buf[etmq->buf_used],
-				etmq->buf_len,
-				&processed);
+			err = cs_etm__decode_data_block(etmq);
 			if (err)
 				return err;
 
-			etmq->offset += processed;
-			etmq->buf_used += processed;
-			etmq->buf_len -= processed;
-
 			/* Process each packet in this chunk */
 			while (1) {
 				err = cs_etm_decoder__get_packet(etmq->decoder,
-- 
2.19.1
