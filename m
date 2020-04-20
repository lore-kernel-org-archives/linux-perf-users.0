From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/60] perf intel-bts: Implement ->evsel_is_auxtrace() callback
Date: Mon, 20 Apr 2020 08:52:43 -0300
Message-ID: <20200420115316.18781-28-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-bts.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 34cb380d19a3..059e1c805ed0 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -728,6 +728,15 @@ static void intel_bts_free(struct perf_session *session)
 	free(bts);
 }
 
+static bool intel_bts_evsel_is_auxtrace(struct perf_session *session,
+					struct evsel *evsel)
+{
+	struct intel_bts *bts = container_of(session->auxtrace, struct intel_bts,
+					     auxtrace);
+
+	return evsel->core.attr.type == bts->pmu_type;
+}
+
 struct intel_bts_synth {
 	struct perf_tool dummy_tool;
 	struct perf_session *session;
@@ -883,6 +892,7 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	bts->auxtrace.flush_events = intel_bts_flush;
 	bts->auxtrace.free_events = intel_bts_free_events;
 	bts->auxtrace.free = intel_bts_free;
+	bts->auxtrace.evsel_is_auxtrace = intel_bts_evsel_is_auxtrace;
 	session->auxtrace = &bts->auxtrace;
 
 	intel_bts_print_info(&auxtrace_info->priv[0], INTEL_BTS_PMU_TYPE,
-- 
2.21.1
