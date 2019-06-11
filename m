From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/85] perf cs-etm: Configure timestamp generation in CPU-wide mode
Date: Tue, 11 Jun 2019 15:58:24 -0300
Message-ID: <20190611185911.11645-39-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

When operating in CPU-wide mode tracers need to generate timestamps in
order to correlate the code being traced on one CPU with what is executed
on other CPUs.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-3-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 57 +++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 3912f0bf04ed..be1e4f20affa 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -99,6 +99,54 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
 	return err;
 }
 
+static int cs_etm_set_timestamp(struct auxtrace_record *itr,
+				struct perf_evsel *evsel, int cpu)
+{
+	struct cs_etm_recording *ptr;
+	struct perf_pmu *cs_etm_pmu;
+	char path[PATH_MAX];
+	int err = -EINVAL;
+	u32 val;
+
+	ptr = container_of(itr, struct cs_etm_recording, itr);
+	cs_etm_pmu = ptr->cs_etm_pmu;
+
+	if (!cs_etm_is_etmv4(itr, cpu))
+		goto out;
+
+	/* Get a handle on TRCIRD0 */
+	snprintf(path, PATH_MAX, "cpu%d/%s",
+		 cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
+	err = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
+
+	/* There was a problem reading the file, bailing out */
+	if (err != 1) {
+		pr_err("%s: can't read file %s\n",
+		       CORESIGHT_ETM_PMU_NAME, path);
+		goto out;
+	}
+
+	/*
+	 * TRCIDR0.TSSIZE, bit [28-24], indicates whether global timestamping
+	 * is supported:
+	 *  0b00000 Global timestamping is not implemented
+	 *  0b00110 Implementation supports a maximum timestamp of 48bits.
+	 *  0b01000 Implementation supports a maximum timestamp of 64bits.
+	 */
+	val &= GENMASK(28, 24);
+	if (!val) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* All good, let the kernel know */
+	evsel->attr.config |= (1 << ETM_OPT_TS);
+	err = 0;
+
+out:
+	return err;
+}
+
 static int cs_etm_set_option(struct auxtrace_record *itr,
 			     struct perf_evsel *evsel, u32 option)
 {
@@ -118,6 +166,11 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 			if (err)
 				goto out;
 			break;
+		case ETM_OPT_TS:
+			err = cs_etm_set_timestamp(itr, evsel, i);
+			if (err)
+				goto out;
+			break;
 		default:
 			goto out;
 		}
@@ -343,6 +396,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
 		if (err)
 			goto out;
+
+		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS);
+		if (err)
+			goto out;
 	}
 
 	/* Add dummy event to keep tracking */
-- 
2.20.1
