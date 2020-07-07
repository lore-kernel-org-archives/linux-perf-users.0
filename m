From: Kajol Jain <kjain@linux.ibm.com>
Subject: [RFC v2 2/5] pmu-events/x86/uncore: Replace PerPkg field to AggregationMode in x86 json files
Date: Tue,  7 Jul 2020 17:53:11 +0530
Message-ID: <20200707122314.624400-3-kjain@linux.ibm.com>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200707122314.624400-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

This patch replace PerPkg field to AggregationMode for all the x86 uncore
json files.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/x86/broadwellde/uncore-cache.json    |  62 ++--
 .../arch/x86/broadwellde/uncore-memory.json   |  18 +-
 .../arch/x86/broadwellde/uncore-power.json    |  18 +-
 .../arch/x86/broadwellx/uncore-cache.json     |  62 ++--
 .../x86/broadwellx/uncore-interconnect.json   |   6 +-
 .../arch/x86/broadwellx/uncore-memory.json    |  18 +-
 .../arch/x86/broadwellx/uncore-power.json     |  18 +-
 .../arch/x86/cascadelakex/uncore-memory.json  |  64 ++--
 .../arch/x86/cascadelakex/uncore-other.json   | 332 +++++++++---------
 .../arch/x86/haswellx/uncore-cache.json       |  62 ++--
 .../x86/haswellx/uncore-interconnect.json     |   6 +-
 .../arch/x86/haswellx/uncore-memory.json      |  18 +-
 .../arch/x86/haswellx/uncore-power.json       |  18 +-
 .../arch/x86/ivytown/uncore-cache.json        |  62 ++--
 .../arch/x86/ivytown/uncore-interconnect.json |  10 +-
 .../arch/x86/ivytown/uncore-memory.json       |  16 +-
 .../arch/x86/ivytown/uncore-power.json        |  52 +--
 .../arch/x86/jaketown/uncore-cache.json       |  40 +--
 .../x86/jaketown/uncore-interconnect.json     |  10 +-
 .../arch/x86/jaketown/uncore-memory.json      |  18 +-
 .../arch/x86/jaketown/uncore-power.json       |  52 +--
 .../x86/knightslanding/uncore-memory.json     |   8 +-
 .../arch/x86/skylakex/uncore-memory.json      |  36 +-
 .../arch/x86/skylakex/uncore-other.json       | 220 ++++++------
 .../arch/x86/tremontx/uncore-memory.json      |  14 +-
 .../arch/x86/tremontx/uncore-other.json       |  70 ++--
 .../arch/x86/tremontx/uncore-power.json       |   2 +-
 27 files changed, 656 insertions(+), 656 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
index 58ed6d33d1f4..60b8e34de513 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
@@ -3,7 +3,7 @@
         "BriefDescription": "Uncore cache clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_C_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "CBO"
     },
     {
@@ -12,7 +12,7 @@
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.ANY",
         "Filter": "filter_state=3D0x1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x11",
         "Unit": "CBO"
@@ -22,7 +22,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -33,7 +33,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.DATA_READ",
         "Filter": "filter_opc=3D0x182",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -44,7 +44,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "filter_opc=3D0x187",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -55,7 +55,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_READ",
         "Filter": "filter_opc=3D0x187,filter_nc=3D1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -66,7 +66,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_WRITE",
         "Filter": "filter_opc=3D0x18f,filter_nc=3D1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -77,7 +77,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.RFO_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x190",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -88,7 +88,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x191",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -99,7 +99,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.DATA_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x192",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -110,7 +110,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -121,7 +121,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x1c8",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -132,7 +132,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_NON_SNOOP_WRITE",
         "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -143,7 +143,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
         "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -153,7 +153,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x181",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -164,7 +164,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_FULL",
         "Filter": "filter_opc=3D0x18c",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -175,7 +175,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
         "Filter": "filter_opc=3D0x18d",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -186,7 +186,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -197,7 +197,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -207,7 +207,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LLC_DATA_READ",
         "Filter": "filter_opc=3D0x182",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -216,7 +216,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "HA"
     },
@@ -225,7 +225,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -234,7 +234,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -243,7 +243,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0xC",
         "Unit": "HA"
     },
@@ -252,7 +252,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -261,7 +261,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -270,7 +270,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x40",
         "Unit": "HA"
     },
@@ -279,7 +279,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x20",
         "Unit": "HA"
@@ -289,7 +289,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x4",
         "Unit": "HA"
@@ -299,7 +299,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x2",
         "Unit": "HA"
@@ -309,7 +309,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x8",
         "Unit": "HA"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json =
b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
index f4b0745cdbbf..2bfbafa00a15 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "iMC"
@@ -14,7 +14,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC",
         "Unit": "iMC"
@@ -23,7 +23,7 @@
         "BriefDescription": "Memory controller clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_M_DCLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -33,7 +33,7 @@
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "MetricExpr": "(UNC_M_POWER_CHANNEL_PPD / UNC_M_DCLOCKTICKS) * 100=
.",
         "MetricName": "power_channel_ppd %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -43,7 +43,7 @@
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
         "MetricExpr": "(UNC_M_POWER_CRITICAL_THROTTLE_CYCLES / UNC_M_DCLOC=
KTICKS) * 100.",
         "MetricName": "power_critical_throttle_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -53,7 +53,7 @@
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_DCLOCKTICKS) * 10=
0.",
         "MetricName": "power_self_refresh %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -61,7 +61,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -70,7 +70,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.RD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -79,7 +79,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.WR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x8",
         "Unit": "iMC"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
index dd1b95655d1d..598678aaf67e 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
@@ -3,7 +3,7 @@
         "BriefDescription": "PCU clock ticks. Use to get percentages of PC=
U cycles events",
         "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -14,7 +14,7 @@
         "Filter": "occ_sel=3D1",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c0 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -25,7 +25,7 @@
         "Filter": "occ_sel=3D2",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C3 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c3 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -36,7 +36,7 @@
         "Filter": "occ_sel=3D3",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C6 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c6 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -46,7 +46,7 @@
         "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
         "MetricExpr": "(UNC_P_PROCHOT_EXTERNAL_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
         "MetricName": "prochot_external_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -56,7 +56,7 @@
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES / UNC_P_CLOCKT=
ICKS) * 100.",
         "MetricName": "freq_max_limit_thermal_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -66,7 +66,7 @@
         "EventName": "UNC_P_FREQ_MAX_OS_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_OS_CYCLES / UNC_P_CLOCKTICKS) * 100=
.",
         "MetricName": "freq_max_os_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -76,7 +76,7 @@
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_POWER_CYCLES / UNC_P_CLOCKTICKS) * =
100.",
         "MetricName": "freq_max_power_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -86,7 +86,7 @@
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_TRANS_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_trans_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
index 58ed6d33d1f4..60b8e34de513 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
@@ -3,7 +3,7 @@
         "BriefDescription": "Uncore cache clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_C_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "CBO"
     },
     {
@@ -12,7 +12,7 @@
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.ANY",
         "Filter": "filter_state=3D0x1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x11",
         "Unit": "CBO"
@@ -22,7 +22,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -33,7 +33,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.DATA_READ",
         "Filter": "filter_opc=3D0x182",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -44,7 +44,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "filter_opc=3D0x187",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -55,7 +55,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_READ",
         "Filter": "filter_opc=3D0x187,filter_nc=3D1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -66,7 +66,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_WRITE",
         "Filter": "filter_opc=3D0x18f,filter_nc=3D1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -77,7 +77,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.RFO_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x190",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -88,7 +88,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x191",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -99,7 +99,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.DATA_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x192",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -110,7 +110,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -121,7 +121,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x1c8",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -132,7 +132,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_NON_SNOOP_WRITE",
         "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -143,7 +143,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
         "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -153,7 +153,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x181",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -164,7 +164,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_FULL",
         "Filter": "filter_opc=3D0x18c",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -175,7 +175,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
         "Filter": "filter_opc=3D0x18d",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -186,7 +186,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -197,7 +197,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -207,7 +207,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LLC_DATA_READ",
         "Filter": "filter_opc=3D0x182",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -216,7 +216,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "HA"
     },
@@ -225,7 +225,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -234,7 +234,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -243,7 +243,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0xC",
         "Unit": "HA"
     },
@@ -252,7 +252,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -261,7 +261,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -270,7 +270,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x40",
         "Unit": "HA"
     },
@@ -279,7 +279,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x20",
         "Unit": "HA"
@@ -289,7 +289,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x4",
         "Unit": "HA"
@@ -299,7 +299,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x2",
         "Unit": "HA"
@@ -309,7 +309,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x8",
         "Unit": "HA"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
index 824961318c1e..5b2df265e712 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
@@ -4,14 +4,14 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_Q_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Number of data flits transmitted . Derived fr=
om unc_q_txl_flits_g0.data",
         "Counter": "0,1,2,3",
         "EventName": "QPI_DATA_BANDWIDTH_TX",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "8Bytes",
         "UMask": "0x2",
         "Unit": "QPI LL"
@@ -20,7 +20,7 @@
         "BriefDescription": "Number of non data (control) flits transmitte=
d . Derived from unc_q_txl_flits_g0.non_data",
         "Counter": "0,1,2,3",
         "EventName": "QPI_CTL_BANDWIDTH_TX",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "8Bytes",
         "UMask": "0x4",
         "Unit": "QPI LL"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
index 66eed399724c..7415eef71559 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "iMC"
@@ -14,7 +14,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC",
         "Unit": "iMC"
@@ -23,7 +23,7 @@
         "BriefDescription": "Memory controller clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_M_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -33,7 +33,7 @@
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "MetricExpr": "(UNC_M_POWER_CHANNEL_PPD / UNC_M_CLOCKTICKS) * 100.=
",
         "MetricName": "power_channel_ppd %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -43,7 +43,7 @@
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
         "MetricExpr": "(UNC_M_POWER_CRITICAL_THROTTLE_CYCLES / UNC_M_CLOCK=
TICKS) * 100.",
         "MetricName": "power_critical_throttle_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -53,7 +53,7 @@
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_CLOCKTICKS) * 100=
.",
         "MetricName": "power_self_refresh %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -61,7 +61,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -70,7 +70,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.RD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -79,7 +79,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.WR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x8",
         "Unit": "iMC"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
index dd1b95655d1d..598678aaf67e 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
@@ -3,7 +3,7 @@
         "BriefDescription": "PCU clock ticks. Use to get percentages of PC=
U cycles events",
         "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -14,7 +14,7 @@
         "Filter": "occ_sel=3D1",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c0 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -25,7 +25,7 @@
         "Filter": "occ_sel=3D2",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C3 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c3 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -36,7 +36,7 @@
         "Filter": "occ_sel=3D3",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C6 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c6 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -46,7 +46,7 @@
         "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
         "MetricExpr": "(UNC_P_PROCHOT_EXTERNAL_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
         "MetricName": "prochot_external_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -56,7 +56,7 @@
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES / UNC_P_CLOCKT=
ICKS) * 100.",
         "MetricName": "freq_max_limit_thermal_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -66,7 +66,7 @@
         "EventName": "UNC_P_FREQ_MAX_OS_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_OS_CYCLES / UNC_P_CLOCKTICKS) * 100=
.",
         "MetricName": "freq_max_os_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -76,7 +76,7 @@
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_POWER_CYCLES / UNC_P_CLOCKTICKS) * =
100.",
         "MetricName": "freq_max_power_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -86,7 +86,7 @@
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_TRANS_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_trans_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json=
 b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
index 3fb5cdce842f..814e0a96ceb8 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "iMC"
@@ -14,7 +14,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC",
         "Unit": "iMC"
@@ -23,7 +23,7 @@
         "BriefDescription": "Memory controller clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_M_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -33,7 +33,7 @@
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "MetricExpr": "(UNC_M_POWER_CHANNEL_PPD / UNC_M_CLOCKTICKS) * 100.=
",
         "MetricName": "power_channel_ppd %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -43,7 +43,7 @@
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_CLOCKTICKS) * 100=
.",
         "MetricName": "power_self_refresh %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -51,7 +51,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -60,7 +60,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.RD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -69,7 +69,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.WR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -78,7 +78,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xE3",
         "EventName": "UNC_M_PMM_RPQ_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -86,7 +86,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xE7",
         "EventName": "UNC_M_PMM_WPQ_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -94,7 +94,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xE3",
         "EventName": "UNC_M_PMM_BANDWIDTH.READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "6.103515625E-5MB/sec",
         "Unit": "iMC"
     },
@@ -103,7 +103,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xE7",
         "EventName": "UNC_M_PMM_BANDWIDTH.WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "6.103515625E-5MB/sec",
         "Unit": "iMC"
     },
@@ -114,7 +114,7 @@
         "EventName": "UNC_M_PMM_BANDWIDTH.TOTAL",
         "MetricExpr": "UNC_M_PMM_RPQ_INSERTS + UNC_M_PMM_WPQ_INSERTS",
         "MetricName": "UNC_M_PMM_BANDWIDTH.TOTAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "6.103515625E-5MB/sec",
         "Unit": "iMC"
     },
@@ -123,7 +123,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xE0",
         "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -134,7 +134,7 @@
         "EventName": "UNC_M_PMM_READ_LATENCY",
         "MetricExpr": "UNC_M_PMM_RPQ_OCCUPANCY.ALL / UNC_M_PMM_RPQ_INSERTS=
 / UNC_M_CLOCKTICKS",
         "MetricName": "UNC_M_PMM_READ_LATENCY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "6000000000ns",
         "UMask": "0x1",
         "Unit": "iMC"
@@ -144,7 +144,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.WR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts DRAM Page Activate commands sent on t=
his channel due to a write request to the iMC (Memory Controller).  Activat=
e commands are issued to open up a page on the DRAM devices so that it can =
be read or written to with a CAS (Column Access Select) command.",
         "UMask": "0x2",
         "Unit": "iMC"
@@ -154,7 +154,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts all CAS (Column Address Select) comma=
nds issued to DRAM per memory channel.  CAS commands are issued to specify =
the address to read or write on DRAM, so this event increments for every re=
ad and write. This event counts whether AutoPrecharge (which closes the DRA=
M Page automatically after a read/write) is enabled or not.",
         "UMask": "0xF",
         "Unit": "iMC"
@@ -164,7 +164,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_REG",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts CAS (Column Access Select) regular re=
ad commands issued to DRAM on a per channel basis.  CAS commands are issued=
 to specify the address to read or write on DRAM, and this event increments=
 for every regular read.  This event only counts regular reads and does not=
 includes underfill reads due to partial write requests.  This event counts=
 whether AutoPrecharge (which closes the DRAM Page automatically after a re=
ad/write)  is enabled or not.",
         "UMask": "0x1",
         "Unit": "iMC"
@@ -174,7 +174,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts CAS (Column Access Select) underfill =
read commands issued to DRAM due to a partial write, on a per channel basis=
.  CAS commands are issued to specify the address to read or write on DRAM,=
 and this command counts underfill reads.  Partial writes must be completed=
 by first reading in the underfill from DRAM and then merging in the partia=
l write data before writing the full line back to DRAM. This event will gen=
erally count about the same as the number of partial writes, but may be sli=
ghtly less because of partials hitting in the WPQ (due to a previous write =
request).",
         "UMask": "0x2",
         "Unit": "iMC"
@@ -184,7 +184,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.WR_WMM",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the total number or DRAM Write CAS co=
mmands issued on this channel while in Write-Major-Mode.",
         "UMask": "0x4",
         "Unit": "iMC"
@@ -194,7 +194,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xEA",
         "EventName": "UNC_M_PMM_CMD1.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "All commands for Intel Optane DC persistent =
memory",
         "UMask": "0x1",
         "Unit": "iMC"
@@ -204,7 +204,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xEA",
         "EventName": "UNC_M_PMM_CMD1.RD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "All Reads - RPQ or Ufill",
         "UMask": "0x2",
         "Unit": "iMC"
@@ -214,7 +214,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xEA",
         "EventName": "UNC_M_PMM_CMD1.UFILL_RD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Underfill reads",
         "UMask": "0x8",
         "Unit": "iMC"
@@ -224,7 +224,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xEA",
         "EventName": "UNC_M_PMM_CMD1.WR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Writes",
         "UMask": "0x4",
         "Unit": "iMC"
@@ -234,7 +234,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xE4",
         "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Write Pending Queue Occupancy of all write r=
equests for Intel Optane DC persistent memory",
         "UMask": "0x1",
         "Unit": "iMC"
@@ -244,7 +244,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of read requests allocated=
 into the Read Pending Queue (RPQ).  This queue is used to schedule reads o=
ut to the memory controller and to track the requests.  Requests allocate i=
nto the RPQ soon after they enter the memory controller, and need credits f=
or an entry in this buffer before being sent from the CHA to the iMC.  The =
requests deallocate after the read CAS command has been issued to DRAM.  Th=
is event counts both Isochronous and non-Isochronous requests which were is=
sued to the RPQ.",
         "Unit": "iMC"
     },
@@ -253,7 +253,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_M_RPQ_OCCUPANCY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of entries in the Read Pen=
ding Queue (RPQ) at each cycle.  This can then be used to calculate both th=
e average occupancy of the queue (in conjunction with the number of cycles =
not empty) and the average latency in the queue (in conjunction with the nu=
mber of allocations).  The RPQ is used to schedule reads out to the memory =
controller and to track the requests.  Requests allocate into the RPQ soon =
after they enter the memory controller, and need credits for an entry in th=
is buffer before being sent from the CHA to the iMC. They deallocate from t=
he RPQ after the CAS command has been issued to memory.",
         "Unit": "iMC"
     },
@@ -262,7 +262,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "UNC_M_TAGCHK.HIT",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Tag Check; Hit",
         "UMask": "0x1",
         "Unit": "iMC"
@@ -272,7 +272,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "UNC_M_TAGCHK.MISS_CLEAN",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Tag Check; Clean",
         "UMask": "0x2",
         "Unit": "iMC"
@@ -282,7 +282,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xD3",
         "EventName": "UNC_M_TAGCHK.MISS_DIRTY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Tag Check; Dirty",
         "UMask": "0x4",
         "Unit": "iMC"
@@ -292,7 +292,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M_WPQ_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of writes requests allocat=
ed into the Write Pending Queue (WPQ).  The WPQ is used to schedule writes =
out to the memory controller and to track the requests.  Requests allocate =
into the WPQ soon after they enter the memory controller, and need credits =
for an entry in this buffer before being sent from the CHA to the iMC (Memo=
ry Controller).  The write requests deallocate after being issued to DRAM. =
 Write requests themselves are able to complete (from the perspective of th=
e rest of the system) as soon they have 'posted' to the iMC.",
         "Unit": "iMC"
     },
@@ -301,7 +301,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "UNC_M_WPQ_OCCUPANCY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of entries in the Write Pe=
nding Queue (WPQ) at each cycle.  This can then be used to calculate both t=
he average queue occupancy (in conjunction with the number of cycles not em=
pty) and the average latency (in conjunction with the number of allocations=
).  The WPQ is used to schedule writes out to the memory controller and to =
track the requests.  Requests allocate into the WPQ soon after they enter t=
he memory controller, and need credits for an entry in this buffer before b=
eing sent from the CHA to the iMC (memory controller).  They deallocate aft=
er being issued to DRAM.  Write requests themselves are able to complete (f=
rom the perspective of the rest of the system) as soon they have 'posted' t=
o the iMC.  This is not to be confused with actually performing the write t=
o DRAM.  Therefore, the average latency for this queue is actually not usef=
ul for deconstruction intermediate write latencies.  So, we provide filteri=
ng based on if the request has posted or not.  By using the 'not posted' fi=
lter, we can track how long writes spent in the iMC before completions were=
 sent to the HA.  The 'posted' filter, on the other hand, provides informat=
ion about how much queueing is actually happenning in the iMC for writes be=
fore they are actually issued to memory.  High average occupancies will gen=
erally coincide with high write major mode counts. Is there a filter of sor=
ts???",
         "Unit": "iMC"
     }
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index df355ba7acc8..5bde08eb9776 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -3,7 +3,7 @@
         "BriefDescription": "Uncore cache clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_CHA_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "CHA"
     },
     {
@@ -12,7 +12,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "config1=3D0x40e33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x21",
         "Unit": "CHA"
     },
@@ -22,7 +22,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_READ",
         "Filter": "config1=3D0x40040e33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x21",
         "Unit": "CHA"
     },
@@ -32,7 +32,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_WRITE",
         "Filter": "config1=3D0x40041e33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x21",
         "Unit": "CHA"
     },
@@ -42,7 +42,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_FULL",
         "Filter": "config1=3D0x41833",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -53,7 +53,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
         "Filter": "config1=3D0x41a33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -63,7 +63,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x03",
         "Unit": "CHA"
     },
@@ -72,7 +72,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x01",
         "Unit": "CHA"
     },
@@ -81,7 +81,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x02",
         "Unit": "CHA"
     },
@@ -90,7 +90,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x0C",
         "Unit": "CHA"
     },
@@ -99,7 +99,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x04",
         "Unit": "CHA"
     },
@@ -108,7 +108,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x08",
         "Unit": "CHA"
     },
@@ -117,7 +117,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UPI_DATA_BANDWIDTH_TX",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "7.11E-06Bytes",
         "UMask": "0xf",
         "Unit": "UPI LL"
@@ -128,7 +128,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -140,7 +140,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -152,7 +152,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -164,7 +164,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -179,7 +179,7 @@
         "Filter": "ch_mask=3D0x1f",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_D=
ATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 + =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
         "MetricName": "LLC_MISSES.PCIE_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -191,7 +191,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -203,7 +203,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -215,7 +215,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -227,7 +227,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -242,7 +242,7 @@
         "Filter": "ch_mask=3D0x1f",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC=
_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
         "MetricName": "LLC_MISSES.PCIE_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -253,7 +253,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.CORE_GTONE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of transactions that trigg=
er a configurable number of cross snoops.  Cores are snooped if the transac=
tion looks up the cache and determines that it is necessary based on the op=
eration type and what CoreValid bits are set.  For example, if 2 CV bits ar=
e set on a data read, the cores must have the data in S state so it is not =
necessary to snoop them.  However, if only 1 CV bit is set the core my have=
 modified the data.  If the transaction was an RFO, it would need to invali=
date the lines.  This event can be filtered based on who triggered the init=
ial snoop(s).",
         "UMask": "0x42",
         "Unit": "CHA"
@@ -263,7 +263,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.EVICT_GTONE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of transactions that trigg=
er a configurable number of cross snoops.  Cores are snooped if the transac=
tion looks up the cache and determines that it is necessary based on the op=
eration type and what CoreValid bits are set.  For example, if 2 CV bits ar=
e set on a data read, the cores must have the data in S state so it is not =
necessary to snoop them.  However, if only 1 CV bit is set the core my have=
 modified the data.  If the transaction was an RFO, it would need to invali=
date the lines.  This event can be filtered based on who triggered the init=
ial snoop(s).",
         "UMask": "0x82",
         "Unit": "CHA"
@@ -273,7 +273,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts transactions that looked into the mul=
ti-socket cacheline Directory state, and therefore did not send a snoop bec=
ause the Directory indicated it was not needed",
         "UMask": "0x02",
         "Unit": "CHA"
@@ -283,7 +283,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts  transactions that looked into the mu=
lti-socket cacheline Directory state, and sent one or more snoops, because =
the Directory indicated it was needed",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -293,7 +293,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_CHA_DIR_UPDATE.HA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts only multi-socket cacheline Directory=
 state updates memory writes issued from the HA pipe. This does not include=
 memory write requests which are for I (Invalid) or E (Exclusive) cacheline=
s.",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -303,7 +303,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_CHA_DIR_UPDATE.TOR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts only multi-socket cacheline Directory=
 state updates due to memory writes issued from the TOR pipe which are the =
result of remote transaction hitting the SF/LLC and returning data Core2Cor=
e. This does not include memory write requests which are for I (Invalid) or=
 E (Exclusive) cachelines.",
         "UMask": "0x02",
         "Unit": "CHA"
@@ -313,7 +313,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xA5",
         "EventName": "UNC_CHA_FAST_ASSERTED.HORZ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of cycles either the local=
 or incoming distress signals are asserted.  Incoming distress includes up,=
 dn and across.",
         "UMask": "0x02",
         "Unit": "CHA"
@@ -323,7 +323,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5F",
         "EventName": "UNC_CHA_HITME_HIT.EX_RDS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts read requests from a remote socket wh=
ich hit in the HitME cache (used to cache the multi-socket Directory state)=
 to a line in the E(Exclusive) state.  This includes the following read opc=
odes (RdCode, RdData, RdDataMigratory, RdCur, RdInv*, Inv*)",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -333,7 +333,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x59",
         "EventName": "UNC_CHA_IMC_READS_COUNT.NORMAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a normal (Non-Isochronous) read =
is issued to any of the memory controller channels from the CHA.",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -343,7 +343,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5B",
         "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a normal (Non-Isochronous) full =
line write is issued from the CHA to the any of the memory controller chann=
els.",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -353,7 +353,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x02",
         "Unit": "CHA"
@@ -363,7 +363,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_F",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x08",
         "Unit": "CHA"
@@ -373,7 +373,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -383,7 +383,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x04",
         "Unit": "CHA"
@@ -393,7 +393,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_CHA_MISC.RFO_HIT_S",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a RFO (the Read for Ownership is=
sued before a  write) request hit a cacheline in the S (Shared) state.",
         "UMask": "0x08",
         "Unit": "CHA"
@@ -403,7 +403,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the total number of requests coming f=
rom a unit on this socket for exclusive ownership of a cache line without r=
eceiving data (INVITOE) to the CHA.",
         "UMask": "0x10",
         "Unit": "CHA"
@@ -413,7 +413,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.INVITOE_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the total number of requests coming f=
rom a remote socket for exclusive ownership of a cache line without receivi=
ng data (INVITOE) to the CHA.",
         "UMask": "0x20",
         "Unit": "CHA"
@@ -423,7 +423,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "UNC_CHA_RxC_INSERTS.IRQ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -433,7 +433,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Ingress (from CMS) Request Queue Rejects; Ph=
yAddr Match",
         "UMask": "0x80",
         "Unit": "CHA"
@@ -442,7 +442,7 @@
         "BriefDescription": "Ingress (from CMS) Occupancy; IRQ",
         "EventCode": "0x11",
         "EventName": "UNC_CHA_RxC_OCCUPANCY.IRQ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -452,7 +452,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3D",
         "EventName": "UNC_CHA_SF_EVICTION.E_STATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts snoop filter capacity evictions for e=
ntries tracking exclusive lines in the cores cache. Snoop filter capacity e=
victions occur when the snoop filter is full and evicts an existing entry t=
o track a new entry. Does not count clean evictions such as when a cores ca=
che replaces a tracked cacheline with a new cacheline.",
         "UMask": "0x02",
         "Unit": "CHA"
@@ -462,7 +462,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3D",
         "EventName": "UNC_CHA_SF_EVICTION.M_STATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts snoop filter capacity evictions for e=
ntries tracking modified lines in the cores cache. Snoop filter capacity ev=
ictions occur when the snoop filter is full and evicts an existing entry to=
 track a new entry. Does not count clean evictions such as when a cores cac=
he replaces a tracked cacheline with a new cacheline.",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -472,7 +472,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3D",
         "EventName": "UNC_CHA_SF_EVICTION.S_STATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts snoop filter capacity evictions for e=
ntries tracking shared lines in the cores cache. Snoop filter capacity evic=
tions occur when the snoop filter is full and evicts an existing entry to t=
rack a new entry. Does not count clean evictions such as when a cores cache=
 replaces a tracked cacheline with a new cacheline.",
         "UMask": "0x04",
         "Unit": "CHA"
@@ -482,7 +482,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a a transaction with the opcode =
type RspCnflct* Snoop Response was received. This is returned when a snoop =
finds an existing outstanding transaction in a remote caching agent. This t=
riggers conflict resolution hardware. This covers both the opcode RspCnflct=
 and RspCnflctWbI.",
         "UMask": "0x40",
         "Unit": "CHA"
@@ -492,7 +492,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPI",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a transaction with the opcode ty=
pe RspI Snoop Response was received which indicates the remote cache does n=
ot have the data, or when the remote cache silently evicts data (such as wh=
en an RFO: the Read for Ownership issued before a write hits non-modified d=
ata).",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -502,7 +502,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPIFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a a transaction with the opcode =
type RspIFwd Snoop Response was received which indicates a remote caching a=
gent forwarded the data and the requesting agent is able to acquire the dat=
a in E (Exclusive) or M (modified) states.  This is commonly returned with =
RFO (the Read for Ownership issued before a write) transactions.  The snoop=
 could have either been to a cacheline in the M,E,F (Modified, Exclusive or=
 Forward)  states.",
         "UMask": "0x04",
         "Unit": "CHA"
@@ -512,7 +512,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPSFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a a transaction with the opcode =
type RspSFwd Snoop Response was received which indicates a remote caching a=
gent forwarded the data but held on to its current copy.  This is common fo=
r data and code reads that hit in a remote socket in E (Exclusive) or F (Fo=
rward) state.",
         "UMask": "0x08",
         "Unit": "CHA"
@@ -522,7 +522,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a transaction with the opcode ty=
pe Rsp*Fwd*WB Snoop Response was received which indicates the data was writ=
ten back to it's home socket, and the cacheline was forwarded to the reques=
tor socket.  This snoop response is only used in >=3D 4 socket systems.  It=
 is used when a snoop HITM's in a remote caching agent and it directly forw=
ards data to a requestor, and simultaneously returns data to it's home sock=
et to be written back to memory.",
         "UMask": "0x20",
         "Unit": "CHA"
@@ -532,7 +532,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a transaction with the opcode ty=
pe Rsp*WB Snoop Response was received which indicates which indicates the d=
ata was written back to it's home.  This is returned when a non-RFO request=
 hits a cacheline in the Modified state. The Cache can either downgrade the=
 cacheline to a S (Shared) or I (Invalid) state depending on how the system=
 has been configured.  This reponse will also be sent when a cache requests=
 E (Exclusive) ownership of a cache line without receiving data, because th=
e cache must acquire ownership.",
         "UMask": "0x10",
         "Unit": "CHA"
@@ -542,7 +542,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_IIO_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts clockticks of the 1GHz trafiic contro=
ller clock in the IIO unit.",
         "Unit": "IIO"
     },
@@ -552,7 +552,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) or by another IIO unit =
to the MMIO space of a card on IIO Part0. In the general case, Part0 refers=
 to a standard PCIe card of any size (x16,x8,x4) that is plugged directly i=
nto one of the PCIe slots. Part0 could also refer to any device plugged int=
o the first slot of a PCIe riser card or to a device attached to the IIO un=
it which starts its use of the bus using lane 0 of the 16 lanes supported b=
y the bus.",
         "UMask": "0x04",
@@ -564,7 +564,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) or by another IIO unit =
to the MMIO space of a card on IIO Part1. In the general case, Part1 refers=
 to a x4 PCIe card plugged into the second slot of a PCIe riser card, but i=
t could refer to any x4 device attached to the IIO unit using lanes startin=
g at lane 4 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -576,7 +576,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) or by another IIO unit =
to the MMIO space of a card on IIO Part2. In the general case, Part2 refers=
 to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, =
but it could refer to any x4 or x8 device attached to the IIO unit and usin=
g lanes starting at lane 8 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -588,7 +588,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) or by another IIO unit =
to the MMIO space of a card on IIO Part3. In the general case, Part3 refers=
 to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but i=
t could brefer to  any device attached to the IIO unit using the lanes star=
ting at lane 12 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -600,7 +600,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part0 by a unit on the main die (=
generally a core) or by another IIO unit. In the general case, Part0 refers=
 to a standard PCIe card of any size (x16,x8,x4) that is plugged directly i=
nto one of the PCIe slots. Part0 could also refer to any device plugged int=
o the first slot of a PCIe riser card or to a device attached to the IIO un=
it which starts its use of the bus using lane 0 of the 16 lanes supported b=
y the bus.",
         "UMask": "0x01",
@@ -612,7 +612,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part1 by a unit on the main die (=
generally a core) or by another IIO unit. In the general case, Part1 refers=
 to a x4 PCIe card plugged into the second slot of a PCIe riser card, but i=
t could refer to any x4 device attached to the IIO unit using lanes startin=
g at lane 4 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -624,7 +624,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part2 by  a unit on the main die =
(generally a core) or by another IIO unit. In the general case, Part2 refer=
s to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card,=
 but it could refer to any x4 or x8 device attached to the IIO unit and usi=
ng lanes starting at lane 8 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -636,7 +636,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part3 by  a unit on the main die =
(generally a core) or by another IIO unit. In the general case, Part3 refer=
s to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but =
it could brefer to any device attached to the IIO unit using the lanes star=
ting at lane 12 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -648,7 +648,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts ever peer to peer read request for 4 =
bytes of data made by a different IIO unit to the MMIO space of a card on I=
IO Part0. Does not include requests made by the same IIO unit. In the gener=
al case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that =
is plugged directly into one of the PCIe slots. Part0 could also refer to a=
ny device plugged into the first slot of a PCIe riser card or to a device a=
ttached to the IIO unit which starts its use of the bus using lane 0 of the=
 16 lanes supported by the bus.",
         "UMask": "0x08",
@@ -660,7 +660,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts ever peer to peer read request for 4 =
bytes of data made by a different IIO unit to the MMIO space of a card on I=
IO Part1. Does not include requests made by the same IIO unit. In the gener=
al case, Part1 refers to a x4 PCIe card plugged into the second slot of a P=
CIe riser card, but it could refer to any x4 device attached to the IIO uni=
t using lanes starting at lane 4 of the 16 lanes supported by the bus.",
         "UMask": "0x08",
@@ -672,7 +672,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts ever peer to peer read request for 4 =
bytes of data made by a different IIO unit to the MMIO space of a card on I=
IO Part2. Does not include requests made by the same IIO unit. In the gener=
al case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot o=
f a PCIe riser card, but it could refer to any x4 or x8 device attached to =
the IIO unit and using lanes starting at lane 8 of the 16 lanes supported b=
y the bus.",
         "UMask": "0x08",
@@ -684,7 +684,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts ever peer to peer read request for 4 =
bytes of data made by a different IIO unit to the MMIO space of a card on I=
IO Part3. Does not include requests made by the same IIO unit. In the gener=
al case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a P=
CIe riser card, but it could brefer to  any device attached to the IIO unit=
 using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
         "UMask": "0x08",
@@ -696,7 +696,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made to the MMIO space of a card on IIO Part0 by a different=
 IIO unit. Does not include requests made by the same IIO unit.  In the gen=
eral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) tha=
t is plugged directly into one of the PCIe slots. Part0 could also refer to=
 any device plugged into the first slot of a PCIe riser card or to a device=
 attached to the IIO unit which starts its use of the bus using lane 0 of t=
he 16 lanes supported by the bus.",
         "UMask": "0x02",
@@ -708,7 +708,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made to the MMIO space of a card on IIO Part1 by a different=
 IIO unit. Does not include requests made by the same IIO unit. In the gene=
ral case, Part1 refers to a x4 PCIe card plugged into the second slot of a =
PCIe riser card, but it could refer to any x4 device attached to the IIO un=
it using lanes starting at lane 4 of the 16 lanes supported by the bus.",
         "UMask": "0x02",
@@ -720,7 +720,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made to the MMIO space of a card on IIO Part2 by a different=
 IIO unit. Does not include requests made by the same IIO unit. In the gene=
ral case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot =
of a PCIe riser card, but it could refer to any x4 or x8 device attached to=
 the IIO unit and using lanes starting at lane 8 of the 16 lanes supported =
by the bus.",
         "UMask": "0x02",
@@ -732,7 +732,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made to the MMIO space of a card on IIO Part3 by a different=
 IIO unit. Does not include requests made by the same IIO unit. In the gene=
ral case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a =
PCIe riser card, but it could brefer to any device attached to the IIO unit=
 using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
         "UMask": "0x02",
@@ -744,7 +744,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every peer to peer read request for 4=
 bytes of data made by IIO Part0 to the MMIO space of an IIO target. In the=
 general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4)=
 that is plugged directly into one of the PCIe slots. Part0 could also refe=
r to any device plugged into the first slot of a PCIe riser card or to a de=
vice attached to the IIO unit which starts its use of the bus using lane 0 =
of the 16 lanes supported by the bus.",
         "UMask": "0x08",
@@ -756,7 +756,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every peer to peer read request for 4=
 bytes of data made by IIO Part1 to the MMIO space of an IIO target. In the=
 general case, Part1 refers to a x4 PCIe card plugged into the second slot =
of a PCIe riser card, but it could refer to any x4 device attached to the I=
IO unit using lanes starting at lane 4 of the 16 lanes supported by the bus=
.",
         "UMask": "0x08",
@@ -768,7 +768,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every peer to peer read request for 4=
 bytes of data made by IIO Part2 to the MMIO space of an IIO target. In the=
 general case, Part2 refers to a x4 or x8 PCIe card plugged into the third =
slot of a PCIe riser card, but it could refer to any x4 or x8 device attach=
ed to the IIO unit and using lanes starting at lane 8 of the 16 lanes suppo=
rted by the bus.",
         "UMask": "0x08",
@@ -780,7 +780,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every peer to peer read request for 4=
 bytes of data made by IIO Part3 to the MMIO space of an IIO target. In the=
 general case, Part3 refers to a x4 PCIe card plugged into the fourth slot =
of a PCIe riser card, but it could brefer to any device attached to the IIO=
 unit using the lanes starting at lane 12 of the 16 lanes supported by the =
bus.",
         "UMask": "0x08",
@@ -792,7 +792,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made by IIO Part0 to the MMIO space of an IIO target. In the=
 general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4)=
 that is plugged directly into one of the PCIe slots. Part0 could also refe=
r to any device plugged into the first slot of a PCIe riser card or to a de=
vice attached to the IIO unit which starts its use of the bus using lane 0 =
of the 16 lanes supported by the bus.",
         "UMask": "0x02",
@@ -804,7 +804,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made by IIO Part1 to the MMIO space of an IIO target. In the=
 general case, Part1 refers to a x4 PCIe card plugged into the second slot =
of a PCIe riser card, but it could refer to any x4 device attached to the I=
IO unit using lanes starting at lane 4 of the 16 lanes supported by the bus=
.",
         "UMask": "0x02",
@@ -816,7 +816,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made by IIO Part2 to the MMIO space of an IIO target. In the=
 general case, Part2 refers to a x4 or x8 PCIe card plugged into the third =
slot of a PCIe riser card, but it could refer to any x4 or x8 device attach=
ed to the IIO unit and using lanes starting at lane 8 of the 16 lanes suppo=
rted by the bus.",
         "UMask": "0x02",
@@ -828,7 +828,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made by IIO Part3 to the MMIO space of an IIO target. In the=
 general case, Part3 refers to a x4 PCIe card plugged into the fourth slot =
of a PCIe riser card, but it could brefer to  any device attached to the II=
O unit using the lanes starting at lane 12 of the 16 lanes supported by the=
 bus.",
         "UMask": "0x02",
@@ -840,7 +840,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) or =
by another IIO unit to the MMIO space of a card on IIO Part0. In the genera=
l case, part0 refers to a standard PCIe card of any size (x16,x8,x4) that i=
s plugged directly into one of the PCIe slots. Part0 could also refer to an=
y device plugged into the first slot of a PCIe riser card or to a device at=
tached to the IIO unit which starts its use of the bus using lane 0 of the =
16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -852,7 +852,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) or =
by another IIO unit to the MMIO space of a card on IIO Part1. In the genera=
l case, Part1 refers to a x4 PCIe card plugged into the second slot of a PC=
Ie riser card, but it could refer to any x4 device attached to the IIO unit=
 using lanes starting at lane 4 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -864,7 +864,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) or =
by another IIO unit to the MMIO space of a card on IIO Part2. In the genera=
l case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of=
 a PCIe riser card, but it could refer to any x4 or x8 device attached to t=
he IIO unit and using lanes starting at lane 8 of the 16 lanes supported by=
 the bus.",
         "UMask": "0x04",
@@ -876,7 +876,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) or =
by another IIO unit to the MMIO space of a card on IIO Part3. In the genera=
l case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PC=
Ie riser card, but it could brefer to  any device attached to the IIO unit =
using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -888,7 +888,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part0 by a un=
it on the main die (generally a core) or by another IIO unit. In the genera=
l case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that i=
s plugged directly into one of the PCIe slots. Part0 could also refer to an=
y device plugged into the first slot of a PCIe riser card or to a device at=
tached to the IIO unit which starts its use of the bus using lane 0 of the =
16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -900,7 +900,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part1 by a un=
it on the main die (generally a core) or by another IIO unit. In the genera=
l case, Part1 refers to a x4 PCIe card plugged into the second slot of a PC=
Ie riser card, but it could refer to any x4 device attached to the IIO unit=
 using lanes starting at lane 4 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -912,7 +912,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part2 by a un=
it on the main die (generally a core) or by another IIO unit. In the genera=
l case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of=
 a PCIe riser card, but it could refer to any x4 or x8 device attached to t=
he IIO unit and using lanes starting at lane 8 of the 16 lanes supported by=
 the bus.",
         "UMask": "0x01",
@@ -924,7 +924,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part3 by a un=
it on the main die (generally a core) or by another IIO unit. In the genera=
l case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PC=
Ie riser card, but it could brefer to  any device attached to the IIO unit =
using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -936,7 +936,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every peer to peer read request for u=
p to a 64 byte transaction of data made by a different IIO unit to the MMIO=
 space of a card on IIO Part0. Does not include requests made by the same I=
IO unit. In the general case, part0 refers to a standard PCIe card of any s=
ize (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 =
could also refer to any device plugged into the first slot of a PCIe riser =
card or to a device attached to the IIO unit which starts its use of the bu=
s using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x08",
@@ -948,7 +948,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every peer to peer read request for u=
p to a 64 byte transaction of data made by a different IIO unit to the MMIO=
 space of a card on IIO Part1. Does not include requests made by the same I=
IO unit. In the general case, Part1 refers to a x4 PCIe card plugged into t=
he second slot of a PCIe riser card, but it could refer to any x4 device at=
tached to the IIO unit using lanes starting at lane 4 of the 16 lanes suppo=
rted by the bus.",
         "UMask": "0x08",
@@ -960,7 +960,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every peer to peer read request for u=
p to a 64 byte transaction of data made by a different IIO unit to the MMIO=
 space of a card on IIO Part2. Does not include requests made by the same I=
IO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugged =
into the third slot of a PCIe riser card, but it could refer to any x4 or x=
8 device attached to the IIO unit and using lanes starting at lane 8 of the=
 16 lanes supported by the bus.",
         "UMask": "0x08",
@@ -972,7 +972,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every peer to peer read request for u=
p to a 64 byte transaction of data made by a different IIO unit to the MMIO=
 space of a card on IIO Part3. Does not include requests made by the same I=
IO unit. In the general case, Part3 refers to a x4 PCIe card plugged into t=
he fourth slot of a PCIe riser card, but it could brefer to  any device att=
ached to the IIO unit using the lanes starting at lane 12 of the 16 lanes s=
upported by the bus.",
         "UMask": "0x08",
@@ -984,7 +984,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made to the MMIO space of a card on IIO =
Part0 by a different IIO unit. Does not include requests made by the same I=
IO unit. In the general case, Part0 refers to a standard PCIe card of any s=
ize (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 =
could also refer to any device plugged into the first slot of a PCIe riser =
card or to a device attached to the IIO unit which starts its use of the bu=
s using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x02",
@@ -996,7 +996,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made to the MMIO space of a card on IIO =
Part1 by a different IIO unit. Does not include requests made by the same I=
IO unit. In the general case, Part1 refers to a x4 PCIe card plugged into t=
he second slot of a PCIe riser card, but it could refer to any x4 device at=
tached to the IIO unit using lanes starting at lane 4 of the 16 lanes suppo=
rted by the bus.",
         "UMask": "0x02",
@@ -1008,7 +1008,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made to the MMIO space of a card on IIO =
Part2 by a different IIO unit. Does not include requests made by the same I=
IO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugged =
into the third slot of a PCIe riser card, but it could refer to any x4 or x=
8 device attached to the IIO unit and using lanes starting at lane 8 of the=
 16 lanes supported by the bus.",
         "UMask": "0x02",
@@ -1020,7 +1020,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made to the MMIO space of a card on IIO =
Part3 by a different IIO unit. Does not include requests made by the same I=
IO unit. In the general case, Part3 refers to a x4 PCIe card plugged into t=
he fourth slot of a PCIe riser card, but it could brefer to  any device att=
ached to the IIO unit using the lanes starting at lane 12 of the 16 lanes s=
upported by the bus.",
         "UMask": "0x02",
@@ -1032,7 +1032,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part0 to a unit on the main die (generall=
y memory). In the general case, Part0 refers to a standard PCIe card of any=
 size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part=
0 could also refer to any device plugged into the first slot of a PCIe rise=
r card or to a device attached to the IIO unit which starts its use of the =
bus using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -1044,7 +1044,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part1 to a unit on the main die (generall=
y memory). In the general case, Part1 refers to a x4 PCIe card plugged into=
 the second slot of a PCIe riser card, but it could refer to any x4 device =
attached to the IIO unit using lanes starting at lane 4 of the 16 lanes sup=
ported by the bus.",
         "UMask": "0x04",
@@ -1056,7 +1056,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part2 to a unit on the main die (generall=
y memory). In the general case, Part2 refers to a x4 or x8 PCIe card plugge=
d into the third slot of a PCIe riser card, but it could refer to any x4 or=
 x8 device attached to the IIO unit and using lanes starting at lane 8 of t=
he 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -1068,7 +1068,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part3 to a unit on the main die (generall=
y memory). In the general case, Part3 refers to a x4 PCIe card plugged into=
 the fourth slot of a PCIe riser card, but it could brefer to  any device a=
ttached to the IIO unit using the lanes starting at lane 12 of the 16 lanes=
 supported by the bus.",
         "UMask": "0x04",
@@ -1080,7 +1080,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part0 to a unit on the main die (generall=
y memory). In the general case, Part0 refers to a standard PCIe card of any=
 size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part=
0 could also refer to any device plugged into the first slot of a PCIe rise=
r card or to a device attached to the IIO unit which starts its use of the =
bus using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -1092,7 +1092,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part1 to a unit on the main die (generall=
y memory). In the general case, Part1 refers to a x4 PCIe card plugged into=
 the second slot of a PCIe riser card, but it could refer to any x4 device =
attached to the IIO unit using lanes starting at lane 4 of the 16 lanes sup=
ported by the bus.",
         "UMask": "0x01",
@@ -1104,7 +1104,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part2 to a unit on the main die (generall=
y memory). In the general case, Part2 refers to a x4 or x8 PCIe card plugge=
d into the third slot of a PCIe riser card, but it could refer to any x4 or=
 x8 device attached to the IIO unit and using lanes starting at lane 8 of t=
he 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -1116,7 +1116,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part3 to a unit on the main die (generall=
y memory). In the general case, Part3 refers to a x4 PCIe card plugged into=
 the fourth slot of a PCIe riser card, but it could brefer to  any device a=
ttached to the IIO unit using the lanes starting at lane 12 of the 16 lanes=
 supported by the bus.",
         "UMask": "0x01",
@@ -1128,7 +1128,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every peer to peer read request of up=
 to a 64 byte transaction made by IIO Part0 to the MMIO space of an IIO tar=
get. In the general case, Part0 refers to a standard PCIe card of any size =
(x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 coul=
d also refer to any device plugged into the first slot of a PCIe riser card=
 or to a device attached to the IIO unit which starts its use of the bus us=
ing lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x08",
@@ -1140,7 +1140,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every peer to peer read request of up=
 to a 64 byte transaction made by IIO Part1 to the MMIO space of an IIO tar=
get. In the general case, Part1 refers to a x4 PCIe card plugged into the s=
econd slot of a PCIe riser card, but it could refer to any x4 device attach=
ed to the IIO unit using lanes starting at lane 4 of the 16 lanes supported=
 by the bus.",
         "UMask": "0x08",
@@ -1152,7 +1152,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every peer to peer read request of up=
 to a 64 byte transaction made by IIO Part2 to the MMIO space of an IIO tar=
get. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into=
 the third slot of a PCIe riser card, but it could refer to any x4 or x8 de=
vice attached to the IIO unit and using lanes starting at lane 8 of the 16 =
lanes supported by the bus.",
         "UMask": "0x08",
@@ -1164,7 +1164,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every peer to peer read request of up=
 to a 64 byte transaction made by IIO Part3 to the MMIO space of an IIO tar=
get. In the general case, Part3 refers to a x4 PCIe card plugged into the f=
ourth slot of a PCIe riser card, but it could brefer to any device attached=
 to the IIO unit using the lanes starting at lane 12 of the 16 lanes suppor=
ted by the bus.",
         "UMask": "0x08",
@@ -1176,7 +1176,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made by IIO Part0 to the MMIO space of a=
n IIO target. In the general case, Part0 refers to a standard PCIe card of =
any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. P=
art0 could also refer to any device plugged into the first slot of a PCIe r=
iser card or to a device attached to the IIO unit which starts its use of t=
he bus using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x02",
@@ -1188,7 +1188,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made by IIO Part1 to the MMIO space of a=
n IIO target.In the general case, Part1 refers to a x4 PCIe card plugged in=
to the second slot of a PCIe riser card, but it could refer to any x4 devic=
e attached to the IIO unit using lanes starting at lane 4 of the 16 lanes s=
upported by the bus.",
         "UMask": "0x02",
@@ -1200,7 +1200,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made by IIO Part2 to the MMIO space of a=
n IIO target. In the general case, Part2 refers to a x4 or x8 PCIe card plu=
gged into the third slot of a PCIe riser card, but it could refer to any x4=
 or x8 device attached to the IIO unit and using lanes starting at lane 8 o=
f the 16 lanes supported by the bus.",
         "UMask": "0x02",
@@ -1212,7 +1212,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made by IIO Part3 to the MMIO space of a=
n IIO target. In the general case, Part3 refers to a x4 PCIe card plugged i=
nto the fourth slot of a PCIe riser card, but it could brefer to  any devic=
e attached to the IIO unit using the lanes starting at lane 12 of the 16 la=
nes supported by the bus.",
         "UMask": "0x02",
@@ -1223,7 +1223,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M2M_BYPASS_M2M_Egress.NOT_TAKEN",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts traffic in which the M2M (Mesh to Mem=
ory) to iMC (Memory Controller) bypass was not taken",
         "UMask": "0x2",
         "Unit": "M2M"
@@ -1233,7 +1233,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts cycles when direct to core mode (whic=
h bypasses the CHA) was disabled",
         "Unit": "M2M"
     },
@@ -1242,7 +1242,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M2M_DIRECT2CORE_TAKEN",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when messages were sent direct to cor=
e (bypassing the CHA)",
         "Unit": "M2M"
     },
@@ -1251,7 +1251,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts reads in which direct to core transac=
tions (which would have bypassed the CHA) were overridden",
         "Unit": "M2M"
     },
@@ -1260,7 +1260,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_CREDITS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts reads in which direct to Intel Ultra =
Path Interconnect (UPI) transactions (which would have bypassed the CHA) we=
re overridden",
         "Unit": "M2M"
     },
@@ -1269,7 +1269,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts cycles when the ability to send messa=
ges direct to the Intel Ultra Path Interconnect (bypassing the CHA) was dis=
abled",
         "Unit": "M2M"
     },
@@ -1278,7 +1278,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_M2M_DIRECT2UPI_TAKEN",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when messages were sent direct to the=
 Intel Ultra Path Interconnect (bypassing the CHA)",
         "Unit": "M2M"
     },
@@ -1287,7 +1287,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_M2M_DIRECT2UPI_TXN_OVERRIDE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a read message that was sent dir=
ect to the Intel Ultra Path Interconnect (bypassing the CHA) was overridden=
",
         "Unit": "M2M"
     },
@@ -1296,7 +1296,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2D",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.ANY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state, and found the cacheline mar=
ked in Any State (A, I, S or unused)",
         "UMask": "0x1",
         "Unit": "M2M"
@@ -1306,7 +1306,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2D",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_A",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state, and found the cacheline mar=
ked in the A (SnoopAll) state, indicating the cacheline is stored in anothe=
r socket in any state, and we must snoop the other sockets to make sure we =
get the latest data.  The data may be stored in any state in the local sock=
et.",
         "UMask": "0x8",
         "Unit": "M2M"
@@ -1316,7 +1316,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2D",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_I",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state , and found the cacheline ma=
rked in the I (Invalid) state indicating the cacheline is not stored in ano=
ther socket, and so there is no need to snoop the other sockets for the lat=
est data.  The data may be stored in any state in the local socket.",
         "UMask": "0x2",
         "Unit": "M2M"
@@ -1326,7 +1326,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2D",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_S",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state , and found the cacheline ma=
rked in the S (Shared) state indicating the cacheline is either stored in a=
nother socket in the S(hared) state , and so there is no need to snoop the =
other sockets for the latest data.  The data may be stored in any state in =
the local socket.",
         "UMask": "0x4",
         "Unit": "M2M"
@@ -1336,7 +1336,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2I",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from A (SnoopAll) to I (In=
valid)",
         "UMask": "0x20",
         "Unit": "M2M"
@@ -1346,7 +1346,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2S",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from A (SnoopAll) to S (Sh=
ared)",
         "UMask": "0x40",
         "Unit": "M2M"
@@ -1356,7 +1356,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.ANY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory to a new state",
         "UMask": "0x1",
         "Unit": "M2M"
@@ -1366,7 +1366,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2A",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from I (Invalid) to A (Sno=
opAll)",
         "UMask": "0x4",
         "Unit": "M2M"
@@ -1376,7 +1376,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2S",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from I (Invalid) to S (Sha=
red)",
         "UMask": "0x2",
         "Unit": "M2M"
@@ -1386,7 +1386,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2A",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from S (Shared) to A (Snoo=
pAll)",
         "UMask": "0x10",
         "Unit": "M2M"
@@ -1396,7 +1396,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2I",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from S (Shared) to I (Inva=
lid)",
         "UMask": "0x8",
         "Unit": "M2M"
@@ -1406,7 +1406,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_M2M_IMC_READS.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
reads to the iMC (Memory Controller).",
         "UMask": "0x4",
         "Unit": "M2M"
@@ -1416,7 +1416,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_M2M_IMC_READS.NORMAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
reads to the iMC (Memory Controller).  It only counts  normal priority non-=
isochronous reads.",
         "UMask": "0x1",
         "Unit": "M2M"
@@ -1426,7 +1426,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_M2M_IMC_READS.TO_PMM",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "M2M Reads Issued to iMC; All, regardless of =
priority.",
         "UMask": "0x8",
         "Unit": "M2M"
@@ -1436,7 +1436,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_M2M_IMC_WRITES.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
writes to the iMC (Memory Controller).",
         "UMask": "0x10",
         "Unit": "M2M"
@@ -1446,7 +1446,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_M2M_IMC_WRITES.NI",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "M2M Writes Issued to iMC; All, regardless of=
 priority.",
         "UMask": "0x80",
         "Unit": "M2M"
@@ -1456,7 +1456,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_M2M_IMC_WRITES.PARTIAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
partial writes to the iMC (Memory Controller).  It only counts normal prior=
ity non-isochronous writes.",
         "UMask": "0x2",
         "Unit": "M2M"
@@ -1466,7 +1466,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_M2M_IMC_WRITES.TO_PMM",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "M2M Writes Issued to iMC; All, regardless of=
 priority.",
         "UMask": "0x20",
         "Unit": "M2M"
@@ -1476,7 +1476,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_PROMOTIONS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) promote=
s a outstanding request in the prefetch queue due to a subsequent demand re=
ad request that entered the M2M with the same address.  Explanatory Side No=
te: The Prefecth queue is made of CAM (Content Addressable Memory)",
         "Unit": "M2M"
     },
@@ -1485,7 +1485,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x57",
         "EventName": "UNC_M2M_PREFCAM_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) recieve=
s a prefetch request and inserts it into its outstanding prefetch queue.  E=
xplanatory Side Note: the prefect queue is made from CAM: Content Addressab=
le Memory",
         "Unit": "M2M"
     },
@@ -1494,7 +1494,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M2M_RxC_AD_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the a new entry is Received(RxC)=
 and then added to the AD (Address Ring) Ingress Queue from the CMS (Common=
 Mesh Stop).  This is generally used for reads, and",
         "Unit": "M2M"
     },
@@ -1503,7 +1503,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M2M_RxC_AD_OCCUPANCY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "AD Ingress (from CMS) Occupancy",
         "Unit": "M2M"
     },
@@ -1512,7 +1512,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_M2M_RxC_BL_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "BL Ingress (from CMS) Allocations",
         "Unit": "M2M"
     },
@@ -1521,7 +1521,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_M2M_RxC_BL_OCCUPANCY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "BL Ingress (from CMS) Occupancy",
         "Unit": "M2M"
     },
@@ -1530,7 +1530,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_M2M_TAG_HIT.NM_RD_HIT_DIRTY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Tag Hit; Read Hit from NearMem, Dirty  Line",
         "UMask": "0x02",
         "Unit": "M2M"
@@ -1540,7 +1540,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_M2M_TAG_HIT.NM_UFILL_HIT_CLEAN",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Tag Hit; Underfill Rd Hit from NearMem, Clea=
n Line",
         "UMask": "0x04",
         "Unit": "M2M"
@@ -1550,7 +1550,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2C",
         "EventName": "UNC_M2M_TAG_HIT.NM_UFILL_HIT_DIRTY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Tag Hit; Underfill Rd Hit from NearMem, Dirt=
y  Line",
         "UMask": "0x08",
         "Unit": "M2M"
@@ -1560,7 +1560,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x9",
         "EventName": "UNC_M2M_TxC_AD_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "AD Egress (to CMS) Allocations",
         "Unit": "M2M"
     },
@@ -1569,7 +1569,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xA",
         "EventName": "UNC_M2M_TxC_AD_OCCUPANCY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "AD Egress (to CMS) Occupancy",
         "Unit": "M2M"
     },
@@ -1578,7 +1578,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x15",
         "EventName": "UNC_M2M_TxC_BL_INSERTS.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "BL Egress (to CMS) Allocations; All",
         "UMask": "0x03",
         "Unit": "M2M"
@@ -1588,7 +1588,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_M2M_TxC_BL_OCCUPANCY.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "BL Egress (to CMS) Occupancy; All",
         "UMask": "0x03",
         "Unit": "M2M"
@@ -1598,7 +1598,7 @@
         "Counter": "0,1,2",
         "EventCode": "0x29",
         "EventName": "UNC_M3UPI_UPI_PREFETCH_SPAWN",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Count cases where flow control queue that si=
ts between the Intel Ultra Path Interconnect (UPI) and the mesh spawns a pr=
efetch to the iMC (Memory Controller)",
         "Unit": "M3UPI"
     },
@@ -1607,7 +1607,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_UPI_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts clockticks of the fixed frequency clo=
ck controlling the Intel Ultra Path Interconnect (UPI).  This clock runs at=
1/8th the 'GT/s' speed of the UPI link.  For example, a  9.6GT/s  link will=
 have a fixed Frequency of 1.2 Ghz.",
         "Unit": "UPI LL"
     },
@@ -1616,7 +1616,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2C",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts Data Response (DRS) packets that atte=
mpted to go direct to core bypassing the CHA.",
         "UMask": "0x1",
         "Unit": "UPI LL"
@@ -1626,7 +1626,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2U",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts Data Response (DRS) packets that atte=
mpted to go direct to Intel Ultra Path Interconnect (UPI) bypassing the CHA=
 .",
         "UMask": "0x2",
         "Unit": "UPI LL"
@@ -1636,7 +1636,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_UPI_L1_POWER_CYCLES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts cycles when the Intel Ultra Path Inte=
rconnect (UPI) is in L1 power mode.  L1 is a mode that totally shuts down t=
he UPI link.  Link power states are per link and per direction, so for exam=
ple the Tx direction could be in one state while Rx was in another, this ev=
ent only coutns when both links are shutdown.",
         "Unit": "UPI LL"
     },
@@ -1645,7 +1645,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts cycles when the the receive side (Rx)=
 of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a m=
ode where we disable 60% of the UPI lanes, decreasing our bandwidth in orde=
r to save power.",
         "Unit": "UPI LL"
     },
@@ -1654,7 +1654,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to t=
he Egress.  This is a latency optimization, and should generally be the com=
mon case.  If this value is less than the number of FLITs transfered, it im=
plies that there was queueing getting onto the ring, and thus the transacti=
ons saw higher latency.",
         "UMask": "0x1",
         "Unit": "UPI LL"
@@ -1664,7 +1664,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly acr=
oss the BGF and into the Egress.  This is a latency optimization, and shoul=
d generally be the common case.  If this value is less than the number of F=
LITs transfered, it implies that there was queueing getting onto the ring, =
and thus the transactions saw higher latency.",
         "UMask": "0x2",
         "Unit": "UPI LL"
@@ -1674,7 +1674,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hcih bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly to =
the Egress.  This is a latency optimization, and should generally be the co=
mmon case.  If this value is less than the number of FLITs transfered, it i=
mplies that there was queueing getting onto the ring, and thus the transact=
ions saw higher latency.",
         "UMask": "0x4",
         "Unit": "UPI LL"
@@ -1684,7 +1684,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts valid data FLITs  (80 bit FLow contro=
l unITs: 64bits of data) received from any of the 3 Intel Ultra Path Interc=
onnect (UPI) Receive Queue slots on this UPI unit.",
         "UMask": "0x0F",
         "Unit": "UPI LL"
@@ -1694,7 +1694,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts null FLITs (80 bit FLow control unITs=
) received from any of the 3 Intel Ultra Path Interconnect (UPI) Receive Qu=
eue slots on this UPI unit.",
         "UMask": "0x27",
         "Unit": "UPI LL"
@@ -1704,7 +1704,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts protocol header and credit FLITs  (80=
 bit FLow control unITs) received from any of the 3 UPI slots on this UPI u=
nit.",
         "UMask": "0x97",
         "Unit": "UPI LL"
@@ -1714,7 +1714,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts cycles when the transmit side (Tx) of=
 the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode=
 where we disable 60% of the UPI lanes, decreasing our bandwidth in order t=
o save power.",
         "Unit": "UPI LL"
     },
@@ -1723,7 +1723,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_UPI_TxL_BYPASSED",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the TxL(transmit) FLIT buffer and pass directly out the UPI L=
ink. Generally, when data is transmitted across the Intel Ultra Path Interc=
onnect (UPI), it will bypass the TxQ and pass directly to the link.  Howeve=
r, the TxQ will be used in L0p (Low Power) mode and (Link Layer Retry) LLR =
 mode, increasing latency to transfer out to the link.",
         "Unit": "UPI LL"
     },
@@ -1732,7 +1732,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts null FLITs (80 bit FLow control unITs=
) transmitted via any of the 3 Intel Ulra Path Interconnect (UPI) slots on =
this UPI unit.",
         "UMask": "0x27",
         "Unit": "UPI LL"
@@ -1742,7 +1742,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_UPI_TxL_FLITS.DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Shows legal flit time (hides impact of L0p a=
nd L0c).; Count Data Flits (which consume all slots), but how much to count=
 is based on Slot0-2 mask, so count can be 0-3 depending on which slots are=
 enabled for counting..",
         "UMask": "0x8",
         "Unit": "UPI LL"
@@ -1752,7 +1752,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_UPI_TxL_FLITS.IDLE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the Intel Ultra Path Interconnec=
t(UPI) transmits an idle FLIT(80 bit FLow control unITs).  Every UPI cycle =
must be sending either data FLITs, protocol/credit FLITs or idle FLITs.",
         "UMask": "0x47",
         "Unit": "UPI LL"
@@ -1762,7 +1762,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts protocol header and credit FLITs (80 =
bit FLow control unITs) transmitted across any of the 3 UPI (Ultra Path Int=
erconnect) slots on this UPI unit.",
         "UMask": "0x97",
         "Unit": "UPI LL"
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
index 58ed6d33d1f4..60b8e34de513 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
@@ -3,7 +3,7 @@
         "BriefDescription": "Uncore cache clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_C_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "CBO"
     },
     {
@@ -12,7 +12,7 @@
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.ANY",
         "Filter": "filter_state=3D0x1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x11",
         "Unit": "CBO"
@@ -22,7 +22,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -33,7 +33,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.DATA_READ",
         "Filter": "filter_opc=3D0x182",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -44,7 +44,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "filter_opc=3D0x187",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -55,7 +55,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_READ",
         "Filter": "filter_opc=3D0x187,filter_nc=3D1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -66,7 +66,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_WRITE",
         "Filter": "filter_opc=3D0x18f,filter_nc=3D1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -77,7 +77,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.RFO_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x190",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -88,7 +88,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x191",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -99,7 +99,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.DATA_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x192",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -110,7 +110,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -121,7 +121,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x1c8",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -132,7 +132,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_NON_SNOOP_WRITE",
         "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -143,7 +143,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
         "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -153,7 +153,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x181",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -164,7 +164,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_FULL",
         "Filter": "filter_opc=3D0x18c",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -175,7 +175,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
         "Filter": "filter_opc=3D0x18d",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -186,7 +186,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -197,7 +197,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -207,7 +207,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LLC_DATA_READ",
         "Filter": "filter_opc=3D0x182",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -216,7 +216,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "HA"
     },
@@ -225,7 +225,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -234,7 +234,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -243,7 +243,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0xC",
         "Unit": "HA"
     },
@@ -252,7 +252,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -261,7 +261,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -270,7 +270,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x40",
         "Unit": "HA"
     },
@@ -279,7 +279,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x20",
         "Unit": "HA"
@@ -289,7 +289,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x4",
         "Unit": "HA"
@@ -299,7 +299,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x2",
         "Unit": "HA"
@@ -309,7 +309,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x8",
         "Unit": "HA"
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
index 824961318c1e..5b2df265e712 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
@@ -4,14 +4,14 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_Q_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Number of data flits transmitted . Derived fr=
om unc_q_txl_flits_g0.data",
         "Counter": "0,1,2,3",
         "EventName": "QPI_DATA_BANDWIDTH_TX",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "8Bytes",
         "UMask": "0x2",
         "Unit": "QPI LL"
@@ -20,7 +20,7 @@
         "BriefDescription": "Number of non data (control) flits transmitte=
d . Derived from unc_q_txl_flits_g0.non_data",
         "Counter": "0,1,2,3",
         "EventName": "QPI_CTL_BANDWIDTH_TX",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "8Bytes",
         "UMask": "0x4",
         "Unit": "QPI LL"
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
index 66eed399724c..7415eef71559 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "iMC"
@@ -14,7 +14,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC",
         "Unit": "iMC"
@@ -23,7 +23,7 @@
         "BriefDescription": "Memory controller clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_M_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -33,7 +33,7 @@
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "MetricExpr": "(UNC_M_POWER_CHANNEL_PPD / UNC_M_CLOCKTICKS) * 100.=
",
         "MetricName": "power_channel_ppd %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -43,7 +43,7 @@
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
         "MetricExpr": "(UNC_M_POWER_CRITICAL_THROTTLE_CYCLES / UNC_M_CLOCK=
TICKS) * 100.",
         "MetricName": "power_critical_throttle_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -53,7 +53,7 @@
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_CLOCKTICKS) * 100=
.",
         "MetricName": "power_self_refresh %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -61,7 +61,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -70,7 +70,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.RD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -79,7 +79,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.WR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x8",
         "Unit": "iMC"
     }
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-power.json
index dd1b95655d1d..598678aaf67e 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
@@ -3,7 +3,7 @@
         "BriefDescription": "PCU clock ticks. Use to get percentages of PC=
U cycles events",
         "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -14,7 +14,7 @@
         "Filter": "occ_sel=3D1",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c0 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -25,7 +25,7 @@
         "Filter": "occ_sel=3D2",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C3 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c3 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -36,7 +36,7 @@
         "Filter": "occ_sel=3D3",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C6 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c6 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -46,7 +46,7 @@
         "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
         "MetricExpr": "(UNC_P_PROCHOT_EXTERNAL_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
         "MetricName": "prochot_external_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -56,7 +56,7 @@
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES / UNC_P_CLOCKT=
ICKS) * 100.",
         "MetricName": "freq_max_limit_thermal_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -66,7 +66,7 @@
         "EventName": "UNC_P_FREQ_MAX_OS_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_OS_CYCLES / UNC_P_CLOCKTICKS) * 100=
.",
         "MetricName": "freq_max_os_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -76,7 +76,7 @@
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_POWER_CYCLES / UNC_P_CLOCKTICKS) * =
100.",
         "MetricName": "freq_max_power_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -86,7 +86,7 @@
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_TRANS_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_trans_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
index 267410594833..09abc07dc5fa 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
@@ -3,7 +3,7 @@
         "BriefDescription": "Uncore cache clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_C_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "CBO"
     },
     {
@@ -12,7 +12,7 @@
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.ANY",
         "Filter": "filter_state=3D0x1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x11",
         "Unit": "CBO"
@@ -22,7 +22,7 @@
         "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -33,7 +33,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.DATA_READ",
         "Filter": "filter_opc=3D0x182",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -44,7 +44,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "filter_opc=3D0x187",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -55,7 +55,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.RFO_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x190",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -66,7 +66,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.CODE_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x191",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -77,7 +77,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.DATA_LLC_PREFETCH",
         "Filter": "filter_opc=3D0x192",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -88,7 +88,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x19c",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -99,7 +99,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -110,7 +110,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.ITOM_WRITE",
         "Filter": "filter_opc=3D0x1c8",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -121,7 +121,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_NON_SNOOP_READ",
         "Filter": "filter_opc=3D0x1e4",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -132,7 +132,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_NON_SNOOP_WRITE",
         "Filter": "filter_opc=3D0x1e6",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -143,7 +143,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_FULL",
         "Filter": "filter_opc=3D0x18c",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -154,7 +154,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
         "Filter": "filter_opc=3D0x18d",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -165,7 +165,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_PARTIAL_READ",
         "Filter": "filter_opc=3D0x195",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -176,7 +176,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x19c",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -187,7 +187,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -198,7 +198,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.ITOM_WRITE",
         "Filter": "filter_opc=3D0x1c8",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -209,7 +209,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_NS_READ",
         "Filter": "filter_opc=3D0x1e4",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -220,7 +220,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
         "Filter": "filter_opc=3D0x1e5",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -231,7 +231,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_NS_WRITE",
         "Filter": "filter_opc=3D0x1e6",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -240,7 +240,7 @@
         "BriefDescription": "Occupancy for all LLC misses that are address=
ed to local memory",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x2A",
         "Unit": "CBO"
     },
@@ -249,7 +249,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LLC_DATA_READ",
         "Filter": "filter_opc=3D0x182",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -257,7 +257,7 @@
         "BriefDescription": "Occupancy for all LLC misses that are address=
ed to remote memory",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x8A",
         "Unit": "CBO"
     },
@@ -266,7 +266,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "HA"
     },
@@ -275,7 +275,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0xC",
         "Unit": "HA"
     },
@@ -284,7 +284,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x20",
         "Unit": "HA"
@@ -294,7 +294,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x4",
         "Unit": "HA"
@@ -304,7 +304,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x2",
         "Unit": "HA"
@@ -314,7 +314,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x8",
         "Unit": "HA"
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
index b798a860bc81..f7a98c8fd3a4 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_Q_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "QPI LL"
     },
     {
@@ -14,7 +14,7 @@
         "EventName": "UNC_Q_RxL0P_POWER_CYCLES",
         "MetricExpr": "(UNC_Q_RxL0P_POWER_CYCLES / UNC_Q_CLOCKTICKS) * 100=
.",
         "MetricName": "rxl0p_power_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "QPI LL"
     },
     {
@@ -24,14 +24,14 @@
         "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
         "MetricExpr": "(UNC_Q_TxL0P_POWER_CYCLES / UNC_Q_CLOCKTICKS) * 100=
.",
         "MetricName": "txl0p_power_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Number of data flits transmitted ",
         "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "8Bytes",
         "UMask": "0x2",
         "Unit": "QPI LL"
@@ -40,7 +40,7 @@
         "BriefDescription": "Number of non data (control) flits transmitte=
d ",
         "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "8Bytes",
         "UMask": "0x4",
         "Unit": "QPI LL"
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json b/to=
ols/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
index df4b43294fa0..af9fe5598b40 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.RD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Umask": "0x3",
         "Unit": "iMC"
@@ -14,7 +14,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "iMC"
@@ -24,7 +24,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC",
         "Unit": "iMC"
@@ -33,7 +33,7 @@
         "BriefDescription": "Memory controller clock ticks. Use to generat=
e percentages for memory controller CYCLES events",
         "Counter": "0,1,2,3",
         "EventName": "UNC_M_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -43,7 +43,7 @@
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "MetricExpr": "(UNC_M_POWER_CHANNEL_PPD / UNC_M_CLOCKTICKS) * 100.=
",
         "MetricName": "power_channel_ppd %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -53,7 +53,7 @@
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
         "MetricExpr": "(UNC_M_POWER_CRITICAL_THROTTLE_CYCLES / UNC_M_CLOCK=
TICKS) * 100.",
         "MetricName": "power_critical_throttle_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -63,7 +63,7 @@
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_CLOCKTICKS) * 100=
.",
         "MetricName": "power_self_refresh %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -71,7 +71,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "iMC"
     }
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-power.json
index 635c09fda1d9..187ac567a0af 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
@@ -3,7 +3,7 @@
         "BriefDescription": "PCU clock ticks. Use to get percentages of PC=
U cycles events",
         "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -13,7 +13,7 @@
         "EventName": "UNC_P_FREQ_BAND0_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_BAND0_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band0_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -23,7 +23,7 @@
         "EventName": "UNC_P_FREQ_BAND1_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_BAND1_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band1_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -33,7 +33,7 @@
         "EventName": "UNC_P_FREQ_BAND2_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_BAND2_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band2_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -43,7 +43,7 @@
         "EventName": "UNC_P_FREQ_BAND3_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_BAND3_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band3_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -54,7 +54,7 @@
         "Filter": "edge=3D1",
         "MetricExpr": "(UNC_P_FREQ_BAND0_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band0_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -65,7 +65,7 @@
         "Filter": "edge=3D1",
         "MetricExpr": "(UNC_P_FREQ_BAND1_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band1_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -76,7 +76,7 @@
         "Filter": "edge=3D1",
         "MetricExpr": "(UNC_P_FREQ_BAND2_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band2_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -87,7 +87,7 @@
         "Filter": "edge=3D1",
         "MetricExpr": "(UNC_P_FREQ_BAND3_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band3_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -98,7 +98,7 @@
         "Filter": "occ_sel=3D1",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c0 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -109,7 +109,7 @@
         "Filter": "occ_sel=3D2",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C3 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c3 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -120,7 +120,7 @@
         "Filter": "occ_sel=3D3",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C6 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c6 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -130,7 +130,7 @@
         "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
         "MetricExpr": "(UNC_P_PROCHOT_EXTERNAL_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
         "MetricName": "prochot_external_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -140,7 +140,7 @@
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES / UNC_P_CLOCKT=
ICKS) * 100.",
         "MetricName": "freq_max_limit_thermal_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -150,7 +150,7 @@
         "EventName": "UNC_P_FREQ_MAX_OS_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_OS_CYCLES / UNC_P_CLOCKTICKS) * 100=
.",
         "MetricName": "freq_max_os_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -160,7 +160,7 @@
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_POWER_CYCLES / UNC_P_CLOCKTICKS) * =
100.",
         "MetricName": "freq_max_power_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -170,7 +170,7 @@
         "EventName": "UNC_P_FREQ_MAX_CURRENT_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_CURRENT_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
         "MetricName": "freq_max_current_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -180,7 +180,7 @@
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_TRANS_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_trans_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -191,7 +191,7 @@
         "Filter": "filter_band0=3D12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -202,7 +202,7 @@
         "Filter": "filter_band1=3D20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -213,7 +213,7 @@
         "Filter": "filter_band2=3D30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -224,7 +224,7 @@
         "Filter": "filter_band3=3D40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -235,7 +235,7 @@
         "Filter": "edge=3D1,filter_band0=3D12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -246,7 +246,7 @@
         "Filter": "edge=3D1,filter_band1=3D20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -257,7 +257,7 @@
         "Filter": "edge=3D1,filter_band2=3D30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -268,7 +268,7 @@
         "Filter": "edge=3D1,filter_band3=3D40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
index 3fa61d962607..98c58b0cf32e 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
@@ -3,7 +3,7 @@
         "BriefDescription": "Uncore cache clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_C_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "CBO"
     },
     {
@@ -12,7 +12,7 @@
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.ANY",
         "Filter": "filter_state=3D0x1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x11",
         "Unit": "CBO"
@@ -22,7 +22,7 @@
         "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -33,7 +33,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.DATA_READ",
         "Filter": "filter_opc=3D0x182",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -44,7 +44,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "filter_opc=3D0x187",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -55,7 +55,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x19c",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -66,7 +66,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.ITOM_WRITE",
         "Filter": "filter_opc=3D0x1c8",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
@@ -77,7 +77,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_FULL",
         "Filter": "filter_opc=3D0x18c",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -88,7 +88,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
         "Filter": "filter_opc=3D0x18d",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -99,7 +99,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_PARTIAL_READ",
         "Filter": "filter_opc=3D0x195",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -110,7 +110,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_WRITE",
         "Filter": "filter_opc=3D0x19c",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -121,7 +121,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_READ",
         "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -132,7 +132,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.ITOM_WRITE",
         "Filter": "filter_opc=3D0x1c8",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -143,7 +143,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_NS_READ",
         "Filter": "filter_opc=3D0x1e4",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -154,7 +154,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
         "Filter": "filter_opc=3D0x1e5",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -165,7 +165,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.PCIE_NS_WRITE",
         "Filter": "filter_opc=3D0x1e6",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
@@ -177,7 +177,7 @@
         "Filter": "filter_opc=3D0x182",
         "MetricExpr": "(UNC_C_TOR_OCCUPANCY.MISS_ALL / UNC_C_CLOCKTICKS) *=
 100.",
         "MetricName": "tor_occupancy.miss_all %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0xa",
         "Unit": "CBO"
     },
@@ -185,7 +185,7 @@
         "BriefDescription": "Occupancy counter for LLC data reads (demand =
and L2 prefetch). Derived from unc_c_tor_occupancy.miss_opcode.llc_data_rea=
d",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LLC_DATA_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -194,7 +194,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.READS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "HA"
     },
@@ -203,7 +203,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_H_REQUESTS.WRITES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0xc",
         "Unit": "HA"
     }
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
index 1b53c0e609e3..a2c9ade947da 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_Q_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "QPI LL"
     },
     {
@@ -14,7 +14,7 @@
         "EventName": "UNC_Q_RxL0P_POWER_CYCLES",
         "MetricExpr": "(UNC_Q_RxL0P_POWER_CYCLES / UNC_Q_CLOCKTICKS) * 100=
.",
         "MetricName": "rxl0p_power_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "QPI LL"
     },
     {
@@ -24,14 +24,14 @@
         "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
         "MetricExpr": "(UNC_Q_TxL0P_POWER_CYCLES / UNC_Q_CLOCKTICKS) * 100=
.",
         "MetricName": "txl0p_power_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "QPI LL"
     },
     {
         "BriefDescription": "Number of data flits transmitted ",
         "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "8Bytes",
         "UMask": "0x2",
         "Unit": "QPI LL"
@@ -40,7 +40,7 @@
         "BriefDescription": "Number of non data (control) flits transmitte=
d ",
         "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "8Bytes",
         "UMask": "0x4",
         "Unit": "QPI LL"
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
index 8551cebeba23..b59d196c9c1c 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -12,7 +12,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x3",
         "Unit": "iMC"
     },
@@ -21,7 +21,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0xc",
         "Unit": "iMC"
     },
@@ -29,7 +29,7 @@
         "BriefDescription": "Memory controller clock ticks. Used to get pe=
rcentages of memory controller cycles events",
         "Counter": "0,1,2,3",
         "EventName": "UNC_M_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -39,7 +39,7 @@
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "MetricExpr": "(UNC_M_POWER_CHANNEL_PPD / UNC_M_CLOCKTICKS) * 100.=
",
         "MetricName": "power_channel_ppd %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -49,7 +49,7 @@
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
         "MetricExpr": "(UNC_M_POWER_CRITICAL_THROTTLE_CYCLES / UNC_M_CLOCK=
TICKS) * 100.",
         "MetricName": "power_critical_throttle_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -59,7 +59,7 @@
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_CLOCKTICKS) * 100=
.",
         "MetricName": "power_self_refresh %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -67,7 +67,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -76,7 +76,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_M_RPQ_OCCUPANCY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index 8755693d86c6..5e4d01b33631 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -3,7 +3,7 @@
         "BriefDescription": "PCU clock ticks. Use to get percentages of PC=
U cycles events",
         "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -13,7 +13,7 @@
         "EventName": "UNC_P_FREQ_BAND0_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_BAND0_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band0_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -23,7 +23,7 @@
         "EventName": "UNC_P_FREQ_BAND1_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_BAND1_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band1_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -33,7 +33,7 @@
         "EventName": "UNC_P_FREQ_BAND2_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_BAND2_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band2_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -43,7 +43,7 @@
         "EventName": "UNC_P_FREQ_BAND3_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_BAND3_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band3_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -54,7 +54,7 @@
         "Filter": "edge=3D1",
         "MetricExpr": "(UNC_P_FREQ_BAND0_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band0_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -65,7 +65,7 @@
         "Filter": "edge=3D1",
         "MetricExpr": "(UNC_P_FREQ_BAND1_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band1_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -76,7 +76,7 @@
         "Filter": "edge=3D1",
         "MetricExpr": "(UNC_P_FREQ_BAND2_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band2_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -87,7 +87,7 @@
         "Filter": "edge=3D1",
         "MetricExpr": "(UNC_P_FREQ_BAND3_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_band3_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -98,7 +98,7 @@
         "Filter": "occ_sel=3D1",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c0 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -109,7 +109,7 @@
         "Filter": "occ_sel=3D2",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C3 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c3 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -120,7 +120,7 @@
         "Filter": "occ_sel=3D3",
         "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C6 / UNC_P_CLOCK=
TICKS) * 100.",
         "MetricName": "power_state_occupancy.cores_c6 %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -130,7 +130,7 @@
         "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
         "MetricExpr": "(UNC_P_PROCHOT_EXTERNAL_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
         "MetricName": "prochot_external_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -140,7 +140,7 @@
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES / UNC_P_CLOCKT=
ICKS) * 100.",
         "MetricName": "freq_max_limit_thermal_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -150,7 +150,7 @@
         "EventName": "UNC_P_FREQ_MAX_OS_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_OS_CYCLES / UNC_P_CLOCKTICKS) * 100=
.",
         "MetricName": "freq_max_os_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -160,7 +160,7 @@
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_POWER_CYCLES / UNC_P_CLOCKTICKS) * =
100.",
         "MetricName": "freq_max_power_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -170,7 +170,7 @@
         "EventName": "UNC_P_FREQ_MAX_CURRENT_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_MAX_CURRENT_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
         "MetricName": "freq_max_current_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -179,7 +179,7 @@
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
         "MetricExpr": "(UNC_P_FREQ_TRANS_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
         "MetricName": "freq_trans_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -190,7 +190,7 @@
         "Filter": "filter_band0=3D12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -201,7 +201,7 @@
         "Filter": "filter_band1=3D20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -212,7 +212,7 @@
         "Filter": "filter_band2=3D30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -223,7 +223,7 @@
         "Filter": "filter_band3=3D40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -234,7 +234,7 @@
         "Filter": "edge=3D1,filter_band0=3D12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -245,7 +245,7 @@
         "Filter": "edge=3D1,filter_band1=3D20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -256,7 +256,7 @@
         "Filter": "edge=3D1,filter_band2=3D30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     },
     {
@@ -267,7 +267,7 @@
         "Filter": "edge=3D1,filter_band3=3D40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "PCU"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
index e3bcd86c4f56..d31b6d5a4e0a 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_CAS_COUNT.RD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "6.4e-05MiB",
         "UMask": "0x01",
         "Unit": "imc"
@@ -14,7 +14,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_CAS_COUNT.WR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "6.4e-05MiB",
         "UMask": "0x02",
         "Unit": "imc"
@@ -24,7 +24,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_E_RPQ_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "6.4e-05MiB",
         "UMask": "0x01",
         "Unit": "edc_eclk"
@@ -34,7 +34,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_E_WPQ_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "6.4e-05MiB",
         "UMask": "0x01",
         "Unit": "edc_eclk"
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
index 9c7e5f8beee2..fb4516c8efac 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "iMC"
@@ -14,7 +14,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC",
         "Unit": "iMC"
@@ -23,7 +23,7 @@
         "BriefDescription": "Memory controller clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_M_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -33,7 +33,7 @@
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
         "MetricExpr": "(UNC_M_POWER_CHANNEL_PPD / UNC_M_CLOCKTICKS) * 100.=
",
         "MetricName": "power_channel_ppd %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -43,7 +43,7 @@
         "EventName": "UNC_M_POWER_SELF_REFRESH",
         "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_CLOCKTICKS) * 100=
.",
         "MetricName": "power_self_refresh %",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -51,7 +51,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1",
         "Unit": "iMC"
     },
@@ -60,7 +60,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.RD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x4",
         "Unit": "iMC"
     },
@@ -69,7 +69,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.WR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x8",
         "Unit": "iMC"
     },
@@ -78,7 +78,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.WR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts DRAM Page Activate commands sent on t=
his channel due to a write request to the iMC (Memory Controller).  Activat=
e commands are issued to open up a page on the DRAM devices so that it can =
be read or written to with a CAS (Column Access Select) command.",
         "UMask": "0x2",
         "Unit": "iMC"
@@ -88,7 +88,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts all CAS (Column Address Select) comma=
nds issued to DRAM per memory channel.  CAS commands are issued to specify =
the address to read or write on DRAM, so this event increments for every re=
ad and write. This event counts whether AutoPrecharge (which closes the DRA=
M Page automatically after a read/write) is enabled or not.",
         "UMask": "0xF",
         "Unit": "iMC"
@@ -98,7 +98,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "iMC"
@@ -108,7 +108,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_REG",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts CAS (Column Access Select) regular re=
ad commands issued to DRAM on a per channel basis.  CAS commands are issued=
 to specify the address to read or write on DRAM, and this event increments=
 for every regular read.  This event only counts regular reads and does not=
 includes underfill reads due to partial write requests.  This event counts=
 whether AutoPrecharge (which closes the DRAM Page automatically after a re=
ad/write)  is enabled or not.",
         "UMask": "0x1",
         "Unit": "iMC"
@@ -118,7 +118,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts CAS (Column Access Select) underfill =
read commands issued to DRAM due to a partial write, on a per channel basis=
.  CAS commands are issued to specify the address to read or write on DRAM,=
 and this command counts underfill reads.  Partial writes must be completed=
 by first reading in the underfill from DRAM and then merging in the partia=
l write data before writing the full line back to DRAM. This event will gen=
erally count about the same as the number of partial writes, but may be sli=
ghtly less because of partials hitting in the WPQ (due to a previous write =
request). ",
         "UMask": "0x2",
         "Unit": "iMC"
@@ -128,7 +128,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "LLC_MISSES.MEM_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC",
         "Unit": "iMC"
@@ -138,7 +138,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of read requests allocated=
 into the Read Pending Queue (RPQ).  This queue is used to schedule reads o=
ut to the memory controller and to track the requests.  Requests allocate i=
nto the RPQ soon after they enter the memory controller, and need credits f=
or an entry in this buffer before being sent from the CHA to the iMC.  The =
requests deallocate after the read CAS command has been issued to DRAM.  Th=
is event counts both Isochronous and non-Isochronous requests which were is=
sued to the RPQ.    ",
         "Unit": "iMC"
     },
@@ -147,7 +147,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_M_RPQ_OCCUPANCY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of entries in the Read Pen=
ding Queue (RPQ) at each cycle.  This can then be used to calculate both th=
e average occupancy of the queue (in conjunction with the number of cycles =
not empty) and the average latency in the queue (in conjunction with the nu=
mber of allocations).  The RPQ is used to schedule reads out to the memory =
controller and to track the requests.  Requests allocate into the RPQ soon =
after they enter the memory controller, and need credits for an entry in th=
is buffer before being sent from the CHA to the iMC. They deallocate from t=
he RPQ after the CAS command has been issued to memory.",
         "Unit": "iMC"
     },
@@ -156,7 +156,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_M_WPQ_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of writes requests allocat=
ed into the Write Pending Queue (WPQ).  The WPQ is used to schedule writes =
out to the memory controller and to track the requests.  Requests allocate =
into the WPQ soon after they enter the memory controller, and need credits =
for an entry in this buffer before being sent from the CHA to the iMC (Memo=
ry Controller).  The write requests deallocate after being issued to DRAM. =
 Write requests themselves are able to complete (from the perspective of th=
e rest of the system) as soon they have 'posted' to the iMC.",
         "Unit": "iMC"
     },
@@ -165,7 +165,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "UNC_M_WPQ_OCCUPANCY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of entries in the Write Pe=
nding Queue (WPQ) at each cycle.  This can then be used to calculate both t=
he average queue occupancy (in conjunction with the number of cycles not em=
pty) and the average latency (in conjunction with the number of allocations=
).  The WPQ is used to schedule writes out to the memory controller and to =
track the requests.",
         "Unit": "iMC"
     }
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/skylakex/uncore-other.json
index adb42c72f5c8..b347f9aad2ef 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
@@ -3,7 +3,7 @@
         "BriefDescription": "Uncore cache clock ticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_CHA_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "CHA"
     },
     {
@@ -12,7 +12,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "config1=3D0x40e33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x21",
         "Unit": "CHA"
     },
@@ -22,7 +22,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_READ",
         "Filter": "config1=3D0x40040e33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x21",
         "Unit": "CHA"
     },
@@ -32,7 +32,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_WRITE",
         "Filter": "config1=3D0x40041e33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x21",
         "Unit": "CHA"
     },
@@ -42,7 +42,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_FULL",
         "Filter": "config1=3D0x41833",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -53,7 +53,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
         "Filter": "config1=3D0x41a33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -63,7 +63,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x03",
         "Unit": "CHA"
     },
@@ -72,7 +72,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x01",
         "Unit": "CHA"
     },
@@ -81,7 +81,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x02",
         "Unit": "CHA"
     },
@@ -90,7 +90,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x0C",
         "Unit": "CHA"
     },
@@ -99,7 +99,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x04",
         "Unit": "CHA"
     },
@@ -108,7 +108,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x08",
         "Unit": "CHA"
     },
@@ -117,7 +117,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UPI_DATA_BANDWIDTH_TX",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "7.11E-06Bytes",
         "UMask": "0x0F",
         "Unit": "UPI LL"
@@ -131,7 +131,7 @@
         "Filter": "ch_mask=3D0x1f",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC=
_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
         "MetricName": "LLC_MISSES.PCIE_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -146,7 +146,7 @@
         "Filter": "ch_mask=3D0x1f",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC=
_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
         "MetricName": "LLC_MISSES.PCIE_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -160,7 +160,7 @@
         "FCMask": "0x07",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC=
_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
         "MetricName": "LLC_MISSES.PCIE_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -172,7 +172,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -184,7 +184,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -196,7 +196,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -210,7 +210,7 @@
         "FCMask": "0x07",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC=
_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
         "MetricName": "LLC_MISSES.PCIE_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -222,7 +222,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -234,7 +234,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -246,7 +246,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -257,7 +257,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.CORE_GTONE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of transactions that trigg=
er a configurable number of cross snoops.  Cores are snooped if the transac=
tion looks up the cache and determines that it is necessary based on the op=
eration type and what CoreValid bits are set.  For example, if 2 CV bits ar=
e set on a data read, the cores must have the data in S state so it is not =
necessary to snoop them.  However, if only 1 CV bit is set the core my have=
 modified the data.  If the transaction was an RFO, it would need to invali=
date the lines.  This event can be filtered based on who triggered the init=
ial snoop(s).",
         "UMask": "0x42",
         "Unit": "CHA"
@@ -267,7 +267,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_CHA_CORE_SNP.EVICT_GTONE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the number of transactions that trigg=
er a configurable number of cross snoops.  Cores are snooped if the transac=
tion looks up the cache and determines that it is necessary based on the op=
eration type and what CoreValid bits are set.  For example, if 2 CV bits ar=
e set on a data read, the cores must have the data in S state so it is not =
necessary to snoop them.  However, if only 1 CV bit is set the core my have=
 modified the data.  If the transaction was an RFO, it would need to invali=
date the lines.  This event can be filtered based on who triggered the init=
ial snoop(s).",
         "UMask": "0x82",
         "Unit": "CHA"
@@ -277,7 +277,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts transactions that looked into the mul=
ti-socket cacheline Directory state, and therefore did not send a snoop bec=
ause the Directory indicated it was not needed",
         "UMask": "0x02",
         "Unit": "CHA"
@@ -287,7 +287,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x53",
         "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts  transactions that looked into the mu=
lti-socket cacheline Directory state, and sent one or more snoops, because =
the Directory indicated it was needed",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -297,7 +297,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_CHA_DIR_UPDATE.HA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts only multi-socket cacheline Directory=
 state updates memory writes issued from the HA pipe. This does not include=
 memory write requests which are for I (Invalid) or E (Exclusive) cacheline=
s.",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -307,7 +307,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_CHA_DIR_UPDATE.TOR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts only multi-socket cacheline Directory=
 state updates due to memory writes issued from the TOR pipe which are the =
result of remote transaction hitting the SF/LLC and returning data Core2Cor=
e. This does not include memory write requests which are for I (Invalid) or=
 E (Exclusive) cachelines.",
         "UMask": "0x02",
         "Unit": "CHA"
@@ -317,7 +317,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5F",
         "EventName": "UNC_CHA_HITME_HIT.EX_RDS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts read requests from a remote socket wh=
ich hit in the HitME cache (used to cache the multi-socket Directory state)=
 to a line in the E(Exclusive) state.  This includes the following read opc=
odes (RdCode, RdData, RdDataMigratory, RdCur, RdInv*, Inv*)",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -327,7 +327,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x59",
         "EventName": "UNC_CHA_IMC_READS_COUNT.NORMAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a normal (Non-Isochronous) read =
is issued to any of the memory controller channels from the CHA.",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -337,7 +337,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5B",
         "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a normal (Non-Isochronous) full =
line write is issued from the CHA to the any of the memory controller chann=
els.",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -347,7 +347,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_CHA_MISC.RFO_HIT_S",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a RFO (the Read for Ownership is=
sued before a  write) request hit a cacheline in the S (Shared) state.",
         "UMask": "0x08",
         "Unit": "CHA"
@@ -357,7 +357,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the total number of requests coming f=
rom a unit on this socket for exclusive ownership of a cache line without r=
eceiving data (INVITOE) to the CHA.",
         "UMask": "0x10",
         "Unit": "CHA"
@@ -367,7 +367,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.INVITOE_REMOTE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts the total number of requests coming f=
rom a remote socket for exclusive ownership of a cache line without receivi=
ng data (INVITOE) to the CHA.",
         "UMask": "0x20",
         "Unit": "CHA"
@@ -377,7 +377,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a a transaction with the opcode =
type RspCnflct* Snoop Response was received. This is returned when a snoop =
finds an existing outstanding transaction in a remote caching agent. This t=
riggers conflict resolution hardware. This covers both the opcode RspCnflct=
 and RspCnflctWbI.",
         "UMask": "0x40",
         "Unit": "CHA"
@@ -387,7 +387,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPI",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a transaction with the opcode ty=
pe RspI Snoop Response was received which indicates the remote cache does n=
ot have the data, or when the remote cache silently evicts data (such as wh=
en an RFO: the Read for Ownership issued before a write hits non-modified d=
ata).",
         "UMask": "0x01",
         "Unit": "CHA"
@@ -397,7 +397,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPIFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a a transaction with the opcode =
type RspIFwd Snoop Response was received which indicates a remote caching a=
gent forwarded the data and the requesting agent is able to acquire the dat=
a in E (Exclusive) or M (modified) states.  This is commonly returned with =
RFO (the Read for Ownership issued before a write) transactions.  The snoop=
 could have either been to a cacheline in the M,E,F (Modified, Exclusive or=
 Forward)  states.",
         "UMask": "0x04",
         "Unit": "CHA"
@@ -407,7 +407,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSPSFWD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a a transaction with the opcode =
type RspSFwd Snoop Response was received which indicates a remote caching a=
gent forwarded the data but held on to its current copy.  This is common fo=
r data and code reads that hit in a remote socket in E (Exclusive) or F (Fo=
rward) state.",
         "UMask": "0x08",
         "Unit": "CHA"
@@ -417,7 +417,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a transaction with the opcode ty=
pe Rsp*Fwd*WB Snoop Response was received which indicates the data was writ=
ten back to it's home socket, and the cacheline was forwarded to the reques=
tor socket.  This snoop response is only used in >=3D 4 socket systems.  It=
 is used when a snoop HITM's in a remote caching agent and it directly forw=
ards data to a requestor, and simultaneously returns data to it's home sock=
et to be written back to memory.",
         "UMask": "0x20",
         "Unit": "CHA"
@@ -427,7 +427,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a transaction with the opcode ty=
pe Rsp*WB Snoop Response was received which indicates which indicates the d=
ata was written back to it's home.  This is returned when a non-RFO request=
 hits a cacheline in the Modified state. The Cache can either downgrade the=
 cacheline to a S (Shared) or I (Invalid) state depending on how the system=
 has been configured.  This response will also be sent when a cache request=
s E (Exclusive) ownership of a cache line without receiving data, because t=
he cache must acquire ownership.",
         "UMask": "0x10",
         "Unit": "CHA"
@@ -437,7 +437,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_IIO_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts clockticks of the 1GHz trafiic contro=
ller clock in the IIO unit.",
         "Unit": "IIO"
     },
@@ -447,7 +447,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) to the MMIO space of a =
card on IIO Part0. In the general case, Part0 refers to a standard PCIe car=
d of any size (x16,x8,x4) that is plugged directly into one of the PCIe slo=
ts. Part0 could also refer to any device plugged into the first slot of a P=
CIe riser card or to a device attached to the IIO unit which starts its use=
 of the bus using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -459,7 +459,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) to the MMIO space of a =
card on IIO Part1. In the general case, Part1 refers to a x4 PCIe card plug=
ged into the second slot of a PCIe riser card, but it could refer to any x4=
 device attached to the IIO unit using lanes starting at lane 4 of the 16 l=
anes supported by the bus.",
         "UMask": "0x04",
@@ -471,7 +471,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) to the MMIO space of a =
card on IIO Part2. In the general case, Part2 refers to a x4 or x8 PCIe car=
d plugged into the third slot of a PCIe riser card, but it could refer to a=
ny x4 or x8 device attached to the IIO unit and using lanes starting at lan=
e 8 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -483,7 +483,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) to the MMIO space of a =
card on IIO Part3. In the general case, Part3 refers to a x4 PCIe card plug=
ged into the fourth slot of a PCIe riser card, but it could brefer to  any =
device attached to the IIO unit using the lanes starting at lane 12 of the =
16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -495,7 +495,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part0 by a unit on the main die (=
generally a core). In the general case, Part0 refers to a standard PCIe car=
d of any size (x16,x8,x4) that is plugged directly into one of the PCIe slo=
ts. Part0 could also refer to any device plugged into the first slot of a P=
CIe riser card or to a device attached to the IIO unit which starts its use=
 of the bus using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -507,7 +507,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part1 by a unit on the main die (=
generally a core). In the general case, Part1 refers to a x4 PCIe card plug=
ged into the second slot of a PCIe riser card, but it could refer to any x4=
 device attached to the IIO unit using lanes starting at lane 4 of the 16 l=
anes supported by the bus.",
         "UMask": "0x01",
@@ -519,7 +519,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part2 by  a unit on the main die =
(generally a core). In the general case, Part2 refers to a x4 or x8 PCIe ca=
rd plugged into the third slot of a PCIe riser card, but it could refer to =
any x4 or x8 device attached to the IIO unit and using lanes starting at la=
ne 8 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -531,7 +531,7 @@
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part3 by  a unit on the main die =
(generally a core). In the general case, Part3 refers to a x4 PCIe card plu=
gged into the fourth slot of a PCIe riser card, but it could brefer to any =
device attached to the IIO unit using the lanes starting at lane 12 of the =
16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -543,7 +543,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) to =
the MMIO space of a card on IIO Part0. In the general case, part0 refers to=
 a standard PCIe card of any size (x16,x8,x4) that is plugged directly into=
 one of the PCIe slots. Part0 could also refer to any device plugged into t=
he first slot of a PCIe riser card or to a device attached to the IIO unit =
which starts its use of the bus using lane 0 of the 16 lanes supported by t=
he bus.",
         "UMask": "0x04",
@@ -555,7 +555,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) to =
the MMIO space of a card on IIO Part1. In the general case, Part1 refers to=
 a x4 PCIe card plugged into the second slot of a PCIe riser card, but it c=
ould refer to any x4 device attached to the IIO unit using lanes starting a=
t lane 4 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -567,7 +567,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) to =
the MMIO space of a card on IIO Part2. In the general case, Part2 refers to=
 a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but=
 it could refer to any x4 or x8 device attached to the IIO unit and using l=
anes starting at lane 8 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -579,7 +579,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) to =
the MMIO space of a card on IIO Part3. In the general case, Part3 refers to=
 a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it c=
ould brefer to  any device attached to the IIO unit using the lanes startin=
g at lane 12 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -591,7 +591,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part0 by a un=
it on the main die (generally a core). In the general case, Part0 refers to=
 a standard PCIe card of any size (x16,x8,x4) that is plugged directly into=
 one of the PCIe slots. Part0 could also refer to any device plugged into t=
he first slot of a PCIe riser card or to a device attached to the IIO unit =
which starts its use of the bus using lane 0 of the 16 lanes supported by t=
he bus.",
         "UMask": "0x01",
@@ -603,7 +603,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part1 by a un=
it on the main die (generally a core). In the general case, Part1 refers to=
 a x4 PCIe card plugged into the second slot of a PCIe riser card, but it c=
ould refer to any x4 device attached to the IIO unit using lanes starting a=
t lane 4 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -615,7 +615,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part2 by a un=
it on the main die (generally a core). In the general case, Part2 refers to=
 a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but=
 it could refer to any x4 or x8 device attached to the IIO unit and using l=
anes starting at lane 8 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -627,7 +627,7 @@
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part3 by a un=
it on the main die (generally a core). In the general case, Part3 refers to=
 a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it c=
ould brefer to  any device attached to the IIO unit using the lanes startin=
g at lane 12 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -639,7 +639,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part0 to a unit on the main die (generall=
y memory). In the general case, Part0 refers to a standard PCIe card of any=
 size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part=
0 could also refer to any device plugged into the first slot of a PCIe rise=
r card or to a device attached to the IIO unit which starts its use of the =
bus using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -651,7 +651,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part1 to a unit on the main die (generall=
y memory). In the general case, Part1 refers to a x4 PCIe card plugged into=
 the second slot of a PCIe riser card, but it could refer to any x4 device =
attached to the IIO unit using lanes starting at lane 4 of the 16 lanes sup=
ported by the bus.",
         "UMask": "0x04",
@@ -663,7 +663,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part2 to a unit on the main die (generall=
y memory). In the general case, Part2 refers to a x4 or x8 PCIe card plugge=
d into the third slot of a PCIe riser card, but it could refer to any x4 or=
 x8 device attached to the IIO unit and using lanes starting at lane 8 of t=
he 16 lanes supported by the bus.",
         "UMask": "0x04",
@@ -675,7 +675,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part3 to a unit on the main die (generall=
y memory). In the general case, Part3 refers to a x4 PCIe card plugged into=
 the fourth slot of a PCIe riser card, but it could brefer to  any device a=
ttached to the IIO unit using the lanes starting at lane 12 of the 16 lanes=
 supported by the bus.",
         "UMask": "0x04",
@@ -687,7 +687,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part0 to a unit on the main die (generall=
y memory). In the general case, Part0 refers to a standard PCIe card of any=
 size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part=
0 could also refer to any device plugged into the first slot of a PCIe rise=
r card or to a device attached to the IIO unit which starts its use of the =
bus using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -699,7 +699,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part1 to a unit on the main die (generall=
y memory). In the general case, Part1 refers to a x4 PCIe card plugged into=
 the second slot of a PCIe riser card, but it could refer to any x4 device =
attached to the IIO unit using lanes starting at lane 4 of the 16 lanes sup=
ported by the bus.",
         "UMask": "0x01",
@@ -711,7 +711,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part2 to a unit on the main die (generall=
y memory). In the general case, Part2 refers to a x4 or x8 PCIe card plugge=
d into the third slot of a PCIe riser card, but it could refer to any x4 or=
 x8 device attached to the IIO unit and using lanes starting at lane 8 of t=
he 16 lanes supported by the bus.",
         "UMask": "0x01",
@@ -723,7 +723,7 @@
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part3 to a unit on the main die (generall=
y memory). In the general case, Part3 refers to a x4 PCIe card plugged into=
 the fourth slot of a PCIe riser card, but it could brefer to  any device a=
ttached to the IIO unit using the lanes starting at lane 12 of the 16 lanes=
 supported by the bus.",
         "UMask": "0x01",
@@ -734,7 +734,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M2M_BYPASS_M2M_Egress.NOT_TAKEN",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts traffic in which the M2M (Mesh to Mem=
ory) to iMC (Memory Controller) bypass was not taken",
         "UMask": "0x2",
         "Unit": "M2M"
@@ -744,7 +744,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts cycles when direct to core mode (whic=
h bypasses the CHA) was disabled",
         "Unit": "M2M"
     },
@@ -753,7 +753,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_M2M_DIRECT2CORE_TAKEN",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when messages were sent direct to cor=
e (bypassing the CHA)",
         "Unit": "M2M"
     },
@@ -762,7 +762,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts reads in which direct to core transac=
tions (which would have bypassed the CHA) were overridden",
         "Unit": "M2M"
     },
@@ -771,7 +771,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_CREDITS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts reads in which direct to Intel Ultra =
Path Interconnect (UPI) transactions (which would have bypassed the CHA) we=
re overridden",
         "Unit": "M2M"
     },
@@ -780,7 +780,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts cycles when the ability to send messa=
ges direct to the Intel Ultra Path Interconnect (bypassing the CHA) was dis=
abled",
         "Unit": "M2M"
     },
@@ -789,7 +789,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "UNC_M2M_DIRECT2UPI_TAKEN",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when messages were sent direct to the=
 Intel Ultra Path Interconnect (bypassing the CHA)",
         "Unit": "M2M"
     },
@@ -798,7 +798,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_M2M_DIRECT2UPI_TXN_OVERRIDE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when a read message that was sent dir=
ect to the Intel Ultra Path Interconnect (bypassing the CHA) was overridden=
",
         "Unit": "M2M"
     },
@@ -807,7 +807,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2D",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.ANY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state, and found the cacheline mar=
ked in Any State (A, I, S or unused)",
         "UMask": "0x1",
         "Unit": "M2M"
@@ -817,7 +817,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2D",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_A",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state, and found the cacheline mar=
ked in the A (SnoopAll) state, indicating the cacheline is stored in anothe=
r socket in any state, and we must snoop the other sockets to make sure we =
get the latest data.  The data may be stored in any state in the local sock=
et.",
         "UMask": "0x8",
         "Unit": "M2M"
@@ -827,7 +827,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2D",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_I",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state , and found the cacheline ma=
rked in the I (Invalid) state indicating the cacheline is not stored in ano=
ther socket, and so there is no need to snoop the other sockets for the lat=
est data.  The data may be stored in any state in the local socket.",
         "UMask": "0x2",
         "Unit": "M2M"
@@ -837,7 +837,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2D",
         "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_S",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state , and found the cacheline ma=
rked in the S (Shared) state indicating the cacheline is either stored in a=
nother socket in the S(hared) state , and so there is no need to snoop the =
other sockets for the latest data.  The data may be stored in any state in =
the local socket.",
         "UMask": "0x4",
         "Unit": "M2M"
@@ -847,7 +847,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2I",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from A (SnoopAll) to I (In=
valid)",
         "UMask": "0x20",
         "Unit": "M2M"
@@ -857,7 +857,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2S",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from A (SnoopAll) to S (Sh=
ared)",
         "UMask": "0x40",
         "Unit": "M2M"
@@ -867,7 +867,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.ANY",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory to a new state",
         "UMask": "0x1",
         "Unit": "M2M"
@@ -877,7 +877,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2A",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from I (Invalid) to A (Sno=
opAll)",
         "UMask": "0x4",
         "Unit": "M2M"
@@ -887,7 +887,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2S",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from I (Invalid) to S (Sha=
red)",
         "UMask": "0x2",
         "Unit": "M2M"
@@ -897,7 +897,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2A",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from S (Shared) to A (Snoo=
pAll)",
         "UMask": "0x10",
         "Unit": "M2M"
@@ -907,7 +907,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2E",
         "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2I",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from S (Shared) to I (Inva=
lid)",
         "UMask": "0x8",
         "Unit": "M2M"
@@ -917,7 +917,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_M2M_IMC_READS.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
reads to the iMC (Memory Controller). ",
         "UMask": "0x4",
         "Unit": "M2M"
@@ -927,7 +927,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_M2M_IMC_READS.NORMAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
reads to the iMC (Memory Controller).  It only counts  normal priority non-=
isochronous reads.",
         "UMask": "0x1",
         "Unit": "M2M"
@@ -937,7 +937,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_M2M_IMC_WRITES.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
writes to the iMC (Memory Controller).",
         "UMask": "0x10",
         "Unit": "M2M"
@@ -947,7 +947,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x38",
         "EventName": "UNC_M2M_IMC_WRITES.PARTIAL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
partial writes to the iMC (Memory Controller).  It only counts normal prior=
ity non-isochronous writes.",
         "UMask": "0x2",
         "Unit": "M2M"
@@ -957,7 +957,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_M2M_PREFCAM_DEMAND_PROMOTIONS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) promote=
s a outstanding request in the prefetch queue due to a subsequent demand re=
ad request that entered the M2M with the same address.  Explanatory Side No=
te: The Prefecth queue is made of CAM (Content Addressable Memory)",
         "Unit": "M2M"
     },
@@ -966,7 +966,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x57",
         "EventName": "UNC_M2M_PREFCAM_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the M2M (Mesh to Memory) receive=
s a prefetch request and inserts it into its outstanding prefetch queue.  E=
xplanatory Side Note: the prefect queue is made from CAM: Content Addressab=
le Memory",
         "Unit": "M2M"
     },
@@ -975,7 +975,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M2M_RxC_AD_INSERTS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the a new entry is Received(RxC)=
 and then added to the AD (Address Ring) Ingress Queue from the CMS (Common=
 Mesh Stop).  This is generally used for reads, and ",
         "Unit": "M2M"
     },
@@ -984,7 +984,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_M3UPI_UPI_PREFETCH_SPAWN",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Count cases where flow control queue that si=
ts between the Intel Ultra Path Interconnect (UPI) and the mesh spawns a pr=
efetch to the iMC (Memory Controller)",
         "Unit": "M3UPI"
     },
@@ -993,7 +993,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_UPI_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts clockticks of the fixed frequency clo=
ck controlling the Intel Ultra Path Interconnect (UPI).  This clock runs at=
1/8th the 'GT/s' speed of the UPI link.  For example, a  9.6GT/s  link will=
 have a fixed Frequency of 1.2 Ghz.",
         "Unit": "UPI LL"
     },
@@ -1002,7 +1002,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2C",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts Data Response (DRS) packets that atte=
mpted to go direct to core bypassing the CHA.",
         "UMask": "0x1",
         "Unit": "UPI LL"
@@ -1012,7 +1012,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2U",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts Data Response (DRS) packets that atte=
mpted to go direct to Intel Ultra Path Interconnect (UPI) bypassing the CHA=
 .",
         "UMask": "0x2",
         "Unit": "UPI LL"
@@ -1022,7 +1022,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_UPI_L1_POWER_CYCLES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts cycles when the Intel Ultra Path Inte=
rconnect (UPI) is in L1 power mode.  L1 is a mode that totally shuts down t=
he UPI link.  Link power states are per link and per direction, so for exam=
ple the Tx direction could be in one state while Rx was in another, this ev=
ent only coutns when both links are shutdown.",
         "Unit": "UPI LL"
     },
@@ -1031,7 +1031,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts cycles when the the receive side (Rx)=
 of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a m=
ode where we disable 60% of the UPI lanes, decreasing our bandwidth in orde=
r to save power.",
         "Unit": "UPI LL"
     },
@@ -1040,7 +1040,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to t=
he Egress.  This is a latency optimization, and should generally be the com=
mon case.  If this value is less than the number of FLITs transferred, it i=
mplies that there was queueing getting onto the ring, and thus the transact=
ions saw higher latency.",
         "UMask": "0x1",
         "Unit": "UPI LL"
@@ -1050,7 +1050,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly acr=
oss the BGF and into the Egress.  This is a latency optimization, and shoul=
d generally be the common case.  If this value is less than the number of F=
LITs transferred, it implies that there was queueing getting onto the ring,=
 and thus the transactions saw higher latency.",
         "UMask": "0x2",
         "Unit": "UPI LL"
@@ -1060,7 +1060,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly to =
the Egress.  This is a latency optimization, and should generally be the co=
mmon case.  If this value is less than the number of FLITs transferred, it =
implies that there was queueing getting onto the ring, and thus the transac=
tions saw higher latency.",
         "UMask": "0x4",
         "Unit": "UPI LL"
@@ -1070,7 +1070,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts valid data FLITs  (80 bit FLow contro=
l unITs: 64bits of data) received from any of the 3 Intel Ultra Path Interc=
onnect (UPI) Receive Queue slots on this UPI unit.",
         "UMask": "0x0F",
         "Unit": "UPI LL"
@@ -1080,7 +1080,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts null FLITs (80 bit FLow control unITs=
) received from any of the 3 Intel Ultra Path Interconnect (UPI) Receive Qu=
eue slots on this UPI unit.",
         "UMask": "0x27",
         "Unit": "UPI LL"
@@ -1090,7 +1090,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3",
         "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts protocol header and credit FLITs  (80=
 bit FLow control unITs) received from any of the 3 UPI slots on this UPI u=
nit.",
         "UMask": "0x97",
         "Unit": "UPI LL"
@@ -1100,7 +1100,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x27",
         "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts cycles when the transmit side (Tx) of=
 the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode=
 where we disable 60% of the UPI lanes, decreasing our bandwidth in order t=
o save power.",
         "Unit": "UPI LL"
     },
@@ -1109,7 +1109,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_UPI_TxL_BYPASSED",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the TxL(transmit) FLIT buffer and pass directly out the UPI L=
ink. Generally, when data is transmitted across the Intel Ultra Path Interc=
onnect (UPI), it will bypass the TxQ and pass directly to the link.  Howeve=
r, the TxQ will be used in L0p (Low Power) mode and (Link Layer Retry) LLR =
 mode, increasing latency to transfer out to the link.",
         "Unit": "UPI LL"
     },
@@ -1118,7 +1118,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UPI_DATA_BANDWIDTH_TX",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "7.11E-06Bytes",
         "UMask": "0x0F",
         "Unit": "UPI LL"
@@ -1128,7 +1128,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts null FLITs (80 bit FLow control unITs=
) transmitted via any of the 3 Intel Ulra Path Interconnect (UPI) slots on =
this UPI unit.",
         "UMask": "0x27",
         "Unit": "UPI LL"
@@ -1138,7 +1138,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_UPI_TxL_FLITS.IDLE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts when the Intel Ultra Path Interconnec=
t(UPI) transmits an idle FLIT(80 bit FLow control unITs).  Every UPI cycle =
must be sending either data FLITs, protocol/credit FLITs or idle FLITs.",
         "UMask": "0x47",
         "Unit": "UPI LL"
@@ -1148,7 +1148,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Counts protocol header and credit FLITs (80 =
bit FLow control unITs) transmitted across any of the 3 UPI (Ultra Path Int=
erconnect) slots on this UPI unit.",
         "UMask": "0x97",
         "Unit": "UPI LL"
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
index 15376f2cf052..154f6da96669 100644
--- a/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
@@ -5,7 +5,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x04",
         "EventName": "LLC_MISSES.MEM_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x0f",
         "Unit": "iMC"
@@ -16,7 +16,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x04",
         "EventName": "LLC_MISSES.MEM_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0x30",
         "Unit": "iMC"
@@ -26,7 +26,7 @@
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventName": "UNC_M_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "iMC"
     },
     {
@@ -35,7 +35,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x02",
         "EventName": "UNC_M_PRE_COUNT.RD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x04",
         "Unit": "iMC"
     },
@@ -45,7 +45,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x02",
         "EventName": "UNC_M_PRE_COUNT.WR",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x08",
         "Unit": "iMC"
     },
@@ -55,7 +55,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x02",
         "EventName": "UNC_M_PRE_COUNT.ALL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0x1c",
         "Unit": "iMC"
     },
@@ -65,7 +65,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x02",
         "EventName": "UNC_M_PRE_COUNT.PGT",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "DRAM Precharge commands. : Precharge due to =
page table : Counts the number of DRAM Precharge commands sent on this chan=
nel.",
         "UMask": "0x10",
         "Unit": "iMC"
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/tremontx/uncore-other.json
index 6deff1fe89e3..981de2670e57 100644
--- a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventName": "UNC_CHA_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "Unit": "CHA"
     },
     {
@@ -14,7 +14,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "config1=3D0x40e33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0xC001FE01",
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
@@ -26,7 +26,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_READ",
         "Filter": "config1=3D0x40040e33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0xC001FE01",
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
@@ -38,7 +38,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_MISSES.MMIO_WRITE",
         "Filter": "config1=3D0x40041e33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "UMask": "0xC001FE01",
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
@@ -50,7 +50,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_FULL",
         "Filter": "config1=3D0x41833",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC001FE01",
         "UMaskExt": "0xC001FE",
@@ -63,7 +63,7 @@
         "EventCode": "0x35",
         "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
         "Filter": "config1=3D0x41a33",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "ScaleUnit": "64Bytes",
         "UMask": "0xC001FE01",
         "UMaskExt": "0xC001FE",
@@ -79,7 +79,7 @@
         "Filter": "ch_mask=3D0x1f",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 +UNC_IIO_DAT=
A_REQ_OF_CPU.MEM_READ.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 +UNC_II=
O_DATA_REQ_OF_CPU.MEM_READ.PART3",
         "MetricName": "LLC_MISSES.PCIE_READ",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -95,7 +95,7 @@
         "Filter": "ch_mask=3D0x1f",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC=
_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
         "MetricName": "LLC_MISSES.PCIE_WRITE",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -108,7 +108,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -121,7 +121,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -134,7 +134,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "ScaleUnit": "4Bytes",
         "UMask": "0x01",
@@ -147,7 +147,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x02",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -160,7 +160,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x04",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -173,7 +173,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x08",
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
@@ -185,7 +185,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "TOR Inserts; Code read from local IA that mi=
sses in the snoop filter",
         "UMask": "0xC80FFE01",
         "UMaskExt": "0xC80FFE",
@@ -197,7 +197,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "TOR Inserts; Code read prefetch from local I=
A that misses in the snoop filter",
         "UMask": "0xC88FFE01",
         "UMaskExt": "0xC88FFE",
@@ -209,7 +209,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "TOR Inserts; Data read opt from local IA tha=
t misses in the snoop filter",
         "UMask": "0xC827FE01",
         "UMaskExt": "0xC827FE",
@@ -221,7 +221,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "TOR Inserts; Data read opt prefetch from loc=
al IA that misses in the snoop filter",
         "UMask": "0xC8A7FE01",
         "UMaskExt": "0xC8A7FE",
@@ -233,7 +233,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "TOR Inserts; Read for ownership from local I=
A that misses in the snoop filter",
         "UMask": "0xC807FE01",
         "UMaskExt": "0xC807FE",
@@ -245,7 +245,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "TOR Inserts; Read for ownership prefetch fro=
m local IA that misses in the snoop filter",
         "UMask": "0xC887FE01",
         "UMaskExt": "0xC887FE",
@@ -257,7 +257,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "TOR Inserts; Data read from local IA that mi=
sses in the snoop filter",
         "UMask": "0xC86FFE01",
         "UMaskExt": "0xC86FFE",
@@ -269,7 +269,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "TOR Inserts; Data read from local IA that mi=
sses in the snoop filter",
         "UMask": "0xC867FE01",
         "UMaskExt": "0xC867FE",
@@ -281,7 +281,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x01",
         "EventName": "UNC_IIO_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Clockticks of the integrated IO (IIO) traffi=
c controller",
         "Unit": "IIO"
     },
@@ -292,7 +292,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x10",
         "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x16 =
card plugged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is =
plugged in to slot 0",
         "UMask": "0x04",
@@ -305,7 +305,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x20",
         "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x4 c=
ard is plugged in to slot 1",
         "UMask": "0x04",
@@ -318,7 +318,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x40",
         "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x8 c=
ard plugged in to Lane 2/3, Or x4 card is plugged in to slot 1",
         "UMask": "0x04",
@@ -331,7 +331,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x80",
         "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x4 c=
ard is plugged in to slot 3",
         "UMask": "0x04",
@@ -344,7 +344,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x10",
         "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x16 ca=
rd plugged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is pl=
ugged in to slot 0",
         "UMask": "0x01",
@@ -357,7 +357,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x20",
         "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x4 car=
d is plugged in to slot 1",
         "UMask": "0x01",
@@ -370,7 +370,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x40",
         "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x8 car=
d plugged in to Lane 2/3, Or x4 card is plugged in to slot 1",
         "UMask": "0x01",
@@ -383,7 +383,7 @@
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
         "FCMask": "0x07",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PortMask": "0x80",
         "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x4 car=
d is plugged in to slot 3",
         "UMask": "0x01",
@@ -395,7 +395,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x01",
         "EventName": "UNC_I_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Clockticks of the IO coherency tracker (IRP)=
",
         "Unit": "IRP"
     },
@@ -404,7 +404,7 @@
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventName": "UNC_M2M_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Clockticks of the mesh to memory (M2M)",
         "Unit": "M2M"
     },
@@ -414,7 +414,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0x01",
         "EventName": "UNC_M2P_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Clockticks of the mesh to PCI (M2P)",
         "Unit": "M2PCIe"
     },
@@ -424,7 +424,7 @@
         "CounterType": "PGMABLE",
         "EventCode": "0xff",
         "EventName": "UNC_U_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Clockticks in the UBOX using a dedicated 48-=
bit Fixed Counter",
         "Unit": "UBOX"
     }
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/tremontx/uncore-power.json
index ea62c092b43f..41f460903161 100644
--- a/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventName": "UNC_P_CLOCKTICKS",
-        "PerPkg": "1",
+        "AggregationMode": "PerPkg",
         "PublicDescription": "Clockticks of the power control unit (PCU)",
         "Unit": "PCU"
     }
--=20
2.26.2
