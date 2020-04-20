From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/60] perf s390-cpumsf: Implement ->evsel_is_auxtrace() callback
Date: Mon, 20 Apr 2020 08:52:46 -0300
Message-ID: <20200420115316.18781-31-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-cpumcf-kernel.h | 1 +
 tools/perf/util/s390-cpumsf.c        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
index d4356030b504..f55ca07f3ca1 100644
--- a/tools/perf/util/s390-cpumcf-kernel.h
+++ b/tools/perf/util/s390-cpumcf-kernel.h
@@ -11,6 +11,7 @@
 
 #define	S390_CPUMCF_DIAG_DEF	0xfeef	/* Counter diagnostic entry ID */
 #define	PERF_EVENT_CPUM_CF_DIAG	0xBC000	/* Event: Counter sets */
+#define PERF_EVENT_CPUM_SF_DIAG	0xBD000 /* Event: Combined-sampling */
 
 struct cf_ctrset_entry {	/* CPU-M CF counter set entry (8 byte) */
 	unsigned int def:16;	/* 0-15  Data Entry Format */
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6785cd87aa4d..d7779e48652f 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1047,6 +1047,14 @@ static void s390_cpumsf_free(struct perf_session *session)
 	free(sf);
 }
 
+static bool
+s390_cpumsf_evsel_is_auxtrace(struct perf_session *session __maybe_unused,
+			      struct evsel *evsel)
+{
+	return evsel->core.attr.type == PERF_TYPE_RAW &&
+	       evsel->core.attr.config == PERF_EVENT_CPUM_SF_DIAG;
+}
+
 static int s390_cpumsf_get_type(const char *cpuid)
 {
 	int ret, family = 0;
@@ -1142,6 +1150,7 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	sf->auxtrace.flush_events = s390_cpumsf_flush;
 	sf->auxtrace.free_events = s390_cpumsf_free_events;
 	sf->auxtrace.free = s390_cpumsf_free;
+	sf->auxtrace.evsel_is_auxtrace = s390_cpumsf_evsel_is_auxtrace;
 	session->auxtrace = &sf->auxtrace;
 
 	if (dump_trace)
-- 
2.21.1
