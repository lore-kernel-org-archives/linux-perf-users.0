From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/25] perf: cs-etm: Optimize option setup for CPU-wide sessions
Date: Fri, 21 Jun 2019 14:38:08 -0300
Message-ID: <20190621173831.13780-3-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Call function cs_etm_set_option() once with all relevant options set
rather than multiple times to avoid going through the list of CPU more
than once.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190611204528.20093-1-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 279c69caef91..c6f1ab5499b5 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -162,20 +162,19 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 		    !cpu_map__has(online_cpus, i))
 			continue;
 
-		switch (option) {
-		case ETM_OPT_CTXTID:
+		if (option & ETM_OPT_CTXTID) {
 			err = cs_etm_set_context_id(itr, evsel, i);
 			if (err)
 				goto out;
-			break;
-		case ETM_OPT_TS:
+		}
+		if (option & ETM_OPT_TS) {
 			err = cs_etm_set_timestamp(itr, evsel, i);
 			if (err)
 				goto out;
-			break;
-		default:
-			goto out;
 		}
+		if (option & ~(ETM_OPT_CTXTID | ETM_OPT_TS))
+			/* Nothing else is currently supported */
+			goto out;
 	}
 
 	err = 0;
@@ -398,11 +397,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (!cpu_map__empty(cpus)) {
 		perf_evsel__set_sample_bit(cs_etm_evsel, CPU);
 
-		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
-		if (err)
-			goto out;
-
-		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS);
+		err = cs_etm_set_option(itr, cs_etm_evsel,
+					ETM_OPT_CTXTID | ETM_OPT_TS);
 		if (err)
 			goto out;
 	}
-- 
2.20.1
