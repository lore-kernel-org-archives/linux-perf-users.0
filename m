From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/66] perf vendor events: Minor fixes to the README
Date: Wed, 25 Sep 2019 21:31:43 -0300
Message-ID: <20190926003244.13962-6-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Borislav Petkov <bp@suse.de>, Janakarajan Natarajan <janakarajan.natarajan@amd.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Luke Mujica <lukemujica@google.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

Some grammatical fixes, and updates to some path references that have
since changed.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Janakarajan Natarajan <janakarajan.natarajan@amd.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190919204306.12598-3-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/README | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index e62b09b6a844..de7efa2cebd1 100644
--- a/tools/perf/pmu-events/README
+++ b/tools/perf/pmu-events/README
@@ -30,9 +30,9 @@ the topic. Eg: "Floating-point.json".
 All the topic JSON files for a CPU model/family should be in a separate
 sub directory. Thus for the Silvermont X86 CPU:
 
-	$ ls tools/perf/pmu-events/arch/x86/Silvermont_core
-	Cache.json 	Memory.json 	Virtual-Memory.json
-	Frontend.json 	Pipeline.json
+	$ ls tools/perf/pmu-events/arch/x86/silvermont
+	cache.json     memory.json    virtual-memory.json
+	frontend.json  pipeline.json
 
 The JSONs folder for a CPU model/family may be placed in the root arch
 folder, or may be placed in a vendor sub-folder under the arch folder
@@ -94,7 +94,7 @@ users to specify events by their name:
 
 where 'pm_1plus_ppc_cmpl' is a Power8 PMU event.
 
-However some errors in processing may cause the perf build to fail.
+However some errors in processing may cause the alias build to fail.
 
 Mapfile format
 ===============
@@ -119,7 +119,7 @@ where:
 
 	Header line
 		The header line is the first line in the file, which is
-		always _IGNORED_. It can empty.
+		always _IGNORED_. It can be empty.
 
 	CPUID:
 		CPUID is an arch-specific char string, that can be used
@@ -138,15 +138,15 @@ where:
 		files, relative to the directory containing the mapfile.csv
 
 	Type:
-		indicates whether the events or "core" or "uncore" events.
+		indicates whether the events are "core" or "uncore" events.
 
 
 	Eg:
 
-	$ grep Silvermont tools/perf/pmu-events/arch/x86/mapfile.csv
-	GenuineIntel-6-37,V13,Silvermont_core,core
-	GenuineIntel-6-4D,V13,Silvermont_core,core
-	GenuineIntel-6-4C,V13,Silvermont_core,core
+	$ grep silvermont tools/perf/pmu-events/arch/x86/mapfile.csv
+	GenuineIntel-6-37,v13,silvermont,core
+	GenuineIntel-6-4D,v13,silvermont,core
+	GenuineIntel-6-4C,v13,silvermont,core
 
 	i.e the three CPU models use the JSON files (i.e PMU events) listed
-	in the directory 'tools/perf/pmu-events/arch/x86/Silvermont_core'.
+	in the directory 'tools/perf/pmu-events/arch/x86/silvermont'.
-- 
2.21.0
