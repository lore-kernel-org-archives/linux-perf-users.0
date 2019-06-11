From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 77/85] perf time-utils: Fix --time documentation
Date: Tue, 11 Jun 2019 15:59:03 -0300
Message-ID: <20190611185911.11645-78-acme@kernel.org>
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

Correct some punctuation and spelling and correct the format to show
that the time resolution is nanoseconds not microseconds.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-diff.txt   | 6 +++---
 tools/perf/Documentation/perf-report.txt | 6 +++---
 tools/perf/Documentation/perf-script.txt | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index da7809b15cc9..5732f69580ab 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -142,9 +142,9 @@ OPTIONS
 	  perf diff --time 0%-10%,30%-40%
 
 	It also supports analyzing samples within a given time window
-	<start>,<stop>. Times have the format seconds.microseconds. If 'start'
-	is not given (i.e., time string is ',x.y') then analysis starts at
-	the beginning of the file. If stop time is not given (i.e, time
+	<start>,<stop>. Times have the format seconds.nanoseconds. If 'start'
+	is not given (i.e. time string is ',x.y') then analysis starts at
+	the beginning of the file. If stop time is not given (i.e. time
 	string is 'x.y,') then analysis goes to the end of the file. Time string is
 	'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
 	perf.data files.
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index f441baa794ce..3de029f6881d 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -412,12 +412,12 @@ OPTIONS
 
 --time::
 	Only analyze samples within given time window: <start>,<stop>. Times
-	have the format seconds.microseconds. If start is not given (i.e., time
+	have the format seconds.nanoseconds. If start is not given (i.e. time
 	string is ',x.y') then analysis starts at the beginning of the file. If
-	stop time is not given (i.e, time string is 'x.y,') then analysis goes
+	stop time is not given (i.e. time string is 'x.y,') then analysis goes
 	to end of file.
 
-	Also support time percent with multiple time range. Time string is
+	Also support time percent with multiple time ranges. Time string is
 	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
 
 	For example:
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index c59fd52e9e91..878349cce968 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -361,12 +361,12 @@ include::itrace.txt[]
 
 --time::
 	Only analyze samples within given time window: <start>,<stop>. Times
-	have the format seconds.microseconds. If start is not given (i.e., time
+	have the format seconds.nanoseconds. If start is not given (i.e. time
 	string is ',x.y') then analysis starts at the beginning of the file. If
-	stop time is not given (i.e, time string is 'x.y,') then analysis goes
+	stop time is not given (i.e. time string is 'x.y,') then analysis goes
 	to end of file.
 
-	Also support time percent with multipe time range. Time string is
+	Also support time percent with multiple time ranges. Time string is
 	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
 
 	For example:
-- 
2.20.1
