Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EEFC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 11:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7164961130
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 11:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhJGLH7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:07:59 -0400
Received: from foss.arm.com ([217.140.110.172]:45842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240849AbhJGLH7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 07:07:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4CDCED1;
        Thu,  7 Oct 2021 04:06:05 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A2093F70D;
        Thu,  7 Oct 2021 04:06:02 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, john.garry@huawei.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org
Cc:     Nick.Forrington@arm.com, Andrew.Kilroy@arm.com,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf vendor-events: Fix all remaining invalid JSON files
Date:   Thu,  7 Oct 2021 12:05:40 +0100
Message-Id: <20211007110543.564963-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211007110543.564963-1-james.clark@arm.com>
References: <20211007110543.564963-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Remove trailing commas. A later commit will make the parser more strict
and these will not be valid anymore.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../arch/arm64/ampere/emag/bus.json           |  2 +-
 .../arch/arm64/ampere/emag/cache.json         | 20 +++++++++----------
 .../arch/arm64/ampere/emag/clock.json         |  2 +-
 .../arch/arm64/ampere/emag/exception.json     |  4 ++--
 .../arch/arm64/ampere/emag/instruction.json   | 10 +++++-----
 .../arch/arm64/ampere/emag/memory.json        |  4 ++--
 .../arch/arm64/hisilicon/hip08/metrics.json   |  2 +-
 .../pmu-events/arch/nds32/n13/atcpmu.json     |  2 +-
 .../pmu-events/arch/s390/cf_z10/basic.json    |  2 +-
 .../pmu-events/arch/s390/cf_z10/crypto.json   |  2 +-
 .../pmu-events/arch/s390/cf_z10/extended.json |  2 +-
 .../pmu-events/arch/s390/cf_z13/basic.json    |  2 +-
 .../pmu-events/arch/s390/cf_z13/crypto.json   |  2 +-
 .../pmu-events/arch/s390/cf_z13/extended.json |  2 +-
 .../pmu-events/arch/s390/cf_z14/basic.json    |  2 +-
 .../pmu-events/arch/s390/cf_z14/crypto.json   |  2 +-
 .../pmu-events/arch/s390/cf_z14/extended.json |  2 +-
 .../pmu-events/arch/s390/cf_z15/basic.json    |  2 +-
 .../pmu-events/arch/s390/cf_z15/crypto.json   |  2 +-
 .../pmu-events/arch/s390/cf_z15/crypto6.json  |  2 +-
 .../pmu-events/arch/s390/cf_z15/extended.json |  2 +-
 .../pmu-events/arch/s390/cf_z196/basic.json   |  2 +-
 .../pmu-events/arch/s390/cf_z196/crypto.json  |  2 +-
 .../arch/s390/cf_z196/extended.json           |  2 +-
 .../pmu-events/arch/s390/cf_zec12/basic.json  |  2 +-
 .../pmu-events/arch/s390/cf_zec12/crypto.json |  2 +-
 .../arch/s390/cf_zec12/extended.json          |  2 +-
 .../arch/test/test_soc/cpu/uncore.json        |  2 +-
 .../arch/x86/icelakex/icx-metrics.json        |  2 +-
 29 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
index 9bea1ba1c4d2..cf48d0dfc759 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
@@ -18,6 +18,6 @@
         "ArchStdEvent": "BUS_ACCESS_PERIPH"
     },
     {
-        "ArchStdEvent": "BUS_ACCESS",
+        "ArchStdEvent": "BUS_ACCESS"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
index 1e25f2ae4ae0..4cc50b7da526 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
@@ -39,31 +39,31 @@
         "ArchStdEvent": "L2D_CACHE_INVAL"
     },
     {
-        "ArchStdEvent": "L1I_CACHE_REFILL",
+        "ArchStdEvent": "L1I_CACHE_REFILL"
     },
     {
-        "ArchStdEvent": "L1I_TLB_REFILL",
+        "ArchStdEvent": "L1I_TLB_REFILL"
     },
     {
-        "ArchStdEvent": "L1D_CACHE_REFILL",
+        "ArchStdEvent": "L1D_CACHE_REFILL"
     },
     {
-        "ArchStdEvent": "L1D_CACHE",
+        "ArchStdEvent": "L1D_CACHE"
     },
     {
-        "ArchStdEvent": "L1D_TLB_REFILL",
+        "ArchStdEvent": "L1D_TLB_REFILL"
     },
     {
-        "ArchStdEvent": "L1I_CACHE",
+        "ArchStdEvent": "L1I_CACHE"
     },
     {
-        "ArchStdEvent": "L2D_CACHE",
+        "ArchStdEvent": "L2D_CACHE"
     },
     {
-        "ArchStdEvent": "L2D_CACHE_REFILL",
+        "ArchStdEvent": "L2D_CACHE_REFILL"
     },
     {
-        "ArchStdEvent": "L2D_CACHE_WB",
+        "ArchStdEvent": "L2D_CACHE_WB"
     },
     {
         "PublicDescription": "This event counts any load or store operation which accesses the data L1 TLB",
@@ -72,7 +72,7 @@
     },
     {
         "PublicDescription": "This event counts any instruction fetch which accesses the instruction L1 TLB",
-        "ArchStdEvent": "L1I_TLB",
+        "ArchStdEvent": "L1I_TLB"
     },
     {
         "PublicDescription": "Level 2 access to data TLB that caused a page table walk. This event counts on any data access which causes L2D_TLB_REFILL to count",
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
index 9076ca2daf9e..927a6f629a03 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
@@ -1,7 +1,7 @@
 [
     {
         "PublicDescription": "The number of core clock cycles",
-        "ArchStdEvent": "CPU_CYCLES",
+        "ArchStdEvent": "CPU_CYCLES"
     },
     {
         "PublicDescription": "FSU clocking gated off cycle",
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
index 9761433ad329..ada052e19632 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
@@ -36,9 +36,9 @@
         "ArchStdEvent": "EXC_TRAP_FIQ"
     },
     {
-        "ArchStdEvent": "EXC_TAKEN",
+        "ArchStdEvent": "EXC_TAKEN"
     },
     {
-        "ArchStdEvent": "EXC_RETURN",
+        "ArchStdEvent": "EXC_RETURN"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
index 482aa3f19e58..62f6276e3016 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
@@ -44,25 +44,25 @@
         "BriefDescription": "Software increment"
     },
     {
-        "ArchStdEvent": "INST_RETIRED",
+        "ArchStdEvent": "INST_RETIRED"
     },
     {
         "ArchStdEvent": "CID_WRITE_RETIRED",
         "BriefDescription": "Write to CONTEXTIDR"
     },
     {
-        "ArchStdEvent": "INST_SPEC",
+        "ArchStdEvent": "INST_SPEC"
     },
     {
-        "ArchStdEvent": "TTBR_WRITE_RETIRED",
+        "ArchStdEvent": "TTBR_WRITE_RETIRED"
     },
     {
         "PublicDescription": "This event counts all branches, taken or not. This excludes exception entries, debug entries and CCFAIL branches",
-        "ArchStdEvent": "BR_RETIRED",
+        "ArchStdEvent": "BR_RETIRED"
     },
     {
         "PublicDescription": "This event counts any branch counted by BR_RETIRED which is not correctly predicted and causes a pipeline flush",
-        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED"
     },
     {
         "PublicDescription": "Operation speculatively executed, NOP",
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
index 2e7555696caf..50157e8c2005 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
@@ -15,10 +15,10 @@
         "ArchStdEvent": "UNALIGNED_LDST_SPEC"
     },
     {
-        "ArchStdEvent": "MEM_ACCESS",
+        "ArchStdEvent": "MEM_ACCESS"
     },
     {
         "PublicDescription": "This event counts any correctable or uncorrectable memory error (ECC or parity) in the protected core RAMs",
-        "ArchStdEvent": "MEMORY_ERROR",
+        "ArchStdEvent": "MEMORY_ERROR"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
index dda8e59149d2..6970203cb247 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
@@ -229,5 +229,5 @@
         "BriefDescription": "Store bound L3 topdown metric",
         "MetricGroup": "TopDownL3",
         "MetricName": "store_bound"
-    },
+    }
 ]
diff --git a/tools/perf/pmu-events/arch/nds32/n13/atcpmu.json b/tools/perf/pmu-events/arch/nds32/n13/atcpmu.json
index 5347350c360c..3e7ac409d894 100644
--- a/tools/perf/pmu-events/arch/nds32/n13/atcpmu.json
+++ b/tools/perf/pmu-events/arch/nds32/n13/atcpmu.json
@@ -286,5 +286,5 @@
     "EventCode": "0x21e",
     "EventName": "pop25_inst",
     "BriefDescription": "V3 POP25 instructions"
-  },
+  }
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json b/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
index 2dd8dafff2ef..783de7f1aeaa 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
@@ -82,5 +82,5 @@
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/extended.json b/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
index b6b7f29ca831..86bd8ba9391d 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
@@ -124,5 +124,5 @@
 		"EventName": "L2C_STORES_SENT",
 		"BriefDescription": "L2C Stores Sent",
 		"PublicDescription": "Incremented by one for every store sent to Level-2 (L1.5) cache"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
index 2dd8dafff2ef..783de7f1aeaa 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
@@ -82,5 +82,5 @@
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
index 5da8296b667e..1a5e4f89c57e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
@@ -390,5 +390,5 @@
 		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
 		"BriefDescription": "Cycle count with two threads active",
 		"PublicDescription": "Cycle count with two threads active"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/basic.json b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
index 17fb5241928b..fc762e9f1d6e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
@@ -54,5 +54,5 @@
 		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
 		"BriefDescription": "Problem-State Instructions",
 		"PublicDescription": "Problem-State Instruction Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
index 89e070727e1b..4942b20a1ea1 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -369,5 +369,5 @@
 		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
 		"BriefDescription": "Cycle count with two threads active",
 		"PublicDescription": "Cycle count with two threads active"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/basic.json b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
index 17fb5241928b..fc762e9f1d6e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
@@ -54,5 +54,5 @@
 		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
 		"BriefDescription": "Problem-State Instructions",
 		"PublicDescription": "Problem-State Instruction Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
index c998e4f1d1d2..ad79189050a0 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
@@ -26,5 +26,5 @@
 		"EventName": "ECC_BLOCKED_CYCLES_COUNT",
 		"BriefDescription": "ECC Blocked Cycles Count",
 		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the elliptic-curve cryptography (ECC) functions issued by the CPU because the ECC coprocessor is busy performing a function issued by another CPU."
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
index 24c4ba2a9ae5..8ac61f8f286b 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
@@ -397,5 +397,5 @@
 		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
 		"BriefDescription": "Cycle count with two threads active",
 		"PublicDescription": "Cycle count with two threads active"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
index 2dd8dafff2ef..783de7f1aeaa 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
@@ -82,5 +82,5 @@
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/extended.json b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
index b7b42a870bb0..86b29fd181cf 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
@@ -166,5 +166,5 @@
 		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json b/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
index 2dd8dafff2ef..783de7f1aeaa 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
@@ -82,5 +82,5 @@
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json b/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
index db286f19e7b6..3f28007d3892 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
@@ -110,5 +110,5 @@
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json b/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
index 162251037219..f40cbed89418 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
@@ -243,5 +243,5 @@
 		"EventName": "TX_C_TABORT_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
 		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
-	},
+	}
 ]
diff --git a/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
index 788766f45dbc..73089c682f80 100644
--- a/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
+++ b/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
@@ -38,5 +38,5 @@
 	    "BriefDescription": "Total cache hits",
 	    "PublicDescription": "Total cache hits",
 	    "Unit": "imc"
-  },
+  }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index 57ddbb9f9b31..14b9a8ab15b9 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -311,5 +311,5 @@
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency"
-    },
+    }
 ]
-- 
2.28.0

