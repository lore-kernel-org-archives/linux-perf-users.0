From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/30] perf script: Fix --per-event-dump for auxtrace synth evsels
Date: Tue, 28 Nov 2017 12:01:56 -0300
Message-ID: <20171128150220.5064-7-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, yuzhoujian <yuzhoujian@didichuxing.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When processing PERF_RECORD_AUXTRACE_INFO several perf_evsel entries
will be synthesized and inserted into session->evlist, eventually ending
in perf_script.tool.sample(), which ends up calling builtin-script.c's
process_event(), that expects evsel->priv to be a perf_evsel_script
object with a valid FILE pointer in fp.

So we need to intercept the processing of PERF_RECORD_AUXTRACE_INFO and
then setup evsel->priv for these newly created perf_evsel instances, do
it to fix the segfault in process_event() trying to use a NULL for that
FILE pointer.

Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: yuzhoujian <yuzhoujian@didichuxing.com>
Fixes: a14390fde64e ("perf script: Allow creating per-event dump files")
Link: http://lkml.kernel.org/n/tip-bthnur8r8de01gxvn2qayx6e@git.kernel.org
[ Merge fix by Ravi Bangoria before pushing upstream to preserv bisectability ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 68f36dc0344f..9b43bda45a41 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1955,6 +1955,16 @@ static int perf_script__fopen_per_event_dump(struct perf_script *script)
 	struct perf_evsel *evsel;
 
 	evlist__for_each_entry(script->session->evlist, evsel) {
+		/*
+		 * Already setup? I.e. we may be called twice in cases like
+		 * Intel PT, one for the intel_pt// and dummy events, then
+		 * for the evsels syntheized from the auxtrace info.
+		 *
+		 * Ses perf_script__process_auxtrace_info.
+		 */
+		if (evsel->priv != NULL)
+			continue;
+
 		evsel->priv = perf_evsel_script__new(evsel, script->session->data);
 		if (evsel->priv == NULL)
 			goto out_err_fclose;
@@ -2838,6 +2848,25 @@ int process_cpu_map_event(struct perf_tool *tool __maybe_unused,
 	return set_maps(script);
 }
 
+#ifdef HAVE_AUXTRACE_SUPPORT
+static int perf_script__process_auxtrace_info(struct perf_tool *tool,
+					      union perf_event *event,
+					      struct perf_session *session)
+{
+	int ret = perf_event__process_auxtrace_info(tool, event, session);
+
+	if (ret == 0) {
+		struct perf_script *script = container_of(tool, struct perf_script, tool);
+
+		ret = perf_script__setup_per_event_dump(script);
+	}
+
+	return ret;
+}
+#else
+#define perf_script__process_auxtrace_info 0
+#endif
+
 int cmd_script(int argc, const char **argv)
 {
 	bool show_full_info = false;
@@ -2866,7 +2895,7 @@ int cmd_script(int argc, const char **argv)
 			.feature	 = perf_event__process_feature,
 			.build_id	 = perf_event__process_build_id,
 			.id_index	 = perf_event__process_id_index,
-			.auxtrace_info	 = perf_event__process_auxtrace_info,
+			.auxtrace_info	 = perf_script__process_auxtrace_info,
 			.auxtrace	 = perf_event__process_auxtrace,
 			.auxtrace_error	 = perf_event__process_auxtrace_error,
 			.stat		 = perf_event__process_stat_event,
-- 
2.13.6
