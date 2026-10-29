Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793300771;
	b=Bd1QH6+iIelOmk0+Z2s0i7OQSzsvRvL2QppAMwtJUlk1r+2gHVrCRuJ60i6a/hT4z8Xf
	 m27fwKL1512WBw47tig21oQaCJH0ngn3vCbfPA9NNTIzgtpHGQY5RVE5mnxYjMltgLZiu
	 9cNz/VIOm0c2e8SKuRClPeLltdBbQv4zyoESxGRpg1XvSGYvEONI4r1tlFx0cM5fb8oT3
	 jHBxgUw9yYsgezr8foLT31j1VYFZhfiYOe/67ELDnBostkq0dSkwsd9EuYpEuueiCnVAe
	 ytuJMKBSaWMbM1zhfBc43LC8pFOoclow3zXiMqQxLGEECc4PN1flbdY/ZXmta+te4/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300771;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PMb9kS7LsQRg2NkbqvbZ3pBQyQ2wS67IIwsfWZTsHx8=;
	b=dovChaXogi3xlT/ywxbS1lyzh0cX+auBaSITca0IFmZPZ3e0rPGuZw2+cbKnkO3taVyb
	 1TeayaIl5BLkJmdX9+ih9wIX0Q06j0YF4VLkaahqpv/lXAibMtFTR0GMZDF/VVzgXxsdA
	 atlhVkY4i4MsdWSFdqlGvAKodLsTt2Eqhde0MBap+HalvxDneByCXPA8CEUdlb2FYP7Ny
	 jJpiARtSSQKobP9dE6TmWakquIpf31SuZR63moCJcEMX/8YxmCECBZHlyypWqUtYPiJw/
	 1Hu8PTd9OED9RUL0yFaajPMvQv0vWzkF3teysRtzp9yr4RuejYNAk94RnGG+n/2yyqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVfC5CPh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60853606A321;
	Thu, 29 Oct 2026 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVfC5CPh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793300771;
	b=0X+AMNcyEGN+ubXVzYPx7n6S0dfAwYpBSSwN0imOjijFErYFfoq5ML16MFKuhNA5mIBh
	 1pqKrr80SFR4I+WwW2JeKeK0rjRj1oQ4ftXBog3SggPVH4p7Z0HsqU80qdQOdpsIdsw3q
	 TtLsi2tre1/dNegtm+5Pbiju/U7wfvw0534um/geunTrNR99qK4P0bWDRn8pyyDCQ1m5A
	 Nh5hy/Yc9IP/iFdaaQfDkheUIedtHAgnzMTZ2BSUblG9uDEpZCKemLYQ94W67odC6HrOQ
	 JLItffkooNEPjxsFjq9+Ie8YAv4JafK5aEWkEiWW17IpBQCrwPGSlA44MBKlBI4ywrA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793300771;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PMb9kS7LsQRg2NkbqvbZ3pBQyQ2wS67IIwsfWZTsHx8=;
	b=MBFLHDmMvjTNH5C2K9t6wX/3qwb/YFZvxL8MyvX3x2Xg2C1AWSRESFCeKBgY+dHt+IvA
	 XL+mfPG/gQsy2yaYJ+hQGzxZo/PsU6Agw9BbHaRlaX0NQg/9ydkOPsgf5D57ntZmKbT2l
	 zZ5dhdZ/tfY76M/0X2u+YEQy+2J4YfmPZHAQy4J1gQaaDe71S8tK/KcPk1VWcmmuzCX9a
	 GM2Xs44CG+nIqTzr5djHCGO05/bVb55RGgAfRddGj88QUZOafs34+h8nBNw3xQHtZL7gP
	 18FO4WdfEKB2XtHoYsMQIcEHqi51g8ymBXQsJQ3ObLIxPmEun/P6yuLQkjhux5JpK5Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5E7091F01825;
	Thu, 29 Oct 2026 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793300771;
	bh=PMb9kS7LsQRg2NkbqvbZ3pBQyQ2wS67IIwsfWZTsHx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HVfC5CPhhauVX00V7EtR4dmGF60Tmi+gOBurqV6q5Vl9HapRuz/tW9qM+UulDxl9D
	 t0S6qyg51buAB0ip2nT8GupUb+qErQV/UQlRB8Zn5W7Y4w4czuDzgEABK+yHB/SfdR
	 y3d8mno5xONVloEoE/5v6mBtM2FM8Z8l6ZCnlJz6U8cQfJUwtK94wZ/awRlZ7QAnUU
	 aW7RsTiZHAH56+uhxF0IKs+NX8Ut2XRRHJPg/EJofXbT787AnYRheuvisWU+s4Yn7o
	 q5HgBnP4ZRxnH7s2yw1tCuu+vf3iu+D2rPwYxpJkV+Xfr5C10TpMiWNn1b4vzshQu/
	 4gdhTHe744z8g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D882445968;
	Thu, 29 Oct 2026 19:06:09 +0000 (UTC)
From: Jacob Lefkowitz via B4 Relay <devnull+jlefkowi.akamai.com@kernel.org>
Date: Thu, 29 Oct 2026 19:05:50 +0000
Subject: [PATCH 1/2] perf jevents: add iommu page table walk metrics
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-perf-tools-next-v1-1-a75a2b64a15e@akamai.com>
References: <20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com>
In-Reply-To: <20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Chaney <bchaney@akamai.com>, Matt Pelland <mpelland@akamai.com>, 
 Jacob Lefkowitz <jlefkowi@akamai.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3881;
 i=jlefkowi@akamai.com; h=from:subject:message-id;
 bh=vi12b5KTiVUT3//EtfmECCInovAIRPbBmoFjz6jP4xo=;
 b=owEBbQKS/ZANAwAKAdLKfgzjwTS1AcsmYgBq45kgbws/mkXO7RgLc1YXyZDQ6ZoM3ruOiFqpK
 FU0D2DafAiJAjMEAAEKAB0WIQQKFmVpIhg7hFI7scTSyn4M48E0tQUCauOZIAAKCRDSyn4M48E0
 tTJ7D/9LxuJke4JN3hiFOgiGe2IBY3C7fO48/Dqk219DTUzc602LXw7LUyNfG7AC06nOQugBwSc
 447fdJ+RhZ3k5voqJI+hubB97tEwVsjH1cxEcTkLZTJSh4qcfJM0lzQLoIZwzjVPXLeclUwgqBo
 9ue8SVTvaFQ8S2TKR/Ll4W6F9FwPsixvkqbeFNUo4QJ8jCTXfkYPunVLXyZRZAXFPrxTTCLFf5S
 f0O+YFGFDPa/QB8c4nRReWSS91nR04gVWC5EbhzxIS3xkzIaURPqSnt2rP7B97TT3dWFLftWqCG
 V0lECv0s9QlVWraWW8VDDu9YzpLLvcBPJUU/dx9NFRfT2MtR42qVPA6qMRXKID9F3xHw37PVrxo
 bTKvjdB+bPfV/AoRvoePekpfYqyjs0hCp0kzWi12EwUoOVgfOrhdcrPvjM3nAGeVXnkwP+xsKvm
 DHbdJ2Ot0kDxkR6Iw29af/oFw0Q7kI7a++MqcB1t43zfzZmeHWL9+KOkPUgYfMjsSLZlsRVO+dc
 j7/4zgVeD07vk0N3pnmkQdCj3VCUqDCD4WlJq7wzJm7p/xVDHsVIDwlLEDSOB7eSpIRuYmqDMK6
 dFwGZtqlvogt2AKUQ9Imw9EyZhNHqrRph6otyNhv5o96d5/s7QdjkjcyJj5v7EGUGemZ98c2JZi
 18ZQcmHirBqALTA==
X-Developer-Key: i=jlefkowi@akamai.com; a=openpgp;
 fpr=0A16656922183B84523BB1C4D2CA7E0CE3C134B5
X-Endpoint-Received: by B4 Relay for jlefkowi@akamai.com/default with
 auth_id=1357
X-Original-From: Jacob Lefkowitz <jlefkowi@akamai.com>
Reply-To: jlefkowi@akamai.com
Content-Transfer-Encoding: 7bit

From: Jacob Lefkowitz <jlefkowi@akamai.com>

Adds page table walk metrics specfically to perf jevents for AMD
platforms to enhance observability into IOMMU overhead. The metrics
are supported on Zen 2 and neweer processors. They are implemented
using the amd_iommu PMU events.

The list of metrics added here are:
- lpm_iommu_ptw_reads_per_tlb_miss
- lpm_iommu_ptw_nested_read_ratio
- lpm_iommu_ptw_guest_read_ratio
- lpm_iommu_trans_per_sec

The changes here have been tested with 'sleep 10' as the workload:

perf stat -M iommuptw --per-socket --metric-only -j -a -- sleep 10
{"socket" : "S0", "counters" : 8,
"reads/tlb_miss lpm_iommu_ptw_reads_per_tlb_miss" : "0.5",
"%  lpm_iommu_ptw_nested_read_ratio" : "100.0",
"%  lpm_iommu_ptw_guest_read_ratio" : "0.0",
"trans/s  lpm_iommu_trans_per_sec" : "971.5"}
{"socket" : "S1", "counters" : 0,
"reads/tlb_miss  lpm_iommu_ptw_reads_per_tlb_miss" : "none",
"%  lpm_iommu_ptw_nested_read_ratio" : "100.0",
"%  lpm_iommu_ptw_guest_read_ratio" : "100.0",
"trans/s  lpm_iommu_trans_per_sec" : "none"}

Signed-off-by: Jacob Lefkowitz <jlefkowi@akamai.com>
---
 tools/perf/pmu-events/amd_metrics.py | 49 +++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 42569b9153f4..dcffd6e268fa 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -5,7 +5,7 @@ import math
 import os
 from typing import Optional, Union
 from common_metrics import Cycles
-from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+from metric import (d_ratio, has_event, max, min, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
                     Metric, MetricGroup, Select)
 
@@ -318,6 +318,52 @@ def AmdIotlb() -> Optional[MetricGroup]:
     )
 
 
+def AmdIommuptw() -> Optional[MetricGroup]:
+    global _zen_model
+
+    if _zen_model < 2:
+        return None
+
+    walks = Event("amd_iommu/mem_iommu_tlb_pte_mis/") + Event(
+        "amd_iommu/mem_iommu_tlb_pde_mis/"
+    )
+    pt_rd = Event("amd_iommu/page_tbl_read_tot/")
+    pt_rd_nst = Event("amd_iommu/page_tbl_read_nst/")
+    pt_rd_gst = Event("amd_iommu/page_tbl_read_gst/")
+    trans = Event("amd_iommu/mem_trans_total/")
+
+    return MetricGroup(
+        "iommuptw",
+        [
+            Metric(
+                "lpm_iommu_ptw_reads_per_tlb_miss",
+                "Average IOMMU page table reads per IOTLB miss",
+                d_ratio(pt_rd, walks),
+                "reads/tlb_miss"
+            ),
+            Metric(
+                "lpm_iommu_ptw_nested_read_ratio",
+                "Share of IOMMU page table reads from nested (host) tables", # 0 without nested translation
+                min(d_ratio(pt_rd_nst, pt_rd), 1),
+                "100%"
+            ),
+            Metric(
+                "lpm_iommu_ptw_guest_read_ratio",
+                "Share of IOMMU page table reads from guest tables", # 0 without nested translation
+                min(d_ratio(pt_rd_gst, pt_rd), 1),
+                "100%"
+            ),
+            Metric(
+                "lpm_iommu_trans_per_sec",
+                "IOMMU translation requests per second",
+                d_ratio(trans, interval_sec),
+                "trans/s"
+            )
+        ],
+        description="IOMMU page table walk metrics"
+    )
+
+
 def AmdItlb():
     l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
     l2m = Event("bp_l1_tlb_miss_l2_tlb_miss.all", "l2_itlb_misses",)
@@ -526,6 +572,7 @@ def main() -> None:
         AmdCtxSw(),
         AmdDtlb(),
         AmdIotlb(),
+        AmdIommuptw(),
         AmdItlb(),
         AmdLdSt(),
         AmdUpc(),

-- 
2.53.0


