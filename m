From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/32] perf util: Improve error checking for time percent input
Date: Wed, 17 Jan 2018 13:12:16 -0300
Message-ID: <20180117161222.15611-27-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The command line like 'perf report --stdio --time 1abc%/1' could be
accepted by perf. It looks not very good.

This patch uses strtod() to replace original atof() and check the entire
string. Now for the same command line, it would return error message
"Invalid time string".

root@skl:/tmp# perf report --stdio --time 1abc%/1
Invalid time string

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1515596433-24653-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 3f7f18f06982..88510ab6450e 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -116,7 +116,8 @@ int perf_time__parse_str(struct perf_time_interval *ptime, const char *ostr)
 
 static int parse_percent(double *pcnt, char *str)
 {
-	char *c;
+	char *c, *endptr;
+	double d;
 
 	c = strchr(str, '%');
 	if (c)
@@ -124,8 +125,11 @@ static int parse_percent(double *pcnt, char *str)
 	else
 		return -1;
 
-	*pcnt = atof(str) / 100.0;
+	d = strtod(str, &endptr);
+	if (endptr != str + strlen(str))
+		return -1;
 
+	*pcnt = d / 100.0;
 	return 0;
 }
 
-- 
2.14.3
