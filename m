Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CB424D79
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228327; cv=none; b=eftA/bMHTavH+kDOZUsVAhsqGk6fM7HflUYngAOBdUHqBSGStn9pcASBsqTlGEUeyxjUG94s5+f5akUQaxVL3F7FIAibrPxMiUGQqQ4y6yEpycasaCM65SUJRscbkqrLfriX8YE0dNAuzHLpFNyNyc6jtA/NDir/+9HbBNIAf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228327; c=relaxed/simple;
	bh=ILHz4VNzxNLCLpIbLx/02Acd0qSiTPI1yAFZWciDCZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ApF8vQRkH+UnBmi/gm/tXuC2wLpK4odVSSXEEZ/PPjunkQhIjIklc2YdCab53ZjG9M2l/qBGrIbEPGDWZg62YtWg4e+6xwDFImSnINqkcz8/pYo2k5toPeR/nPZnB8XWXXUkjlrcd4WK5c5tXuVKV8gXdD562EMggBhE78J9Crc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2W29THH; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2W29THH"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so3111714eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228322; x=1790833122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EB0sQ/Jg0ecUC4KMlXNFNnqjaTzmgRkPvSX+ua/vV7E=;
        b=X2W29THHz5Yv/13w51RDmW+o14rVfgv6Ka9NmuGFaG3BtVD9EkHZsc9fs7VhMJ/jzd
         G2rYMvgl+5MT2TBaawUnwxt6PQwmgovsuxlbK2ToyCVxBp2ITBUwkc7MOjj4AXNLDko8
         O5VNufw9KV9K0ZeXsmey4rZ2uGGDVZAkv4xGcFiVnV0XRcrUifldOLz5PMn0NpC3r06/
         hy50pBH+tbogmKEL+P64/OCNzLENZHFkpLBARTctgrOLOUe3U0ThwAPzps20xMnoyED3
         +aUIafAjuiKn81UcxpD8Q90Z5A2GeGjKmz9FeyAJWkJARR6Boq6iTOcleQI+m7DiDL7s
         jefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228322; x=1790833122;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EB0sQ/Jg0ecUC4KMlXNFNnqjaTzmgRkPvSX+ua/vV7E=;
        b=aRQ35ISXeIOpb0G28EvhiNxVfqcWk5ZeCcHjbywXCl+uS4OQIV/rp/fEemZjVatyEX
         akb8CA1cT8OWiY91OBVuJZnl4WSRjiYer9RqwYVV5SFK4vRhwaGrD3K9QbJG8QKiFWnG
         3onehmC1qO0KOasBBe/UT39Ys91UTafksbc+0lxMIRhtpLQilbpSSSet+tqdcCX/17Ox
         twAwMDE4/nDiWUJOBw9LoSv2TOaZ4Ra4ouPmTqHeTb36ISeI5C/HEcKl8G44bmA+x2nw
         i587riIG+XExcxKpibjMrBsXYSLdQ93fs0kWWXmcLEWfnNhYaS70KB0qKjIFrHWTjPAM
         LVKw==
X-Forwarded-Encrypted: i=1; AKwUvBx5Qry/A/eAH2FutLDFb+l2tM7mp68u8YU+pDRe9+s2sV60fL+y+iW1WNbvK/eDxUlbsNgM/uhO5G56QddA4etp@vger.kernel.org
X-Gm-Message-State: AFuF++nCc0LakGzo3h7RrMM5vJrf/GxtNxOAa+EtaScyrkui8owVv0dI
	71OqP9Oth+hhWewqh1DXz3d/sn+hKDYBuQG3W8M8ehjZe73rHek4h/taj2oXrf/l+rxAWIt+F49
	eTfUe+RR4Sg==
X-Received: from dlx14.prod.google.com ([2002:a05:7022:8e:b0:144:cdc4:f2cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4292:10b0:137:c0a7:8d01
 with SMTP id a92af1059eb24-14503fc6b34mr1094240c88.23.1790228321452; Wed, 23
 Sep 2026 22:38:41 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:45 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-22-irogers@google.com>
Subject: [PATCH v1 21/21] perf vendor events intel: Update tigerlake events to
 1.20 and TMA metrics to 5.2
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

  https://github.com/intel/perfmon/commit/228a83d851e8908aa09fac00a96a69404=
f2d3107

The updated TMA 5.2 metrics were published in:

  https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a887=
ad46c45

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/tigerlake/metricgroups.json      |  2 +-
 .../pmu-events/arch/x86/tigerlake/other.json  |  9 ++
 .../arch/x86/tigerlake/pipeline.json          |  7 +-
 .../arch/x86/tigerlake/tgl-metrics.json       | 82 +++++++------------
 5 files changed, 43 insertions(+), 59 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 19166dacdcfb..7011fb91c882 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -36,7 +36,7 @@ GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.37,skylakex,core
 GenuineIntel-6-86,v1.23,snowridgex,core
-GenuineIntel-6-8[CD],v1.19,tigerlake,core
+GenuineIntel-6-8[CD],v1.20,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
 GenuineIntel-6-25,v4,westmereep-sp,core
 GenuineIntel-6-2F,v4,westmereex,core
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/metricgroups.json b/t=
ools/perf/pmu-events/arch/x86/tigerlake/metricgroups.json
index 80ca8021f2de..8f829fa7f854 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/metricgroups.json
@@ -87,7 +87,6 @@
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
@@ -120,6 +119,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/tigerlake/other.json
index a22b626c14c9..ac5b26d33881 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
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
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. [This event is alias to MISC_RET=
IRED.LBR_INSERTS]",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/tigerlake/pipeline.json
index b417e1db9e07..d42b3fbac7ef 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
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
@@ -551,11 +550,11 @@
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
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. [This event is alias to LBR_INSE=
RTS.ANY]",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
index 908da985c594..734713e6a964 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
@@ -159,16 +159,16 @@
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load + tma_=
fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + =
tma_store_fwd_blk)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_me=
mory_bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_l3_miss_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_acces=
ses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bo=
und * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_=
miss_bound + tma_store_bound)) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb=
_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_sp=
lit_loads + tma_store_fwd_blk)))",
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
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound =
+ tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l=
1_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_b=
lk)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tma_l1_bound + =
tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_lock_latency / (tma_=
4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma=
_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * =
(tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_boun=
d + tma_store_bound)) * (tma_split_loads / (tma_4k_aliasing + tma_dtlb_load=
 + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_l=
oads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * =
(tma_split_stores / (tma_dtlb_store + tma_false_sharing + tma_split_stores =
+ tma_store_latency + tma_streaming_stores)) + tma_memory_bound * (tma_stor=
e_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tm=
a_store_bound)) * (tma_store_latency / (tma_dtlb_store + tma_false_sharing =
+ tma_split_stores + tma_store_latency + tma_streaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memo=
ry_bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tm=
a_l3_miss_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_=
accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memo=
ry_bound * tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma=
_l3_miss_bound + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bou=
nd)) * (tma_l1_latency_dependency / (tma_4k_aliasing + tma_dtlb_load + tma_=
fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + =
tma_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tm=
a_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_bound)) * (tma_lo=
ck_latency / (tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1_latenc=
y_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + t=
ma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_l3_miss_bound + tma_store_bound)) * (tma_split_loads / (tma_4k_ali=
asing + tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_=
latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_s=
tore_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_boun=
d + tma_store_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sha=
ring + tma_split_stores + tma_store_latency + tma_streaming_stores)) + tma_=
memory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_l3_miss_bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb=
_store + tma_false_sharing + tma_split_stores + tma_store_latency + tma_str=
eaming_stores)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_bottleneck_data_cache_memory_latency",
         "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
@@ -194,7 +194,7 @@
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tm=
a_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency + =
tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store=
_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_spli=
t_stores + tma_store_latency + tma_streaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound=
 + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing +=
 tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency=
 + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bo=
und / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma=
_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tm=
a_split_stores + tma_store_latency + tma_streaming_stores)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -203,7 +203,7 @@
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
         "MetricConstraint": "NO_GROUP_EVENTS",
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
@@ -349,13 +349,13 @@
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
         "MetricExpr": "48 * tma_info_system_core_frequency * (MEM_LOAD_L3_=
HIT_RETIRED.XSNP_NO_FWD + MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEMAN=
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
@@ -376,16 +376,6 @@
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
-        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clk=
s + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_thread_clks - tma_l2_bound",
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
@@ -437,7 +427,7 @@
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
@@ -723,7 +713,7 @@
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_frontend_dsb_coverage",
         "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 5 > 0.35",
@@ -774,7 +764,7 @@
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
-        "MetricExpr": "LSD.UOPS / UOPS_ISSUED.ANY",
+        "MetricExpr": "LSD.UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS=
 + IDQ.MS_UOPS)",
         "MetricGroup": "Fed;LSD",
         "MetricName": "tma_info_frontend_lsd_coverage"
     },
@@ -1085,7 +1075,7 @@
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
@@ -1151,7 +1141,7 @@
         "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / tma_info_system_time / 1e3",
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
@@ -1208,29 +1198,6 @@
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
@@ -1379,6 +1346,15 @@
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
+        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clk=
s + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_thread_clks - tma_l2_bound",
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
@@ -1479,18 +1455,18 @@
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
@@ -1554,7 +1530,7 @@
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
@@ -1571,7 +1547,7 @@
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
@@ -1743,7 +1719,7 @@
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
--=20
2.56.0.rc1.310.g51773c2048-goog

