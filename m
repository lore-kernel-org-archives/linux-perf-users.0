From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/23] perf intel-pt: Add Intel PT man page references
Date: Tue, 17 Mar 2020 18:32:52 -0300
Message-ID: <20200317213259.15494-17-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add references to Intel PT man page in man pages of associated tools.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200311122034.3697-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-inject.txt   | 3 ++-
 tools/perf/Documentation/perf-intel-pt.txt | 7 +++++++
 tools/perf/Documentation/perf-record.txt   | 2 +-
 tools/perf/Documentation/perf-report.txt   | 3 ++-
 tools/perf/Documentation/perf-script.txt   | 2 +-
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index a64d6588470e..70969ea73e01 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -66,4 +66,5 @@ include::itrace.txt[]
 
 SEE ALSO
 --------
-linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-archive[1]
+linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-archive[1],
+linkperf:perf-intel-pt[1]
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 7d743a98a9c1..456fdcbf26ac 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -998,3 +998,10 @@ Note that currently, software only supports redirecting at most one PEBS event.
 To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
 
 	perf script --itrace=oe
+
+
+SEE ALSO
+--------
+
+linkperf:perf-record[1], linkperf:perf-script[1], linkperf:perf-report[1],
+linkperf:perf-inject[1]
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b23a4012a606..7f4db7592467 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -589,4 +589,4 @@ appended unit character - B/K/M/G
 
 SEE ALSO
 --------
-linkperf:perf-stat[1], linkperf:perf-list[1]
+linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index db61f16ffa56..bd0a029d4c08 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -546,4 +546,5 @@ include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
 --------
-linkperf:perf-stat[1], linkperf:perf-annotate[1], linkperf:perf-record[1]
+linkperf:perf-stat[1], linkperf:perf-annotate[1], linkperf:perf-record[1],
+linkperf:perf-intel-pt[1]
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2599b057e47b..db6a36aac47e 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -429,4 +429,4 @@ include::itrace.txt[]
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
-linkperf:perf-script-python[1]
+linkperf:perf-script-python[1], linkperf:perf-intel-pt[1]
-- 
2.21.1
