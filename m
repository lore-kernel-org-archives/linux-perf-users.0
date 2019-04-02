From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/44] perf vendor events intel: Update Bonnell to V4
Date: Tue,  2 Apr 2019 13:05:46 -0300
Message-ID: <20190402160549.13544-42-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190315165219.GA21223@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/bonnell/frontend.json | 2 +-
 tools/perf/pmu-events/arch/x86/bonnell/pipeline.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/bonnell/frontend.json b/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
index 935b7dcf067d..ef69540ab61d 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
@@ -77,7 +77,7 @@
         "UMask": "0x1",
         "EventName": "UOPS.MS_CYCLES",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "This event counts the cycles where 1 or more uops are issued by the micro-sequencer (MS), including microcode assists and inserted flows, and written to the IQ. ",
+        "BriefDescription": "This event counts the cycles where 1 or more uops are issued by the micro-sequencer (MS), including microcode assists and inserted flows, and written to the IQ.",
         "CounterMask": "1"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
index b2e681c78466..09c6de13de20 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
@@ -189,7 +189,7 @@
         "UMask": "0x8",
         "EventName": "BR_MISSP_TYPE_RETIRED.IND_CALL",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Mispredicted indirect calls, including both register and memory indirect. "
+        "BriefDescription": "Mispredicted indirect calls, including both register and memory indirect."
     },
     {
         "EventCode": "0x89",
-- 
2.20.1
