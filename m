From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/75] perf tools Documentation: Fix diverse typos
Date: Thu,  6 Dec 2018 18:25:26 -0300
Message-ID: <20181206212602.20474-40-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease cherry
picking and/or backporting, split this into multiple patches.

In this particular case, it affects documentation, so may be interesting
to cherry pick as it is information that is presented to the user.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt   | 2 +-
 tools/perf/Documentation/perf-report.txt | 2 +-
 tools/perf/Documentation/perf-stat.txt   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 667c14e56031..138fb6e94b3c 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -172,7 +172,7 @@ like cycles and instructions and some software events.
 Other PMUs and global measurements are normally root only.
 Some event qualifiers, such as "any", are also root only.
 
-This can be overriden by setting the kernel.perf_event_paranoid
+This can be overridden by setting the kernel.perf_event_paranoid
 sysctl to -1, which allows non root to use these events.
 
 For accessing trace point events perf needs to have read access to
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index ed2bf37ab132..1a27bfe05039 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -252,7 +252,7 @@ OPTIONS
 	          Usually more convenient to use --branch-history for this.
 
 	value can be:
-	- percent: diplay overhead percent (default)
+	- percent: display overhead percent (default)
 	- period: display event period
 	- count: display event count
 
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index b10a90b6a718..4bc2085e5197 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -50,7 +50,7 @@ report::
 	  /sys/bus/event_source/devices/<pmu>/format/*
 
 	Note that the last two syntaxes support prefix and glob matching in
-	the PMU name to simplify creation of events accross multiple instances
+	the PMU name to simplify creation of events across multiple instances
 	of the same type of PMU in large systems (e.g. memory controller PMUs).
 	Multiple PMU instances are typical for uncore PMUs, so the prefix
 	'uncore_' is also ignored when performing this match.
@@ -277,7 +277,7 @@ echo 0 > /proc/sys/kernel/nmi_watchdog
 for best results. Otherwise the bottlenecks may be inconsistent
 on workload with changing phases.
 
-This enables --metric-only, unless overriden with --no-metric-only.
+This enables --metric-only, unless overridden with --no-metric-only.
 
 To interpret the results it is usually needed to know on which
 CPUs the workload runs on. If needed the CPUs can be forced using
-- 
2.19.2
