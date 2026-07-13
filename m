Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5E3537F7
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966695; cv=none; b=nwT1hfODo/DmFW3mnWSdssjLRtGRgjYqbaxna21J0pHMe0JdVd2XvqVSVq9FzRZFle6JDq3OT+7nAdHylGtw4zI9XR68y533jJitKoG+PLyA0scBleekm2zdN+FQtQqGFlj/mZLkNI4KUQINtmpy0gCxg9U4PFXm9HH9lO4FNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966695; c=relaxed/simple;
	bh=IQ/poQylhdqZ70motUrx+8u655vrv5uZsO37mX1oAns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UDoKgFwtjcpIbmI8nVpnX+QXrGx9NpIUhq+DaZnQMGQZfntVZE81cMs3uZmkS3VP+QjGJDFWXOokPqyxXMyCrIkJIGRxAA7wvxiwRKeSkBv1zwbMWSi01Q8azMTiKW833zlDyPIb6hxnwIxdfBrbIWMiLBuS/fw5xXpFFLl9vfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTzgPtYI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTzgPtYI"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-848860def2cso3325334b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 11:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783966686; x=1784571486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4xt82ilvgVChitvMPCLXVBd1JA2Cq3aCA0LXZnhkeCo=;
        b=RTzgPtYIRFUb6CS6AxVM83tLOUNXfbEl8/1UFl0ytYFub6O+3fWAir9SBR8MNS3UOn
         3IKeq6vJX2ozmsaxN3nGauF95bf3tnylGQ9E+5H8wjdMo7nMT4h6w1VSdZEs8o34B26Q
         fR+2kmjkNfbR8RLD3v82ZuG+0mK9wGsNOwu+Msc0uH9DcvU5VvIZ0+h2KjTYG1AYHE0G
         WPtvIZiF5O7//sFotPwgoEhugUSGesQO35KHsvvrNeta1RSzI8q06lFIp9afH8vKb3u/
         8kUuD0x+MFc9l7N4oQ1XT97qJJeYDpf0J0urjiA63wk+DxGtm6i1XKAESK20bGqSUpL+
         hPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966686; x=1784571486;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4xt82ilvgVChitvMPCLXVBd1JA2Cq3aCA0LXZnhkeCo=;
        b=hZRxCUPuhzpbDob2ue0JbKtNetSQkQpbLW8aONN57hGc3yf066MsBJn3CWdrYKbMw4
         Z++in/KwIM7xxOR4ropNhSak/NofSX6XTa4kmmUBATZiAHEaMrqzHA9SXbx+awzIoHO8
         r0IMWDotYbQuPco/5drL1JAr7oGgdOIcS6OPhF4Rf//2HB7PMGp8eRZgqy7FOH12DIf+
         7tMJ9IsQ+vSfYgXbnFIhYn+uFrTOedc51WVcVszbTmo8p0Z5L68feB1clQOQFjPaSjlq
         hCAc0riTeaECbwipbDBoB9GHi3sUt7Za27UDTM+a/VscXQZ6rePoimBHxcsof62AKEbw
         LZZg==
X-Forwarded-Encrypted: i=1; AHgh+RrPzwd9lzSB3/LbcgCP4uv8oaT3Pw6LwA5VoKWngiaNJSxwagMJIMR766jBPHpl2BJFwmOuws5WYr1UVBjMkJ0J@vger.kernel.org
X-Gm-Message-State: AOJu0YyisnxbK8bxC4+ME7hLzVHWbqCeqXoQI5z01P49jhNf7SbV4Gzg
	V0q4Z6gybHqp7XZnAb3jEULWYBPYtSK0TFiwhXDGQOS/LA00aRrcK7C0+NtS9TnjywIaGVJ2xhf
	0j1PjGA==
X-Received: from pfcp8.prod.google.com ([2002:a05:6a00:a248:b0:848:4e44:7f19])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab09:b0:847:439b:ae30
 with SMTP id d2e1a72fcca58-848896673bfmr9140223b3a.20.1783966686197; Mon, 13
 Jul 2026 11:18:06 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:17:51 -0700
In-Reply-To: <20260713181757.481164-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713181757.481164-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713181757.481164-7-ctshao@google.com>
Subject: [PATCH v1 06/12] perf vendor events intel: Update graniterapids
 events from 1.19 to 1.20
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
https://github.com/intel/perfmon/commit/084ecb869d75f9e5383354d3fe68a93aa25=
be112

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../arch/x86/graniterapids/gnr-metrics.json   | 102 +++++++++---------
 .../arch/x86/graniterapids/metricgroups.json  |   2 +-
 .../arch/x86/graniterapids/pipeline.json      |   2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 4 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json =
b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
index 299631fb8d53..95e05812eb3b 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
@@ -452,15 +452,15 @@
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_cx=
l_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_late=
ncy)) + tma_memory_bound * (tma_l3_bound / (tma_cxl_mem_bound + tma_dram_bo=
und + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma=
_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_latency =
+ tma_sq_full)) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_bound + t=
ma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_boun=
d)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependen=
cy + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_cxl_mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_b=
ound + tma_store_bound)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_me=
m_latency)) + tma_memory_bound * (tma_l3_bound / (tma_cxl_mem_bound + tma_l=
1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound=
)) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_hit=
_latency + tma_sq_full)) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_=
bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tm=
a_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_late=
ncy_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))"=
,
         "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_bottleneck_data_cache_memory_bandwidth",
         "MetricThreshold": "tma_bottleneck_data_cache_memory_bandwidth > 2=
0",
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_uc_bound"
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_cx=
l_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latenc=
y)) + 0 / (tma_cxl_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound=
 + tma_l3_bound + tma_store_bound) * tma_mem_latency / (tma_mem_bandwidth +=
 tma_mem_latency) + tma_memory_bound * (tma_l3_bound / (tma_cxl_mem_bound +=
 tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bo=
und)) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + =
tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * tma_l2_bound / (tma=
_cxl_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_boun=
d + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_boun=
d + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store=
_bound)) * (tma_l1_latency_dependency / (tma_dtlb_load + tma_fb_full + tma_=
l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_=
blk)) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_bound + tma_dram_bo=
und + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma=
_lock_latency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + =
tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound=
 * (tma_l1_bound / (tma_cxl_mem_bound + tma_dram_bound + tma_l1_bound + tma=
_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_split_loads / (tma_dtlb=
_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_sp=
lit_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tm=
a_cxl_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sh=
aring + tma_split_stores + tma_store_latency + tma_streaming_stores)) + tma=
_memory_bound * (tma_store_bound / (tma_cxl_mem_bound + tma_dram_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_store_l=
atency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store=
_latency + tma_streaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_cxl_mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_b=
ound + tma_store_bound)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_=
latency)) + tma_memory_bound * (tma_l3_bound / (tma_cxl_mem_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound))=
 * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tma_l=
3_hit_latency + tma_sq_full)) + tma_memory_bound * tma_l2_bound / (tma_cxl_=
mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound =
+ tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_bound =
+ tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_stor=
e_bound)) * (tma_l1_latency_dependency / (tma_dtlb_load + tma_fb_full + tma=
_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd=
_blk)) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_bound + tma_l1_bou=
nd + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * =
(tma_lock_latency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependenc=
y + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_b=
ound * (tma_l1_bound / (tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound + t=
ma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_split_loads / (t=
ma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency +=
 tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_boun=
d / (tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l=
3_miss_bound + tma_store_bound)) * (tma_split_stores / (tma_dtlb_store + tm=
a_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_stor=
es)) + tma_memory_bound * (tma_store_bound / (tma_cxl_mem_bound + tma_l1_bo=
und + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) *=
 (tma_store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_store=
s + tma_store_latency + tma_streaming_stores)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_bottleneck_data_cache_memory_latency",
         "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
@@ -483,7 +483,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_cxl_=
mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound)) * (tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)=
) + tma_memory_bound * (tma_store_bound / (tma_cxl_mem_bound + tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_s=
tore_latency + tma_streaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_cxl_=
mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound =
+ tma_store_bound)) * (tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l=
1_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_b=
lk)) + tma_memory_bound * (tma_store_bound / (tma_cxl_mem_bound + tma_l1_bo=
und + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) *=
 (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores +=
 tma_store_latency + tma_streaming_stores)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -491,7 +491,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_cx=
l_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency=
)) * tma_remote_cache / (tma_local_mem + tma_remote_cache + tma_remote_mem)=
 + tma_l3_bound / (tma_cxl_mem_bound + tma_dram_bound + tma_l1_bound + tma_=
l2_bound + tma_l3_bound + tma_store_bound) * (tma_contested_accesses + tma_=
data_sharing) / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_lat=
ency + tma_sq_full) + tma_store_bound / (tma_cxl_mem_bound + tma_dram_bound=
 + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * tma_fals=
e_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_st=
ore_latency + tma_streaming_stores - tma_store_latency)) + tma_machine_clea=
rs * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_cxl_mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_b=
ound + tma_store_bound) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_l=
atency)) * tma_remote_cache / (tma_local_mem + tma_remote_cache + tma_remot=
e_mem) + tma_l3_bound / (tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound + =
tma_l3_bound + tma_l3_miss_bound + tma_store_bound) * (tma_contested_access=
es + tma_data_sharing) / (tma_contested_accesses + tma_data_sharing + tma_l=
3_hit_latency + tma_sq_full) + tma_store_bound / (tma_cxl_mem_bound + tma_l=
1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound=
) * tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_sto=
res + tma_store_latency + tma_streaming_stores - tma_store_latency)) + tma_=
machine_clears * (1 - tma_other_nukes / tma_other_nukes))",
         "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
         "MetricName": "tma_bottleneck_memory_synchronization",
         "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
@@ -624,7 +624,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by non-taken conditional bran=
ches.",
-        "MetricExpr": "BR_MISP_RETIRED.COND_NTAKEN_COST * BR_MISP_RETIRED.=
COND_NTAKEN_COST:R / tma_info_thread_clks",
+        "MetricExpr": "BR_MISP_RETIRED.COND_NTAKEN / BR_MISP_RETIRED.ALL_B=
RANCHES * tma_branch_mispredicts",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_cond_nt_mispredicts",
         "MetricThreshold": "tma_cond_nt_mispredicts > 0.05 & (tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -632,7 +632,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by taken conditional branches.",
-        "MetricExpr": "BR_MISP_RETIRED.COND_TAKEN_COST * BR_MISP_RETIRED.C=
OND_TAKEN_COST:R / tma_info_thread_clks",
+        "MetricExpr": "BR_MISP_RETIRED.COND_TAKEN / BR_MISP_RETIRED.ALL_BR=
ANCHES * tma_branch_mispredicts",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_cond_tk_mispredicts",
         "MetricThreshold": "tma_cond_tk_mispredicts > 0.05 & (tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -668,13 +668,13 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to L3 data-sharing=
 accesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD * min(MEM_LOAD=
_L3_HIT_RETIRED.XSNP_NO_FWD:R, 74.6 * tma_info_system_core_frequency) + MEM=
_LOAD_L3_HIT_RETIRED.XSNP_FWD * min(MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD:R, 74.=
6 * tma_info_system_core_frequency) * (1 - OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_=
HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SN=
OOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MI=
SS / 2) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -695,15 +695,6 @@
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIV_ACTIVE",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_thread_c=
lks - tma_cxl_mem_bound if #has_pmem > 0 else MEMORY_ACTIVITY.STALLS_L3_MIS=
S / tma_info_thread_clks)",
-        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
-        "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
         "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_info=
_core_core_clks / 2",
@@ -755,7 +746,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -902,7 +893,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect CALL instructions=
.",
-        "MetricExpr": "BR_MISP_RETIRED.INDIRECT_CALL_COST * BR_MISP_RETIRE=
D.INDIRECT_CALL_COST:R / tma_info_thread_clks",
+        "MetricExpr": "BR_MISP_RETIRED.INDIRECT_CALL / BR_MISP_RETIRED.ALL=
_BRANCHES * tma_branch_mispredicts",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ind_call_mispredicts",
         "MetricThreshold": "tma_ind_call_mispredicts > 0.05 & (tma_branch_=
mispredicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -910,7 +901,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect JMP instructions.=
",
-        "MetricExpr": "max((BR_MISP_RETIRED.INDIRECT_COST * BR_MISP_RETIRE=
D.INDIRECT_COST:R - BR_MISP_RETIRED.INDIRECT_CALL_COST * BR_MISP_RETIRED.IN=
DIRECT_CALL_COST:R) / tma_info_thread_clks, 0)",
+        "MetricExpr": "max((BR_MISP_RETIRED.INDIRECT - BR_MISP_RETIRED.IND=
IRECT_CALL) / BR_MISP_RETIRED.ALL_BRANCHES * tma_branch_mispredicts, 0)",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ind_jump_mispredicts",
         "MetricThreshold": "tma_ind_jump_mispredicts > 0.05 & (tma_branch_=
mispredicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -1045,7 +1036,7 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / tma_info_core_core_clks",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_ARIT=
H_INST_RETIRED.8_FLOPS + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) / t=
ma_info_core_core_clks",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_core_flopc"
     },
@@ -1064,7 +1055,7 @@
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.=
MS_UOPS)",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_frontend_dsb_coverage",
         "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 6 > 0.35",
@@ -1202,7 +1193,7 @@
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Half-Pr=
ecision instruction (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED2.SCALAR",
-        "MetricGroup": "Flops;FpScalar;InsType;Server",
+        "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_hp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_hp < 10",
         "PublicDescription": "Instructions per FP Arithmetic Scalar Half-P=
recision instruction (lower number means higher occurrence rate). Values < =
1 are possible due to intentional FMA double counting."
@@ -1231,7 +1222,7 @@
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / (cpu@FP_ARITH_INST_RETIRED.SCALA=
R_SINGLE\\,umask\\=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE +=
 4 * cpu@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * c=
pu@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARI=
TH_INST_RETIRED.512B_PACKED_SINGLE)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_=
FLOPS + 8 * FP_ARITH_INST_RETIRED.8_FLOPS + 16 * FP_ARITH_INST_RETIRED.512B=
_PACKED_SINGLE)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_ipflop",
         "MetricThreshold": "tma_info_inst_mix_ipflop < 10"
@@ -1271,6 +1262,14 @@
         "MetricThreshold": "tma_info_inst_mix_iptb < 13",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp"
     },
+    {
+        "BriefDescription": "AVX preserve/restore assists per kilo instruc=
tion",
+        "MetricExpr": "1e3 * ASSISTS.SSE_AVX_MIX / INST_RETIRED.ANY",
+        "MetricGroup": "tma_issueMV",
+        "MetricName": "tma_info_inst_mix_vectormixpki",
+        "MetricThreshold": "tma_info_inst_mix_vectormixpki > 0.05",
+        "PublicDescription": "AVX preserve/restore assists per kilo instru=
ction. Related metrics: tma_mixing_vectors, tma_ms_switches"
+    },
     {
         "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "tma_info_memory_l1d_cache_fill_bw",
@@ -1526,7 +1525,7 @@
         "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
     },
     {
-        "BriefDescription": "Mem;Backend;CacheHits",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per physical core",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
@@ -1606,11 +1605,11 @@
         "MetricExpr": "64 * (UNC_M_CAS_COUNT_SCH0.RD + UNC_M_CAS_COUNT_SCH=
1.RD + UNC_M_CAS_COUNT_SCH0.WR + UNC_M_CAS_COUNT_SCH1.WR) / 1e9 / tma_info_=
system_time",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_data_cache_memor=
y_bandwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full"
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_data_cache_memor=
y_bandwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full, tma_uc_bound"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(cpu@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umask\\=
=3D0x03@ + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * cpu@FP_ARITH_=
INST_RETIRED.128B_PACKED_SINGLE\\,umask\\=3D0x18@ + 8 * cpu@FP_ARITH_INST_R=
ETIRED.256B_PACKED_SINGLE\\,umask\\=3D0x60@ + 16 * FP_ARITH_INST_RETIRED.51=
2B_PACKED_SINGLE) / 1e9 / tma_info_system_time",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_ARIT=
H_INST_RETIRED.8_FLOPS + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) / 1=
e9 / tma_info_system_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width"
@@ -1701,12 +1700,6 @@
         "MetricGroup": "Power",
         "MetricName": "tma_info_system_turbo_utilization"
     },
-    {
-        "BriefDescription": "Measured Average Uncore Frequency for the SoC=
 [GHz]",
-        "MetricExpr": "tma_info_system_socket_clks / 1e9 / tma_info_system=
_time",
-        "MetricGroup": "SoC",
-        "MetricName": "tma_info_system_uncore_frequency"
-    },
     {
         "BriefDescription": "Cross-socket Ultra Path Interconnect (UPI) da=
ta transmit bandwidth for data only [MB / sec]",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 64 / 9 / 1e6",
@@ -1862,6 +1855,15 @@
         "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_bottleneck_data_cache_memory_latency, tma_mem_latency",
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_thread_c=
lks - tma_cxl_mem_bound if #has_pmem > 0 else MEMORY_ACTIVITY.STALLS_L3_MIS=
S / tma_info_thread_clks)",
+        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_grou=
p;tma_memory_bound_group",
+        "MetricName": "tma_l3_miss_bound",
+        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound > =
0.2 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
         "MetricExpr": "DECODE.LCP / tma_info_thread_clks",
@@ -1936,7 +1938,7 @@
         "MetricExpr": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * MEM_LOAD_L3_M=
ISS_RETIRED.LOCAL_DRAM:R * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_mem",
-        "MetricThreshold": "tma_local_mem > 0.1 & (tma_mem_latency > 0.1 &=
 (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2)=
))",
+        "MetricThreshold": "tma_local_mem > 0.1 & (tma_mem_latency > 0.1 &=
 (tma_l3_miss_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2)))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.LOCAL_DRAM",
         "ScaleUnit": "100%"
     },
@@ -1966,24 +1968,24 @@
         "MetricExpr": "INT_MISC.MBA_STALLS / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;Server;TopdownL5;tma_L5_group;tma=
_mem_bandwidth_group",
         "MetricName": "tma_mba_stalls",
-        "MetricThreshold": "tma_mba_stalls > 0.1 & (tma_mem_bandwidth > 0.=
2 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2)))",
+        "MetricThreshold": "tma_mba_stalls > 0.1 & (tma_mem_bandwidth > 0.=
2 & (tma_l3_miss_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound =
> 0.2)))",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
-        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.DATA_RD\\,cmask\\=3D12@) / tma_info_thread_clks",
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
). Related metrics: tma_bottleneck_data_cache_memory_latency, tma_l3_hit_la=
tency",
         "ScaleUnit": "100%"
     },
@@ -2047,7 +2049,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -2064,7 +2066,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -2197,25 +2199,25 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
-        "MetricExpr": "(MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * PEBS + MEM_=
LOAD_L3_MISS_RETIRED.REMOTE_FWD * PEBS) * (1 + MEM_LOAD_RETIRED.FB_HIT / ME=
M_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "(MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * MEM_LOAD_L3=
_MISS_RETIRED.REMOTE_HITM:R + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_FWD:R) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
         "MetricName": "tma_remote_cache",
-        "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
+        "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_l3_miss_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2)))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article. Sample with: MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_HITM_PS;MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD_PS. Related metri=
cs: tma_bottleneck_memory_synchronization, tma_contested_accesses, tma_data=
_sharing, tma_false_sharing, tma_machine_clears",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricExpr": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * PEBS * (1 + =
MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_c=
lks",
+        "MetricExpr": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * MEM_LOAD_L3_=
MISS_RETIRED.REMOTE_DRAM:R * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRE=
D.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_mem",
-        "MetricThreshold": "tma_remote_mem > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
+        "MetricThreshold": "tma_remote_mem > 0.1 & (tma_mem_latency > 0.1 =
& (tma_l3_miss_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article. Sample=
 with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by (indirect) RET instruction=
s.",
-        "MetricExpr": "BR_MISP_RETIRED.RET_COST * BR_MISP_RETIRED.RET_COST=
:R / tma_info_thread_clks",
+        "MetricExpr": "BR_MISP_RETIRED.RET / BR_MISP_RETIRED.ALL_BRANCHES =
* tma_branch_mispredicts",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ret_mispredicts",
         "MetricThreshold": "tma_ret_mispredicts > 0.05 & (tma_branch_mispr=
edicts > 0.1 & tma_bad_speculation > 0.15)",
@@ -2283,7 +2285,7 @@
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
         "ScaleUnit": "100%"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json=
 b/tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
index 9129fb7b7ce4..b5f601991e9d 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
@@ -90,7 +90,6 @@
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
@@ -124,6 +123,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
index 0fef8fd61974..afc77bdeb600 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
@@ -559,7 +559,7 @@
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
         "UMask": "0x8"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index d9f45cc906c7..21f624e20cf3 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.24,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.13,grandridge,core
-GenuineIntel-6-A[DE],v1.19,graniterapids,core
+GenuineIntel-6-A[DE],v1.20,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
--=20
2.55.0.795.g602f6c329a-goog

