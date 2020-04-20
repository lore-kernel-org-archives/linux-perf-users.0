From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/60] perf arm-spe: Implement ->evsel_is_auxtrace() callback
Date: Mon, 20 Apr 2020 08:52:44 -0300
Message-ID: <20200420115316.18781-29-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/arm-spe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 53be12b23ff4..875a0dd540e5 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -176,6 +176,14 @@ static void arm_spe_free(struct perf_session *session)
 	free(spe);
 }
 
+static bool arm_spe_evsel_is_auxtrace(struct perf_session *session,
+				      struct evsel *evsel)
+{
+	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe, auxtrace);
+
+	return evsel->core.attr.type == spe->pmu_type;
+}
+
 static const char * const arm_spe_info_fmts[] = {
 	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
 };
@@ -218,6 +226,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->auxtrace.flush_events = arm_spe_flush;
 	spe->auxtrace.free_events = arm_spe_free_events;
 	spe->auxtrace.free = arm_spe_free;
+	spe->auxtrace.evsel_is_auxtrace = arm_spe_evsel_is_auxtrace;
 	session->auxtrace = &spe->auxtrace;
 
 	arm_spe_print_info(&auxtrace_info->priv[0]);
-- 
2.21.1
