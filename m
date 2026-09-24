Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6034E4AB1D4
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269483; cv=none; b=b/zPKBkGAsM+U9/uiHDgDQAwpEr0PyBVVgVarkvUiIn1h6rAhWelEPME3cOvMQLm8/9QjFW75TVCpFv8dRoWOnB88YYHuO5IDGqmr7jTh4qsjuCbi3d/lyfJ7yz56OWmuMH+ElrJpCz/hfHv4G7IkpmzsxqZznYfjjPMsZFt2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269483; c=relaxed/simple;
	bh=YPwQn0S3wQwsX2rLY52hr+C3DrPmDExuB9NAjJ92AcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I2TwJrUPfEK+OiDj3qp4eqMW7Qsio5I9YACsiVl0pkfAufSzB1r9HzteBqUDnTx1ULPQ/o9njtKgPO9MoQwwU1M4aSz5vEu+6T7f71BlF6zCU6Swmc5CmNd45YQr3IKw26Xui7RxTkcUgSFIw3Ie16Gi7dXyikK8+HW5ZlOvdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkm5RErG; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkm5RErG"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14373747468so24896c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269479; x=1790874279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i3KsC39D6uATehQv31zsoQzGLqTwfyFmpqP4Ks6M8Gc=;
        b=lkm5RErGFu01WqcKl23xPxn604nMbGjGpwurVRViCUBfQkUyIa/S4ExvvO/5CbMinK
         +ulKvbErC8VIfyoaI+CjEo52iUt0WO4FJ3O2vpCukpCT5CcgB9pN5raYOUb2sjtFu8g1
         PGZ5W6pjT1kraYUOUVMoRvh4spPlMA2GqejPFZLyJ/3WUzc8mM6f6LET3coQcTtnuGYZ
         Nu/qTmJisfEbwwoWxOlmSU32WM1ydSDUG7E9VJ6DbPrzZnbSzg6KSo+1lTVsBmzoBf46
         zvZkl+1GpJIbbtibV+Vuf323zzsEYGS4NTcqUwFD5aAuIBQ6q/D0fFWnaHl4DUDapqbQ
         qTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269479; x=1790874279;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i3KsC39D6uATehQv31zsoQzGLqTwfyFmpqP4Ks6M8Gc=;
        b=BIzB5JMkn8Z2nz1ND9JjRPOnsW9YifLsqic8knPHV+LoGv0ex5u1rQqwNue7zm80Jl
         kNV80CcU54jc5Y3YpjxNTpPppo6bA1TPFRGu912GgKRKcaBcMo/l1KwOD9f863LIbLOt
         azz5lb7JBMiJNPp8Ig3ZDseJpzr1IKGUDrIAJbVf9cZtDRxFHcdVx5ze++W+oWmMk00S
         ErnCM0UR8aAKJqpdIND7JDiPHILxT2t1DLaMfNqa8j/qrgkuFTYLmBo/dBwxeaIBe9TQ
         pY9eQIy7kpV7yNrwhNUGuoi3fWGyuINrdx/ojc6iCJPVo5MqrbBO2dZ2kPvZismW38gW
         jA2Q==
X-Forwarded-Encrypted: i=1; AKwUvBx4crRac39RuMvgJ71yiB6selaHXAmgozy7Rtqk5Fp0ldspgvWWFKTSQtI6AH3/n71N1rdt0/snSEIr/OSxtnxc@vger.kernel.org
X-Gm-Message-State: AFuF++nIn1/qysh07FR1/NxdvzRaLSP9r8PA27B5lIxOXwFntZeMRKjH
	vHvTNdLVTYuCBOUAoV4k3GgVq/Wph0HGuVK+5zfvcKUXVFGFdMgr6KXSMy2ibDCjbhWGCEW1SHs
	MeZL8SaHwAA==
X-Received: from dlbur4.prod.google.com ([2002:a05:7022:ea44:b0:144:d109:6356])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7e03:b0:144:f44b:fa26
 with SMTP id a92af1059eb24-14503fe27f0mr2820228c88.30.1790269478851; Thu, 24
 Sep 2026 10:04:38 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:38 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-19-irogers@google.com>
Subject: [PATCH v2 18/26] perf vendor events intel: Update sandybridge metrics
 to TMA 5.2
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated TMA metrics were published in:

  https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a887=
ad46c45

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/sandybridge/metricgroups.json    |  3 +-
 .../arch/x86/sandybridge/snb-metrics.json     | 35 +++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json b=
/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
index eb8fbd14138a..e527c8c5c443 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
@@ -79,7 +79,6 @@
     "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
     "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
     "tma_divider_group": "Metrics contributing to tma_divider category",
-    "tma_dram_bound_group": "Metrics contributing to tma_dram_bound catego=
ry",
     "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load category=
",
     "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store catego=
ry",
     "tma_fetch_bandwidth_group": "Metrics contributing to tma_fetch_bandwi=
dth category",
@@ -88,6 +87,7 @@
     "tma_fp_vector_group": "Metrics contributing to tma_fp_vector category=
",
     "tma_frontend_bound_group": "Metrics contributing to tma_frontend_boun=
d category",
     "tma_heavy_operations_group": "Metrics contributing to tma_heavy_opera=
tions category",
+    "tma_icache_misses_group": "Metrics contributing to tma_icache_misses =
category",
     "tma_issue2P": "Metrics related by the issue $issue2P",
     "tma_issueBM": "Metrics related by the issue $issueBM",
     "tma_issueBW": "Metrics related by the issue $issueBW",
@@ -105,6 +105,7 @@
     "tma_issueTLB": "Metrics related by the issue $issueTLB",
     "tma_itlb_misses_group": "Metrics contributing to tma_itlb_misses cate=
gory",
     "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
+    "tma_l3_miss_bound_group": "Metrics contributing to tma_l3_miss_bound =
category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
     "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
     "tma_mem_latency_group": "Metrics contributing to tma_mem_latency cate=
gory",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/=
tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index d40761903429..48f9ccc0a727 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -129,16 +129,6 @@
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricConstraint": "NO_GROUP_EVENTS_SMT",
-        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS=
_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS)) * CYCLE_ACTIVI=
TY.STALLS_L2_PENDING / tma_info_thread_clks",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
-        "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS_PS",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
@@ -316,7 +306,7 @@
         "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / tma_info_system_time / 1e3",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_mem_bandwidth"
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_mem_bandwidth, tma_uc_bound=
"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
@@ -431,7 +421,16 @@
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UOPS=
_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS)) * CYCLE_ACTIVI=
TY.STALLS_L2_PENDING / tma_info_thread_clks",
+        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_grou=
p;tma_memory_bound_group",
+        "MetricName": "tma_l3_miss_bound",
+        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound > =
0.2 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
         "ScaleUnit": "100%"
     },
     {
@@ -467,18 +466,18 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_thread_clks",
-        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_miss_bound_group",
         "MetricName": "tma_mem_bandwidth",
-        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_info_system_dram_bw_use",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_l3_miss_bound >=
 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_info_system_dram_bw_use, tma_uc_bo=
und",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory - DRA=
M ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
-        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
+        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
issueLat;tma_l3_miss_bound_group",
         "MetricName": "tma_mem_latency",
-        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_l3_miss_bound > 0=
.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: ",
         "ScaleUnit": "100%"
     },
@@ -508,7 +507,7 @@
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
         "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_clears_r=
esteers, tma_l1_bound, tma_machine_clears, tma_microcode_sequencer, tma_mix=
ing_vectors, tma_serializing_operation",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_clears_r=
esteers, tma_info_inst_mix_vectormixpki, tma_l1_bound, tma_machine_clears, =
tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_operation",
         "ScaleUnit": "100%"
     },
     {
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

