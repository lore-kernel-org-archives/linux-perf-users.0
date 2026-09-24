Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F013F9F50
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228305; cv=none; b=beMy3icY5NimpKqIh/3ekVevbuTvSeeoG2wd/DotH8bGHBvQqeO6nzBX0cqK5TzI3vRlRnv5Xv75O8PsKCyXvx0tqG1rEccL5WKiQMSAjHQhgs4H8KJ1n5BNv93pusXsbbwZpS3llK1bdpypaq//S7CM1IOzh1ZnP2QGzxDoRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228305; c=relaxed/simple;
	bh=TmQReHJB296u2wtLKeDcaKCxTu3tn03XMwP6cHc4D0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qrSc6a8NOznMne3cfzM/Wku1m9TZx2xc4BWYVUOSUEDd0rOeOpb2ts2M7dugz7zlleTkWOhyrbeJ9icagmtDWeSfhf1kn3D/UtD2Xi3wuzFFMCX0nlWm0ioev7nrRrPiIG5F9JlCK9oc2y0oDR1C1fLyGF1icNac2ySjqBsC07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btVwXmSu; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btVwXmSu"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14318be7d79so1930788c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228297; x=1790833097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1++OlqwKwIr0xaKCgwZB5hyV6F0Wl6fi1ulbOPsSGCA=;
        b=btVwXmSuPkFB894j6b5Mx8c24tYhzvkJ90Ujy/lLu/zQAiOBxE/p0Ex16G8ZD0WBzf
         7oidfcjXDe0XrLx9D/vIH5F6+KPwCueRAKLynd/aMfF8szaOsFDsKMogY81L71L21DPD
         ko7FVHWOvHsBVL0AdoLKCCwqh2Ar88at5yru6x0DsNRxFfKTCIuW7Qs/WSVVEeknYq56
         naGgqhBb35YIceyIJKroFe2PQJI41P6xwYa2BrsNRqU3UthcSk4nEnptcM/5XJASj4Iz
         MoY4olmnJOK9QIeJRM7+/BbfsI89ufFIC6KiBTpQaw7Ilj8uHPMEmEi80oSX72GCC0dX
         NrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228297; x=1790833097;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1++OlqwKwIr0xaKCgwZB5hyV6F0Wl6fi1ulbOPsSGCA=;
        b=wdngWA1P79Uw9Vud19mFEr2ntof1WN3M0Tz3fjjo3zgDQtiOq2Zl/DW0Mn4olG7YnX
         Xp+iwDtJU2uvCxs85bhmkL9a0U/1R32accfVY4EZpsuexB/joYvU1jDCoI21iYRG37Gh
         dVeVKdjLFgit4Gw7BGrnlMG19gX3d/JnehtesFRDKCWkM0Gimve3p49UUxBL6nAA6QqZ
         ijQOgJoXGvh6E6LP1xDf1NAcwfagbcijt774p1S38HCml4x9HE0J+UI0rA06ddzwsvAU
         pFYglI7N4YYW+RIBqlW18diIP9ye0PhypqjK09GHWgzo8pWfzUpClb5aVFPlB9fXv3zY
         IkHw==
X-Forwarded-Encrypted: i=1; AKwUvBzj72OBLulmyiGbh06Pxxt9X3qVv2klWlISkN96YMNNx2QCH9N0cFcsxTh85RgMn3RlN5YlZi+CmiEWMkbSxL/P@vger.kernel.org
X-Gm-Message-State: AFuF++naB0BCMGbnRGkRVMwH7PPkyahYf0fWlO9XMVF4o2Cnv0blT84Q
	M8NjpTNW72mmW8eDJykPT9sx+wcZesQfY9POPLXORFBM4g8GbqSt8ha0lC8lYwkC2zP5cnWoGgv
	9aovZq1nXww==
X-Received: from dlbsj1.prod.google.com ([2002:a05:7022:f901:b0:144:8d97:71f5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:a4b:20b0:143:26f5:c617
 with SMTP id a92af1059eb24-145040d1741mr933182c88.32.1790228297031; Wed, 23
 Sep 2026 22:38:17 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:34 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-11-irogers@google.com>
Subject: [PATCH v1 10/21] perf vendor events intel: Update icelakex events to
 1.31 and TMA metrics to 5.2
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

The updated events were published in:

  https://github.com/intel/perfmon/commit/563ea935e283a7fc5bf49bbc082fab5be=
81af5b7

The updated TMA 5.2 metrics were published in:

  https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a887=
ad46c45

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/icelakex/icx-metrics.json        | 101 ++++++------------
 .../pmu-events/arch/x86/icelakex/memory.json  |  24 +++++
 .../arch/x86/icelakex/metricgroups.json       |   2 +-
 .../pmu-events/arch/x86/icelakex/other.json   |   9 ++
 .../arch/x86/icelakex/pipeline.json           |   7 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 6 files changed, 70 insertions(+), 75 deletions(-)

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
2.56.0.rc1.310.g51773c2048-goog

