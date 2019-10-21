From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/57] perf vendor events arm64: Add some missing events for Hisi hip08 HHA PMU
Date: Mon, 21 Oct 2019 10:37:59 -0300
Message-ID: <20191021133834.25998-23-acme@kernel.org>
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

A trivial typo is also fixed.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1567612484-195727-5-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arm64/hisilicon/hip08/uncore-hha.json     | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
index 447d3064de90..3be418a248ea 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
@@ -20,6 +20,13 @@
 	    "PublicDescription": "The number of all operations received by the HHA from another SCCL in this socket",
 	    "Unit": "hisi_sccl,hha",
    },
+   {
+	    "EventCode": "0x03",
+	    "EventName": "uncore_hisi_hha.rx_ccix",
+	    "BriefDescription": "Count of the number of operations that HHA has received from CCIX",
+	    "PublicDescription": "Count of the number of operations that HHA has received from CCIX",
+	    "Unit": "hisi_sccl,hha",
+   },
    {
 	    "EventCode": "0x1c",
 	    "EventName": "uncore_hisi_hha.rd_ddr_64b",
@@ -29,7 +36,7 @@
    },
    {
 	    "EventCode": "0x1d",
-	    "EventName": "uncore_hisi_hha.wr_dr_64b",
+	    "EventName": "uncore_hisi_hha.wr_ddr_64b",
 	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
 	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
 	    "Unit": "hisi_sccl,hha",
@@ -48,4 +55,18 @@
 	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
 	    "Unit": "hisi_sccl,hha",
    },
+   {
+	    "EventCode": "0x20",
+	    "EventName": "uncore_hisi_hha.spill_num",
+	    "BriefDescription": "Count of the number of spill operations that the HHA has sent",
+	    "PublicDescription": "Count of the number of spill operations that the HHA has sent",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x21",
+	    "EventName": "uncore_hisi_hha.spill_success",
+	    "BriefDescription": "Count of the number of successful spill operations that the HHA has sent",
+	    "PublicDescription": "Count of the number of successful spill operations that the HHA has sent",
+	    "Unit": "hisi_sccl,hha",
+   },
 ]
-- 
2.21.0
