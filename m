Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F0C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiDMVIT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbiDMVIM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 17:08:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2155583B1B
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d129-20020a254f87000000b006411bf3f331so2714341ybb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YbrCAd0HTzm8nIYQbKISy9o9brmGYCkpuolMPrFO/E0=;
        b=nyChMhsTgdMUn1iXKlSFVbjKsXDeEbTqQfWpiFh11D5qmybgKLmDVaVsPJbMnCjLc6
         61ADOkEaA7YhpdWzy27F2Z3z0CEbT9iegk6w/LChX8Xfzjw9520i7lea9oc+dBJTWNMk
         0fYT4QBwhW6AKDpFa2WVnvWRkYy29clnkDSl6kuzIEbWoPBtJxbpkwN96cQEMXB9c2NI
         xUL6UQ9hC8tr5EYvBFfAMPqTrM7hgvywoH2BqEpG+uFD+Pif7XMPsiqw4hZejtMif9Op
         +U16NVUYtZ6G2fNp3e+5BbJEpoUEK/ijqryPX6+oKj1CzvepRZyo1tic7xDp3mqZXGEg
         Zkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YbrCAd0HTzm8nIYQbKISy9o9brmGYCkpuolMPrFO/E0=;
        b=eJM/tLdRb8y7S5oS20QTUcGiNYq8iy1mfhc+FjG/XKUvwkQ0+HaAgSoP7Tt3peRCs+
         Fbcs5H5ExlhG5DIYAdGhRY4rt5PcKDmkHtcRDkbD9f0pENhxHR6AtctYkl6G8nOjzOBB
         gmwVFeTLMDTyjWpSy2/vUsQcBRliJoKt1MveG6lfi3FZrYPhTxJV6a5yOwUgTa+SoMJd
         Qp6wqJhwiuTmcsFGAo+nQ8SMHVwoHMfv5xXQgvI5EnvhcampHGPcD/ss4E9Qxl05u8Ws
         4ZZrE58Om+TZjkMTcaXEbMWJOngURoZKNpHcHIoMX7+TKIzsph9wkYODv/Xyu8f2cbt2
         WLqQ==
X-Gm-Message-State: AOAM533Hhv7prcuHO2EMbzx9Bn11N8zYykmu5mvJ8F+ttGSR1cU4VriA
        8CohUroMRmbJn64fPXkGrdYXZQ+6UbY6
X-Google-Smtp-Source: ABdhPJztFP7Zw7XFEYDHCtwvHmr4hehc+wkwsMIcT6Hl68294Na0xIN8Jze7tgHocr+v3lrQMNMmA1c7UnRv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a25:b0a5:0:b0:641:4c43:db00 with SMTP id
 f37-20020a25b0a5000000b006414c43db00mr708820ybj.478.1649883929238; Wed, 13
 Apr 2022 14:05:29 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:59 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-10-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 10/14] perf vendor events intel: Update westmereep-sp event topics
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
 .../arch/x86/westmereep-sp/other.json         | 66 +------------------
 .../arch/x86/westmereep-sp/pipeline.json      | 66 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
index 23dcd554728c..67bc34984fa8 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
index 10140f460fbb..403fb2b87fc4 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
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

