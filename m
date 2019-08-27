From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/33] perf report: Use timestamp__scnprintf_nsec() for time sort key
Date: Mon, 26 Aug 2019 22:36:15 -0300
Message-ID: <20190827013634.3173-15-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Use timestamp__scnprintf_nsec() to print nanoseconds for the time sort
key, instead of open coding.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190823210338.12360-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index c522bdde3f71..83eb3fa6f941 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -670,17 +670,11 @@ sort__time_cmp(struct hist_entry *left, struct hist_entry *right)
 static int hist_entry__time_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
-	unsigned long secs;
-	unsigned long long nsecs;
 	char he_time[32];
 
-	nsecs = he->time;
-	secs = nsecs / NSEC_PER_SEC;
-	nsecs -= secs * NSEC_PER_SEC;
-
 	if (symbol_conf.nanosecs)
-		snprintf(he_time, sizeof he_time, "%5lu.%09llu: ",
-			 secs, nsecs);
+		timestamp__scnprintf_nsec(he->time, he_time,
+					  sizeof(he_time));
 	else
 		timestamp__scnprintf_usec(he->time, he_time,
 					  sizeof(he_time));
-- 
2.21.0
