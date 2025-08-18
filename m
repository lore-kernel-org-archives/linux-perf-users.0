Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087F27466C
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543929; cv=none; b=S3KaCxKCaRIqkXwggkrsRD2aUPnVmKkxQhF3A0x+485Bx8zG1buUXM0owZgHugA398ollGcPpAKb++efv5ezsNhQa3FGk1iffmveQPtssgZdVZnJmXwMo+s8k3KAx64zZFCzyWADUjhXA7SyXcSQZKVED7SsnFWwu3SX5yS0GZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543929; c=relaxed/simple;
	bh=VFb1CaJ0eRxh9IO9QxjPvXJk8l4UbGZXT8gl5bmUsvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QGtVsVfNlaryR6QDiAuzaio0iQ+0iWCdgcItiDxHn7HMNqnoLffh2wOAfEIbWEm0LD+UaihXYwYO6pKsR3ZAuzEm0Y64981O+qgCh6uwxdu0768haRj3ksNOxbzfcMGHL8niN1Ythhh2HfRT+oxIWPYmzxVbpT5Zoz8XltZzMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0QSk1ZL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0QSk1ZL"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457fe8844so51603615ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543921; x=1756148721; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPu7HgEqjv/9pYy7ZOBzTh5eusrrnsbsNUri9J4cP3I=;
        b=E0QSk1ZLVOkkEITpT1R3rOivICs61fsiajbZzwU4deSaJLRly6Ek8KAU2xLKQIZtDq
         JqJ0XypYmgK2ZlVUw8685UnZy2yZnGrvkVHRDfTRCgU5e57O7wD+scLMOO89dN30lP8r
         rnSx7+mi0MBohIZYzf7K+jgXgsVCfFDekquHy7NzqakDPMDJjGyaAlyUbr6+vEQVHAzD
         blX9ciKcUxXNOxZKHo1UInjjPQ7ZxHCcsCl+RakcKzHGAaAsfGuGjOjHcKoFNffnhplF
         wPnOOjp6g65xc4DQ5OlO5V5rwE3xuzyBF1ELQYbvV9kPl1Dk4IMAOvbUILodVPJhNuaT
         8zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543921; x=1756148721;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XPu7HgEqjv/9pYy7ZOBzTh5eusrrnsbsNUri9J4cP3I=;
        b=CXwkGgExsgTeSAVTrwc8tYRI8r9w1bX4gQlbAsX99bc88L3Auu3KABW5l6SwI/DAw2
         5RtjBXNuH/QRDs3tzNRixWNmEjeH1aO8SLsKN+ajbcLK47aztqMrW4wQLnBlHHH/0aEH
         Y2dZ9C1sFNGXkpZYgZZ+8rdQpZI7ZxYAURJOKGdFo7zPUzp3ShgZC2bdrxtH8q+lJt3o
         X+3zz04NDTi7AVJQ1FZ5TyTjGaTmnQZGAoaDoJYrFTnoF4IR5rhk78T7gZ6n+273gOSQ
         enJyPf5EMVPR8og5AgrEuJzJYa7ZqrMc8P+YSrKikZQ2w6tKLWx2NYcACnU6i53JxZCX
         544Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/3dhbvseTd77dqevh08aW+aq99wrTxOzZR4qBmrxM08KyX48a8/Ym2DWtv39Xi0Q/RToIiVUplyGohVQYtHgQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oWeLX0njwlZ5vC8Wz5DgZIysHPoeDJ/lf0N7EU86Xrh+mAm1
	vgHK9D03J1vITctg4/1PgoG3B47vov3W9igevI4p1TeIh2KLdJ84dNsctGKdGB7plm+wiuPasHz
	IOwVgu4DQiw==
X-Google-Smtp-Source: AGHT+IGCajH84fWcoM3zhwef2bMwrEFrQjDsj6evWediiGXYFqCovJ4ispp6xFqBqm/wBfDbU9d2jJ2h/tqS
X-Received: from pldq4.prod.google.com ([2002:a17:902:c9c4:b0:240:608a:938d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:189:b0:244:214f:13b7
 with SMTP id d9443c01a7336-24478feb7cdmr134225075ad.53.1755543921168; Mon, 18
 Aug 2025 12:05:21 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:03:58 -0700
In-Reply-To: <20250818190416.145274-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818190416.145274-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818190416.145274-3-irogers@google.com>
Subject: [PATCH v2 02/20] perf vendor events: Update alderlake events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.31 to v1.33. Update metrics from TMA 5.0 to 5.1.

The event updates come from:
https://github.com/intel/perfmon/commit/c504da6cb00e52067206166d2049a0c11af=
3b650
https://github.com/intel/perfmon/commit/4c18312c1a22eb564f5dbc94b187b59e438=
3a56a

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 104 +++++------
 .../pmu-events/arch/x86/alderlake/cache.json  |  99 +++++------
 .../arch/x86/alderlake/floating-point.json    |  28 ++-
 .../arch/x86/alderlake/frontend.json          |  42 +++--
 .../pmu-events/arch/x86/alderlake/memory.json |  12 +-
 .../pmu-events/arch/x86/alderlake/other.json  |   8 +-
 .../arch/x86/alderlake/pipeline.json          | 163 +++++++-----------
 .../x86/alderlake/uncore-interconnect.json    |   2 -
 .../arch/x86/alderlake/virtual-memory.json    |  40 ++---
 .../arch/x86/alderlaken/adln-metrics.json     |  20 +--
 .../x86/alderlaken/uncore-interconnect.json   |   2 -
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   4 +-
 12 files changed, 231 insertions(+), 293 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 377dfecd96bd..cae7c0cf02f2 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -1,56 +1,56 @@
 [
     {
         "BriefDescription": "C10 residency percent per package",
-        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c10\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C10_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C1 residency percent per core",
-        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c1\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C1_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C8 residency percent per package",
-        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c8\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C8_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -552,7 +552,7 @@
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / msr@tsc\\,cpu=
=3Dcpu_atom@",
         "MetricName": "tma_info_system_cpu_utilization",
         "Unit": "cpu_atom"
     },
@@ -751,7 +751,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@)",
         "MetricGroup": "BvOB;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -789,12 +789,21 @@
         "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_ports_utilization + tma_serializing_operation) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_ports_utilization + tma_serializin=
g_operation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricGroup": "BvCB;Cor;tma_issueComp",
+        "MetricName": "tma_bottleneck_compute_bound_est",
+        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: ",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
         "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)=
))",
         "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
-        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
+        "MetricName": "tma_bottleneck_data_cache_memory_bandwidth",
+        "MetricThreshold": "tma_bottleneck_data_cache_memory_bandwidth > 2=
0",
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
         "Unit": "cpu_core"
     },
@@ -802,23 +811,14 @@
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
         "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
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
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_bottleneck_cache_memory_latency",
-        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
+        "MetricName": "tma_bottleneck_data_cache_memory_latency",
+        "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
-        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_ports_utilization + tma_serializing_operation) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_ports_utilization + tma_serializin=
g_operation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
-        "MetricGroup": "BvCB;Cor;tma_issueComp",
-        "MetricName": "tma_bottleneck_compute_bound_est",
-        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
-        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: ",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
-        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_cl=
ears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_bran=
ch_mispredicts) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unk=
nown_branches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_miss=
es + tma_itlb_misses + tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * t=
ma_ms / (tma_dsb + tma_lsd + tma_mite + tma_ms))) - tma_bottleneck_big_code=
",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_cl=
ears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_bran=
ch_mispredicts) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unk=
nown_branches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_miss=
es + tma_itlb_misses + tma_lcp + tma_ms_switches) + tma_ms)) - tma_bottlene=
ck_big_code",
         "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
         "MetricName": "tma_bottleneck_instruction_fetch_bw",
         "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20",
@@ -826,7 +826,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
-        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_swi=
tches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_restee=
rs * tma_other_mispredicts / tma_branch_mispredicts) / (tma_clears_resteers=
 + tma_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers=
 + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_m=
s_switches) + tma_fetch_bandwidth * tma_ms / (tma_dsb + tma_lsd + tma_mite =
+ tma_ms)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_bra=
nch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other_n=
ukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + cpu_=
core@RS.EMPTY_RESOURCE@ / tma_info_thread_clks * tma_ports_utilized_0) / (t=
ma_divider + tma_ports_utilization + tma_serializing_operation) + tma_micro=
code_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) * (t=
ma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_swi=
tches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_restee=
rs * tma_other_mispredicts / tma_branch_mispredicts) / (tma_clears_resteers=
 + tma_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers=
 + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_m=
s_switches) + tma_ms) + 10 * tma_microcode_sequencer * tma_other_mispredict=
s / tma_branch_mispredicts * tma_branch_mispredicts + tma_machine_clears * =
tma_other_nukes / tma_other_nukes + tma_core_bound * (tma_serializing_opera=
tion + cpu_core@RS.EMPTY_RESOURCE@ / tma_info_thread_clks * tma_ports_utili=
zed_0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) =
+ tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequ=
encer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
         "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
         "MetricName": "tma_bottleneck_irregular_overhead",
         "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
@@ -862,7 +862,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
-        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_cache_me=
mory_bandwidth + tma_bottleneck_cache_memory_latency + tma_bottleneck_memor=
y_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottleneck_comput=
e_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_branching_=
overhead + tma_bottleneck_useful_work)",
+        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_data_cac=
he_memory_bandwidth + tma_bottleneck_data_cache_memory_latency + tma_bottle=
neck_memory_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottlen=
eck_compute_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_=
branching_overhead + tma_bottleneck_useful_work)",
         "MetricGroup": "BvOB;Cor;Offcore",
         "MetricName": "tma_bottleneck_other_bottlenecks",
         "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
@@ -879,7 +879,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@)",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
@@ -992,7 +992,6 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(25 * tma_info_system_core_frequency * (cpu_core@ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP=
_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEM=
AND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) + 24 * tma_info_system_core_frequ=
ency * cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@) * (1 + cpu_core@MEM_LOA=
D_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thre=
ad_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
@@ -1109,7 +1108,7 @@
         "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_cache_memory_bandwidth, =
tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_late=
ncy, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_data_cache_memory_bandwi=
dth, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store=
_latency, tma_streaming_stores",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1238,7 +1237,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
-        "MetricExpr": "cpu_core@topdown\\-heavy\\-ops@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "cpu_core@topdown\\-heavy\\-ops@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@)",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
@@ -1851,7 +1850,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Mem;Backend;CacheHits",
         "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute",
@@ -1912,7 +1911,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * msr@tsc\\,cpu=
=3Dcpu_core@ / 1e9 / tma_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency",
         "Unit": "cpu_core"
@@ -1926,7 +1925,7 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / msr@tsc\\,cpu=
=3Dcpu_core@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized",
         "Unit": "cpu_core"
@@ -1936,7 +1935,7 @@
         "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / tma_info_system_time / 1e3",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_ban=
dwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_data_cache_memor=
y_bandwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full",
         "Unit": "cpu_core"
     },
     {
@@ -1980,7 +1979,6 @@
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(UNC_ARB_TRK_OCCUPANCY.RD + UNC_ARB_DAT_OCCUPANCY.R=
D) / UNC_ARB_TRK_REQUESTS.RD",
         "MetricGroup": "Mem;MemoryLat;SoC",
         "MetricName": "tma_info_system_mem_read_latency",
@@ -2031,6 +2029,13 @@
         "MetricName": "tma_info_system_turbo_utilization",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Measured Average Uncore Frequency for the SoC=
 [GHz]",
+        "MetricExpr": "tma_info_system_socket_clks / 1e9 / tma_info_system=
_time",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_system_uncore_frequency",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD@",
@@ -2150,12 +2155,12 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
+        "BriefDescription": "This metric ([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache",
         "MetricExpr": "min(2 * (cpu_core@MEM_INST_RETIRED.ALL_LOADS@ - cpu=
_core@MEM_LOAD_RETIRED.FB_HIT@ - cpu_core@MEM_LOAD_RETIRED.L1_MISS@) * 20 /=
 100, max(cpu_core@CYCLE_ACTIVITY.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVIT=
Y.CYCLES_L1D_MISS@, 0)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
         "MetricName": "tma_l1_latency_dependency",
         "MetricThreshold": "tma_l1_latency_dependency > 0.1 & (tma_l1_boun=
d > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache. The s=
hort latency of the L1D cache may be exposed in pointer-chasing memory acce=
ss patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
+        "PublicDescription": "This metric ([SKL+] roughly; [LNL]) estimate=
s fraction of cycles with demand load accesses that hit the L1D cache. The =
short latency of the L1D cache may be exposed in pointer-chasing memory acc=
ess patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2171,7 +2176,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "3 * tma_info_system_core_frequency * cpu_core@MEM_L=
OAD_RETIRED.L2_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM=
_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
         "MetricName": "tma_l2_hit_latency",
@@ -2192,12 +2196,11 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "9 * tma_info_system_core_frequency * (cpu_core@MEM_=
LOAD_RETIRED.L3_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@ME=
M_LOAD_RETIRED.L1_MISS@ / 2)) / tma_info_thread_clks",
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
a_bottleneck_cache_memory_latency, tma_mem_latency",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_bottleneck_data_cache_memory_latency, tma_mem_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2279,6 +2282,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(16 * max(0, cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ =
- cpu_core@L2_RQSTS.ALL_RFO@) + cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu=
_core@MEM_INST_RETIRED.ALL_STORES@ * (10 * cpu_core@L2_RQSTS.RFO_HIT@ + min=
(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUESTS_OUTSTANDING.C=
YCLES_WITH_DEMAND_RFO@))) / tma_info_thread_clks",
         "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
@@ -2314,7 +2318,7 @@
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_data_cache_memory_bandw=
idth, tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2324,13 +2328,13 @@
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_latency=
",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_data_cache_memory_latency, tma_l3_hit_la=
tency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "cpu_core@topdown\\-mem\\-bound@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "cpu_core@topdown\\-mem\\-bound@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@)",
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
@@ -2341,7 +2345,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * cpu_core@MISC2_RETIRED.LFENCE@ / tma_info_thre=
ad_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_memory_fence",
@@ -2400,7 +2403,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details.",
-        "MetricExpr": "max(cpu_core@IDQ.MS_CYCLES_ANY@, cpu_core@UOPS_RETI=
RED.MS\\,cmask\\=3D1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUE=
D.ANY@)) / tma_info_core_core_clks / 2",
+        "MetricExpr": "max(cpu_core@IDQ.MS_CYCLES_ANY@, cpu_core@UOPS_RETI=
RED.MS\\,cmask\\=3D1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUE=
D.ANY@)) / tma_info_core_core_clks / 2.4",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
         "MetricName": "tma_ms",
         "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
@@ -2439,6 +2442,7 @@
     },
     {
         "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches))",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_other_light_ops",
@@ -2507,6 +2511,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (cp=
u_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_=
3_PORTS_UTIL@)) / tma_info_thread_clks if cpu_core@ARITH.DIV_ACTIVE@ < cpu_=
core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ e=
lse (cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTI=
VITY.2_3_PORTS_UTIL@) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
@@ -2517,6 +2522,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricConstraint": "NO_THRESHOLD_AND_NMI",
         "MetricExpr": "(cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + max(cpu=
_core@RS.EMPTY_RESOURCE@ - cpu_core@RESOURCE_STALLS.SCOREBOARD@, 0)) / tma_=
info_thread_clks * (cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_AC=
TIVITY.BOUND_ON_LOADS@) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
@@ -2527,6 +2533,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricConstraint": "NO_THRESHOLD_AND_NMI",
         "MetricExpr": "cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
@@ -2537,7 +2544,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "cpu_core@EXE_ACTIVITY.2_PORTS_UTIL@ / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
@@ -2548,7 +2554,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "cpu_core@UOPS_EXECUTED.CYCLES_GE_3@ / tma_info_thre=
ad_clks",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
@@ -2560,7 +2565,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-=
fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@=
 + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-=
fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@=
 + cpu_core@topdown\\-be\\-bound@)",
         "MetricGroup": "BvUW;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -2591,7 +2596,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.PAUSE@ / tma_info_thread_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
@@ -2626,7 +2630,7 @@
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma_m=
em_bandwidth",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_data_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, =
tma_mem_bandwidth",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index 5461576dafc7..6a56c9ad8e43 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -4,7 +4,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.HWPF_MISS",
-        "PublicDescription": "L1D.HWPF_MISS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -14,7 +13,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
-        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace. Available PDIST counters: 0",
+        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -24,7 +23,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
-        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses. Av=
ailable PDIST counters: 0",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -36,7 +35,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
-        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses. Av=
ailable PDIST counters: 0",
+        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -47,7 +46,6 @@
         "Deprecated": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALL",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 L1D_PEND_MISS.L2_STALLS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -57,7 +55,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALLS",
-        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses. Availa=
ble PDIST counters: 0",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -67,7 +65,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
-        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type. Available PDIST counters: 0",
+        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -78,7 +76,7 @@
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
-        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles. Available PDIST counters: 0",
+        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -88,7 +86,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "L2_LINES_IN.ALL",
-        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
         "SampleAfterValue": "100003",
         "UMask": "0x1f",
         "Unit": "cpu_core"
@@ -98,7 +96,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.NON_SILENT",
-        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3 Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -108,7 +106,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.SILENT",
-        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event.",
         "SampleAfterValue": "200003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -118,7 +116,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.USELESS_HWPF",
-        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
         "SampleAfterValue": "200003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -137,7 +135,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
-        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES] Available PDIST coun=
ters: 0",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES]",
         "SampleAfterValue": "200003",
         "UMask": "0xff",
         "Unit": "cpu_core"
@@ -167,7 +165,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
-        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS] Available PDIST coun=
ters: 0",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS]",
         "SampleAfterValue": "200003",
         "UMask": "0x3f",
         "Unit": "cpu_core"
@@ -177,7 +175,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
-        "PublicDescription": "Counts the total number of L2 code requests.=
 Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of L2 code requests.=
",
         "SampleAfterValue": "200003",
         "UMask": "0xe4",
         "Unit": "cpu_core"
@@ -187,7 +185,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
-        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once. Ava=
ilable PDIST counters: 0",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
         "UMask": "0xe1",
         "Unit": "cpu_core"
@@ -197,7 +195,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
-        "PublicDescription": "Counts demand requests that miss L2 cache. A=
vailable PDIST counters: 0",
+        "PublicDescription": "Counts demand requests that miss L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x27",
         "Unit": "cpu_core"
@@ -207,7 +205,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_HWPF",
-        "PublicDescription": "L2_RQSTS.ALL_HWPF Available PDIST counters: =
0",
         "SampleAfterValue": "200003",
         "UMask": "0xf0",
         "Unit": "cpu_core"
@@ -217,7 +214,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
-        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches. Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
         "SampleAfterValue": "200003",
         "UMask": "0xe2",
         "Unit": "cpu_core"
@@ -227,7 +224,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
-        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads. Available PDIST counters: 0",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
         "SampleAfterValue": "200003",
         "UMask": "0xc4",
         "Unit": "cpu_core"
@@ -237,7 +234,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
-        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions. Available PDIST counters: 0",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
         "SampleAfterValue": "200003",
         "UMask": "0x24",
         "Unit": "cpu_core"
@@ -247,7 +244,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
-        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0xc1",
         "Unit": "cpu_core"
@@ -257,7 +254,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
-        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once. Available PDIST counters: 0",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
         "UMask": "0x21",
         "Unit": "cpu_core"
@@ -267,7 +264,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.HWPF_MISS",
-        "PublicDescription": "L2_RQSTS.HWPF_MISS Available PDIST counters:=
 0",
         "SampleAfterValue": "200003",
         "UMask": "0x30",
         "Unit": "cpu_core"
@@ -277,7 +273,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
-        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS] Available PDIST co=
unters: 0",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS]",
         "SampleAfterValue": "200003",
         "UMask": "0x3f",
         "Unit": "cpu_core"
@@ -287,7 +283,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
-        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL] Available PDIST counters:=
 0",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL]",
         "SampleAfterValue": "200003",
         "UMask": "0xff",
         "Unit": "cpu_core"
@@ -297,7 +293,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
-        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache. Available PDIST counters: 0",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0xc2",
         "Unit": "cpu_core"
@@ -307,7 +303,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
-        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache. Available PDIST counters: 0",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x22",
         "Unit": "cpu_core"
@@ -317,7 +313,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_HIT",
-        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full. Available PDIST counters: 0",
+        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
         "SampleAfterValue": "200003",
         "UMask": "0xc8",
         "Unit": "cpu_core"
@@ -327,7 +323,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_MISS",
-        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full. Available PDIST counters: 0",
+        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
         "SampleAfterValue": "200003",
         "UMask": "0x28",
         "Unit": "cpu_core"
@@ -337,7 +333,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "L2_TRANS.L2_WB",
-        "PublicDescription": "Counts L2 writebacks that access L2 cache. A=
vailable PDIST counters: 0",
+        "PublicDescription": "Counts L2 writebacks that access L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -357,7 +353,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3. Available PDIST coun=
ters: 0",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
         "UMask": "0x41",
         "Unit": "cpu_core"
@@ -377,7 +373,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3. Available PDIST counters: 0=
",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
         "UMask": "0x4f",
         "Unit": "cpu_core"
@@ -552,7 +548,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
-        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss) Available PDIST counters: 0",
+        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
         "SampleAfterValue": "1000003",
         "UMask": "0xfd",
         "Unit": "cpu_core"
@@ -853,7 +849,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "MEM_STORE_RETIRED.L2_HIT",
-        "PublicDescription": "MEM_STORE_RETIRED.L2_HIT Available PDIST cou=
nters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1050,7 +1045,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe5",
         "EventName": "MEM_UOP_RETIRED.ANY",
-        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses Available PDIST counters: 0",
+        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -1372,7 +1367,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
-        "PublicDescription": "OFFCORE_REQUESTS.ALL_REQUESTS Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -1382,7 +1376,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DATA_RD",
-        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type. Available PDIST counters: 0",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1392,7 +1386,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
-        "PublicDescription": "Counts both cacheable and non-cacheable code=
 read requests. Available PDIST counters: 0",
+        "PublicDescription": "Counts both cacheable and non-cacheable code=
 read requests.",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1402,7 +1396,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
-        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore. Available PDIST counters: 0",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1412,7 +1406,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
-        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM. Available PDIST counters: 0",
+        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1424,7 +1418,6 @@
         "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 OFFCORE_REQUESTS_OUTSTANDING.DATA_RD Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1436,7 +1429,6 @@
         "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
-        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DAT=
A_RD Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1447,7 +1439,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE=
_RD",
-        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1458,7 +1450,6 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
-        "PublicDescription": "Cycles where at least 1 outstanding demand d=
ata read request is pending. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1469,7 +1460,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
-        "PublicDescription": "Counts the number of offcore outstanding dem=
and rfo Reads transactions in the super queue every cycle. The 'Offcore out=
standing' state of the transaction lasts from the L2 miss until the sending=
 transaction completion to requestor (SQ deallocation). See the correspondi=
ng Umask under OFFCORE_REQUESTS. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of offcore outstanding dem=
and rfo Reads transactions in the super queue every cycle. The 'Offcore out=
standing' state of the transaction lasts from the L2 miss until the sending=
 transaction completion to requestor (SQ deallocation). See the correspondi=
ng Umask under OFFCORE_REQUESTS.",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1480,7 +1471,6 @@
         "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
-        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD Availab=
le PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1490,7 +1480,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
-        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1500,7 +1490,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
-        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor. Available PDIST counters: 0"=
,
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1510,7 +1500,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "SQ_MISC.BUS_LOCK",
-        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory. Avai=
lable PDIST counters: 0",
+        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1520,7 +1510,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.ANY",
-        "PublicDescription": "Counts the number of PREFETCHNTA, PREFETCHW,=
 PREFETCHT0, PREFETCHT1 or PREFETCHT2 instructions executed. Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xf",
         "Unit": "cpu_core"
@@ -1530,7 +1519,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.NTA",
-        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1540,7 +1529,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
-        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1550,7 +1539,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T0",
-        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1560,7 +1549,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
-        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json b=
/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
index d01f1b163ed8..62fd70f220e5 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
@@ -14,7 +14,6 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FPDIV_ACTIVE",
-        "PublicDescription": "ARITH.FPDIV_ACTIVE Available PDIST counters:=
 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -33,7 +32,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.FP",
-        "PublicDescription": "Counts all microcode Floating Point assists.=
 Available PDIST counters: 0",
+        "PublicDescription": "Counts all microcode Floating Point assists.=
",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -43,7 +42,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.SSE_AVX_MIX",
-        "PublicDescription": "ASSISTS.SSE_AVX_MIX Available PDIST counters=
: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -53,7 +51,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
-        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_0 [This event is al=
ias to FP_ARITH_DISPATCHED.V0] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -63,7 +60,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
-        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_1 [This event is al=
ias to FP_ARITH_DISPATCHED.V1] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -73,7 +69,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
-        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_5 [This event is al=
ias to FP_ARITH_DISPATCHED.V2] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -83,7 +78,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V0",
-        "PublicDescription": "FP_ARITH_DISPATCHED.V0 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_0] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -93,7 +87,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V1",
-        "PublicDescription": "FP_ARITH_DISPATCHED.V1 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_1] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -103,7 +96,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V2",
-        "PublicDescription": "FP_ARITH_DISPATCHED.V2 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_5] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -113,7 +105,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events. Available PDIST counters: 0"=
,
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -123,7 +115,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events. Available PDIST co=
unters: 0",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -133,7 +125,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events. Available PDIST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -143,7 +135,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events. Available PDIST co=
unters: 0",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -153,7 +145,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.4_FLOPS",
-        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events. =
Available PDIST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
         "SampleAfterValue": "100003",
         "UMask": "0x18",
         "Unit": "cpu_core"
@@ -163,7 +155,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
-        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events. Available PDIST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -173,7 +165,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events. Available PD=
IST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -183,7 +175,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events. Av=
ailable PDIST counters: 0",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -193,7 +185,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
-        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events. Available PDIST counters: 0",
+        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
         "SampleAfterValue": "1000003",
         "UMask": "0xfc",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/alderlake/frontend.json
index dae3174a74fb..ff3b30c2619a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
@@ -14,7 +14,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "BACLEARS.ANY",
-        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore. A=
vailable PDIST counters: 0",
+        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -24,7 +24,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.LCP",
-        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. Available PDIS=
T counters: 0",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
         "SampleAfterValue": "500009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -34,7 +34,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.MS_BUSY",
-        "PublicDescription": "Cycles the Microcode Sequencer is busy. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -44,7 +43,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
-        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE. Available PDIST counters: =
0",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -302,7 +301,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALLS",
-        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
         "SampleAfterValue": "500009",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -314,7 +313,6 @@
         "EdgeDetect": "1",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALL_PERIODS",
-        "PublicDescription": "ICACHE_DATA.STALL_PERIODS Available PDIST co=
unters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -324,7 +322,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_TAG.STALLS",
-        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
         "SampleAfterValue": "200003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -335,7 +333,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
-        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -346,7 +344,7 @@
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -356,7 +354,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
-        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path. Availab=
le PDIST counters: 0",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -367,7 +365,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_ANY",
-        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB). Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -378,7 +376,7 @@
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB). Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -388,7 +386,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
-        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB). Available PDIST c=
ounters: 0",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -399,7 +397,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES_ANY",
-        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE. Avai=
lable PDIST counters: 0",
+        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -411,7 +409,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_SWITCHES",
-        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer. Availab=
le PDIST counters: 0",
+        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -421,7 +419,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
-        "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS). Available PDIST counters: 0",
+        "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
         "SampleAfterValue": "1000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -431,7 +429,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CORE",
-        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE] Available PDI=
ST counters: 0",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -442,7 +440,7 @@
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE] Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -454,7 +452,7 @@
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK] Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -464,7 +462,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
-        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_BUBBLES.CORE] Available PDIST counters=
: 0",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_BUBBLES.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -475,7 +473,7 @@
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE] Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -487,7 +485,7 @@
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK] Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index 07f5786bdbc0..a0260d5b8619 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -5,7 +5,6 @@
         "CounterMask": "6",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
-        "PublicDescription": "Execution stalls while L3 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
         "Unit": "cpu_core"
@@ -79,7 +78,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -90,7 +89,6 @@
         "CounterMask": "2",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
-        "PublicDescription": "Cycles while L1 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -101,7 +99,6 @@
         "CounterMask": "3",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
-        "PublicDescription": "Execution stalls while L1 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -112,7 +109,7 @@
         "CounterMask": "5",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
-        "PublicDescription": "Execution stalls while L2 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock). Available PDIST counters: 0",
+        "PublicDescription": "Execution stalls while L2 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_core"
@@ -123,7 +120,7 @@
         "CounterMask": "9",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
-        "PublicDescription": "Execution stalls while L3 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock). Available PDIST counters: 0",
+        "PublicDescription": "Execution stalls while L3 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
         "SampleAfterValue": "1000003",
         "UMask": "0x9",
         "Unit": "cpu_core"
@@ -417,7 +414,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
-        "PublicDescription": "Counts demand data read requests that miss t=
he L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -427,7 +423,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD"=
,
-        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache. Available PDIST counters: 0",
+        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index 5f64138edfe4..af46cde26b54 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.HARDWARE",
-        "PublicDescription": "Count all other hardware assists or traps th=
at are not necessarily architecturally exposed (through a software handler)=
 beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-ev=
ents.  This includes, but not limited to, assists at EXE or MEM uop writeba=
ck like AVX* load/store/gather/scatter (non-FP GSSE-assist ) , assists gene=
rated by ROB like PEBS and RTIT, Uncore trap, RAR (Remote Action Request) a=
nd CET (Control flow Enforcement Technology) assists. the event also counts=
 for Machine Ordering count. Available PDIST counters: 0",
+        "PublicDescription": "Count all other hardware assists or traps th=
at are not necessarily architecturally exposed (through a software handler)=
 beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-ev=
ents.  This includes, but not limited to, assists at EXE or MEM uop writeba=
ck like AVX* load/store/gather/scatter (non-FP GSSE-assist ) , assists gene=
rated by ROB like PEBS and RTIT, Uncore trap, RAR (Remote Action Request) a=
nd CET (Control flow Enforcement Technology) assists. the event also counts=
 for Machine Ordering count.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -14,7 +14,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.PAGE_FAULT",
-        "PublicDescription": "ASSISTS.PAGE_FAULT Available PDIST counters:=
 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -24,7 +23,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_1",
-        "PublicDescription": "CORE_POWER.LICENSE_1 Available PDIST counter=
s: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -34,7 +32,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_2",
-        "PublicDescription": "CORE_POWER.LICENSE_2 Available PDIST counter=
s: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -44,7 +41,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_3",
-        "PublicDescription": "CORE_POWER.LICENSE_3 Available PDIST counter=
s: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -113,7 +109,7 @@
         "CounterMask": "1",
         "EventCode": "0x2d",
         "EventName": "XQ.FULL_CYCLES",
-        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache). Available PDIST=
 counters: 0",
+        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache).",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index 48ef2a8cc49a..33d1f39e441f 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -6,7 +6,6 @@
         "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIVIDER_ACTIVE",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 ARITH.DIV_ACTIVE Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x9",
         "Unit": "cpu_core"
@@ -27,7 +26,7 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIV_ACTIVE",
-        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
         "SampleAfterValue": "1000003",
         "UMask": "0x9",
         "Unit": "cpu_core"
@@ -57,7 +56,6 @@
         "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FP_DIVIDER_ACTIVE",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 ARITH.FPDIV_ACTIVE Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -78,7 +76,6 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
-        "PublicDescription": "This event counts the cycles the integer div=
ider is busy. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -108,7 +105,6 @@
         "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.INT_DIVIDER_ACTIVE",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 ARITH.IDIV_ACTIVE Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -118,7 +114,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.ANY",
-        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
         "SampleAfterValue": "100003",
         "UMask": "0x1b",
         "Unit": "cpu_core"
@@ -549,7 +545,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C01",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions. Availab=
le PDIST counters: 0",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -559,7 +555,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C02",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions. Availab=
le PDIST counters: 0",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -569,7 +565,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction. Available PDIST counters: 0",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
         "SampleAfterValue": "2000003",
         "UMask": "0x70",
         "Unit": "cpu_core"
@@ -597,7 +593,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
-        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread. Available PDIST counters: 0",
+        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -607,7 +603,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
-        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
         "SampleAfterValue": "25003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -617,7 +613,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
-        "PublicDescription": "CPU_CLK_UNHALTED.PAUSE Available PDIST count=
ers: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -629,7 +624,6 @@
         "EdgeDetect": "1",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
-        "PublicDescription": "CPU_CLK_UNHALTED.PAUSE_INST Available PDIST =
counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -649,7 +643,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
-        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread. Available PDIST counters: 0",
+        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -687,7 +681,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
-        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case. Avail=
able PDIST counters: 0",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -724,7 +718,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. Available PDIST counters: 0",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
     },
@@ -734,7 +728,6 @@
         "CounterMask": "8",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
-        "PublicDescription": "Cycles while L1 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -745,7 +738,6 @@
         "CounterMask": "1",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
-        "PublicDescription": "Cycles while L2 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -756,7 +748,6 @@
         "CounterMask": "16",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
-        "PublicDescription": "Cycles while memory subsystem has an outstan=
ding load. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -767,7 +758,6 @@
         "CounterMask": "12",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
-        "PublicDescription": "Execution stalls while L1 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xc",
         "Unit": "cpu_core"
@@ -778,7 +768,6 @@
         "CounterMask": "5",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
-        "PublicDescription": "Execution stalls while L2 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_core"
@@ -789,7 +778,6 @@
         "CounterMask": "4",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
-        "PublicDescription": "Total execution stalls. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -799,7 +787,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
-        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty. Avail=
able PDIST counters: 0",
+        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -809,7 +797,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_3_PORTS_UTIL",
-        "PublicDescription": "Cycles total of 2 or 3 uops are executed on =
all ports and Reservation Station (RS) was not empty. Available PDIST count=
ers: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0xc",
         "Unit": "cpu_core"
@@ -819,7 +806,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
-        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty. Ava=
ilable PDIST counters: 0",
+        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -829,7 +816,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
-        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty. Available PDIST counters: =
0",
+        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -839,7 +826,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
-        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty. Available PDIST counters: =
0",
+        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -850,7 +837,6 @@
         "CounterMask": "5",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
-        "PublicDescription": "Execution stalls while memory subsystem has =
an outstanding load. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x21",
         "Unit": "cpu_core"
@@ -861,7 +847,7 @@
         "CounterMask": "2",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
-        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
         "SampleAfterValue": "1000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -871,7 +857,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
-        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load. Available PDIST counters: 0"=
,
+        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
         "SampleAfterValue": "1000003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -881,7 +867,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x75",
         "EventName": "INST_DECODED.DECODERS",
-        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions. Available PDIST cou=
nters: 0",
+        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -927,7 +913,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
-        "PublicDescription": "INST_RETIRED.MACRO_FUSED Available PDIST cou=
nters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -937,7 +922,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions Available PDIST counters: 0",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -956,7 +941,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent. Available PDIST counters: 0",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -968,7 +953,7 @@
         "EdgeDetect": "1",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEARS_COUNT",
-        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears Available PDIST count=
ers: 0",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
         "SampleAfterValue": "500009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -978,7 +963,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
-        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
. Available PDIST counters: 0",
+        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
         "SampleAfterValue": "500009",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -988,7 +973,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
-        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event. Available PDIST counters: 0",
+        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
         "SampleAfterValue": "500009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1000,7 +985,6 @@
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x7",
-        "PublicDescription": "Bubble cycles of BAClear (Unknown Branch). A=
vailable PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -1010,7 +994,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UOP_DROPPING",
-        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons Available P=
DIST counters: 0",
+        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1020,7 +1004,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.128BIT",
-        "PublicDescription": "INT_VEC_RETIRED.128BIT Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x13",
         "Unit": "cpu_core"
@@ -1030,7 +1013,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.256BIT",
-        "PublicDescription": "INT_VEC_RETIRED.256BIT Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xac",
         "Unit": "cpu_core"
@@ -1040,7 +1022,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_128",
-        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions. Available PDIST counters: 0=
",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -1050,7 +1032,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_256",
-        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions. Available PDIST counters: 0=
",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0xc",
         "Unit": "cpu_core"
@@ -1060,7 +1042,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.MUL_256",
-        "PublicDescription": "INT_VEC_RETIRED.MUL_256 Available PDIST coun=
ters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -1070,7 +1051,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.SHUFFLES",
-        "PublicDescription": "INT_VEC_RETIRED.SHUFFLES Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -1080,7 +1060,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_128",
-        "PublicDescription": "INT_VEC_RETIRED.VNNI_128 Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1090,7 +1069,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_256",
-        "PublicDescription": "INT_VEC_RETIRED.VNNI_256 Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1119,7 +1097,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address. Avail=
able PDIST counters: 0",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1138,7 +1116,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
-        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
         "SampleAfterValue": "100003",
         "UMask": "0x88",
         "Unit": "cpu_core"
@@ -1148,7 +1126,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
         "SampleAfterValue": "100003",
         "UMask": "0x82",
         "Unit": "cpu_core"
@@ -1158,7 +1136,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions. Available PDIST counters: 0",
+        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1169,7 +1147,7 @@
         "CounterMask": "1",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
-        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector). Available PDIST counters: 0",
+        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1180,7 +1158,7 @@
         "CounterMask": "6",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
-        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector). Available PDIST counters:=
 0",
+        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1190,7 +1168,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
-        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector). Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1202,7 +1180,7 @@
         "EdgeDetect": "1",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.COUNT",
-        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1258,7 +1236,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
-        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear. Available PDIST counters: 0",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1268,7 +1246,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
-        "PublicDescription": "number of LFENCE retired instructions Availa=
ble PDIST counters: 0",
+        "PublicDescription": "number of LFENCE retired instructions",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1288,7 +1266,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. Available PDIST counters: 0",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1298,7 +1276,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SB",
-        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end. Available PDIST counters: 0",
+        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1308,7 +1286,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
-        "PublicDescription": "Counts cycles where the pipeline is stalled =
due to serializing operations. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1318,7 +1295,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY",
-        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses) Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
         "SampleAfterValue": "1000003",
         "UMask": "0x7",
         "Unit": "cpu_core"
@@ -1331,7 +1308,7 @@
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY_COUNT",
         "Invert": "1",
-        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events) Av=
ailable PDIST counters: 0",
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
         "SampleAfterValue": "100003",
         "UMask": "0x7",
         "Unit": "cpu_core"
@@ -1341,7 +1318,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY_RESOURCE",
-        "PublicDescription": "Cycles when Reservation Station (RS) is empt=
y due to a resource in the back-end Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1355,7 +1331,6 @@
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.COUNT",
         "Invert": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 RS.EMPTY_COUNT Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x7",
         "Unit": "cpu_core"
@@ -1366,7 +1341,6 @@
         "Deprecated": "1",
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.CYCLES",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 RS.EMPTY Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x7",
         "Unit": "cpu_core"
@@ -1395,7 +1369,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources. Available PDIST counters: 0",
+        "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
         "SampleAfterValue": "10000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1405,7 +1379,7 @@
         "Counter": "0",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
-        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations. Available PDIST counters: 0",
+        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
         "SampleAfterValue": "10000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1415,7 +1389,7 @@
         "Counter": "0",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction. Ava=
ilable PDIST counters: 0",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1425,7 +1399,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
-        "PublicDescription": "TOPDOWN.MEMORY_BOUND_SLOTS Available PDIST c=
ounters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1444,7 +1417,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
-        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
         "SampleAfterValue": "10000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1661,7 +1634,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UOPS_DECODED.DEC0_UOPS",
-        "PublicDescription": "UOPS_DECODED.DEC0_UOPS Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1671,7 +1643,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_0",
-        "PublicDescription": "Number of uops dispatch to execution  port 0=
. Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1681,7 +1653,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_1",
-        "PublicDescription": "Number of uops dispatch to execution  port 1=
. Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1691,7 +1663,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
-        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10 Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1701,7 +1673,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
-        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9 Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1711,7 +1683,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_5_11",
-        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11 Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
         "SampleAfterValue": "2000003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1721,7 +1693,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_6",
-        "PublicDescription": "Number of uops dispatch to execution  port 6=
. Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
         "SampleAfterValue": "2000003",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -1731,7 +1703,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
-        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8. Available PDIST counters: 0",
+        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
         "SampleAfterValue": "2000003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -1742,7 +1714,7 @@
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
-        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1753,7 +1725,7 @@
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
-        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1764,7 +1736,7 @@
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
-        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1775,7 +1747,7 @@
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
-        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1786,7 +1758,7 @@
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
-        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread. Available PDIST counters: 0",
+        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1797,7 +1769,7 @@
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
-        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread. Available PDIST counters: 0",
+        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1808,7 +1780,7 @@
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
-        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread. Available PDIST counters: 0",
+        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1819,7 +1791,7 @@
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
-        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread. Available PDIST counters: 0",
+        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1831,7 +1803,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALLS",
         "Invert": "1",
-        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1844,7 +1816,6 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALL_CYCLES",
         "Invert": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UOPS_EXECUTED.STALLS Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1854,7 +1825,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.THREAD",
-        "PublicDescription": "Counts the number of uops to be executed per=
-thread each cycle. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1864,7 +1834,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.X87",
-        "PublicDescription": "Counts the number of x87 uops executed. Avai=
lable PDIST counters: 0",
+        "PublicDescription": "Counts the number of x87 uops executed.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1883,7 +1853,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.ANY",
-        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS). Available PD=
IST counters: 0",
+        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1894,7 +1864,6 @@
         "CounterMask": "1",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.CYCLES",
-        "PublicDescription": "UOPS_ISSUED.CYCLES Available PDIST counters:=
 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1913,7 +1882,7 @@
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.CYCLES",
-        "PublicDescription": "Counts cycles where at least one uop has ret=
ired. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1923,7 +1892,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
-        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count. Available P=
DIST counters: 0",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1954,7 +1923,6 @@
         "EventName": "UOPS_RETIRED.MS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
-        "PublicDescription": "UOPS_RETIRED.MS Available PDIST counters: 0"=
,
         "SampleAfterValue": "2000003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -1964,7 +1932,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
-        "PublicDescription": "Counts the retirement slots used each cycle.=
 Available PDIST counters: 0",
+        "PublicDescription": "Counts the retirement slots used each cycle.=
",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1976,7 +1944,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALLS",
         "Invert": "1",
-        "PublicDescription": "This event counts cycles without actually re=
tired uops. Available PDIST counters: 0",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1989,7 +1957,6 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
         "Invert": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UOPS_RETIRED.STALLS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.j=
son b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
index 7c0779c74154..b5604c7534e1 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
@@ -65,7 +65,6 @@
         "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "ARB"
@@ -103,7 +102,6 @@
         "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.RD",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "ARB"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
index ffbbd08acc68..132ce48af6d9 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
-        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB). Available PDIST counters: 0",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -15,7 +15,7 @@
         "CounterMask": "1",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load. Available PDIST cou=
nters: 0",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -35,7 +35,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault. Available =
PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
@@ -45,7 +45,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
-        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -55,7 +55,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -65,7 +65,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -75,7 +75,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle. Available PDIS=
T counters: 0",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -85,7 +85,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
-        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB). Available PDIST counters: 0",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -96,7 +96,7 @@
         "CounterMask": "1",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store. Available PDIST counters:=
 0",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -116,7 +116,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault. Available=
 PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
@@ -126,7 +126,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
-        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -136,7 +136,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -146,7 +146,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -156,7 +156,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle. Available PDIST coun=
ters: 0",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -184,7 +184,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.STLB_HIT",
-        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB). Available P=
DIST counters: 0",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -195,7 +195,7 @@
         "CounterMask": "1",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -215,7 +215,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
@@ -225,7 +225,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt. Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -235,7 +235,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
 Available PDIST counters: 0",
+        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
         "SampleAfterValue": "100003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -245,7 +245,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
         "SampleAfterValue": "100003",
         "UMask": "0x10",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index ce93648043ef..0f72c9192df6 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -1,56 +1,56 @@
 [
     {
         "BriefDescription": "C10 residency percent per package",
-        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c10\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C10_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C1 residency percent per core",
-        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c1\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C1_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C8 residency percent per package",
-        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c8\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C8_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -460,12 +460,12 @@
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricName": "tma_info_system_cpu_utilization"
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE_P@k / CPU_CLK_UNHALTED.CO=
RE",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P:k / CPU_CLK_UNHALTED.CORE",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_kernel_utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
index 7c0779c74154..b5604c7534e1 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
@@ -65,7 +65,6 @@
         "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "ARB"
@@ -103,7 +102,6 @@
         "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.RD",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "ARB"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 354ce241500b..d0a17905c74e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.31,alderlake,core
-GenuineIntel-6-BE,v1.31,alderlaken,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.33,alderlake,core
+GenuineIntel-6-BE,v1.33,alderlaken,core
 GenuineIntel-6-C[56],v1.09,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
--=20
2.51.0.rc1.167.g924127e9c0-goog

