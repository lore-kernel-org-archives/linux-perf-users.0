From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 3/4] perf, tools: Support name for duration_time
Date: Tue, 26 Mar 2019 15:18:22 -0700
Message-ID: <20190326221823.11518-4-andi@firstfloor.org>
References: <20190326221823.11518-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326221823.11518-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Implement printing the correct name for duration_time

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evsel.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7835e05f0c0a..6872394b6f55 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -579,6 +579,12 @@ static int perf_evsel__raw_name(struct perf_evsel *evsel, char *bf, size_t size)
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
@@ -600,7 +606,10 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
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
