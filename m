Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6BA26B0B5
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459601; cv=none; b=kOfgA1B9UVBjsszKGKoamFn+iqr0UcsXSz6k3AhDlETlcfa1qfBZiiPfGxZjW8Fi9zDD8z/4R2G1Zq8zmQD1ciDg7hXHPszDNk/7117k89qv2yFUZgKnKi5Ls9lF5vGHCvGdRBei54KFdj7oCGSWg3M00kriJXvVy0+Oj9C9dio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459601; c=relaxed/simple;
	bh=75WtKV97demkDyvVvsBSVI/sHIJRofn2uIxOHJA6Cfk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=u4cdQam14Pt66WyOdDNYGVBnAyU1Q/ETQVdnnLYPcPyOg8bzy5m1KbhrMCuG+VSfm2uZQ5kNlWsXOH8SlEkFKjIMmiD0gXfbNx0+XnfXxe5oz6AllmfVuWgkeS0Ae156oEPLkKLgA4L/joN/olJYasRtGmmiecO7yh3ykryRnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=I3u6SAEi; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="I3u6SAEi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739459582; bh=Nzt2vQH7DSa3tUtAyFdTa0J3/Ncy+l1J5I0wQF068Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I3u6SAEitu8khPZyov+B8skt7/J2vohZ1W50RWKfNoqlAZXPToST5ftKny/AyhZWN
	 +QiY7z4Qe0JLi6DFPFxAX9IovKqAD8Sm4XOCrVoCn8I+idViAZPEP4U3W46Gu1EOtJ
	 t8atP3YHrE8eexCrcUBax9Babi/aUwCEqKOKEa8Y=
Received: from cyy-pc.lan ([240e:379:2251:3600:f57b:26f9:9718:486c])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 338A58E8; Thu, 13 Feb 2025 23:12:56 +0800
X-QQ-mid: xmsmtpt1739459576tgw6byg21
Message-ID: <tencent_E5686B3956E04AC548862C35FAF03909E20A@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAhsKvSrCboBKxoZ5TS2wuovy/4FSdvWKxhHFyehT7Mwr6nb1BVM
	 UGsdKQjSd1PANX6UJ+LvUiaI5Ve38sAMRV1nELAOdZKCXB6HAc2aJLpa3qdYAUZ+3/huaJiMNQY8
	 CIFAF/EDJGU+39weutf9O5zhpL9MGQPCzhDuPlBc9OSSicHrtM+0A67bIzNIHgCnJmYQM5Xu6h3O
	 c4lv7B5uUt5uoeT6EWnncKgZt8gSyh5W2Vqqw36qFp3hfGwNKn9PgsptjFsYkzUD7d3ffqwC5bu/
	 YKsYanM1qbZSVtfFgfCSGaSgDqpm5/jImpQk0IWI+ekCSpqyrTUJ+jEF38KzpFsUjwvYlVk5Xih4
	 VQ276N6xp80lUbBuEorLanWDG3nPmtlHPWBimaoUe/x5p5TGPKIVzgwaZQ2MHWXrCu75B7tJmGb3
	 uOJGJaHtgkRSnVcNWIKo/+bbLP2/0B2CrtcbMcWmRc3UfzNo4UXwJ6+FQ/RzwJ9pzrwdc00+G+eZ
	 3UBg/ONATwEN0AHv92nZPp54K0N7bHljJOVVEy3cRng5lUbkSn4VYnncL/OugO72pd7Ki1zUSBOI
	 sU0+4+Y0b7sWTnNScFfBt/iaNXuRJiY52Hw5HY7SzSixEppM2gTsKfbBTDkVzHoTcAmInwxu2bdJ
	 R1EnHIKts4WWRvngj1ljy+YRkL+7bN5mLZSkDvsMRvM+yipn0RTQQvlIYlOJfChPMK83AiksDLXo
	 cwKdPqct8AA6B8iWtmBUBO+s/YukeH8e+3Pu9qvkkJwHj6wCFoYTqql7WdqXZrcimzlc+92aIoEa
	 3QqVBkMQHANBhzN1STF4uSzOslw8eVfnKnhUoq/lMRx9nP1JGm0q5UBfq5OQACzrDprS1lmDkVYv
	 bQMLfTjgdvjoXOMJphY6fhE4fOWRYAYZvIHoe86+niC1JQkE2Odp4mCzftSFwKYotQR7GLp2brry
	 tNr8QZtLugy3M1MoACDtsNOeweUhRzdHQrT5n6nLf4VBJOk8aR9yGjB6II1U/gv09rqjOXlXF2b2
	 1XAwWUFg/TcwzR/mrNJjU6dtlPrzNvjPlkKqhMS8yEjF3sSVWQ
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Subject: [PATCH 2/2] perf vendor events arm64: Add Cortex-A520 events/metrics
Date: Thu, 13 Feb 2025 23:12:52 +0800
X-OQ-MSGID: <20250213151252.187475-1-cyy@cyyself.name>
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

Add JSON files for Cortex-A520 events and metrics. Using the existing
Neoverse N3 JSON files as a template, I manually checked the missing and
extra events/metrics using my script [1] and modified them according to
the Arm Cortex-A520 Core Technical Reference Manual [2].

[1] https://github.com/cyyself/arm-pmu-check/tree/1075bebeb3f1441067448251a387df35af15bf16
[2] https://developer.arm.com/documentation/102517/0004/Performance-Monitors-Extension-support-/Performance-monitors-events/Common-event-PMU-events

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 .../arch/arm64/arm/cortex-a520/bus.json       |  26 ++
 .../arch/arm64/arm/cortex-a520/exception.json |  18 +
 .../arm64/arm/cortex-a520/fp_operation.json   |  14 +
 .../arch/arm64/arm/cortex-a520/general.json   |   6 +
 .../arch/arm64/arm/cortex-a520/l1d_cache.json |  50 +++
 .../arch/arm64/arm/cortex-a520/l1i_cache.json |  14 +
 .../arch/arm64/arm/cortex-a520/l2_cache.json  |  46 +++
 .../arch/arm64/arm/cortex-a520/l3_cache.json  |  21 +
 .../arch/arm64/arm/cortex-a520/ll_cache.json  |  10 +
 .../arch/arm64/arm/cortex-a520/memory.json    |  58 +++
 .../arch/arm64/arm/cortex-a520/metrics.json   | 373 ++++++++++++++++++
 .../arch/arm64/arm/cortex-a520/pmu.json       |   8 +
 .../arch/arm64/arm/cortex-a520/retired.json   |  90 +++++
 .../arm64/arm/cortex-a520/spec_operation.json |  70 ++++
 .../arch/arm64/arm/cortex-a520/stall.json     |  82 ++++
 .../arch/arm64/arm/cortex-a520/sve.json       |  22 ++
 .../arch/arm64/arm/cortex-a520/tlb.json       |  78 ++++
 .../arch/arm64/arm/cortex-a520/trace.json     |  32 ++
 .../arch/arm64/common-and-microarch.json      |  15 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 20 files changed, 1034 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
new file mode 100644
index 000000000000..884e42ab6a49
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
@@ -0,0 +1,26 @@
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
+    },
+    {
+        "ArchStdEvent": "BUS_REQ_RD_PERCYC",
+        "PublicDescription": "Bus read transactions in progress."
+    },
+    {
+        "ArchStdEvent": "BUS_REQ_RD",
+        "BriefDescription": "Bus request, read"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
new file mode 100644
index 000000000000..fbe580e15c2e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
@@ -0,0 +1,18 @@
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
+        "ArchStdEvent": "EXC_IRQ",
+        "PublicDescription": "Counts IRQ exceptions including the virtual IRQs that are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+        "PublicDescription": "Counts FIQ exceptions including the virtual FIQs that are taken locally."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
new file mode 100644
index 000000000000..da0c4b05ad5b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
@@ -0,0 +1,14 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
new file mode 100644
index 000000000000..20fada95ef97
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
@@ -0,0 +1,6 @@
+[
+    {
+        "ArchStdEvent": "CPU_CYCLES",
+        "PublicDescription": "Counts CPU clock cycles (not timer cycles). The clock measured by this event is defined as the physical clock driving the CPU logic."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
new file mode 100644
index 000000000000..90e871c8986a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
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
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed load instructions where the memory read operation misses in the level 1 data cache. This event only counts one event per cache line."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
+        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed store instructions where the memory write operation misses in the level 1 data cache. This event only counts one event per cache line."
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
+        "ArchStdEvent": "L1D_CACHE_HWPRF",
+        "PublicDescription": "Counts level 1 data cache accesses from any load/store operations generated by the hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_HWPRF",
+        "PublicDescription": "Counts level 1 data cache refills where the cache line is requested by a hardware prefetcher."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
new file mode 100644
index 000000000000..633f1030359d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
new file mode 100644
index 000000000000..9874b1a7c94b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
@@ -0,0 +1,46 @@
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
+        "ArchStdEvent": "L2D_CACHE_LMISS_RD",
+        "PublicDescription": "Counts cache line refills into the level 2 unified cache from any memory read operations that incurred additional latency."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_HWPRF",
+        "PublicDescription": "Counts level 2 data cache accesses generated by L2D hardware prefetchers."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_HWPRF",
+        "BriefDescription": "This event counts hardware prefetch counted by L2D_CACHE_HWPRF that causes a refill of the Level 2 cache, or any Level 1 data and instruction cache of this PE, from outside of those caches."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
new file mode 100644
index 000000000000..d5485d71babb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
@@ -0,0 +1,21 @@
+[
+    {
+        "ArchStdEvent": "L3D_CACHE",
+        "PublicDescription": "Counts level 3 cache accesses. Level 3 cache is a unified cache for data and instruction accesses. Accesses are for misses in the lower level caches or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD",
+        "PublicDescription": "Counts level 3 cache accesses caused by any memory read operation. Level 3 cache is a unified cache for data and instruction accesses. Accesses are for misses in the lower level caches or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_LMISS_RD",
+        "PublicDescription": "Counts any cache line refill into the level 3 cache from memory read operations that incurred additional latency."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_HWPRF",
+        "PublicDescription": "Level 3 data cache hardware prefetch."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
new file mode 100644
index 000000000000..fd5a2e0099b8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
new file mode 100644
index 000000000000..e7f7914ecd2b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
@@ -0,0 +1,58 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS",
+        "PublicDescription": "Counts memory accesses issued by the CPU load store unit, where those accesses are issued due to load or store operations. This event counts memory accesses no matter whether the data is received from any level of cache hierarchy or external memory. If memory accesses are broken up into smaller transactions than what were specified in the load or store instructions, then the event counts those smaller memory transactions."
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR",
+        "PublicDescription": "Counts any detected correctable or uncorrectable physical memory errors (ECC or parity) in protected CPUs RAMs. On the core, this event counts errors in the caches (including data and tag rams). Any detected memory error (from either a speculative and abandoned access, or an architecturally executed access) is counted. Note that errors are only detected when the actual protected memory is accessed by an operation."
+    },
+    {
+        "ArchStdEvent": "REMOTE_ACCESS_RD",
+        "PublicDescription": "Counts memory access to another socket in a multi-socket system, read."
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
new file mode 100644
index 000000000000..62cb910c8945
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
@@ -0,0 +1,373 @@
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
+        "MetricName": "branch_percentage",
+        "MetricExpr": "PC_WRITE_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures branch operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
new file mode 100644
index 000000000000..d8b7b9f9e5fa
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "PMU_OVFS"
+    },
+    {
+        "ArchStdEvent": "PMU_HOVFS"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
new file mode 100644
index 000000000000..152f15c1253c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
@@ -0,0 +1,90 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR",
+        "PublicDescription": "Counts software writes to the PMSWINC_EL0 (software PMU increment) register. The PMSWINC_EL0 register is a manually updated counter for use by application software.\n\nThis event could be used to measure any user program event, such as accesses to a particular data structure (by writing to the PMSWINC_EL0 register each time the data structure is accessed).\n\nTo use the PMSWINC_EL0 register and event, developers must insert instructions that write to the PMSWINC_EL0 register into the source code.\n\nSince the SW_INCR event records writes to the PMSWINC_EL0 register, there is no need to do a read/increment/write sequence to the PMSWINC_EL0 register."
+    },
+    {
+        "ArchStdEvent": "LD_RETIRED",
+        "PublicDescription": "Counts instruction architecturally executed, Condition code check pass, load."
+    },
+    {
+        "ArchStdEvent": "ST_RETIRED",
+        "PublicDescription": "Counts instruction architecturally executed, Condition code check pass, store."
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
+        "ArchStdEvent": "SVE_INST_RETIRED",
+        "PublicDescription": "Counts architecturally executed SVE instructions."
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.json
new file mode 100644
index 000000000000..40c29be53cc0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.json
@@ -0,0 +1,70 @@
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
+        "ArchStdEvent": "LDST_SPEC",
+        "PublicDescription": "Counts speculatively executed load and store operations."
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
+        "ArchStdEvent": "BR_IMMED_SPEC",
+        "PublicDescription": "Counts direct branch operations which are speculatively executed."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC",
+        "PublicDescription": "Counts procedure return operations (RET, RETAA and RETAB) which are speculatively executed."
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC",
+        "PublicDescription": "Counts indirect branch operations including procedure returns, which are speculatively executed. This includes operations that force a software change of the PC, other than exception-generating operations and direct branch instructions. Some examples of the instructions counted by this event include BR Xn, RET, etc..."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
new file mode 100644
index 000000000000..d65aeb4b8808
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
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
+        "ArchStdEvent": "STALL_FRONTEND_FLOW",
+        "PublicDescription": "Counts cycles when the frontend could not send any micro-operations to the rename stage due to resource constraints in the branch prediction unit."
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
+        "ArchStdEvent": "STALL_BACKEND_BUSY",
+        "PublicDescription": "Counts cycles when the backend could not accept any micro-operations because the issue queues are full to take any operations for execution."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_ILOCK",
+        "PublicDescription": "Counts cycles when the backend could not accept any micro-operations due to resource constraints imposed by input dependency."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
new file mode 100644
index 000000000000..21810ce5de8d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
@@ -0,0 +1,22 @@
+[
+    {
+        "ArchStdEvent": "SVE_INST_SPEC",
+        "PublicDescription": "Counts speculatively executed operations that are SVE operations."
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
new file mode 100644
index 000000000000..1de56300e581
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
@@ -0,0 +1,78 @@
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
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_RW",
+        "PublicDescription": "Counts number of demand data translation table walks caused by a miss in the L2 TLB and performing at least one memory access. Translation table walks are counted even if the translation ended up taking a translation fault for reasons different than EPD, E0PD and NFD. Note that partial translations that cause a translation table walk are also counted. Also note that this event does not count walks triggered by TLB maintenance operations."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json
new file mode 100644
index 000000000000..33672a8711d4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
index e40be37addf8..3e774c1e1413 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -1339,6 +1339,11 @@
         "EventName": "INST_FETCH",
         "BriefDescription": "Instruction memory access"
     },
+    {
+        "EventCode": "0x8125",
+        "EventName": "BUS_REQ_RD_PERCYC",
+        "BriefDescription": "Bus read transactions in progress"
+    },
     {
         "EventCode": "0x8128",
         "EventName": "DTLB_WALK_PERCYC",
@@ -1539,6 +1544,11 @@
         "EventName": "L2D_CACHE_HWPRF",
         "BriefDescription": "Level 2 data cache hardware prefetch."
     },
+    {
+        "EventCode": "0x8156",
+        "EventName": "L3D_CACHE_HWPRF",
+        "BriefDescription": "Level 3 data cache hardware prefetch."
+    },
     {
         "EventCode": "0x8158",
         "EventName": "STALL_FRONTEND_MEMBOUND",
@@ -1674,6 +1684,11 @@
         "EventName": "DTLB_WALK_PAGE",
         "BriefDescription": "Data TLB page translation table walk."
     },
+    {
+        "EventCode": "0x818D",
+        "EventName": "BUS_REQ_RD",
+        "BriefDescription": "Bus request, read"
+    },
     {
         "EventCode": "0x818B",
         "EventName": "ITLB_WALK_PAGE",
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index ccfcae375750..6b98632636e1 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -32,6 +32,7 @@
 0x00000000410fd440,v1,arm/cortex-x1,core
 0x00000000410fd4c0,v1,arm/cortex-x1,core
 0x00000000410fd460,v1,arm/cortex-a510,core
+0x00000000410fd800,v1,arm/cortex-a520,core
 0x00000000410fd470,v1,arm/cortex-a710,core
 0x00000000410fd810,v1,arm/cortex-a720,core
 0x00000000410fd480,v1,arm/cortex-x2,core
-- 
2.47.2

