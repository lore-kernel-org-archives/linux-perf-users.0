Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E52CCA48A
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jul 2022 22:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiGYWjq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiGYWiv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jul 2022 18:38:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DC825E9A
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 15:37:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f46b4759bso1617377b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VRYq/3VipyPAQUNgnVCOcSr5eBLXfY8DFtdppUbEbtU=;
        b=ktQH1FonfCU5Ke+1oIsBldW3IZM3KN/XPmANPSBaHcg6FCEBq/fNTHjAbP40WBZYYy
         ss6ix/XNkh6rPMiDVIvZlkqO3m5bFqMKq85TZynZTi5+mpdDXwSUig+K+//Tn7lY63fI
         NXfN+oqExwuV6JKZ039EawMmkq6rTu/z3iYzF9NqFC7fZXfgMg3dvmG3OG+prRQNJxEP
         WMu0eroTg8Ouq1Pj/OJ8qJbuY2AAfu1htxw1llX8xTAIls/4TvCtQbRwIGO35oMXH2RP
         sCxN0HtOR/cWAcDt+fbgapi1ho9xbvbpd3v0LdI+zDDmqP5PUVzsRqwp3CbHJ9eKMKnM
         A5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VRYq/3VipyPAQUNgnVCOcSr5eBLXfY8DFtdppUbEbtU=;
        b=tVSg66yrE1fEheQdMSPDdRPTHjDS9RTpMV6u5YcF9lx/pO6qOFoS9wfV2u2h4GSwpY
         MDzhP9wsG3vavaX1Y9XyG1zLRdzvbF/Witjd+Avbfi/F4Q3fpN1BrDtcLs2gYfnDedK+
         lBF9I9C2kZK1abAazPFvuOzPoBISWO144zx/WI1L+mkeCcQA4l5kVZkXq9wDwtvBxjqa
         DwjBppowvdtGFsrcAbqKM9+il7rC27yRAnG0xPVScQvAs5l02r5UnypMbbiRR/Ovf80w
         jkxd9Kmq/sj8CqbnHInrkucyaSPO8tiG5JP3vrsj/vWyOT6S0EOkWHIWzbIq48gr6Ru7
         nLtA==
X-Gm-Message-State: AJIora82DRzyQF7xsW495yDdE+oMBHx42D0iDoL+gPqUEijiSBTtUC3A
        uryTsnI7XoRsJRBYjvUW/NWxH/P/m3nn
X-Google-Smtp-Source: AGRyM1sXib++bbXb90rIcJoupm6jBQUZWTnacavwK7VPUBwcbVNbQU7/SfFsdeqHHhcFM8R09KMlpblh/xI6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a25:3747:0:b0:66f:77b1:904f with SMTP id
 e68-20020a253747000000b0066f77b1904fmr10774681yba.447.1658788657681; Mon, 25
 Jul 2022 15:37:37 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:21 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-21-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 20/32] perf vendor events: Update Intel nehalemep
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update to v3, the are no TMA metrics for nehalemep.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the nehalemep files into perf and update mapfile.csv.

Tested on a non-nehalemep with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv         |  4 +---
 .../perf/pmu-events/arch/x86/nehalemep/cache.json  | 14 +++++++-------
 .../arch/x86/nehalemep/floating-point.json         |  2 +-
 .../pmu-events/arch/x86/nehalemep/frontend.json    |  2 +-
 .../perf/pmu-events/arch/x86/nehalemep/memory.json |  6 +++---
 .../arch/x86/nehalemep/virtual-memory.json         |  2 +-
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 7d6731e81102..8336f2c8f96f 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -17,9 +17,7 @@ GenuineIntel-6-3E,v21,ivytown,core
 GenuineIntel-6-2D,v21,jaketown,core
 GenuineIntel-6-(57|85),v9,knightslanding,core
 GenuineIntel-6-AA,v1.00,meteorlake,core
-GenuineIntel-6-1E,v2,nehalemep,core
-GenuineIntel-6-1F,v2,nehalemep,core
-GenuineIntel-6-1A,v2,nehalemep,core
+GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v2,nehalemex,core
 GenuineIntel-6-[4589]E,v24,skylake,core
 GenuineIntel-6-A[56],v24,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
index bcf74d793ae2..1ee91300baf9 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
@@ -1773,7 +1773,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
@@ -1784,7 +1784,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
@@ -1795,7 +1795,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
@@ -1806,7 +1806,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
@@ -1861,7 +1861,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
@@ -1872,7 +1872,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
@@ -3226,4 +3226,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
index 39af1329224a..666e466d351c 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
@@ -226,4 +226,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json b/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
index 8ac5c24888c5..c561ac24d91d 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
@@ -23,4 +23,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
index 26138ae639f4..6e95de3f3409 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
@@ -286,7 +286,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
@@ -297,7 +297,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
@@ -736,4 +736,4 @@
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
index 6d3247c55bcd..e88c0802e679 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
@@ -106,4 +106,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

