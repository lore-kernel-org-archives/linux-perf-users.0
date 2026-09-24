Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075041D216
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269471; cv=none; b=hK5pPVWBMYoDR3fNERFpWWwzp1uJQbNys96Nr8dVj5iRTFA6kQm2/XxugaocT141oNBxq0Ivz+84ug+Tq5MNwYMXV7So+tuIdIbGtwYxCgxGX9cnI+ouM+bD+tLbpDb4cGyBZ3HSTUUy5ON/bC6nsum4BCMVZAUHovrDAmoc15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269471; c=relaxed/simple;
	bh=6oI8MORuL642eQ0QUUd+afXCHFbXto36DhtD1hrc13s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ewzLWOT947PhTZKz1OVRgWvAq/dGRrQI5GVJhXiWOJ9Nx8THEiExmW9T4DpaY/JXvrvD00nb8MIwK4p3EGPCFidQuyiliefkJjuN9Eyn1Is9D2/3kicv+WRXYA8lEf91Q3vgmM/Itxs84Tpp1QzSnC+EnbyB+FEFYcsHPDtdt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1SeqQ/X; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1SeqQ/X"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so103729c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269463; x=1790874263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RedmzXASCdGxOiCGTv9sQJ9yl0bsYgaZQssXfuEUzFY=;
        b=Z1SeqQ/X5xxPu5HyMnnUArbjbfkWwiNpQs1l9/bUvK8e7M2CGA4eJUQo9hx8UsimZK
         bSzmD9aod9uhEn0OdqF4mpELbmvUdGnfDSm0e6OfipFQleKuQdAWuiy7mtE7ro4Uv8kh
         f6svFcqxOPTpSjNQOMS62jxCF5JENenb7GrkBG7KTTKldHglSyZXknZelYSzwaQN+9QY
         hf1VSLL28z9jjkWhDSuFGTMek9R43v5lp/fgC2/d/Q+9pvOoDmGF9fqzLU3G+LL93oDP
         c8xqHZezawhIuqRDsOwewXlFd9tC2iiLcPIZKRSQFnQCFkQT5CGrgKjpVvl8g9Sh5p4e
         mryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269463; x=1790874263;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RedmzXASCdGxOiCGTv9sQJ9yl0bsYgaZQssXfuEUzFY=;
        b=kd3nGvssiROwJKNVFlDNhyz0MZd0DrxsSLCZ2wxKoCuLXAbJCHtV2pmGFAQ5v01qwQ
         kXRhEDhTw8Go8r4XaXyG67k0QSevtXv6lHylz5sbYeGB+CxkJrZ+LtiUiDIhHbpff+vA
         TZZdoX0SxnG6aWxjB5qp2gOaEfRzul8sys97lcw3aWX5sfZZpO/d8F5yzevjytpwN/f1
         MuE7wT2bwS4x4WzJRR5KOT05/8xP9s6kDyfdc3vamzqnsv1wT/+Q5eBPeiX4eKEWgpSA
         eyeRJnra2ujTxlnN7O+5b0c4U62+0m/4Q9weEbKOlN6lxLP6954Dq7Ap+dr779kEIdcF
         ng3w==
X-Forwarded-Encrypted: i=1; AKwUvByhsqRIHc2c0RFY02eCFlKxnlgYpASfEuANDkLw7Axz/G+/n6cbtfICTpa/4IqbwzLVQIQkzyO4BXIT/eHU8EHg@vger.kernel.org
X-Gm-Message-State: AFuF++lTS7+uiX4V738VYxgSP1+Y+nkWnjreWHZd1nufVkKIId0ozsnq
	lf+hMJCMxot1+zlklTBVk+TSafYxvWLgm1jmTjVQmZi39iCs7RG8rbTVywbv6p2/rQoTDT2XCKx
	VBBe9hdw/yw==
X-Received: from dlbsn1.prod.google.com ([2002:a05:7022:b901:b0:143:83fd:ad8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:420c:20b0:141:b2c3:d868
 with SMTP id a92af1059eb24-14503f85054mr2769890c88.3.1790269462358; Thu, 24
 Sep 2026 10:04:22 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:30 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-11-irogers@google.com>
Subject: [PATCH v2 10/26] perf vendor events intel: Update icelakex events to
 1.31 and TMA metrics to 5.2
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:

  https://github.com/intel/perfmon/commit/563ea935e283a7fc5bf49bbc082fab5be=
81af5b7

The updated TMA 5.2 metrics were published in:

  https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a887=
ad46c45

Fix umask encodings for UMaskExt.

Fixes: f42a7d02b7a3 ("perf vendor events intel: Fix uncore topics for icela=
kex")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/icelakex/icx-metrics.json        | 101 ++++++------------
 .../pmu-events/arch/x86/icelakex/memory.json  |  24 +++++
 .../arch/x86/icelakex/metricgroups.json       |   2 +-
 .../pmu-events/arch/x86/icelakex/other.json   |   9 ++
 .../arch/x86/icelakex/pipeline.json           |   7 +-
 .../arch/x86/icelakex/uncore-cache.json       |  79 ++++++++++++++
 .../x86/icelakex/uncore-interconnect.json     |  22 ++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 8 files changed, 171 insertions(+), 75 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index f58eec2a1788..b771243f2f96 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -435,16 +435,16 @@
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
e_latency + tma_streaming_stores)) + tma_memory_bound * (tma_store_bound / =
(tma_cxl_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_=
bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb_store + tma_fals=
e_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores)))"=
,
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
_split_stores + tma_store_latency + tma_streaming_stores)) + tma_memory_bou=
nd * (tma_store_bound / (tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound + =
tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_store_latency /=
 (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency=
 + tma_streaming_stores)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_bottleneck_data_cache_memory_latency",
         "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
@@ -470,7 +470,7 @@
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
tlb_store + tma_false_sharing + tma_split_stores + tma_store_latency + tma_=
streaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_l3_miss_bound + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_boun=
d, tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1_latency_dependenc=
y + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_b=
ound * (tma_store_bound / (tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound =
+ tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_dtlb_store / =
(tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency =
+ tma_streaming_stores)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -479,7 +479,7 @@
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
@@ -611,7 +611,7 @@
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
@@ -634,13 +634,13 @@
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
         "MetricExpr": "43.5 * tma_info_system_core_frequency * (MEM_LOAD_L=
3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (1 - OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.D=
EMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT /=
 MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
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
@@ -661,16 +661,6 @@
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
@@ -722,7 +712,7 @@
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
@@ -1008,7 +998,7 @@
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
o_thread_ipc / 5 > 0.35",
@@ -1370,7 +1360,7 @@
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
@@ -1442,7 +1432,7 @@
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
@@ -1492,13 +1482,6 @@
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
         "MetricConstraint": "NO_GROUP_EVENTS",
@@ -1534,29 +1517,6 @@
         "MetricGroup": "Power;SoC",
         "MetricName": "tma_info_system_power"
     },
-    {
-        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for baseline license level 0",
-        "MetricExpr": "CORE_POWER.LVL0_TURBO_LICENSE / tma_info_core_core_=
clks",
-        "MetricGroup": "Power",
-        "MetricName": "tma_info_system_power_license0_utilization",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes."
-    },
-    {
-        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 1",
-        "MetricExpr": "CORE_POWER.LVL1_TURBO_LICENSE / tma_info_core_core_=
clks",
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
-        "MetricExpr": "CORE_POWER.LVL2_TURBO_LICENSE / tma_info_core_core_=
clks",
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
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_U=
NHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
@@ -1582,12 +1542,6 @@
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
@@ -1711,6 +1665,15 @@
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
@@ -1784,7 +1747,7 @@
         "MetricExpr": "43.5 * tma_info_system_core_frequency * MEM_LOAD_L3=
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
@@ -1811,18 +1774,18 @@
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
@@ -1886,7 +1849,7 @@
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
@@ -1903,7 +1866,7 @@
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
@@ -2027,7 +1990,7 @@
         "MetricExpr": "(97 * tma_info_system_core_frequency * MEM_LOAD_L3_=
MISS_RETIRED.REMOTE_HITM + 97 * tma_info_system_core_frequency * MEM_LOAD_L=
3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRE=
D.L1_MISS / 2) / tma_info_thread_clks",
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
@@ -2036,7 +1999,7 @@
         "MetricExpr": "108 * tma_info_system_core_frequency * MEM_LOAD_L3_=
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
@@ -2093,7 +2056,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/memory.json b/tools/pe=
rf/pmu-events/arch/x86/icelakex/memory.json
index ca7f68f67463..bb328ed2e7ae 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/memory.json
@@ -17,6 +17,18 @@
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "SampleAfterValue": "53",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -41,6 +53,18 @@
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2048 cycles.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "SampleAfterValue": "23",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/metricgroups.json b/to=
ols/perf/pmu-events/arch/x86/icelakex/metricgroups.json
index 4a28187c2896..63323add9db4 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/metricgroups.json
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
@@ -121,6 +120,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/other.json b/tools/per=
f/pmu-events/arch/x86/icelakex/other.json
index 141cd30a30af..73c9187b4fdf 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/other.json
@@ -26,6 +26,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Increments whenever there is an update to the=
 LBR array. [This event is alias to MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcc",
+        "EventName": "LBR_INSERTS.ANY",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR to be enabled properly. [This ev=
ent is alias to MISC_RETIRED.LBR_INSERTS]",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that have any type of response.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/icelakex/pipeline.json
index f3a0d7f49af4..45336cede2fe 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
@@ -170,11 +170,10 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
         "SampleAfterValue": "50021",
         "UMask": "0x8"
     },
@@ -531,11 +530,11 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
+        "BriefDescription": "Increments whenever there is an update to the=
 LBR array. [This event is alias to LBR_INSERTS.ANY]",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR to be enabled properly.",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR to be enabled properly. [This ev=
ent is alias to LBR_INSERTS.ANY]",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
index 1c225192ba34..939ad1e0ca4c 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
@@ -1927,6 +1927,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : All Request Filter : Counts =
the number of times the LLC was accessed - this includes code, data, prefet=
ches and hints coming from L2.  This has numerous filters available.  Note =
the non-standard filtering equation.  This event will count requests that l=
ookup the cache multiple times with multiple increments.  One must ALWAYS s=
elect a state or states (in the umask field) to match.  Otherwise, the even=
t will count nothing. : Any local or remote transaction to the LLC, includi=
ng prefetch.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -1970,6 +1971,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : CRd Request Filter : Counts =
the number of times the LLC was accessed - this includes code, data, prefet=
ches and hints coming from L2.  This has numerous filters available.  Note =
the non-standard filtering equation.  This event will count requests that l=
ookup the cache multiple times with multiple increments.  One must ALWAYS s=
elect a state or states (in the umask field) to match.  Otherwise, the even=
t will count nothing. : Local or remote CRd transactions to the LLC.  This =
includes CRd prefetch.",
+        "UMask": "0x1000",
         "Unit": "CHA"
     },
     {
@@ -2024,6 +2026,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Local request Filter : Count=
s the number of times the LLC was accessed - this includes code, data, pref=
etches and hints coming from L2.  This has numerous filters available.  Not=
e the non-standard filtering equation.  This event will count requests that=
 lookup the cache multiple times with multiple increments.  One must ALWAYS=
 select a state or states (in the umask field) to match.  Otherwise, the ev=
ent will count nothing. : Any local transaction to the LLC, including prefe=
tches from the Core",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -2066,6 +2069,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Data Read Request Filter : C=
ounts the number of times the LLC was accessed - this includes code, data, =
prefetches and hints coming from L2.  This has numerous filters available. =
 Note the non-standard filtering equation.  This event will count requests =
that lookup the cache multiple times with multiple increments.  One must AL=
WAYS select a state or states (in the umask field) to match.  Otherwise, th=
e event will count nothing. : Read transactions.",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -2175,6 +2179,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Flush or Invalidate Filter :=
 Counts the number of times the LLC was accessed - this includes code, data=
, prefetches and hints coming from L2.  This has numerous filters available=
.  Note the non-standard filtering equation.  This event will count request=
s that lookup the cache multiple times with multiple increments.  One must =
ALWAYS select a state or states (in the umask field) to match.  Otherwise, =
the event will count nothing.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -2207,6 +2212,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Local LLC prefetch requests =
(from LLC) Filter : Counts the number of times the LLC was accessed - this =
includes code, data, prefetches and hints coming from L2.  This has numerou=
s filters available.  Note the non-standard filtering equation.  This event=
 will count requests that lookup the cache multiple times with multiple inc=
rements.  One must ALWAYS select a state or states (in the umask field) to =
match.  Otherwise, the event will count nothing. : Any local LLC prefetch t=
o the LLC",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -2239,6 +2245,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Transactions homed locally F=
ilter : Counts the number of times the LLC was accessed - this includes cod=
e, data, prefetches and hints coming from L2.  This has numerous filters av=
ailable.  Note the non-standard filtering equation.  This event will count =
requests that lookup the cache multiple times with multiple increments.  On=
e must ALWAYS select a state or states (in the umask field) to match.  Othe=
rwise, the event will count nothing. : Transaction whose address resides in=
 the local MC.",
+        "UMask": "0x80000",
         "Unit": "CHA"
     },
     {
@@ -2282,6 +2289,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Write Request Filter : Count=
s the number of times the LLC was accessed - this includes code, data, pref=
etches and hints coming from L2.  This has numerous filters available.  Not=
e the non-standard filtering equation.  This event will count requests that=
 lookup the cache multiple times with multiple increments.  One must ALWAYS=
 select a state or states (in the umask field) to match.  Otherwise, the ev=
ent will count nothing. : Writeback transactions to the LLC  This includes =
all write transactions -- both Cacheable and UC.",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -2292,6 +2300,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Remote non-snoop request Fil=
ter : Counts the number of times the LLC was accessed - this includes code,=
 data, prefetches and hints coming from L2.  This has numerous filters avai=
lable.  Note the non-standard filtering equation.  This event will count re=
quests that lookup the cache multiple times with multiple increments.  One =
must ALWAYS select a state or states (in the umask field) to match.  Otherw=
ise, the event will count nothing. : Non-snoop transactions to the LLC from=
 remote agent",
+        "UMask": "0x20000",
         "Unit": "CHA"
     },
     {
@@ -2412,6 +2421,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Transactions homed remotely =
Filter : Counts the number of times the LLC was accessed - this includes co=
de, data, prefetches and hints coming from L2.  This has numerous filters a=
vailable.  Note the non-standard filtering equation.  This event will count=
 requests that lookup the cache multiple times with multiple increments.  O=
ne must ALWAYS select a state or states (in the umask field) to match.  Oth=
erwise, the event will count nothing. : Transaction whose address resides i=
n a remote MC",
+        "UMask": "0x100000",
         "Unit": "CHA"
     },
     {
@@ -2422,6 +2432,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Remote snoop request Filter =
: Counts the number of times the LLC was accessed - this includes code, dat=
a, prefetches and hints coming from L2.  This has numerous filters availabl=
e.  Note the non-standard filtering equation.  This event will count reques=
ts that lookup the cache multiple times with multiple increments.  One must=
 ALWAYS select a state or states (in the umask field) to match.  Otherwise,=
 the event will count nothing. : Snoop transactions to the LLC from remote =
agent",
+        "UMask": "0x40000",
         "Unit": "CHA"
     },
     {
@@ -2465,6 +2476,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : RFO Request Filter : Counts =
the number of times the LLC was accessed - this includes code, data, prefet=
ches and hints coming from L2.  This has numerous filters available.  Note =
the non-standard filtering equation.  This event will count requests that l=
ookup the cache multiple times with multiple increments.  One must ALWAYS s=
elect a state or states (in the umask field) to match.  Otherwise, the even=
t will count nothing. : Local or remote RFO transactions to the LLC.  This =
includes RFO prefetch.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -2650,6 +2662,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Local Only : Counts the n=
umber of lines that were victimized on a fill.  This can be filtered by the=
 state that the line was in.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -2715,6 +2728,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Remote Only : Counts the =
number of lines that were victimized on a fill.  This can be filtered by th=
e state that the line was in.",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -2888,6 +2902,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x10000000",
         "Unit": "CHA"
     },
     {
@@ -2898,6 +2913,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x20000000",
         "Unit": "CHA"
     },
     {
@@ -2908,6 +2924,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x80000",
         "Unit": "CHA"
     },
     {
@@ -2918,6 +2935,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x8000000",
         "Unit": "CHA"
     },
     {
@@ -2928,6 +2946,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -2982,6 +3001,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x40000000",
         "Unit": "CHA"
     },
     {
@@ -2992,6 +3012,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x10000",
         "Unit": "CHA"
     },
     {
@@ -3002,6 +3023,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -3023,6 +3045,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -3033,6 +3056,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x200000",
         "Unit": "CHA"
     },
     {
@@ -3043,6 +3067,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x4000000",
         "Unit": "CHA"
     },
     {
@@ -3053,6 +3078,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x800000",
         "Unit": "CHA"
     },
     {
@@ -3063,6 +3089,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x1000000",
         "Unit": "CHA"
     },
     {
@@ -3073,6 +3100,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -3083,6 +3111,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -3093,6 +3122,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x40000",
         "Unit": "CHA"
     },
     {
@@ -3103,6 +3133,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -3146,6 +3177,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x100000",
         "Unit": "CHA"
     },
     {
@@ -3156,6 +3188,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x20000",
         "Unit": "CHA"
     },
     {
@@ -3166,6 +3199,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x400000",
         "Unit": "CHA"
     },
     {
@@ -3176,6 +3210,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x2000000",
         "Unit": "CHA"
     },
     {
@@ -3186,6 +3221,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x1000",
         "Unit": "CHA"
     },
     {
@@ -3196,6 +3232,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x80000000",
         "Unit": "CHA"
     },
     {
@@ -3206,6 +3243,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x100000000",
         "Unit": "CHA"
     },
     {
@@ -3216,6 +3254,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x200000000",
         "Unit": "CHA"
     },
     {
@@ -3226,6 +3265,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Pipe Rejects : More Miscellaneous events in =
the Cbo.",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -3443,6 +3483,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx READ Credits Empty : MC10 : Cou=
nts the number of times when there are no credits available for sending rea=
ds from the CHA into the iMC.  In order to send reads into the memory contr=
oller, the HA must first acquire a credit for the iMC's AD Ingress queue. :=
 Filter for memory controller 10 only.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -3453,6 +3494,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx READ Credits Empty : MC11 : Cou=
nts the number of times when there are no credits available for sending rea=
ds from the CHA into the iMC.  In order to send reads into the memory contr=
oller, the HA must first acquire a credit for the iMC's AD Ingress queue. :=
 Filter for memory controller 11 only.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -3463,6 +3505,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx READ Credits Empty : MC12 : Cou=
nts the number of times when there are no credits available for sending rea=
ds from the CHA into the iMC.  In order to send reads into the memory contr=
oller, the HA must first acquire a credit for the iMC's AD Ingress queue. :=
 Filter for memory controller 12 only.",
+        "UMask": "0x1000",
         "Unit": "CHA"
     },
     {
@@ -3473,6 +3516,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx READ Credits Empty : MC13 : Cou=
nts the number of times when there are no credits available for sending rea=
ds from the CHA into the iMC.  In order to send reads into the memory contr=
oller, the HA must first acquire a credit for the iMC's AD Ingress queue. :=
 Filter for memory controller 13 only.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -3549,6 +3593,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx READ Credits Empty : MC8 : Coun=
ts the number of times when there are no credits available for sending read=
s from the CHA into the iMC.  In order to send reads into the memory contro=
ller, the HA must first acquire a credit for the iMC's AD Ingress queue. : =
Filter for memory controller 8 only.",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -3559,6 +3604,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx READ Credits Empty : MC9 : Coun=
ts the number of times when there are no credits available for sending read=
s from the CHA into the iMC.  In order to send reads into the memory contro=
ller, the HA must first acquire a credit for the iMC's AD Ingress queue. : =
Filter for memory controller 9 only.",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -6738,6 +6784,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DDR4 Access : Counts the numbe=
r of entries successfully inserted into the TOR that match qualifications s=
pecified by the subevent.   Does not include addressless requests such as l=
ocks and interrupts.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -6748,6 +6795,7 @@
         "EventName": "UNC_CHA_TOR_INSERTS.DDR4",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -6769,6 +6817,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Hits : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.   Does not include addressless requests such as loc=
ks and interrupts.",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -8290,6 +8339,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just ISOC : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.   Does not include addressless requests such as loc=
ks and interrupts.",
+        "UMask": "0x200000000",
         "Unit": "CHA"
     },
     {
@@ -8300,6 +8350,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Local Targets : Counts th=
e number of entries successfully inserted into the TOR that match qualifica=
tions specified by the subevent.   Does not include addressless requests su=
ch as locks and interrupts.",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -8343,6 +8394,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Match the Opcode in b[29:19] o=
f the extended umask field : Counts the number of entries successfully inse=
rted into the TOR that match qualifications specified by the subevent.   Do=
es not include addressless requests such as locks and interrupts.",
+        "UMask": "0x20000",
         "Unit": "CHA"
     },
     {
@@ -8353,6 +8405,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Misses : Counts the numbe=
r of entries successfully inserted into the TOR that match qualifications s=
pecified by the subevent.   Does not include addressless requests such as l=
ocks and interrupts.",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -8363,6 +8416,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : MMCFG Access : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.   Does not include addressless requests such as =
locks and interrupts.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -8373,6 +8427,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just NearMem : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.   Does not include addressless requests such as =
locks and interrupts.",
+        "UMask": "0x40000000",
         "Unit": "CHA"
     },
     {
@@ -8383,6 +8438,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just NonCoherent : Counts the =
number of entries successfully inserted into the TOR that match qualificati=
ons specified by the subevent.   Does not include addressless requests such=
 as locks and interrupts.",
+        "UMask": "0x100000000",
         "Unit": "CHA"
     },
     {
@@ -8393,6 +8449,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just NotNearMem : Counts the n=
umber of entries successfully inserted into the TOR that match qualificatio=
ns specified by the subevent.   Does not include addressless requests such =
as locks and interrupts.",
+        "UMask": "0x80000000",
         "Unit": "CHA"
     },
     {
@@ -8403,6 +8460,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : PMM Access : Counts the number=
 of entries successfully inserted into the TOR that match qualifications sp=
ecified by the subevent.   Does not include addressless requests such as lo=
cks and interrupts.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -8413,6 +8471,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Match the PreMorphed Opcode in=
 b[29:19] of the extended umask field : Counts the number of entries succes=
sfully inserted into the TOR that match qualifications specified by the sub=
event.   Does not include addressless requests such as locks and interrupts=
.",
+        "UMask": "0x40000",
         "Unit": "CHA"
     },
     {
@@ -8445,6 +8504,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Remote Targets : Counts t=
he number of entries successfully inserted into the TOR that match qualific=
ations specified by the subevent.   Does not include addressless requests s=
uch as locks and interrupts.",
+        "UMask": "0x10000",
         "Unit": "CHA"
     },
     {
@@ -8477,6 +8537,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DDR4 Access : For each cycle=
, this event accumulates the number of valid entries in the TOR that match =
qualifications specified by the subevent.     Does not include addressless =
requests such as locks and interrupts.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -8498,6 +8559,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Hits : For each cycle, =
this event accumulates the number of valid entries in the TOR that match qu=
alifications specified by the subevent.     Does not include addressless re=
quests such as locks and interrupts.",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -9854,6 +9916,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just ISOC : For each cycle, =
this event accumulates the number of valid entries in the TOR that match qu=
alifications specified by the subevent.     Does not include addressless re=
quests such as locks and interrupts.",
+        "UMask": "0x200000000",
         "Unit": "CHA"
     },
     {
@@ -9864,6 +9927,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Local Targets : For eac=
h cycle, this event accumulates the number of valid entries in the TOR that=
 match qualifications specified by the subevent.     Does not include addre=
ssless requests such as locks and interrupts.",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -9907,6 +9971,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Match the Opcode in b[29:19]=
 of the extended umask field : For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.     Does not include addressless requests such as locks and int=
errupts.",
+        "UMask": "0x20000",
         "Unit": "CHA"
     },
     {
@@ -9917,6 +9982,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Misses : For each cycle=
, this event accumulates the number of valid entries in the TOR that match =
qualifications specified by the subevent.     Does not include addressless =
requests such as locks and interrupts.",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -9927,6 +9993,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : MMCFG Access : For each cycl=
e, this event accumulates the number of valid entries in the TOR that match=
 qualifications specified by the subevent.     Does not include addressless=
 requests such as locks and interrupts.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -9937,6 +10004,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just NearMem : For each cycl=
e, this event accumulates the number of valid entries in the TOR that match=
 qualifications specified by the subevent.     Does not include addressless=
 requests such as locks and interrupts.",
+        "UMask": "0x40000000",
         "Unit": "CHA"
     },
     {
@@ -9947,6 +10015,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just NonCoherent : For each =
cycle, this event accumulates the number of valid entries in the TOR that m=
atch qualifications specified by the subevent.     Does not include address=
less requests such as locks and interrupts.",
+        "UMask": "0x100000000",
         "Unit": "CHA"
     },
     {
@@ -9957,6 +10026,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just NotNearMem : For each c=
ycle, this event accumulates the number of valid entries in the TOR that ma=
tch qualifications specified by the subevent.     Does not include addressl=
ess requests such as locks and interrupts.",
+        "UMask": "0x80000000",
         "Unit": "CHA"
     },
     {
@@ -9967,6 +10037,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : PMM Access : For each cycle,=
 this event accumulates the number of valid entries in the TOR that match q=
ualifications specified by the subevent.     Does not include addressless r=
equests such as locks and interrupts.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -9977,6 +10048,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Match the PreMorphed Opcode =
in b[29:19] of the extended umask field : For each cycle, this event accumu=
lates the number of valid entries in the TOR that match qualifications spec=
ified by the subevent.     Does not include addressless requests such as lo=
cks and interrupts.",
+        "UMask": "0x40000",
         "Unit": "CHA"
     },
     {
@@ -10009,6 +10081,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Remote Targets : For ea=
ch cycle, this event accumulates the number of valid entries in the TOR tha=
t match qualifications specified by the subevent.     Does not include addr=
essless requests such as locks and interrupts.",
+        "UMask": "0x10000",
         "Unit": "CHA"
     },
     {
@@ -11790,6 +11863,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx WRITE Credits Empty : MC10 : Co=
unts the number of times when there are no credits available for sending WR=
ITEs from the CHA into the iMC.  In order to send WRITEs into the memory co=
ntroller, the HA must first acquire a credit for the iMC's BL Ingress queue=
. : Filter for memory controller 10 only.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -11800,6 +11874,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx WRITE Credits Empty : MC11 : Co=
unts the number of times when there are no credits available for sending WR=
ITEs from the CHA into the iMC.  In order to send WRITEs into the memory co=
ntroller, the HA must first acquire a credit for the iMC's BL Ingress queue=
. : Filter for memory controller 11 only.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -11810,6 +11885,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx WRITE Credits Empty : MC12 : Co=
unts the number of times when there are no credits available for sending WR=
ITEs from the CHA into the iMC.  In order to send WRITEs into the memory co=
ntroller, the HA must first acquire a credit for the iMC's BL Ingress queue=
. : Filter for memory controller 12 only.",
+        "UMask": "0x1000",
         "Unit": "CHA"
     },
     {
@@ -11820,6 +11896,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx WRITE Credits Empty : MC13 : Co=
unts the number of times when there are no credits available for sending WR=
ITEs from the CHA into the iMC.  In order to send WRITEs into the memory co=
ntroller, the HA must first acquire a credit for the iMC's BL Ingress queue=
. : Filter for memory controller 13 only.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -11896,6 +11973,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx WRITE Credits Empty : MC8 : Cou=
nts the number of times when there are no credits available for sending WRI=
TEs from the CHA into the iMC.  In order to send WRITEs into the memory con=
troller, the HA must first acquire a credit for the iMC's BL Ingress queue.=
 : Filter for memory controller 8 only.",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -11906,6 +11984,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "CHA iMC CHNx WRITE Credits Empty : MC9 : Cou=
nts the number of times when there are no credits available for sending WRI=
TEs from the CHA into the iMC.  In order to send WRITEs into the memory con=
troller, the HA must first acquire a credit for the iMC's BL Ingress queue.=
 : Filter for memory controller 9 only.",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
index 97bec6cfc79c..4e4554e58dd7 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
@@ -2584,6 +2584,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0_FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x500",
         "Unit": "M2M"
     },
     {
@@ -2613,6 +2614,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0_NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x600",
         "Unit": "M2M"
     },
     {
@@ -2622,6 +2624,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0_NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x2000",
         "Unit": "M2M"
     },
     {
@@ -2692,6 +2695,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1_FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x900",
         "Unit": "M2M"
     },
     {
@@ -2721,6 +2725,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1_NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0xa00",
         "Unit": "M2M"
     },
     {
@@ -2730,6 +2735,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1_NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0xc00",
         "Unit": "M2M"
     },
     {
@@ -2790,6 +2796,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1d00",
         "Unit": "M2M"
     },
     {
@@ -2819,6 +2826,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1e00",
         "Unit": "M2M"
     },
     {
@@ -2828,6 +2836,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1c00",
         "Unit": "M2M"
     },
     {
@@ -3113,6 +3122,7 @@
         "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH2_HITA0_INVAL",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x100",
         "Unit": "M2M"
     },
     {
@@ -3122,6 +3132,7 @@
         "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH2_HITA1_INVAL",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x200",
         "Unit": "M2M"
     },
     {
@@ -3131,6 +3142,7 @@
         "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH2_MISS_INVAL",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x400",
         "Unit": "M2M"
     },
     {
@@ -3140,6 +3152,7 @@
         "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH2_RSP_PDRESET",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x800",
         "Unit": "M2M"
     },
     {
@@ -3375,6 +3388,7 @@
         "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.RPQ_PROXY",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x100",
         "Unit": "M2M"
     },
     {
@@ -3394,6 +3408,7 @@
         "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.UPI_THRESH",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x400",
         "Unit": "M2M"
     },
     {
@@ -3413,6 +3428,7 @@
         "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.XPT_THRESH",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x200",
         "Unit": "M2M"
     },
     {
@@ -3482,6 +3498,7 @@
         "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.RPQ_PROXY",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x100",
         "Unit": "M2M"
     },
     {
@@ -3501,6 +3518,7 @@
         "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.UPI_THRESH",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x400",
         "Unit": "M2M"
     },
     {
@@ -3520,6 +3538,7 @@
         "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.XPT_THRESH",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x200",
         "Unit": "M2M"
     },
     {
@@ -3589,6 +3608,7 @@
         "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH2.RPQ_PROXY",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x100",
         "Unit": "M2M"
     },
     {
@@ -3608,6 +3628,7 @@
         "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH2.UPI_THRESH",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x400",
         "Unit": "M2M"
     },
     {
@@ -3627,6 +3648,7 @@
         "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH2.XPT_THRESH",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x200",
         "Unit": "M2M"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 6c60b002453d..694359197777 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -17,7 +17,7 @@ GenuineIntel-6-A[DE],v1.21,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.25,icelake,core
-GenuineIntel-6-6[AC],v1.30,icelakex,core
+GenuineIntel-6-6[AC],v1.31,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

