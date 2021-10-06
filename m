Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C52C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E94B60F9D
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbhJFIN3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:13:29 -0400
Received: from foss.arm.com ([217.140.110.172]:56878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237647AbhJFIN2 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 04:13:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3127C101E;
        Wed,  6 Oct 2021 01:11:36 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B95D3F766;
        Wed,  6 Oct 2021 01:11:34 -0700 (PDT)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] perf vendor events: Categorise the Neoverse V1 counters
Date:   Wed,  6 Oct 2021 09:11:05 +0100
Message-Id: <20211006081106.8649-3-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211006081106.8649-1-andrew.kilroy@arm.com>
References: <20211006081106.8649-1-andrew.kilroy@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is so they are categorised in the perf list output.  The pmus all
exist in the armv8-common-and-microarch.json and arm-recommended.json
files, so this commit places them into each category's own file under

  tools/perf/pmu-events/arch/arm64/arm/neoverse-v1

Also add the Neoverse V1 to the arm64 mapfile

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 .../arch/arm64/arm/neoverse-v1/branch.json    |   8 +
 .../arch/arm64/arm/neoverse-v1/bus.json       |  20 +++
 .../arch/arm64/arm/neoverse-v1/cache.json     | 155 ++++++++++++++++++
 .../arch/arm64/arm/neoverse-v1/exception.json |  47 ++++++
 .../arm64/arm/neoverse-v1/instruction.json    |  89 ++++++++++
 .../arch/arm64/arm/neoverse-v1/memory.json    |  20 +++
 .../arch/arm64/arm/neoverse-v1/other.json     |   5 +
 .../arch/arm64/arm/neoverse-v1/pipeline.json  |  23 +++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 9 files changed, 368 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/pipeline.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/branch.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/branch.json
new file mode 100644
index 000000000000..79f2016c53b0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/branch.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/bus.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/bus.json
new file mode 100644
index 000000000000..579c1c993d17
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/bus.json
@@ -0,0 +1,20 @@
+[
+    {
+        "ArchStdEvent": "CPU_CYCLES"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS"
+    },
+    {
+        "ArchStdEvent": "BUS_CYCLES"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR"
+    },
+    {
+        "ArchStdEvent": "CNT_CYCLES"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/cache.json
new file mode 100644
index 000000000000..0141f749bff3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/cache.json
@@ -0,0 +1,155 @@
+[
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1I_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_ALLOCATE"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB"
+    },
+    {
+        "ArchStdEvent": "L1I_TLB"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_ALLOCATE"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB"
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK"
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK"
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_MISS_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_LMISS_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_LMISS"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_LMISS_RD"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_LMISS_RD"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/exception.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/exception.json
new file mode 100644
index 000000000000..344a2d552ad5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/exception.json
@@ -0,0 +1,47 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN"
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR"
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF"
+    },
+    {
+        "ArchStdEvent": "EXC_SVC"
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ"
+    },
+    {
+        "ArchStdEvent": "EXC_SMC"
+    },
+    {
+        "ArchStdEvent": "EXC_HVC"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
new file mode 100644
index 000000000000..25825e14c535
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
@@ -0,0 +1,89 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR"
+    },
+    {
+        "ArchStdEvent": "INST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "EXC_RETURN"
+    },
+    {
+        "ArchStdEvent": "CID_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "TTBR_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED"
+    },
+    {
+        "ArchStdEvent": "OP_RETIRED"
+    },
+    {
+        "ArchStdEvent": "OP_SPEC"
+    },
+    {
+        "ArchStdEvent": "LDREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "DP_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC"
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC"
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC"
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json
new file mode 100644
index 000000000000..e3d08f1f7c92
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json
@@ -0,0 +1,20 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json
new file mode 100644
index 000000000000..20d8365756c5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json
@@ -0,0 +1,5 @@
+[
+    {
+        "ArchStdEvent": "REMOTE_ACCESS"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/pipeline.json
new file mode 100644
index 000000000000..f9fae15f7555
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/pipeline.json
@@ -0,0 +1,23 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEM"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index c43591d831b8..31d8b57ca9bb 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -18,6 +18,7 @@
 0x00000000410fd080,v1,arm/cortex-a57-a72,core
 0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
+0x00000000410fd400,v1,arm/neoverse-v1,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000460f0010,v1,fujitsu/a64fx,core
-- 
2.17.1

