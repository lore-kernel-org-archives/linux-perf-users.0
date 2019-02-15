From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/43] perf cs-etm: Modularize main packet processing loop
Date: Thu, 14 Feb 2019 21:45:30 -0300
Message-ID: <20190215004539.23571-35-acme@kernel.org>
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

Making the main packet processing loop modular so that it can be called
from different decoding context (timeless vs. non-timless), avoiding to
repeat code.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-13-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 129 ++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index cfa686fe223e..f607bc58bd03 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1519,6 +1519,72 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 	return ret;
 }
 
+static int cs_etm__process_decoder_queue(struct cs_etm_queue *etmq)
+{
+	int ret;
+
+		/* Process each packet in this chunk */
+		while (1) {
+			ret = cs_etm_decoder__get_packet(etmq->decoder,
+							 etmq->packet);
+			if (ret <= 0)
+				/*
+				 * Stop processing this chunk on
+				 * end of data or error
+				 */
+				break;
+
+			/*
+			 * Since packet addresses are swapped in packet
+			 * handling within below switch() statements,
+			 * thus setting sample flags must be called
+			 * prior to switch() statement to use address
+			 * information before packets swapping.
+			 */
+			ret = cs_etm__set_sample_flags(etmq);
+			if (ret < 0)
+				break;
+
+			switch (etmq->packet->sample_type) {
+			case CS_ETM_RANGE:
+				/*
+				 * If the packet contains an instruction
+				 * range, generate instruction sequence
+				 * events.
+				 */
+				cs_etm__sample(etmq);
+				break;
+			case CS_ETM_EXCEPTION:
+			case CS_ETM_EXCEPTION_RET:
+				/*
+				 * If the exception packet is coming,
+				 * make sure the previous instruction
+				 * range packet to be handled properly.
+				 */
+				cs_etm__exception(etmq);
+				break;
+			case CS_ETM_DISCONTINUITY:
+				/*
+				 * Discontinuity in trace, flush
+				 * previous branch stack
+				 */
+				cs_etm__flush(etmq);
+				break;
+			case CS_ETM_EMPTY:
+				/*
+				 * Should not receive empty packet,
+				 * report error.
+				 */
+				pr_err("CS ETM Trace: empty packet\n");
+				return -EINVAL;
+			default:
+				break;
+			}
+		}
+
+	return ret;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	int err = 0;
@@ -1544,64 +1610,13 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 			if (err)
 				return err;
 
-			/* Process each packet in this chunk */
-			while (1) {
-				err = cs_etm_decoder__get_packet(etmq->decoder,
-								 etmq->packet);
-				if (err <= 0)
-					/*
-					 * Stop processing this chunk on
-					 * end of data or error
-					 */
-					break;
+			/*
+			 * Process each packet in this chunk, nothing to do if
+			 * an error occurs other than hoping the next one will
+			 * be better.
+			 */
+			err = cs_etm__process_decoder_queue(etmq);
 
-				/*
-				 * Since packet addresses are swapped in packet
-				 * handling within below switch() statements,
-				 * thus setting sample flags must be called
-				 * prior to switch() statement to use address
-				 * information before packets swapping.
-				 */
-				err = cs_etm__set_sample_flags(etmq);
-				if (err < 0)
-					break;
-
-				switch (etmq->packet->sample_type) {
-				case CS_ETM_RANGE:
-					/*
-					 * If the packet contains an instruction
-					 * range, generate instruction sequence
-					 * events.
-					 */
-					cs_etm__sample(etmq);
-					break;
-				case CS_ETM_EXCEPTION:
-				case CS_ETM_EXCEPTION_RET:
-					/*
-					 * If the exception packet is coming,
-					 * make sure the previous instruction
-					 * range packet to be handled properly.
-					 */
-					cs_etm__exception(etmq);
-					break;
-				case CS_ETM_DISCONTINUITY:
-					/*
-					 * Discontinuity in trace, flush
-					 * previous branch stack
-					 */
-					cs_etm__flush(etmq);
-					break;
-				case CS_ETM_EMPTY:
-					/*
-					 * Should not receive empty packet,
-					 * report error.
-					 */
-					pr_err("CS ETM Trace: empty packet\n");
-					return -EINVAL;
-				default:
-					break;
-				}
-			}
 		} while (etmq->buf_len);
 
 		if (err == 0)
-- 
2.19.1
