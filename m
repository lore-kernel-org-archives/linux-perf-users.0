Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF037C77B61
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 13:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjDMNay (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjDMNan (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 09:30:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFCAAD0A
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:30:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186-20020a2510c3000000b00b880000325bso32109043ybq.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681392619; x=1683984619;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTPnQm9bXBOZrjOsPaeX+PW/pu2n7sFV4FVI7qhmzso=;
        b=jkUnltS4TdxLAyH9uRVx3eXFDVrq59dAdNcHEfdE8gUYB5zkxH3RgPJZ/o8rZ1/v/R
         pUSD+Cp6N4gZ17/mmvp3JFtr8Xbr0LvLG2HDEIykXhMdR+taFaUMdY3fbelb6wYSna4W
         GAj6aHa84Kwf7h11s9esyeEitijOsCBkeooQZkgdkfUr9sb+iVLNpy8xx5WGn8eRd0Ny
         NYFNCS19wg2QMTBr7E1JHOYBPFKB2d1rlW4RcincG2nrNpP+IRlyK9zcKf47ZRom5zQI
         O7YEk13TJgSAQtAL2r7BQE2qnnJ552TiDLCVm+snW30z0tCLNkiC5ZmQXyEPtWmcbrL9
         mOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392619; x=1683984619;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xTPnQm9bXBOZrjOsPaeX+PW/pu2n7sFV4FVI7qhmzso=;
        b=RL2J2ZwTpXnDImKY1sLBWhBrycDSozzoxlDGE5gKT/s/gR2CCd3Pdj3h96r7GRQlZG
         c6OuydmiXyfME3zsmRQx2JFiTCZMPPm3hsfhSmRZJE3HISqOh0oSh/GKZKSWaJA7AH/1
         hj7/aqJONdarprUQv5eSKrMdCjFdDi4GiPJlULGXLdkQOHP3oQ1FcxeTlYi7UmL3b7AX
         Fe2/p7hCOyY3yUfg07YIhqPKxfrDFPLVAGCrqVXXXdjc5wvyY0cSsoa87OexIh+RBdxD
         v1/zDLZDd5l8pIOOOl/+VCLxnWVvh23XMj/wPNg8p5l0disOnoa9mNWVg9aYbW3u0PBm
         wKQA==
X-Gm-Message-State: AAQBX9cb9R+dGbe6PDSD46lf0+YyuXcCZUYl7xlSNEmb2WTAV/oSrcuI
        zP2ZlTK03ICAsjHJUe17IE6Gf/90e07n
X-Google-Smtp-Source: AKy350a81ruBZT7OlZtvDutS4uUtAVCE3Gp5WylbvG4nG7RdUQzUnpKPSYqkzn6VjWFlyK3mBaXsONDhUWwh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a25:cc07:0:b0:b8b:fe5f:2eaa with SMTP id
 l7-20020a25cc07000000b00b8bfe5f2eaamr1152271ybf.2.1681392619121; Thu, 13 Apr
 2023 06:30:19 -0700 (PDT)
Date:   Thu, 13 Apr 2023 06:29:30 -0700
In-Reply-To: <20230413132949.3487664-1-irogers@google.com>
Message-Id: <20230413132949.3487664-3-irogers@google.com>
Mime-Version: 1.0
References: <20230413132949.3487664-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v3 02/21] perf vendor events intel: Add grandridge
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add v1.00 from:
https://github.com/intel/perfmon/pull/69

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/grandridge/cache.json | 155 ++++++++++++++++++
 .../arch/x86/grandridge/frontend.json         |  16 ++
 .../arch/x86/grandridge/memory.json           |  20 +++
 .../pmu-events/arch/x86/grandridge/other.json |  20 +++
 .../arch/x86/grandridge/pipeline.json         |  96 +++++++++++
 .../arch/x86/grandridge/virtual-memory.json   |  24 +++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
 7 files changed, 332 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/virtual-memor=
y.json

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/cache.json b/tools/p=
erf/pmu-events/arch/x86/grandridge/cache.json
new file mode 100644
index 000000000000..7f0dc65a55d2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/grandridge/cache.json
@@ -0,0 +1,155 @@
+[
+    {
+        "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 =
cache. Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 c=
ache. Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4f"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x81"
+    },
+    {
+        "BriefDescription": "Counts the number of store ops retired.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x80",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x10",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x100",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x20",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x4",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x200",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x40",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x8",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/frontend.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/frontend.json
new file mode 100644
index 000000000000..be8f1c7e195c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/grandridge/frontend.json
@@ -0,0 +1,16 @@
+[
+    {
+        "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump.",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.ACCESSES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump and the instruction cache registers bytes are not present=
. -",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.MISSES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/memory.json b/tools/=
perf/pmu-events/arch/x86/grandridge/memory.json
new file mode 100644
index 000000000000..79d8af45100c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/grandridge/memory.json
@@ -0,0 +1,20 @@
+[
+    {
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/other.json b/tools/p=
erf/pmu-events/arch/x86/grandridge/other.json
new file mode 100644
index 000000000000..2414f6ff53b0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/grandridge/other.json
@@ -0,0 +1,20 @@
+[
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/pipeline.json
new file mode 100644
index 000000000000..41212957ef21
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
@@ -0,0 +1,96 @@
+[
+    {
+        "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "EventName": "CPU_CLK_UNHALTED.CORE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency.",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
+        "EventName": "INST_RETIRED.ANY",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PEBS": "1",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear.",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear."=
,
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALL",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ALL",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL",
+        "EventCode": "0x72",
+        "EventName": "TOPDOWN_RETIRING.ALL",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json
new file mode 100644
index 000000000000..bd5f2b634c98
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json
@@ -0,0 +1,24 @@
+[
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 1G page.",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 1G page.",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 437eeecfaf64..c2b83cbae225 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,6 +9,7 @@ GenuineIntel-6-55-[56789ABCDEF],v1.17,cascadelakex,core
 GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
+GenuineIntel-6-B6,v1.00,grandridge,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v33,haswell,core
 GenuineIntel-6-3F,v27,haswellx,core
--=20
2.40.0.577.gac1e443424-goog

