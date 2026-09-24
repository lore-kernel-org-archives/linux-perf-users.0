Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5F4AC17D
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269490; cv=none; b=TC1zCWsgC/xKZevOFCwc0w4aCWrSdA/n9rHuB2f0B7f6mxKOEMwUHGyJi9IP+KwGzuaX12Y04kAKVkae7TBItYBIv02SpoZeuyNWSTbcbnUHsZI9+zCtRxr30XiIm/fBx91FBgyK/sBMsbkhOazMD/jq3GYjsQ2iFqCwNqAlPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269490; c=relaxed/simple;
	bh=/D8FIzz+7Aog+rIWnbUrIGzXT1SDtcHZ3uCYsIvcNB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ow73BLi0Rm6VrbFiPRvZElo1JYrZkg8iF5VgaKbld0lggNMW8ldSKLsHHN1zQa0YqkAPWj5AJH/JYWYnfjY0V191JLd1S3ibiihxMvYxeAh+R+cxNt/aTUN6OpEnKQ9Ml3mZeHxCleuM6QpaS/XAisNgDH5Eu485hlP9STUy33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vA8NNBQ3; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA8NNBQ3"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-143826c4a13so14252c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269483; x=1790874283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=66Zo27EHVUYRkXdHw33lPR2TB1VYBumrPbK1SfK2Mx8=;
        b=vA8NNBQ3Tn34TFOSdqfx9AQ9WVzsucFvE+E4wPeoQl7Rz7BqVk6QZcE9StlnUekY+c
         bduqEswy5Wge4V8PydiMi3TK7qqwl3IStaVyBnZ7LhmCS+XzfZXarkwoe974aS+nll1B
         5e9AR00p6k+BQfo73lM7enJxUnD8Wy4QoJT0SoQCnAZ0XUM3lXDbfwwlHqONLKxxv/7w
         0z8xwI5MHz2PIbAaKoxlgy869495hjMJzKpZ70YGXxGzXe6m8MZKRuvI2eZTmLMthDWo
         NKCtdDZJ6+l7ITuAHqckGmBaw06DpNwOAHiBLRK7nsMMCloCZwD6sN7Ixa8emlfHcQXT
         e3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269483; x=1790874283;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=66Zo27EHVUYRkXdHw33lPR2TB1VYBumrPbK1SfK2Mx8=;
        b=Zi1EfD6sQgsJmEyXTRDihulroLsxa4bAHwJF0y3I6e1dU8IZXFR6IZoNI01DtwSmh5
         qIURq3AT4wdnXA2ZLHTLJXOk2O/sqm9qCFFepkgne3Jn0uXDFGwSgHbcL+GJkq6vhnw0
         eWQBInJAzmB73DNz6Pt6TbpG0jG6zJOwrwRjtxXakiYqoLQ3R+XXDd6SZvt3ev6pladt
         GGxUEDhjldJ6a+gg0UUYxWewBAIioRGVuupm0doYFon+tyJzHqs4yPPDXDywuRSJDNXw
         EID/b0Ih3ofQakXjC45/euL0yJDaAix+E75hunPqzDhgi07qBbPVcosLFN6kkeqGhkZI
         fANg==
X-Forwarded-Encrypted: i=1; AKwUvBzQ23s+KjhYdLF75TgXdOTLSAubvPQ536gQNEd1sUDwF9/C0jG7TOr8oryF3CW3MWxdNA+dH8iYaET+zrpCGnWf@vger.kernel.org
X-Gm-Message-State: AFuF++mhwQ5u3J9D/Pc9HfATtMn2vV2Vo8FbnfHggqJ9coFmCfjj35Zc
	c6UORHJ828yiAbqjStaB/hnt5rQTCMph1TyrQo/yN05gJnXMTt2/JGAeCykkBhkHnvzsILDCKXO
	733VNgd1awg==
X-Received: from dlbox8.prod.google.com ([2002:a05:7022:1208:b0:144:cc16:e125])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:454b:10b0:141:aa71:6e02
 with SMTP id a92af1059eb24-14503f06512mr2211362c88.2.1790269482098; Thu, 24
 Sep 2026 10:04:42 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:39 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-20-irogers@google.com>
Subject: [PATCH v2 19/26] perf vendor events intel: Update sapphirerapids
 events from 1.39 to 1.40
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

  https://github.com/intel/perfmon/commit/2ba60f607169b97dcfa0d28f7e3a61328=
627cf0c

Fix umask encodings when there is a UMaskExt.

Fixes: 54f5de6f2998 ("perf vendor events intel: Update sapphirerapids to v1=
.12")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/sapphirerapids/cache.json        |  2 +-
 .../arch/x86/sapphirerapids/memory.json       | 35 +++++++
 .../arch/x86/sapphirerapids/metricgroups.json |  2 +-
 .../arch/x86/sapphirerapids/other.json        |  9 ++
 .../arch/x86/sapphirerapids/pipeline.json     | 10 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  | 93 +++++++++----------
 .../arch/x86/sapphirerapids/uncore-cache.json | 42 +++++++++
 .../sapphirerapids/uncore-interconnect.json   | 12 +++
 .../arch/x86/sapphirerapids/uncore-io.json    | 54 ++++++++++-
 .../x86/sapphirerapids/uncore-memory.json     | 10 ++
 11 files changed, 213 insertions(+), 58 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index a04111fc8848..19166dacdcfb 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -30,7 +30,7 @@ GenuineIntel-18-[13],v1.04,novalake,core
 GenuineIntel-6-(CC|D5|E5),v1.08,pantherlake,core
 GenuineIntel-6-A7,v1.06,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
-GenuineIntel-6-8F,v1.39,sapphirerapids,core
+GenuineIntel-6-8F,v1.40,sapphirerapids,core
 GenuineIntel-6-AF,v1.18,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index 4c096b5e6766..7e49de97f084 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -1275,7 +1275,7 @@
         "EventCode": "0x2c",
         "EventName": "SQ_MISC.BUS_LOCK",
         "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
-        "SampleAfterValue": "100003",
+        "SampleAfterValue": "503",
         "UMask": "0x10"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json b/to=
ols/perf/pmu-events/arch/x86/sapphirerapids/memory.json
index 5e6c1f05c981..93effd1d69a2 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
@@ -55,6 +55,17 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than any number of cycles."=
,
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY",
+        "MSRIndex": "0x3F6",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than any number of cycles.=
 Reported latency may be longer than just the memory latency.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
         "Counter": "1,2,3,4,5,6,7",
@@ -91,6 +102,30 @@
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2 cycles. Reported la=
tency may be longer than just the memory latency.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2048 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
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
         "Counter": "1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.json
index 9129fb7b7ce4..b5f601991e9d 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.json
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
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/other.json
index 21f49f609ed4..4ded9b0499c3 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
@@ -32,6 +32,15 @@
         "SampleAfterValue": "203",
         "UMask": "0x1"
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
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index 1fa7957956df..035c01540cf7 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -200,11 +200,11 @@
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
tired. Available PDIST counters: 0",
+        "PublicDescription": "This event counts the number of mispredicted=
 ret instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
@@ -502,7 +502,7 @@
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
st strings, this event may vary from run to run and not match the architect=
ural number of iterations (specified by RCX).",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -723,11 +723,11 @@
         "UMask": "0x20"
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
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json=
 b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index b6a28227a58a..cdc7b00dafdb 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -463,15 +463,15 @@
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
y)) + tma_memory_bound * (tma_l3_bound / (tma_cxl_mem_bound + tma_dram_boun=
d + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l=
3_hit_latency / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_lat=
ency + tma_sq_full)) + tma_memory_bound * tma_l2_bound / (tma_cxl_mem_bound=
 + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_=
bound) + tma_memory_bound * (tma_l1_bound / (tma_cxl_mem_bound + tma_dram_b=
ound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tm=
a_l1_latency_dependency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dep=
endency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_me=
mory_bound * (tma_l1_bound / (tma_cxl_mem_bound + tma_dram_bound + tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_lock_latency =
/ (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_laten=
cy + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_l1_bou=
nd / (tma_cxl_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tm=
a_l3_bound + tma_store_bound)) * (tma_split_loads / (tma_dtlb_load + tma_fb=
_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tm=
a_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_cxl_mem_boun=
d + tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store=
_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sharing + tma_sp=
lit_stores + tma_store_latency + tma_streaming_stores)) + tma_memory_bound =
* (tma_store_bound / (tma_cxl_mem_bound + tma_dram_bound + tma_l1_bound + t=
ma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_store_latency / (tma_=
dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency + tma=
_streaming_stores)))",
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
@@ -494,7 +494,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_cxl_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bou=
nd + tma_l3_bound + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, =
tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_latency =
+ tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bou=
nd / (tma_cxl_mem_bound + tma_dram_bound + tma_l1_bound + tma_l2_bound + tm=
a_l3_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma_fa=
lse_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores))=
)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_l3_miss_bound + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_boun=
d, tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_laten=
cy + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_store_=
bound / (tma_cxl_mem_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + t=
ma_l3_miss_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + =
tma_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_st=
ores)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -502,7 +502,7 @@
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
@@ -663,13 +663,13 @@
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
@@ -690,15 +690,6 @@
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
@@ -750,7 +741,7 @@
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
@@ -1043,7 +1034,7 @@
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
@@ -1161,7 +1152,7 @@
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
@@ -1230,6 +1221,14 @@
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
@@ -1471,7 +1470,7 @@
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
@@ -1551,7 +1550,7 @@
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
@@ -1601,13 +1600,6 @@
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
@@ -1667,12 +1659,6 @@
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
@@ -1828,6 +1814,15 @@
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
@@ -1902,14 +1897,14 @@
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
@@ -1932,24 +1927,24 @@
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
@@ -2013,7 +2008,7 @@
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
@@ -2030,7 +2025,7 @@
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
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_bottleneck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_mac=
hine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_o=
peration",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_bottleneck_irregular_overhead, tma_clears_resteers, tma_info_inst_mix_vec=
tormixpki, tma_l1_bound, tma_machine_clears, tma_microcode_sequencer, tma_m=
ixing_vectors, tma_serializing_operation",
         "ScaleUnit": "100%"
     },
     {
@@ -2166,7 +2161,7 @@
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
@@ -2175,7 +2170,7 @@
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
@@ -2219,7 +2214,7 @@
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
@@ -2241,7 +2236,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
index 59f6fd2c7a8f..2620ae2322a2 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
@@ -581,6 +581,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : All Requests : Counts the nu=
mber of times the LLC was accessed - this includes code, data, prefetches a=
nd hints coming from L2.  This has numerous filters available.  Note the no=
n-standard filtering equation.  This event will count requests that lookup =
the cache multiple times with multiple increments.  One must ALWAYS set uma=
sk bit 0 and select a state or states to match.  Otherwise, the event will =
count nothing. : Any local or remote transaction to the LLC, including pref=
etch.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -602,6 +603,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : CRd Requests : Counts the nu=
mber of times the LLC was accessed - this includes code, data, prefetches a=
nd hints coming from L2.  This has numerous filters available.  Note the no=
n-standard filtering equation.  This event will count requests that lookup =
the cache multiple times with multiple increments.  One must ALWAYS set uma=
sk bit 0 and select a state or states to match.  Otherwise, the event will =
count nothing. : Local or remote CRd transactions to the LLC.  This include=
s CRd prefetch.",
+        "UMask": "0x1000",
         "Unit": "CHA"
     },
     {
@@ -612,6 +614,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Local non-prefetch requests =
: Counts the number of times the LLC was accessed - this includes code, dat=
a, prefetches and hints coming from L2.  This has numerous filters availabl=
e.  Note the non-standard filtering equation.  This event will count reques=
ts that lookup the cache multiple times with multiple increments.  One must=
 ALWAYS set umask bit 0 and select a state or states to match.  Otherwise, =
the event will count nothing. : Any local transaction to the LLC, not inclu=
ding prefetch",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -644,6 +647,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Data Read Request : Counts t=
he number of times the LLC was accessed - this includes code, data, prefetc=
hes and hints coming from L2.  This has numerous filters available.  Note t=
he non-standard filtering equation.  This event will count requests that lo=
okup the cache multiple times with multiple increments.  One must ALWAYS se=
t umask bit 0 and select a state or states to match.  Otherwise, the event =
will count nothing. : Read transactions.",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -709,6 +713,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Flush : Counts the number of=
 times the LLC was accessed - this includes code, data, prefetches and hint=
s coming from L2.  This has numerous filters available.  Note the non-stand=
ard filtering equation.  This event will count requests that lookup the cac=
he multiple times with multiple increments.  One must ALWAYS set umask bit =
0 and select a state or states to match.  Otherwise, the event will count n=
othing.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -730,6 +735,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Local LLC prefetch requests =
(from LLC) : Counts the number of times the LLC was accessed - this include=
s code, data, prefetches and hints coming from L2.  This has numerous filte=
rs available.  Note the non-standard filtering equation.  This event will c=
ount requests that lookup the cache multiple times with multiple increments=
.  One must ALWAYS set umask bit 0 and select a state or states to match.  =
Otherwise, the event will count nothing. : Any local LLC prefetch to the LL=
C",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -806,6 +812,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Transactions homed locally :=
 Counts the number of times the LLC was accessed - this includes code, data=
, prefetches and hints coming from L2.  This has numerous filters available=
.  Note the non-standard filtering equation.  This event will count request=
s that lookup the cache multiple times with multiple increments.  One must =
ALWAYS set umask bit 0 and select a state or states to match.  Otherwise, t=
he event will count nothing. : Transaction whose address resides in the loc=
al MC.",
+        "UMask": "0x80000",
         "Unit": "CHA"
     },
     {
@@ -915,6 +922,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Write Requests : Counts the =
number of times the LLC was accessed - this includes code, data, prefetches=
 and hints coming from L2.  This has numerous filters available.  Note the =
non-standard filtering equation.  This event will count requests that looku=
p the cache multiple times with multiple increments.  One must ALWAYS set u=
mask bit 0 and select a state or states to match.  Otherwise, the event wil=
l count nothing. : Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cacheable and UC.",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -925,6 +933,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Remote non-snoop requests : =
Counts the number of times the LLC was accessed - this includes code, data,=
 prefetches and hints coming from L2.  This has numerous filters available.=
  Note the non-standard filtering equation.  This event will count requests=
 that lookup the cache multiple times with multiple increments.  One must A=
LWAYS set umask bit 0 and select a state or states to match.  Otherwise, th=
e event will count nothing. : Remote non-snoop transactions to the LLC.",
+        "UMask": "0x20000",
         "Unit": "CHA"
     },
     {
@@ -968,6 +977,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Transactions homed remotely =
: Counts the number of times the LLC was accessed - this includes code, dat=
a, prefetches and hints coming from L2.  This has numerous filters availabl=
e.  Note the non-standard filtering equation.  This event will count reques=
ts that lookup the cache multiple times with multiple increments.  One must=
 ALWAYS set umask bit 0 and select a state or states to match.  Otherwise, =
the event will count nothing. : Transaction whose address resides in a remo=
te MC",
+        "UMask": "0x100000",
         "Unit": "CHA"
     },
     {
@@ -1011,6 +1021,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Remote snoop requests : Coun=
ts the number of times the LLC was accessed - this includes code, data, pre=
fetches and hints coming from L2.  This has numerous filters available.  No=
te the non-standard filtering equation.  This event will count requests tha=
t lookup the cache multiple times with multiple increments.  One must ALWAY=
S set umask bit 0 and select a state or states to match.  Otherwise, the ev=
ent will count nothing. : Remote snoop transactions to the LLC.",
+        "UMask": "0x40000",
         "Unit": "CHA"
     },
     {
@@ -1043,6 +1054,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS select a state or states (in the umask=
 field) to match.  Otherwise, the event will count nothing. : Local or remo=
te RFO transactions to the LLC.  This includes RFO prefetch.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -1240,6 +1252,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Local Only : Counts the n=
umber of lines that were victimized on a fill.  This can be filtered by the=
 state that the line was in.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -1305,6 +1318,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Remote Only : Counts the =
number of lines that were victimized on a fill.  This can be filtered by th=
e state that the line was in.",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -3705,6 +3719,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DDR Access : Counts the number=
 of entries successfully inserted into the TOR that match qualifications sp=
ecified by the subevent.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -3726,6 +3741,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Hits : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -5211,6 +5227,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just ISOC : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.",
+        "UMask": "0x200000000",
         "Unit": "CHA"
     },
     {
@@ -5221,6 +5238,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Local Targets : Counts th=
e number of entries successfully inserted into the TOR that match qualifica=
tions specified by the subevent.",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -5264,6 +5282,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Match the Opcode in b[29:19] o=
f the extended umask field : Counts the number of entries successfully inse=
rted into the TOR that match qualifications specified by the subevent.",
+        "UMask": "0x20000",
         "Unit": "CHA"
     },
     {
@@ -5274,6 +5293,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Misses : Counts the numbe=
r of entries successfully inserted into the TOR that match qualifications s=
pecified by the subevent.",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -5284,6 +5304,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : MMCFG Access : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -5294,6 +5315,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : MMIO Access : Counts the numbe=
r of entries successfully inserted into the TOR that match qualifications s=
pecified by the subevent.",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -5304,6 +5326,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just NearMem : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.",
+        "UMask": "0x40000000",
         "Unit": "CHA"
     },
     {
@@ -5314,6 +5337,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just NonCoherent : Counts the =
number of entries successfully inserted into the TOR that match qualificati=
ons specified by the subevent.",
+        "UMask": "0x100000000",
         "Unit": "CHA"
     },
     {
@@ -5324,6 +5348,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just NotNearMem : Counts the n=
umber of entries successfully inserted into the TOR that match qualificatio=
ns specified by the subevent.",
+        "UMask": "0x80000000",
         "Unit": "CHA"
     },
     {
@@ -5334,6 +5359,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : PM Access : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -5344,6 +5370,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Match the PreMorphed Opcode in=
 b[29:19] of the extended umask field : Counts the number of entries succes=
sfully inserted into the TOR that match qualifications specified by the sub=
event.",
+        "UMask": "0x40000",
         "Unit": "CHA"
     },
     {
@@ -5376,6 +5403,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Remote Targets : Counts t=
he number of entries successfully inserted into the TOR that match qualific=
ations specified by the subevent.",
+        "UMask": "0x10000",
         "Unit": "CHA"
     },
     {
@@ -5452,6 +5480,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DDR Access : For each cycle,=
 this event accumulates the number of valid entries in the TOR that match q=
ualifications specified by the subevent.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -5473,6 +5502,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Hits : For each cycle, =
this event accumulates the number of valid entries in the TOR that match qu=
alifications specified by the subevent.   T",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -6936,6 +6966,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just ISOC : For each cycle, =
this event accumulates the number of valid entries in the TOR that match qu=
alifications specified by the subevent.   T",
+        "UMask": "0x200000000",
         "Unit": "CHA"
     },
     {
@@ -6946,6 +6977,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Local Targets : For eac=
h cycle, this event accumulates the number of valid entries in the TOR that=
 match qualifications specified by the subevent.   T",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -6989,6 +7021,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Match the Opcode in b[29:19]=
 of the extended umask field : For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   T",
+        "UMask": "0x20000",
         "Unit": "CHA"
     },
     {
@@ -6999,6 +7032,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Misses : For each cycle=
, this event accumulates the number of valid entries in the TOR that match =
qualifications specified by the subevent.   T",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -7009,6 +7043,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : MMCFG Access : For each cycl=
e, this event accumulates the number of valid entries in the TOR that match=
 qualifications specified by the subevent.   T",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -7019,6 +7054,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : MMIO Access : For each cycle=
, this event accumulates the number of valid entries in the TOR that match =
qualifications specified by the subevent.   T",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -7029,6 +7065,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just NearMem : For each cycl=
e, this event accumulates the number of valid entries in the TOR that match=
 qualifications specified by the subevent.   T",
+        "UMask": "0x40000000",
         "Unit": "CHA"
     },
     {
@@ -7039,6 +7076,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just NonCoherent : For each =
cycle, this event accumulates the number of valid entries in the TOR that m=
atch qualifications specified by the subevent.   T",
+        "UMask": "0x100000000",
         "Unit": "CHA"
     },
     {
@@ -7049,6 +7087,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just NotNearMem : For each c=
ycle, this event accumulates the number of valid entries in the TOR that ma=
tch qualifications specified by the subevent.   T",
+        "UMask": "0x80000000",
         "Unit": "CHA"
     },
     {
@@ -7059,6 +7098,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : PMM Access : For each cycle,=
 this event accumulates the number of valid entries in the TOR that match q=
ualifications specified by the subevent.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -7069,6 +7109,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Match the PreMorphed Opcode =
in b[29:19] of the extended umask field : For each cycle, this event accumu=
lates the number of valid entries in the TOR that match qualifications spec=
ified by the subevent.   T",
+        "UMask": "0x40000",
         "Unit": "CHA"
     },
     {
@@ -7101,6 +7142,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Remote Targets : For ea=
ch cycle, this event accumulates the number of valid entries in the TOR tha=
t match qualifications specified by the subevent.   T",
+        "UMask": "0x10000",
         "Unit": "CHA"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconn=
ect.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnec=
t.json
index 8b1ae9540066..c2f5897ad4b9 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.jso=
n
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.jso=
n
@@ -545,6 +545,7 @@
         "EventCode": "0xc0",
         "EventName": "UNC_M2M_CMS_CLOCKTICKS",
         "PerPkg": "1",
+        "UMask": "0x80000000",
         "Unit": "M2M"
     },
     {
@@ -1455,6 +1456,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0.NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0xa00",
         "Unit": "M2M"
     },
     {
@@ -1476,6 +1478,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0_FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x900",
         "Unit": "M2M"
     },
     {
@@ -1507,6 +1510,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0_NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0xa00",
         "Unit": "M2M"
     },
     {
@@ -1516,6 +1520,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0_NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0xc00",
         "Unit": "M2M"
     },
     {
@@ -1580,6 +1585,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1.NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1200",
         "Unit": "M2M"
     },
     {
@@ -1601,6 +1607,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1_FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1100",
         "Unit": "M2M"
     },
     {
@@ -1632,6 +1639,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1_NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1200",
         "Unit": "M2M"
     },
     {
@@ -1641,6 +1649,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1_NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1400",
         "Unit": "M2M"
     },
     {
@@ -1705,6 +1714,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1900",
         "Unit": "M2M"
     },
     {
@@ -1734,6 +1744,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1a00",
         "Unit": "M2M"
     },
     {
@@ -1743,6 +1754,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1c00",
         "Unit": "M2M"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json b=
/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
index 45675a1099e2..6d6da5d49786 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
@@ -653,6 +653,19 @@
         "UMask": "0x1",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to this IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) requested by the mai=
n die.  Includes all requests initiated by the main die, including reads an=
d writes. : x16 card plugged in to stack, Or x8 card plugged in to Lane 0/1=
, Or x4 card is plugged in to slot 0",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part0",
         "Counter": "2,3",
@@ -757,6 +770,19 @@
         "UMask": "0x8",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 this IIO by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) requested by the mai=
n die.  Includes all requests initiated by the main die, including reads an=
d writes. : x16 card plugged in to stack, Or x8 card plugged in to Lane 0/1=
, Or x4 card is plugged in to slot 0",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part0 by a different IIO unit",
         "Counter": "2,3",
@@ -1184,6 +1210,32 @@
         "UMask": "0x1",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO any part to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) the card requests of=
 the main die.    Includes all requests initiated by the Card, including re=
ads and writes. : x16 card plugged in to stack, Or x8 card plugged in to La=
ne 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 any IIO part to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) the card requests of=
 the main die.    Includes all requests initiated by the Card, including re=
ads and writes. : x16 card plugged in to stack, Or x8 card plugged in to La=
ne 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
         "Counter": "0,1",
@@ -1907,7 +1959,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED",
-        "Experimental": "1",
         "FCMask": "0x01",
         "PerPkg": "1",
         "PortMask": "0x00FF",
@@ -1923,6 +1974,7 @@
         "PerPkg": "1",
         "PortMask": "0x0000",
         "PublicDescription": "UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU",
+        "UMask": "0x7000000",
         "Unit": "IIO"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
index 30044177ccf8..ad32f0ccfa02 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
@@ -13,6 +13,7 @@
         "EventCode": "0xc0",
         "EventName": "UNC_M2HBM_CMS_CLOCKTICKS",
         "PerPkg": "1",
+        "UMask": "0x80000000",
         "Unit": "M2HBM"
     },
     {
@@ -926,6 +927,7 @@
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0_FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x900",
         "Unit": "M2HBM"
     },
     {
@@ -959,6 +961,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0xa00",
         "Unit": "M2HBM"
     },
     {
@@ -970,6 +973,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0xc00",
         "Unit": "M2HBM"
     },
     {
@@ -1043,6 +1047,7 @@
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1_FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1100",
         "Unit": "M2HBM"
     },
     {
@@ -1076,6 +1081,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0x1200",
         "Unit": "M2HBM"
     },
     {
@@ -1087,6 +1093,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0x1400",
         "Unit": "M2HBM"
     },
     {
@@ -1118,6 +1125,7 @@
         "EventName": "UNC_M2HBM_IMC_WRITES.FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1900",
         "Unit": "M2HBM"
     },
     {
@@ -1149,6 +1157,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0x1a00",
         "Unit": "M2HBM"
     },
     {
@@ -1160,6 +1169,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0x1c00",
         "Unit": "M2HBM"
     },
     {
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

