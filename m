Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE72645
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459580; cv=none; b=czt4GdlhgYGum0BZeShxSc1ydWNsr73q2HJuteZGPxzHqcrDqCDp2EQfXYz5zOO1VlSTee9wfXAfL6TUINDY0OIFe7cuUMCNXJIA5AZ4HFS9+28je0uk7No2gmS/WpOVoQFixNQcRHN+5YzwCDmJM3YPOXlD9sJHEGbIBcbOtkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459580; c=relaxed/simple;
	bh=2jcKfs8j2570hfqmJFobbtJr+YFiijx6fS5+6LD050o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dvT00uW/hc0zCRt8oQL5TmmHJ6wUb1TCvYnAYmFsD7OPgMGBbDugtG7H1t/Q+4VNTDdis7BifjAzUIM7MpIDm4bHgpaR/xP2FN6DjMmI0Of9bqJudfHu8n44jW4j4USfPCs1jF1ijgIOTD+c0zbHrwc5fGbdZXg/ZpruVM+f33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RwWb1wN1; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RwWb1wN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739459564; bh=U37SpgKCfAQXTOl9oGsbvq6Zo2b4aluskpRdxYnCskE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RwWb1wN1vp/tid0PisEYue1mRPojFuTaLlyZo7v+OAP8O9oKyYOR8mTYU+HW6QF1j
	 7Cg+zyt/5I39jjODB/mS32gjjV2n+ubb3Ev8kPVRcFVkdLhhf+IRgKqhyW+ccpMAad
	 PuYeeY2BFeIZPTWAbMznNdipLYcJ9ICxT7s7Juf0=
Received: from cyy-pc.lan ([240e:379:2251:3600:f57b:26f9:9718:486c])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 3212741D; Thu, 13 Feb 2025 23:12:33 +0800
X-QQ-mid: xmsmtpt1739459553t5bpdbvqy
Message-ID: <tencent_0434DA8D8E21B8C4318A213C8D6B7CC08208@qq.com>
X-QQ-XMAILINFO: NnIX2CK8LSsJ3nFwDszqQ65PatHZarqNE0mnYsZsqegbGZxPt75uhFbjNEJ9u4
	 Cox/zl30YWP1PXQZdh/tHMM1D+EmgORCQvbsbRYVXdHZYOLo3g80Jc1rckUcHPM54LMNBfJjxlvw
	 ecw6YIYZdlBaSBT/siR+8+ZEzv16r/rYQQIUgik86Jtdr0j4pNgedMfVpFDoM9OzfpH/cqnYH6Ft
	 iYtWU6p4ErA7f6KSTU0/+glN626I8JlEu046Pm4aMJA/KOkPa5uu3ZQUNWS5+/r3Fl3SDCLcTjNb
	 EKbcArcEHOu1/JbjWhhDI81/VzWsQJ7Ifd0s96PWOn08bnJIQeLvM/q+lud7RACo7xYLJ/CySKvX
	 IdItbCFSfDKhCYP4hCzQ1dmUlj9DTDnH7EJz3G/+VwFOklhD9f52pGdxhu3fwRSfmCw5ov+EstVE
	 vOQRJjnp1WIZIVh/wuinmeuG+adKoks2EZN6QAEUnLJdVqRqrxlU0b87vdipl0xnf1LRULxQIybV
	 Q+ivDM/QA1Xkq6ffVQZKJLyVdz6FWoFHw89iwJZj97lEFi9jT55kmENXsrajTgk7sqKFJg78vlsK
	 aduYgdl8kHveBgBCyJj8lrtzV+LPorL4oEzahKa6xsbTMDXVeu75h204ae7IFjX79GKrVJBATaqX
	 IiG/zhbxxKvgAwigMQcGBCC0mn+ISgSGYTDysjLblqpQLIrMXWC9LTqSGCc67QrtSwOQKbgU/wKe
	 5dzODMn1JxU+OfAj1Co5PvIS/Z44YAO6Y/4VlrLRcrMykVjPZStLmeY86tj/XASCvpxFmJlgyFpW
	 s72S9EnYdeDuKx3uS5sYqIvOa6KjeWFMeyPTYr2L1eluSYOXIpgzjcd5+wZupd1+paguIbbqCv2v
	 EE7SgDPV6MB4T04a2+62sCYUMP3BT7YtjJqKnj/RUlSAPeAk7zunUJi3/CZ5KKWgc6G4jlPFF8aw
	 YY15TJ/p+Lnv6IVCuHR0oYknbLl95Iv8/3RhXpkAvOHMNRdj+JWW3EhyXpLVwfrMTbXUPsFlArO+
	 wRWMwEXg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-perf-users@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 1/2] perf vendor events arm64: Add Cortex-A720 events/metrics
Date: Thu, 13 Feb 2025 23:12:25 +0800
X-OQ-MSGID: <20250213151226.187205-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add JSON files for Cortex-A720 events and metrics. Using the existing
Neoverse N3 JSON files as a template, I manually checked the missing and
extra events/metrics using my script [1] and modified them according to
the Arm Cortex-A720 Core Technical Reference Manual [2].

[1] https://github.com/cyyself/arm-pmu-check/tree/1075bebeb3f1441067448251a387df35af15bf16
[2] https://developer.arm.com/documentation/102530/0002/Performance-Monitors-Extension-support-/Performance-monitors-events

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 .../arch/arm64/arm/cortex-a720/bus.json       |  18 +
 .../arch/arm64/arm/cortex-a720/exception.json |  62 +++
 .../arm64/arm/cortex-a720/fp_operation.json   |  22 +
 .../arch/arm64/arm/cortex-a720/general.json   |  10 +
 .../arch/arm64/arm/cortex-a720/l1d_cache.json |  50 ++
 .../arch/arm64/arm/cortex-a720/l1i_cache.json |  14 +
 .../arch/arm64/arm/cortex-a720/l2_cache.json  |  62 +++
 .../arch/arm64/arm/cortex-a720/l3_cache.json  |  22 +
 .../arch/arm64/arm/cortex-a720/ll_cache.json  |  10 +
 .../arch/arm64/arm/cortex-a720/memory.json    |  54 +++
 .../arch/arm64/arm/cortex-a720/metrics.json   | 436 ++++++++++++++++++
 .../arch/arm64/arm/cortex-a720/pmu.json       |   8 +
 .../arch/arm64/arm/cortex-a720/retired.json   |  90 ++++
 .../arch/arm64/arm/cortex-a720/spe.json       |  42 ++
 .../arm64/arm/cortex-a720/spec_operation.json |  90 ++++
 .../arch/arm64/arm/cortex-a720/stall.json     |  82 ++++
 .../arch/arm64/arm/cortex-a720/sve.json       |  50 ++
 .../arch/arm64/arm/cortex-a720/tlb.json       |  74 +++
 .../arch/arm64/arm/cortex-a720/trace.json     |  32 ++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 20 files changed, 1229 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/pmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/trace.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/bus.json
new file mode 100644
index 000000000000..2e11a8c4a484
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/bus.json
@@ -0,0 +1,18 @@
+[
+    {
+        "ArchStdEvent": "BUS_ACCESS",
+        "PublicDescription": "Counts memory transactions issued by the CPU to the external bus, including snoop requests and snoop responses. Each beat of data is counted individually."
+    },
+    {
+        "ArchStdEvent": "BUS_CYCLES",
+        "PublicDescription": "Counts bus cycles in the CPU. Bus cycles represent a clock cycle in which a transaction could be sent or received on the interface from the CPU to the external bus. Since that interface is driven at the same clock speed as the CPU, this event is a duplicate of CPU_CYCLES."
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD",
+        "PublicDescription": "Counts memory read transactions seen on the external bus. Each beat of data is counted individually."
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR",
+        "PublicDescription": "Counts memory write transactions seen on the external bus. Each beat of data is counted individually."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/exception.json
new file mode 100644
index 000000000000..7126fbf292e0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/exception.json
@@ -0,0 +1,62 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN",
+        "PublicDescription": "Counts any taken architecturally visible exceptions such as IRQ, FIQ, SError, and other synchronous exceptions. Exceptions are counted whether or not they are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_RETURN",
+        "PublicDescription": "Counts any architecturally executed exception return instructions. For example: AArch64: ERET"
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF",
+        "PublicDescription": "Counts the number of synchronous exceptions which are taken locally that are due to attempting to execute an instruction that is UNDEFINED. Attempting to execute instruction bit patterns that have not been allocated. Attempting to execute instructions when they are disabled. Attempting to execute instructions at an inappropriate Exception level. Attempting to execute an instruction when the value of PSTATE.IL is 1."
+    },
+    {
+        "ArchStdEvent": "EXC_SVC",
+        "PublicDescription": "Counts SVC exceptions taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT",
+        "PublicDescription": "Counts synchronous exceptions that are taken locally and caused by Instruction Aborts."
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT",
+        "PublicDescription": "Counts exceptions that are taken locally and are caused by data aborts or SErrors. Conditions that could cause those exceptions are attempting to read or write memory where the MMU generates a fault, attempting to read or write memory with a misaligned address, interrupts from the nSEI inputs and internally generated SErrors."
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ",
+        "PublicDescription": "Counts IRQ exceptions including the virtual IRQs that are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+        "PublicDescription": "Counts FIQ exceptions including the virtual FIQs that are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_SMC",
+        "PublicDescription": "Counts SMC exceptions take to EL3."
+    },
+    {
+        "ArchStdEvent": "EXC_HVC",
+        "PublicDescription": "Counts HVC exceptions taken to EL2."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT",
+        "PublicDescription": "Counts exceptions which are traps not taken locally and are caused by Instruction Aborts. For example, attempting to execute an instruction with a misaligned PC."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT",
+        "PublicDescription": "Counts exceptions which are traps not taken locally and are caused by Data Aborts or SError interrupts. Conditions that could cause those exceptions are:\n\n1. Attempting to read or write memory where the MMU generates a fault,\n2. Attempting to read or write memory with a misaligned address,\n3. Interrupts from the SEI input.\n4. internally generated SErrors."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER",
+        "PublicDescription": "Counts the number of synchronous trap exceptions which are not taken locally and are not SVC, SMC, HVC, data aborts, Instruction Aborts, or interrupts."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ",
+        "PublicDescription": "Counts IRQ exceptions including the virtual IRQs that are not taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ",
+        "PublicDescription": "Counts FIQs which are not taken locally but taken from EL0, EL1,\n or EL2 to EL3 (which would be the normal behavior for FIQs when not executing\n in EL3)."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/fp_operation.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/fp_operation.json
new file mode 100644
index 000000000000..cec3435ac766
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/fp_operation.json
@@ -0,0 +1,22 @@
+[
+    {
+        "ArchStdEvent": "FP_HP_SPEC",
+        "PublicDescription": "Counts speculatively executed half precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_SP_SPEC",
+        "PublicDescription": "Counts speculatively executed single precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_DP_SPEC",
+        "PublicDescription": "Counts speculatively executed double precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_SCALE_OPS_SPEC",
+        "PublicDescription": "Counts speculatively executed scalable single precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_FIXED_OPS_SPEC",
+        "PublicDescription": "Counts speculatively executed non-scalable single precision floating point operations."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/general.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/general.json
new file mode 100644
index 000000000000..c5dcdcf43c58
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/general.json
@@ -0,0 +1,10 @@
+[
+    {
+        "ArchStdEvent": "CPU_CYCLES",
+        "PublicDescription": "Counts CPU clock cycles (not timer cycles). The clock measured by this event is defined as the physical clock driving the CPU logic."
+    },
+    {
+        "ArchStdEvent": "CNT_CYCLES",
+        "PublicDescription": "Increments at a constant frequency equal to the rate of increment of the System Counter, CNTPCT_EL0."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1d_cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1d_cache.json
new file mode 100644
index 000000000000..a6fee569f4c6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1d_cache.json
@@ -0,0 +1,50 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL",
+        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed load or store operations that missed in the level 1 data cache. This event only counts one event per cache line."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE",
+        "PublicDescription": "Counts level 1 data cache accesses from any load/store operations. Atomic operations that resolve in the CPUs caches (near atomic operations) counts as both a write access and read access. Each access to a cache line is counted including the multiple accesses caused by single instructions such as LDM or STM. Each access to other level 1 data or unified memory structures, for example refill buffers, write buffers, and write-back buffers, are also counted."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB",
+        "PublicDescription": "Counts write-backs of dirty data from the L1 data cache to the L2 cache. This occurs when either a dirty cache line is evicted from L1 data cache and allocated in the L2 cache or dirty data is written to the L2 and possibly to the next level of cache. This event counts both victim cache line evictions and cache write-backs from snoops or cache maintenance operations. The following cache operations are not counted:\n\n1. Invalidations which do not result in data being transferred out of the L1 (such as evictions of clean data),\n2. Full line writes which write to L2 without writing L1, such as write streaming mode."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_LMISS_RD",
+        "PublicDescription": "Counts cache line refills into the level 1 data cache from any memory read operations, that incurred additional latency."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+        "PublicDescription": "Counts level 1 data cache accesses from any load operation. Atomic load operations that resolve in the CPUs caches counts as both a write access and read access."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+        "PublicDescription": "Counts level 1 data cache accesses generated by store operations. This event also counts accesses caused by a DC ZVA (data cache zero, specified by virtual address) instruction. Near atomic operations that resolve in the CPUs caches count as a write access and read access."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
+        "PublicDescription": "Counts level 1 data cache refills where the cache line data came from caches inside the immediate cluster of the core."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
+        "PublicDescription": "Counts level 1 data cache refills for which the cache line data came from outside the immediate cluster of the core, like an SLC in the system interconnect or DRAM."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+        "PublicDescription": "Counts each explicit invalidation of a cache line in the level 1 data cache caused by:\n\n- Cache Maintenance Operations (CMO) that operate by a virtual address.\n- Broadcast cache coherency operations from another CPU in the system.\n\nThis event does not count for the following conditions:\n\n1. A cache refill invalidates a cache line.\n2. A CMO which is executed on that CPU and invalidates a cache line specified by set/way.\n\nNote that CMOs that operate by set/way cannot be broadcast from one CPU to another."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RW",
+        "PublicDescription": "Counts level 1 data demand cache accesses from any load or store operation. Near atomic operations that resolve in the CPUs caches counts as both a write access and read access."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_PRF",
+        "BriefDescription": "This event counts fetch counted by either Level 1 data hardware prefetch or Level 1 data software prefetch."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_PRF",
+        "BriefDescription": "This event counts hardware prefetch counted by L1D_CACHE_PRF that causes a refill of the Level 1 data cache from outside of the Level 1 data cache."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1i_cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1i_cache.json
new file mode 100644
index 000000000000..633f1030359d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1i_cache.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL",
+        "PublicDescription": "Counts cache line refills in the level 1 instruction cache caused by a missed instruction fetch. Instruction fetches may include accessing multiple instructions, but the single cache line allocation is counted once."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE",
+        "PublicDescription": "Counts instruction fetches which access the level 1 instruction cache. Instruction cache accesses caused by cache maintenance operations are not counted."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_LMISS",
+        "PublicDescription": "Counts cache line refills into the level 1 instruction cache, that incurred additional latency."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l2_cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l2_cache.json
new file mode 100644
index 000000000000..3806fef42b30
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l2_cache.json
@@ -0,0 +1,62 @@
+[
+    {
+        "ArchStdEvent": "L2D_CACHE",
+        "PublicDescription": "Counts accesses to the level 2 cache due to data accesses. Level 2 cache is a unified cache for data and instruction accesses. Accesses are for misses in the first level data cache or translation resolutions due to accesses. This event also counts write back of dirty data from level 1 data cache to the L2 cache."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL",
+        "PublicDescription": "Counts cache line refills into the level 2 cache. Level 2 cache is a unified cache for data and instruction accesses. Accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB",
+        "PublicDescription": "Counts write-backs of data from the L2 cache to outside the CPU. This includes snoops to the L2 (from other CPUs) which return data even if the snoops cause an invalidation. L2 cache line invalidations which do not write data outside the CPU and snoops which return data from an L1 cache are not counted. Data would not be written outside the cache when invalidating a clean cache line."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_ALLOCATE",
+        "PublicDescription": "Counts level 2 cache line allocates that do not fetch data from outside the level 2 data or unified cache."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD",
+        "PublicDescription": "Counts level 2 data cache accesses due to memory read operations. Level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR",
+        "PublicDescription": "Counts level 2 cache accesses due to memory write operations. Level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
+        "PublicDescription": "Counts refills for memory accesses due to memory read operation counted by L2D_CACHE_RD. Level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
+        "PublicDescription": "Counts refills for memory accesses due to memory write operation counted by L2D_CACHE_WR. Level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
+        "PublicDescription": "Counts evictions from the level 2 cache because of a line being allocated into the L2 cache."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
+        "PublicDescription": "Counts write-backs from the level 2 cache that are a result of either:\n\n1. Cache maintenance operations,\n\n2. Snoop responses or,\n\n3. Direct cache transfers to another CPU due to a forwarding snoop request."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL",
+        "PublicDescription": "Counts each explicit invalidation of a cache line in the level 2 cache by cache maintenance operations that operate by a virtual address, or by external coherency operations. This event does not count if either:\n\n1. A cache refill invalidates a cache line or,\n2. A Cache Maintenance Operation (CMO), which invalidates a cache line specified by set/way, is executed on that CPU.\n\nCMOs that operate by set/way cannot be broadcast from one CPU to another."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_LMISS_RD",
+        "PublicDescription": "Counts cache line refills into the level 2 unified cache from any memory read operations that incurred additional latency."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RW",
+        "PublicDescription": "Counts level 2 cache demand accesses from any load/store operations. Level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_PRF",
+        "PublicDescription": "Counts level 2 data cache accesses from software preload or prefetch instructions or hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_PRF",
+        "PublicDescription": "Counts refills due to accesses generated as a result of prefetches."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l3_cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l3_cache.json
new file mode 100644
index 000000000000..4a2e72fc5ada
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l3_cache.json
@@ -0,0 +1,22 @@
+[
+    {
+        "ArchStdEvent": "L3D_CACHE_ALLOCATE",
+        "PublicDescription": "Counts level 3 cache line allocates that do not fetch data from outside the level 3 data or unified cache. For example, allocates due to streaming stores."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL",
+        "PublicDescription": "Counts level 3 accesses that receive data from outside the L3 cache."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE",
+        "PublicDescription": "Counts level 3 cache accesses. Level 3 cache is a unified cache for data and instruction accesses. Accesses are for misses in the lower level caches or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD",
+        "PublicDescription": "Counts level 3 cache accesses caused by any memory read operation. Level 3 cache is a unified cache for data and instruction accesses. Accesses are for misses in the lower level caches or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_LMISS_RD",
+        "PublicDescription": "Counts any cache line refill into the level 3 cache from memory read operations that incurred additional latency."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/ll_cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/ll_cache.json
new file mode 100644
index 000000000000..fd5a2e0099b8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/ll_cache.json
@@ -0,0 +1,10 @@
+[
+    {
+        "ArchStdEvent": "LL_CACHE_RD",
+        "PublicDescription": "Counts read transactions that were returned from outside the core cluster. This event counts for external last level cache  when the system register CPUECTLR.EXTLLC bit is set, otherwise it counts for the L3 cache. This event counts read transactions returned from outside the core if those transactions are either hit in the system level cache or missed in the SLC and are returned from any other external sources."
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_MISS_RD",
+        "PublicDescription": "Counts read transactions that were returned from outside the core cluster but missed in the system level cache. This event counts for external last level cache when the system register CPUECTLR.EXTLLC bit is set, otherwise it counts for L3 cache. This event counts read transactions returned from outside the core if those transactions are missed in the System level Cache. The data source of the transaction is indicated by a field in the CHI transaction returning to the CPU. This event does not count reads caused by cache maintenance operations."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/memory.json
new file mode 100644
index 000000000000..f19204a5faae
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/memory.json
@@ -0,0 +1,54 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS",
+        "PublicDescription": "Counts memory accesses issued by the CPU load store unit, where those accesses are issued due to load or store operations. This event counts memory accesses no matter whether the data is received from any level of cache hierarchy or external memory. If memory accesses are broken up into smaller transactions than what were specified in the load or store instructions, then the event counts those smaller memory transactions."
+    },
+    {
+        "ArchStdEvent": "REMOTE_ACCESS",
+        "PublicDescription": "Counts accesses to another chip, which is implemented as a different CMN mesh in the system. If the CHI bus response back to the core indicates that the data source is from another chip (mesh), then the counter is updated. If no data is returned, even if the system snoops another chip/mesh, then the counter is not updated."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD",
+        "PublicDescription": "Counts memory accesses issued by the CPU due to load operations. The event counts any memory load access, no matter whether the data is received from any level of cache hierarchy or external memory. The event also counts atomic load operations. If memory accesses are broken up by the load/store unit into smaller transactions that are issued by the bus interface, then the event counts those smaller transactions."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR",
+        "PublicDescription": "Counts memory accesses issued by the CPU due to store operations. The event counts any memory store access, no matter whether the data is located in any level of cache or external memory. The event also counts atomic load and store operations. If memory accesses are broken up by the load/store unit into smaller transactions that are issued by the bus interface, then the event counts those smaller transactions."
+    },
+    {
+        "ArchStdEvent": "LDST_ALIGN_LAT",
+        "PublicDescription": "Counts the number of memory read and write accesses in a cycle that incurred additional latency, due to the alignment of the address and the size of data being accessed, which results in store crossing a single cache line."
+    },
+    {
+        "ArchStdEvent": "LD_ALIGN_LAT",
+        "PublicDescription": "Counts the number of memory read accesses in a cycle that incurred additional latency, due to the alignment of the address and size of data being accessed, which results in load crossing a single cache line."
+    },
+    {
+        "ArchStdEvent": "ST_ALIGN_LAT",
+        "PublicDescription": "Counts the number of memory write access in a cycle that incurred additional latency, due to the alignment of the address and size of data being accessed incurred additional latency."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED",
+        "PublicDescription": "Counts the number of memory read and write accesses counted by MEM_ACCESS that are tag checked by the Memory Tagging Extension (MTE). This event is implemented as the sum of MEM_ACCESS_CHECKED_RD and MEM_ACCESS_CHECKED_WR"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_RD",
+        "PublicDescription": "Counts the number of memory read accesses in a cycle that are tag checked by the Memory Tagging Extension (MTE)."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_WR",
+        "PublicDescription": "Counts the number of memory write accesses in a cycle that is tag checked by the Memory Tagging Extension (MTE)."
+    },
+    {
+        "ArchStdEvent": "INST_FETCH_PERCYC",
+        "PublicDescription": "Counts number of instruction fetches outstanding per cycle, which will provide an average latency of instruction fetch."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD_PERCYC",
+        "PublicDescription": "Counts the number of outstanding loads or memory read accesses per cycle."
+    },
+    {
+        "ArchStdEvent": "INST_FETCH",
+        "PublicDescription": "Counts Instruction memory accesses that the PE makes."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/metrics.json
new file mode 100644
index 000000000000..d8e8b5155cfa
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/metrics.json
@@ -0,0 +1,436 @@
+[
+    {
+        "ArchStdEvent": "backend_bound"
+    },
+    {
+        "MetricName": "backend_busy_bound",
+        "MetricExpr": "STALL_BACKEND_BUSY / STALL_BACKEND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the backend due to issue queues being full to accept operations for execution.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_cache_l1d_bound",
+        "MetricExpr": "STALL_BACKEND_L1D / (STALL_BACKEND_L1D + STALL_BACKEND_MEM) * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the backend due to memory access latency issues caused by level 1 data cache misses.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_cache_l2d_bound",
+        "MetricExpr": "STALL_BACKEND_MEM / (STALL_BACKEND_L1D + STALL_BACKEND_MEM) * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the backend due to memory access latency issues caused by level 2 data cache misses.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_core_bound",
+        "MetricExpr": "STALL_BACKEND_CPUBOUND / STALL_BACKEND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the backend due to backend core resource constraints not related to instruction fetch latency issues caused by memory access components.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_core_rename_bound",
+        "MetricExpr": "STALL_BACKEND_RENAME / STALL_BACKEND_CPUBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the backend as the rename unit registers are unavailable.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_mem_bound",
+        "MetricExpr": "STALL_BACKEND_MEMBOUND / STALL_BACKEND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the backend due to backend core resource constraints related to memory access latency issues caused by memory access components.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_mem_cache_bound",
+        "MetricExpr": "(STALL_BACKEND_L1D + STALL_BACKEND_MEM) / STALL_BACKEND_MEMBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the backend due to memory latency issues caused by data cache misses.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_mem_store_bound",
+        "MetricExpr": "STALL_BACKEND_ST / STALL_BACKEND_MEMBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the frontend due to memory write pending caused by stores stalled in the pre-commit stage.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_mem_tlb_bound",
+        "MetricExpr": "STALL_BACKEND_TLB / STALL_BACKEND_MEMBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the backend due to memory access latency issues caused by data TLB misses.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_stalled_cycles",
+        "MetricExpr": "STALL_BACKEND / CPU_CYCLES * 100",
+        "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the backend unit of the processor.",
+        "MetricGroup": "Cycle_Accounting",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "ArchStdEvent": "bad_speculation",
+        "MetricExpr": "(1 - STALL_SLOT / (10 * CPU_CYCLES)) * (1 - OP_RETIRED / OP_SPEC) * 100 + STALL_FRONTEND_FLUSH / CPU_CYCLES * 100"
+    },
+    {
+        "MetricName": "barrier_percentage",
+        "MetricExpr": "(ISB_SPEC + DSB_SPEC + DMB_SPEC) / INST_SPEC * 100",
+        "BriefDescription": "This metric measures instruction and data barrier operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "branch_direct_ratio",
+        "MetricExpr": "BR_IMMED_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of direct branches retired to the total number of branches architecturally executed.",
+        "MetricGroup": "Branch_Effectiveness",
+        "ScaleUnit": "1per branch"
+    },
+    {
+        "MetricName": "branch_indirect_ratio",
+        "MetricExpr": "BR_IND_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of indirect branches retired, including function returns, to the total number of branches architecturally executed.",
+        "MetricGroup": "Branch_Effectiveness",
+        "ScaleUnit": "1per branch"
+    },
+    {
+        "MetricName": "branch_misprediction_ratio",
+        "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of branches mispredicted to the total number of branches architecturally executed. This gives an indication of the effectiveness of the branch prediction unit.",
+        "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
+        "ScaleUnit": "100percent of branches"
+    },
+    {
+        "MetricName": "branch_mpki",
+        "MetricExpr": "BR_MIS_PRED_RETIRED / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of branch mispredictions per thousand instructions executed.",
+        "MetricGroup": "MPKI;Branch_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "branch_return_ratio",
+        "MetricExpr": "BR_RETURN_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of branches retired that are function returns to the total number of branches architecturally executed.",
+        "MetricGroup": "Branch_Effectiveness",
+        "ScaleUnit": "1per branch"
+    },
+    {
+        "MetricName": "crypto_percentage",
+        "MetricExpr": "CRYPTO_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures crypto operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "dtlb_mpki",
+        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of data TLB Walks per thousand instructions executed.",
+        "MetricGroup": "MPKI;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "dtlb_walk_ratio",
+        "MetricExpr": "DTLB_WALK / L1D_TLB",
+        "BriefDescription": "This metric measures the ratio of data TLB Walks to the total number of data TLB accesses. This gives an indication of the effectiveness of the data TLB accesses.",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
+        "ScaleUnit": "100percent of TLB accesses"
+    },
+    {
+        "MetricName": "fp16_percentage",
+        "MetricExpr": "FP_HP_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures half-precision floating point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "FP_Precision_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "fp32_percentage",
+        "MetricExpr": "FP_SP_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures single-precision floating point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "FP_Precision_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "fp64_percentage",
+        "MetricExpr": "FP_DP_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures double-precision floating point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "FP_Precision_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "fp_ops_per_cycle",
+        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLES",
+        "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by any instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
+        "MetricGroup": "FP_Arithmetic_Intensity",
+        "ScaleUnit": "1operations per cycle"
+    },
+    {
+        "MetricName": "frontend_cache_l1i_bound",
+        "MetricExpr": "STALL_FRONTEND_L1I / (STALL_FRONTEND_L1I + STALL_FRONTEND_MEM) * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the frontend due to memory access latency issues caused by level 1 instruction cache misses.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_cache_l2i_bound",
+        "MetricExpr": "STALL_FRONTEND_MEM / (STALL_FRONTEND_L1I + STALL_FRONTEND_MEM) * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the frontend due to memory access latency issues caused by level 2 instruction cache misses.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_core_bound",
+        "MetricExpr": "STALL_FRONTEND_CPUBOUND / STALL_FRONTEND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the frontend due to frontend core resource constraints not related to instruction fetch latency issues caused by memory access components.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_core_flush_bound",
+        "MetricExpr": "STALL_FRONTEND_FLUSH / STALL_FRONTEND_CPUBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the frontend as the processor is recovering from a pipeline flush caused by bad speculation or other machine resteers.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_mem_bound",
+        "MetricExpr": "STALL_FRONTEND_MEMBOUND / STALL_FRONTEND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the frontend due to frontend core resource constraints related to the instruction fetch latency issues caused by memory access components.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_mem_cache_bound",
+        "MetricExpr": "(STALL_FRONTEND_L1I + STALL_FRONTEND_MEM) / STALL_FRONTEND_MEMBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the frontend due to instruction fetch latency issues caused by instruction cache misses.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_mem_tlb_bound",
+        "MetricExpr": "STALL_FRONTEND_TLB / STALL_FRONTEND_MEMBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles stalled in the frontend due to instruction fetch latency issues caused by instruction TLB misses.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_stalled_cycles",
+        "MetricExpr": "STALL_FRONTEND / CPU_CYCLES * 100",
+        "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the frontend unit of the processor.",
+        "MetricGroup": "Cycle_Accounting",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "integer_dp_percentage",
+        "MetricExpr": "DP_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures scalar integer operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "ipc",
+        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
+        "BriefDescription": "This metric measures the number of instructions retired per cycle.",
+        "MetricGroup": "General",
+        "ScaleUnit": "1per cycle"
+    },
+    {
+        "MetricName": "itlb_mpki",
+        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of instruction TLB Walks per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "itlb_walk_ratio",
+        "MetricExpr": "ITLB_WALK / L1I_TLB",
+        "BriefDescription": "This metric measures the ratio of instruction TLB Walks to the total number of instruction TLB accesses. This gives an indication of the effectiveness of the instruction TLB accesses.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
+        "ScaleUnit": "100percent of TLB accesses"
+    },
+    {
+        "MetricName": "l1d_cache_miss_ratio",
+        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
+        "BriefDescription": "This metric measures the ratio of level 1 data cache accesses missed to the total number of level 1 data cache accesses. This gives an indication of the effectiveness of the level 1 data cache.",
+        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
+        "ScaleUnit": "100percent of cache accesses"
+    },
+    {
+        "MetricName": "l1d_cache_mpki",
+        "MetricExpr": "L1D_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 1 data cache accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;L1D_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1d_tlb_miss_ratio",
+        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
+        "BriefDescription": "This metric measures the ratio of level 1 data TLB accesses missed to the total number of level 1 data TLB accesses. This gives an indication of the effectiveness of the level 1 data TLB.",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
+        "ScaleUnit": "100percent of TLB accesses"
+    },
+    {
+        "MetricName": "l1d_tlb_mpki",
+        "MetricExpr": "L1D_TLB_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 1 data TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1i_cache_miss_ratio",
+        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
+        "BriefDescription": "This metric measures the ratio of level 1 instruction cache accesses missed to the total number of level 1 instruction cache accesses. This gives an indication of the effectiveness of the level 1 instruction cache.",
+        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
+        "ScaleUnit": "100percent of cache accesses"
+    },
+    {
+        "MetricName": "l1i_cache_mpki",
+        "MetricExpr": "L1I_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 1 instruction cache accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;L1I_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1i_tlb_miss_ratio",
+        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
+        "BriefDescription": "This metric measures the ratio of level 1 instruction TLB accesses missed to the total number of level 1 instruction TLB accesses. This gives an indication of the effectiveness of the level 1 instruction TLB.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
+        "ScaleUnit": "100percent of TLB accesses"
+    },
+    {
+        "MetricName": "l1i_tlb_mpki",
+        "MetricExpr": "L1I_TLB_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 1 instruction TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l2_cache_miss_ratio",
+        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
+        "BriefDescription": "This metric measures the ratio of level 2 cache accesses missed to the total number of level 2 cache accesses. This gives an indication of the effectiveness of the level 2 cache, which is a unified cache that stores both data and instruction. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
+        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
+        "ScaleUnit": "100percent of cache accesses"
+    },
+    {
+        "MetricName": "l2_cache_mpki",
+        "MetricExpr": "L2D_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 2 unified cache accesses missed per thousand instructions executed. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
+        "MetricGroup": "MPKI;L2_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l2_tlb_miss_ratio",
+        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
+        "BriefDescription": "This metric measures the ratio of level 2 unified TLB accesses missed to the total number of level 2 unified TLB accesses. This gives an indication of the effectiveness of the level 2 TLB.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness",
+        "ScaleUnit": "100percent of TLB accesses"
+    },
+    {
+        "MetricName": "l2_tlb_mpki",
+        "MetricExpr": "L2D_TLB_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 2 unified TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "ll_cache_read_hit_ratio",
+        "MetricExpr": "(LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD",
+        "BriefDescription": "This metric measures the ratio of last level cache read accesses hit in the cache to the total number of last level cache accesses. This gives an indication of the effectiveness of the last level cache for read traffic. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a system level cache.",
+        "MetricGroup": "LL_Cache_Effectiveness",
+        "ScaleUnit": "100percent of cache accesses"
+    },
+    {
+        "MetricName": "ll_cache_read_miss_ratio",
+        "MetricExpr": "LL_CACHE_MISS_RD / LL_CACHE_RD",
+        "BriefDescription": "This metric measures the ratio of last level cache read accesses missed to the total number of last level cache accesses. This gives an indication of the effectiveness of the last level cache for read traffic. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a system level cache.",
+        "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness",
+        "ScaleUnit": "100percent of cache accesses"
+    },
+    {
+        "MetricName": "ll_cache_read_mpki",
+        "MetricExpr": "LL_CACHE_MISS_RD / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of last level cache read accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;LL_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "load_percentage",
+        "MetricExpr": "LD_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures load operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "nonsve_fp_ops_per_cycle",
+        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLES",
+        "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by an instruction that is not an SVE instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
+        "MetricGroup": "FP_Arithmetic_Intensity",
+        "ScaleUnit": "1operations per cycle"
+    },
+    {
+        "MetricName": "scalar_fp_percentage",
+        "MetricExpr": "VFP_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures scalar floating point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "simd_percentage",
+        "MetricExpr": "ASE_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures advanced SIMD operations as a percentage of total operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "store_percentage",
+        "MetricExpr": "ST_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures store operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "sve_all_percentage",
+        "MetricExpr": "SVE_INST_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operations, including loads and stores, as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "sve_fp_ops_per_cycle",
+        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLES",
+        "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by SVE instructions. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
+        "MetricGroup": "FP_Arithmetic_Intensity",
+        "ScaleUnit": "1operations per cycle"
+    },
+    {
+        "MetricName": "sve_predicate_empty_percentage",
+        "MetricExpr": "SVE_PRED_EMPTY_SPEC / SVE_PRED_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operations with no active predicates as a percentage of sve predicated operations speculatively executed.",
+        "MetricGroup": "SVE_Effectiveness",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "sve_predicate_full_percentage",
+        "MetricExpr": "SVE_PRED_FULL_SPEC / SVE_PRED_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operations with all active predicates as a percentage of sve predicated operations speculatively executed.",
+        "MetricGroup": "SVE_Effectiveness",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "sve_predicate_partial_percentage",
+        "MetricExpr": "SVE_PRED_PARTIAL_SPEC / SVE_PRED_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operations with at least one active predicates as a percentage of sve predicated operations speculatively executed.",
+        "MetricGroup": "SVE_Effectiveness",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "sve_predicate_percentage",
+        "MetricExpr": "SVE_PRED_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operations with predicates as a percentage of operations speculatively executed.",
+        "MetricGroup": "SVE_Effectiveness",
+        "ScaleUnit": "1percent of operations"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/pmu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/pmu.json
new file mode 100644
index 000000000000..d8b7b9f9e5fa
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/pmu.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "PMU_OVFS"
+    },
+    {
+        "ArchStdEvent": "PMU_HOVFS"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/retired.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/retired.json
new file mode 100644
index 000000000000..69f9a0b0c7ff
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/retired.json
@@ -0,0 +1,90 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR",
+        "PublicDescription": "Counts software writes to the PMSWINC_EL0 (software PMU increment) register. The PMSWINC_EL0 register is a manually updated counter for use by application software.\n\nThis event could be used to measure any user program event, such as accesses to a particular data structure (by writing to the PMSWINC_EL0 register each time the data structure is accessed).\n\nTo use the PMSWINC_EL0 register and event, developers must insert instructions that write to the PMSWINC_EL0 register into the source code.\n\nSince the SW_INCR event records writes to the PMSWINC_EL0 register, there is no need to do a read/increment/write sequence to the PMSWINC_EL0 register."
+    },
+    {
+        "ArchStdEvent": "INST_RETIRED",
+        "PublicDescription": "Counts instructions that have been architecturally executed."
+    },
+    {
+        "ArchStdEvent": "CID_WRITE_RETIRED",
+        "PublicDescription": "Counts architecturally executed writes to the CONTEXTIDR_EL1 register, which usually contain the kernel PID and can be output with hardware trace."
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_RETIRED",
+        "PublicDescription": "Counts branch instructions that caused a change of Program Counter, which effectively causes a change in the control flow of the program."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_RETIRED",
+        "PublicDescription": "Counts architecturally executed direct branches."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_RETIRED",
+        "PublicDescription": "Counts architecturally executed procedure returns."
+    },
+    {
+        "ArchStdEvent": "TTBR_WRITE_RETIRED",
+        "PublicDescription": "Counts architectural writes to TTBR0/1_EL1. If virtualization host extensions are enabled (by setting the HCR_EL2.E2H bit to 1), then accesses to TTBR0/1_EL1 that are redirected to TTBR0/1_EL2, or accesses to TTBR0/1_EL12, are counted. TTBRn registers are typically updated when the kernel is swapping user-space threads or applications."
+    },
+    {
+        "ArchStdEvent": "BR_RETIRED",
+        "PublicDescription": "Counts architecturally executed branches, whether the branch is taken or not. Instructions that explicitly write to the PC are also counted. Note that exception generating instructions, exception return instructions and context synchronization instructions are not counted."
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts branches counted by BR_RETIRED which were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "OP_RETIRED",
+        "PublicDescription": "Counts micro-operations that are architecturally executed. This is a count of number of micro-operations retired from the commit queue in a single cycle."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_TAKEN_RETIRED",
+        "PublicDescription": "Counts architecturally executed immediate branches that were taken."
+    },
+    {
+        "ArchStdEvent": "BR_INDNR_TAKEN_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect branches excluding procedure returns that were taken."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed direct branches that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed direct branches that were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_IND_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect branches including procedure returns that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_IND_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect branches including procedure returns that were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed procedure returns that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed procedure returns that were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_INDNR_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect branches excluding procedure returns that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_INDNR_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect branches excluding procedure returns that were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_PRED_RETIRED",
+        "PublicDescription": "Counts branch instructions counted by BR_RETIRED which were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_IND_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect branches including procedure returns."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spe.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spe.json
new file mode 100644
index 000000000000..ca0217fa4681
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spe.json
@@ -0,0 +1,42 @@
+[
+    {
+        "ArchStdEvent": "SAMPLE_POP",
+        "PublicDescription": "Counts statistical profiling sample population, the count of all operations that could be sampled but may or may not be chosen for sampling."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED",
+        "PublicDescription": "Counts statistical profiling samples taken for sampling."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FILTRATE",
+        "PublicDescription": "Counts statistical profiling samples taken which are not removed by filtering."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_COLLISION",
+        "PublicDescription": "Counts statistical profiling samples that have collided with a previous sample and so therefore not taken."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_BR",
+        "PublicDescription": "Counts statistical profiling samples taken which are branches."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_LD",
+        "PublicDescription": "Counts statistical profiling samples taken which are loads or load atomic operations."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_ST",
+        "PublicDescription": "Counts statistical profiling samples taken which are stores or store atomic operations."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_OP",
+        "PublicDescription": "Counts statistical profiling samples taken which are matching any operation type filters supported."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_EVENT",
+        "PublicDescription": "Counts statistical profiling samples taken which are matching event packet filter constraints."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_LAT",
+        "PublicDescription": "Counts statistical profiling samples taken which are exceeding minimum latency set by operation latency filter constraints."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spec_operation.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spec_operation.json
new file mode 100644
index 000000000000..f91eb18d683c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spec_operation.json
@@ -0,0 +1,90 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED",
+        "PublicDescription": "Counts branches which are speculatively executed and mispredicted."
+    },
+    {
+        "ArchStdEvent": "BR_PRED",
+        "PublicDescription": "Counts all speculatively executed branches."
+    },
+    {
+        "ArchStdEvent": "INST_SPEC",
+        "PublicDescription": "Counts operations that have been speculatively executed."
+    },
+    {
+        "ArchStdEvent": "OP_SPEC",
+        "PublicDescription": "Counts micro-operations speculatively executed. This is the count of the number of micro-operations dispatched in a cycle."
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC",
+        "PublicDescription": "Counts store-exclusive operations that have been speculatively executed and have not successfully completed the store operation."
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC",
+        "PublicDescription": "Counts store-exclusive operations that have been speculatively executed."
+    },
+    {
+        "ArchStdEvent": "LD_SPEC",
+        "PublicDescription": "Counts speculatively executed load operations including Single Instruction Multiple Data (SIMD) load operations."
+    },
+    {
+        "ArchStdEvent": "ST_SPEC",
+        "PublicDescription": "Counts speculatively executed store operations including Single Instruction Multiple Data (SIMD) store operations."
+    },
+    {
+        "ArchStdEvent": "DP_SPEC",
+        "PublicDescription": "Counts speculatively executed logical or arithmetic instructions such as MOV/MVN operations."
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD operations excluding load, store and move micro-operations that move data to or from SIMD (vector) registers."
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC",
+        "PublicDescription": "Counts speculatively executed floating point operations. This event does not count operations that move data to or from floating point (vector) registers."
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC",
+        "PublicDescription": "Counts speculatively executed operations which cause software changes of the PC. Those operations include all taken branch operations."
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC",
+        "PublicDescription": "Counts speculatively executed cryptographic operations except for PMULL and VMULL operations."
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC",
+        "PublicDescription": "Counts ISB operations that are executed."
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC",
+        "PublicDescription": "Counts DSB operations that are speculatively issued to Load/Store unit in the CPU."
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC",
+        "PublicDescription": "Counts DMB operations that are speculatively issued to the Load/Store unit in the CPU. This event does not count implied barriers from load acquire/store release operations."
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC",
+        "PublicDescription": "Counts any load acquire operations that are speculatively executed. For example: LDAR, LDARH, LDARB"
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC",
+        "PublicDescription": "Counts any store release operations that are speculatively executed. For example: STLR, STLRH, STLRB"
+    },
+    {
+        "ArchStdEvent": "ASE_INST_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD operations."
+    },
+    {
+        "ArchStdEvent": "CAS_NEAR_PASS",
+        "PublicDescription": "Counts compare and swap instructions that executed locally to the PE and updated the location accessed."
+    },
+    {
+        "ArchStdEvent": "CAS_NEAR_SPEC",
+        "PublicDescription": "Counts compare and swap instructions that executed locally to the PE."
+    },
+    {
+        "ArchStdEvent": "CAS_FAR_SPEC",
+        "PublicDescription": "Counts compare and swap instructions that did not execute locally to the PE."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/stall.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/stall.json
new file mode 100644
index 000000000000..b1eae21bac07
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/stall.json
@@ -0,0 +1,82 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND",
+        "PublicDescription": "Counts cycles when frontend could not send any micro-operations to the rename stage because of frontend resource stalls caused by fetch memory latency or branch prediction flow stalls. STALL_FRONTEND_SLOTS counts SLOTS during the cycle when this event counts."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND",
+        "PublicDescription": "Counts cycles whenever the rename unit is unable to send any micro-operations to the backend of the pipeline because of backend resource constraints. Backend resource constraints can include issue stage fullness, execution stage fullness, or other internal pipeline resource fullness. All the backend slots were empty during the cycle when this event counts."
+    },
+    {
+        "ArchStdEvent": "STALL",
+        "PublicDescription": "Counts cycles when no operations are sent to the rename unit from the frontend or from the rename unit to the backend for any reason (either frontend or backend stall). This event is the sum of STALL_FRONTEND and STALL_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_BACKEND",
+        "PublicDescription": "Counts slots per cycle in which no operations are sent from the rename unit to the backend due to backend resource constraints. STALL_BACKEND counts during the cycle when STALL_SLOT_BACKEND counts at least 1."
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_FRONTEND",
+        "PublicDescription": "Counts slots per cycle in which no operations are sent to the rename unit from the frontend due to frontend resource constraints."
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT",
+        "PublicDescription": "Counts slots per cycle in which no operations are sent to the rename unit from the frontend or from the rename unit to the backend for any reason (either frontend or backend stall). STALL_SLOT is the sum of STALL_SLOT_FRONTEND and STALL_SLOT_BACKEND."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEM",
+        "PublicDescription": "Counts cycles when the backend is stalled because there is a pending demand load request in progress in the last level core cache."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_MEMBOUND",
+        "PublicDescription": "Counts cycles when the frontend could not send any micro-operations to the rename stage due to resource constraints in the memory resources."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_L1I",
+        "PublicDescription": "Counts cycles when the frontend is stalled because there is an instruction fetch request pending in the level 1 instruction cache."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_MEM",
+        "PublicDescription": "Counts cycles when the frontend is stalled because there is an instruction fetch request pending in the last level core cache."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_TLB",
+        "PublicDescription": "Counts when the frontend is stalled on any TLB misses being handled. This event also counts the TLB accesses made by hardware prefetches."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_CPUBOUND",
+        "PublicDescription": "Counts cycles when the frontend could not send any micro-operations to the rename stage due to resource constraints in the CPU resources excluding memory resources."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_FLUSH",
+        "PublicDescription": "Counts cycles when the frontend could not send any micro-operations to the rename stage as the frontend is recovering from a machine flush or resteer. Example scenarios that cause a flush include branch mispredictions, taken exceptions, micro-architectural flush etc."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEMBOUND",
+        "PublicDescription": "Counts cycles when the backend could not accept any micro-operations due to resource constraints in the memory resources."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_L1D",
+        "PublicDescription": "Counts cycles when the backend is stalled because there is a pending demand load request in progress in the level 1 data cache."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_TLB",
+        "PublicDescription": "Counts cycles when the backend is stalled on any demand TLB misses being handled."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_ST",
+        "PublicDescription": "Counts cycles when the backend is stalled and there is a store that has not reached the pre-commit stage."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_CPUBOUND",
+        "PublicDescription": "Counts cycles when the backend could not accept any micro-operations due to any resource constraints in the CPU excluding memory resources."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_BUSY",
+        "PublicDescription": "Counts cycles when the backend could not accept any micro-operations because the issue queues are full to take any operations for execution."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_RENAME",
+        "PublicDescription": "Counts cycles when backend is stalled even when operations are available from the frontend but at least one is not ready to be sent to the backend because no rename register is available."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/sve.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/sve.json
new file mode 100644
index 000000000000..51dab48cb2ba
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/sve.json
@@ -0,0 +1,50 @@
+[
+    {
+        "ArchStdEvent": "SVE_INST_SPEC",
+        "PublicDescription": "Counts speculatively executed operations that are SVE operations."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_SPEC",
+        "PublicDescription": "Counts speculatively executed predicated SVE operations."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_EMPTY_SPEC",
+        "PublicDescription": "Counts speculatively executed predicated SVE operations with no active predicate elements."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_FULL_SPEC",
+        "PublicDescription": "Counts speculatively executed predicated SVE operations with all predicate elements active."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_PARTIAL_SPEC",
+        "PublicDescription": "Counts speculatively executed predicated SVE operations with at least one but not all active predicate elements."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_NOT_FULL_SPEC",
+        "PublicDescription": "Counts speculatively executed predicated SVE operations with at least one non active predicate elements."
+    },
+    {
+        "ArchStdEvent": "SVE_LDFF_SPEC",
+        "PublicDescription": "Counts speculatively executed SVE first fault or non-fault load operations."
+    },
+    {
+        "ArchStdEvent": "SVE_LDFF_FAULT_SPEC",
+        "PublicDescription": "Counts speculatively executed SVE first fault or non-fault load operations that clear at least one bit in the FFR."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT8_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD or SVE integer operations with the largest data type an 8-bit integer."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT16_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD or SVE integer operations with the largest data type a 16-bit integer."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT32_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD or SVE integer operations with the largest data type a 32-bit integer."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT64_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD or SVE integer operations with the largest data type a 64-bit integer."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/tlb.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/tlb.json
new file mode 100644
index 000000000000..c7aa89c2f19f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/tlb.json
@@ -0,0 +1,74 @@
+[
+    {
+        "ArchStdEvent": "L1I_TLB_REFILL",
+        "PublicDescription": "Counts level 1 instruction TLB refills from any Instruction fetch. If there are multiple misses in the TLB that are resolved by the refill, then this event only counts once. This event will not count if the translation table walk results in a fault (such as a translation or access fault), since there is no new translation created for the TLB."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL",
+        "PublicDescription": "Counts level 1 data TLB accesses that resulted in TLB refills. If there are multiple misses in the TLB that are resolved by the refill, then this event only counts once. This event counts for refills caused by preload instructions or hardware prefetch accesses. This event counts regardless of whether the miss hits in L2 or results in a translation table walk. This event will not count if the translation table walk results in a fault (such as a translation or access fault), since there is no new translation created for the TLB. This event will not count on an access from an AT(address translation) instruction."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB",
+        "PublicDescription": "Counts level 1 data TLB accesses caused by any memory load or store operation. Note that load or store instructions can be broken up into multiple memory operations. This event does not count TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1I_TLB",
+        "PublicDescription": "Counts level 1 instruction TLB accesses, whether the access hits or misses in the TLB. This event counts both demand accesses and prefetch or preload generated accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL",
+        "PublicDescription": "Counts level 2 TLB refills caused by memory operations from both data and instruction fetch, except for those caused by TLB maintenance operations and hardware prefetches."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB",
+        "PublicDescription": "Counts level 2 TLB accesses except those caused by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK",
+        "PublicDescription": "Counts number of demand data translation table walks caused by a miss in the L2 TLB and performing at least one memory access. Translation table walks are counted even if the translation ended up taking a translation fault for reasons different than EPD, E0PD and NFD. Note that partial translations that cause a translation table walk are also counted. Also note that this event counts walks triggered by software preloads, but not walks triggered by hardware prefetchers, and that this event does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK",
+        "PublicDescription": "Counts number of instruction translation table walks caused by a miss in the L2 TLB and performing at least one memory access. Translation table walks are counted even if the translation ended up taking a translation fault for reasons different than EPD, E0PD and NFD. Note that partial translations that cause a translation table walk are also counted. Also note that this event does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_PERCYC",
+        "PublicDescription": "Counts the number of data translation table walks in progress per cycle."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_PERCYC",
+        "PublicDescription": "Counts the number of instruction translation table walks in progress per cycle."
+    },
+    {
+        "ArchStdEvent": "DTLB_HWUPD",
+        "PublicDescription": "Counts number of memory accesses triggered by a data translation table walk and performing an update of a translation table entry. Memory accesses are counted even if the translation ended up taking a translation fault for reasons different than EPD, E0PD and NFD. Note that this event counts accesses triggered by software preloads, but not accesses triggered by hardware prefetchers."
+    },
+    {
+        "ArchStdEvent": "ITLB_HWUPD",
+        "PublicDescription": "Counts number of memory accesses triggered by an instruction translation table walk and performing an update of a translation table entry. Memory accesses are counted even if the translation ended up taking a translation fault for reasons different than EPD, E0PD and NFD."
+    },
+    {
+        "ArchStdEvent": "DTLB_STEP",
+        "PublicDescription": "Counts number of memory accesses triggered by a demand data translation table walk and performing a read of a translation table entry. Memory accesses are counted even if the translation ended up taking a translation fault for reasons different than EPD, E0PD and NFD. Note that this event counts accesses triggered by software preloads, but not accesses triggered by hardware prefetchers."
+    },
+    {
+        "ArchStdEvent": "ITLB_STEP",
+        "PublicDescription": "Counts number of memory accesses triggered by an instruction translation table walk and performing a read of a translation table entry. Memory accesses are counted even if the translation ended up taking a translation fault for reasons different than EPD, E0PD and NFD."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_LARGE",
+        "PublicDescription": "Counts number of demand data translation table walks caused by a miss in the L2 TLB and yielding a large page. The set of large pages is defined as all pages with a final size higher than or equal to 2MB. Translation table walks that end up taking a translation fault are not counted, as the page size would be undefined in that case. If DTLB_WALK_BLOCK is implemented, then it is an alias for this event in this family. Note that partial translations that cause a translation table walk are also counted. Also note that this event counts walks triggered by software preloads, but not walks triggered by hardware prefetchers, and that this event does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_LARGE",
+        "PublicDescription": "Counts number of instruction translation table walks caused by a miss in the L2 TLB and yielding a large page. The set of large pages is defined as all pages with a final size higher than or equal to 2MB. Translation table walks that end up taking a translation fault are not counted, as the page size would be undefined in that case. In this family, this is equal to ITLB_WALK_BLOCK event. Note that partial translations that cause a translation table walk are also counted. Also note that this event does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_SMALL",
+        "PublicDescription": "Counts number of data translation table walks caused by a miss in the L2 TLB and yielding a small page. The set of small pages is defined as all pages with a final size lower than 2MB. Translation table walks that end up taking a translation fault are not counted, as the page size would be undefined in that case. If DTLB_WALK_PAGE event is implemented, then it is an alias for this event in this family. Note that partial translations that cause a translation table walk are also counted. Also note that this event counts walks triggered by software preloads, but not walks triggered by hardware prefetchers, and that this event does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_SMALL",
+        "PublicDescription": "Counts number of instruction translation table walks caused by a miss in the L2 TLB and yielding a small page. The set of small pages is defined as all pages with a final size lower than 2MB. Translation table walks that end up taking a translation fault are not counted, as the page size would be undefined in that case. In this family, this is equal to ITLB_WALK_PAGE event. Note that partial translations that cause a translation table walk are also counted. Also note that this event does not count walks triggered by TLB maintenance operations."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/trace.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/trace.json
new file mode 100644
index 000000000000..33672a8711d4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a720/trace.json
@@ -0,0 +1,32 @@
+[
+    {
+        "ArchStdEvent": "TRB_WRAP"
+    },
+    {
+        "ArchStdEvent": "TRB_TRIG"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT0"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT1"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT2"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT3"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT4"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT5"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT6"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT7"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index bb3fa8a33496..ccfcae375750 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -33,6 +33,7 @@
 0x00000000410fd4c0,v1,arm/cortex-x1,core
 0x00000000410fd460,v1,arm/cortex-a510,core
 0x00000000410fd470,v1,arm/cortex-a710,core
+0x00000000410fd810,v1,arm/cortex-a720,core
 0x00000000410fd480,v1,arm/cortex-x2,core
 0x00000000410fd490,v1,arm/neoverse-n2-v2,core
 0x00000000410fd4f0,v1,arm/neoverse-n2-v2,core
-- 
2.47.2

