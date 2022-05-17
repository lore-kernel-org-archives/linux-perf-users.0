Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73803C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 13:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347595AbiEQN6y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 09:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348127AbiEQN6s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 09:58:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C57274D25B;
        Tue, 17 May 2022 06:58:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E2731063;
        Tue, 17 May 2022 06:58:28 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E143F3F718;
        Tue, 17 May 2022 06:58:25 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] perf vendors events arm64: Update Cortex A57/A72
Date:   Tue, 17 May 2022 14:58:05 +0100
Message-Id: <20220517135805.313184-2-nick.forrington@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517135805.313184-1-nick.forrington@arm.com>
References: <20220517135805.313184-1-nick.forrington@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Categorise and add missing PMU events for Cortex-A57/A72, based on:
https://github.com/ARM-software/data/blob/master/pmu/cortex-a57.json
https://github.com/ARM-software/data/blob/master/pmu/cortex-a72.json

These contain the same events, and are based on the Arm Technical
Reference Manuals for Cortex-A57 and Cortex-A72.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/cortex-a57-a72/branch.json |  17 ++
 .../arch/arm64/arm/cortex-a57-a72/bus.json    |  29 +++
 .../arch/arm64/arm/cortex-a57-a72/cache.json  |  80 ++++++++
 .../arm/cortex-a57-a72/core-imp-def.json      | 179 ------------------
 .../arm64/arm/cortex-a57-a72/exception.json   |  47 +++++
 .../arm64/arm/cortex-a57-a72/instruction.json |  68 +++++++
 .../arch/arm64/arm/cortex-a57-a72/memory.json |  20 ++
 7 files changed, 261 insertions(+), 179 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json
new file mode 100644
index 000000000000..2f2d137f5f55
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json
@@ -0,0 +1,17 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json
new file mode 100644
index 000000000000..31505994c06c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json
@@ -0,0 +1,29 @@
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
+        "ArchStdEvent": "BUS_ACCESS_SHARED"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NORMAL"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_PERIPH"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json
new file mode 100644
index 000000000000..1bd59e7d982b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json
@@ -0,0 +1,80 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
deleted file mode 100644
index 543c7692677a..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
+++ /dev/null
@@ -1,179 +0,0 @@
-[
-    {
-        "ArchStdEvent": "L1D_CACHE_RD"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_WR"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_INVAL"
-    },
-    {
-        "ArchStdEvent": "L1D_TLB_REFILL_RD"
-    },
-    {
-        "ArchStdEvent": "L1D_TLB_REFILL_WR"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_RD"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_WR"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_INVAL"
-    },
-    {
-        "ArchStdEvent": "BUS_ACCESS_RD"
-    },
-    {
-        "ArchStdEvent": "BUS_ACCESS_WR"
-    },
-    {
-        "ArchStdEvent": "BUS_ACCESS_SHARED"
-    },
-    {
-        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED"
-    },
-    {
-        "ArchStdEvent": "BUS_ACCESS_NORMAL"
-    },
-    {
-        "ArchStdEvent": "BUS_ACCESS_PERIPH"
-    },
-    {
-        "ArchStdEvent": "MEM_ACCESS_RD"
-    },
-    {
-        "ArchStdEvent": "MEM_ACCESS_WR"
-    },
-    {
-        "ArchStdEvent": "UNALIGNED_LD_SPEC"
-    },
-    {
-        "ArchStdEvent": "UNALIGNED_ST_SPEC"
-    },
-    {
-        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
-    },
-    {
-        "ArchStdEvent": "LDREX_SPEC"
-    },
-    {
-        "ArchStdEvent": "STREX_PASS_SPEC"
-    },
-    {
-        "ArchStdEvent": "STREX_FAIL_SPEC"
-    },
-    {
-        "ArchStdEvent": "LD_SPEC"
-    },
-    {
-        "ArchStdEvent": "ST_SPEC"
-    },
-    {
-        "ArchStdEvent": "LDST_SPEC"
-    },
-    {
-        "ArchStdEvent": "DP_SPEC"
-    },
-    {
-        "ArchStdEvent": "ASE_SPEC"
-    },
-    {
-        "ArchStdEvent": "VFP_SPEC"
-    },
-    {
-        "ArchStdEvent": "PC_WRITE_SPEC"
-    },
-    {
-        "ArchStdEvent": "CRYPTO_SPEC"
-    },
-    {
-        "ArchStdEvent": "BR_IMMED_SPEC"
-    },
-    {
-        "ArchStdEvent": "BR_RETURN_SPEC"
-    },
-    {
-        "ArchStdEvent": "BR_INDIRECT_SPEC"
-    },
-    {
-        "ArchStdEvent": "ISB_SPEC"
-    },
-    {
-        "ArchStdEvent": "DSB_SPEC"
-    },
-    {
-        "ArchStdEvent": "DMB_SPEC"
-    },
-    {
-        "ArchStdEvent": "EXC_UNDEF"
-    },
-    {
-        "ArchStdEvent": "EXC_SVC"
-    },
-    {
-        "ArchStdEvent": "EXC_PABORT"
-    },
-    {
-        "ArchStdEvent": "EXC_DABORT"
-    },
-    {
-        "ArchStdEvent": "EXC_IRQ"
-    },
-    {
-        "ArchStdEvent": "EXC_FIQ"
-    },
-    {
-        "ArchStdEvent": "EXC_SMC"
-    },
-    {
-        "ArchStdEvent": "EXC_HVC"
-    },
-    {
-        "ArchStdEvent": "EXC_TRAP_PABORT"
-    },
-    {
-        "ArchStdEvent": "EXC_TRAP_DABORT"
-    },
-    {
-        "ArchStdEvent": "EXC_TRAP_OTHER"
-    },
-    {
-        "ArchStdEvent": "EXC_TRAP_IRQ"
-    },
-    {
-        "ArchStdEvent": "EXC_TRAP_FIQ"
-    },
-    {
-        "ArchStdEvent": "RC_LD_SPEC"
-    },
-    {
-        "ArchStdEvent": "RC_ST_SPEC"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json
new file mode 100644
index 000000000000..344a2d552ad5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json
new file mode 100644
index 000000000000..e42486d406b3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json
@@ -0,0 +1,68 @@
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
+        "ArchStdEvent": "LDREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC"
+    },
+    {
+        "ArchStdEvent": "LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC"
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json
new file mode 100644
index 000000000000..e3d08f1f7c92
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json
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
-- 
2.25.1

