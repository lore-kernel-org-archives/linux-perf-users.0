Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628443546DE
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966697; cv=none; b=sjl0HO7FL0qraHToEl41eYavGPd2Z97dGKqwkdMfvc4tgefU2craxdhs9ILLD5/YudOSvo5pn+U7hGXvPt6xx3x77D6HdxRJr45HY+DdN4aFHztvJ23uv276dlNgXkJLdqC1ZQByFTRqyaTKx5cvwANWTDnlvIGoqoxhlPa5nQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966697; c=relaxed/simple;
	bh=NNtysQRsYYpZQH2QrCVpVviDe0eRzlcCyLw6Fw8hu70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTQYPCaKA3Nj+qWCXZ86sGl1SfhRV2MlIs/hqaPrlmJanLI0jjfCp3Q1hbKXGbZJufqV5B+SY7aCOWh5KD4ZoPOlhdqHtNUKu2caC3dFwo7b0/sUFUyosPVJGh8WOJf+J6pxr/q679zYkNfF6P0acYN5dLCRbGVzdlwhofOuFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9T4ldkU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9T4ldkU"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848544a8496so171659b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783966693; x=1784571493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rMCmwPf3W0meKeqLaxRIfsqH2W/lUPcyeEyIa/z2kKo=;
        b=F9T4ldkU1LXHs1aVfUzrujrRJkHY/9rzjRC7LTxtztl+YdmNUK4GYM0mXPaccC6K9W
         BV1wZO7SQLV+I2Ky6QcqvFTZvu1guuJAUjasyeJ2Fa98iSZHynMtZAK3dDcLOQt076Rq
         22/IqIAKpSJACepkHMj8twlf7RK0IzH1hXWefsnPzrxpfCChHj1MTztabp3wzxbZR0Xp
         fAHWzo0dwtH3pLjA8lAapMWXYMF3x27GbU7VEGZ4olalelpygRC19PFswvEeHzbRqzAh
         gd7pA7IxOlTr8ClqiJmLLd/vYBg9YgGigkpknKJWKztzN2aYTeFTw9qXRSn9HPe0Faf/
         Tusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966693; x=1784571493;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rMCmwPf3W0meKeqLaxRIfsqH2W/lUPcyeEyIa/z2kKo=;
        b=s3uTQuxkKyR7FD5Ph/cWAGvFBfgyd8q6TpCavN9Kkqa7xdKH9W6BOjG1NLqjefGZYl
         I4muvRic/GbdXlTtvYBlhdHZoeNWgyepBeOzbTAba4WtqDMgGKXf36nByO3j+KhZ06dk
         0m7IFfeBA6EFlXWv0ZdGwOYwnsdvKfD3TQz+KcDd6Kc0MIcEPgwc3fP+j5CFW+X/pPBP
         z81hMwtgujI0s1e0SPBJ0L67ctJLGULHNrMiecLpa0huVNaoX0WBwdsjiwPY7ZyiGsNR
         DBGGhzz0U7/tWk2JEyQDTjbDuN7fAF3JL+edU2WKjBGcjKMHe3Ey6uS1NURx26jNU50C
         Dkug==
X-Forwarded-Encrypted: i=1; AHgh+Rp9Uj3YQaYk/XlobvHwAjn7IR0qvsHGzdvgZLnsdWFsd29rlZnanzjC5CYL+GyN55MxgDbIA/bsmX5LBRzBCUa/@vger.kernel.org
X-Gm-Message-State: AOJu0YycNtv/VXYiZu9Q1wNknDupHDI1eHr9MgfbfQi6i43jP7sssCPP
	o2pSzFEHI8/pl+r7Rgb47Lf7XjQnIUgGvBZHhpavG//I9i6LAYCw5yLTfLvdaqU/6Xy5EJKjsTI
	jLr4aMw==
X-Received: from pfbfe24.prod.google.com ([2002:a05:6a00:2f18:b0:847:98fd:5a98])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd8a:b0:847:8b11:596d
 with SMTP id d2e1a72fcca58-848896b9d6cmr8674338b3a.41.1783966692518; Mon, 13
 Jul 2026 11:18:12 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:17:57 -0700
In-Reply-To: <20260713181757.481164-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713181757.481164-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713181757.481164-13-ctshao@google.com>
Subject: [PATCH v1 12/12] perf vendor events intel: Update emeraldrapids metrics
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
https://github.com/intel/perfmon/commit/240735b7d8e0b50fe8f4a64e08399df13cb=
87ae6

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../arch/x86/emeraldrapids/emr-metrics.json   | 135 +++++++++++-------
 .../arch/x86/emeraldrapids/metricgroups.json  |   2 +-
 2 files changed, 87 insertions(+), 50 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json =
b/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
index 433ae5f50704..e00e32e71691 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
@@ -84,6 +84,18 @@
         "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB",
         "ScaleUnit": "1per_instr"
     },
+    {
+        "BriefDescription": "Bandwidth observed by the integrated I/O traf=
fic controller (IIO) of IO reads that are initiated by end device controlle=
rs that are requesting memory from the CPU",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS * 4 / 1e=
6 / duration_time",
+        "MetricName": "iio_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth observed by the integrated I/O traf=
fic controller (IIO) of IO writes that are initiated by end device controll=
ers that are writing memory to the CPU",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS * 4 / 1=
e6 / duration_time",
+        "MetricName": "iio_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU",
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e6 / durati=
on_time",
@@ -242,6 +254,30 @@
         "MetricName": "llc_demand_data_read_miss_to_dram_latency",
         "ScaleUnit": "1ns"
     },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_LOCAL * 64 / 1e6 / duration_=
time",
+        "MetricName": "llc_miss_local_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_LOCAL * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_local_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_REMOTE * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_REMOTE * 64 / 1e6 / duratio=
n_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
         "MetricExpr": "MEM_INST_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
@@ -403,15 +439,15 @@
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + 0 / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * t=
ma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency) + tma_memory_bound=
 * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_b=
ound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma_dat=
a_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tma_l1=
_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma=
_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_laten=
cy_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + 0 / (t=
ma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_b=
ound) * tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency) + tma_mem=
ory_bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_l3_miss_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_access=
es + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bou=
nd * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_m=
iss_bound + tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full=
 + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_sto=
re_fwd_blk)))",
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
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + 0 / (tma_dram_=
bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * tma=
_mem_latency / (tma_mem_bandwidth + tma_mem_latency) + tma_memory_bound * (=
tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses + tma_=
data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * tma_=
l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l1_latenc=
y_dependency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + t=
ma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound =
* (tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bo=
und + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_fb_full =
+ tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_stor=
e_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_split_loads /=
 (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latenc=
y + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_b=
ound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_s=
tore_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sharing + tm=
a_split_stores + tma_store_latency + tma_streaming_stores)) + tma_memory_bo=
und * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tm=
a_l3_bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb_store + tma=
_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_store=
s)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + 0 / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd) * tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency) + tma_memory_=
bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l=
3_miss_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_acc=
esses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_=
bound * tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3=
_miss_bound + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)=
) * (tma_l1_latency_dependency / (tma_dtlb_load + tma_fb_full + tma_l1_late=
ncy_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) +=
 tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_b=
ound + tma_l3_miss_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtl=
b_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_s=
plit_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_boun=
d)) * (tma_split_loads / (tma_dtlb_load + tma_fb_full + tma_l1_latency_depe=
ndency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_mem=
ory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_l3_miss_bound + tma_store_bound)) * (tma_split_stores / (tma_dtlb_sto=
re + tma_false_sharing + tma_split_stores + tma_store_latency + tma_streami=
ng_stores)) + tma_memory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_=
bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_store_l=
atency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store=
_latency + tma_streaming_stores)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_bottleneck_data_cache_memory_latency",
         "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
@@ -434,7 +470,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_=
fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + =
tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_dram_bound=
 + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_dt=
lb_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_sto=
re_latency + tma_streaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound=
 + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + t=
ma_fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads=
 + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_l1_boun=
d + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (=
tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores + t=
ma_store_latency + tma_streaming_stores)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -442,7 +478,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
(tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) * tma_remote_cach=
e / (tma_local_mem + tma_remote_cache + tma_remote_mem) + tma_l3_bound / (t=
ma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_boun=
d) * (tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / =
(tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bo=
und) * tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_=
stores + tma_store_latency + tma_streaming_stores - tma_store_latency)) + t=
ma_machine_clears * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) * tma_remot=
e_cache / (tma_local_mem + tma_remote_cache + tma_remote_mem) + tma_l3_boun=
d / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_s=
tore_bound) * (tma_contested_accesses + tma_data_sharing) / (tma_contested_=
accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store=
_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + =
tma_store_bound) * tma_false_sharing / (tma_dtlb_store + tma_false_sharing =
+ tma_split_stores + tma_store_latency + tma_streaming_stores - tma_store_l=
atency)) + tma_machine_clears * (1 - tma_other_nukes / tma_other_nukes))",
         "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
         "MetricName": "tma_bottleneck_memory_synchronization",
         "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
@@ -594,13 +630,13 @@
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
         "MetricExpr": "74.6 * tma_info_system_core_frequency * (MEM_LOAD_L=
3_HIT_RETIRED.XSNP_NO_FWD + MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEM=
AND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR=
.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT=
 / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
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
@@ -621,15 +657,6 @@
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
-        "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_thread_cl=
ks",
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
@@ -681,7 +708,7 @@
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
@@ -974,7 +1001,7 @@
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
@@ -1092,7 +1119,7 @@
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
@@ -1161,6 +1188,14 @@
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
@@ -1402,7 +1437,7 @@
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
@@ -1482,7 +1517,7 @@
         "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / tma_info_system_time",
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
@@ -1532,13 +1567,6 @@
         "MetricName": "tma_info_system_mem_dram_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data=
-read prefetches"
     },
-    {
-        "BriefDescription": "Fraction of Uncore cycles where requests got =
rejected due to duplicate address already in IRQ ingress queue in the cache=
 homing agent",
-        "MetricExpr": "UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH / UNC_CHA_CLOCKTIC=
KS",
-        "MetricGroup": "LockCont;MemOffcore;Server;SoC",
-        "MetricName": "tma_info_system_mem_irq_duplicate_address",
-        "MetricThreshold": "tma_info_system_mem_irq_duplicate_address > 0.=
1"
-    },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
         "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_OCC=
UPANCY.IA_MISS_DRD@thresh\\=3D1@",
@@ -1591,12 +1619,6 @@
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
@@ -1752,6 +1774,15 @@
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
+        "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_thread_cl=
ks",
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
@@ -1826,14 +1857,14 @@
         "MetricExpr": "72 * tma_info_system_core_frequency * MEM_LOAD_L3_M=
ISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1=
_MISS / 2) / tma_info_thread_clks",
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
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
+        "MetricExpr": "LOCK_CYCLES.CACHE_LOCK_DURATION / tma_info_thread_c=
lks",
         "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
@@ -1856,24 +1887,24 @@
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
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
-        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D12@) / tma_info_thread_clks",
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
@@ -1937,7 +1968,7 @@
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
@@ -1954,7 +1985,7 @@
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
@@ -2090,7 +2121,7 @@
         "MetricExpr": "(133 * tma_info_system_core_frequency * MEM_LOAD_L3=
_MISS_RETIRED.REMOTE_HITM + 133 * tma_info_system_core_frequency * MEM_LOAD=
_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS / 2) / tma_info_thread_clks",
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
@@ -2099,7 +2130,7 @@
         "MetricExpr": "153 * tma_info_system_core_frequency * MEM_LOAD_L3_=
MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
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
@@ -2143,7 +2174,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
-        "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCKS.=
NO_SR / tma_info_thread_clks",
+        "MetricExpr": "MEM_INST_RETIRED.SPLIT_LOADS * tma_info_memory_load=
_miss_real_latency / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.3",
@@ -2165,7 +2196,7 @@
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
@@ -2277,6 +2308,12 @@
         "MetricName": "uncore_frequency",
         "ScaleUnit": "1GHz"
     },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data r=
eceive bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / 1e=
6 / duration_time",
+        "MetricName": "upi_data_receive_bw",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data t=
ransmit bandwidth (MB/sec)",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e=
6 / duration_time",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/metricgroups.json=
 b/tools/perf/pmu-events/arch/x86/emeraldrapids/metricgroups.json
index 9129fb7b7ce4..b5f601991e9d 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/metricgroups.json
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
--
2.55.0.795.g602f6c329a-goog

