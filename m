Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6B495504
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061661; cv=none; b=EtbpojBWbXqUL8wrEKe/ByEO8JrTpNjIv/sEqXz0Gs5Tr0ELyVuLZtrvDIzp1bPatYOBJVbSrpsMEe7pktK+idYJSico49uK6cjRpIcMD90u56pDYXdjjUswgmCsINia1mQ9WWr8KNdPrM7JVNog2Sdp+LJ4ibTt2F31nZZSbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061661; c=relaxed/simple;
	bh=huIPr91a1QZIVeaXEgXb71bIb//F3Jf8Er6hax0ZbNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OB0BU+5IfF870hlNjVgYBtOA96BTeMPSsPXW9HCrUFuCFkv9W9AnJKx+dHzb0F2pA3Wc2PVpiDB2c9IHrGHLWxjwR5XBCGUIYTtBO8J9TOHMkmVYuHaZn6BXkdXKJEkO4f+YUpM/EQQRr560AJ4IX7SJ4kaNHheoQfts7pQ+4zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNg8KAUA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNg8KAUA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so7069164a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784061654; x=1784666454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0WEdU2YFPU8k+NPNB4dI0f/FFapgokOdQDNHDiZfBhU=;
        b=dNg8KAUAL+IZEbHpQAPu3bTxPR1cR7c7GIAc5O72+aIWdt6968ZtJ8mrLRqw0QbEYU
         xdG7BsJUPwCm8uPQF7vPGcUuItqR8ZHDTqitZjzlEtRgA8urejPfMkqTVsnjqfTeMWY0
         m2Esc6/E1NVxh+lnWiGJ2D1MKyoq4qHdstAGJt7Ocz/rvRwjuu4BvIwtZCj+JWPz+YhL
         TrGZpT6IN2fxcNNYaagu+MRB/pZ9oCyiflafwZ8MNakraB8Ue0+HfXtLdTTZFz3s0XGv
         qTyRy49Gl0EszcdBgoUINrp/oBsouJJJodqN9SW3D8kvfbfPiiA+a3VDyZiN9cHWx7wo
         GPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061654; x=1784666454;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0WEdU2YFPU8k+NPNB4dI0f/FFapgokOdQDNHDiZfBhU=;
        b=caTlP1qthIbwTwz1nG0LP9q2Y63Ruqsr5mAgcO2MYygek6EtVCjch/JhsvXUxLmE0Z
         eucDrKcSB7mvZ5exAiss4jMgfORcIvaN8UIkO1KX9FAqEmlFnu4tBY+6wDPW/BS2F6kQ
         RQmQmuMDIhj/V3Xux/PYI10/f9FDjwkUfVnW02nGEV3zHqtVKqyX8STpX+ILZmR0hfYB
         SL1RY5N2Vxw6aDzXaJpk9TiQK60rhb80SZAiHdXv0H7+/UldLicb2GFVw3D93IdqXxLb
         MYjt0JFZ3TPn6D+xR91jyMY93wdjZlTPFhQCKTotgvS0jh6+ouQSrr7nomYkMdm9JUtc
         uKbw==
X-Forwarded-Encrypted: i=1; AHgh+RpQ/coZ4gsi7CQAMLVLS+zAjLiQlTZ4YnMoYh2PuiJa2R+VTcAcGuZrNFX7NDzuuXIMTN/amLNW6oaoacgglH3i@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzop82Do5d/V0H8uQJcWaSX4D3+eYFPQvKNmDnw9mzlY0UYPC
	ef9oRpPvXjszgLNCCw0Bh00FT6rdS76ELme/rHCtkLARXqodOK56FNAYOLTeIsTAQ721WxlQsjc
	RCGby7w==
X-Received: from pfcg17.prod.google.com ([2002:a05:6a00:23d1:b0:847:9af3:417e])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c090:b0:84a:6528:81c5
 with SMTP id d2e1a72fcca58-84a6528858amr254253b3a.17.1784061653679; Tue, 14
 Jul 2026 13:40:53 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:39 -0700
In-Reply-To: <20260714204044.1952031-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714204044.1952031-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714204044.1952031-9-ctshao@google.com>
Subject: [PATCH v2 08/12] perf vendor events intel: Update meteorlake events
 from 1.21 to 1.22
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/704ef43e4c0738065a0575622cf7d31867b=
8d48b

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 11 ++-
 .../arch/x86/meteorlake/metricgroups.json     |  2 +-
 .../arch/x86/meteorlake/mtl-metrics.json      | 88 ++++++++++---------
 .../arch/x86/meteorlake/pipeline.json         |  4 +-
 .../arch/x86/meteorlake/uncore-memory.json    | 84 +++++++++++++++---
 6 files changed, 131 insertions(+), 60 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 68f1ae4c0aae..a15cd3280993 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.26,lunarlake,core
-GenuineIntel-6-(AA|AC|B5),v1.21,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.22,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-(CC|D5),v1.06,pantherlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index 6419bc36f249..c2d351efa9d6 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "Counts the number of request that were not ac=
cepted into the L2Q because the L2Q is FULL.",
+        "BriefDescription": "Counts the number of requests that were not a=
ccepted into the L2Q because the L2Q is FULL.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ANY",
@@ -631,6 +631,15 @@
         "UMask": "0x50",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the caches, a s=
noop was required, and hits in other core or module on the same die. Anothe=
r core provides the data with a FWD, NO_FWD, or HITM. If the core has acces=
s to an L3 cache, an LLC miss refers to an L3 cache miss, otherwise it is a=
n L2 cache miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS_OTHERMOD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled to a store buffer full condition",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json b/=
tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
index 855585fe6fae..9acbda612c25 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
@@ -93,7 +93,6 @@
     "tma_code_stlb_miss_group": "Metrics contributing to tma_code_stlb_mis=
s category",
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
@@ -129,6 +128,7 @@
     "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
     "tma_l2_bound_group": "Metrics contributing to tma_l2_bound category",
     "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category",
+    "tma_l3_miss_bound_group": "Metrics contributing to tma_l3_miss_bound =
category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
     "tma_load_op_utilization_group": "Metrics contributing to tma_load_op_=
utilization category",
     "tma_load_stlb_miss_group": "Metrics contributing to tma_load_stlb_mis=
s category",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json b/t=
ools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
index 948c16a1f95b..a23691052237 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
@@ -797,16 +797,16 @@
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)=
))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_me=
mory_bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_l3_miss_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_acces=
ses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bo=
und * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_=
miss_bound + tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_ful=
l + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_st=
ore_fwd_blk)))",
         "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_bottleneck_data_cache_memory_bandwidth",
         "MetricThreshold": "tma_bottleneck_data_cache_memory_bandwidth > 2=
0",
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_uc_bound",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound =
+ tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependen=
cy + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_=
bound * (tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma=
_l3_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_fb=
_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tm=
a_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_split_l=
oads / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_=
latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_s=
tore_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sharin=
g + tma_split_stores + tma_store_latency + tma_streaming_stores)) + tma_mem=
ory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_boun=
d + tma_l3_bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb_store=
 + tma_false_sharing + tma_split_stores + tma_store_latency + tma_streaming=
_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memo=
ry_bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tm=
a_l3_miss_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_=
accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memo=
ry_bound * tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma=
_l3_miss_bound + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd)) * (tma_l1_latency_dependency / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)=
) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l=
3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_lock_latency / (tma_=
dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency + tm=
a_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (t=
ma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_b=
ound)) * (tma_split_loads / (tma_dtlb_load + tma_fb_full + tma_l1_latency_d=
ependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_=
memory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_l3_miss_bound + tma_store_bound)) * (tma_split_stores / (tma_dtlb_=
store + tma_false_sharing + tma_split_stores + tma_store_latency + tma_stre=
aming_stores)) + tma_memory_bound * (tma_store_bound / (tma_l1_bound + tma_=
l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_stor=
e_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_st=
ore_latency + tma_streaming_stores)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_bottleneck_data_cache_memory_latency",
         "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
@@ -832,7 +832,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + =
tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound=
 * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l=
3_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma_false=
_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) =
* (tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency=
 + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bo=
und * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_=
l3_miss_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma=
_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_store=
s)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -841,7 +841,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_stores =
+ tma_store_latency + tma_streaming_stores - tma_store_latency)) + tma_mach=
ine_clears * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound) *=
 (tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tm=
a_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd) * tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_s=
tores + tma_store_latency + tma_streaming_stores - tma_store_latency)) + tm=
a_machine_clears * (1 - tma_other_nukes / tma_other_nukes))",
         "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
         "MetricName": "tma_bottleneck_memory_synchronization",
         "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
@@ -989,7 +989,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by non-taken conditional bran=
ches.",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_NTAKEN_COST@ * cpu_co=
re@BR_MISP_RETIRED.COND_NTAKEN_COST@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_NTAKEN@ / cpu_core@BR=
_MISP_RETIRED.ALL_BRANCHES@ * tma_branch_mispredicts",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_cond_nt_mispredicts",
         "MetricThreshold": "tma_cond_nt_mispredicts > 0.05 & (tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -998,7 +998,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by taken conditional branches.",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_TAKEN_COST@ * cpu_cor=
e@BR_MISP_RETIRED.COND_TAKEN_COST@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_TAKEN@ / cpu_core@BR_=
MISP_RETIRED.ALL_BRANCHES@ * tma_branch_mispredicts",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_cond_tk_mispredicts",
         "MetricThreshold": "tma_cond_tk_mispredicts > 0.05 & (tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -1027,13 +1027,13 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to L3 data-sharing=
 accesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ * mi=
n(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@R, 24 * tma_info_system_core=
_frequency) + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * min(cpu_core@MEM=
_LOAD_L3_HIT_RETIRED.XSNP_FWD@R, 24 * tma_info_system_core_frequency) * (1 =
- cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAND_DAT=
A_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH=
_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIR=
ED.L1_MISS@ / 2) / tma_info_thread_clks",
         "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_synch=
ronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears, =
tma_remote_cache",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to L3 data-sharin=
g accesses. Data shared by multiple Logical Processors (even just read shar=
ed) may cause increased access latency due to cache coherency. Excessive da=
ta sharing can drastically harm multithreaded performance. Sample with: MEM=
_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_sy=
nchronization, tma_contested_accesses, tma_false_sharing, tma_machine_clear=
s, tma_remote_cache",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1057,16 +1057,6 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricExpr": "cpu_core@MEMORY_ACTIVITY.STALLS_L3_MISS@ / tma_info=
_thread_clks",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
-        "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
         "MetricExpr": "(cpu_core@IDQ.DSB_CYCLES_ANY@ - cpu_core@IDQ.DSB_CY=
CLES_OK@) / tma_info_core_core_clks / 2",
@@ -1123,7 +1113,7 @@
         "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_data_cache_memory_bandwi=
dth, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store=
_latency, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_data_cache_memory_bandwi=
dth, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store=
_latency, tma_streaming_stores, tma_uc_bound",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1273,7 +1263,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect CALL instructions=
.",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.INDIRECT_CALL_COST@ * cpu_=
core@BR_MISP_RETIRED.INDIRECT_CALL_COST@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.INDIRECT_CALL@ / cpu_core@=
BR_MISP_RETIRED.ALL_BRANCHES@ * tma_branch_mispredicts",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ind_call_mispredicts",
         "MetricThreshold": "tma_ind_call_mispredicts > 0.05 & (tma_branch_=
mispredicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -1282,7 +1272,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect JMP instructions.=
",
-        "MetricExpr": "max((cpu_core@BR_MISP_RETIRED.INDIRECT_COST@ * cpu_=
core@BR_MISP_RETIRED.INDIRECT_COST@R - cpu_core@BR_MISP_RETIRED.INDIRECT_CA=
LL_COST@ * cpu_core@BR_MISP_RETIRED.INDIRECT_CALL_COST@R) / tma_info_thread=
_clks, 0)",
+        "MetricExpr": "max((cpu_core@BR_MISP_RETIRED.INDIRECT@ - cpu_core@=
BR_MISP_RETIRED.INDIRECT_CALL@) / cpu_core@BR_MISP_RETIRED.ALL_BRANCHES@ * =
tma_branch_mispredicts, 0)",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ind_jump_mispredicts",
         "MetricThreshold": "tma_ind_jump_mispredicts > 0.05 & (tma_branch_=
mispredicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -1459,7 +1449,7 @@
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "cpu_core@IDQ.DSB_UOPS@ / cpu_core@UOPS_ISSUED.ANY@"=
,
+        "MetricExpr": "cpu_core@IDQ.DSB_UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + =
cpu_core@LSD.UOPS@ + cpu_core@IDQ.MITE_UOPS@ + cpu_core@IDQ.MS_UOPS@)",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_frontend_dsb_coverage",
         "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 6 > 0.35",
@@ -1526,7 +1516,7 @@
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
-        "MetricExpr": "cpu_core@LSD.UOPS@ / cpu_core@UOPS_ISSUED.ANY@",
+        "MetricExpr": "cpu_core@LSD.UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_=
core@LSD.UOPS@ + cpu_core@IDQ.MITE_UOPS@ + cpu_core@IDQ.MS_UOPS@)",
         "MetricGroup": "Fed;LSD",
         "MetricName": "tma_info_frontend_lsd_coverage",
         "Unit": "cpu_core"
@@ -1685,6 +1675,15 @@
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "AVX preserve/restore assists per kilo instruc=
tion",
+        "MetricExpr": "1e3 * cpu_core@ASSISTS.SSE_AVX_MIX@ / cpu_core@INST=
_RETIRED.ANY@",
+        "MetricGroup": "tma_issueMV",
+        "MetricName": "tma_info_inst_mix_vectormixpki",
+        "MetricThreshold": "tma_info_inst_mix_vectormixpki > 0.05",
+        "PublicDescription": "AVX preserve/restore assists per kilo instru=
ction. Related metrics: tma_mixing_vectors, tma_ms_switches",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "tma_info_memory_l1d_cache_fill_bw",
@@ -1922,7 +1921,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Mem;Backend;CacheHits",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per physical core",
         "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute",
@@ -2004,10 +2003,10 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_HAC_ARB_TRK_REQUESTS.ALL + UNC_HAC_ARB_CO=
H_TRK_REQUESTS.ALL) / 1e9 / tma_info_system_time",
+        "MetricExpr": "32 * UNC_M_TOTAL_DATA / 1e9 / tma_info_system_time"=
,
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_data_cache_memor=
y_bandwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_data_cache_memor=
y_bandwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full, tma_uc_bound",
         "Unit": "cpu_core"
     },
     {
@@ -2093,13 +2092,6 @@
         "MetricName": "tma_info_system_turbo_utilization",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "Measured Average Uncore Frequency for the SoC=
 [GHz]",
-        "MetricExpr": "tma_info_system_socket_clks / 1e9 / tma_info_system=
_time",
-        "MetricGroup": "SoC",
-        "MetricName": "tma_info_system_uncore_frequency",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD@",
@@ -2268,6 +2260,16 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricExpr": "cpu_core@MEMORY_ACTIVITY.STALLS_L3_MISS@ / tma_info=
_thread_clks",
+        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_grou=
p;tma_memory_bound_group",
+        "MetricName": "tma_l3_miss_bound",
+        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound > =
0.2 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
         "MetricExpr": "cpu_core@DECODE.LCP@ / tma_info_thread_clks",
@@ -2379,19 +2381,19 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
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
counters for that). Related metrics: tma_bottleneck_data_cache_memory_bandw=
idth, tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
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
counters for that). Related metrics: tma_bottleneck_data_cache_memory_bandw=
idth, tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full, tma_uc_bound",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory - DRA=
M ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_thread_clks - tm=
a_mem_bandwidth",
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
). Related metrics: tma_bottleneck_data_cache_memory_latency, tma_l3_hit_la=
tency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2461,7 +2463,7 @@
         "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
         "MetricName": "tma_mixing_vectors",
         "MetricThreshold": "tma_mixing_vectors > 0.05",
-        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued -- the Count =
Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investiga=
ting. Read more in Appendix B1 of the Optimizations Guide for this topic. R=
elated metrics: tma_ms_switches",
+        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued -- the Count =
Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investiga=
ting. Read more in Appendix B1 of the Optimizations Guide for this topic. R=
elated metrics: tma_info_inst_mix_vectormixpki, tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2480,7 +2482,7 @@
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
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_bottleneck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_mac=
hine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_o=
peration",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_bottleneck_irregular_overhead, tma_clears_resteers, tma_info_inst_mix_vec=
tormixpki, tma_l1_bound, tma_machine_clears, tma_microcode_sequencer, tma_m=
ixing_vectors, tma_serializing_operation",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2628,7 +2630,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by (indirect) RET instruction=
s.",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.RET_COST@ * cpu_core@BR_MI=
SP_RETIRED.RET_COST@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.RET@ / cpu_core@BR_MISP_RE=
TIRED.ALL_BRANCHES@ * tma_branch_mispredicts",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ret_mispredicts",
         "MetricThreshold": "tma_ret_mispredicts > 0.05 & (tma_branch_mispr=
edicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -2703,7 +2705,7 @@
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_data_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, =
tma_mem_bandwidth",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_data_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, =
tma_mem_bandwidth, tma_uc_bound",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index 09e1147c4733..6cd1b1659ec7 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -909,7 +909,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary run to run and not match the architectural =
number of iterations (specified by RCX)",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1443,7 +1443,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number issue slots not consumed  d=
ue to a  color request for an FCW or MXCSR control register when all 4 colo=
rs (copies) are already in use.",
+        "BriefDescription": "Counts the number of issue slots not consumed=
 due to a color request for an FCW or MXCSR control register when all 4 col=
ors (copies) are already in use.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x75",
         "EventName": "SERIALIZATION.COLOR_STALLS",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/meteorlake/uncore-memory.json
index ceb8839f0767..60bf390198d6 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/uncore-memory.json
@@ -1,61 +1,61 @@
 [
     {
-        "BriefDescription": "Counts every CAS read command sent from the M=
emory Controller 0 to DRAM (sum of all channels).",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to UNC_M_MC0_RDCAS_COUNT_FREERUN]",
         "Counter": "0",
+        "Deprecated": "1",
         "EventCode": "0xff",
         "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "Counts every CAS read command sent from the =
Memory Controller 0 to DRAM (sum of all channels). Each CAS commands can be=
 for 32B or 64B of data.",
         "UMask": "0x20",
         "Unit": "imc_free_running_0"
     },
     {
-        "BriefDescription": "Counts every read and write request entering =
the Memory Controller 0.",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to UNC_M_MC0_TOTAL_REQCOUNT_FREERUN]",
         "Counter": "2",
+        "Deprecated": "1",
         "EventCode": "0xff",
         "EventName": "UNC_MC0_TOTAL_REQCOUNT_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "Counts every read and write request entering=
 the Memory Controller 0 (sum of all channels). All requests are counted as=
 one, whether they are 32B or 64B Read/Write or partial/full line writes. S=
ome write requests to the same address may merge to a single write command =
to DRAM. Therefore, the total request count may be higher than total DRAM B=
W.",
         "UMask": "0x10",
         "Unit": "imc_free_running_0"
     },
     {
-        "BriefDescription": "Counts every CAS write command sent from the =
Memory Controller 0 to DRAM (sum of all channels).",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to UNC_M_MC0_WRCAS_COUNT_FREERUN]",
         "Counter": "1",
+        "Deprecated": "1",
         "EventCode": "0xff",
         "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "Counts every CAS write command sent from the=
 Memory Controller 0 to DRAM (sum of all channels).  Each CAS commands can =
be for 32B or 64B of data.",
         "UMask": "0x30",
         "Unit": "imc_free_running_0"
     },
     {
-        "BriefDescription": "Counts every CAS read command sent from the M=
emory Controller 1 to DRAM (sum of all channels).",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to UNC_M_MC1_RDCAS_COUNT_FREERUN]",
         "Counter": "3",
+        "Deprecated": "1",
         "EventCode": "0xff",
         "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "Counts every CAS read command sent from the =
Memory Controller 1 to DRAM (sum of all channels). Each CAS commands can be=
 for 32B or 64B of data.",
         "UMask": "0x20",
         "Unit": "imc_free_running_1"
     },
     {
-        "BriefDescription": "Counts every read and write request entering =
the Memory Controller 1.",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to UNC_M_MC1_TOTAL_REQCOUNT_FREERUN]",
         "Counter": "5",
+        "Deprecated": "1",
         "EventCode": "0xff",
         "EventName": "UNC_MC1_TOTAL_REQCOUNT_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "Counts every read and write request entering=
 the Memory Controller 1 (sum of all channels). All requests are counted as=
 one, whether they are 32B or 64B Read/Write or partial/full line writes. S=
ome write requests to the same address may merge to a single write command =
to DRAM. Therefore, the total request count may be higher than total DRAM B=
W.",
         "UMask": "0x10",
         "Unit": "imc_free_running_1"
     },
     {
-        "BriefDescription": "Counts every CAS write command sent from the =
Memory Controller 1 to DRAM (sum of all channels).",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to UNC_M_MC1_WRCAS_COUNT_FREERUN]",
         "Counter": "4",
+        "Deprecated": "1",
         "EventCode": "0xff",
         "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "Counts every CAS write command sent from the=
 Memory Controller 1 to DRAM (sum of all channels).  Each CAS commands can =
be for 32B or 64B of data.",
         "UMask": "0x30",
         "Unit": "imc_free_running_1"
     },
@@ -117,6 +117,66 @@
         "PerPkg": "1",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Counts every CAS read command sent from the M=
emory Controller 0 to DRAM (sum of all channels). [This event is alias to U=
NC_MC0_RDCAS_COUNT_FREERUN]",
+        "Counter": "0",
+        "EventCode": "0xff",
+        "EventName": "UNC_M_MC0_RDCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts every CAS read command sent from the =
Memory Controller 0 to DRAM (sum of all channels). Each CAS commands can be=
 for 32B or 64B of data. [This event is alias to UNC_MC0_RDCAS_COUNT_FREERU=
N]",
+        "UMask": "0x20",
+        "Unit": "imc_free_running_0"
+    },
+    {
+        "BriefDescription": "Counts every read and write request entering =
the Memory Controller 0. [This event is alias to UNC_MC0_TOTAL_REQCOUNT_FRE=
ERUN]",
+        "Counter": "2",
+        "EventCode": "0xff",
+        "EventName": "UNC_M_MC0_TOTAL_REQCOUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts every read and write request entering=
 the Memory Controller 0 (sum of all channels). All requests are counted as=
 one, whether they are 32B or 64B Read/Write or partial/full line writes. S=
ome write requests to the same address may merge to a single write command =
to DRAM. Therefore, the total request count may be higher than total DRAM B=
W. [This event is alias to UNC_MC0_TOTAL_REQCOUNT_FREERUN]",
+        "UMask": "0x10",
+        "Unit": "imc_free_running_0"
+    },
+    {
+        "BriefDescription": "Counts every CAS write command sent from the =
Memory Controller 0 to DRAM (sum of all channels). [This event is alias to =
UNC_MC0_WRCAS_COUNT_FREERUN]",
+        "Counter": "1",
+        "EventCode": "0xff",
+        "EventName": "UNC_M_MC0_WRCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts every CAS write command sent from the=
 Memory Controller 0 to DRAM (sum of all channels).  Each CAS commands can =
be for 32B or 64B of data. [This event is alias to UNC_MC0_WRCAS_COUNT_FREE=
RUN]",
+        "UMask": "0x30",
+        "Unit": "imc_free_running_0"
+    },
+    {
+        "BriefDescription": "Counts every CAS read command sent from the M=
emory Controller 1 to DRAM (sum of all channels). [This event is alias to U=
NC_MC1_RDCAS_COUNT_FREERUN]",
+        "Counter": "3",
+        "EventCode": "0xff",
+        "EventName": "UNC_M_MC1_RDCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts every CAS read command sent from the =
Memory Controller 1 to DRAM (sum of all channels). Each CAS commands can be=
 for 32B or 64B of data. [This event is alias to UNC_MC1_RDCAS_COUNT_FREERU=
N]",
+        "UMask": "0x20",
+        "Unit": "imc_free_running_1"
+    },
+    {
+        "BriefDescription": "Counts every read and write request entering =
the Memory Controller 1. [This event is alias to UNC_MC1_TOTAL_REQCOUNT_FRE=
ERUN]",
+        "Counter": "5",
+        "EventCode": "0xff",
+        "EventName": "UNC_M_MC1_TOTAL_REQCOUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts every read and write request entering=
 the Memory Controller 1 (sum of all channels). All requests are counted as=
 one, whether they are 32B or 64B Read/Write or partial/full line writes. S=
ome write requests to the same address may merge to a single write command =
to DRAM. Therefore, the total request count may be higher than total DRAM B=
W. [This event is alias to UNC_MC1_TOTAL_REQCOUNT_FREERUN]",
+        "UMask": "0x10",
+        "Unit": "imc_free_running_1"
+    },
+    {
+        "BriefDescription": "Counts every CAS write command sent from the =
Memory Controller 1 to DRAM (sum of all channels). [This event is alias to =
UNC_MC1_WRCAS_COUNT_FREERUN]",
+        "Counter": "4",
+        "EventCode": "0xff",
+        "EventName": "UNC_M_MC1_WRCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts every CAS write command sent from the=
 Memory Controller 1 to DRAM (sum of all channels).  Each CAS commands can =
be for 32B or 64B of data. [This event is alias to UNC_MC1_WRCAS_COUNT_FREE=
RUN]",
+        "UMask": "0x30",
+        "Unit": "imc_free_running_1"
+    },
     {
         "BriefDescription": "PRE command sent to DRAM due to page table id=
le timer expiration",
         "Counter": "0,1,2,3,4",
--=20
2.55.0.141.g00534a21ce-goog

