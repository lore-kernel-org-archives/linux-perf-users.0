From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/18] perf intel-pt: Add more event information to debug log
Date: Tue,  6 Nov 2018 09:06:08 -0300
Message-ID: <20181106120612.8262-15-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

More event information is useful for debugging, especially MMAP events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20181105073505.8129-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-log.c |  5 +++++
 tools/perf/util/intel-pt-decoder/intel-pt-log.h |  1 +
 tools/perf/util/intel-pt.c                      | 16 +++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
index e02bc7b166a0..5e64da270f97 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
@@ -31,6 +31,11 @@ static FILE *f;
 static char log_name[MAX_LOG_NAME];
 bool intel_pt_enable_logging;
 
+void *intel_pt_log_fp(void)
+{
+	return f;
+}
+
 void intel_pt_log_enable(void)
 {
 	intel_pt_enable_logging = true;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.h b/tools/perf/util/intel-pt-decoder/intel-pt-log.h
index 45b64f93f358..cc084937f701 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.h
@@ -22,6 +22,7 @@
 
 struct intel_pt_pkt;
 
+void *intel_pt_log_fp(void);
 void intel_pt_log_enable(void);
 void intel_pt_log_disable(void);
 void intel_pt_log_set_name(const char *name);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 86cc9a64e982..149ff361ca78 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -206,6 +206,16 @@ static void intel_pt_dump_event(struct intel_pt *pt, unsigned char *buf,
 	intel_pt_dump(pt, buf, len);
 }
 
+static void intel_pt_log_event(union perf_event *event)
+{
+	FILE *f = intel_pt_log_fp();
+
+	if (!intel_pt_enable_logging || !f)
+		return;
+
+	perf_event__fprintf(event, f);
+}
+
 static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
 				   struct auxtrace_buffer *b)
 {
@@ -2010,9 +2020,9 @@ static int intel_pt_process_event(struct perf_session *session,
 		 event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
 		err = intel_pt_context_switch(pt, event, sample);
 
-	intel_pt_log("event %s (%u): cpu %d time %"PRIu64" tsc %#"PRIx64"\n",
-		     perf_event__name(event->header.type), event->header.type,
-		     sample->cpu, sample->time, timestamp);
+	intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",
+		     event->header.type, sample->cpu, sample->time, timestamp);
+	intel_pt_log_event(event);
 
 	return err;
 }
-- 
2.14.4
