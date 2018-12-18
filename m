From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/63] perf cs-etm: Remove unused 'trace_on' in cs_etm_decoder
Date: Tue, 18 Dec 2018 19:06:58 -0300
Message-ID: <20181218220733.15839-29-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mike Leach <mike.leach@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Robert Walker <robert.walker@arm.com>, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

cs_etm_decoder::trace_on is being assigned when TRACE_ON or NO_SYNC
element is coming, but it is never used hence it is redundant and can
be removed.

So let's remove 'trace_on' field from cs_etm_decoder struct.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-4-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 0b4c8629f578..97b39b1f5759 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -36,7 +36,6 @@
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
-	bool trace_on;
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
 	ocsd_datapath_resp_t prev_return;
@@ -411,12 +410,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
-		decoder->trace_on = false;
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
 		resp = cs_etm_decoder__buffer_trace_on(decoder,
 						       trace_chan_id);
-		decoder->trace_on = true;
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
 		resp = cs_etm_decoder__buffer_range(decoder, elem,
-- 
2.19.2
