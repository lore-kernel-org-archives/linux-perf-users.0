From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/44] perf evsel: Support printing evsel name for 'duration_time'
Date: Tue,  2 Apr 2019 13:05:14 -0300
Message-ID: <20190402160549.13544-10-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Implement printing the correct name for duration_time

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190326221823.11518-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66d066f18b5b..84cfb9fe2fc6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -580,6 +580,12 @@ static int perf_evsel__raw_name(struct perf_evsel *evsel, char *bf, size_t size)
 	return ret + perf_evsel__add_modifiers(evsel, bf + ret, size - ret);
 }
 
+static int perf_evsel__tool_name(char *bf, size_t size)
+{
+	int ret = scnprintf(bf, size, "duration_time");
+	return ret;
+}
+
 const char *perf_evsel__name(struct perf_evsel *evsel)
 {
 	char bf[128];
@@ -601,7 +607,10 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
 		break;
 
 	case PERF_TYPE_SOFTWARE:
-		perf_evsel__sw_name(evsel, bf, sizeof(bf));
+		if (evsel->tool_event)
+			perf_evsel__tool_name(bf, sizeof(bf));
+		else
+			perf_evsel__sw_name(evsel, bf, sizeof(bf));
 		break;
 
 	case PERF_TYPE_TRACEPOINT:
-- 
2.20.1
