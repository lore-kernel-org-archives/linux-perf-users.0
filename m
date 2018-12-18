From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/63] perf cs-etm: Generate branch sample for exception packet
Date: Tue, 18 Dec 2018 19:07:03 -0300
Message-ID: <20181218220733.15839-34-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mike Leach <mike.leach@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Robert Walker <robert.walker@arm.com>, coresight ml <coresight@lists.linaro.org>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The exception packet appears as one element with 'elem_type' ==
OCSD_GEN_TRC_ELEM_EXCEPTION or OCSD_GEN_TRC_ELEM_EXCEPTION_RET, which is
present for exception entry and exit respectively.  The decoder sets the
packet fields 'packet->exc' and 'packet->exc_ret' to indicate the
exception packets; but exception packets don't have a dedicated sample
type and shares the same sample type CS_ETM_RANGE with normal
instruction packets.

As a result, the exception packets are taken as normal instruction
packets and this introduces confusion in mixing different packet types.
Furthermore, these instruction range packets will be processed for
branch samples only when 'packet->last_instr_taken_branch' is true,
otherwise they will be omitted, this can introduce a mess for exception
and exception returning due to not having the complete address range
info for context switching.

To process exception packets properly, this patch introduces two new
sample types: CS_ETM_EXCEPTION and CS_ETM_EXCEPTION_RET; these two types
of packets will be handled by cs_etm__exception().  The function
cs_etm__exception() forces setting the previous CS_ETM_RANGE packet flag
'prev_packet->last_instr_taken_branch' to true, this matches well with
the program flow when the exception is trapped from user space to kernel
space, no matter if the most recent flow has branch taken or not; this
is also safe for returning to user space after exception handling.

After exception packets have their own sample type, the packet fields
'packet->exc' and 'packet->exc_ret' aren't needed anymore, so remove
them.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-9-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 26 +++++++++++++----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  4 +--
 tools/perf/util/cs-etm.c                      | 28 +++++++++++++++++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cda6f074bd03..8c155575c6c5 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -290,8 +290,6 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].instr_count = 0;
 		decoder->packet_buffer[i].last_instr_taken_branch = false;
 		decoder->packet_buffer[i].last_instr_size = 0;
-		decoder->packet_buffer[i].exc = false;
-		decoder->packet_buffer[i].exc_ret = false;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -319,8 +317,6 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 
 	decoder->packet_buffer[et].sample_type = sample_type;
 	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
-	decoder->packet_buffer[et].exc = false;
-	decoder->packet_buffer[et].exc_ret = false;
 	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
 	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
 	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
@@ -397,6 +393,22 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
 					     CS_ETM_DISCONTINUITY);
 }
 
+static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+				 const uint8_t trace_chan_id)
+{
+	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					     CS_ETM_EXCEPTION);
+}
+
+static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_exception_ret(struct cs_etm_decoder *decoder,
+				     const uint8_t trace_chan_id)
+{
+	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					     CS_ETM_EXCEPTION_RET);
+}
+
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 				const void *context,
 				const ocsd_trc_index_t indx __maybe_unused,
@@ -420,10 +432,12 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		decoder->packet_buffer[decoder->tail].exc = true;
+		resp = cs_etm_decoder__buffer_exception(decoder,
+							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
-		decoder->packet_buffer[decoder->tail].exc_ret = true;
+		resp = cs_etm_decoder__buffer_exception_ret(decoder,
+							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index a27231722e27..a6407d41598f 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -26,6 +26,8 @@ enum cs_etm_sample_type {
 	CS_ETM_EMPTY,
 	CS_ETM_RANGE,
 	CS_ETM_DISCONTINUITY,
+	CS_ETM_EXCEPTION,
+	CS_ETM_EXCEPTION_RET,
 };
 
 enum cs_etm_isa {
@@ -43,8 +45,6 @@ struct cs_etm_packet {
 	u32 instr_count;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
-	u8 exc;
-	u8 exc_ret;
 	int cpu;
 };
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index cea3158915d3..27a374ddf661 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1000,6 +1000,25 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static int cs_etm__exception(struct cs_etm_queue *etmq)
+{
+	/*
+	 * When the exception packet is inserted, whether the last instruction
+	 * in previous range packet is taken branch or not, we need to force
+	 * to set 'prev_packet->last_instr_taken_branch' to true.  This ensures
+	 * to generate branch sample for the instruction range before the
+	 * exception is trapped to kernel or before the exception returning.
+	 *
+	 * The exception packet includes the dummy address values, so don't
+	 * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be useful
+	 * for generating instruction and branch samples.
+	 */
+	if (etmq->prev_packet->sample_type == CS_ETM_RANGE)
+		etmq->prev_packet->last_instr_taken_branch = true;
+
+	return 0;
+}
+
 static int cs_etm__flush(struct cs_etm_queue *etmq)
 {
 	int err = 0;
@@ -1148,6 +1167,15 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					cs_etm__sample(etmq);
 					break;
+				case CS_ETM_EXCEPTION:
+				case CS_ETM_EXCEPTION_RET:
+					/*
+					 * If the exception packet is coming,
+					 * make sure the previous instruction
+					 * range packet to be handled properly.
+					 */
+					cs_etm__exception(etmq);
+					break;
 				case CS_ETM_DISCONTINUITY:
 					/*
 					 * Discontinuity in trace, flush
-- 
2.19.2
