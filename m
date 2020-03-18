From: Vijay Thakkar <vijaythakkar@me.com>
Subject: [PATCH v6 1/3] perf vendor events amd: restrict model detection for zen1 based processors
Date: Wed, 18 Mar 2020 15:00:00 -0400
Message-ID: <20200318190002.307290-2-vijaythakkar@me.com>
References: <20200318190002.307290-1-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200318190002.307290-1-vijaythakkar@me.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Vijay Thakkar <vijaythakkar@me.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Kim Phillips <kim.phillips@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

This patch changes the previous blanket detection of AMD Family 17h
processors to be more specific to Zen1 core based products only by
replacing model detection regex pattern [[:xdigit:]]+ with
([12][0-9A-F]|[0-9A-F]), restricting to models 0 though 2f only.

This change is required to allow for the addition of separate PMU events
for Zen2 core based models in the following patches as those belong to family
17h but have different PMCs. Current PMU events directory has also been
renamed to "amdzen1" from "amdfam17h" to reflect this specificity.

Note that although this change does not break PMU counters for existing
zen1 based systems, it does disable the current set of counters for zen2
based systems. Counters for zen2 have been added in the following
patches in this patchset.

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>

---
Changes in v2:
    - Correct the UMasks for fpu_pipe_assignment.dual* by left shifting
    all by 4 bits.
    - Correct UMask for ls_mab_alloc.loads
    - add bp_dyn_ind_pred (PMC0x08E)
    - add bp_de_redirect  (PMC0x091)
Changes in v3:
    - Correct the pipe numbers for fpu_pipe_assignment counters
    - Correct ls_mab_alloc.* public descriptions
Changes in v4:
    - PMC 0x46 add missing subcounters for types 0 and 1 of tablewalker
    allocation
    - PMC 0x60 and 0x61: add missing detail on brief descriptions
    - change descriptions of many of the events to bring them in-line
    with improvements made in patch 2/3. These were for counters that
    did not change between zen1 to zen2. Patch reviews for zen2 lead
    these descriptions to be changed and improved, and many of these
    have been carried here in this version of patch 3.

 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json  | 0
 tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json | 0
 .../arch/x86/{amdfam17h => amdzen1}/floating-point.json         | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json  | 0
 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 7 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/branch.json b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/branch.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/cache.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/core.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/core.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/memory.json b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/memory.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/other.json b/tools/perf/pmu-events/arch/x86/amdzen1/other.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/other.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/other.json
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 745ced083844..82a9db00125e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -36,4 +36,4 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
-AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
+AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v1,amdzen1,core
-- 
2.25.2
