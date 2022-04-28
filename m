Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B65C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Apr 2022 07:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbiD1IBD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Apr 2022 04:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343638AbiD1IBB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Apr 2022 04:01:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DBA9D4DF
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 00:57:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7ddeb73c1so39928567b3.5
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SO+yjzYpVBUSmrI7QpCCrXS5LJfjCzTJ8nkeb3Mo8dU=;
        b=Qa4x2xMtTBRaEBmnuV0W0tjeGml32zmd51Fa45Tjo2IT/6K5D6YbIsyaNK8VFmkOJ6
         7+4sLWRsk/cwOft1kJzYjlLjpa0GLeKx84kDAoCU1tNRW9ebnoAULQY/knyDx4CWm9Ky
         dOPSMhlfu9kKZ6X8bA314lg1ardMAZYesSNEvYM08sgOrzDJK65LxOv1aLJ6J7CGsFcV
         fnnB0GJt2017adnSlPaGPkZy5E6ZtR2CCNOWmywZRkhpjUbh2i73iba9LboJnuYsfyav
         RmgRH0LMqYlJNoInUo6Dgxp5QjQb6pZGU1GDbth2QOSGKuVeVUAMuUxyKdJNVU9jtj+L
         mOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SO+yjzYpVBUSmrI7QpCCrXS5LJfjCzTJ8nkeb3Mo8dU=;
        b=lwQMibRUUeIt7h3dWVdh6Eh4396T03Z3anbdlib11JuGnJ45LAow51pjLO5KIEDc4K
         pCLIL3lJ9lVN5ogp2JTXGWc9WNE/GECs/JoBBr9LEV3ins/Y89Uto6LxH3uS2YDTSCIZ
         7Vvnh6WnIsEpC5ulIOm6B+xfNLIGrxy/8fkQ+xhiZ3T6WgdvwgJHxs5ugnfFtkKcVJFn
         Kaliwsy6wyN2KdMsHMAUIbiFUXe5Beo0hKANtOH9rl0PJVq+xASUGK7BpY0P3p02rIUe
         S286wfowlT9OsdeJLEkylVWaQvhLBvjiLYil3OyZEMCumEhO96S/X08mPRa9b/+7o6t7
         cHDw==
X-Gm-Message-State: AOAM532NJIcBB3S05cQz/tAz6Q8kwxskABZigTeIT1TCF72l2x35DF2a
        AcgYxaXVJB9jOOthOIodcUo9/1uCi0HG
X-Google-Smtp-Source: ABdhPJxt2fweUwfCgwQBq2TPqBf3/1CLqWtr3RnM1E3AuQ+GloEy3fNJs4TFyN67Sj2RlB3Zr74itM2dMTRr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:33c3:c9d8:c4fd:e75c])
 (user=irogers job=sendgmr) by 2002:a81:af59:0:b0:2f4:d869:b5df with SMTP id
 x25-20020a81af59000000b002f4d869b5dfmr32015447ywj.367.1651132666673; Thu, 28
 Apr 2022 00:57:46 -0700 (PDT)
Date:   Thu, 28 Apr 2022 00:57:29 -0700
In-Reply-To: <20220428075730.797727-1-irogers@google.com>
Message-Id: <20220428075730.797727-6-irogers@google.com>
Mime-Version: 1.0
References: <20220428075730.797727-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 6/7] perf vendor events intel: Update WSM-EP-SP events to v3
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

Events are generated for Westmere EP-SP v3 with events from:
https://download.01.org/perfmon/WSM-EP-SP/

Using the scripts at:
https://github.com/intel/event-converter-for-linux-perf/

This change updates descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/westmereep-sp/cache.json   | 14 +++++++-------
 .../pmu-events/arch/x86/westmereep-sp/memory.json  |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
index 2ecd80f8fa67..c5f33fe2a3ce 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
@@ -1769,7 +1769,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
@@ -1780,7 +1780,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
@@ -1791,7 +1791,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
@@ -1802,7 +1802,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
@@ -1857,7 +1857,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
@@ -1868,7 +1868,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
@@ -3230,4 +3230,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
index 623a0087c8f3..f14e760a9ddc 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
@@ -286,7 +286,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
@@ -297,7 +297,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
@@ -736,4 +736,4 @@
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.36.0.464.gb9c8b46e94-goog

