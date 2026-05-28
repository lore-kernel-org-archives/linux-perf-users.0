Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FC313E31
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011911; cv=none; b=uHU+inqANhzbW1+gX9KQ1R6pIuVVKDMR6NGLdcHoMNsZbwk9489xYMTlMlt5fLkvkg/dsWiXOL2imR76FZSBde2xSQJBMeqv6gSzqN73nWb73nkoLedCiUU1asYRhj+pZ/ORtkS1GKcDKBRfP2hzg4FmBiHENHklEX6wBmG/TuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011911; c=relaxed/simple;
	bh=0Px7N72t/xCGV6WTir4btbb7CJJYtna6D9J54N5moag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJt9j6HzmQewT6YoCNI/LsmKv8CJEnojN4LMAPKoVg5tRj1bHzX8jf05hMLXDgXdx0nPaMRnEMDrwUnOAvwSPinj8HMaqYY2f5Wpcy6Hbyttpnlsp4A/x7HFrsuiDPl7K3SSEgmdxyWSHE9HAay4VYsy2pmoILMPBHznLlKNOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q7hUwEJ6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7hUwEJ6"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso6002089b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 16:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780011909; x=1780616709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oU42RlL/Ela7v6l++RyVgsWvdsc6WbwlwF0CF9Y43ls=;
        b=Q7hUwEJ6DXmaMate7eiHZKxMbdjBKx7KQllRdgWm1KLjcJ2qMGotzyf7WZulmoYUSv
         pPVCktJAvjWBQnl+yhgOFIfy+fYyYepleEVeiUSj6kpv0AxnQdPju513l+JppuV4SJFD
         RTNo1n5RVMOnASzyjmOI6Kf1zSuQifTnPKkbNPXcR9VzSivQQLT5kCfmAKUP8oVRUgFN
         NO2M+8BdaoL+AG0KtypAmqWJljdffugFZOj0z53srTjnvvTUA+Rak0Y1M75o1zjKhflw
         MKg8DiqgYYOgXV7SEyHXZOihzfkxK0NTuBQ736TzzwQ0R7eT6kguhpdKgnBiQp8vYJVX
         8lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780011909; x=1780616709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oU42RlL/Ela7v6l++RyVgsWvdsc6WbwlwF0CF9Y43ls=;
        b=HfqD4yKWW/QlV5SoCEhih8Af5supWbu2Xh75WXf2uzPhwidQXwTphHzESET8ODTQYg
         6nnsQYkFlS8CMHLfuW6wl3uv1oZ8TUuXbWOdO5ayl4q+/iu6ATZ0+0/nY+99vOam80lN
         GDwqRYB5F+l4v9ayvkrUplR2Naes3KfqSifFzwErXRLbR7kIM5wPUbEjRA8qY07MnUyK
         0rD8DD+gdgGOY+A2iedo8HEyHxXgfid8awKSvqOqUANfqbiBQkPGjZasQwWHXTq6h22C
         j6niNBdeprcbnfkEqSKI9v2flJLlIefirCCbOgG8m12tFEsxuYFzEwDZJ4blMvbj9jCV
         oLUA==
X-Forwarded-Encrypted: i=1; AFNElJ82ZO8NuQowX1cEF8jNK3SIFm/lnORqMRbL6vXwx9ZhRKx4uRcStOIhnO4IMu03CBN1Ag1+5WyR+Kz1PXyn+J2l@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1f2bevRKw+POQ0tYe/UTwau6JuEZC+mxqRycU+H5AB2FyC2Az
	jYMlHZfiqpocmYRmNOUnWSgKcG25fwP6YvpreXrZ0PiumkFB7DwazacaZ2YZRo9PC+B2Xnboy/R
	QHODrMA==
X-Received: from pfbhk4.prod.google.com ([2002:a05:6a00:8784:b0:842:bb5:c63a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4217:b0:837:a211:4ee2
 with SMTP id d2e1a72fcca58-84212d6ef4cmr310611b3a.38.1780011908958; Thu, 28
 May 2026 16:45:08 -0700 (PDT)
Date: Thu, 28 May 2026 16:44:55 -0700
In-Reply-To: <20260528234455.434027-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528234455.434027-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528234455.434027-3-ctshao@google.com>
Subject: [PATCH v2 2/2] perf jevents: Add IOMMU metrics for Intel
From: Chun-Tse Shao <ctshao@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Add IOMMU Translation Lookaside Buffer (TLB) and interrupt cache metrics
to perf jevents for Intel platforms. This enhances I/O performance
observability, allowing fleet-wide monitoring of IOMMU overhead.

These metrics are supported on platforms that expose the required uncore
IIO IOMMU events (such as Emerald Rapids and Granite Rapids). The Intel
implementation dynamically detects event availability at generation time.
It requires at least the TLB events to expose the metric group, while the
interrupt cache events are optional. This allows platforms like Emerald
Rapids, which lack IOMMU interrupt cache events, to still expose the
IOMMU TLB metrics.

The following metrics are added:
- iotlb_total_hit: Total IOTLB hits (4K, 2M, 1G pages).
- iotlb_total_miss: Total IOTLB misses.
- iotlb_miss_rate: IOTLB miss rate.
- iotlb_interrupt_cache_hit: Interrupt cache hits.
- iotlb_interrupt_cache_miss: Interrupt cache misses (calculated as
  lookup - hit, clamped to zero).
- iotlb_interrupt_cache_lookup: Interrupt cache lookups.
- iotlb_interrupt_cache_miss_rate: Interrupt cache miss rate.

Tested:
  # perf stat -M \
    iotlb_total_hit,iotlb_total_miss,iotlb_miss_rate \
    --per-socket --metric-only -a -j -- sleep 10
  {"socket" : "S0", "counters" : 10,
   "hits  iotlb_total_hit" : "3579249.0",
   "%  iotlb_miss_rate" : "0.0",
   "misses  iotlb_total_miss" : "3.0"}
  {"socket" : "S1", "counters" : 10,
   "hits  iotlb_total_hit" : "0.0",
   "%  iotlb_miss_rate" : "0.0",
   "misses  iotlb_total_miss" : "0.0"}

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

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

