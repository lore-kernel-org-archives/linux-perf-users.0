Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297031AA7A6
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113491; cv=none; b=tYsKz0o+6/SwDTxia7+Nwr/5s2t+k58iduQxKv2FUg2wESju+tM0TZ45YLURxQMlP6QeOn5wuc7gweXFN+ZPXnYAyomQlcUE5sJyX/zltXGuBziikmK+FmudLUwma6XI/fjCKlOGYyMsWBWQLBz7QPLttLtFVfjbQddofJJLkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113491; c=relaxed/simple;
	bh=8csFrdzTbgJcT+CbqS6ziq0vLxc1fMBRJL0ob444AHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T9vrcKrRolO0kswXSbFSFI9J+cMy+svnR8os9q13NGCg4lAR6Ea6v4foKlktVXbzVyaATwvUoz2tQd0mNR4p3oky/QWywRUV79YFLJbVovtS6bosq+lPBrj28q76/K6vuoLPjoA9j7Gr0hUOfWP9jRoi8lCcyMihFyes9ekCWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCoE+oB6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCoE+oB6"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso327225666b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 06:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732113485; x=1732718285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/9I6LytuQvos/2gUPtBiMN2ZnHV3kE0jcN0O5sMu3o=;
        b=sCoE+oB6qPJh0IKD1iTrzq13uqJ4c4e95PWPza/BfuG3JxCQjdDDrzaDoiEWs04Uzi
         BBa1jy/fPENmqXB85PT1zrwv0WkrNNsaJwj+eHmgD1CNSfE/GNf/n3JP40cjqbd5IpuU
         2SYaC4pLUgheF0bBSVfxQ5f2vOfgsrH9HnOW7MuON8ktdFCuATTiDK0j8wp79CzSzPp7
         8XhqcgIpmbSlZhAyqb0VCKOBrKfeB6CC3HINmXIauSVH6W0nCvnXLxYChWPg9jJ4kkto
         5uIDDOUI3SKfy13Metv88fRiACaa0QqWo5+onAQuUnC5dhVbEgapIUkYzMZeEdogLsDs
         X1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732113485; x=1732718285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/9I6LytuQvos/2gUPtBiMN2ZnHV3kE0jcN0O5sMu3o=;
        b=KwY8hMbDLZgBTHTV20n8H1XfEVrOkaK3mQgY+yW0MDD0vPTrxYLO50lfHC7nGW9cMv
         1n1g2fX8qyDDYr3XcRPEvLauqJVbig4W+YC5mkagYBj1TH14BUTHTjk43pNQ9huJWUrw
         vCiF/dL4kRQktFAx7Wd8DNpq+cs3muyJ0CNEsmHmtXa6mSVQpgkN+/ecHGDrRFn5xW1v
         ArHmzJqFQytn8QmqFuHMBjIQ16vrwFzY1hX0rqab5ukibObdRZzKfRGTddLA67Eby6it
         FjOIAbfVVqvVmsYnMXJw71zlcosx9Mqu8dBYRDnswn3KX6ofyNy49W9JQWPC5+mVyypa
         PG3w==
X-Gm-Message-State: AOJu0YwnASzC56tBZEYTRWaN30ricuwtFsCQwI7TVoFbQNcExqsK14NC
	wU8y7GJ0wg76oRdiD+kjHAmg42EssjjH1v5uhC2FA6ymMpO+kM+MRWVNQvS2+47TGzVQgv5YmSu
	zGF8=
X-Google-Smtp-Source: AGHT+IFfv9s/veaFQrvZRRK46krHztOXirjYj8BZ1eCCy1BgGIEaqbfN6oy4rfiL1D3DlOhQeSoIhw==
X-Received: by 2002:a17:907:3687:b0:a99:f4be:7a6a with SMTP id a640c23a62f3a-aa4dd71a2a0mr271970266b.47.1732113483748;
        Wed, 20 Nov 2024 06:38:03 -0800 (PST)
Received: from pop-os.. ([145.224.90.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046932sm774520766b.170.2024.11.20.06.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:38:03 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
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
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf vendor events arm64: Update N2/V2 events from source
Date: Wed, 20 Nov 2024 14:37:31 +0000
Message-Id: <20241120143739.243728-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update using the new data [1] for these changes:

  * Scale some metrics like dtlb_walk_ratio to percent so they display
    better with Perf's 2 dp precision
  * Description typos, grammar and clarifications
  * Unnecessary metric formula brackets seem to have been removed in the
    source but this is not a functional change
  * New sve_all_percentage metric

The following command was used to generate this commit:

$ telemetry-solution/tools/perf_json_generator/generate.py \
  tools/perf/ --telemetry-files \
  telemetry-solution/data/pmu/cpu/neoverse/neoverse-v2.json:neoverse-n2-v2

[1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-v2.json

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../arm64/arm/neoverse-n2-v2/exception.json   |  2 +-
 .../arm64/arm/neoverse-n2-v2/general.json     |  2 +-
 .../arm64/arm/neoverse-n2-v2/l1d_cache.json   |  6 +-
 .../arm64/arm/neoverse-n2-v2/l2_cache.json    | 14 +--
 .../arm64/arm/neoverse-n2-v2/l3_cache.json    |  4 +-
 .../arm64/arm/neoverse-n2-v2/ll_cache.json    |  4 +-
 .../arch/arm64/arm/neoverse-n2-v2/memory.json |  2 +-
 .../arm64/arm/neoverse-n2-v2/metrics.json     | 93 ++++++++++---------
 .../arm64/arm/neoverse-n2-v2/retired.json     |  4 +-
 .../arm/neoverse-n2-v2/spec_operation.json    | 14 +--
 .../arch/arm64/arm/neoverse-n2-v2/stall.json  |  8 +-
 .../arch/arm64/arm/neoverse-n2-v2/tlb.json    |  4 +-
 12 files changed, 82 insertions(+), 75 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
index 4404b8e91690..7126fbf292e0 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
@@ -5,7 +5,7 @@
     },
     {
         "ArchStdEvent": "EXC_RETURN",
-        "PublicDescription": "Counts any architecturally executed exception return instructions. Eg: AArch64: ERET"
+        "PublicDescription": "Counts any architecturally executed exception return instructions. For example: AArch64: ERET"
     },
     {
         "ArchStdEvent": "EXC_UNDEF",
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json
index 428810f855b8..c5dcdcf43c58 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json
@@ -5,6 +5,6 @@
     },
     {
         "ArchStdEvent": "CNT_CYCLES",
-        "PublicDescription": "Counts constant frequency cycles"
+        "PublicDescription": "Increments at a constant frequency equal to the rate of increment of the System Counter, CNTPCT_EL0."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json
index da7c129f2569..799d106d5173 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json
@@ -1,11 +1,11 @@
 [
     {
         "ArchStdEvent": "L1D_CACHE_REFILL",
-        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed load or store operations that missed in the level 1 data cache. This event only counts one event per cache line. This event does not count cache line allocations from preload instructions or from hardware cache prefetching."
+        "PublicDescription": "Counts level 1 data cache refills caused by speculatively executed load or store operations that missed in the level 1 data cache. This event only counts one event per cache line."
     },
     {
         "ArchStdEvent": "L1D_CACHE",
-        "PublicDescription": "Counts level 1 data cache accesses from any load/store operations. Atomic operations that resolve in the CPUs caches (near atomic operations) count as both a write access and read access. Each access to a cache line is counted including the multiple accesses caused by single instructions such as LDM or STM. Each access to other level 1 data or unified memory structures, for example refill buffers, write buffers, and write-back buffers, are also counted."
+        "PublicDescription": "Counts level 1 data cache accesses from any load/store operations. Atomic operations that resolve in the CPUs caches (near atomic operations) counts as both a write access and read access. Each access to a cache line is counted including the multiple accesses caused by single instructions such as LDM or STM. Each access to other level 1 data or unified memory structures, for example refill buffers, write buffers, and write-back buffers, are also counted."
     },
     {
         "ArchStdEvent": "L1D_CACHE_WB",
@@ -17,7 +17,7 @@
     },
     {
         "ArchStdEvent": "L1D_CACHE_RD",
-        "PublicDescription": "Counts level 1 data cache accesses from any load operation. Atomic load operations that resolve in the CPUs caches count as both a write access and read access."
+        "PublicDescription": "Counts level 1 data cache accesses from any load operation. Atomic load operations that resolve in the CPUs caches counts as both a write access and read access."
     },
     {
         "ArchStdEvent": "L1D_CACHE_WR",
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json
index 0e31d0daf88b..ed8291ab9737 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json
@@ -1,11 +1,11 @@
 [
     {
         "ArchStdEvent": "L2D_CACHE",
-        "PublicDescription": "Counts level 2 cache accesses. level 2 cache is a unified cache for data and instruction accesses. Accesses are for misses in the first level caches or translation resolutions due to accesses. This event also counts write back of dirty data from level 1 data cache to the L2 cache."
+        "PublicDescription": "Counts accesses to the level 2 cache due to data accesses. Level 2 cache is a unified cache for data and instruction accesses. Accesses are for misses in the first level data cache or translation resolutions due to accesses. This event also counts write back of dirty data from level 1 data cache to the L2 cache."
     },
     {
         "ArchStdEvent": "L2D_CACHE_REFILL",
-        "PublicDescription": "Counts cache line refills into the level 2 cache. level 2 cache is a unified cache for data and instruction accesses. Accesses are for misses in the level 1 caches or translation resolutions due to accesses."
+        "PublicDescription": "Counts cache line refills into the level 2 cache. Level 2 cache is a unified cache for data and instruction accesses. Accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
     },
     {
         "ArchStdEvent": "L2D_CACHE_WB",
@@ -13,23 +13,23 @@
     },
     {
         "ArchStdEvent": "L2D_CACHE_ALLOCATE",
-        "PublicDescription": "TBD"
+        "PublicDescription": "Counts level 2 cache line allocates that do not fetch data from outside the level 2 data or unified cache."
     },
     {
         "ArchStdEvent": "L2D_CACHE_RD",
-        "PublicDescription": "Counts level 2 cache accesses due to memory read operations. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
+        "PublicDescription": "Counts level 2 data cache accesses due to memory read operations. Level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
     },
     {
         "ArchStdEvent": "L2D_CACHE_WR",
-        "PublicDescription": "Counts level 2 cache accesses due to memory write operations. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
+        "PublicDescription": "Counts level 2 cache accesses due to memory write operations. Level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
     },
     {
         "ArchStdEvent": "L2D_CACHE_REFILL_RD",
-        "PublicDescription": "Counts refills for memory accesses due to memory read operation counted by L2D_CACHE_RD. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
+        "PublicDescription": "Counts refills for memory accesses due to memory read operation counted by L2D_CACHE_RD. Level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
     },
     {
         "ArchStdEvent": "L2D_CACHE_REFILL_WR",
-        "PublicDescription": "Counts refills for memory accesses due to memory write operation counted by L2D_CACHE_WR. level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 caches or translation resolutions due to accesses."
+        "PublicDescription": "Counts refills for memory accesses due to memory write operation counted by L2D_CACHE_WR. Level 2 cache is a unified cache for data and instruction accesses, accesses are for misses in the level 1 data cache or translation resolutions due to accesses."
     },
     {
         "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json
index 45bfba532df7..4a2e72fc5ada 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json
@@ -9,11 +9,11 @@
     },
     {
         "ArchStdEvent": "L3D_CACHE",
-        "PublicDescription": "Counts level 3 cache accesses. level 3 cache is a unified cache for data and instruction accesses. Accesses are for misses in the lower level caches or translation resolutions due to accesses."
+        "PublicDescription": "Counts level 3 cache accesses. Level 3 cache is a unified cache for data and instruction accesses. Accesses are for misses in the lower level caches or translation resolutions due to accesses."
     },
     {
         "ArchStdEvent": "L3D_CACHE_RD",
-        "PublicDescription": "TBD"
+        "PublicDescription": "Counts level 3 cache accesses caused by any memory read operation. Level 3 cache is a unified cache for data and instruction accesses. Accesses are for misses in the lower level caches or translation resolutions due to accesses."
     },
     {
         "ArchStdEvent": "L3D_CACHE_LMISS_RD",
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json
index bb712d57d58a..fd5a2e0099b8 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json
@@ -1,10 +1,10 @@
 [
     {
         "ArchStdEvent": "LL_CACHE_RD",
-        "PublicDescription": "Counts read transactions that were returned from outside the core cluster. This event counts when the system register CPUECTLR.EXTLLC bit is set. This event counts read transactions returned from outside the core if those transactions are either hit in the system level cache or missed in the SLC and are returned from any other external sources."
+        "PublicDescription": "Counts read transactions that were returned from outside the core cluster. This event counts for external last level cache  when the system register CPUECTLR.EXTLLC bit is set, otherwise it counts for the L3 cache. This event counts read transactions returned from outside the core if those transactions are either hit in the system level cache or missed in the SLC and are returned from any other external sources."
     },
     {
         "ArchStdEvent": "LL_CACHE_MISS_RD",
-        "PublicDescription": "Counts read transactions that were returned from outside the core cluster but missed in the system level cache. This event counts when the system register CPUECTLR.EXTLLC bit is set. This event counts read transactions returned from outside the core if those transactions are missed in the System level Cache. The data source of the transaction is indicated by a field in the CHI transaction returning to the CPU. This event does not count reads caused by cache maintenance operations."
+        "PublicDescription": "Counts read transactions that were returned from outside the core cluster but missed in the system level cache. This event counts for external last level cache when the system register CPUECTLR.EXTLLC bit is set, otherwise it counts for L3 cache. This event counts read transactions returned from outside the core if those transactions are missed in the System level Cache. The data source of the transaction is indicated by a field in the CHI transaction returning to the CPU. This event does not count reads caused by cache maintenance operations."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json
index 106a97f8b2e7..bb3491012a8f 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json
@@ -33,7 +33,7 @@
     },
     {
         "ArchStdEvent": "MEM_ACCESS_CHECKED",
-        "PublicDescription": "Counts the number of memory read and write accesses in a cycle that are tag checked by the Memory Tagging Extension (MTE)."
+        "PublicDescription": "Counts the number of memory read and write accesses counted by MEM_ACCESS that are tag checked by the Memory Tagging Extension (MTE). This event is implemented as the sum of MEM_ACCESS_CHECKED_RD and MEM_ACCESS_CHECKED_WR"
     },
     {
         "ArchStdEvent": "MEM_ACCESS_CHECKED_RD",
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
index 5f449270b448..97d352f94323 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
@@ -5,7 +5,7 @@
     },
     {
         "MetricName": "backend_stalled_cycles",
-        "MetricExpr": "((STALL_BACKEND / CPU_CYCLES) * 100)",
+        "MetricExpr": "STALL_BACKEND / CPU_CYCLES * 100",
         "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the backend unit of the processor.",
         "MetricGroup": "Cycle_Accounting",
         "ScaleUnit": "1percent of cycles"
@@ -16,45 +16,45 @@
     },
     {
         "MetricName": "branch_misprediction_ratio",
-        "MetricExpr": "(BR_MIS_PRED_RETIRED / BR_RETIRED)",
+        "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
         "BriefDescription": "This metric measures the ratio of branches mispredicted to the total number of branches architecturally executed. This gives an indication of the effectiveness of the branch prediction unit.",
         "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
-        "ScaleUnit": "1per branch"
+        "ScaleUnit": "100percent of branches"
     },
     {
         "MetricName": "branch_mpki",
-        "MetricExpr": "((BR_MIS_PRED_RETIRED / INST_RETIRED) * 1000)",
+        "MetricExpr": "BR_MIS_PRED_RETIRED / INST_RETIRED * 1000",
         "BriefDescription": "This metric measures the number of branch mispredictions per thousand instructions executed.",
         "MetricGroup": "MPKI;Branch_Effectiveness",
         "ScaleUnit": "1MPKI"
     },
     {
         "MetricName": "branch_percentage",
-        "MetricExpr": "(((BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SPEC) * 100)",
+        "MetricExpr": "(BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SPEC * 100",
         "BriefDescription": "This metric measures branch operations as a percentage of operations speculatively executed.",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "1percent of operations"
     },
     {
         "MetricName": "crypto_percentage",
-        "MetricExpr": "((CRYPTO_SPEC / INST_SPEC) * 100)",
+        "MetricExpr": "CRYPTO_SPEC / INST_SPEC * 100",
         "BriefDescription": "This metric measures crypto operations as a percentage of operations speculatively executed.",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "1percent of operations"
     },
     {
         "MetricName": "dtlb_mpki",
-        "MetricExpr": "((DTLB_WALK / INST_RETIRED) * 1000)",
+        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
         "BriefDescription": "This metric measures the number of data TLB Walks per thousand instructions executed.",
         "MetricGroup": "MPKI;DTLB_Effectiveness",
         "ScaleUnit": "1MPKI"
     },
     {
         "MetricName": "dtlb_walk_ratio",
-        "MetricExpr": "(DTLB_WALK / L1D_TLB)",
+        "MetricExpr": "DTLB_WALK / L1D_TLB",
         "BriefDescription": "This metric measures the ratio of data TLB Walks to the total number of data TLB accesses. This gives an indication of the effectiveness of the data TLB accesses.",
         "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
-        "ScaleUnit": "1per TLB access"
+        "ScaleUnit": "100percent of TLB accesses"
     },
     {
         "ArchStdEvent": "frontend_bound",
@@ -62,147 +62,147 @@
     },
     {
         "MetricName": "frontend_stalled_cycles",
-        "MetricExpr": "((STALL_FRONTEND / CPU_CYCLES) * 100)",
+        "MetricExpr": "STALL_FRONTEND / CPU_CYCLES * 100",
         "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the frontend unit of the processor.",
         "MetricGroup": "Cycle_Accounting",
         "ScaleUnit": "1percent of cycles"
     },
     {
         "MetricName": "integer_dp_percentage",
-        "MetricExpr": "((DP_SPEC / INST_SPEC) * 100)",
+        "MetricExpr": "DP_SPEC / INST_SPEC * 100",
         "BriefDescription": "This metric measures scalar integer operations as a percentage of operations speculatively executed.",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "1percent of operations"
     },
     {
         "MetricName": "ipc",
-        "MetricExpr": "(INST_RETIRED / CPU_CYCLES)",
+        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
         "BriefDescription": "This metric measures the number of instructions retired per cycle.",
         "MetricGroup": "General",
         "ScaleUnit": "1per cycle"
     },
     {
         "MetricName": "itlb_mpki",
-        "MetricExpr": "((ITLB_WALK / INST_RETIRED) * 1000)",
+        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
         "BriefDescription": "This metric measures the number of instruction TLB Walks per thousand instructions executed.",
         "MetricGroup": "MPKI;ITLB_Effectiveness",
         "ScaleUnit": "1MPKI"
     },
     {
         "MetricName": "itlb_walk_ratio",
-        "MetricExpr": "(ITLB_WALK / L1I_TLB)",
+        "MetricExpr": "ITLB_WALK / L1I_TLB",
         "BriefDescription": "This metric measures the ratio of instruction TLB Walks to the total number of instruction TLB accesses. This gives an indication of the effectiveness of the instruction TLB accesses.",
         "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
-        "ScaleUnit": "1per TLB access"
+        "ScaleUnit": "100percent of TLB accesses"
     },
     {
         "MetricName": "l1d_cache_miss_ratio",
-        "MetricExpr": "(L1D_CACHE_REFILL / L1D_CACHE)",
+        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
         "BriefDescription": "This metric measures the ratio of level 1 data cache accesses missed to the total number of level 1 data cache accesses. This gives an indication of the effectiveness of the level 1 data cache.",
         "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
-        "ScaleUnit": "1per cache access"
+        "ScaleUnit": "100percent of cache accesses"
     },
     {
         "MetricName": "l1d_cache_mpki",
-        "MetricExpr": "((L1D_CACHE_REFILL / INST_RETIRED) * 1000)",
+        "MetricExpr": "L1D_CACHE_REFILL / INST_RETIRED * 1000",
         "BriefDescription": "This metric measures the number of level 1 data cache accesses missed per thousand instructions executed.",
         "MetricGroup": "MPKI;L1D_Cache_Effectiveness",
         "ScaleUnit": "1MPKI"
     },
     {
         "MetricName": "l1d_tlb_miss_ratio",
-        "MetricExpr": "(L1D_TLB_REFILL / L1D_TLB)",
+        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
         "BriefDescription": "This metric measures the ratio of level 1 data TLB accesses missed to the total number of level 1 data TLB accesses. This gives an indication of the effectiveness of the level 1 data TLB.",
         "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
-        "ScaleUnit": "1per TLB access"
+        "ScaleUnit": "100percent of TLB accesses"
     },
     {
         "MetricName": "l1d_tlb_mpki",
-        "MetricExpr": "((L1D_TLB_REFILL / INST_RETIRED) * 1000)",
-        "BriefDescription": "This metric measures the number of level 1 instruction TLB accesses missed per thousand instructions executed.",
+        "MetricExpr": "L1D_TLB_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 1 data TLB accesses missed per thousand instructions executed.",
         "MetricGroup": "MPKI;DTLB_Effectiveness",
         "ScaleUnit": "1MPKI"
     },
     {
         "MetricName": "l1i_cache_miss_ratio",
-        "MetricExpr": "(L1I_CACHE_REFILL / L1I_CACHE)",
+        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
         "BriefDescription": "This metric measures the ratio of level 1 instruction cache accesses missed to the total number of level 1 instruction cache accesses. This gives an indication of the effectiveness of the level 1 instruction cache.",
         "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
-        "ScaleUnit": "1per cache access"
+        "ScaleUnit": "100percent of cache accesses"
     },
     {
         "MetricName": "l1i_cache_mpki",
-        "MetricExpr": "((L1I_CACHE_REFILL / INST_RETIRED) * 1000)",
+        "MetricExpr": "L1I_CACHE_REFILL / INST_RETIRED * 1000",
         "BriefDescription": "This metric measures the number of level 1 instruction cache accesses missed per thousand instructions executed.",
         "MetricGroup": "MPKI;L1I_Cache_Effectiveness",
         "ScaleUnit": "1MPKI"
     },
     {
         "MetricName": "l1i_tlb_miss_ratio",
-        "MetricExpr": "(L1I_TLB_REFILL / L1I_TLB)",
+        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
         "BriefDescription": "This metric measures the ratio of level 1 instruction TLB accesses missed to the total number of level 1 instruction TLB accesses. This gives an indication of the effectiveness of the level 1 instruction TLB.",
         "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
-        "ScaleUnit": "1per TLB access"
+        "ScaleUnit": "100percent of TLB accesses"
     },
     {
         "MetricName": "l1i_tlb_mpki",
-        "MetricExpr": "((L1I_TLB_REFILL / INST_RETIRED) * 1000)",
+        "MetricExpr": "L1I_TLB_REFILL / INST_RETIRED * 1000",
         "BriefDescription": "This metric measures the number of level 1 instruction TLB accesses missed per thousand instructions executed.",
         "MetricGroup": "MPKI;ITLB_Effectiveness",
         "ScaleUnit": "1MPKI"
     },
     {
         "MetricName": "l2_cache_miss_ratio",
-        "MetricExpr": "(L2D_CACHE_REFILL / L2D_CACHE)",
+        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
         "BriefDescription": "This metric measures the ratio of level 2 cache accesses missed to the total number of level 2 cache accesses. This gives an indication of the effectiveness of the level 2 cache, which is a unified cache that stores both data and instruction. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
         "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
-        "ScaleUnit": "1per cache access"
+        "ScaleUnit": "100percent of cache accesses"
     },
     {
         "MetricName": "l2_cache_mpki",
-        "MetricExpr": "((L2D_CACHE_REFILL / INST_RETIRED) * 1000)",
+        "MetricExpr": "L2D_CACHE_REFILL / INST_RETIRED * 1000",
         "BriefDescription": "This metric measures the number of level 2 unified cache accesses missed per thousand instructions executed. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
         "MetricGroup": "MPKI;L2_Cache_Effectiveness",
         "ScaleUnit": "1MPKI"
     },
     {
         "MetricName": "l2_tlb_miss_ratio",
-        "MetricExpr": "(L2D_TLB_REFILL / L2D_TLB)",
+        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
         "BriefDescription": "This metric measures the ratio of level 2 unified TLB accesses missed to the total number of level 2 unified TLB accesses. This gives an indication of the effectiveness of the level 2 TLB.",
         "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness",
-        "ScaleUnit": "1per TLB access"
+        "ScaleUnit": "100percent of TLB accesses"
     },
     {
         "MetricName": "l2_tlb_mpki",
-        "MetricExpr": "((L2D_TLB_REFILL / INST_RETIRED) * 1000)",
+        "MetricExpr": "L2D_TLB_REFILL / INST_RETIRED * 1000",
         "BriefDescription": "This metric measures the number of level 2 unified TLB accesses missed per thousand instructions executed.",
         "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness",
         "ScaleUnit": "1MPKI"
     },
     {
         "MetricName": "ll_cache_read_hit_ratio",
-        "MetricExpr": "((LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD)",
+        "MetricExpr": "(LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD",
         "BriefDescription": "This metric measures the ratio of last level cache read accesses hit in the cache to the total number of last level cache accesses. This gives an indication of the effectiveness of the last level cache for read traffic. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a system level cache.",
         "MetricGroup": "LL_Cache_Effectiveness",
-        "ScaleUnit": "1per cache access"
+        "ScaleUnit": "100percent of cache accesses"
     },
     {
         "MetricName": "ll_cache_read_miss_ratio",
-        "MetricExpr": "(LL_CACHE_MISS_RD / LL_CACHE_RD)",
+        "MetricExpr": "LL_CACHE_MISS_RD / LL_CACHE_RD",
         "BriefDescription": "This metric measures the ratio of last level cache read accesses missed to the total number of last level cache accesses. This gives an indication of the effectiveness of the last level cache for read traffic. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a system level cache.",
         "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness",
-        "ScaleUnit": "1per cache access"
+        "ScaleUnit": "100percent of cache accesses"
     },
     {
         "MetricName": "ll_cache_read_mpki",
-        "MetricExpr": "((LL_CACHE_MISS_RD / INST_RETIRED) * 1000)",
+        "MetricExpr": "LL_CACHE_MISS_RD / INST_RETIRED * 1000",
         "BriefDescription": "This metric measures the number of last level cache read accesses missed per thousand instructions executed.",
         "MetricGroup": "MPKI;LL_Cache_Effectiveness",
         "ScaleUnit": "1MPKI"
     },
     {
         "MetricName": "load_percentage",
-        "MetricExpr": "((LD_SPEC / INST_SPEC) * 100)",
+        "MetricExpr": "LD_SPEC / INST_SPEC * 100",
         "BriefDescription": "This metric measures load operations as a percentage of operations speculatively executed.",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "1percent of operations"
@@ -213,21 +213,21 @@
     },
     {
         "MetricName": "scalar_fp_percentage",
-        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
+        "MetricExpr": "VFP_SPEC / INST_SPEC * 100",
         "BriefDescription": "This metric measures scalar floating point operations as a percentage of operations speculatively executed.",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "1percent of operations"
     },
     {
         "MetricName": "simd_percentage",
-        "MetricExpr": "((ASE_SPEC / INST_SPEC) * 100)",
+        "MetricExpr": "ASE_SPEC / INST_SPEC * 100",
         "BriefDescription": "This metric measures advanced SIMD operations as a percentage of total operations speculatively executed.",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "1percent of operations"
     },
     {
         "MetricName": "store_percentage",
-        "MetricExpr": "((ST_SPEC / INST_SPEC) * 100)",
+        "MetricExpr": "ST_SPEC / INST_SPEC * 100",
         "BriefDescription": "This metric measures store operations as a percentage of operations speculatively executed.",
         "MetricGroup": "Operation_Mix",
         "ScaleUnit": "1percent of operations"
@@ -300,5 +300,12 @@
         "MetricGroup": "Operation_Mix",
         "MetricName": "branch_indirect_spec_rate",
         "ScaleUnit": "100%"
+    },
+    {
+        "MetricName": "sve_all_percentage",
+        "MetricExpr": "SVE_INST_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operations, including loads and stores, as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json
index f297b049b62f..337e6a916f2b 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json
@@ -9,7 +9,7 @@
     },
     {
         "ArchStdEvent": "CID_WRITE_RETIRED",
-        "PublicDescription": "Counts architecturally executed writes to the CONTEXTIDR register, which usually contain the kernel PID and can be output with hardware trace."
+        "PublicDescription": "Counts architecturally executed writes to the CONTEXTIDR_EL1 register, which usually contain the kernel PID and can be output with hardware trace."
     },
     {
         "ArchStdEvent": "TTBR_WRITE_RETIRED",
@@ -17,7 +17,7 @@
     },
     {
         "ArchStdEvent": "BR_RETIRED",
-        "PublicDescription": "Counts architecturally executed branches, whether the branch is taken or not. Instructions that explicitly write to the PC are also counted."
+        "PublicDescription": "Counts architecturally executed branches, whether the branch is taken or not. Instructions that explicitly write to the PC are also counted. Note that exception generating instructions, exception return instructions and context synchronization instructions are not counted."
     },
     {
         "ArchStdEvent": "BR_MIS_PRED_RETIRED",
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.json
index 1af961f8a6c8..a7ea0d4c4ea4 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.json
@@ -5,7 +5,7 @@
     },
     {
         "ArchStdEvent": "BR_PRED",
-        "PublicDescription": "Counts branches speculatively executed and were predicted right."
+        "PublicDescription": "Counts all speculatively executed branches."
     },
     {
         "ArchStdEvent": "INST_SPEC",
@@ -29,7 +29,7 @@
     },
     {
         "ArchStdEvent": "LDREX_SPEC",
-        "PublicDescription": "Counts Load-Exclusive operations that have been speculatively executed. Eg: LDREX, LDX"
+        "PublicDescription": "Counts Load-Exclusive operations that have been speculatively executed. For example: LDREX, LDX"
     },
     {
         "ArchStdEvent": "STREX_PASS_SPEC",
@@ -73,15 +73,15 @@
     },
     {
         "ArchStdEvent": "BR_IMMED_SPEC",
-        "PublicDescription": "Counts immediate branch operations which are speculatively executed."
+        "PublicDescription": "Counts direct branch operations which are speculatively executed."
     },
     {
         "ArchStdEvent": "BR_RETURN_SPEC",
-        "PublicDescription": "Counts procedure return operations (RET) which are speculatively executed."
+        "PublicDescription": "Counts procedure return operations (RET, RETAA and RETAB) which are speculatively executed."
     },
     {
         "ArchStdEvent": "BR_INDIRECT_SPEC",
-        "PublicDescription": "Counts indirect branch operations including procedure returns, which are speculatively executed. This includes operations that force a software change of the PC, other than exception-generating operations.  Eg: BR Xn, RET"
+        "PublicDescription": "Counts indirect branch operations including procedure returns, which are speculatively executed. This includes operations that force a software change of the PC, other than exception-generating operations and direct branch instructions. Some examples of the instructions counted by this event include BR Xn, RET, etc..."
     },
     {
         "ArchStdEvent": "ISB_SPEC",
@@ -97,11 +97,11 @@
     },
     {
         "ArchStdEvent": "RC_LD_SPEC",
-        "PublicDescription": "Counts any load acquire operations that are speculatively executed. Eg: LDAR, LDARH, LDARB"
+        "PublicDescription": "Counts any load acquire operations that are speculatively executed. For example: LDAR, LDARH, LDARB"
     },
     {
         "ArchStdEvent": "RC_ST_SPEC",
-        "PublicDescription": "Counts any store release operations that are speculatively executed. Eg: STLR, STLRH, STLRB'"
+        "PublicDescription": "Counts any store release operations that are speculatively executed. For example: STLR, STLRH, STLRB"
     },
     {
         "ArchStdEvent": "ASE_INST_SPEC",
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json
index bbbebc805034..1fcba19dfb7d 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json
@@ -1,7 +1,7 @@
 [
     {
         "ArchStdEvent": "STALL_FRONTEND",
-        "PublicDescription": "Counts cycles when frontend could not send any micro-operations to the rename stage because of frontend resource stalls caused by fetch memory latency or branch prediction flow stalls. All the frontend slots were empty during the cycle when this event counts."
+        "PublicDescription": "Counts cycles when frontend could not send any micro-operations to the rename stage because of frontend resource stalls caused by fetch memory latency or branch prediction flow stalls. STALL_FRONTEND_SLOTS counts SLOTS during the cycle when this event counts."
     },
     {
         "ArchStdEvent": "STALL_BACKEND",
@@ -9,11 +9,11 @@
     },
     {
         "ArchStdEvent": "STALL",
-        "PublicDescription": "Counts cycles when no operations are sent to the rename unit from the frontend or from the rename unit to the backend for any reason (either frontend or backend stall)."
+        "PublicDescription": "Counts cycles when no operations are sent to the rename unit from the frontend or from the rename unit to the backend for any reason (either frontend or backend stall). This event is the sum of STALL_FRONTEND and STALL_BACKEND"
     },
     {
         "ArchStdEvent": "STALL_SLOT_BACKEND",
-        "PublicDescription": "Counts slots per cycle in which no operations are sent from the rename unit to the backend due to backend resource constraints."
+        "PublicDescription": "Counts slots per cycle in which no operations are sent from the rename unit to the backend due to backend resource constraints. STALL_BACKEND counts during the cycle when STALL_SLOT_BACKEND counts at least 1."
     },
     {
         "ArchStdEvent": "STALL_SLOT_FRONTEND",
@@ -21,7 +21,7 @@
     },
     {
         "ArchStdEvent": "STALL_SLOT",
-        "PublicDescription": "Counts slots per cycle in which no operations are sent to the rename unit from the frontend or from the rename unit to the backend for any reason (either frontend or backend stall)."
+        "PublicDescription": "Counts slots per cycle in which no operations are sent to the rename unit from the frontend or from the rename unit to the backend for any reason (either frontend or backend stall). STALL_SLOT is the sum of STALL_SLOT_FRONTEND and STALL_SLOT_BACKEND."
     },
     {
         "ArchStdEvent": "STALL_BACKEND_MEM",
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json
index b550af1831f5..5704f1e83af9 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json
@@ -25,11 +25,11 @@
     },
     {
         "ArchStdEvent": "DTLB_WALK",
-        "PublicDescription": "Counts data memory translation table walks caused by a miss in the L2 TLB driven by a memory access. Note that partial translations that also cause a table walk are counted. This event does not count table walks caused by TLB maintenance operations."
+        "PublicDescription": "Counts number of demand data translation table walks caused by a miss in the L2 TLB and performing at least one memory access. Translation table walks are counted even if the translation ended up taking a translation fault for reasons different than EPD, E0PD and NFD. Note that partial translations that cause a translation table walk are also counted. Also note that this event counts walks triggered by software preloads, but not walks triggered by hardware prefetchers, and that this event does not count walks triggered by TLB maintenance operations."
     },
     {
         "ArchStdEvent": "ITLB_WALK",
-        "PublicDescription": "Counts instruction memory translation table walks caused by a miss in the L2 TLB driven by a memory access. Partial translations that also cause a table walk are counted. This event does not count table walks caused by TLB maintenance operations."
+        "PublicDescription": "Counts number of instruction translation table walks caused by a miss in the L2 TLB and performing at least one memory access. Translation table walks are counted even if the translation ended up taking a translation fault for reasons different than EPD, E0PD and NFD. Note that partial translations that cause a translation table walk are also counted. Also note that this event does not count walks triggered by TLB maintenance operations."
     },
     {
         "ArchStdEvent": "L1D_TLB_REFILL_RD",
-- 
2.34.1

