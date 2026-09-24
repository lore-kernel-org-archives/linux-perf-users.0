Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3823D9DD8
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228294; cv=none; b=BXg1ipqCRMaPCjzSKG8F7VfbXnDKENTwDrxGvs6hwA+AkUMGik+T/xdYfdhoI+hth0QeFbHA6s5KzJcPIKgmVscRcIUh7ZUZlDO07G5f29lGZNM8ukA2ghWBVlq8Y8+RWcfh/PMfsG/EWIiP+XcZcf56AjV7c8ZBqZZdrYAgX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228294; c=relaxed/simple;
	bh=BT2+AuHewyWNXqNaQmwXf0x/jI/VC3GAVoV1JD64f8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dUQpE3VAYZKk4Oi/oZd2de+LJf/8aGAZsYTEpXnpxw3BXnvBoMHLFWIl8Phh2voxf+fydWsNltoDr3qtso63hEgG8cSdE0c8gLI/CsaarYDwJh+r6gCkOhxS0aAs7sUDVSnENhB7nLM1iLZeg0gyHduw8fPt+kt9ZTe9NbbyxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHMvwFrF; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHMvwFrF"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1416f32fe11so2296688c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228287; x=1790833087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+RXFu999uZAOd62Ct+unkiQWnkDyz4LeGAsER2RxP7g=;
        b=YHMvwFrFAB01HglRMOZMBMKvfZRiFnJg3Kz6qaZQ9gFcyutomyEWZwcTBVPitVgSFO
         ObXAibBU9n983RRrF+SlOUC7sTd4nDV2P7vZpt4nL9fbnKiWXGY0Of3G6Z91xiI03TZJ
         7qfnxjJVUX4sW++oF2adh/UIoOHxPYDSNW+R73BiVt9ORVhfMDAW3LCiovUybn/4DWBU
         PeT+io04beZwTKmsOZ2vDHHXErIkpYpOoBlJm1hRn19/IjhWfRgupZ1XvcUCESu48tyJ
         AoSbs5HvFeL4gNdFUFgo+i0R4AMOiF6YNodUpSzCQCI1UGna8ubL+HHRsdS4pdbCQ9ie
         BojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228287; x=1790833087;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+RXFu999uZAOd62Ct+unkiQWnkDyz4LeGAsER2RxP7g=;
        b=kGFfgeMYhKKgzNqeV9YG/whiJrf+XfKO2KFLr+ZSZpujoRAq51gcEM230o9tywcOTT
         H5dbWQZWI860q6R7Uj0ejwgdcvDy0uwgJCK3fMPrXaF+QqsGgV6aPReE1QHrSI7Apver
         F4MPaVIY4GIbDthxyHNR76cagiYd82R7il0V1zeWENnmOFSzpu328tZvdJFeeR5GU1tc
         uv/ZI9oLxeby6t93+tTn+1L6zAX5a6VLezFO86xQdDFpWEGYPyu+dr36hZ62qx9YvvtQ
         pXaOQfFrS+97v6JDJ21l31q6nhptWInDxvgySgqq8D5JS+n6uyDNUc4y4zjwPjlyroQm
         IGzg==
X-Forwarded-Encrypted: i=1; AKwUvBwCTUKxY2gc1lQsTWvfL8XnN4xvOeoSHAbd18z8VvX6RUnbVLkPfbRJovGvlDmIlcYQfRkohv1jraDWhEUgFaZo@vger.kernel.org
X-Gm-Message-State: AFuF++nkC5yCkgVHYS9qd2BqsYKeDZUgzWmEGBiE1b7Y6G8WDZ7MNFIL
	3eMt/7B47STUA7p1/hb3tl27wKj4oB6G++Axcr/VoJ/O4pyZZwATYkYouxR/uD3XwVdbqLHIRqK
	bkBiU2ldzdg==
X-Received: from dlbqs7.prod.google.com ([2002:a05:7023:d07:b0:144:e4a2:1056])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:c968:b0:143:3c9f:10a6
 with SMTP id a92af1059eb24-14503fc11dfmr928843c88.4.1790228286910; Wed, 23
 Sep 2026 22:38:06 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:29 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-6-irogers@google.com>
Subject: [PATCH v1 05/21] perf vendor events intel: Update cascadelakex
 metrics to TMA 5.2
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated TMA metrics were published in:

  https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a887=
ad46c45

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/cascadelakex/clx-metrics.json    | 94 +++++++------------
 .../arch/x86/cascadelakex/metricgroups.json   |  3 +-
 2 files changed, 34 insertions(+), 63 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b=
/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 2e50a91b6728..8aec1fa7d519 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -383,16 +383,16 @@
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_cx=
l_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_late=
ncy)) + tma_memory_bound * (tma_l3_bound / (tma_cxl_mem_bound + tma_dram_bo=
und + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma=
_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_latency =
+ tma_sq_full)) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_bound + t=
ma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_boun=
d)) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l=
1_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_b=
lk)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_cxl_mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_b=
ound + tma_store_bound)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_me=
m_latency)) + tma_memory_bound * (tma_l3_bound / (tma_cxl_mem_bound + tma_l=
1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound=
)) * (tma_sq_full / (tma_contested_accesses + tma_data_sharing + tma_l3_hit=
_latency + tma_sq_full)) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_=
bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tm=
a_store_bound)) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load + tma_fb_=
full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma=
_store_fwd_blk)))",
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
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_cx=
l_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latenc=
y)) + tma_memory_bound * (tma_l3_bound / (tma_cxl_mem_bound + tma_dram_boun=
d + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l=
3_hit_latency / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_lat=
ency + tma_sq_full)) + tma_memory_bound * tma_l2_bound / (tma_cxl_mem_bound=
 + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_=
bound) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_bound + tma_dram_b=
ound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tm=
a_l1_latency_dependency / (tma_4k_aliasing + tma_dtlb_load + tma_fb_full + =
tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_=
fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_bound + tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * =
(tma_lock_latency / (tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1=
_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_bl=
k)) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_bound + tma_dram_boun=
d + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_s=
plit_loads / (tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1_latenc=
y_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + t=
ma_memory_bound * (tma_store_bound / (tma_cxl_mem_bound + tma_dram_bound + =
tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_split=
_stores / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_stor=
e_latency)) + tma_memory_bound * (tma_store_bound / (tma_cxl_mem_bound + tm=
a_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound=
)) * (tma_store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_s=
tores + tma_store_latency)))",
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
e_bound)) * (tma_l1_latency_dependency / (tma_4k_aliasing + tma_dtlb_load +=
 tma_fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loa=
ds + tma_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_=
bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tm=
a_store_bound)) * (tma_lock_latency / (tma_4k_aliasing + tma_dtlb_load + tm=
a_fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads =
+ tma_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_s=
tore_bound)) * (tma_split_loads / (tma_4k_aliasing + tma_dtlb_load + tma_fb=
_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tm=
a_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_cxl_mem_boun=
d + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_st=
ore_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sharing + tma=
_split_stores + tma_store_latency)) + tma_memory_bound * (tma_store_bound /=
 (tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_m=
iss_bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb_store + tma_=
false_sharing + tma_split_stores + tma_store_latency)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_bottleneck_data_cache_memory_latency",
         "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
@@ -418,7 +418,7 @@
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_cxl_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bou=
nd + tma_l3_bound + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, =
tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency +=
 tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_boun=
d * (tma_store_bound / (tma_cxl_mem_bound + tma_dram_bound + tma_l1_bound +=
 tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_dtlb_store / (tma_d=
tlb_store + tma_false_sharing + tma_split_stores + tma_store_latency)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_l3_miss_bound + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_boun=
d, tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1_latency_dependenc=
y + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_b=
ound * (tma_store_bound / (tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound =
+ tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_dtlb_store / =
(tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency)=
))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -427,7 +427,7 @@
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
         "MetricConstraint": "NO_GROUP_EVENTS",
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
ore_latency - tma_store_latency)) + tma_machine_clears * (1 - tma_other_nuk=
es / tma_other_nukes))",
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
res + tma_store_latency - tma_store_latency)) + tma_machine_clears * (1 - t=
ma_other_nukes / tma_other_nukes))",
         "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
         "MetricName": "tma_bottleneck_memory_synchronization",
         "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
@@ -537,7 +537,7 @@
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
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. Re=
lated metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related m=
etrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false_=
sharing, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
@@ -561,13 +561,13 @@
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
         "MetricExpr": "44 * tma_info_system_core_frequency * (MEM_LOAD_L3_=
HIT_RETIRED.XSNP_HIT + MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (1 - OCR.DEMAND_=
DATA_RD.L3_HIT.HITM_OTHER_CORE / (OCR.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE=
 + OCR.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_CORE_FWD))) * (1 + MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
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
AD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_bottleneck_memory_synch=
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
@@ -588,16 +588,6 @@
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_cl=
ks + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma=
_info_thread_clks - tma_l2_bound - tma_cxl_mem_bound if #has_pmem > 0 else =
CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clks + (CYCLE_ACTIVITY.STAL=
LS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_thread_clks - tma_l=
2_bound)",
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
@@ -642,7 +632,7 @@
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM. Related=
 metrics: tma_bottleneck_memory_synchronization, tma_contested_accesses, tm=
a_data_sharing, tma_machine_clears, tma_remote_cache",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronization, t=
ma_contested_accesses, tma_data_sharing, tma_machine_clears, tma_remote_cac=
he",
         "ScaleUnit": "100%"
     },
     {
@@ -652,7 +642,7 @@
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
@@ -1272,7 +1262,7 @@
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
@@ -1344,7 +1334,7 @@
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
@@ -1429,29 +1419,6 @@
         "MetricGroup": "Power;SoC",
         "MetricName": "tma_info_system_power"
     },
-    {
-        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for baseline license level 0",
-        "MetricExpr": "(CORE_POWER.LVL0_TURBO_LICENSE / 2 / tma_info_core_=
core_clks if #SMT_on else CORE_POWER.LVL0_TURBO_LICENSE / tma_info_core_cor=
e_clks)",
-        "MetricGroup": "Power",
-        "MetricName": "tma_info_system_power_license0_utilization",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes."
-    },
-    {
-        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 1",
-        "MetricExpr": "(CORE_POWER.LVL1_TURBO_LICENSE / 2 / tma_info_core_=
core_clks if #SMT_on else CORE_POWER.LVL1_TURBO_LICENSE / tma_info_core_cor=
e_clks)",
-        "MetricGroup": "Power",
-        "MetricName": "tma_info_system_power_license1_utilization",
-        "MetricThreshold": "tma_info_system_power_license1_utilization > 0=
.5",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions."
-    },
-    {
-        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 2 (introduced in SKX)",
-        "MetricExpr": "(CORE_POWER.LVL2_TURBO_LICENSE / 2 / tma_info_core_=
core_clks if #SMT_on else CORE_POWER.LVL2_TURBO_LICENSE / tma_info_core_cor=
e_clks)",
-        "MetricGroup": "Power",
-        "MetricName": "tma_info_system_power_license2_utilization",
-        "MetricThreshold": "tma_info_system_power_license2_utilization > 0=
.5",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions."
-    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
@@ -1477,12 +1444,6 @@
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
         "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
@@ -1593,6 +1554,15 @@
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
+        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_cl=
ks + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma=
_info_thread_clks - tma_l2_bound - tma_cxl_mem_bound if #has_pmem > 0 else =
CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clks + (CYCLE_ACTIVITY.STAL=
LS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_thread_clks - tma_l=
2_bound)",
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
@@ -1671,7 +1641,7 @@
         "MetricExpr": "59.5 * tma_info_system_core_frequency * MEM_LOAD_L3=
_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
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
@@ -1699,18 +1669,18 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
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
@@ -1767,7 +1737,7 @@
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
@@ -1776,7 +1746,7 @@
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
@@ -1948,7 +1918,7 @@
         "MetricExpr": "(89.5 * tma_info_system_core_frequency * MEM_LOAD_L=
3_MISS_RETIRED.REMOTE_HITM + 89.5 * tma_info_system_core_frequency * MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS / 2) / tma_info_thread_clks",
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
@@ -1957,7 +1927,7 @@
         "MetricExpr": "127 * tma_info_system_core_frequency * MEM_LOAD_L3_=
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
@@ -2014,7 +1984,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/metricgroups.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/metricgroups.json
index a579603f720b..63323add9db4 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/metricgroups.json
@@ -88,7 +88,6 @@
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
@@ -97,6 +96,7 @@
     "tma_fp_vector_group": "Metrics contributing to tma_fp_vector category=
",
     "tma_frontend_bound_group": "Metrics contributing to tma_frontend_boun=
d category",
     "tma_heavy_operations_group": "Metrics contributing to tma_heavy_opera=
tions category",
+    "tma_icache_misses_group": "Metrics contributing to tma_icache_misses =
category",
     "tma_issue2P": "Metrics related by the issue $issue2P",
     "tma_issueBM": "Metrics related by the issue $issueBM",
     "tma_issueBW": "Metrics related by the issue $issueBW",
@@ -120,6 +120,7 @@
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
--=20
2.56.0.rc1.310.g51773c2048-goog

