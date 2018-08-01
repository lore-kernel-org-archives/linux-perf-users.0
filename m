From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/21] perf vendor events arm64: Update ThunderX2 implementation defined pmu core events
Date: Wed,  1 Aug 2018 18:36:43 -0300
Message-ID: <20180801213648.4814-17-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ganapatrao Kulkarni <gklkml16@gmail.com>, Jan Glauber <jan.glauber@cavium.com>, Jayachandran C <jnair@caviumnetworks.com>, Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Robert Richter <robert.richter@cavium.com>, Vadim Lomovtsev <vadim.lomovtsev@cavium.com>, Will Deacon <will.deacon@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc: Jan Glauber <jan.glauber@cavium.com>
Cc: Jayachandran C <jnair@caviumnetworks.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@cavium.com>
Cc: Vadim Lomovtsev <vadim.lomovtsev@cavium.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20180731100251.23575-1-ganapatrao.kulkarni@cavium.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 87 +++++++++++++++++++++-
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
index bc03c06c3918..752e47eb6977 100644
--- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
@@ -11,6 +11,21 @@
     {
         "ArchStdEvent": "L1D_CACHE_REFILL_WR",
     },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+    },
     {
         "ArchStdEvent": "L1D_TLB_REFILL_RD",
     },
@@ -23,10 +38,76 @@
     {
         "ArchStdEvent": "L1D_TLB_WR",
     },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR",
+    },
     {
         "ArchStdEvent": "BUS_ACCESS_RD",
-   },
-   {
+    },
+    {
         "ArchStdEvent": "BUS_ACCESS_WR",
-   }
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD",
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF",
+    },
+    {
+        "ArchStdEvent": "EXC_SVC",
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+    },
+    {
+        "ArchStdEvent": "EXC_SMC",
+    },
+    {
+        "ArchStdEvent": "EXC_HVC",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ",
+    }
 ]
-- 
2.14.4
