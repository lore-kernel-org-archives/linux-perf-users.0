Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA48C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Mar 2022 18:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiCQSbE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiCQSbC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Mar 2022 14:31:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0D4F3A59
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Mar 2022 11:29:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d6914a097cso51628567b3.10
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Mar 2022 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=16R8cuvlrytUTd48mQ9QH65EhG2EnQWcUN8IuJ/qkS0=;
        b=YkMKBUs/08jQ8aMFJCwXs7KV7zxnkANJBEApz0nbFTla9/OIuO1F8iOWZ3RbeuqpLK
         /7rZ5DUlsuV3zgmLDauE40dGturuyASqlt5+oRK3wP72piUDbkzXgypTK3J3osip64Kq
         DazD65tgSwPrJgxXWug071ElzL/LFovDC/hNBvFAFpysnRidv3dAiDzGUSlIZyAa5bop
         xdK4mSkCTglTBbAV8LtJ83cGN/vAUMueNgeJ6a/eS9aSZqxrTTYGxMmd/vJQ+dVcJ6ty
         lh5dFGa0UAp8jUMUsgvnZOkW32YZJWvftSPRNX6QGTVcvRDEHB9dv6St5vcEb0fBQ2UO
         JW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=16R8cuvlrytUTd48mQ9QH65EhG2EnQWcUN8IuJ/qkS0=;
        b=cs2V0VlQo0VKsRAArkRrPN58P2cFlrHMQZP5n8+3OfDxsdguNLPOHvIrXKS0tr/BhL
         LA0cs9y5Cxq8/Mq/kvk8Du9sFeCYAc1l4qz6I2bdqWDSWZHn8//eCFPDBjpFnHIIz2SF
         mcedmKPySeJQYpMFEyY03vwntHMB5SoMQS7m1VudRYn/EX6rytY+cbsB1p2MMA9ppbkO
         c6q/PWR2/02HshtTqzxBQAFVmOyoJbs2642pou81+8JDpUFQjXNPwg8/kB4zADupQj/V
         box6k4g8zofLAn1J//UIlQKo+3xPYZcOvjznfUGSakl/alJdKFTm4X4tqBwKhFh+dA1v
         nwig==
X-Gm-Message-State: AOAM531D/B/5AOdRycmDjVBagx1DV0FHJYQB505nsMDrv6QB6yiVICy8
        x/dPwYpoUvYmzA3K0KePJcv6ALwqn7Uh
X-Google-Smtp-Source: ABdhPJy26VZJsBJ3Wu/Pjx0aWHyrafHeAkxP4Ucljuz60xLQtfCIEK4A2XoBy9YEwOl5vykEQ2RDaESKn5qa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6811:1685:e3b9:7904])
 (user=irogers job=sendgmr) by 2002:a81:1cc5:0:b0:2d6:17ad:11ea with SMTP id
 c188-20020a811cc5000000b002d617ad11eamr6936770ywc.43.1647541783631; Thu, 17
 Mar 2022 11:29:43 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:28:56 -0700
In-Reply-To: <20220317182858.484474-1-irogers@google.com>
Message-Id: <20220317182858.484474-6-irogers@google.com>
Mime-Version: 1.0
References: <20220317182858.484474-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH 6/8] perf vendor events: Update events for SkylakeX
From:   Ian Rogers <irogers@google.com>
To:     Kan Liang <kan.liang@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The change:
https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e394eed6a1ebd909c9f649d3ed3ef
moved certain "other" type of events in to the cache topic. Update the
perf json files for this change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/skylakex/cache.json   | 36 +++++++++++++++++++
 .../pmu-events/arch/x86/skylakex/other.json   | 36 -------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylakex/cache.json b/tools/perf/pmu-events/arch/x86/skylakex/cache.json
index 821d2f2a8f25..6639e18a7068 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/cache.json
@@ -1686,5 +1686,41 @@
         "PublicDescription": "Counts the number of cache line split locks sent to the uncore.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x32",
+        "EventName": "SW_PREFETCH_ACCESS.NTA",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x32",
+        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x32",
+        "EventName": "SW_PREFETCH_ACCESS.T0",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x32",
+        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/other.json b/tools/perf/pmu-events/arch/x86/skylakex/other.json
index 8b344259176f..779654e62d97 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/other.json
@@ -76,41 +76,5 @@
         "EventName": "MEMORY_DISAMBIGUATION.HISTORY_RESET",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.NTA",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHW instructions executed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x8"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.T0",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x4"
     }
 ]
\ No newline at end of file
-- 
2.35.1.894.gb6a874cedc-goog

