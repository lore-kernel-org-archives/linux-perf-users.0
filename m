From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/57] perf vendor events arm64: Add some missing events for Hisi hip08 L3C PMU
Date: Mon, 21 Oct 2019 10:37:58 -0300
Message-ID: <20191021133834.25998-22-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linuxarm@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: John Garry <john.garry@huawei.com>

Add some more missing events.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1567612484-195727-4-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arm64/hisilicon/hip08/uncore-l3c.json     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
index ca48747642e1..f463d0acfaef 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
@@ -34,4 +34,60 @@
 	    "PublicDescription": "l3c precharge commands",
 	    "Unit": "hisi_sccl,l3c",
    },
+   {
+	    "EventCode": "0x20",
+	    "EventName": "uncore_hisi_l3c.rd_spipe",
+	    "BriefDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
+	    "PublicDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x21",
+	    "EventName": "uncore_hisi_l3c.wr_spipe",
+	    "BriefDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
+	    "PublicDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x22",
+	    "EventName": "uncore_hisi_l3c.rd_hit_spipe",
+	    "BriefDescription": "Count of the number of read lines that hits in spipe of this L3C",
+	    "PublicDescription": "Count of the number of read lines that hits in spipe of this L3C",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x23",
+	    "EventName": "uncore_hisi_l3c.wr_hit_spipe",
+	    "BriefDescription": "Count of the number of write lines that hits in spipe of this L3C",
+	    "PublicDescription": "Count of the number of write lines that hits in spipe of this L3C",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x29",
+	    "EventName": "uncore_hisi_l3c.back_invalid",
+	    "BriefDescription": "Count of the number of L3C back invalid operations",
+	    "PublicDescription": "Count of the number of L3C back invalid operations",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x40",
+	    "EventName": "uncore_hisi_l3c.retry_cpu",
+	    "BriefDescription": "Count of the number of retry that L3C suppresses the CPU operations",
+	    "PublicDescription": "Count of the number of retry that L3C suppresses the CPU operations",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x41",
+	    "EventName": "uncore_hisi_l3c.retry_ring",
+	    "BriefDescription": "Count of the number of retry that L3C suppresses the ring operations",
+	    "PublicDescription": "Count of the number of retry that L3C suppresses the ring operations",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x42",
+	    "EventName": "uncore_hisi_l3c.prefetch_drop",
+	    "BriefDescription": "Count of the number of prefetch drops from this L3C",
+	    "PublicDescription": "Count of the number of prefetch drops from this L3C",
+	    "Unit": "hisi_sccl,l3c",
+   },
 ]
-- 
2.21.0
