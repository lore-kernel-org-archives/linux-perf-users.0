Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4939021A
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921562; cv=none; b=A46Gf5ZB/wSNWA5ZpJYdsoBjU1EEjMdANGGqkpf/ZYtoIgjr3Yrvrasvpm+TZDsw9q6tNOxPgLiOT2rBqm2espdNUEWDGxV2c9GUDX7V/wW5ZXWPsaLFcdZsGBJXtIr5sPnoo+Ajb1kfw6v80GubQzLgU4ImcjdEgAWJ+1sMkRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921562; c=relaxed/simple;
	bh=m80NJ+0X0ib5LTbC3Es7cffWDSAffY6Uxty86Z0sM0M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AjERQtaUJbDbV/iUKx69IO3S+Pd2xMH3hOSmepuHxxo1XcESkiJCipq0ZQK4QUKQtMySKZnVwiLEJVgweGfdacAAa4w+XwwsTslYPlTApm4cLctziSE+h1+tk1UHiTcXxtCefPC3x8HwI/dJntUE9+bwLLgNuf6Ftvb9Yq5UoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JwreTrwS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwreTrwS"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2baf7378ad0so129796195ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 15:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779921560; x=1780526360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K+fe7HA+vyt0OREUX0nQyWTBJuu5RKwCm1GVLu6SIgg=;
        b=JwreTrwS303NCmsi/XXQs6XmjCJ7q31/ZGwUNilW0OubDsJyKwiWRh/1MDauaCM9Dx
         vdOE8k5HBqxhdZVDR8i+BpwIQYF+7DnlGxAyFQ88s13Y1XDDG5dLiHFpsV8SswmV7bd6
         hEn/sq1NNBeLTyKib7b7yjOyJA8LNBQNX2RL/NwA8n8Lp9sMWj/c0ZZGRVRVW9oxzNhm
         O/uFNBHgwoN7WwxDdFblnnUbumWkjjUlNI5TdLhucs5CB2T4YjOvn6Wu/9RbgxWpkbTr
         VDIXREAElvVt9PGn+Jrj2OrWWTd8bbw5TlkTQ0XJRDDEBVmMMcBloODCKlsFob4wBNpL
         LMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779921560; x=1780526360;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+fe7HA+vyt0OREUX0nQyWTBJuu5RKwCm1GVLu6SIgg=;
        b=JHjPz2xTRdP2dL3la+ki0COl9YbclXr2Ia7A0wrCzNXCJ0BUJfVu7IlF6aEMuCgYw8
         1+BtWOzKh3UCqOM30y4D7CVRTp7CBliT285kzHYoBBarfDWD9j5Py3iZqse/viwvDxqX
         adRascKeQvXUJV3xC5+XhZ7bKzJQfSBJUE1yYFaz4WA1VsteiOvVnTq/r1hZuoCumHDL
         UhFOF/+ezV06jO+xWPcvs13xCEkN9b7riMvdwlPtgZBTyyFbAdWpNzhYkIgJGjLEdII9
         EAj0OH3psVBmlA21JcLHnG8E4I1FCrL8goWbNuzbSB3AFnrsm/EfAscXMKc24y6OPBac
         cHBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ekl0g7k0cYCla5JakCa/+alJy7hX3IIUbKB7pr9lJia+s+sTq8GDun6ijxIx71jjCaWyjx8jSzIu89DJE8WXb@vger.kernel.org
X-Gm-Message-State: AOJu0YzMeMgv3aRMPNfN8a5wVpn2RrSp/j6AxNRXqJCMxl37mmmbpgeq
	hdJGNlohMUV9tgAe+JK386qFe63qT7nL0XsmVQuQ8boped4tKhHJPJdLOQli1/WTXGpgvXJj9Za
	qc94lVg==
X-Received: from plks14.prod.google.com ([2002:a17:903:2ce:b0:2b0:af2d:2502])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e6:b0:2bc:7d5d:e2b7
 with SMTP id d9443c01a7336-2beb069cff3mr308837545ad.36.1779921559984; Wed, 27
 May 2026 15:39:19 -0700 (PDT)
Date: Wed, 27 May 2026 15:39:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260527223917.3845056-1-ctshao@google.com>
Subject: [PATCH] perf jevents: Add IOMMU metrics for AMD and Intel
From: Chun-Tse Shao <ctshao@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Add IOMMU Translation Lookaside Buffer (TLB) and interrupt cache metrics
to perf jevents for both AMD and Intel platforms. This enhances I/O
performance observability, allowing fleet-wide monitoring of IOMMU
overhead.

For AMD, these metrics are supported on Zen 2 and newer processors and
are implemented using the standard `amd_iommu` PMU events. The
implementation uses the existing `_zen_model` helper to ensure these are
only generated for Zen 2+.

For Intel, these metrics are supported on platforms that expose the
required uncore IIO IOMMU events (such as Emerald Rapids and Granite
Rapids). The Intel implementation dynamically detects event availability
at generation time. It requires at least the TLB events to expose the
metric group, while the interrupt cache events are optional. This allows
platforms like Emerald Rapids, which lack IOMMU interrupt cache events,
to still expose the IOMMU TLB metrics.

The following metrics are added:
- iotlb_total_hit: Total IOTLB hits (4K, 2M, 1G pages).
- iotlb_total_miss: Total IOTLB misses.
- iotlb_miss_rate: IOTLB miss rate.
- iotlb_interrupt_cache_hit: Interrupt cache hits.
- iotlb_interrupt_cache_miss: Interrupt cache misses (calculated for
  Intel as lookup - hit, clamped to zero).
- iotlb_interrupt_cache_lookup: Interrupt cache lookups.
- iotlb_interrupt_cache_miss_rate: Interrupt cache miss rate.

Tested:
  # perf stat -M iotlb_total_hit,iotlb_total_miss,iotlb_miss_rate --per-socket --metric-only -a -j -- sleep 10
  {"socket" : "S0", "counters" : 10, "hits  iotlb_total_hit" : "3579249.0", "%  iotlb_miss_rate" : "0.0", "misses  iotlb_total_miss" : "3.0"}
  {"socket" : "S1", "counters" : 10, "hits  iotlb_total_hit" : "0.0", "%  iotlb_miss_rate" : "0.0", "misses  iotlb_total_miss" : "0.0"}

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/pmu-events/amd_metrics.py   | 56 +++++++++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 971f6e7af1f8..4558e7ce20f2 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -265,6 +265,61 @@ def AmdDtlb() -> Optional[MetricGroup]:
     ], description="Data TLB metrics")


+def AmdIotlb() -> Optional[MetricGroup]:
+  global _zen_model
+  if _zen_model < 2:
+    return None
+
+  total_hit = Event("amd_iommu/mem_iommu_tlb_pte_hit/") + Event(
+      "amd_iommu/mem_iommu_tlb_pde_hit/"
+  )
+  total_miss = Event("amd_iommu/mem_iommu_tlb_pte_mis/") + Event(
+      "amd_iommu/mem_iommu_tlb_pde_mis/"
+  )
+  miss_rate = d_ratio(total_miss, total_miss + total_hit)
+
+  interrupt_cache_hit = Event("amd_iommu/int_dte_hit/")
+  interrupt_cache_miss = Event("amd_iommu/int_dte_mis/")
+  interrupt_cache_lookup = interrupt_cache_hit + interrupt_cache_miss
+  interrupt_cache_miss_rate = d_ratio(
+      interrupt_cache_miss, interrupt_cache_miss + interrupt_cache_hit
+  )
+
+  return MetricGroup(
+      "iotlb",
+      [
+          Metric("iotlb_total_hit", "IOTLB total hit", total_hit, "hits"),
+          Metric("iotlb_total_miss", "IOTLB total miss", total_miss, "misses"),
+          Metric("iotlb_miss_rate", "IOTLB miss rate", miss_rate, "100%"),
+          Metric(
+              "iotlb_interrupt_cache_hit",
+              "IOTLB interrupt cache hit",
+              interrupt_cache_hit,
+              "hits",
+          ),
+          Metric(
+              "iotlb_interrupt_cache_miss",
+              "IOTLB interrupt cache miss",
+              interrupt_cache_miss,
+              "misses",
+          ),
+          Metric(
+              "iotlb_interrupt_cache_lookup",
+              "IOTLB interrupt cache lookup",
+              interrupt_cache_lookup,
+              "lookups",
+          ),
+          Metric(
+              "iotlb_interrupt_cache_miss_rate",
+              "IOTLB interrupt cache miss rate",
+              interrupt_cache_miss_rate,
+              "100%",
+          ),
+      ],
+      description="IOMMU TLB metrics",
+  )
+
+
 def AmdItlb():
     global _zen_model
     l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
@@ -473,6 +528,7 @@ def main() -> None:
         AmdBr(),
         AmdCtxSw(),
         AmdDtlb(),
+        AmdIotlb(),
         AmdItlb(),
         AmdLdSt(),
         AmdUpc(),
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 52035433b505..c3a5c2965f74 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -457,6 +457,67 @@ def IntelIlp() -> MetricGroup:
     ])


+def IntelIotlb() -> Optional[MetricGroup]:
+  try:
+    total_hit = (
+        Event("UNC_IIO_IOMMU0.4K_HITS")
+        + Event("UNC_IIO_IOMMU0.2M_HITS")
+        + Event("UNC_IIO_IOMMU0.1G_HITS")
+    )
+    total_miss = Event("UNC_IIO_IOMMU0.MISSES")
+  except:
+    return None
+
+  miss_rate = d_ratio(total_miss, total_miss + total_hit)
+  metrics = [
+      Metric("iotlb_total_hit", "IOTLB total hit", total_hit, "hits"),
+      Metric("iotlb_total_miss", "IOTLB total miss", total_miss, "misses"),
+      Metric("iotlb_miss_rate", "IOTLB miss rate", miss_rate, "100%"),
+  ]
+
+  try:
+    interrupt_cache_hit = Event("UNC_IIO_IOMMU3.INT_CACHE_HITS")
+    interrupt_cache_lookup = Event("UNC_IIO_IOMMU3.INT_CACHE_LOOKUPS")
+    interrupt_cache_miss = max(interrupt_cache_lookup - interrupt_cache_hit, 0)
+    interrupt_cache_miss_rate = d_ratio(
+        interrupt_cache_miss, interrupt_cache_miss + interrupt_cache_hit
+    )
+    metrics += [
+        Metric(
+            "iotlb_interrupt_cache_hit",
+            "IOTLB interrupt cache hit",
+            interrupt_cache_hit,
+            "hits",
+        ),
+        Metric(
+            "iotlb_interrupt_cache_miss",
+            "IOTLB interrupt cache miss",
+            interrupt_cache_miss,
+            "misses",
+        ),
+        Metric(
+            "iotlb_interrupt_cache_lookup",
+            "IOTLB interrupt cache lookup",
+            interrupt_cache_lookup,
+            "lookups",
+        ),
+        Metric(
+            "iotlb_interrupt_cache_miss_rate",
+            "IOTLB interrupt cache miss rate",
+            interrupt_cache_miss_rate,
+            "100%",
+        ),
+    ]
+  except:
+    pass
+
+  return MetricGroup(
+      "iotlb",
+      metrics,
+      description="IOMMU TLB metrics",
+  )
+
+
 def IntelL2() -> Optional[MetricGroup]:
     try:
         DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -1105,6 +1166,7 @@ def main() -> None:
         IntelCtxSw(),
         IntelFpu(),
         IntelIlp(),
+        IntelIotlb(),
         IntelL2(),
         IntelLdSt(),
         IntelMissLat(),
--
2.54.0.823.g6e5bcc1fc9-goog

