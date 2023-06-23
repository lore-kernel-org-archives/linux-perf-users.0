Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6BCEB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 15:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjFWPMp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 11:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjFWPLl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1074230FC
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:11:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704995f964so10395527b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533057; x=1690125057;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=850oXQZLts9z54NFDwePrz1Be1TwGAdCXoDLk79UUlM=;
        b=Iz8RzvHkUguYNbb6/l16Z0RKNUNXCLWtEp60jInbkyHpMHJnNkgRuLQfksC43hVuhr
         kM2NzEDrLE9ITKemYUWbpCBYCBd+uZPSr4amtTcvsBvz96/Awd6bXNL53Z2qG+VlgKn6
         99NrsNYQBuswsAe0NRJCXjT9lQKgSQ2ioRGi1s91JJzPpHBPRyOCuD1yV8iWhQ3H/DxG
         VI2QGK8qzXQrmsSFHyx4zVQP8J0uFC+YHwmzCmRDJe00fMQxiHIcLB4/1DmePODMPNsn
         R4wpy7RcnHcKlII6zuN/jHCq91VX2lMhOICWgxos18Cix6LIxy8HD2379Sb/SE45UE10
         SmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533057; x=1690125057;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=850oXQZLts9z54NFDwePrz1Be1TwGAdCXoDLk79UUlM=;
        b=YyUxTXdNi7OuIpEOaOcY4sCsWTbyb09YgNOpV+f2GHPlWUWnySabh4j2RjQySssq9Q
         ykYLO5Da3Z4aBDPFfpJm1VR0l6iSuSp06KQzNzWSVNa+jegtjD1ZUwn0JwRAOWwYpQ+C
         FrgcICTsQpvLGVYfScnmbItrv/oNYLy8ekCBEe5iYcDgnIXoTqBGFgs1i6vm6faJFQcI
         xcV9UEx8ANWeEkY/HeSwvGIHCnzP4BOuPHhx+7fX9C2S6Z3Z4UVNWMZq4B7lDJUS+yPs
         jE37HwrOBD9GL19nlKUXDRdGu0LvVV7mZEkpYEsA1SBpNACAO4T1zpYQB67H5YGmgIOe
         vtqQ==
X-Gm-Message-State: AC+VfDwW5JJth0FjwwHf+fs4wCMdwChgFErfyRqSe45hm1sYGdxj0/pT
        n9sKJ+I0h9P2eBfnMppY51q8yQlFSOYz
X-Google-Smtp-Source: ACHHUZ6+15YCL3DkMoKwRHNc2KxumX7PsZPc1DWQyFZk5MdzIJtfQPpCJNQAhBnvX0Of/vVzJXP3xRGySgxm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a81:af59:0:b0:573:3897:c925 with SMTP id
 x25-20020a81af59000000b005733897c925mr6372448ywj.6.1687533056765; Fri, 23 Jun
 2023 08:10:56 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:10:13 -0700
In-Reply-To: <20230623151016.4193660-1-irogers@google.com>
Message-Id: <20230623151016.4193660-10-irogers@google.com>
Mime-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 09/12] perf vendor events intel: Update sapphirerapids to 1.14
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
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Updates were released in:
https://github.com/intel/perfmon/commit/a84850f1fec633002c35838ed34e51e1f0d=
6a2dd
Adds a large number of CXL events like
UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_ACC,
UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_ACC,
UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_ACC,
UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_ACC,
UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_ACC,
UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_ACC,
UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_ACC,
UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_ACC,
UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_ACC,
UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL_ACC,
UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_ACC,
UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_ACC,
UNC_CHA_TOR_INSERTS.IA_MISS_CXL_ACC,
UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC,
UNC_CHA_TOR_OCCUPANCY.IA_MISS_CXL_ACC,
UNC_CHA_TOR_OCCUPANCY.IA_HIT_CXL_ACC.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/sapphirerapids/pipeline.json     |   2 +-
 .../arch/x86/sapphirerapids/uncore-cache.json | 308 ++++++++++++++++++
 .../sapphirerapids/uncore-interconnect.json   |   2 +-
 4 files changed, 311 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 98828c3a9cde..f321b2cd83da 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -24,7 +24,7 @@ GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-A7,v1.01,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
-GenuineIntel-6-(8F|CF),v1.13,sapphirerapids,core
+GenuineIntel-6-(8F|CF),v1.14,sapphirerapids,core
 GenuineIntel-6-AF,v1.00,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v56,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index 72e9bdfa9f80..6dcf3b763af4 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -706,7 +706,7 @@
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of specualtive operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
         "UMask": "0x8"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
index b91cebf81f50..3fa660694bc7 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
@@ -3156,6 +3156,23 @@
         "UMask": "0xc88ffd01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "All requests issued from IA cores to CXL acce=
lerator memory regions that hit the LLC.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c0008101",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts; DRd hits from local IA",
         "EventCode": "0x35",
@@ -3371,6 +3388,23 @@
         "UMask": "0xc80f7e01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "All requests issued from IA cores to CXL acce=
lerator memory regions that miss the LLC.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_CXL_ACC_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c0008201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts for DRd misses from local IA",
         "EventCode": "0x35",
@@ -3397,6 +3431,23 @@
         "UMask": "0xc837fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "DRds issued from an IA core which miss the L3=
 and target memory in a CXL type 2 memory expander card.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8178201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_ACC_LOCAL=
",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8168201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts for DRds issued by IA Cores targe=
ting DDR Mem that Missed the LLC",
         "EventCode": "0x35",
@@ -3442,6 +3493,15 @@
         "UMask": "0xc827fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_CXL_ACC_L=
OCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8268201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts; DRd Opt Pref misses from local I=
A",
         "EventCode": "0x35",
@@ -3451,6 +3511,15 @@
         "UMask": "0xc8a7fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_CXL_=
ACC_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_CXL_ACC_LOC=
AL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8a68201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts for DRds issued by iA Cores targe=
ting PMM Mem that Missed the LLC",
         "EventCode": "0x35",
@@ -3469,6 +3538,23 @@
         "UMask": "0xc897fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "L2 data prefetches issued from an IA core whi=
ch miss the L3 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8978201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_ACC_=
LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8968201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts : DRd_Prefs issued by iA Cores ta=
rgeting DDR Mem that Missed the LLC",
         "EventCode": "0x35",
@@ -3603,6 +3689,23 @@
         "UMask": "0xccd7fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "LLC data prefetches issued from an IA core wh=
ich miss the L3 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccd78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_A=
CC_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_ACC_LOCA=
L",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10ccd68201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts; LLCPrefRFO misses from local IA"=
,
         "EventCode": "0x35",
@@ -3612,6 +3715,23 @@
         "UMask": "0xccc7fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "L2 RFO prefetches issued from an IA core whic=
h miss the L3 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8878201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_AC=
C_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_ACC_LOCAL=
",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8868201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts : WCiLFs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed locally",
         "EventCode": "0x35",
@@ -3701,6 +3821,23 @@
         "UMask": "0x10c8038201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "RFOs issued from an IA core which miss the L3=
 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8078201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_ACC_LOCAL=
",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8068201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts RFO misses from local IA",
         "EventCode": "0x35",
@@ -3719,6 +3856,23 @@
         "UMask": "0xc887fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "LLC RFO prefetches issued from an IA core whi=
ch miss the L3 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccc78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_ACC_=
LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10ccc68201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts; RFO prefetch misses from local I=
A",
         "EventCode": "0x35",
@@ -4427,6 +4581,23 @@
         "UMask": "0xc88ffd01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for All requests issued from IA=
 cores to CXL accelerator memory regions that hit the LLC.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CXL_ACC_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c0008101",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; DRd hits from local IA",
         "EventCode": "0x36",
@@ -4644,6 +4815,23 @@
         "UMask": "0xc80f7e01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for All requests issued from IA=
 cores to CXL accelerator memory regions that miss the LLC.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CXL_ACC_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c0008201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy for DRd misses from local IA",
         "EventCode": "0x36",
@@ -4672,6 +4860,23 @@
         "UMask": "0xc837fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for DRds and equivalent opcodes=
 issued from an IA core which miss the L3 and target memory in a CXL type 2=
 memory expander card.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8178201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_ACC_LOC=
AL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8168201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy for DRds issued by iA Cores tar=
geting DDR Mem that Missed the LLC",
         "EventCode": "0x36",
@@ -4717,6 +4922,15 @@
         "UMask": "0xc827fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_CXL_ACC=
_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_CXL_ACC_LOCAL"=
,
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8268201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; DRd Opt Pref misses from local=
 IA",
         "EventCode": "0x36",
@@ -4726,6 +4940,15 @@
         "UMask": "0xc8a7fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF_CX=
L_ACC_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF_CXL_ACC_L=
OCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8a68201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy for DRds issued by iA Cores tar=
geting PMM Mem that Missed the LLC",
         "EventCode": "0x36",
@@ -4744,6 +4967,23 @@
         "UMask": "0xc897fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for L2 data prefetches issued f=
rom an IA core which miss the L3 and target memory in a CXL type 2 accelera=
tor.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8978201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_AC=
C_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_ACC_LOCAL=
",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8968201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy : DRd_Prefs issued by iA Cores =
targeting DDR Mem that Missed the LLC",
         "EventCode": "0x36",
@@ -4878,6 +5118,23 @@
         "UMask": "0xccd7fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for LLC data prefetches issued =
from an IA core which miss the L3 and target memory in a CXL type 2 acceler=
ator.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccd78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL=
_ACC_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL_ACC_LO=
CAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10ccd68201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; LLCPrefRFO misses from local I=
A",
         "EventCode": "0x36",
@@ -4887,6 +5144,23 @@
         "UMask": "0xccc7fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for L2 RFO prefetches issued fr=
om an IA core which miss the L3 and target memory in a CXL type 2 accelerat=
or.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8878201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_=
ACC_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_ACC_LOC=
AL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8868201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy : WCiLFs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed locally",
         "EventCode": "0x36",
@@ -4976,6 +5250,23 @@
         "UMask": "0x10c8038201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for RFOs issued from an IA core=
 which miss the L3 and target memory in a CXL type 2 accelerator.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8078201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_ACC_LOC=
AL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_ACC_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10c8068201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; RFO misses from local IA",
         "EventCode": "0x36",
@@ -4994,6 +5285,23 @@
         "UMask": "0xc887fe01",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Occupancy for LLC RFO prefetches issued f=
rom an IA core which miss the L3 and target memory in a CXL type 2 accelera=
tor.",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccc78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_AC=
C_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_ACC_LOCAL=
",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10ccc68201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; RFO prefetch misses from local=
 IA",
         "EventCode": "0x36",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconn=
ect.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnec=
t.json
index 6800de05c836..09d840c7da4c 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.jso=
n
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.jso=
n
@@ -3326,7 +3326,7 @@
         "EventCode": "0x50",
         "EventName": "UNC_M3UPI_RxC_HELD.PARALLEL_SUCCESS",
         "PerPkg": "1",
-        "PublicDescription": "Message Held : Parallel Success : ad and bl =
messages were actually slotted into the same flit in paralle",
+        "PublicDescription": "Message Held : Parallel Success : ad and bl =
messages were actually slotted into the same flit in parallel",
         "UMask": "0x8",
         "Unit": "M3UPI"
     },
--=20
2.41.0.162.gfafddb0af9-goog

