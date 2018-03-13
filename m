From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/31] perf vendor events arm64: Fixup ThunderX2 to use recommended events
Date: Tue, 13 Mar 2018 09:04:56 -0300
Message-ID: <20180313120508.29327-20-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Will Deacon <will.deacon@arm.com>, William Cohen <wcohen@redhat.com>, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: John Garry <john.garry@huawei.com>

This patch fixes the Cavium ThunderX2 JSON to use event definitions from
the ARMv8 recommended events.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-10-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 50 +++++-----------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
index 2db45c40ebc7..bc03c06c3918 100644
--- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
@@ -1,62 +1,32 @@
 [
     {
-        "PublicDescription": "Attributable Level 1 data cache access, read",
-        "EventCode": "0x40",
-        "EventName": "l1d_cache_rd",
-        "BriefDescription": "L1D cache read",
+        "ArchStdEvent": "L1D_CACHE_RD",
     },
     {
-        "PublicDescription": "Attributable Level 1 data cache access, write ",
-        "EventCode": "0x41",
-        "EventName": "l1d_cache_wr",
-        "BriefDescription": "L1D cache write",
+        "ArchStdEvent": "L1D_CACHE_WR",
     },
     {
-        "PublicDescription": "Attributable Level 1 data cache refill, read",
-        "EventCode": "0x42",
-        "EventName": "l1d_cache_refill_rd",
-        "BriefDescription": "L1D cache refill read",
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
     },
     {
-        "PublicDescription": "Attributable Level 1 data cache refill, write",
-        "EventCode": "0x43",
-        "EventName": "l1d_cache_refill_wr",
-        "BriefDescription": "L1D refill write",
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
     },
     {
-        "PublicDescription": "Attributable Level 1 data TLB refill, read",
-        "EventCode": "0x4C",
-        "EventName": "l1d_tlb_refill_rd",
-        "BriefDescription": "L1D tlb refill read",
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
     },
     {
-        "PublicDescription": "Attributable Level 1 data TLB refill, write",
-        "EventCode": "0x4D",
-        "EventName": "l1d_tlb_refill_wr",
-        "BriefDescription": "L1D tlb refill write",
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
     },
     {
-        "PublicDescription": "Attributable Level 1 data or unified TLB access, read",
-        "EventCode": "0x4E",
-        "EventName": "l1d_tlb_rd",
-        "BriefDescription": "L1D tlb read",
+        "ArchStdEvent": "L1D_TLB_RD",
     },
     {
-        "PublicDescription": "Attributable Level 1 data or unified TLB access, write",
-        "EventCode": "0x4F",
-        "EventName": "l1d_tlb_wr",
-        "BriefDescription": "L1D tlb write",
+        "ArchStdEvent": "L1D_TLB_WR",
     },
     {
-        "PublicDescription": "Bus access read",
-        "EventCode": "0x60",
-        "EventName": "bus_access_rd",
-        "BriefDescription": "Bus access read",
+        "ArchStdEvent": "BUS_ACCESS_RD",
    },
    {
-        "PublicDescription": "Bus access write",
-        "EventCode": "0x61",
-        "EventName": "bus_access_wr",
-        "BriefDescription": "Bus access write",
+        "ArchStdEvent": "BUS_ACCESS_WR",
    }
 ]
-- 
2.14.3
