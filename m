Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C48C77B75
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Apr 2023 00:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDSAym (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Apr 2023 20:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDSAyl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Apr 2023 20:54:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60F93E2
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Apr 2023 17:54:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54fba72c1adso149876897b3.18
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Apr 2023 17:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681865679; x=1684457679;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y/rdUpcxYH42Bljt97/HiNvPLvrpvyHQn3krC7u6Gk=;
        b=TxCG3nN4FnxF/DV3lQNKWwpjynmYwoq/zvuoLzId6VXXRrkexuF/R8c2D4cw0Hw73a
         /6F7Dc4P8ObLD5h99lInRSk5mW1iGXJfXzJhioHdOvwcWOf3YF3V4DrZCB++6Bx3WWP7
         izSFx0ChHL90GcuRetqP8N5Ha7oreAxnKov0Ou0lsl+XcKqcCrDBN4mO/nO8aElvF9Wr
         wzbPIZePOc06HHRaplghkgaDUzke32fxb8rJg1FRkvRnRJaIcEDFkez4EqoX/Nm6fJvU
         DVADGS/Zw60YgJ8Fb+sBhncR/O5H7ALgkEE63L1KB58xcvzn6qSZgFq9i65dT8cE30H1
         cjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681865679; x=1684457679;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y/rdUpcxYH42Bljt97/HiNvPLvrpvyHQn3krC7u6Gk=;
        b=fPQ+uKxuPbHywCqLQxiwXNPJDajcdT0P8Tr6ccAN0OKJxS6IJSNP8LXJ+fFQykxiLF
         l5kgXI2XJOMEiRRJpt8yKRDak+11ifpqbYg51dmLn8R+ElpXFUInDj01CrY7ZpTKF45p
         LYhlkmmkW0VplywXGj8PL4HCIG4HAASKNRk4yQN8wQ0pUA83w8xzULUq75G23pG4wHS6
         /kmSvKXWKhp2gIc4cQFg4W7etUsBjPuLgwd5mmy1GnbzYfEyvtF9uOvT3t2bJn60cC+G
         sDVT/DndjqzS6kqC5nmmUjmqKvbdt3z2jC1QIQYxvqUOX5hfcc8VxEjhs8LDdCZW/ss4
         opJw==
X-Gm-Message-State: AAQBX9dWv/rtEUZEVuEVzTPeiNYBTkIQBnKaupttxS4L7WHUBE5Za1Cv
        TXd6TkvGAiXDTMskY7/F4MabjFa15lhX
X-Google-Smtp-Source: AKy350YhE0xb/nPWSauNDyxmtUh2yIhsnQ8MWvZ7hqHv4EE+DLsoXqvZ9pocI3TnfcxhoQodUcLGyicdhkxe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f6da:3a8f:84ce:3dd3])
 (user=irogers job=sendgmr) by 2002:a05:6902:70e:b0:a27:3ecc:ffe7 with SMTP id
 k14-20020a056902070e00b00a273eccffe7mr469036ybt.3.1681865679093; Tue, 18 Apr
 2023 17:54:39 -0700 (PDT)
Date:   Tue, 18 Apr 2023 17:54:18 -0700
Message-Id: <20230419005423.343862-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Subject: [PATCH v2 1/6] perf vendor events intel: Add alderlake metric constraints
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Previously these constraints were disabled as they contained topdown
events. Since:
https://lore.kernel.org/all/20230312021543.3060328-9-irogers@google.com/
the topdown events are correctly grouped even if no group exists.

This change was created by PR:
https://github.com/intel/perfmon/pull/71

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/alderlake/adl-metrics.json    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 75d80e70e5cd..d09361dacd4f 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -1057,6 +1057,7 @@
     },
     {
         "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
@@ -1181,6 +1182,7 @@
     },
     {
         "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * tma_m=
ispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icache_=
misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_slots / B=
R_MISP_RETIRED.ALL_BRANCHES",
         "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_branch_misprediction_cost",
@@ -1233,6 +1235,7 @@
     },
     {
         "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_smt_2t_utiliz=
ation > 0.5 else 0)",
         "MetricGroup": "Cor;SMT",
         "MetricName": "tma_info_core_bound_likely",
@@ -1293,6 +1296,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_dsb_misses",
@@ -1386,6 +1390,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency * tma=
_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_icach=
e_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_big_cod=
e",
         "MetricGroup": "Fed;FetchBW;Frontend",
         "MetricName": "tma_info_instruction_fetch_bw",
@@ -1805,6 +1810,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tma_me=
mory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_fb=
_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_stor=
e_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tm=
a_store_bound) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharing + tm=
a_split_stores + tma_store_latency + tma_streaming_stores)))",
         "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_info_memory_data_tlbs",
@@ -1814,6 +1820,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Latency related=
 bottlenecks (external memory and off-core caches)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (=
tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound / (=
tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bou=
nd) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing + tm=
a_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
         "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_info_memory_latency",
@@ -1823,6 +1830,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
         "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_mispredictions",
@@ -1855,6 +1863,7 @@
     },
     {
         "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_retiring * tma_info_slots / cpu_core@UOPS_RETIR=
ED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_retire",
@@ -2127,6 +2136,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma_r=
etiring * tma_info_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_memory_operations",
@@ -2206,6 +2216,7 @@
     },
     {
         "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches + tma_nop_instructions))",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_other_light_ops",
--=20
2.40.0.634.g4ca3ef3211-goog

