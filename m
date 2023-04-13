Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B880C77B61
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 13:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDMNfD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDMNdz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 09:33:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E686A42
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:32:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j6-20020a255506000000b00b8ef3da4acfso12988374ybb.8
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681392750; x=1683984750;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUfPUvLoShzw1K1BISvJjLxFPJ+s9EqCiRDe+diC2OM=;
        b=HncV5JMqwu/eslVmWJFNt1vbGo/I79ZOjHk16mqN3sNZ9nr7NzPJB/WDAXA5FUZFkb
         Gi5S9XCohLjnlEs3RDOUK6zL1iW6iosXxMUnZvvC8tGgfZNtR8pbrSkyViRBHSr4JTdJ
         9ZCsTzXt07sm2ZZT+DUYejLfxPa4KPIoF6Gh+zP5f86cL4NfOdSZ5rMMFqnd+hD4PNC1
         CEHfR19yjURUqKpqoahTXyCVR8ZSY8RDXtYf5UhEE+NBP3UiRtDLqRyzxYZev7pdep1o
         wuop+DxY4Pg/8ou99tLVg2k3+uOk3nwPTryKsBJ10+V1eLpR5Xdp69UlNLO8zOZzrTUn
         l9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392750; x=1683984750;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUfPUvLoShzw1K1BISvJjLxFPJ+s9EqCiRDe+diC2OM=;
        b=H/QrxkAae2AJE6AQxPwb1M5rTjbx8jUkPRAV/34kIZV0ei9wtfEQPC+8tsQXf75UYc
         +7pMZMai2T9vvRol/9ma/Tyuxfhzp82HWsfSfrcNDOrEiauqx8pjXw6S4y2y+MRgBpbt
         MCS/zGBPh8WXHAz35i2C1MmsIhkoQn0SH3jcD7+7n/+JvTjtL3C+s12tspFWk1clmTTn
         33rnWfVw+Rz4oT6aHF9NZik0OMKKFuUJIwj9MWQTHXTZhMblMaYpSO2tPT8BU76sJH4K
         +3Zwtz2W6p8+6WqIsMEQ+AxpUn3X3PkmLWik7O5pv5WNGDZXq/yjHAhg9j84mAV5XHho
         aBLA==
X-Gm-Message-State: AAQBX9cyUCq2iy2JBgzJ60Qtep+bMNQHsenExbicCrtMXqFDMIFC8HDE
        YKHZjfa4uqSnk8FKMfdUJQekm8BJWU9C
X-Google-Smtp-Source: AKy350aQ6Jewz4zJvJWLFqY2mzftBnR5EJR9IPPP2Z+QWVEdma4wF8BNApqoaG3nsn8Wty19sMs1yTfQcRhf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a81:9846:0:b0:544:bbd2:74be with SMTP id
 p67-20020a819846000000b00544bbd274bemr4805857ywg.4.1681392750564; Thu, 13 Apr
 2023 06:32:30 -0700 (PDT)
Date:   Thu, 13 Apr 2023 06:29:46 -0700
In-Reply-To: <20230413132949.3487664-1-irogers@google.com>
Message-Id: <20230413132949.3487664-19-irogers@google.com>
Mime-Version: 1.0
References: <20230413132949.3487664-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v3 18/21] perf vendor events intel: Fix uncore topics for skylake
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
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move events from 'uncore-other' topic classification to cache and
interconnect.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/skylake/uncore-cache.json        | 28 ++++----
 .../arch/x86/skylake/uncore-interconnect.json | 67 +++++++++++++++++++
 .../arch/x86/skylake/uncore-other.json        | 65 ------------------
 3 files changed, 81 insertions(+), 79 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-interconnect.json

diff --git a/tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json b/tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json
index ec9463c94ffe..b4e061477c1a 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json
@@ -6,7 +6,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup any request that access cache and found line in E or S-state.",
         "UMask": "0x86",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and found line in I-state",
@@ -15,7 +15,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup any request that access cache and found line in I-state.",
         "UMask": "0x88",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and found line in M-state",
@@ -24,7 +24,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup any request that access cache and found line in M-state.",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and found line in MESI-state",
@@ -33,7 +33,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup any request that access cache and found line in MESI-state.",
         "UMask": "0x8f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in E or S-state",
@@ -42,7 +42,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup read request that access cache and found line in E or S-state.",
         "UMask": "0x16",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in I-state",
@@ -51,7 +51,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup read request that access cache and found line in I-state.",
         "UMask": "0x18",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in any MESI-state",
@@ -60,7 +60,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup read request that access cache and found line in any MESI-state.",
         "UMask": "0x1f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in E or S-state",
@@ -69,7 +69,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup write request that access cache and found line in E or S-state.",
         "UMask": "0x26",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in M-state",
@@ -78,7 +78,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup write request that access cache and found line in M-state.",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in MESI-state",
@@ -87,7 +87,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup write request that access cache and found line in MESI-state.",
         "UMask": "0x2f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due to processor core memory request which hits a modified line in some processor core.",
@@ -95,7 +95,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_XCORE",
         "PerPkg": "1",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due to processor core memory request which hits a non-modified line in some processor core.",
@@ -103,7 +103,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_XCORE",
         "PerPkg": "1",
         "UMask": "0x44",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
@@ -111,7 +111,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
         "PerPkg": "1",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due to processor core memory request which misses in some processor core.",
@@ -119,6 +119,6 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE",
         "PerPkg": "1",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/skylake/uncore-interconnect.json
new file mode 100644
index 000000000000..fe7e19717371
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/skylake/uncore-interconnect.json
@@ -0,0 +1,67 @@
+[
+    {
+        "BriefDescription": "Number of entries allocated. Account for Any type: e.g. Snoop, Core aperture, etc.",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all Core entries outstanding for the memory controller. The outstanding interval starts after LLC miss till return of first data chunk. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Cycles with at least one request outstanding is waiting for data return from memory controller. Account for coherent and non-coherent requests initiated by IA Cores, Processor Graphics Unit, or LLC.",
+        "CounterMask": "1",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Core Data Read entries outstanding for the memory controller. The outstanding interval starts after LLC miss till return of first data chunk.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.DATA_READ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "UNC_ARB_TRK_REQUESTS.ALL",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Core coherent Data Read requests sent to memory controller whose data is returned directly to requesting agent.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.DATA_READ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Core coherent Data Read requests sent to memory controller whose data is returned directly to requesting agent.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.DRD_DIRECT",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Writes allocated - any write transactions: full/partials writes and evictions.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "ARB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/uncore-other.json b/tools/perf/pmu-events/arch/x86/skylake/uncore-other.json
index ef804df3f41e..58be90d7cc93 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/uncore-other.json
@@ -1,69 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of entries allocated. Account for Any type: e.g. Snoop, Core aperture, etc.",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all Core entries outstanding for the memory controller. The outstanding interval starts after LLC miss till return of first data chunk. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Cycles with at least one request outstanding is waiting for data return from memory controller. Account for coherent and non-coherent requests initiated by IA Cores, Processor Graphics Unit, or LLC.",
-        "CounterMask": "1",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of Core Data Read entries outstanding for the memory controller. The outstanding interval starts after LLC miss till return of first data chunk.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.DATA_READ",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "UNC_ARB_TRK_REQUESTS.ALL",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of Core coherent Data Read requests sent to memory controller whose data is returned directly to requesting agent.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.DATA_READ",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of Core coherent Data Read requests sent to memory controller whose data is returned directly to requesting agent.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.DRD_DIRECT",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of Writes allocated - any write transactions: full/partials writes and evictions.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
-        "PerPkg": "1",
-        "UMask": "0x20",
-        "Unit": "ARB"
-    },
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles",
         "EventCode": "0xff",
-- 
2.40.0.577.gac1e443424-goog

