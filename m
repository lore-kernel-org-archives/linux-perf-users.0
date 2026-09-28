Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8534E77EA
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617896; cv=none; b=tjhZhhMAHnas+bfzs3nIkZ96FYs43Jr8M+1+IdvaOvdF33xYxvu/MCaPsWg41xs1kKOoBb8zPGVqikCRpq/DYAntQuEZwV6uv2wc08+Tb/MsYeguLdjJLBZdnKvQw43WXFr9qU+X+Jpp8/2svKIIYDQTFL3fqPuQkGopw3DyYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617896; c=relaxed/simple;
	bh=W7NchJ2e254RzEdP3zhZH4tzirDk3Juw+MZY5PFnTE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IDqskh+ooPYj7A45yd5qYLDnX6uWu2jcJUpFJF8fHwKPkQox2rc/DVnN6XSJaptDIIgCZHK8OeqnL6XmDrrtgqk6bUYot6NGND6OThd90MsSQi6D8wqB0ftA/kBeoK+8gFOKQWzk46tZW9a2r8dj/JS7BfKwnq6LqR2dvrBYle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HieWitiG; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HieWitiG"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b6416441eso5854559a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617894; x=1791222694; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+eWi/73aVgEUepz9bgjlZyaQmbZ/Qs8GDgJhCXyhWvc=;
        b=HieWitiGYrM8yziovEgnlQhQrKo/Vbcy+MtCo14f1QCGHVTsGDT93g8OW1+Wpdn7kK
         dAVLd7+V2BdKjYMD43iud6GaEnfpXRMUHQWTxZK36H2pRHcdrnnsOrHHSb4EMlmhN/St
         f6pAFMPdGYcX0wGjJQiEuZkPMOG6FDMYCcXHNsgOpTE79iDrYMi7kSwehZlIJRQCREQh
         v23906QRO4glhHkrthzhWbN6WpdfQ8zyx8Xqglm6KPIJwLNw+/FIH0oN7H40YQTAtj8X
         4XmCuG8kQjMUDh/e/phxlypJuBvNg3MQOLDswXeG7VNwUyXgBSH3DcK72nOCGVCr3bfK
         7W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617894; x=1791222694;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+eWi/73aVgEUepz9bgjlZyaQmbZ/Qs8GDgJhCXyhWvc=;
        b=kjsNkvSNy+5/WjWyytL2dfWw6s/zMGPdc+qPZekzvFp4v3ZKzVfNoR3QJiZy2hRRoi
         dV11hVNMPSk89cGiUEvjMX2shwLQO8JBv9w97ULAycDgWwtw+A0KiFmve9gpktVZJtmj
         bTsJswu/r0HgYBsyRXdiFMZxe6/JxSX6Y3sNL8i9FuRlfRfj3b7HUx/23SGJy1o5A/6G
         2BYLXObjNAACf36fqkAonOXxKMlPnjEqOq1ITG8fdvx4nst9+2qKeVid+Rrtw7sBG1tc
         ZBonrYjg9v3JGqFL10jlqLx+s2203WG0qOXpw8/etiq5gKhvEa5Ejkh6DuT5vDbbz8Mq
         /z9A==
X-Forwarded-Encrypted: i=1; AKwUvByuS4TYiAd8BPmjuUE9Fpm1OFDhmvFC0B3LaRqU9pI3pwNVoAg65QTscGekX45hmu/rvB6lY/jDKGSGqUJh5hRt@vger.kernel.org
X-Gm-Message-State: AFq9FYItf7cJM0ZZjI+2+dOnqIkoHpO8/vv6je7Ife7qelzHaY0g/dWt
	Vew9nQpLgpHwOS+NOqaEQI7z06zVZIVSThK8o6TEkawlZxhHi/XaJEczyUFmgLS8mL8ZAdB9KfO
	LfehMfA==
X-Received: from pgdj8.prod.google.com ([2002:a05:6a02:5208:b0:cc7:9685:757a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d81:b0:3a0:bf0a:c9cf
 with SMTP id 98e67ed59e1d1-3a0bf0ad149mr7941023a91.67.1790617893784; Mon, 28
 Sep 2026 10:51:33 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:51:27 -0700
In-Reply-To: <20260928175127.1032535-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928175127.1032535-1-ctshao@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928175127.1032535-3-ctshao@google.com>
Subject: [PATCH 2/2] perf jevents: Add NVIDIA Tegra410 uncore PCIe metrics
From: Chun-Tse Shao <ctshao@google.com>
To: acme@kernel.org, namhyung@kernel.org, irogers@google.com
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, bwicaksono@nvidia.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Add PCIe bandwidth metrics for the NVIDIA Tegra410 SoC. The formulas
follow Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst:

  AVG_RD_BANDWIDTH_IN_GBPS = RD_BYTES / ELAPSED_TIME_IN_NS
  AVG_WR_BANDWIDTH_IN_GBPS = WR_BYTES / ELAPSED_TIME_IN_NS

There is one PCIE PMU per socket and PCIe Root Complex (RC), named
nvidia_pcie_pmu_<socket-id>_rc_<pcie-rc-id>, with RCs 0 to 5 in each
socket. The metrics sum the rd_bytes/wr_bytes events of both sockets:

  lpm_pcie_bw, lpm_pcie_rd_bw, lpm_pcie_wr_bw: all RCs.
  lpm_pcie_bw_<rc>, lpm_pcie_rd_bw_<rc>, lpm_pcie_wr_bw_<rc>: one RC.
  lpm_pcie_loc_rd_bw_<rc>, lpm_pcie_loc_wr_bw_<rc>: one RC to local
    CMEM, GMEM, PCIe peer and CXL memory.
  lpm_pcie_rem_rd_bw_<rc>, lpm_pcie_rem_wr_bw_<rc>: one RC to remote
    memory.

The per RC metrics are in the lpm_pcie_rc<rc>_bw metric groups.

A socket's event counts as 0 if its PMU isn't present (has_event() is
0), e.g. on a single socket system, or if it isn't counted in the
aggregation (source_count() is 0), e.g. the other socket's event with
--per-socket. Otherwise the metric fails to parse or is nan.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/pmu-events/arm64_metrics.py | 68 ++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index b0d0651fec12..1ca3d8ddb4b7 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -2,9 +2,10 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
 import os
-from typing import Optional
-from metric import (aggr_nr, d_ratio, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric, MetricGroup)
+from typing import List, Optional, Union
+from metric import (aggr_nr, d_ratio, has_event, source_count, Event, Expression,
+                    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
+                    MetricGroup, Select)
 from common_metrics import Cycles
 
 # Global command line arguments.
@@ -67,7 +68,66 @@ def NvidiaT410Uncore() -> Optional[MetricGroup]:
                    rd_cum_outs - rd_cum_outs, "1ns"),
         ], description="NVIDIA Tegra410 DDR latency")
 
-    return MetricGroup("lpm_uncore", [DdrBw(), DdrLat()],
+    def PcieBw() -> MetricGroup:
+        # PCIE PMU, one per socket and PCIe Root Complex (RC):
+        # AVG_{RD,WR}_BANDWIDTH = {RD,WR}_BYTES / ELAPSED_TIME
+        loc_dst = "dst_loc_cmem=0x1,dst_loc_gmem=0x1,dst_loc_pcie_p2p=0x1,dst_loc_pcie_cxl=0x1"
+        rem_dst = "dst_rem=0x1"
+
+        def SocketSum(rc: str, event: str) -> Expression:
+            # Sum the event over both sockets. A PMU counts as 0 if it isn't
+            # present (has_event() is 0) or isn't counted in the aggregation,
+            # e.g. the other socket with --per-socket (source_count() is 0).
+            def Count(e: Event) -> Expression:
+                return Select(Select(e, source_count(e), 0), has_event(e), 0)
+
+            return (Count(Event(f"nvidia_pcie_pmu_0_{rc}/{event}/")) +
+                    Count(Event(f"nvidia_pcie_pmu_1_{rc}/{event}/")))
+
+        # nvidia_pcie_pmu_<socket-id>_rc matches the PMUs of all RCs in the socket.
+        rd = SocketSum("rc", "rd_bytes")
+        wr = SocketSum("rc", "wr_bytes")
+        metrics: List[Union[Metric, MetricGroup]] = [
+            Metric("lpm_pcie_bw", "Total PCIe bandwidth across all Root Complexes",
+                   d_ratio(rd + wr, interval_sec), mb_per_sec),
+            Metric("lpm_pcie_rd_bw", "Total PCIe read bandwidth across all Root Complexes",
+                   d_ratio(rd, interval_sec), mb_per_sec),
+            Metric("lpm_pcie_wr_bw", "Total PCIe write bandwidth across all Root Complexes",
+                   d_ratio(wr, interval_sec), mb_per_sec),
+        ]
+        for i in range(6):
+            rc = f"rc_{i}"
+            rc_rd = SocketSum(rc, "rd_bytes")
+            rc_wr = SocketSum(rc, "wr_bytes")
+            loc_rd = SocketSum(rc, f"rd_bytes,{loc_dst}")
+            loc_wr = SocketSum(rc, f"wr_bytes,{loc_dst}")
+            rem_rd = SocketSum(rc, f"rd_bytes,{rem_dst}")
+            rem_wr = SocketSum(rc, f"wr_bytes,{rem_dst}")
+            metrics.append(MetricGroup(f"lpm_pcie_rc{i}_bw", [
+                Metric(f"lpm_pcie_bw_{i}", f"PCIe total bandwidth on Root Complex {i}",
+                       d_ratio(rc_rd + rc_wr, interval_sec), mb_per_sec),
+                Metric(f"lpm_pcie_rd_bw_{i}", f"PCIe read bandwidth on Root Complex {i}",
+                       d_ratio(rc_rd, interval_sec), mb_per_sec),
+                Metric(f"lpm_pcie_wr_bw_{i}", f"PCIe write bandwidth on Root Complex {i}",
+                       d_ratio(rc_wr, interval_sec), mb_per_sec),
+                Metric(f"lpm_pcie_loc_rd_bw_{i}",
+                       f"PCIe local read bandwidth on Root Complex {i}",
+                       d_ratio(loc_rd, interval_sec), mb_per_sec),
+                Metric(f"lpm_pcie_loc_wr_bw_{i}",
+                       f"PCIe local write bandwidth on Root Complex {i}",
+                       d_ratio(loc_wr, interval_sec), mb_per_sec),
+                Metric(f"lpm_pcie_rem_rd_bw_{i}",
+                       f"PCIe remote read bandwidth on Root Complex {i}",
+                       d_ratio(rem_rd, interval_sec), mb_per_sec),
+                Metric(f"lpm_pcie_rem_wr_bw_{i}",
+                       f"PCIe remote write bandwidth on Root Complex {i}",
+                       d_ratio(rem_wr, interval_sec), mb_per_sec),
+            ], description=f"PCIe bandwidth on Root Complex {i}"))
+
+        return MetricGroup("lpm_pcie_bw", metrics,
+                           description="NVIDIA Tegra410 PCIe Root Complex bandwidth")
+
+    return MetricGroup("lpm_uncore", [DdrBw(), DdrLat(), PcieBw()],
                        description="NVIDIA Tegra410 uncore metrics")
 
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

