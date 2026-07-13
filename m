Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA2353A86
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966692; cv=none; b=Vq9s5RYTOfeLGkk2lZQIrAaTc5fj5CBJVh2aUCodVnuW4MyTAfrQgR1+U9fz9J6EOr5b480xwyryw1YFPHAUJJOYQSuSa4ZocbLoj4LbECpxoJGKkvujBntqt+64oxCFE7VWflSYTHVrEHRRam84g8u7U91xM3zvGts1RnhZKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966692; c=relaxed/simple;
	bh=fMC/8LNSiMrl9cBVZ4GUDegR+c8kVRcyar+9lju3qRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qieba6q8DjmheWQ0JnZ/ipmzgw/nVXCRUECP4CDBS+2IHtP3jtomsUh6ul7StlvE2Ct8LvGxoJOg9wZLesuY+AmDX9H9aizQcKQbnBUvWmKESH2cnKkpoFNc7X/v1s1rliYLrisoGcyIxs7sPUKZPaui1I86CDcpgugkGQ96/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6w8vZ2q; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6w8vZ2q"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8484f26852dso150121b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783966688; x=1784571488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H7LTXblBZLfEHb+3KT/oVdy6FuHS89hpCR9GnPgmLZE=;
        b=s6w8vZ2qIQM1NScvbTJEOz0w+dT4pg31jBhe3XbBH9HKlrUjfsFMg07cHvfLbl1xAH
         w7I+cVt72kkVykWjdcwhj/+rIvQsw8yKuwUWGAgf2IBfeWotNEUkvAQ0X26df68kRi8H
         g+AUC2IsTtKohvvd1oirBI7CuxWbXx4BHFml89xv/bf6A6hPnGYFJaez1EP7MM2UvIsb
         LiCDkRkbI2BdOw6JCrRq9KcSSilq3T1um9lFqFUok6jHnafpNK8k1zYdTdOYONFrUldg
         yVQBg+TW/wZ1k5XVcuA6l1cjHPTYuosxW7hzttu8jXJ0MNtmhv1geKdpwSZGIRKUF/6H
         y4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966688; x=1784571488;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7LTXblBZLfEHb+3KT/oVdy6FuHS89hpCR9GnPgmLZE=;
        b=WFzKXQM8aL7piejcdFZuhlMigqcWMt7oJVuJ4YHqCrG8PoC9nqOu9ezZGlsjLK+Yss
         w1ZZYoIl/px97HXmFxYgyh7a//wMwK/vJB/f/otT/4VIu355SBWRSpB3IG45a6VsKy6I
         Rye7FS6iSXSVWOQ1oWv3yTLzLTq1C6BJseQNn9Jwu4Mrydrcs97439KTPb04/GSJAMmq
         lnOPw250+z6Xmo9OtsEaLM3ZTNHryjWeOs4gbGHtt9OezB8nYrXjYkBiaRwRbI91dAtT
         QsaztVqjhVI50/lmavbOcyKsxkc//QcDtbq3nLyhSiYzU3YE3unY4+zOqfqX6bKvYNgJ
         5pAw==
X-Forwarded-Encrypted: i=1; AHgh+RoiiHlVvZCtD6iWP6HQ6U6Cbu5/6m4fHYebKV3a5ujyCPO7NX6WvmD0W4E4RbJA978wvdTA8sbhZSbXl6PnIeQj@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGaBpVTegnedOZ77i+dTRDspdjdtK5pCyOthYcU2KPcHigTv4
	1MsjG/2IdLejVYzafAk+LnCOlRc9LVvZRM6cB4B7SwvPXsX5V2U/RKpSe4G1N/y7N9UjhVS7Uln
	xawuU0w==
X-Received: from pfbdh4.prod.google.com ([2002:a05:6a00:4784:b0:847:7f5d:6b90])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c8f:b0:82d:62ed:b01d
 with SMTP id d2e1a72fcca58-848896bb05emr9234536b3a.45.1783966687297; Mon, 13
 Jul 2026 11:18:07 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:17:52 -0700
In-Reply-To: <20260713181757.481164-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713181757.481164-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713181757.481164-8-ctshao@google.com>
Subject: [PATCH v1 07/12] perf vendor events intel: Update lunarlake events
 from 1.25 to 1.26
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, perry.taylor@intel.com, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/2ba9dec72a771ed3ce7114d6a1679713187=
1fd61

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../arch/x86/lunarlake/lnl-metrics.json       | 142 ++++++++++--------
 .../arch/x86/lunarlake/metricgroups.json      |   2 +-
 .../arch/x86/lunarlake/pipeline.json          |   2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 4 files changed, 83 insertions(+), 65 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/lnl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/lunarlake/lnl-metrics.json
index 06390a72110d..6bc62297ca6c 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/lnl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/lnl-metrics.json
@@ -783,16 +783,16 @@
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
@@ -818,7 +818,7 @@
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
@@ -827,7 +827,7 @@
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
@@ -975,7 +975,7 @@
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
@@ -984,7 +984,7 @@
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
@@ -993,7 +993,7 @@
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
@@ -1022,13 +1022,13 @@
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
_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_sy=
nchronization, tma_contested_accesses, tma_false_sharing, tma_machine_clear=
s, tma_remote_cache",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1042,19 +1042,9 @@
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
@@ -1108,7 +1098,7 @@
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
@@ -1205,7 +1195,7 @@
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
@@ -1248,7 +1238,7 @@
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
@@ -1258,7 +1248,7 @@
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
@@ -1267,7 +1257,7 @@
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
@@ -1437,7 +1427,7 @@
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
@@ -1504,7 +1494,7 @@
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
@@ -1663,6 +1653,15 @@
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
@@ -1929,6 +1928,13 @@
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
@@ -1971,7 +1977,7 @@
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
@@ -2042,13 +2048,6 @@
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
@@ -2140,9 +2139,18 @@
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
@@ -2169,19 +2177,9 @@
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
ess patterns as an example. Sample with: MEM_LOAD_UOPS_RETIRED.L1_HIT_PS",
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
@@ -2219,6 +2217,16 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
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
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
         "MetricExpr": "cpu_core@DECODE.LCP@ / tma_info_thread_clks",
@@ -2308,7 +2316,7 @@
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
@@ -2330,19 +2338,19 @@
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
@@ -2398,7 +2406,7 @@
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
@@ -2412,13 +2420,13 @@
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
@@ -2431,7 +2439,7 @@
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
@@ -2549,7 +2557,7 @@
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
@@ -2624,7 +2632,7 @@
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
@@ -2639,8 +2647,8 @@
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
@@ -2731,6 +2739,16 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
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
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
         "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / tma_info=
_thread_clks",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/metricgroups.json b/t=
ools/perf/pmu-events/arch/x86/lunarlake/metricgroups.json
index 855585fe6fae..9acbda612c25 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/metricgroups.json
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
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/lunarlake/pipeline.json
index a7467b2f291d..8be3ea336bb8 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
@@ -973,7 +973,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 21f624e20cf3..68f1ae4c0aae 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -22,7 +22,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
-GenuineIntel-6-BD,v1.25,lunarlake,core
+GenuineIntel-6-BD,v1.26,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.21,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
--=20
2.55.0.795.g602f6c329a-goog

