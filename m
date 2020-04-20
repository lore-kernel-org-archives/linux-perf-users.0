From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/60] perf intel-pt: Implement ->evsel_is_auxtrace() callback
Date: Mon, 20 Apr 2020 08:52:42 -0300
Message-ID: <20200420115316.18781-27-acme@kernel.org>
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
Link: http://lore.kernel.org/lkml/20200401101613.6201-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 23c8289c2472..db25c77d82f3 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2715,6 +2715,15 @@ static void intel_pt_free(struct perf_session *session)
 	free(pt);
 }
 
+static bool intel_pt_evsel_is_auxtrace(struct perf_session *session,
+				       struct evsel *evsel)
+{
+	struct intel_pt *pt = container_of(session->auxtrace, struct intel_pt,
+					   auxtrace);
+
+	return evsel->core.attr.type == pt->pmu_type;
+}
+
 static int intel_pt_process_auxtrace_event(struct perf_session *session,
 					   union perf_event *event,
 					   struct perf_tool *tool __maybe_unused)
@@ -3310,6 +3319,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	pt->auxtrace.flush_events = intel_pt_flush;
 	pt->auxtrace.free_events = intel_pt_free_events;
 	pt->auxtrace.free = intel_pt_free;
+	pt->auxtrace.evsel_is_auxtrace = intel_pt_evsel_is_auxtrace;
 	session->auxtrace = &pt->auxtrace;
 
 	if (dump_trace)
-- 
2.21.1
