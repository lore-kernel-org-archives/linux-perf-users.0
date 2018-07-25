From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/27] perf cs-etm: Bail out immediately for instruction sample failure
Date: Wed, 25 Jul 2018 14:59:38 -0300
Message-ID: <20180725180001.15108-5-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Mike Leach <mike.leach@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Robert Walker <robert.walker@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

If the instruction sample failure has happened, it isn't necessary to
execute to the end of the function cs_etm__flush().  This commit is to
bail out immediately and return the error code.

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
Link: http://lkml.kernel.org/r/1529298599-3876-3-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 822ba915d144..8b2c099e750a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -939,6 +939,9 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 		err = cs_etm__synth_instruction_sample(
 			etmq, addr,
 			etmq->period_instructions);
+		if (err)
+			return err;
+
 		etmq->period_instructions = 0;
 
 		/*
-- 
2.14.4
