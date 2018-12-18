From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/63] perf cs-etm: Treat NO_SYNC element as trace discontinuity
Date: Tue, 18 Dec 2018 19:07:01 -0300
Message-ID: <20181218220733.15839-32-acme@kernel.org>
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

The CoreSight tracer driver might insert barrier packets between
different buffers, thus the decoder can spot the boundaries based on the
barrier packet; it is possible for the decoder to hit a barrier packet
and emit a NO_SYNC element, then the decoder will find a periodic
synchronisation point inside that next trace block that starts the trace
again but does not have the TRACE_ON element as indicator - usually
because this trace block has wrapped the buffer so we have lost the
original point when the trace was enabled.

In the first case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
in the middle of the tracing stream, but as we were not handling the
NO_SYNC element properly this ends up making users miss the
discontinuity indications.

Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
output from the decoder, both indicate that the trace data is
discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as a trace
discontinuity and generates a CS_ETM_DISCONTINUITY packet for it, so
cs-etm can handle the discontinuity for this case, finally it saves the
last trace data for the previous trace block and restart samples for the
new block.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-7-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 1039f364f4cc..bee026e76a4c 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -410,7 +410,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
-		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
 		resp = cs_etm_decoder__buffer_discontinuity(decoder,
 							    trace_chan_id);
-- 
2.19.2
