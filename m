Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029194E1C87
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617895; cv=none; b=SKJUN8qUvvyUlvZ+zWtFLy5mFLRHxHzVM4/wIrEWptAx0LYknw6pKYTYHmijIwN/s4jACpqmCPGBbMxrNMUC0lXRGbuHtsBDrjOD9HYhoJWIYjBsmK7/jT1tqJqqZvi+ACJX3WUV75AEb9mAMkU1C2O6P5QjVAThVi4uk0JyY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617895; c=relaxed/simple;
	bh=/COI9v1Zgdw6CM9J/+iiDztdxC0ARcUlvTfApyjAlrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IrQYh5Fh277rygLma3FjJgnpxFg2DBlJAFuvDsY5ymqAx++Nk8cazcqAACtUlCZia2JaktZchBDtC0RZ5qAN5qVqR6eE/1CGObkWBzvnG0Ju2PKyJMeddGzdkgV1j4q8gjKHROZFBLHkbYIERlERNhVZreQzSzqW3NP0H7SlhEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gd0EY/bZ; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gd0EY/bZ"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so4740462a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 10:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617893; x=1791222693; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YT8fSaf2iy6BbHJSTRJh91pzph8T4TLe8Lu1aCY2oBs=;
        b=Gd0EY/bZRyKBdUN2luHhtjN2NietFk4uY/+x6etBmbragAAUpGI9gAlYQ7PJ7BiZH3
         TbRPyYRDJU6/umuN2lP4Yo8PC9BSHUuPztxhwEC1/7Y+mXJZ12mXGTYxpBIJ7iYHV0Si
         dmNSAScvr1UTMVU/BYLIUD7+5Po1LVgCLiheV1fZneQqTDDMUiFrqmxGdHkpR1j9ZdC0
         elru1RIWdKYeT7PbVcz1kyT5Ui7okroWr+3nB/2WxZtUTx7K2HNGWjwj6q6BRA/Ict7n
         N2k8FCo5fkh4YQrOtoF7X9RSYJ1tVLd+MrdlujZWn8F7JY72YrkiMt1V4W0LD2OesSBQ
         M+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617893; x=1791222693;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YT8fSaf2iy6BbHJSTRJh91pzph8T4TLe8Lu1aCY2oBs=;
        b=VPpmoeldVkuymSwI32mEPfqTIFleqODPyjzB+HODC6MV/CT7TXrZhpl53BLB17aq2o
         pssFlwj45wUGRURUgRyRz+PBnQkPA6gZxV4q0uSjnM1oTiPGeZjs5PkN0vxR4dU4h2er
         WZfaaLpD8KPZnJLdiSoeO4HoIjLftR7va8si1qrhCtRBnwUVIyIb2i8127upftfsWjMb
         xFp5oxatdVjAuRwT80VBpFK7WCQBGnaZrwJEhK5s56rIetnIn8s1sh3GBw3+9vspCdK6
         Un+o4XFFDf+bXw/OK9BIKH7ic+3ucB2fDuJSJU2KlLd6kJGIcrmnLO6J3mi1bcfVkcnF
         VxMg==
X-Forwarded-Encrypted: i=1; AKwUvBwHjR6sjHzsz6A3Les1y192A2fY4uCDr1skCJdssOpM54H6xXjaQg2FFdRAYcWctbbrToLvvgNr1IVI+zzLQuC7@vger.kernel.org
X-Gm-Message-State: AFq9FYK1Ypaz3tKcYKUUIRMHwKMgkEMOc0TYSYVgZChOadjajFBgY6xZ
	Ces59pMik344jdOTvuqvCksjfzshUTokhRByQzE90dGdgENeV3ibuNlnGZbPiMCb+0Q5/O5GX/J
	H2Ed5nQ==
X-Received: from pjbne20.prod.google.com ([2002:a17:90b:3754:b0:3a4:89dc:ed26])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d03:b0:3a0:e89c:b989
 with SMTP id 98e67ed59e1d1-3a0e89cba0dmr5901692a91.36.1790617892740; Mon, 28
 Sep 2026 10:51:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:51:26 -0700
In-Reply-To: <20260928175127.1032535-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928175127.1032535-1-ctshao@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928175127.1032535-2-ctshao@google.com>
Subject: [PATCH 1/2] perf jevents: Add NVIDIA Tegra410 uncore DDR metrics
From: Chun-Tse Shao <ctshao@google.com>
To: acme@kernel.org, namhyung@kernel.org, irogers@google.com
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, bwicaksono@nvidia.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Add DDR bandwidth and latency metrics for the NVIDIA Tegra410 SoC. The
formulas follow Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst:

  AVG_MEM_READ_BANDWIDTH_IN_GBPS = MEM_BYTES_RD / ELAPSED_TIME_IN_NS
  AVG_MEM_WRITE_BANDWIDTH_IN_GBPS = MEM_BYTES_WR / ELAPSED_TIME_IN_NS

  FREQ_IN_GHZ = CYCLES / ELAPSED_TIME_IN_NS
  AVG_LATENCY_IN_CYCLES = RD_CUM_OUTS / RD_REQ
  AVERAGE_LATENCY_IN_NS = AVG_LATENCY_IN_CYCLES / FREQ_IN_GHZ

The bandwidth metrics use the mem_bytes_rd/mem_bytes_wr events of the
Unified Coherence Fabric (UCF) PMU with source/destination filters:

  lpm_ddr_bw, lpm_ddr_rd_bw, lpm_ddr_wr_bw: all sources to local CMEM.
  lpm_ddr_loc_rd_bw, lpm_ddr_loc_wr_bw: local CPU and non-CPU sources to
    local CMEM.
  lpm_ddr_rem_rd_bw, lpm_ddr_rem_wr_bw: local CPU and non-CPU sources to
    remote memory.

The latency metrics use the CPU Memory (CMEM) latency PMU:

  lpm_ddr_lat, lpm_ddr_rd_lat: average DDR read latency in ns.
  lpm_ddr_wr_lat: the PMU only measures reads, so this is always 0.

There is one CMEM latency PMU per socket and perf sums the counts of the
PMUs in an aggregation, e.g. of both sockets in the default aggregation
mode. Use aggr_nr() to divide the summed cycles by the number of PMUs,
otherwise the frequency is too high and the latency too low by that
factor.

The events are sysfs events of the nvidia_ucf_pmu_<socket-id> and
nvidia_cmem_latency_pmu_<socket-id> PMUs rather than json events, so add
the "nvidia" PMU prefix to the prefixes that skip the named json event
check in metric.py.

pmu-events/Build only runs arm64_metrics.py for the "arm" vendor models,
so also run it for the "nvidia" vendor models to generate the Tegra410
metrics.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/pmu-events/Build            |  2 +-
 tools/perf/pmu-events/arm64_metrics.py | 66 +++++++++++++++++++++++++-
 tools/perf/pmu-events/metric.py        |  2 +-
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 1ac067be9d34..8dc8cfcb8b04 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -78,7 +78,7 @@ endif
 
 ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),arm64 all))
 # Generate ARM Json
-ARMS := $(shell ls -d pmu-events/arch/arm64/arm/*|grep -v cmn)
+ARMS := $(shell ls -d pmu-events/arch/arm64/arm/* pmu-events/arch/arm64/nvidia/*|grep -v cmn)
 ARM_METRICS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metrics.json)
 ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
 GEN_JSON += $(ARM_METRICS) $(ARM_METRICGROUPS)
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index 4ecda96d11fa..b0d0651fec12 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -2,14 +2,75 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
 import os
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from typing import Optional
+from metric import (aggr_nr, d_ratio, Event, JsonEncodeMetric,
+                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric, MetricGroup)
 from common_metrics import Cycles
 
 # Global command line arguments.
 _args = None
 
 
+def NvidiaT410Uncore() -> Optional[MetricGroup]:
+    """Uncore metrics for the NVIDIA Tegra410 SoC.
+
+    The formulas follow Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst.
+    """
+    assert _args is not None
+    if _args.vendor != "nvidia" or _args.model != "t410":
+        return None
+
+    interval_sec = Event("duration_time")
+    mb_per_sec = f"{1/1e6}MB/s"
+
+    def DdrBw() -> MetricGroup:
+        # Unified Coherence Fabric (UCF) PMU:
+        # AVG_MEM_{READ,WRITE}_BANDWIDTH = MEM_BYTES_{RD,WR} / ELAPSED_TIME
+        loc_src = "src_loc_cpu=0x1,src_loc_noncpu=0x1"
+        rd = Event("nvidia_ucf_pmu/mem_bytes_rd,dst_loc_cmem=0x1/")
+        wr = Event("nvidia_ucf_pmu/mem_bytes_wr,dst_loc_cmem=0x1/")
+        loc_rd = Event(f"nvidia_ucf_pmu/mem_bytes_rd,{loc_src},dst_loc_cmem=0x1/")
+        loc_wr = Event(f"nvidia_ucf_pmu/mem_bytes_wr,{loc_src},dst_loc_cmem=0x1/")
+        rem_rd = Event(f"nvidia_ucf_pmu/mem_bytes_rd,{loc_src},dst_rem=0x1/")
+        rem_wr = Event(f"nvidia_ucf_pmu/mem_bytes_wr,{loc_src},dst_rem=0x1/")
+        return MetricGroup("lpm_ddr_bw", [
+            Metric("lpm_ddr_bw", "Total DDR bandwidth",
+                   d_ratio(rd + wr, interval_sec), mb_per_sec),
+            Metric("lpm_ddr_rd_bw", "DDR read bandwidth",
+                   d_ratio(rd, interval_sec), mb_per_sec),
+            Metric("lpm_ddr_wr_bw", "DDR write bandwidth",
+                   d_ratio(wr, interval_sec), mb_per_sec),
+            Metric("lpm_ddr_loc_rd_bw", "Local DDR read bandwidth",
+                   d_ratio(loc_rd, interval_sec), mb_per_sec),
+            Metric("lpm_ddr_loc_wr_bw", "Local DDR write bandwidth",
+                   d_ratio(loc_wr, interval_sec), mb_per_sec),
+            Metric("lpm_ddr_rem_rd_bw", "Remote DDR read bandwidth",
+                   d_ratio(rem_rd, interval_sec), mb_per_sec),
+            Metric("lpm_ddr_rem_wr_bw", "Remote DDR write bandwidth",
+                   d_ratio(rem_wr, interval_sec), mb_per_sec),
+        ], description="NVIDIA Tegra410 DDR bandwidth")
+
+    def DdrLat() -> MetricGroup:
+        # CPU Memory (CMEM) latency PMU, one per socket:
+        # AVERAGE_LATENCY_IN_NS = (RD_CUM_OUTS / RD_REQ) / (CYCLES / ELAPSED_TIME_IN_NS)
+        rd_cum_outs = Event("nvidia_cmem_latency_pmu/rd_cum_outs/")
+        rd_req = Event("nvidia_cmem_latency_pmu/rd_req/")
+        cycles = Event("nvidia_cmem_latency_pmu/cycles/")
+        # perf sums the counts of the PMUs in an aggregation, e.g. both sockets
+        # by default, so divide cycles by their number to get the frequency.
+        rd_lat = d_ratio(1e9 * interval_sec * rd_cum_outs * aggr_nr(cycles), rd_req * cycles)
+        return MetricGroup("lpm_ddr_lat", [
+            Metric("lpm_ddr_lat", "Average DDR read latency in ns", rd_lat, "1ns"),
+            Metric("lpm_ddr_rd_lat", "DDR read latency in ns", rd_lat, "1ns"),
+            # The CMEM latency PMU only measures reads, write latency is always 0.
+            Metric("lpm_ddr_wr_lat", "DDR write latency in ns",
+                   rd_cum_outs - rd_cum_outs, "1ns"),
+        ], description="NVIDIA Tegra410 DDR latency")
+
+    return MetricGroup("lpm_uncore", [DdrBw(), DdrLat()],
+                       description="NVIDIA Tegra410 uncore metrics")
+
+
 def main() -> None:
     global _args
 
@@ -37,6 +98,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         Cycles(),
+        NvidiaT410Uncore(),
     ])
 
     if _args.metricgroups:
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index f5d81eccd5c3..6fb69024d1fd 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -91,7 +91,7 @@ def CheckEveryEvent(*names: str) -> None:
       name = name[:name.find(':')]
     elif '/' in name:
       name = name[:name.find('/')]
-      if any([name.startswith(x) for x in ['amd', 'arm', 'cpu', 'msr', 'power', 'cha', 'uncore']]):
+      if any([name.startswith(x) for x in ['amd', 'arm', 'cpu', 'msr', 'power', 'cha', 'uncore', 'nvidia']]):
         continue
     if name not in all_events_all_models:
       raise ValueError(f"Is {name} a named json event?")
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

