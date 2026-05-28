Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E236F8F5
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011911; cv=none; b=PxUpFeJkB2i5e5bWn4K4pbkPHPw6j/l8cCW2eqzN5ub2DqDzXBCYkCu3jNBDLPw8ZfkJ8kG/ZmISkJgRyg2LBlu+SN0Uj5U1pJ85arUm/eRpFZgLlVxe4L0KhJ2XErrsMu/To0OdpteMXUNbaaMt/olWUnE3COPKr7q6G0x3bkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011911; c=relaxed/simple;
	bh=eVoCcjqI1Hkq1HXKcTcxTyL7IJsjmBfwE0lOHLdwCKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G79iU5EPdl2VXgwKgnG4rOEIlw/i54lvJizB6FrUxOr95FmyCJVx3vhGzNM+5/moWUiqatwVQnanPyEzGFjze/OW4x5h6I+1CqfcxkdUrxnIGcJLZHhYVbS3nDZoUKLrXeva2TjLzRX5BsFrc35I/MiuiI/htEHETzjt9vIf1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhBqFx8v; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhBqFx8v"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so15421320b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 16:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780011908; x=1780616708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEJ3gSEY3y0ujjZQDvgcj3V001E5epqXgJ35l3nvu+s=;
        b=LhBqFx8v4bR+Wdvt4VmtuzkJ99igI/kCL7mMAZxgaP/coqOZEuWBTBLCT7Z0JNY6a7
         QO8XcxMY2rXWqgGe9SB6vTDrRMyGFlKiBrwG+G/Uh88/NAVD9Fb9L1XC8AZ41drCdVYR
         Qb1oDPiI6F3yoe6UuhrWLxR6FPpEQuk0Oe9RkRGPo7vNJrJlT/IgFijf9Lz6librOWgy
         CEK3vOYUQyrtCaCWnQi7WI+zP/qUYlQd+wBZ6zvT/ruyPsfLgFtivXf2KPPFBrUwa+JT
         9ULW3G3Jf0JV0tAXWrlMXFyfRHJQJBpXUE2bbSB+hztYisBPJoG36240SfR7TnoaiwJn
         d/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780011908; x=1780616708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEJ3gSEY3y0ujjZQDvgcj3V001E5epqXgJ35l3nvu+s=;
        b=QjFDFT7boIKzUwaiRlnRLpIu+3iqKb01cA3ljWAwo/KHqCpIU4P90pbpD0m3Xu1lzi
         QtjUsKCdcs5BzIzT39sGcw7kOzlS17V3xzOwwwf0nObYCaHZatoCBshLXMEkHKkCOO6l
         T5c76Yztil3hHezxt4ulpECoACISavG5O1joStSpsgGmeMp4gYWS/fm8x7Uv+SN61ksW
         3eQSDIV6OJn6nIj5JSczWQociheP4Xi4cmHUA695/ho9qrgUR+ppo80Xjgxr0VHpn1LO
         MxsYPv81Rsk4dsIEYpOmKzOudYIlFtmOPKHKQtNN1xcEvQ6eEgFgYZRJ+bWJADC9trW1
         HsJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KLhD/WFURRmsA4rq4STsbOeLuFv3COEEbvJE6TLmNEGoMDncPPscTl49eqM/98ARt9HU7JM9izit2ttj2aflZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPDjLvWxR+UtJwKL8qjj6O2kT+i+eaFEAeVWYT8ZiF4n/mTld
	j82tuBeUElc7nyMwy52JH4RwaCgt/6pYFoZ4u6PpyaXQFAAm/G3gM6vWxDznmU1hhUhOANeAAE6
	VxesvRQ==
X-Received: from pfuu9.prod.google.com ([2002:a05:6a00:6f89:b0:83e:c835:edc])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4398:b0:82f:3828:a009
 with SMTP id d2e1a72fcca58-84212b9dd87mr325456b3a.3.1780011907702; Thu, 28
 May 2026 16:45:07 -0700 (PDT)
Date: Thu, 28 May 2026 16:44:54 -0700
In-Reply-To: <20260528234455.434027-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528234455.434027-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528234455.434027-2-ctshao@google.com>
Subject: [PATCH v2 1/2] perf jevents: Add IOMMU metrics for AMD
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
to perf jevents for AMD platforms. This enhances I/O performance
observability, allowing fleet-wide monitoring of IOMMU overhead.

These metrics are supported on Zen 2 and newer processors (Rome, Milan,
Genoa, Turin) and are implemented using the standard `amd_iommu` PMU
events. The implementation uses the existing `_zen_model` helper to
ensure these are only generated for Zen 2+. Note that the pde events on
AMD cover both 2M and 1G pages, so 1G pages are implicitly included in
the total hits/misses metrics (sum of pte and pde events).

The following metrics are added:
- iotlb_total_hit: Total IOTLB hits (4K, 2M, 1G pages).
- iotlb_total_miss: Total IOTLB misses.
- iotlb_miss_rate: IOTLB miss rate.
- iotlb_interrupt_cache_hit: Interrupt cache hits.
- iotlb_interrupt_cache_miss: Interrupt cache misses.
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
 tools/perf/pmu-events/amd_metrics.py | 57 ++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 971f6e7af1f8..dccfcacaf148 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -265,6 +265,62 @@ def AmdDtlb() -> Optional[MetricGroup]:
     ], description="Data TLB metrics")
 
 
+def AmdIotlb() -> Optional[MetricGroup]:
+    global _zen_model
+    if _zen_model < 2:
+        return None
+
+    # On AMD, the pde events cover both 2M and 1G pages.
+    total_hit = Event("amd_iommu/mem_iommu_tlb_pte_hit/") + Event(
+        "amd_iommu/mem_iommu_tlb_pde_hit/"
+    )
+    total_miss = Event("amd_iommu/mem_iommu_tlb_pte_mis/") + Event(
+        "amd_iommu/mem_iommu_tlb_pde_mis/"
+    )
+    miss_rate = d_ratio(total_miss, total_miss + total_hit)
+
+    interrupt_cache_hit = Event("amd_iommu/int_dte_hit/")
+    interrupt_cache_miss = Event("amd_iommu/int_dte_mis/")
+    interrupt_cache_lookup = interrupt_cache_hit + interrupt_cache_miss
+    interrupt_cache_miss_rate = d_ratio(
+        interrupt_cache_miss, interrupt_cache_miss + interrupt_cache_hit
+    )
+
+    return MetricGroup(
+        "iotlb",
+        [
+            Metric("iotlb_total_hit", "IOTLB total hit", total_hit, "hits"),
+            Metric("iotlb_total_miss", "IOTLB total miss", total_miss, "misses"),
+            Metric("iotlb_miss_rate", "IOTLB miss rate", miss_rate, "100%"),
+            Metric(
+                "iotlb_interrupt_cache_hit",
+                "IOTLB interrupt cache hit",
+                interrupt_cache_hit,
+                "hits",
+            ),
+            Metric(
+                "iotlb_interrupt_cache_miss",
+                "IOTLB interrupt cache miss",
+                interrupt_cache_miss,
+                "misses",
+            ),
+            Metric(
+                "iotlb_interrupt_cache_lookup",
+                "IOTLB interrupt cache lookup",
+                interrupt_cache_lookup,
+                "lookups",
+            ),
+            Metric(
+                "iotlb_interrupt_cache_miss_rate",
+                "IOTLB interrupt cache miss rate",
+                interrupt_cache_miss_rate,
+                "100%",
+            ),
+        ],
+        description="IOMMU TLB metrics",
+    )
+
+
 def AmdItlb():
     global _zen_model
     l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
@@ -473,6 +529,7 @@ def main() -> None:
         AmdBr(),
         AmdCtxSw(),
         AmdDtlb(),
+        AmdIotlb(),
         AmdItlb(),
         AmdLdSt(),
         AmdUpc(),
-- 
2.54.0.823.g6e5bcc1fc9-goog

