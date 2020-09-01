From: Kim Phillips <kim.phillips@amd.com>
Subject: [PATCH 2/4] perf vendor events amd: Add ITLB Instruction Fetch Hits event for zen1
Date: Tue,  1 Sep 2020 17:09:42 -0500
Message-ID: <20200901220944.277505-2-kim.phillips@amd.com>
References: <20200901220944.277505-1-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200901220944.277505-1-kim.phillips@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Vijay Thakkar <vijaythakkar@me.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, Yunfeng Ye <yeyunfeng@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>, Martin Jambor <mjambor@suse.cz>, Michael Petlan <mpetlan@redhat.com>, William Cohen <wcohen@redhat.com>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

The ITLB Instruction Fetch Hits event isn't documented even in
later zen1 PPRs, but it seems to count correctly on zen1 hardware.

Add it to zen1 group so zen1 users can use the upcoming IC Fetch Miss
Ratio Metric.

The IF1G, 1IF2M, IF4K (Instruction fetches to a 1 GB, 2 MB, and 4K page)
unit masks are not added because unlike zen2 hardware, zen1 hardware
counts all its unit masks with a 0 unit mask according to the old
convention:

zen1$ perf stat -e cpu/event=0x94/,cpu/event=0x94,umask=0xff/ sleep 1

 Performance counter stats for 'sleep 1':

           211,318      cpu/event=0x94/u
           211,318      cpu/event=0x94,umask=0xff/u

Rome/zen2:

zen2$ perf stat -e cpu/event=0x94/,cpu/event=0x94,umask=0xff/ sleep 1

 Performance counter stats for 'sleep 1':

                 0      cpu/event=0x94/u
           190,744      cpu/event=0x94,umask=0xff/u

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vijay Thakkar <vijaythakkar@me.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: "Martin Liška" <mliska@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jon Grimm <jon.grimm@amd.com>
Cc: Martin Jambor <mjambor@suse.cz>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/pmu-events/arch/x86/amdzen1/branch.json | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
index a9943eeb8d6b..4ceb67a0db21 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
@@ -19,5 +19,10 @@
     "EventName": "bp_de_redirect",
     "EventCode": "0x91",
     "BriefDescription": "Decoder Overrides Existing Branch Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB."
   }
 ]
-- 
2.27.0
