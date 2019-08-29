From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/37] libperf: Add 'union perf_event' to perf/event.h
Date: Thu, 29 Aug 2019 11:39:12 -0300
Message-ID: <20190829143917.29745-33-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So it's available for libperf's users.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-22-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 36 +++++++++++++++++++++++++++++
 tools/perf/util/event.h             | 36 -----------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ef7a46e82a6d..a5b08ef118a7 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -323,4 +323,40 @@ struct compressed_event {
 	char			 data[];
 };
 
+union perf_event {
+	struct perf_event_header	header;
+	struct perf_record_mmap		mmap;
+	struct perf_record_mmap2	mmap2;
+	struct perf_record_comm		comm;
+	struct perf_record_namespaces	namespaces;
+	struct perf_record_fork		fork;
+	struct perf_record_lost		lost;
+	struct perf_record_lost_samples	lost_samples;
+	struct perf_record_read		read;
+	struct perf_record_throttle	throttle;
+	struct perf_record_sample	sample;
+	struct perf_record_bpf_event	bpf;
+	struct perf_record_ksymbol	ksymbol;
+	struct attr_event		attr;
+	struct event_update_event	event_update;
+	struct event_type_event		event_type;
+	struct tracing_data_event	tracing_data;
+	struct build_id_event		build_id;
+	struct id_index_event		id_index;
+	struct auxtrace_info_event	auxtrace_info;
+	struct auxtrace_event		auxtrace;
+	struct auxtrace_error_event	auxtrace_error;
+	struct aux_event		aux;
+	struct itrace_start_event	itrace_start;
+	struct context_switch_event	context_switch;
+	struct thread_map_event		thread_map;
+	struct cpu_map_event		cpu_map;
+	struct stat_config_event	stat_config;
+	struct stat_event		stat;
+	struct stat_round_event		stat_round;
+	struct time_conv_event		time_conv;
+	struct feature_event		feat;
+	struct compressed_event		pack;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ee2ee23e4c46..e15eed53ce90 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,42 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-union perf_event {
-	struct perf_event_header	header;
-	struct perf_record_mmap		mmap;
-	struct perf_record_mmap2	mmap2;
-	struct perf_record_comm		comm;
-	struct perf_record_namespaces	namespaces;
-	struct perf_record_fork		fork;
-	struct perf_record_lost		lost;
-	struct perf_record_lost_samples	lost_samples;
-	struct perf_record_read		read;
-	struct perf_record_throttle	throttle;
-	struct perf_record_sample	sample;
-	struct perf_record_bpf_event	bpf;
-	struct perf_record_ksymbol	ksymbol;
-	struct attr_event		attr;
-	struct event_update_event	event_update;
-	struct event_type_event		event_type;
-	struct tracing_data_event	tracing_data;
-	struct build_id_event		build_id;
-	struct id_index_event		id_index;
-	struct auxtrace_info_event	auxtrace_info;
-	struct auxtrace_event		auxtrace;
-	struct auxtrace_error_event	auxtrace_error;
-	struct aux_event		aux;
-	struct itrace_start_event	itrace_start;
-	struct context_switch_event	context_switch;
-	struct thread_map_event		thread_map;
-	struct cpu_map_event		cpu_map;
-	struct stat_config_event	stat_config;
-	struct stat_event		stat;
-	struct stat_round_event		stat_round;
-	struct time_conv_event		time_conv;
-	struct feature_event		feat;
-	struct compressed_event		pack;
-};
-
 void perf_event__print_totals(void);
 
 struct perf_tool;
-- 
2.21.0
