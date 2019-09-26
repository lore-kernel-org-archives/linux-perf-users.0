From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/66] perf vendor events amd: Remove redundant '['
Date: Wed, 25 Sep 2019 21:31:42 -0300
Message-ID: <20190926003244.13962-5-acme@kernel.org>
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

Remove the redundant '['.

'perf list' output before:

  ex_ret_brn
       [[Retired Branch Instructions]

'perf list' output after:

  ex_ret_brn
       [Retired Branch Instructions]

Fixes: 98c07a8f74f8 ("perf vendor events amd: perf PMU events for AMD Family 17h")
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
Link: http://lore.kernel.org/lkml/20190919204306.12598-2-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0
