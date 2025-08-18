Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302DF338F3D
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543991; cv=none; b=seE08IqhyCP2XSswtxooi3TlKICg2YtoqsImRlMoBrtZruiV6JGUdR/uMOXpY2TIWwS8Ki+0W8pS9/Jmtw7Fp5aDIWdbxaPmOJSacUh6ETv+dtjz5qVkagS7SdK8iKzmHSDf+vFVO7xOPw8BdvC5ToHgFA6QMUFgi1IQaUf0dcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543991; c=relaxed/simple;
	bh=c+vnH53dueGrXjkmBhCR4TCZuwVUSOh1cvKBTpQQNMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qsuU3LPlS2e4vSUNQqLRURqZ+IKpTACURMYOEZB9JONMBF+EvFfx04y90sfuA3tzruCQirp3+OIDsGAxJMPfJEv4qtoyadw0U8GXaYuf11iMZSJMOcZka6A4ioyT/Vpr6gIvbP+XONnbxgnfbs0WjY/pfTghKM/7SbSG1ZQ4v+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2y3MI6X; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2y3MI6X"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b474b68cff7so924863a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543985; x=1756148785; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzHAmaeXA9OIiXJ+xcmKvHI7wCRNulVu9l87+Mg8X58=;
        b=S2y3MI6XSU9a3xtUdgNKBDv/nOeIdWie15i+8BxPX+pja3+z9Q7mzn6+8nQlUnxTBE
         NcQOlwCEwYco3GGF69mrXGObvvL/Yvlh6/NGMi0WrwmJu2BfslDbmDEHmqjvzjwVLECp
         +/gZFlduVEHuqMR1d6qFXqMU1+jc4D6qetkUHWCNmth7l2tT9QqsyfGBjbNxh7alrMYf
         BGqfuMPfhb5SBVx4t3j6s7s5TFZeChwSkVx0OwdsSBDVLwMzRA3/1Ms/R3IMV+1WJ1+Q
         98EZmaWUryRuegf7lye2r3mfdsxib8c8VIx55rkT7QfrP4cUpOLw6YqRmjPuJmY/PqWo
         9idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543985; x=1756148785;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BzHAmaeXA9OIiXJ+xcmKvHI7wCRNulVu9l87+Mg8X58=;
        b=ejzu3dxMt+7t2763DT4klqH9TTjWMF0ym035/qjm6G+3VWTqZTzTw995+bHXMFQaPX
         fjVR++ThpCEc+G1LjSsKLcJh8E7aHUzKza+jihNegBdgD/HN6Wpjz2MJyYpl9BbC5vTq
         iK56LErRG83VR+aBqsXU/aWelRSTSiCi+rXgPNtDB6NkoXsVbwhT9721wuR0OxlKClfE
         ruGVje6MX8HMe55+RbccFkhgg5K0ecbC5X6Z3o64X9YxJI3MyRiVk3UL2bUacdiL4QNB
         ZUrgB7mNvRbaMEikmS2nYx33t9IbnsUKJ+n8M0kCmP69XXw/ia/TMvhoutXO1hPdwVXX
         LpFg==
X-Forwarded-Encrypted: i=1; AJvYcCVOvGhzKUlbzm6niIzTpiRXcvGkCm7r/U+87gaH4Su+LfKhvpRKXuj0HTyxrsSfPWXt7+usWJLFeFhnNc+FFLBU@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEnBh/n8jHcQnexpUraJSHodGyvsdzYEuzjBckwN4hp02EsYl
	gv2Rd58pmLyqtV8PQzZDlBn914IWVIcpwL1UUirSVuLjFKhrQPfzdLD1BpvFk1mgdJs4JYRaXs6
	IY/6ebC/8KA==
X-Google-Smtp-Source: AGHT+IHVk3xwOEFPAJ+yrp6GaENL2yxmQp/jyPrGJOpv6fScF397QZbyMRL9ny28afa4CvnySYOzk02Re/7s
X-Received: from plblh13.prod.google.com ([2002:a17:903:290d:b0:240:52d7:e88a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac3:b0:242:9bbc:3647
 with SMTP id d9443c01a7336-2449d001e87mr5052245ad.57.1755543985452; Mon, 18
 Aug 2025 12:06:25 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:04:15 -0700
In-Reply-To: <20250818190416.145274-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818190416.145274-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818190416.145274-20-irogers@google.com>
Subject: [PATCH v2 19/20] perf vendor events: Update skylake metrics
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

Update metrics from TMA 5.0 to 5.1.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 .../arch/x86/skylake/skl-metrics.json         | 101 ++++++++++++------
 .../arch/x86/skylakex/skx-metrics.json        | 101 ++++++++++++------
 2 files changed, 134 insertions(+), 68 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tool=
s/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 2d3a037e88b5..707bd8790ed2 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -1,49 +1,49 @@
 [
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Core_Residency",
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
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -80,6 +80,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -117,6 +118,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
         "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
         "MetricName": "tma_bottleneck_big_code",
@@ -130,32 +132,36 @@
         "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
         "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)"
     },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "MetricConstraint": "NO_GROUP_EVENTS",
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
n long-latency execution units are busy. Related metrics: "
+    },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load + tma_=
fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + =
tma_store_fwd_blk)))",
         "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
-        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
+        "MetricName": "tma_bottleneck_data_cache_memory_bandwidth",
+        "MetricThreshold": "tma_bottleneck_data_cache_memory_bandwidth > 2=
0",
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
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
+ tma_store_latency)) + tma_memory_bound * (tma_store_bound / (tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tm=
a_store_latency)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_bottleneck_cache_memory_latency",
-        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
+        "MetricName": "tma_bottleneck_data_cache_memory_latency",
+        "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency"
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
n long-latency execution units are busy. Related metrics: "
-    },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - tma_mi=
crocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) *=
 (tma_assists / tma_microcode_sequencer) * tma_fetch_latency * (tma_ms_swit=
ches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_resteer=
s * (10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_misp=
redicts)) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unknown_b=
ranches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + t=
ma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_bottleneck_big_code",
         "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
         "MetricName": "tma_bottleneck_instruction_fetch_bw",
@@ -163,6 +169,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_microcode_sequencer / (tma_few_uops_inst=
ructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_sequence=
r) * tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clea=
rs_resteers + tma_mispredicts_resteers * (10 * tma_microcode_sequencer * tm=
a_other_mispredicts / tma_branch_mispredicts)) / (tma_clears_resteers + tma=
_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers + tma=
_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_swit=
ches) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_m=
ispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other_nukes =
/ tma_other_nukes + tma_core_bound * (tma_serializing_operation + tma_core_=
bound * RS_EVENTS.EMPTY_CYCLES / tma_info_thread_clks * tma_ports_utilized_=
0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) + tm=
a_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequence=
r) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
         "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
         "MetricName": "tma_bottleneck_irregular_overhead",
@@ -171,6 +178,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tm=
a_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency + =
tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store=
_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_spli=
t_stores + tma_store_latency)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
@@ -179,6 +187,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_stores =
+ tma_store_latency - tma_store_latency)) + tma_machine_clears * (1 - tma_o=
ther_nukes / tma_other_nukes))",
         "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
         "MetricName": "tma_bottleneck_memory_synchronization",
@@ -187,6 +196,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
         "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
         "MetricName": "tma_bottleneck_mispredictions",
@@ -195,7 +205,8 @@
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
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_data_cac=
he_memory_bandwidth + tma_bottleneck_data_cache_memory_latency + tma_bottle=
neck_memory_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottlen=
eck_compute_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_=
branching_overhead + tma_bottleneck_useful_work)",
         "MetricGroup": "BvOB;Cor;Offcore",
         "MetricName": "tma_bottleneck_other_bottlenecks",
         "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
@@ -203,6 +214,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slot=
s - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_se=
quencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)"=
,
         "MetricGroup": "BvUW;Ret",
         "MetricName": "tma_bottleneck_useful_work",
@@ -230,6 +242,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
@@ -391,7 +404,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -454,7 +467,6 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "FP_ARITH_INST_RETIRED.VECTOR / UOPS_RETIRED.RETIRE_=
SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
@@ -520,6 +532,7 @@
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Cycles representin=
g fraction of TMA slots wasted per non-speculative branch misprediction (re=
tired JEClear)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_bottleneck_mispredictions * tma_info_thread_slo=
ts / 4 / BR_MISP_RETIRED.ALL_BRANCHES / 100",
         "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
@@ -555,6 +568,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_mite=
)))",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
@@ -572,6 +586,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
@@ -713,7 +728,6 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
FP_ARITH_INST_RETIRED.VECTOR)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
@@ -975,7 +989,7 @@
         "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Mem;Backend;CacheHits",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
@@ -992,6 +1006,12 @@
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "tma_info_pipeline_fetch_mite"
     },
+    {
+        "BriefDescription": "Average number of uops fetched from MS per cy=
cle",
+        "MetricExpr": "IDQ.MS_UOPS / cpu@IDQ.MS_UOPS\\,cmask\\=3D1@",
+        "MetricGroup": "Fed;FetchLat;MicroSeq",
+        "MetricName": "tma_info_pipeline_fetch_ms"
+    },
     {
         "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ASSIST.ANY + OTHER_ASSISTS.A=
NY)",
@@ -1008,7 +1028,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * msr@tsc@ / 1e9 =
/ tma_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -1020,7 +1040,7 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
@@ -1029,7 +1049,7 @@
         "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / tma_info_system_time / 1e3",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_ban=
dwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full"
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_data_cache_memor=
y_bandwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
@@ -1175,12 +1195,13 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
+        "BriefDescription": "This metric ([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RETI=
RED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYCLE=
S_MEM_ANY - CYCLE_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1217,7 +1238,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -1241,6 +1262,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
@@ -1267,6 +1289,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_1G / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_1g",
@@ -1275,6 +1298,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPL=
ETED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_2m",
@@ -1283,6 +1307,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_4K / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_4k",
@@ -1291,6 +1316,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(12 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (9 =
* L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAND=
ING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
         "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
@@ -1315,7 +1341,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -1324,7 +1350,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -1348,7 +1374,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / tma_info_thread_slots",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
@@ -1358,6 +1383,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
@@ -1412,6 +1438,7 @@
     },
     {
         "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_m=
emory_operations + tma_fused_instructions + tma_non_fused_branches))",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_other_light_ops",
@@ -1421,6 +1448,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED.A=
LL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
         "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
@@ -1429,6 +1457,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMORY=
_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
         "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
@@ -1509,6 +1538,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (EX=
E_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / tma_=
info_thread_clks if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CY=
CLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring =
* EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
@@ -1595,7 +1625,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -1652,6 +1682,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_1G / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_1g",
@@ -1660,6 +1691,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_2M_4M / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_C=
OMPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_2m",
@@ -1668,6 +1700,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_4K / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_4k",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 7cc7b076c3e2..56c2caaafef4 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -1,49 +1,49 @@
 [
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Core_Residency",
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
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -301,6 +301,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -338,6 +339,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
         "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
         "MetricName": "tma_bottleneck_big_code",
@@ -351,32 +353,36 @@
         "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
         "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)"
     },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "MetricConstraint": "NO_GROUP_EVENTS",
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
n long-latency execution units are busy. Related metrics: "
+    },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_4k_aliasing + tma_dtlb_load + tma_=
fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + =
tma_store_fwd_blk)))",
         "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
-        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
+        "MetricName": "tma_bottleneck_data_cache_memory_bandwidth",
+        "MetricThreshold": "tma_bottleneck_data_cache_memory_bandwidth > 2=
0",
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
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
+ tma_store_latency)) + tma_memory_bound * (tma_store_bound / (tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tm=
a_store_latency)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_bottleneck_cache_memory_latency",
-        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
+        "MetricName": "tma_bottleneck_data_cache_memory_latency",
+        "MetricThreshold": "tma_bottleneck_data_cache_memory_latency > 20"=
,
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency"
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
n long-latency execution units are busy. Related metrics: "
-    },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - tma_mi=
crocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) *=
 (tma_assists / tma_microcode_sequencer) * tma_fetch_latency * (tma_ms_swit=
ches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_resteer=
s * (10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_misp=
redicts)) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unknown_b=
ranches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + t=
ma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_bottleneck_big_code",
         "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
         "MetricName": "tma_bottleneck_instruction_fetch_bw",
@@ -384,6 +390,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_microcode_sequencer / (tma_few_uops_inst=
ructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_sequence=
r) * tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clea=
rs_resteers + tma_mispredicts_resteers * (10 * tma_microcode_sequencer * tm=
a_other_mispredicts / tma_branch_mispredicts)) / (tma_clears_resteers + tma=
_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers + tma=
_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_swit=
ches) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_m=
ispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other_nukes =
/ tma_other_nukes + tma_core_bound * (tma_serializing_operation + tma_core_=
bound * RS_EVENTS.EMPTY_CYCLES / tma_info_thread_clks * tma_ports_utilized_=
0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) + tm=
a_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequence=
r) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
         "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
         "MetricName": "tma_bottleneck_irregular_overhead",
@@ -392,6 +399,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + tm=
a_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency + =
tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store=
_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_spli=
t_stores + tma_store_latency)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
@@ -400,6 +408,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
(tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) * tma_remote_cach=
e / (tma_local_mem + tma_remote_cache + tma_remote_mem) + tma_l3_bound / (t=
ma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_boun=
d) * (tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / =
(tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bo=
und) * tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_=
stores + tma_store_latency - tma_store_latency)) + tma_machine_clears * (1 =
- tma_other_nukes / tma_other_nukes))",
         "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
         "MetricName": "tma_bottleneck_memory_synchronization",
@@ -408,6 +417,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
         "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
         "MetricName": "tma_bottleneck_mispredictions",
@@ -416,7 +426,8 @@
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
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_data_cac=
he_memory_bandwidth + tma_bottleneck_data_cache_memory_latency + tma_bottle=
neck_memory_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottlen=
eck_compute_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_=
branching_overhead + tma_bottleneck_useful_work)",
         "MetricGroup": "BvOB;Cor;Offcore",
         "MetricName": "tma_bottleneck_other_bottlenecks",
         "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
@@ -424,6 +435,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slot=
s - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_se=
quencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)"=
,
         "MetricGroup": "BvUW;Ret",
         "MetricName": "tma_bottleneck_useful_work",
@@ -451,6 +463,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
@@ -612,7 +625,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -675,7 +688,6 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umas=
k\\=3D0xfc@ / UOPS_RETIRED.RETIRE_SLOTS",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
@@ -750,6 +762,7 @@
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Cycles representin=
g fraction of TMA slots wasted per non-speculative branch misprediction (re=
tired JEClear)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_bottleneck_mispredictions * tma_info_thread_slo=
ts / 4 / BR_MISP_RETIRED.ALL_BRANCHES / 100",
         "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
@@ -785,6 +798,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_mite=
)))",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
@@ -802,6 +816,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
@@ -943,7 +958,6 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR + =
cpu@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\,umask\\=3D0xfc@)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
@@ -1225,7 +1239,7 @@
         "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Mem;Backend;CacheHits",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
@@ -1242,6 +1256,12 @@
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "tma_info_pipeline_fetch_mite"
     },
+    {
+        "BriefDescription": "Average number of uops fetched from MS per cy=
cle",
+        "MetricExpr": "IDQ.MS_UOPS / cpu@IDQ.MS_UOPS\\,cmask\\=3D1@",
+        "MetricGroup": "Fed;FetchLat;MicroSeq",
+        "MetricName": "tma_info_pipeline_fetch_ms"
+    },
     {
         "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
         "MetricExpr": "INST_RETIRED.ANY / (FP_ASSIST.ANY + OTHER_ASSISTS.A=
NY)",
@@ -1258,7 +1278,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * msr@tsc@ / 1e9 =
/ tma_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -1270,7 +1290,7 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
@@ -1279,7 +1299,7 @@
         "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / tma_info_system_time",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_ban=
dwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full"
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_data_cache_memor=
y_bandwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
@@ -1475,12 +1495,13 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
+        "BriefDescription": "This metric ([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RETI=
RED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYCLE=
S_MEM_ANY - CYCLE_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1517,7 +1538,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -1541,6 +1562,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_2 + UOPS_DISPATCHED_PORT=
.PORT_3 + UOPS_DISPATCHED_PORT.PORT_7 - UOPS_DISPATCHED_PORT.PORT_4) / (2 *=
 tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_load_op_utilization",
@@ -1567,6 +1589,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_1G / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_1g",
@@ -1575,6 +1598,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPL=
ETED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_2m",
@@ -1583,6 +1607,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_4K / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_4k",
@@ -1600,6 +1625,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(12 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (11=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
         "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
@@ -1624,7 +1650,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -1633,7 +1659,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -1657,7 +1683,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / UOPS_ISSUED.ANY * IDQ.M=
S_UOPS / tma_info_thread_slots",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
@@ -1667,6 +1692,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
@@ -1721,6 +1747,7 @@
     },
     {
         "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_m=
emory_operations + tma_fused_instructions + tma_non_fused_branches))",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_other_light_ops",
@@ -1730,6 +1757,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED.A=
LL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
         "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
@@ -1738,6 +1766,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMORY=
_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
         "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
@@ -1818,6 +1847,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (EX=
E_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / tma_=
info_thread_clks if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CY=
CLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring =
* EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
@@ -1923,7 +1953,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -1980,6 +2010,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_1G / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_1g",
@@ -1988,6 +2019,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_2M_4M / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_C=
OMPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_2m",
@@ -1996,6 +2028,7 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_4K / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_4k",
--=20
2.51.0.rc1.167.g924127e9c0-goog

