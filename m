From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/21] perf cs-etm: Fix start tracing packet handling
Date: Wed,  1 Aug 2018 18:36:39 -0300
Message-ID: <20180801213648.4814-13-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Mike Leach <mike.leach@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Robert Walker <robert.walker@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Usually the start tracing packet is a CS_ETM_TRACE_ON packet, this
packet is passed to cs_etm__flush();  cs_etm__flush() will check the
condition 'prev_packet->sample_type == CS_ETM_RANGE' but 'prev_packet'
is allocated by zalloc() so 'prev_packet->sample_type' is zero in
initialization and this condition is false.  So cs_etm__flush() will
directly bail out without handling the start tracing packet.

This patch is to introduce a new sample type CS_ETM_EMPTY, which is used
to indicate the packet is an empty packet.  cs_etm__flush() will swap
packets when it finds the previous packet is empty, so this can record
the start tracing packet into 'etmq->prev_packet'.

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
Link: http://lkml.kernel.org/r/1531295145-596-4-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 743f5f444304..612b5755f742 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,6 +23,7 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
+	CS_ETM_EMPTY = 0,
 	CS_ETM_RANGE = 1 << 0,
 	CS_ETM_TRACE_ON = 1 << 1,
 };
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b2c099e750a..ae7c9c880cb2 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -924,8 +924,14 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	int err = 0;
 	struct cs_etm_packet *tmp;
 
+	if (!etmq->prev_packet)
+		return 0;
+
+	/* Handle start tracing packet */
+	if (etmq->prev_packet->sample_type == CS_ETM_EMPTY)
+		goto swap_packet;
+
 	if (etmq->etm->synth_opts.last_branch &&
-	    etmq->prev_packet &&
 	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
 		/*
 		 * Generate a last branch event for the branches left in the
@@ -944,6 +950,10 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 
 		etmq->period_instructions = 0;
 
+	}
+
+swap_packet:
+	if (etmq->etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
@@ -1023,6 +1033,13 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					cs_etm__flush(etmq);
 					break;
+				case CS_ETM_EMPTY:
+					/*
+					 * Should not receive empty packet,
+					 * report error.
+					 */
+					pr_err("CS ETM Trace: empty packet\n");
+					return -EINVAL;
 				default:
 					break;
 				}
-- 
2.14.4
