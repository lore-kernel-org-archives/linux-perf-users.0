Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1E328C5B1;
	Tue, 18 Aug 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047319; cv=none; b=UTFomigtdoRXHDqP/DV4wM11rzdOvRpQXQFFcbQsqCNYOkJ4jqKrOnt37ZMiUjdkXwjb1hWsPP0UeIYO5wpVsdtjJ30KjX6SyTcNhD6C9uVCvOpeimYulUi29sA5UNAOfJ3KyBYErH+WADs9EUi2tylSJEH6HdxfBfcbCLlpY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047319; c=relaxed/simple;
	bh=M1U75z66kRNZn5niV1VkLNHMdBAWSuKh5cPrLmEDI+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSRJC+S7yOiGMbcVWIo72c4yieQaz9yYrJCOmiv6GpVKxUXOec2EiwnXUhyqyf7kJnozJDBrLopZf0djZKDs7+nZtDqDO27nB2WY+J4YjDRu+43tmUTE0yMkkP/xG/Bejtwmes6neKMaMuEnqbZ+6cKk3mSC26C+/41KMWib5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPQGD02w8z18tXb;
	Tue, 18 Aug 2026 18:01:40 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPQGC0SsSz18tWX;
	Tue, 18 Aug 2026 18:01:39 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 280B7300D1E7;
	Tue, 18 Aug 2026 17:58:12 +0800 (CST)
Received: from neptune.hygon.cn (172.22.228.106) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Aug
 2026 18:01:38 +0800
From: Qi Liu <liuqi@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<sandipan.das@amd.com>, <ravi.bangoria@amd.com>, <irogers@google.com>,
	<x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <liuqi@hygon.cn>
Subject: [PATCH v5 2/2] perf vendor events hygon: Add Hygon Data Fabric PMU events and metrics
Date: Tue, 18 Aug 2026 10:01:18 +0000
Message-ID: <20260818100118.12944-3-liuqi@hygon.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818100118.12944-1-liuqi@hygon.cn>
References: <20260818100118.12944-1-liuqi@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Add perf JSON event definitions and metrics for the Hygon Data Fabric (DF)
uncore PMU.

Signed-off-by: Qi Liu <liuqi@hygon.cn>
---
 tools/perf/pmu-events/Build                   |   2 +-
 .../arch/x86/hygonm1/data-fabric.json         |  95 ++++++++++
 .../arch/x86/hygonm4/data-fabric.json         | 134 ++++++++++++++
 .../arch/x86/hygonm6/data-fabric.json         | 170 ++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +
 tools/perf/pmu-events/jevents.py              |   2 +
 6 files changed, 405 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 372773b998e4..79a9b4cad202 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -95,7 +95,7 @@ endif
 
 ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
 # Generate Intel Json
-INTELS := $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
+INTELS := $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v hygon|grep -v mapfile.csv)
 INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
 INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
 GEN_JSON += $(INTEL_METRICS) $(INTEL_METRICGROUPS)
diff --git a/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json b/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
new file mode 100644
index 000000000000..8c6a8e9ba9a5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
@@ -0,0 +1,95 @@
+[
+  {
+    "EventName": "cpu_read_requests_cs_0",
+    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
+    "EventCode": "0x2",
+    "UMask": "0x07",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_read_requests_cs_1",
+    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
+    "EventCode": "0x2",
+    "UMask": "0x07",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_write_requests_cs_0",
+    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
+    "EventCode": "0x2",
+    "UMask": "0x08",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_write_requests_cs_1",
+    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
+    "EventCode": "0x2",
+    "UMask": "0x08",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_read_requests_cs_0",
+    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x0F",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_read_requests_cs_1",
+    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x0F",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_write_requests_cs_0",
+    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x70",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_write_requests_cs_1",
+    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x70",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "MetricName": "cpu_memory_bandwidth",
+    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1) * 64 / (duration_time * 1e6)",
+    "BriefDescription": "Total CPU memory access bandwidth",
+    "MetricGroup": "DF_Memory_BW",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "io_memory_max_bandwidth",
+    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_write_requests_cs_0 + io_write_requests_cs_1) * 64 / (duration_time * 1e6)",
+    "BriefDescription": "Maximum inbound I/O memory access bandwidth (upper bound, assuming 64B per request. Actual inbound I/O requests may be 32B or 64B)",
+    "MetricGroup": "DF_Memory_BW",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "io_memory_min_bandwidth",
+    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_write_requests_cs_0 + io_write_requests_cs_1) * 32 / (duration_time * 1e6)",
+    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lower bound, assuming 32B per request. Actual inbound I/O requests may be 32B or 64B)",
+    "MetricGroup": "DF_Memory_BW",
+    "ScaleUnit": "1MB/s"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json b/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
new file mode 100644
index 000000000000..41932a1a3d6d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
@@ -0,0 +1,134 @@
+[
+  {
+    "EventName": "cpu_read_requests_cs_0",
+    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
+    "EventCode": "0x2",
+    "UMask": "0x07",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_read_requests_cs_1",
+    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
+    "EventCode": "0x2",
+    "UMask": "0x07",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_read_requests_cs_2",
+    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 2 (CS2).",
+    "EventCode": "0x2",
+    "UMask": "0x07",
+    "CompId": "0x2",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_write_requests_cs_0",
+    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
+    "EventCode": "0x2",
+    "UMask": "0x08",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_write_requests_cs_1",
+    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
+    "EventCode": "0x2",
+    "UMask": "0x08",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_write_requests_cs_2",
+    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 2 (CS2).",
+    "EventCode": "0x2",
+    "UMask": "0x08",
+    "CompId": "0x2",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_read_requests_cs_0",
+    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x0F",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_read_requests_cs_1",
+    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x0F",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_read_requests_cs_2",
+    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 2 (CS2). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x0F",
+    "CompId": "0x2",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_write_requests_cs_0",
+    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x70",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_write_requests_cs_1",
+    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x70",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_write_requests_cs_2",
+    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 2 (CS2). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x70",
+    "CompId": "0x2",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "MetricName": "cpu_memory_bandwidth",
+    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cpu_read_requests_cs_2 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1 + cpu_write_requests_cs_2) * 64 / (duration_time * 1e6)",
+    "MetricConstraint": "NO_GROUP_EVENTS",
+    "BriefDescription": "Total CPU memory access bandwidth",
+    "MetricGroup": "DF_Memory_BW",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "io_memory_max_bandwidth",
+    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2) * 64 / (duration_time * 1e6)",
+    "MetricConstraint": "NO_GROUP_EVENTS",
+    "BriefDescription": "Maximum inbound I/O memory access bandwidth (upper bound, assuming 64B per request. Actual inbound I/O requests may be 32B or 64B)",
+    "MetricGroup": "DF_Memory_BW",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "io_memory_min_bandwidth",
+    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2) * 32 / (duration_time * 1e6)",
+    "MetricConstraint": "NO_GROUP_EVENTS",
+    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lower bound, assuming 32B per request. Actual inbound I/O requests may be 32B or 64B)",
+    "MetricGroup": "DF_Memory_BW",
+    "ScaleUnit": "1MB/s"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json b/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
new file mode 100644
index 000000000000..ee81e35dc6f3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
@@ -0,0 +1,170 @@
+[
+  {
+    "EventName": "cpu_read_requests_cs_0",
+    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
+    "EventCode": "0x2",
+    "UMask": "0x07",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_read_requests_cs_1",
+    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
+    "EventCode": "0x2",
+    "UMask": "0x07",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_read_requests_cs_2",
+    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 2 (CS2).",
+    "EventCode": "0x2",
+    "UMask": "0x07",
+    "CompId": "0x2",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_read_requests_cs_3",
+    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 3 (CS3).",
+    "EventCode": "0x2",
+    "UMask": "0x07",
+    "CompId": "0x3",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_write_requests_cs_0",
+    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
+    "EventCode": "0x2",
+    "UMask": "0x08",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_write_requests_cs_1",
+    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
+    "EventCode": "0x2",
+    "UMask": "0x08",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_write_requests_cs_2",
+    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 2 (CS2).",
+    "EventCode": "0x2",
+    "UMask": "0x08",
+    "CompId": "0x2",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "cpu_write_requests_cs_3",
+    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 3 (CS3).",
+    "EventCode": "0x2",
+    "UMask": "0x08",
+    "CompId": "0x3",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_read_requests_cs_0",
+    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x0F",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_read_requests_cs_1",
+    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x0F",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_read_requests_cs_2",
+    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 2 (CS2). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x0F",
+    "CompId": "0x2",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_read_requests_cs_3",
+    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 3 (CS3). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x0F",
+    "CompId": "0x3",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_write_requests_cs_0",
+    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x70",
+    "CompId": "0x0",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_write_requests_cs_1",
+    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x70",
+    "CompId": "0x1",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_write_requests_cs_2",
+    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 2 (CS2). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x70",
+    "CompId": "0x2",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "EventName": "io_write_requests_cs_3",
+    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 3 (CS3). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
+    "EventCode": "0x3",
+    "UMask": "0x70",
+    "CompId": "0x3",
+    "Unit": "HYGON_DF",
+    "ScaleUnit": "64Bytes"
+  },
+  {
+    "MetricName": "cpu_memory_bandwidth",
+    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cpu_read_requests_cs_2 + cpu_read_requests_cs_3 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1 + cpu_write_requests_cs_2 + cpu_write_requests_cs_3) * 64 / (duration_time * 1e6)",
+    "MetricConstraint": "NO_GROUP_EVENTS",
+    "BriefDescription": "Total CPU memory access bandwidth",
+    "MetricGroup": "DF_Memory_BW",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "io_memory_max_bandwidth",
+    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_read_requests_cs_3 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2 + io_write_requests_cs_3) * 64 / (duration_time * 1e6)",
+    "MetricConstraint": "NO_GROUP_EVENTS",
+    "BriefDescription": "Maximum inbound I/O memory access bandwidth (upper bound, assuming 64B per request. Actual inbound I/O requests may be 32B or 64B)",
+    "MetricGroup": "DF_Memory_BW",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "io_memory_min_bandwidth",
+    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_read_requests_cs_3 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2 + io_write_requests_cs_3) * 32 / (duration_time * 1e6)",
+    "MetricConstraint": "NO_GROUP_EVENTS",
+    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lower bound, assuming 32B per request. Actual inbound I/O requests may be 32B or 64B)",
+    "MetricGroup": "DF_Memory_BW",
+    "ScaleUnit": "1MB/s"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 50a403b429b1..ba17117245d1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -45,3 +45,6 @@ AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
 AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
 AuthenticAMD-26-([12467][[:xdigit:]]|[[:xdigit:]]),v1,amdzen5,core
 AuthenticAMD-26-[[:xdigit:]]+,v1,amdzen6,core
+HygonGenuine-24-[0123],v1,hygonm1,core
+HygonGenuine-24-[45],v1,hygonm4,core
+HygonGenuine-24-(1[012345678]|[6789ABCDEF]),v1,hygonm6,core
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 376dc2d24162..07a843d92483 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -294,6 +294,7 @@ class JsonEvent:
           'L3PMC': 'amd_l3',
           'DFPMC': 'amd_df',
           'UMCPMC': 'amd_umc',
+          'HYGON_DF': 'hygon_df',
           'cpu_core': 'cpu_core',
           'cpu_atom': 'cpu_atom',
           'ali_drw': 'ali_drw',
@@ -390,6 +391,7 @@ class JsonEvent:
         ('Invert', 'inv='),
         ('SampleAfterValue', 'period='),
         ('UMask', 'umask='),
+        ('CompId', 'compid='),
         ('NodeType', 'type='),
         ('RdWrMask', 'rdwrmask='),
         ('EnAllCores', 'enallcores='),
-- 
2.34.1


