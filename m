From: Kim Phillips <kim.phillips@amd.com>
Subject: [PATCH 1/5] perf vendor events amd: add L3 cache events for Family 17h
Date: Thu, 19 Sep 2019 15:43:02 -0500
Message-ID: <20190919204306.12598-1-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: kim.phillips@amd.com, Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Borislav Petkov <bp@suse.de>, Martin Liska <mliska@suse.cz>, Luke Mujica <lukemujica@google.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Allow users to symbolically specify L3 events for Family 17h processors
using the existing AMD Uncore driver.

Source of events descriptions are from section 2.1.15.4.1
"L3 Cache PMC Events" of the latest Family 17h PPR, available here:

https://www.amd.com/system/files/TechDocs/55570-B1_PUB.zip

Only BriefDescriptions added, since they show with and without
the -v and --details flags.

Tested with:

 # perf stat -e l3_request_g1.caching_l3_cache_accesses,amd_l3/event=0x01,umask=0x80/,l3_comb_clstr_state.request_miss,amd_l3/event=0x06,umask=0x01/ perf bench mem memcpy -s 4mb -l 100 -f default
...
         7,006,831      l3_request_g1.caching_l3_cache_accesses
         7,006,830      amd_l3/event=0x01,umask=0x80/
           366,530      l3_comb_clstr_state.request_miss
           366,568      amd_l3/event=0x06,umask=0x01/

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Martin Liska <mliska@suse.cz>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
---
 .../pmu-events/arch/x86/amdfam17h/cache.json  | 42 +++++++++++++++++++
 tools/perf/pmu-events/jevents.c               |  1 +
 2 files changed, 43 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json b/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
index fad4af9142cb..6221a840fcea 100644
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
@@ -283,5 +283,47 @@
     "BriefDescription": "Total cycles spent with one or more fill requests in flight from L2.",
     "PublicDescription": "Total cycles spent with one or more fill requests in flight from L2.",
     "UMask": "0x1"
+  },
+  {
+    "EventName": "l3_request_g1.caching_l3_cache_accesses",
+    "EventCode": "0x01",
+    "BriefDescription": "Caching: L3 cache accesses",
+    "UMask": "0x80",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_l3_req_typs",
+    "EventCode": "0x04",
+    "BriefDescription": "All L3 Request Types",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.other_l3_miss_typs",
+    "EventCode": "0x06",
+    "BriefDescription": "Other L3 Miss Request Types",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.request_miss",
+    "EventCode": "0x06",
+    "BriefDescription": "L3 cache misses",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_sys_fill_latency",
+    "EventCode": "0x90",
+    "BriefDescription": "L3 Cache Miss Latency. Total cycles for all transactions divided by 16. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x00",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_ccx_sdp_req1.all_l3_miss_req_typs",
+    "EventCode": "0x9a",
+    "BriefDescription": "All L3 Miss Request Types. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x3f",
+    "Unit": "L3PMC"
   }
 ]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index d413761621b0..9e37287da924 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -239,6 +239,7 @@ static struct map {
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
+	{ "L3PMC", "amd_l3" },
 	{}
 };
 
-- 
2.23.0
