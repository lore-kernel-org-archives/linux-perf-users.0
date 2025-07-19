Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E121884A
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896736; cv=none; b=HtSJ1DKFAKM/bDWb9FYziDUzO1oQNZaAy7qRIgmiQE0K7+ImF84cLj0vioYEQeS4eIUq941UvcPboJoHlROWcYOlbCa87NlVrmtCgV18ltXhuv6IXMIXSo0OXWrZJMLH02Pwz2eZNBZ9Mlc52x0AeERwvGpEaYC3zgSh8knSQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896736; c=relaxed/simple;
	bh=xFTNvFkmYo1uM2XaL6FP1zrsQ+xIMFA+dyEbfiFXxbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V4Ls6RnkTnsNMQi85irvYEhhl61+XZy/mZEQA4/fpFbmbFqA2jUOiLJqA7VHHzE8lnjXnTIbSoBWFMttnPDp1yIieobNhizbKLl4d9D5AiWWYNUVAt7pe34R/Wcc1RryJsQccygVT9/0ShdCuC29fL6i6WadYqKxtF8gu1AbASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXXxUCv/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXXxUCv/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31315427249so2558721a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752896729; x=1753501529; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2r71u9Bw9kyGry8Dg+LafrpxZTDsysZsOvttEbY9mWw=;
        b=jXXxUCv/BMTP88ucUkN+6sRKKSKEJ5er1PRLkk/x7IpgC+8gU2mIRwFZjBmAsCJRcu
         t6zR6Cv8q4MT8RZJRSuM58UaBDgII7iH+0KdMjgpxXzCgvnRT+0+BFcrysFYazhdDa1A
         M7gS8LdAKk8Fn6LoLHmNoqg+hxcjhvZNZpohnWdxmeQMd5QwhnJO4clnj8feKglSqf06
         jT+TaOHw0DZnxSX4Y1z6CXDksxRpz/NoJjx4lzRTyLqSCmVV+IRKkkZMqof1QOZ6AG2o
         fwfqPwcF1chpsl4I+gzoXFPSIYT+4syG8KG+aSbfjODggoOhgkIg2xi5zII5I+qU+ZU5
         Nx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896729; x=1753501529;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2r71u9Bw9kyGry8Dg+LafrpxZTDsysZsOvttEbY9mWw=;
        b=kiK5KvgjuEU7L/n4irn0NbaS/fJ9wuhUMoX63tIAYTNZQHjKVATVfyTFYsmrjLUbwp
         TsSKOWwBiF8+Q1UaBbNRQR/agEodo3Lg+/FYQCHwxEeomSXfu8hK4FFydxyhzx3RKTw9
         e5gPCo7RVmkcOL1UU4ZCrv3qZAA7JyJ5D1tUb7SATKvj+RhKh3J5PwHzn4f6rEbttF3R
         8bzB6VOZKozgnhbtOx4AI8ghQ8XTiWiKz9MiSkFl9rXdQrZ14fzwqaTZqkfN9v37G21N
         COI0Yixq+FpZedDkXp95WxQKInt6webO1XhWSLHFT3ugSDTPqKrXkLaAUeptlQH+9gSj
         51GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnT4bpeNnVc1dHXyqv1GpuzjURR8BVtc1VQ4MIJI1z7LfxnPWMINB5aeRa/UFKVZU6lIyoumLKC5LdqLzaMP+I@vger.kernel.org
X-Gm-Message-State: AOJu0YxD9Wms4J8umkr/HDHLBGgtPSKh1g3yrNz8pXU3Xi7wx/O9pA5X
	AwsdFV0DILEkJqTLbg2MO8SDeSzeXimw3ohlTtSJ2rqH+KmQZlG0iaLig2uLyxh3FfQjCjhoUSX
	dE/u/RGAKoA==
X-Google-Smtp-Source: AGHT+IGgqjsbrFRfo89CYqDG9JDdK0KGYBQfPO+ICLzH2PRRKfnXTEVU5tzndr4igyz8/Vt973YVp7GlezyR
X-Received: from pjbqd16.prod.google.com ([2002:a17:90b:3cd0:b0:31c:15e1:d04])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f8d:b0:316:d69d:49fb
 with SMTP id 98e67ed59e1d1-31c9e70915amr21926694a91.14.1752896729383; Fri, 18
 Jul 2025 20:45:29 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:44:58 -0700
In-Reply-To: <20250719034515.2000467-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719034515.2000467-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719034515.2000467-3-irogers@google.com>
Subject: [PATCH v1 02/19] perf vendor events: Update arrowlake events/metrics
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.09 to v1.12. Update metrics from TMA 5.0 to 5.1.

The event updates come from:
https://github.com/intel/perfmon/commit/d5b1d2e9ee89035198ab7752e0378acba86=
907b6
https://github.com/intel/perfmon/commit/b9c162b7c98874321af36a411ee3c2194ea=
9afeb

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/arrowlake/arl-metrics.json       | 180 +++++++++++-------
 .../pmu-events/arch/x86/arrowlake/cache.json  | 122 ++++++++----
 .../arch/x86/arrowlake/frontend.json          |  40 ++--
 .../pmu-events/arch/x86/arrowlake/memory.json |  22 +--
 .../arch/x86/arrowlake/pipeline.json          |  94 +++++----
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 6 files changed, 282 insertions(+), 178 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json
index b22a02450e6c..4f1f77404943 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json
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
@@ -567,7 +567,7 @@
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / msr@tsc\\,cpu=
=3Dcpu_atom@",
         "MetricName": "tma_info_system_cpu_utilization",
         "Unit": "cpu_atom"
     },
@@ -774,7 +774,7 @@
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
@@ -786,7 +786,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "cpu_core@topdown\\-bad\\-spec@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "cpu_core@topdown\\-bad\\-spec@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@)",
         "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
@@ -812,36 +812,36 @@
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
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_capacity + tma_l1_latency_dependency + tma_lock_latency + tma_split_=
loads + tma_store_fwd_blk)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_capacity + tma_l1_latency_dependency + tma_lock_latency + tma_split_=
loads + tma_store_early_blk + tma_store_fwd_blk)))",
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
re_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l1_latency_c=
apacity / (tma_dtlb_load + tma_fb_full + tma_l1_latency_capacity + tma_l1_l=
atency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)=
) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma=
_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtl=
b_load + tma_fb_full + tma_l1_latency_capacity + tma_l1_latency_dependency =
+ tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bou=
nd * (tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_split_loads / (tma_dtlb_load + tma_fb_ful=
l + tma_l1_latency_capacity + tma_l1_latency_dependency + tma_lock_latency =
+ tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bou=
nd / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_sto=
re_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sharing + tma_=
split_stores + tma_store_latency + tma_streaming_stores)) + tma_memory_boun=
d * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb_store + tma_f=
alse_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores)=
))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
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
@@ -849,7 +849,7 @@
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
code_sequencer / (tma_microcode_sequencer + tma_few_uops_instructions) * (t=
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
+ tma_microcode_sequencer / (tma_microcode_sequencer + tma_few_uops_instruc=
tions) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
         "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
         "MetricName": "tma_bottleneck_irregular_overhead",
         "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
@@ -858,7 +858,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l1_latency_capacity + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_fw=
d_blk)) + tma_memory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bo=
und + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_dtlb_store / (=
tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency +=
 tma_streaming_stores)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l1_latency_capacity + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_ea=
rly_blk + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_=
dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound))=
 * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores=
 + tma_store_latency + tma_streaming_stores)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -885,7 +885,7 @@
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
@@ -902,7 +902,7 @@
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
@@ -1042,7 +1042,6 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ * min(=
cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@R, 24 * tma_info_system_core_fre=
quency) + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM@ * min(cpu_core@MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HITM@R, 25 * tma_info_system_core_frequency)) * (1 +=
 cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2=
) / tma_info_thread_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
@@ -1095,7 +1094,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
-        "MetricExpr": "(cpu_core@IDQ.DSB_UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x=
1@ + cpu_core@IDQ.DSB_UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.MITE_U=
OPS@) * (cpu_core@IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE@ - cpu_core@IDQ_BUBB=
LES.FETCH_LATENCY@)) / tma_info_thread_clks",
+        "MetricExpr": "(cpu_core@IDQ.DSB_UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x=
1@ / 2 + cpu_core@IDQ.DSB_UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.MI=
TE_UOPS@) * (cpu_core@IDQ_BUBBLES.STARVATION_CYCLES@ - cpu_core@IDQ_BUBBLES=
.FETCH_LATENCY@)) / tma_info_thread_clks",
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
         "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
@@ -1149,7 +1148,7 @@
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
@@ -1166,7 +1165,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "cpu_core@topdown\\-fetch\\-lat@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "cpu_core@topdown\\-fetch\\-lat@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@)",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
@@ -1216,7 +1215,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
-        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ / (tma_retir=
ing * tma_info_thread_slots)",
+        "MetricExpr": "cpu_core@FP_ARITH_OPS_RETIRED.SCALAR@ / (tma_retiri=
ng * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
         "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -1226,7 +1225,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.VECTOR@ / (tma_retir=
ing * tma_info_thread_slots)",
+        "MetricExpr": "cpu_core@FP_ARITH_OPS_RETIRED.VECTOR@ / (tma_retiri=
ng * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
         "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -1236,7 +1235,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
+        "MetricExpr": "(cpu_core@FP_ARITH_OPS_RETIRED.128B_PACKED_DOUBLE@ =
+ cpu_core@FP_ARITH_OPS_RETIRED.128B_PACKED_SINGLE@) / (tma_retiring * tma_=
info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
         "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -1246,7 +1245,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
-        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.VECTOR\\,umask\\=3D0=
x30@ / (tma_retiring * tma_info_thread_slots)",
+        "MetricExpr": "cpu_core@FP_ARITH_OPS_RETIRED.VECTOR\\,umask\\=3D0x=
30@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
         "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
@@ -1257,7 +1256,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@)",
         "MetricGroup": "BvFB;BvIO;Default;PGO;TmaL1;TopdownL1;tma_L1_group=
",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
@@ -1278,7 +1277,7 @@
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
@@ -1456,7 +1455,7 @@
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu_c=
ore@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INST_=
RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) =
/ tma_info_thread_clks",
+        "MetricExpr": "(cpu_core@FP_ARITH_OPS_RETIRED.SCALAR@ + 2 * cpu_co=
re@FP_ARITH_OPS_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_OPS_RET=
IRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_OPS_RETIRED.256B_PACKED_SINGLE@) / tm=
a_info_thread_clks",
         "MetricGroup": "Flops;Ret",
         "MetricName": "tma_info_core_flopc",
         "Unit": "cpu_core"
@@ -1597,7 +1596,7 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.SCALAR@ + cpu_core@FP_ARITH_INST_RETIRED.VECTOR@)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_OPS=
_RETIRED.SCALAR@ + cpu_core@FP_ARITH_OPS_RETIRED.VECTOR@)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
@@ -1606,7 +1605,7 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.128B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_=
SINGLE@)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_OPS=
_RETIRED.128B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_OPS_RETIRED.128B_PACKED_SI=
NGLE@)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
@@ -1615,7 +1614,7 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.256B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_=
SINGLE@)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_OPS=
_RETIRED.256B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_OPS_RETIRED.256B_PACKED_SI=
NGLE@)",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
@@ -1624,7 +1623,7 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FP_ARITH_INST=
_RETIRED.SCALAR_DOUBLE@",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FP_ARITH_OPS_=
RETIRED.SCALAR_DOUBLE@",
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
@@ -1633,7 +1632,7 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FP_ARITH_INST=
_RETIRED.SCALAR_SINGLE@",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FP_ARITH_OPS_=
RETIRED.SCALAR_SINGLE@",
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
@@ -1658,7 +1657,7 @@
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.SCALAR@ + 2 * cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ =
+ 4 * cpu_core@FP_ARITH_INST_RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_=
RETIRED.256B_PACKED_SINGLE@)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_OPS=
_RETIRED.SCALAR@ + 2 * cpu_core@FP_ARITH_OPS_RETIRED.128B_PACKED_DOUBLE@ + =
4 * cpu_core@FP_ARITH_OPS_RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_OPS_RETI=
RED.256B_PACKED_SINGLE@)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_ipflop",
         "MetricThreshold": "tma_info_inst_mix_ipflop < 10",
@@ -1713,7 +1712,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / tma_info_sys=
tem_time",
+        "MetricExpr": "64 * cpu_core@L1D.L1_REPLACEMENT@ / 1e9 / tma_info_=
system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw",
         "Unit": "cpu_core"
@@ -1725,6 +1724,13 @@
         "MetricName": "tma_info_memory_l1dl0_cache_fill_bw",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "L0 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * (cpu_core@MEM_LOAD_RETIRED.L1_MISS@ + cpu_cor=
e@MEM_LOAD_RETIRED.L1_HIT_L1@) / cpu_core@INST_RETIRED.ANY@",
+        "MetricGroup": "CacheHits;Mem",
+        "MetricName": "tma_info_memory_l1dl0_mpki",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / cpu_core=
@INST_RETIRED.ANY@",
@@ -1940,6 +1946,13 @@
         "MetricName": "tma_info_pipeline_fetch_mite",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Average number of uops fetched from MS per cy=
cle",
+        "MetricExpr": "cpu_core@IDQ.MS_UOPS@ / cpu_core@IDQ.MS_UOPS\\,cmas=
k\\=3D1@",
+        "MetricGroup": "Fed;FetchLat;MicroSeq",
+        "MetricName": "tma_info_pipeline_fetch_ms",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@ASSISTS.ANY@"=
,
@@ -1974,7 +1987,7 @@
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
@@ -1988,14 +2001,22 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / msr@tsc\\,cpu=
=3Dcpu_core@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "32 * UNC_M_TOTAL_DATA / 1e9 / tma_info_system_time"=
,
+        "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
+        "MetricName": "tma_info_system_dram_bw_use",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_data_cache_memor=
y_bandwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu_c=
ore@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INST_=
RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) =
/ 1e9 / tma_info_system_time",
+        "MetricExpr": "(cpu_core@FP_ARITH_OPS_RETIRED.SCALAR@ + 2 * cpu_co=
re@FP_ARITH_OPS_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_OPS_RET=
IRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_OPS_RETIRED.256B_PACKED_SINGLE@) / 1e=
9 / tma_info_system_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width",
@@ -2061,6 +2082,13 @@
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
@@ -2182,12 +2210,12 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
-        "MetricExpr": "4 * cpu_core@DEPENDENT_LOADS.ANY@ / tma_info_thread=
_clks",
+        "BriefDescription": "This metric ([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache",
+        "MetricExpr": "4 * cpu_core@DEPENDENT_LOADS.ANY\\,cmask\\=3D1@ / t=
ma_info_thread_clks",
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
@@ -2203,7 +2231,6 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "cpu_core@MEM_LOAD_RETIRED.L2_HIT@ * min(cpu_core@ME=
M_LOAD_RETIRED.L2_HIT@R, 3 * tma_info_system_core_frequency) * (1 + cpu_cor=
e@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_=
info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
         "MetricName": "tma_l2_hit_latency",
@@ -2224,12 +2251,11 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * min(cpu_core@ME=
M_LOAD_RETIRED.L3_HIT@R, 9 * tma_info_system_core_frequency) * (1 + cpu_cor=
e@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_=
info_thread_clks",
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
@@ -2311,6 +2337,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ * cpu_core@ME=
M_INST_RETIRED.LOCK_LOADS@R / tma_info_thread_clks",
         "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
@@ -2321,7 +2348,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to LSD (Loop Stream Detector) unit",
-        "MetricExpr": "cpu_core@LSD.UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x1@ / =
tma_info_thread_clks",
+        "MetricExpr": "cpu_core@LSD.UOPS\\,cmask\\=3D0x8\\,inv\\=3D0x1@ / =
tma_info_thread_clks / 2",
         "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_lsd",
         "MetricThreshold": "tma_lsd > 0.15 & tma_fetch_bandwidth > 0.2",
@@ -2346,7 +2373,7 @@
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
@@ -2356,13 +2383,13 @@
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
@@ -2373,7 +2400,6 @@
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
@@ -2412,7 +2438,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
-        "MetricExpr": "(cpu_core@IDQ.MITE_UOPS\\,cmask\\=3D0x8\\,inv\\=3D0=
x1@ / 2 + cpu_core@IDQ.MITE_UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.=
MITE_UOPS@) * (cpu_core@IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE@ - cpu_core@ID=
Q_BUBBLES.FETCH_LATENCY@)) / tma_info_thread_clks",
+        "MetricExpr": "(cpu_core@IDQ.MITE_UOPS\\,cmask\\=3D0x8\\,inv\\=3D0=
x1@ / 2 + cpu_core@IDQ.MITE_UOPS@ / (cpu_core@IDQ.DSB_UOPS@ + cpu_core@IDQ.=
MITE_UOPS@) * (cpu_core@IDQ_BUBBLES.STARVATION_CYCLES@ - cpu_core@IDQ_BUBBL=
ES.FETCH_LATENCY@)) / tma_info_thread_clks",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
         "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
@@ -2432,7 +2458,7 @@
     },
     {
         "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details.",
-        "MetricExpr": "cpu_core@IDQ.MS_CYCLES_ANY@ / tma_info_thread_clks"=
,
+        "MetricExpr": "cpu_core@IDQ.MS_CYCLES_ANY@ / tma_info_thread_clks =
/ 1.8",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
         "MetricName": "tma_ms",
         "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
@@ -2471,7 +2497,8 @@
     },
     {
         "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
-        "MetricExpr": "max(0, tma_light_operations - (tma_x87_use + (cpu_c=
ore@FP_ARITH_INST_RETIRED.SCALAR@ + cpu_core@FP_ARITH_INST_RETIRED.VECTOR@)=
 / (tma_retiring * tma_info_thread_slots) + (cpu_core@INT_VEC_RETIRED.ADD_1=
28@ + cpu_core@INT_VEC_RETIRED.VNNI_128@ + cpu_core@INT_VEC_RETIRED.ADD_256=
@ + cpu_core@INT_VEC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@)=
 / (tma_retiring * tma_info_thread_slots) + tma_memory_operations + tma_fus=
ed_instructions + tma_non_fused_branches))",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "max(0, tma_light_operations - (tma_x87_use + (cpu_c=
ore@FP_ARITH_OPS_RETIRED.SCALAR@ + cpu_core@FP_ARITH_OPS_RETIRED.VECTOR@) /=
 (tma_retiring * tma_info_thread_slots) + (cpu_core@INT_VEC_RETIRED.ADD_128=
@ + cpu_core@INT_VEC_RETIRED.VNNI_128@ + cpu_core@INT_VEC_RETIRED.ADD_256@ =
+ cpu_core@INT_VEC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@) /=
 (tma_retiring * tma_info_thread_slots) + tma_memory_operations + tma_fused=
_instructions + tma_non_fused_branches))",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_other_light_ops",
         "MetricThreshold": "tma_other_light_ops > 0.3 & tma_light_operatio=
ns > 0.6",
@@ -2509,6 +2536,7 @@
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "((cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + (cpu_c=
ore@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_3_P=
ORTS_UTIL@)) / tma_info_thread_clks if cpu_core@ARITH.DIV_ACTIVE@ < cpu_cor=
e@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ else=
 (cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVIT=
Y.2_3_PORTS_UTIL@) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
@@ -2519,6 +2547,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricConstraint": "NO_THRESHOLD_AND_NMI",
         "MetricExpr": "cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ / tma_info=
_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
@@ -2529,6 +2558,7 @@
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
@@ -2539,7 +2569,6 @@
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
@@ -2550,7 +2579,6 @@
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
@@ -2571,7 +2599,7 @@
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
@@ -2586,7 +2614,7 @@
         "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_bou=
nd_group;tma_issueSO",
         "MetricName": "tma_serializing_operation",
         "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_bo=
und > 0.1 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: PARTIAL_RAT_STALLS.SCOREBOARD. Related me=
trics: tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2602,7 +2630,6 @@
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
@@ -2637,7 +2664,7 @@
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
@@ -2651,6 +2678,15 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric estimates clocks wasted due to lo=
ads blocked due to unknown store address (did not do memory disambiguation)=
 or due to unknown store data",
+        "MetricExpr": "7 * cpu_core@LD_BLOCKS.STORE_EARLY\\,cmask\\=3D1@ /=
 tma_info_thread_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
+        "MetricName": "tma_store_early_blk",
+        "MetricThreshold": "tma_store_early_blk > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
         "MetricExpr": "13 * cpu_core@LD_BLOCKS.STORE_FORWARD@ / tma_info_t=
hread_clks",
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/arrowlake/cache.json
index 91929d8bcf47..f5168b55a6f4 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
@@ -28,6 +28,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cachelines replaced into the L1 d-cache. Succ=
essful replacements only (not blocked) and exclude WB-miss case",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x51",
+        "EventName": "L1D.L1_REPLACEMENT",
+        "PublicDescription": "Counts cachelines replaced into the L1 d-cac=
he.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cachelines replaced into the L0 and L1 d-cach=
e. Successful replacements only (not blocked) and exclude WB-miss case",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -540,7 +550,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
-        "PublicDescription": "Counts Instructions with at least one archit=
ecturally visible load retired. Available PDIST counters: 0",
+        "PublicDescription": "Counts Instructions with at least one archit=
ecturally visible load retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x81",
         "Unit": "cpu_core"
@@ -551,7 +561,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "PublicDescription": "Counts all retired store instructions. Avail=
able PDIST counters: 0",
+        "PublicDescription": "Counts all retired store instructions. Avail=
able PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x82",
         "Unit": "cpu_core"
@@ -561,7 +571,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_SWPF",
-        "PublicDescription": "Counts all retired software prefetch instruc=
tions. Available PDIST counters: 0",
+        "PublicDescription": "Counts all retired software prefetch instruc=
tions. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x84",
         "Unit": "cpu_core"
@@ -572,7 +582,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
-        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores. Available PDIST counters: 0",
+        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x87",
         "Unit": "cpu_core"
@@ -583,7 +593,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
-        "PublicDescription": "Counts retired load instructions with locked=
 access. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired load instructions with locked=
 access. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x21",
         "Unit": "cpu_core"
@@ -594,7 +604,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary. Available PDIST counters: 0,1",
         "SampleAfterValue": "100003",
         "UMask": "0x41",
         "Unit": "cpu_core"
@@ -605,18 +615,29 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
-        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary. Available PDIST counters: 0,1",
         "SampleAfterValue": "100003",
         "UMask": "0x42",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Retired instructions that hit the STLB.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_ANY",
+        "PublicDescription": "Number of retired instructions with a clean =
hit in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0xf",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Retired load instructions that hit the STLB."=
,
         "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_HIT_LOADS",
-        "PublicDescription": "Number of retired load instructions with a c=
lean hit in the 2nd-level TLB (STLB). Available PDIST counters: 0",
+        "PublicDescription": "Number of retired load instructions with a c=
lean hit in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
         "SampleAfterValue": "100003",
         "UMask": "0x9",
         "Unit": "cpu_core"
@@ -627,18 +648,39 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_HIT_STORES",
-        "PublicDescription": "Number of retired store instructions that hi=
t in the 2nd-level TLB (STLB). Available PDIST counters: 0",
+        "PublicDescription": "Number of retired store instructions that hi=
t in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
         "SampleAfterValue": "100003",
         "UMask": "0xa",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Retired SWPF instructions that hit the STLB."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_SWPF",
+        "PublicDescription": "Number of retired SWPF instructions that hit=
 in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that miss the STLB.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_ANY",
+        "PublicDescription": "Retired instructions that miss the STLB. Ava=
ilable PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x17",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Retired load instructions that miss the STLB.=
",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
-        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0",
+        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
         "SampleAfterValue": "100003",
         "UMask": "0x11",
         "Unit": "cpu_core"
@@ -649,18 +691,28 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
-        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0",
+        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
         "SampleAfterValue": "100003",
         "UMask": "0x12",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Retired SWPF instructions that miss the STLB.=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_SWPF",
+        "PublicDescription": "Number of retired SWPF instructions that (st=
art a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x14",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were a cross-core Snoop hits and forwards data from an in on-package core c=
ache (induced by NI$)",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
-        "PublicDescription": "Counts retired load instructions whose data =
sources were a cross-core Snoop hits and forwards data from an in on-packag=
e core cache (induced by NI$) Available PDIST counters: 0",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were a cross-core Snoop hits and forwards data from an in on-packag=
e core cache (induced by NI$) Available PDIST counters: 0,1",
         "SampleAfterValue": "20011",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -671,7 +723,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
-        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3, Hit-with-FWD is normally exclud=
ed. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3, Hit-with-FWD is normally exclud=
ed. Available PDIST counters: 0,1",
         "SampleAfterValue": "20011",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -682,7 +734,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
-        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache. A=
vailable PDIST counters: 0",
+        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache. A=
vailable PDIST counters: 0,1",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -693,7 +745,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
-        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache. Available P=
DIST counters: 0",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache. Available P=
DIST counters: 0,1",
         "SampleAfterValue": "20011",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -704,7 +756,7 @@
         "Data_LA": "1",
         "EventCode": "0xd4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
-        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock). Available PDIST counters: 0",
+        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock). Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -715,7 +767,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready. Available PDIST counters:=
 0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready. Available PDIST counters:=
 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -726,7 +778,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source. Available PDIST c=
ounters: 0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source. Available PDIST c=
ounters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x101",
         "Unit": "cpu_core"
@@ -737,7 +789,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT_L0",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 0 of the L1 data cache. This event include=
s all SW prefetches and lock instructions regardless of the data source. Av=
ailable PDIST counters: 0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 0 of the L1 data cache. This event include=
s all SW prefetches and lock instructions regardless of the data source. Av=
ailable PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -747,7 +799,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT_L1",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 1 of the L1 data cache. Available PDIST co=
unters: 0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 1 of the L1 data cache. Available PDIST co=
unters: 0,1",
         "SampleAfterValue": "1000003",
         "Unit": "cpu_core"
     },
@@ -757,7 +809,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache. Available PDIST counters: 0,1",
         "SampleAfterValue": "200003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -768,7 +820,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
-        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources. Available PDIST counters: 0,1",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -779,7 +831,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
-        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources. Available PDIST counters: 0,1",
         "SampleAfterValue": "100021",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -790,7 +842,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache. Available PDIST counters: 0,1",
         "SampleAfterValue": "100021",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -801,7 +853,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache. Available PDIST counters: 0,1",
         "SampleAfterValue": "50021",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -1029,7 +1081,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
@@ -1053,7 +1105,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -1077,7 +1129,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -1089,7 +1141,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
@@ -1113,7 +1165,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -1137,7 +1189,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -1161,7 +1213,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -1185,7 +1237,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -1209,7 +1261,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -1233,7 +1285,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/arrowlake/frontend.json
index 56cf1ec63200..db2ef84ca041 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/frontend.json
@@ -81,7 +81,7 @@
         "EventName": "FRONTEND_RETIRED.ANY_ANT",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x9",
-        "PublicDescription": "Always Not Taken (ANT) conditional retired b=
ranches (no BTB entry and not mispredicted) Available PDIST counters: 0",
+        "PublicDescription": "Always Not Taken (ANT) conditional retired b=
ranches (no BTB entry and not mispredicted) Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -93,7 +93,7 @@
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x1",
-        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss. Availa=
ble PDIST counters: 0",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss. Availa=
ble PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -179,7 +179,7 @@
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x11",
-        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss. Available PDIST counters: 0",
+        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -218,7 +218,7 @@
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x14",
-        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -239,7 +239,7 @@
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x12",
-        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -251,7 +251,7 @@
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x13",
-        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -263,7 +263,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x608006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -275,7 +275,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x601006",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -287,7 +287,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600206",
-        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -299,7 +299,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x610006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -311,7 +311,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x100206",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -323,7 +323,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x602006",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -335,7 +335,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600406",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall. Available PDIST count=
ers: 0",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall. Available PDIST count=
ers: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -347,7 +347,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x620006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -359,7 +359,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x604006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall. Available PDIST coun=
ters: 0",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall. Available PDIST coun=
ters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -371,7 +371,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600806",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -383,7 +383,7 @@
         "EventName": "FRONTEND_RETIRED.MISP_ANT",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x9",
-        "PublicDescription": "ANT retired branches that got just mispredic=
ted Available PDIST counters: 0",
+        "PublicDescription": "ANT retired branches that got just mispredic=
ted Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -395,7 +395,7 @@
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
-        "PublicDescription": "Counts flows delivered by the Microcode Sequ=
encer Available PDIST counters: 0",
+        "PublicDescription": "Counts flows delivered by the Microcode Sequ=
encer Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -443,7 +443,7 @@
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x15",
-        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss. Available PDIST counters: 0",
+        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -455,7 +455,7 @@
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x17",
-        "PublicDescription": "Number retired branch instructions that caus=
ed the front-end to be resteered when it finds the instruction in a fetch l=
ine. This is called Unknown Branch which occurs for the first time a branch=
 instruction is fetched or when the branch is not tracked by the BPU (Branc=
h Prediction Unit) anymore. Available PDIST counters: 0",
+        "PublicDescription": "Number retired branch instructions that caus=
ed the front-end to be resteered when it finds the instruction in a fetch l=
ine. This is called Unknown Branch which occurs for the first time a branch=
 instruction is fetched or when the branch is not tracked by the BPU (Branc=
h Prediction Unit) anymore. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/arrowlake/memory.json
index fb8d4ac69bda..1e6360347c0f 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/memory.json
@@ -163,7 +163,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency. Available PDIST count=
ers: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency.",
         "SampleAfterValue": "53",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -176,7 +176,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "1009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -189,7 +189,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -202,7 +202,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x800",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency. Available PDIST count=
ers: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency.",
         "SampleAfterValue": "23",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -215,7 +215,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "503",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -228,7 +228,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -241,7 +241,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -254,7 +254,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "101",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -267,7 +267,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "2003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -280,7 +280,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -291,7 +291,7 @@
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
-        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8 Availab=
le PDIST counters: 0",
+        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8 Availab=
le PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/arrowlake/pipeline.json
index 18a22368b99b..0651e2c4561e 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
@@ -74,13 +74,14 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts all branch instructions retired. Avai=
lable PDIST counters: 0",
+        "PublicDescription": "Counts all branch instructions retired. Avai=
lable PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "ARL010, ARL011",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
@@ -101,7 +102,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PublicDescription": "Counts conditional branch instructions retir=
ed. Available PDIST counters: 0",
+        "PublicDescription": "Counts conditional branch instructions retir=
ed. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x111",
         "Unit": "cpu_core"
@@ -109,6 +110,7 @@
     {
         "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "ARL011",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
         "SampleAfterValue": "200003",
@@ -120,7 +122,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
-        "PublicDescription": "Counts not taken branch instructions retired=
. Available PDIST counters: 0",
+        "PublicDescription": "Counts not taken branch instructions retired=
. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -139,7 +141,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PublicDescription": "Counts taken conditional branch instructions=
 retired. Available PDIST counters: 0",
+        "PublicDescription": "Counts taken conditional branch instructions=
 retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x101",
         "Unit": "cpu_core"
@@ -158,7 +160,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN_BWD",
-        "PublicDescription": "Counts taken backward conditional branch ins=
tructions retired. Available PDIST counters: 0",
+        "PublicDescription": "Counts taken backward conditional branch ins=
tructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -168,7 +170,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
-        "PublicDescription": "Counts taken forward conditional branch inst=
ructions retired. Available PDIST counters: 0",
+        "PublicDescription": "Counts taken forward conditional branch inst=
ructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x102",
         "Unit": "cpu_core"
@@ -187,7 +189,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PublicDescription": "Counts far branch instructions retired. Avai=
lable PDIST counters: 0",
+        "PublicDescription": "Counts far branch instructions retired. Avai=
lable PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -195,6 +197,7 @@
     {
         "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "ARL011",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "SampleAfterValue": "200003",
@@ -215,7 +218,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch. Available PDIST co=
unters: 0",
+        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch. Available PDIST co=
unters: 0,1",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -223,6 +226,7 @@
     {
         "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "ARL011",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
         "SampleAfterValue": "200003",
@@ -241,6 +245,7 @@
     {
         "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "ARL011",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
         "SampleAfterValue": "200003",
@@ -270,7 +275,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PublicDescription": "Counts both direct and indirect near call in=
structions retired. Available PDIST counters: 0",
+        "PublicDescription": "Counts both direct and indirect near call in=
structions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -278,6 +283,7 @@
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "ARL010, ARL011",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "SampleAfterValue": "200003",
@@ -298,7 +304,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PublicDescription": "Counts return instructions retired. Availabl=
e PDIST counters: 0",
+        "PublicDescription": "Counts return instructions retired. Availabl=
e PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -317,7 +323,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Counts taken branch instructions retired. Av=
ailable PDIST counters: 0",
+        "PublicDescription": "Counts taken branch instructions retired. Av=
ailable PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -325,6 +331,7 @@
     {
         "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "ARL011",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "SampleAfterValue": "200003",
@@ -372,7 +379,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path. Available PDIST counters: 0",
+        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
@@ -390,7 +397,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_COST",
-        "PublicDescription": "All mispredicted branch instructions retired=
. This precise event may be used to get the misprediction cost via the Reti=
re_Latency field of PEBS. It fires on the instruction that immediately foll=
ows the mispredicted branch. Available PDIST counters: 0",
+        "PublicDescription": "All mispredicted branch instructions retired=
. This precise event may be used to get the misprediction cost via the Reti=
re_Latency field of PEBS. It fires on the instruction that immediately foll=
ows the mispredicted branch. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x44",
         "Unit": "cpu_core"
@@ -409,7 +416,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired. Available PDIST counters: 0",
+        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x111",
         "Unit": "cpu_core"
@@ -428,7 +435,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_COST",
-        "PublicDescription": "Mispredicted conditional branch instructions=
 retired. This precise event may be used to get the misprediction cost via =
the Retire_Latency field of PEBS. It fires on the instruction that immediat=
ely follows the mispredicted branch. Available PDIST counters: 0",
+        "PublicDescription": "Mispredicted conditional branch instructions=
 retired. This precise event may be used to get the misprediction cost via =
the Retire_Latency field of PEBS. It fires on the instruction that immediat=
ely follows the mispredicted branch. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x151",
         "Unit": "cpu_core"
@@ -438,7 +445,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
-        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken. Available PDIST counters: 0",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -448,7 +455,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN_COST",
-        "PublicDescription": "Mispredicted non-taken conditional branch in=
structions retired. This precise event may be used to get the misprediction=
 cost via the Retire_Latency field of PEBS. It fires on the instruction tha=
t immediately follows the mispredicted branch. Available PDIST counters: 0"=
,
+        "PublicDescription": "Mispredicted non-taken conditional branch in=
structions retired. This precise event may be used to get the misprediction=
 cost via the Retire_Latency field of PEBS. It fires on the instruction tha=
t immediately follows the mispredicted branch. Available PDIST counters: 0,=
1",
         "SampleAfterValue": "400009",
         "UMask": "0x50",
         "Unit": "cpu_core"
@@ -467,7 +474,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired. Available PDIST counters: 0",
+        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x101",
         "Unit": "cpu_core"
@@ -486,7 +493,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD",
-        "PublicDescription": "Counts taken backward conditional mispredict=
ed branch instructions retired. Available PDIST counters: 0",
+        "PublicDescription": "Counts taken backward conditional mispredict=
ed branch instructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -496,7 +503,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD_COST",
-        "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken backward. This precise event may be used to get =
the misprediction cost via the Retire_Latency field of PEBS. It fires on th=
e instruction that immediately follows the mispredicted branch. Available P=
DIST counters: 0",
+        "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken backward. This precise event may be used to get =
the misprediction cost via the Retire_Latency field of PEBS. It fires on th=
e instruction that immediately follows the mispredicted branch. Available P=
DIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x8001",
         "Unit": "cpu_core"
@@ -506,7 +513,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_COST",
-        "PublicDescription": "Mispredicted taken conditional branch instru=
ctions retired. This precise event may be used to get the misprediction cos=
t via the Retire_Latency field of PEBS. It fires on the instruction that im=
mediately follows the mispredicted branch. Available PDIST counters: 0",
+        "PublicDescription": "Mispredicted taken conditional branch instru=
ctions retired. This precise event may be used to get the misprediction cos=
t via the Retire_Latency field of PEBS. It fires on the instruction that im=
mediately follows the mispredicted branch. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x141",
         "Unit": "cpu_core"
@@ -516,7 +523,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD",
-        "PublicDescription": "Counts taken forward conditional mispredicte=
d branch instructions retired. Available PDIST counters: 0",
+        "PublicDescription": "Counts taken forward conditional mispredicte=
d branch instructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
@@ -525,7 +532,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD_COST",
-        "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken forward. This precise event may be used to get t=
he misprediction cost via the Retire_Latency field of PEBS. It fires on the=
 instruction that immediately follows the mispredicted branch. Available PD=
IST counters: 0",
+        "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken forward. This precise event may be used to get t=
he misprediction cost via the Retire_Latency field of PEBS. It fires on the=
 instruction that immediately follows the mispredicted branch. Available PD=
IST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x8002",
         "Unit": "cpu_core"
@@ -544,7 +551,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch. Ava=
ilable PDIST counters: 0",
+        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch. Ava=
ilable PDIST counters: 0,1",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
         "Unit": "cpu_core"
@@ -572,7 +579,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect. Avail=
able PDIST counters: 0",
+        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect. Avail=
able PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -591,7 +598,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL_COST",
-        "PublicDescription": "Mispredicted indirect CALL retired. This pre=
cise event may be used to get the misprediction cost via the Retire_Latency=
 field of PEBS. It fires on the instruction that immediately follows the mi=
spredicted branch. Available PDIST counters: 0",
+        "PublicDescription": "Mispredicted indirect CALL retired. This pre=
cise event may be used to get the misprediction cost via the Retire_Latency=
 field of PEBS. It fires on the instruction that immediately follows the mi=
spredicted branch. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x42",
         "Unit": "cpu_core"
@@ -601,7 +608,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_COST",
-        "PublicDescription": "Mispredicted near indirect branch instructio=
ns retired (excluding returns). This precise event may be used to get the m=
isprediction cost via the Retire_Latency field of PEBS. It fires on the ins=
truction that immediately follows the mispredicted branch. Available PDIST =
counters: 0",
+        "PublicDescription": "Mispredicted near indirect branch instructio=
ns retired (excluding returns). This precise event may be used to get the m=
isprediction cost via the Retire_Latency field of PEBS. It fires on the ins=
truction that immediately follows the mispredicted branch. Available PDIST =
counters: 0,1",
         "SampleAfterValue": "100003",
         "UMask": "0xc0",
         "Unit": "cpu_core"
@@ -620,7 +627,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken. Available PDIST counters: 0",
+        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
@@ -639,7 +646,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN_COST",
-        "PublicDescription": "Mispredicted taken near branch instructions =
retired. This precise event may be used to get the misprediction cost via t=
he Retire_Latency field of PEBS. It fires on the instruction that immediate=
ly follows the mispredicted branch. Available PDIST counters: 0",
+        "PublicDescription": "Mispredicted taken near branch instructions =
retired. This precise event may be used to get the misprediction cost via t=
he Retire_Latency field of PEBS. It fires on the instruction that immediate=
ly follows the mispredicted branch. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "UMask": "0x60",
         "Unit": "cpu_core"
@@ -649,7 +656,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired. Available PDIST counters: 0",
+        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -677,7 +684,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET_COST",
-        "PublicDescription": "Mispredicted ret instructions retired. This =
precise event may be used to get the misprediction cost via the Retire_Late=
ncy field of PEBS. It fires on the instruction that immediately follows the=
 mispredicted branch. Available PDIST counters: 0",
+        "PublicDescription": "Mispredicted ret instructions retired. This =
precise event may be used to get the misprediction cost via the Retire_Late=
ncy field of PEBS. It fires on the instruction that immediately follows the=
 mispredicted branch. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x48",
         "Unit": "cpu_core"
@@ -1046,7 +1053,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
-        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter. A=
vailable PDIST counters: 0",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter. A=
vailable PDIST counters: 0,1",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
     },
@@ -1063,7 +1070,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.BR_FUSED",
-        "PublicDescription": "retired macro-fused uops when there is a bra=
nch in the macro-fused pair (the two instructions that got macro-fused coun=
t once in this pmon) Available PDIST counters: 0",
+        "PublicDescription": "retired macro-fused uops when there is a bra=
nch in the macro-fused pair (the two instructions that got macro-fused coun=
t once in this pmon) Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -1073,7 +1080,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
-        "PublicDescription": "INST_RETIRED.MACRO_FUSED Available PDIST cou=
nters: 0",
+        "PublicDescription": "INST_RETIRED.MACRO_FUSED Available PDIST cou=
nters: 0,1",
         "SampleAfterValue": "2000003",
         "UMask": "0x30",
         "Unit": "cpu_core"
@@ -1083,7 +1090,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions Available PDIST counters: 0",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions Available PDIST counters: 0,1",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
@@ -1102,7 +1109,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
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
rations is implementation-dependent. Available PDIST counters: 0,1",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1348,6 +1355,15 @@
         "UMask": "0x88",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of times a load got early b=
locked due to preceding store operation with unknown address or unknown dat=
a. Excluding in-line (immediate) wakeups",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_EARLY",
+        "SampleAfterValue": "100003",
+        "UMask": "0xa1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of occurrences a retired lo=
ad gets blocked because its address partially overlaps with an older store =
(size mismatch) - unknown_sta/bad_forward",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1563,7 +1579,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "LBR record is inserted Available PDIST count=
ers: 0",
+        "PublicDescription": "LBR record is inserted Available PDIST count=
ers: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1929,7 +1945,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of retiremen=
t slots not consumed due to front end stalls.",
-        "Counter": "37",
+        "Counter": "Fixed counter 5",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
@@ -2126,7 +2142,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.",
-        "Counter": "38",
+        "Counter": "Fixed counter 6",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x7",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index d0a17905c74e..12017f568606 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.33,alderlake,core
 GenuineIntel-6-BE,v1.33,alderlaken,core
-GenuineIntel-6-C[56],v1.09,arrowlake,core
+GenuineIntel-6-C[56],v1.12,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
--=20
2.50.0.727.gbf7dc18ff4-goog

