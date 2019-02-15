From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/43] perf cs-etm: Fix erroneous comment
Date: Thu, 14 Feb 2019 21:45:25 -0300
Message-ID: <20190215004539.23571-30-acme@kernel.org>
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

The comment just before initialising the decoder is plane wrong since it
is part of the decoding queue setup function and the operation code
specifically mention that trace data is to be decoded rather than printed
out.

This patch simply fix the comment to prevent people from getting really
confused.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-8-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f3a6dfaf3026..4cc9fce97a86 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -459,7 +459,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (cs_etm__init_trace_params(t_params, etm))
 		goto out_free;
 
-	/* Set decoder parameters to simply print the trace packets */
+	/* Set decoder parameters to decode trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
 					CS_ETM_OPERATION_DECODE))
 		goto out_free;
-- 
2.19.1
