From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 63/85] perf auxtrace: Add perf time interval to itrace_synth_ops
Date: Tue, 11 Jun 2019 15:58:49 -0300
Message-ID: <20190611185911.11645-64-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Instruction trace decoders can optimize output based on what time
intervals will be filtered, so pass that information in
itrace_synth_ops.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index c69bcd9a3091..c80c58eb7f4d 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -83,6 +83,8 @@ enum itrace_period_type {
  * @period_type: 'instructions' events period type
  * @initial_skip: skip N events at the beginning.
  * @cpu_bitmap: CPUs for which to synthesize events, or NULL for all
+ * @ptime_range: time intervals to trace or NULL
+ * @range_num: number of time intervals to trace
  */
 struct itrace_synth_opts {
 	bool			set;
@@ -107,6 +109,8 @@ struct itrace_synth_opts {
 	enum itrace_period_type	period_type;
 	unsigned long		initial_skip;
 	unsigned long		*cpu_bitmap;
+	struct perf_time_interval *ptime_range;
+	int			range_num;
 };
 
 /**
@@ -599,6 +603,21 @@ static inline void auxtrace__free(struct perf_session *session)
 "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
 "				concatenate multiple options. Default is ibxwpe or cewp\n"
 
+static inline
+void itrace_synth_opts__set_time_range(struct itrace_synth_opts *opts,
+				       struct perf_time_interval *ptime_range,
+				       int range_num)
+{
+	opts->ptime_range = ptime_range;
+	opts->range_num = range_num;
+}
+
+static inline
+void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts)
+{
+	opts->ptime_range = NULL;
+	opts->range_num = 0;
+}
 
 #else
 
@@ -742,6 +761,21 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 
 #define ITRACE_HELP ""
 
+static inline
+void itrace_synth_opts__set_time_range(struct itrace_synth_opts *opts
+				       __maybe_unused,
+				       struct perf_time_interval *ptime_range
+				       __maybe_unused,
+				       int range_num __maybe_unused)
+{
+}
+
+static inline
+void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts
+					 __maybe_unused)
+{
+}
+
 #endif
 
 #endif
-- 
2.20.1
