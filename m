Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FB9C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 21:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiDMVIL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiDMVHr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 17:07:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62814BBA7
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ec1914e315so26419157b3.23
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M6hxphbgar+HzAtPo4I7IkS8wfLYg+Jal2YHLrvU+Js=;
        b=BjNXG+C5cyguf3y53w98MrRTLqYnoWqjsCXsDJyQX0vicVPme6c4jbKvebCZwlO4fe
         4Psx1qqkarWmh9Oes7yFnCqFvcPOLxohY/8eEKKc188tp5wFSDqjJF+kie0Tepn/T35n
         wQsuV9rHj34FdVckNV7rS27hGSkezAJN01haV+/mruirtnzBP9jN9ybrO4HpJA7tsyFb
         QvAsRkw0eM7Gn7InzP8k2vM98M36lvx8oBs9cKGSbntdd6UfGyK8lNiIwPi8KVQkM8u3
         8FzlyalvyhdhNKwwhGo2KhJZulAPmezlp3fZcUuv9OuB0RxD8/Nks0kvqHdabMPOyLqV
         oJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M6hxphbgar+HzAtPo4I7IkS8wfLYg+Jal2YHLrvU+Js=;
        b=6B43eBu+UgVHXVGRYESpJ5XFySO3drtmSdAj40so9hsoPiDU8pY3QTwJUfsLu1PJyH
         PWgZ/83vp4RapiacY90rNuWjO0lRTEPt48GiwfQER9/MTLgOdfuENMHc4szL58ZObaZk
         dzISER0PbLfe3g+I3xaRR/Cme88BKRFqLRteYUk3fB25pPqwkjbJCNvBgfuLTRcf2Ct3
         d/36S7bumd4wyucLxhXiPKRAGSX2V7iLmyOd25fEoYKikvJ/SMxdzP7Lp7Sc+92OLq6L
         ULY999AL74te2j3xp2pY2zRWVjeQisli38tCSGJhdVQvd7OsNG8EzVKdKkRjy9iQnC1O
         yVXw==
X-Gm-Message-State: AOAM531/KUl/AUPV/RpDCR0dwfF4Zf/Xf2fQqkkgAyzLULPYwzUas2/9
        dnYObF/oGiCEya/8jKfpS01Esvd93Ajl
X-Google-Smtp-Source: ABdhPJzgXdC7Z+X3CZnMKg/EwPoEGTzYp+mdc2QwJfDLbW2w7r2V7jOY6q1+WJW1p+MDH80k0XfC1uTK9RZU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a25:d207:0:b0:641:5458:207e with SMTP id
 j7-20020a25d207000000b006415458207emr700126ybg.552.1649883924001; Wed, 13 Apr
 2022 14:05:24 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:57 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-8-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 08/14] perf vendor events intel: Update tremontx uncore and topics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update the topic of BTCLEAR.ANY and add additional uncore event names
as per:
https://github.com/intel/event-converter-for-linux-perf/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/tremontx/other.json   | 13 +--
 .../arch/x86/tremontx/pipeline.json           | 13 ++-
 .../arch/x86/tremontx/uncore-memory.json      | 22 +++++
 .../arch/x86/tremontx/uncore-other.json       | 94 +++++++++++++++++++
 4 files changed, 129 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/tremontx/other.json b/tools/perf/pmu-events/arch/x86/tremontx/other.json
index 4f20f45a4898..2766e9dfc325 100644
--- a/tools/perf/pmu-events/arch/x86/tremontx/other.json
+++ b/tools/perf/pmu-events/arch/x86/tremontx/other.json
@@ -1,15 +1,4 @@
 [
-    {
-        "BriefDescription": "Counts the total number of BTCLEARS.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xe8",
-        "EventName": "BTCLEAR.ANY",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the total number of BTCLEARS which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
-        "SampleAfterValue": "200003"
-    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event BUS_LOCK.SELF_LOCKS",
         "CollectPEBSRecord": "2",
@@ -683,4 +672,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json b/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
index 0a77e9f9a16a..38dc8044767b 100644
--- a/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
@@ -164,6 +164,17 @@
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
+    {
+        "BriefDescription": "Counts the total number of BTCLEARS.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xe8",
+        "EventName": "BTCLEAR.ANY",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of BTCLEARS which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
+        "SampleAfterValue": "200003"
+    },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
         "CollectPEBSRecord": "2",
@@ -671,4 +682,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json b/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
index 0d342efae154..b7ff25a5d717 100644
--- a/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
@@ -10,6 +10,17 @@
         "UMask": "0x0f",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "read requests to memory controller",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.RD",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x0f",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "write requests to memory controller. Derived from unc_m_cas_count.wr",
         "Counter": "0,1,2,3",
@@ -21,6 +32,17 @@
         "UMask": "0x30",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "write requests to memory controller",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.WR",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x30",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Memory controller clock ticks",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json b/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
index 0f73582248f9..5194ce1b4390 100644
--- a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
@@ -19,6 +19,18 @@
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) ",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Filter": "config1=0x40e33",
+        "PerPkg": "1",
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "MMIO reads. Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -31,6 +43,18 @@
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "MMIO reads",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Filter": "config1=0x40040e33",
+        "PerPkg": "1",
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "MMIO writes. Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -43,6 +67,18 @@
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "MMIO writes",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Filter": "config1=0x40041e33",
+        "PerPkg": "1",
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "Streaming stores (full cache line). Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -56,6 +92,19 @@
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Streaming stores (full cache line)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Filter": "config1=0x41833",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "Streaming stores (partial cache line). Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -69,6 +118,19 @@
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Streaming stores (partial cache line)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Filter": "config1=0x41a33",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "read requests from home agent",
         "Counter": "0,1,2,3",
@@ -105,6 +167,22 @@
         "UMask": "0x04",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "Filter": "ch_mask=0x1f",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "MetricName": "LLC_MISSES.PCIE_READ",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "PCI Express bandwidth writing at IIO. Derived from unc_iio_data_req_of_cpu.mem_write.part0",
         "Counter": "0,1",
@@ -121,6 +199,22 @@
         "UMask": "0x01",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "Filter": "ch_mask=0x1f",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "MetricName": "LLC_MISSES.PCIE_WRITE",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "PCI Express bandwidth writing at IIO, part 1",
         "Counter": "0,1",
-- 
2.36.0.rc0.470.gd361397f0d-goog

