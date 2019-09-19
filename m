From: Kim Phillips <kim.phillips@amd.com>
Subject: [PATCH 2/5] perf vendor events amd: remove redundant '['
Date: Thu, 19 Sep 2019 15:43:03 -0500
Message-ID: <20190919204306.12598-2-kim.phillips@amd.com>
References: <20190919204306.12598-1-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919204306.12598-1-kim.phillips@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: kim.phillips@amd.com, Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Borislav Petkov <bp@suse.de>, Martin Liska <mliska@suse.cz>, Luke Mujica <lukemujica@google.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Remove the redundant '['.

perf list output before:
  ex_ret_brn
       [[Retired Branch Instructions]

perf list output after:
  ex_ret_brn
       [Retired Branch Instructions]

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
Fixes: 98c07a8f74f8 ("perf vendor events amd: perf PMU events for AMD Family 17h")
---
 tools/perf/pmu-events/arch/x86/amdfam17h/core.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json b/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
index 7b285b0a7f35..1079544eeed5 100644
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
@@ -13,7 +13,7 @@
   {
     "EventName": "ex_ret_brn",
     "EventCode": "0xc2",
-    "BriefDescription": "[Retired Branch Instructions.",
+    "BriefDescription": "Retired Branch Instructions.",
     "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
   },
   {
-- 
2.23.0
