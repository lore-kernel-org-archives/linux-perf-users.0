Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65EEC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 21:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbiDMVIR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238789AbiDMVIL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 17:08:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F23765A6
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ef53391dbaso13773947b3.11
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f2AT4ITYPFxsdOdurZGcIARH0DtMfQS5p3Gw/gDTrdU=;
        b=hid61dedk9iGfRraAq8k0u8M9v8qBhUYnXHMiULz8qz+dmjXXzBzlKc5V9brm1oq5H
         z7WpPGlQbu3dJ00ZNoB7edObLdsuGHGThhNVYJrWtrY/P7MXVkCEL0lkQsurFXOyBQn6
         dxSESNjStGdRlOum3W+qR1YGEs7ty+3TF7BHteSMQ3WjGkGEI/985zjfRkHK+cxwG8OW
         +J6cRLL8yATDNQKNCzlpO+WQ33xB6qDcIr/bf5gC/3e5n/428oK3CwovyTG+6tEHnpuU
         U9mHyro1Lme6BWqHXqtU4uMOLYfr7k5AnTcu/U1TW8WdGSf2F0LHD14yVr0wWtWMBYwR
         J1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f2AT4ITYPFxsdOdurZGcIARH0DtMfQS5p3Gw/gDTrdU=;
        b=R/W45xnBcklz+mWu4RN4pBYV6CfhRNPo1yj8TGle96fCKPCDhXBt0ArU2nU+oPcQ1r
         4uML4jt6fDgGViosBB25M8523vvVqU2B5cuu1arGzIDsad5VP1b6a7vfspXOOOmhpFv2
         TVdxD3svpDcDhAlCv5ZQF5nTxRnsY0jhfyDHTL32t9Sw5kg0wkHj5uIOtwFIz5NNokrQ
         nN3pQHIxnA7W3YnGFOIUcmlP3Igaxz1FhswGLW1Fmut1bHiuaunxgxlYro2caqOdl2dH
         7QZG8LHc/MB3kIq4hWTZOk+cNmKjkSavkwPZzpQRzoioQPRxqb70+brSM2YOW8CHkwW3
         GVSw==
X-Gm-Message-State: AOAM533lRXZqm6nbPX9ttSaWYkfe2FPUpnVnQKGt+TmE5KOv+RxWq58m
        TwJyaFb90QPETeqP9faRYcRB8ecDuqFV
X-Google-Smtp-Source: ABdhPJy7dB5pZ5t1tJ3klcEWLFkfKfF0MQqcpByNUpfqLHZxhn0xsobf4f6As9YZV5bP7MRg8Jvr1CySYnWG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a81:1345:0:b0:2ec:31ea:dfdb with SMTP id
 66-20020a811345000000b002ec31eadfdbmr717334ywt.351.1649883926710; Wed, 13 Apr
 2022 14:05:26 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:58 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-9-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 09/14] perf vendor events intel: Update westmereep-dp event topics
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

Apply topic updates from:
https://github.com/intel/event-converter-for-linux-perf/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/westmereep-dp/other.json         | 66 +------------------
 .../arch/x86/westmereep-dp/pipeline.json      | 66 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
index 23dcd554728c..67bc34984fa8 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
@@ -1,28 +1,4 @@
 [
-    {
-        "BriefDescription": "Early Branch Prediciton Unit clears",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xE8",
-        "EventName": "BPU_CLEARS.EARLY",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Late Branch Prediction Unit clears",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xE8",
-        "EventName": "BPU_CLEARS.LATE",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Branch prediction unit missed call or return",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xE5",
-        "EventName": "BPU_MISSED_CALL_RET",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "ES segment renames",
         "Counter": "0,1,2,3",
@@ -127,46 +103,6 @@
         "SampleAfterValue": "200000",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "All RAT stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xD2",
-        "EventName": "RAT_STALLS.ANY",
-        "SampleAfterValue": "2000000",
-        "UMask": "0xf"
-    },
-    {
-        "BriefDescription": "Flag stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xD2",
-        "EventName": "RAT_STALLS.FLAGS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Partial register stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xD2",
-        "EventName": "RAT_STALLS.REGISTERS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "ROB read port stalls cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xD2",
-        "EventName": "RAT_STALLS.ROB_READ_PORT",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "Scoreboard stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xD2",
-        "EventName": "RAT_STALLS.SCOREBOARD",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x8"
-    },
     {
         "BriefDescription": "All Store buffer stall cycles",
         "Counter": "0,1,2,3",
@@ -284,4 +220,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
index 10140f460fbb..403fb2b87fc4 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
@@ -50,6 +50,30 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Early Branch Prediciton Unit clears",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE8",
+        "EventName": "BPU_CLEARS.EARLY",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Late Branch Prediction Unit clears",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE8",
+        "EventName": "BPU_CLEARS.LATE",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Branch prediction unit missed call or return",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE5",
+        "EventName": "BPU_MISSED_CALL_RET",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Branch instructions decoded",
         "Counter": "0,1,2,3",
@@ -494,6 +518,46 @@
         "SampleAfterValue": "20000",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "All RAT stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "RAT_STALLS.ANY",
+        "SampleAfterValue": "2000000",
+        "UMask": "0xf"
+    },
+    {
+        "BriefDescription": "Flag stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "RAT_STALLS.FLAGS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Partial register stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "RAT_STALLS.REGISTERS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "ROB read port stalls cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "RAT_STALLS.ROB_READ_PORT",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Scoreboard stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "RAT_STALLS.SCOREBOARD",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Resource related stall cycles",
         "Counter": "0,1,2,3",
@@ -896,4 +960,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.36.0.rc0.470.gd361397f0d-goog

