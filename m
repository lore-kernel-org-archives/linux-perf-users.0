From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/21] perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON packet
Date: Wed,  1 Aug 2018 18:36:41 -0300
Message-ID: <20180801213648.4814-15-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Mike Leach <mike.leach@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Robert Walker <robert.walker@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

If one CS_ETM_TRACE_ON packet is inserted, we miss to generate branch
sample for the previous CS_ETM_RANGE packet.

This patch is to generate branch sample when receiving a CS_ETM_TRACE_ON
packet, so this can save complete info for the previous CS_ETM_RANGE
packet just before CS_ETM_TRACE_ON packet.

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
Link: http://lkml.kernel.org/r/1531295145-596-6-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 976db8483478..d3b794286bca 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -935,6 +935,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 static int cs_etm__flush(struct cs_etm_queue *etmq)
 {
 	int err = 0;
+	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet *tmp;
 
 	if (!etmq->prev_packet)
@@ -965,6 +966,13 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 
 	}
 
+	if (etm->sample_branches &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+		err = cs_etm__synth_branch_sample(etmq);
+		if (err)
+			return err;
+	}
+
 swap_packet:
 	if (etmq->etm->synth_opts.last_branch) {
 		/*
-- 
2.14.4
