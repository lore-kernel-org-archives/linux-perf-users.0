From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/53] perf cs-etm: Add exception number in exception packet
Date: Wed,  6 Feb 2019 15:48:49 -0300
Message-ID: <20190206184903.24054-40-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>, Suzuki K Poulouse <suzuki.poulose@arm.com>, coresight ml <coresight@lists.linaro.org>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

When an exception packet comes, it contains the information for
exception number; the exception number indicates the exception types, so
from it we can know if the exception is taken for interrupt, system call
or other traps, etc.

This patch simply adds a field in cs_etm_packet struct, it records
exception number for exception packet that will then be used to properly
identify exception types to the perf synthesize mechanic.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190129122842.32041-5-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 +++++++++++++++----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e98ee49a1527..294efa76c9e3 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -294,6 +294,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].last_instr_subtype = 0;
 		decoder->packet_buffer[i].last_instr_cond = 0;
 		decoder->packet_buffer[i].flags = 0;
+		decoder->packet_buffer[i].exception_number = UINT32_MAX;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].last_instr_subtype = 0;
 	decoder->packet_buffer[et].last_instr_cond = 0;
 	decoder->packet_buffer[et].flags = 0;
+	decoder->packet_buffer[et].exception_number = UINT32_MAX;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -406,10 +408,20 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
-{
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_EXCEPTION);
+{	int ret = 0;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_EXCEPTION);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+	packet->exception_number = elem->exception_number;
+
+	return ret;
 }
 
 static ocsd_datapath_resp_t
@@ -443,7 +455,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(decoder,
+		resp = cs_etm_decoder__buffer_exception(decoder, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 23600e57a215..012b4728a46f 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -46,6 +46,7 @@ struct cs_etm_packet {
 	u32 last_instr_type;
 	u32 last_instr_subtype;
 	u32 flags;
+	u32 exception_number;
 	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
-- 
2.20.1
