From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 75/85] perf time-utils: Factor out set_percent_time()
Date: Tue, 11 Jun 2019 15:59:01 -0300
Message-ID: <20190611185911.11645-76-acme@kernel.org>
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

Factor out set_percent_time() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-14-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 39 +++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 1d67cf1216c7..69441faab3d0 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -135,12 +135,27 @@ static int parse_percent(double *pcnt, char *str)
 	return 0;
 }
 
+static int set_percent_time(struct perf_time_interval *ptime, double start_pcnt,
+			    double end_pcnt, u64 start, u64 end)
+{
+	u64 total = end - start;
+
+	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
+	    end_pcnt < 0.0 || end_pcnt > 1.0) {
+		return -1;
+	}
+
+	ptime->start = start + round(start_pcnt * total);
+	ptime->end = start + round(end_pcnt * total);
+
+	return 0;
+}
+
 static int percent_slash_split(char *str, struct perf_time_interval *ptime,
 			       u64 start, u64 end)
 {
 	char *p, *end_str;
 	double pcnt, start_pcnt, end_pcnt;
-	u64 total = end - start;
 	int i;
 
 	/*
@@ -168,15 +183,7 @@ static int percent_slash_split(char *str, struct perf_time_interval *ptime,
 	start_pcnt = pcnt * (i - 1);
 	end_pcnt = pcnt * i;
 
-	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
-	    end_pcnt < 0.0 || end_pcnt > 1.0) {
-		return -1;
-	}
-
-	ptime->start = start + round(start_pcnt * total);
-	ptime->end = start + round(end_pcnt * total);
-
-	return 0;
+	return set_percent_time(ptime, start_pcnt, end_pcnt, start, end);
 }
 
 static int percent_dash_split(char *str, struct perf_time_interval *ptime,
@@ -184,7 +191,6 @@ static int percent_dash_split(char *str, struct perf_time_interval *ptime,
 {
 	char *start_str = NULL, *end_str;
 	double start_pcnt, end_pcnt;
-	u64 total = end - start;
 	int ret;
 
 	/*
@@ -203,16 +209,7 @@ static int percent_dash_split(char *str, struct perf_time_interval *ptime,
 
 	free(start_str);
 
-	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
-	    end_pcnt < 0.0 || end_pcnt > 1.0 ||
-	    start_pcnt > end_pcnt) {
-		return -1;
-	}
-
-	ptime->start = start + round(start_pcnt * total);
-	ptime->end = start + round(end_pcnt * total);
-
-	return 0;
+	return set_percent_time(ptime, start_pcnt, end_pcnt, start, end);
 }
 
 typedef int (*time_pecent_split)(char *, struct perf_time_interval *,
-- 
2.20.1
