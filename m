Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3977433041
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061654; cv=none; b=EZ/yxKwsIXFU3iss2pxeGoAyipIb9fUmHrx4Bd4U236A+N9i3nn+gpNXZR7hAolstxyaYmFUxPPWEN42DoFJnFsFjMGsBRd6sf9Z+hEzh5H0DFvbTuRuMnlTxIrpNhO9vUJy+0huyfXigFgmhHAHwNZU2QvbirLR3Yq/iSFkHr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061654; c=relaxed/simple;
	bh=YKWekgxGFGWhlhvMVugY581uVx7X8/IlSaKvr3IMnTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nDA8FwvZK/pDPPKLm/Stt343RCIft/paYPKk24wlG2YM8hjI/abGszpjWd1IP2bQltjgtW5OB7Mstw/ud3pd7qixooFx7BiNB0wEMt8g3910E9Md7Ubvqz1SVwTW9xz1mBnrBrOzAp7bzYc68WL17q/3K62LaYUHhD7ZM0oEHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXkqFEl9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXkqFEl9"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ca860baea9fso3178654a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784061649; x=1784666449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8qrMUmYhSoehGE/5+LfHGEhf+jMUqgJsr4fs2xrp6KU=;
        b=iXkqFEl9avHfKm7TF2ABw8aRlK4CCaPsT84MZ5QoeqEHutUnoNqc/gqOZWMi7gIm3j
         ih5oYO/Vjv79WvYILPOdRQxKATdZ4qEHQaIlV1PdnvuWlmopnBcA0IOnvwKSkxOak9j4
         T5jj9GJpN1EdpwUqyyfu3FCaXVLAn5ecNRtmXAVOJ1R9JbFaS9Tf1CdPnfQzNFVx/8Fg
         FF9YWxaXNCs0FeYEJ9lrLYxUW+5k+KORfs6RgDDPZ7LB2uEqIomHi94ANEvctt//8Z1u
         oqmiekmZyLKl5UCfbwW5t/z7zuUlS4aWd6WNA5ATYgjtNOevNqAV0ARD3G8WTKMdBxLf
         718g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061649; x=1784666449;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qrMUmYhSoehGE/5+LfHGEhf+jMUqgJsr4fs2xrp6KU=;
        b=h9BgTCR5DPvmvh49r06uoqU4C3kBcr4yctcam65YtshZfYzTb8vdrQR0nX1c0rbEN5
         sQuMrtWmOhVW/2+zbAQNye+39SaFhJ//ssENQnFEy+i/C5IacyvDA+FEjjrrVaEraY+j
         svWCOShfGxhx/toVkh5LBqA4nzlAz+u/aaLcSEuuHsQW5vdeuv+Cysq2CTP88YcL/MfX
         A2gxbpTFFEifilVHJO3QLwXrWM8uP38dhazUxz/RUHF0Efmo9SNqUiB9+kT+Q04tEFTl
         usmKHp1COM95XPmQWG02tTTjA2judh9n3ZGwK48xkg6MGLC6d8SpornCOEVqzvKL+asa
         RduQ==
X-Forwarded-Encrypted: i=1; AHgh+Rotfhk3lQoANSvJPNfQjlrIdTicbUQzcj2p5qE6A0MiSDeWXtttm48LzvA7OjtI+IJF3uwftcVzNhooNs7Bl+u1@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1Tnqgke1ntKrG2u32kZEXDrjjsljaSaib7jEpARu/SWbm8J0
	kJAyPzTDYW6diG2NTopjjIi1m0H0aaehD2k1+51xTRYfFjB18AY/lLZJ2EuEaRHOSuJ78ttILjN
	idv7mbw==
X-Received: from pfbhw9.prod.google.com ([2002:a05:6a00:8909:b0:847:aa6c:47fc])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9501:b0:848:50a5:a70b
 with SMTP id d2e1a72fcca58-8488962feb7mr14464714b3a.21.1784061648698; Tue, 14
 Jul 2026 13:40:48 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:34 -0700
In-Reply-To: <20260714204044.1952031-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714204044.1952031-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714204044.1952031-4-ctshao@google.com>
Subject: [PATCH v2 03/12] perf vendor events intel: Update arrowlake events
 from 1.19 to 1.20
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
https://github.com/intel/perfmon/commit/b23ebe7bc25add0c835565e4bc87e063cb6=
20a02

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../arch/x86/arrowlake/arl-metrics.json       | 152 ++++++++++--------
 .../arch/x86/arrowlake/metricgroups.json      |   2 +-
 .../arch/x86/arrowlake/pipeline.json          |   2 +-
 .../arch/x86/arrowlake/uncore-memory.json     |  84 ++++++++--
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 5 files changed, 160 insertions(+), 82 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json
index 4f1f77404943..52db2caafc0a 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json
@@ -823,16 +823,16 @@
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
atency_capacity + tma_l1_latency_dependency + tma_lock_latency + tma_split_=
loads + tma_store_early_blk + tma_store_fwd_blk)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency + tma_uc_b=
ound)) + tma_memory_bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + =
tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_sq_full / (tma_=
contested_accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) =
+ tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_=
bound + tma_l3_miss_bound + tma_store_bound)) * (tma_fb_full / (tma_dtlb_lo=
ad + tma_fb_full + tma_l1_latency_capacity + tma_lock_latency + tma_split_l=
oads + tma_store_early_blk + tma_store_fwd_blk)))",
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
latency_dependency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_capacity=
 + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_sto=
re_early_blk + tma_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tm=
a_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound=
)) * (tma_l1_latency_capacity / (tma_dtlb_load + tma_fb_full + tma_l1_laten=
cy_capacity + tma_l1_latency_dependency + tma_lock_latency + tma_split_load=
s + tma_store_early_blk + tma_store_fwd_blk)) + tma_memory_bound * (tma_l1_=
bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_=
store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_capacity + tma_l1_latency_dependency + tma_lock_latency + tma_split_=
loads + tma_store_early_blk + tma_store_fwd_blk)) + tma_memory_bound * (tma=
_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_split_loads / (tma_dtlb_load + tma_fb_full + tma_l=
1_latency_capacity + tma_l1_latency_dependency + tma_lock_latency + tma_spl=
it_loads + tma_store_early_blk + tma_store_fwd_blk)) + tma_memory_bound * (=
tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bo=
und + tma_store_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_s=
haring + tma_split_stores + tma_store_latency + tma_streaming_stores)) + tm=
a_memory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2=
_bound + tma_l3_bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb_=
store + tma_false_sharing + tma_split_stores + tma_store_latency + tma_stre=
aming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency + tma_uc_bou=
nd)) + tma_memory_bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tm=
a_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_l3_hit_latency / =
(tma_contested_accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_fu=
ll)) + tma_memory_bound * tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma=
_l3_bound + tma_l3_miss_bound + tma_store_bound) + tma_memory_bound * (tma_=
l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound =
+ tma_store_bound)) * (tma_l1_latency_capacity / (tma_dtlb_load + tma_fb_fu=
ll + tma_l1_latency_capacity + tma_lock_latency + tma_split_loads + tma_sto=
re_early_blk + tma_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bo=
und)) * (tma_lock_latency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_c=
apacity + tma_lock_latency + tma_split_loads + tma_store_early_blk + tma_st=
ore_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_l2_b=
ound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_split_lo=
ads / (tma_dtlb_load + tma_fb_full + tma_l1_latency_capacity + tma_lock_lat=
ency + tma_split_loads + tma_store_early_blk + tma_store_fwd_blk)) + tma_me=
mory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_l3_miss_bound + tma_store_bound)) * (tma_split_stores / (tma_dtlb_st=
ore + tma_false_sharing + tma_split_stores + tma_store_latency + tma_stream=
ing_stores)) + tma_memory_bound * (tma_store_bound / (tma_l1_bound + tma_l2=
_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_store_=
latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_stor=
e_latency + tma_streaming_stores)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_bottleneck_data_cache_memory_latency",
         "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
@@ -858,7 +858,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l1_latency_capacity + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_ea=
rly_blk + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_=
dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound))=
 * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores=
 + tma_store_latency + tma_streaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) =
* (tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l1_latency_capacity +=
 tma_lock_latency + tma_split_loads + tma_store_early_blk + tma_store_fwd_b=
lk)) + tma_memory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound +=
 tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_dtlb_store / (=
tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency +=
 tma_streaming_stores)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -867,7 +867,7 @@
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
@@ -1015,7 +1015,7 @@
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
@@ -1024,7 +1024,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by backward-taken conditional branche=
s.",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_TAKEN_BWD_COST@ * cpu=
_core@BR_MISP_RETIRED.COND_TAKEN_BWD_COST@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_TAKEN_BWD@ / cpu_core=
@BR_MISP_RETIRED.ALL_BRANCHES@ * tma_branch_mispredicts",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_cond_tk_bwd_mispredicts",
         "MetricThreshold": "tma_cond_tk_bwd_mispredicts > 0.05 & (tma_bran=
ch_mispredicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -1033,7 +1033,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by forward-taken conditional branches=
.",
-        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_TAKEN_FWD_COST@ * cpu=
_core@BR_MISP_RETIRED.COND_TAKEN_FWD_COST@R / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_TAKEN_FWD@ / cpu_core=
@BR_MISP_RETIRED.ALL_BRANCHES@ * tma_branch_mispredicts",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_cond_tk_fwd_mispredicts",
         "MetricThreshold": "tma_cond_tk_fwd_mispredicts > 0.05 & (tma_bran=
ch_mispredicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -1046,7 +1046,7 @@
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related m=
etrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false_=
sharing, tma_machine_clears, tma_remote_cache",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HIT_ESF.SNP_MISS;MEM_LOAD_L2_MISS_RETIRE=
D.OTHER_MODULE_L2.SAME_CBB.HIT_M.SNP_FWD. Related metrics: tma_bottleneck_m=
emory_synchronization, tma_data_sharing, tma_false_sharing, tma_machine_cle=
ars, tma_remote_cache",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1062,13 +1062,13 @@
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
_LOAD_L3_HIT_RETIRED.XSNP_FWD@R, 25 * tma_info_system_core_frequency)) * (1=
 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ /=
 2) / tma_info_thread_clks",
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
_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HIT_ESF.SNP_HIT_NO_FWD. Related metrics: =
tma_bottleneck_memory_synchronization, tma_contested_accesses, tma_false_sh=
aring, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1082,19 +1082,9 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricExpr": "cpu_core@MEMORY_STALLS.MEM@ / tma_info_thread_clks"=
,
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
-        "MetricExpr": "(cpu_core@IDQ.DSB_UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x=
1@ / 2 + cpu_core@IDQ.DSB_UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.MI=
TE_UOPS@) * (cpu_core@IDQ_BUBBLES.STARVATION_CYCLES@ - cpu_core@IDQ_BUBBLES=
.FETCH_LATENCY@)) / tma_info_thread_clks",
+        "MetricExpr": "(cpu_core@IDQ.DSB_UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x=
1@ * max(0, 8 - tma_info_pipeline_fetch_dsb) / 8 + cpu_core@IDQ.DSB_UOPS@ /=
 (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.MITE_UOPS@) * (cpu_core@IDQ_BUBBLES=
.STARVATION_CYCLES@ - cpu_core@IDQ_BUBBLES.FETCH_LATENCY@)) / tma_info_thre=
ad_clks",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
         "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
@@ -1138,7 +1128,7 @@
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronization, t=
ma_contested_accesses, tma_data_sharing, tma_machine_clears, tma_remote_cac=
he",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: L2_REQUEST.RFO_H=
IT_XSNP_HIT_FWD. Related metrics: tma_bottleneck_memory_synchronization, tm=
a_contested_accesses, tma_data_sharing, tma_machine_clears, tma_remote_cach=
e",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1148,7 +1138,7 @@
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
@@ -1245,7 +1235,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
-        "MetricExpr": "cpu_core@FP_ARITH_OPS_RETIRED.VECTOR\\,umask\\=3D0x=
30@ / (tma_retiring * tma_info_thread_slots)",
+        "MetricExpr": "cpu_core@FP_ARITH_OPS_RETIRED.VECTOR_256B@ / (tma_r=
etiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
         "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -1288,7 +1278,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
-        "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / tma_info_thread_clks=
",
+        "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / tma_info_thread_clks=
 + tma_isb_full",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
@@ -1298,7 +1288,7 @@
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
@@ -1307,7 +1297,7 @@
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
@@ -1477,7 +1467,7 @@
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
o_thread_ipc / 8 > 0.35",
@@ -1544,7 +1534,7 @@
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
@@ -1703,6 +1693,15 @@
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
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
         "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@=
INST_RETIRED.ANY@",
@@ -1969,6 +1968,13 @@
         "MetricName": "tma_info_pipeline_retire",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Total percent of cycles without actually reti=
red uops",
+        "MetricExpr": "cpu_core@UOPS_RETIRED.STALLS@ / tma_info_thread_clk=
s",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_retire_stall",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
         "MetricExpr": "cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D1@",
@@ -2011,7 +2017,7 @@
         "MetricExpr": "32 * UNC_M_TOTAL_DATA / 1e9 / tma_info_system_time"=
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
@@ -2082,13 +2088,6 @@
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
@@ -2180,9 +2179,18 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric represents fraction of cycles Ica=
che tag lookup was stalled due to Instruction Stream Buffer (ISB) being ful=
l",
+        "MetricExpr": "(cpu_core@ICACHE_TAG.STALLS_ISB@ + cpu_core@ICACHE_=
TAG.STALLS_INUSE@) / tma_info_thread_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_icache_misses_group",
+        "MetricName": "tma_isb_full",
+        "MetricThreshold": "tma_isb_full > 0.05 & (tma_icache_misses > 0.0=
5 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
-        "MetricExpr": "cpu_core@ICACHE_TAG.STALLS@ / tma_info_thread_clks"=
,
+        "MetricExpr": "cpu_core@ICACHE_TAG.STALLS@ / tma_info_thread_clks =
- tma_isb_full",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
@@ -2209,19 +2217,9 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "This metric ([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache",
-        "MetricExpr": "4 * cpu_core@DEPENDENT_LOADS.ANY\\,cmask\\=3D1@ / t=
ma_info_thread_clks",
-        "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
-        "MetricName": "tma_l1_latency_dependency",
-        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & (tma_l1_boun=
d > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric ([SKL+] roughly; [LNL]) estimate=
s fraction of cycles with demand load accesses that hit the L1D cache. The =
short latency of the L1D cache may be exposed in pointer-chasing memory acc=
ess patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
-        "MetricExpr": "cpu_core@MEMORY_STALLS.L2@ / tma_info_thread_clks",
+        "MetricExpr": "cpu_core@MEM_LOAD_RETIRED.L2_HIT@ / (cpu_core@MEM_L=
OAD_RETIRED.L2_HIT@ + cpu_core@MEM_LOAD_MISC_RETIRED.UC@) * cpu_core@MEMORY=
_STALLS.L2@ / tma_info_thread_clks",
         "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
@@ -2245,7 +2243,7 @@
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
         "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_C=
BB",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2255,7 +2253,17 @@
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_bottleneck_data_cache_memory_latency, tma_mem_latency",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB. Relat=
ed metrics: tma_bottleneck_data_cache_memory_latency, tma_mem_latency",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricExpr": "cpu_core@MEMORY_STALLS.MEM@ / tma_info_thread_clks"=
,
+        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_grou=
p;tma_memory_bound_group",
+        "MetricName": "tma_l3_miss_bound",
+        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound > =
0.2 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_L2_MISS=
_RETIRED.L3_MISS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2348,7 +2356,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to LSD (Loop Stream Detector) unit",
-        "MetricExpr": "cpu_core@LSD.UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x1@ / =
tma_info_thread_clks / 2",
+        "MetricExpr": "cpu_core@LSD.UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x1@ * =
max(0, 8 - tma_info_pipeline_fetch_lsd) / 8 / tma_info_thread_clks",
         "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_lsd",
         "MetricThreshold": "tma_lsd > 0.15 & tma_fetch_bandwidth > 0.2",
@@ -2370,19 +2378,19 @@
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
@@ -2438,7 +2446,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(cpu_core@IDQ.MITE_UOPS\\,cmask\\=3D0x8\\,inv\\=3D0=
x1@ / 2 + cpu_core@IDQ.MITE_UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.=
MITE_UOPS@) * (cpu_core@IDQ_BUBBLES.STARVATION_CYCLES@ - cpu_core@IDQ_BUBBL=
ES.FETCH_LATENCY@)) / tma_info_thread_clks",
+        "MetricExpr": "(cpu_core@IDQ.MITE_UOPS\\,cmask\\=3D0x8\\,inv\\=3D0=
x1@ * max(0, 8 - tma_info_pipeline_fetch_mite) / 8 + cpu_core@IDQ.MITE_UOPS=
@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.MITE_UOPS@) * (cpu_core@IDQ_BUBB=
LES.STARVATION_CYCLES@ - cpu_core@IDQ_BUBBLES.FETCH_LATENCY@)) / tma_info_t=
hread_clks",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
         "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
@@ -2452,13 +2460,13 @@
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
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details.",
-        "MetricExpr": "cpu_core@IDQ.MS_CYCLES_ANY@ / tma_info_thread_clks =
/ 1.8",
+        "MetricExpr": "cpu_core@IDQ.MS_CYCLES_ANY@ * (8 - cpu_core@IDQ.MS_=
UOPS@ / cpu_core@IDQ.MS_CYCLES_ANY@) / tma_info_thread_slots",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
         "MetricName": "tma_ms",
         "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
@@ -2471,7 +2479,7 @@
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
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_bottlene=
ck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clear=
s, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_operation",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_bottlene=
ck_irregular_overhead, tma_clears_resteers, tma_info_inst_mix_vectormixpki,=
 tma_l1_bound, tma_machine_clears, tma_microcode_sequencer, tma_mixing_vect=
ors, tma_serializing_operation",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2589,7 +2597,7 @@
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
@@ -2664,7 +2672,7 @@
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
@@ -2679,8 +2687,8 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates clocks wasted due to lo=
ads blocked due to unknown store address (did not do memory disambiguation)=
 or due to unknown store data",
-        "MetricExpr": "7 * cpu_core@LD_BLOCKS.STORE_EARLY\\,cmask\\=3D1@ /=
 tma_info_thread_clks",
+        "BriefDescription": "This metric roughly estimates clocks wasted d=
ue to loads blocked due to unknown store address (did not do memory disambi=
guation) or due to unknown store data",
+        "MetricExpr": "cpu_core@LD_BLOCKS.STORE_EARLY\\,cmask\\=3D1@ / tma=
_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_early_blk",
         "MetricThreshold": "tma_store_early_blk > 0.2",
@@ -2768,7 +2776,17 @@
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
         "MetricName": "tma_streaming_stores",
         "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: tma=
_fb_full",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OMR.STREAMING_WR.ANY_RESPONSE. Related metrics: tma=
_fb_full",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of cyc=
les where the core's performance was likely hurt due to un-chacheable memor=
y",
+        "MetricExpr": "cpu_core@MEM_LOAD_MISC_RETIRED.UC@ / (cpu_core@MEM_=
LOAD_RETIRED.L2_HIT@ + cpu_core@MEM_LOAD_MISC_RETIRED.UC@) * cpu_core@MEMOR=
Y_STALLS.L2@ / tma_info_thread_clks",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_miss_bound_group",
+        "MetricName": "tma_uc_bound",
+        "MetricThreshold": "tma_uc_bound > 0.2 & (tma_l3_miss_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles where the core's performance was likely hurt due to un-chacheable memo=
ry. Related metrics: tma_bottleneck_data_cache_memory_bandwidth, tma_fb_ful=
l, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/metricgroups.json b/t=
ools/perf/pmu-events/arch/x86/arrowlake/metricgroups.json
index 855585fe6fae..9acbda612c25 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/metricgroups.json
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
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/arrowlake/pipeline.json
index bdfee0347cc5..1f1b5a88216a 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
@@ -1238,7 +1238,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent. Available PDIST counters: 0,1",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary run to run and not match the architectural =
number of iterations (specified by RCX) Available PDIST counters: 0,1",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/uncore-memory.json b/=
tools/perf/pmu-events/arch/x86/arrowlake/uncore-memory.json
index ceb8839f0767..60bf390198d6 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/uncore-memory.json
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
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index d82f6b3d5b68..7160ff89dac4 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.40,alderlake,core
 GenuineIntel-6-BE,v1.40,alderlaken,core
-GenuineIntel-6-C[56],v1.19,arrowlake,core
+GenuineIntel-6-C[56],v1.20,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
--=20
2.55.0.141.g00534a21ce-goog

