Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C7FC77B61
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 13:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjDMNed (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjDMNdp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 09:33:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2DB468
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:32:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f87e44598so66023317b3.5
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681392742; x=1683984742;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjePygWNzjikF1/0wL8IG/xpima8j1eK/Y93rEybJLQ=;
        b=GS6jV3v+fTQxf304pBmtb2QF6+oAf40aGTJB7CItdb905njsjwjrRvziffQ/PUKkP1
         rGhSGBUr6RtTfAUEx0YtRvCiMACNYn4aRNtQR2X1CjhaO8HrmJZo7I7dM4FfKmN17vMH
         F4tk6PW71DGeQ8IwQwQ5AUhnwl1CuEYKVzQD2We2s4f8opAhBkwmiUslE03yCiRBo2Tz
         pOZtVWQDW5sJ5ZD4zmxyzrrjjQi7G3HXIF8J+dh83HP+Etll7u15paYlOC6QqBP7wPxl
         AVPDmrKoZRYZp0UNyt63RbMpN14XQo3xwe5aVEHUZqFE6VL4UyQGIDQdU0Poi60MkAaX
         sj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392742; x=1683984742;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjePygWNzjikF1/0wL8IG/xpima8j1eK/Y93rEybJLQ=;
        b=CINbn47pMQl34xtR4Rz9EDNFEq0te7gzsQxo0DEfia20rcvDFEXkZhKgFTKSApgy2e
         rocDo1v/BQmuCbhrXQED4woQzeb99D4VjQi4vu2M/EVnIrs7Rsktu74yPm7SwX7pIUfI
         rfHma05PeRt4xgBnINoasJ1N+E4DkxQIRhI23YS/VWa7qXLHSdzM8DznCqfcC8xEFHFk
         i7kFjpJ49XrOlc9AdM8NvjHTYvQWw5JYdL1+ud5+WweB0Cl/km9PCHZPJC4tfGFY53AD
         6w4iL6tyY35mY105jSTS+/Rf9H8I737p00LaR4dO6Iy6INIuRx+6nMl1ZMWHDu1dtFIS
         jfCw==
X-Gm-Message-State: AAQBX9e0ZuQeXk/byVhver8v3RQdb9T6WqCPObljtSvznJt9Ts5R4P86
        rTpaFmgdQFimyJ40U6lETa9M8cSYYJOF
X-Google-Smtp-Source: AKy350bxdZvQmjXxNMx6pAHLjGhcAaAi1/DkKsTzlpyd3XrnwzP0CUw1FNDebdnn/d16oj0SdSekQhff517X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a0d:ec47:0:b0:54e:e490:d190 with SMTP id
 r7-20020a0dec47000000b0054ee490d190mr1366137ywn.4.1681392742282; Thu, 13 Apr
 2023 06:32:22 -0700 (PDT)
Date:   Thu, 13 Apr 2023 06:29:45 -0700
In-Reply-To: <20230413132949.3487664-1-irogers@google.com>
Message-Id: <20230413132949.3487664-18-irogers@google.com>
Mime-Version: 1.0
References: <20230413132949.3487664-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v3 17/21] perf vendor events intel: Fix uncore topics for sandybridge
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

Remove 'uncore-other' topic classification, move to cache and
interconnect.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/sandybridge/uncore-cache.json    | 50 +++++++++----------
 ...re-other.json => uncore-interconnect.json} |  0
 2 files changed, 25 insertions(+), 25 deletions(-)
 rename tools/perf/pmu-events/arch/x86/sandybridge/{uncore-other.json => uncore-interconnect.json} (100%)

diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-cache.json b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-cache.json
index c538557ba4c0..be9a3ed1a940 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-cache.json
@@ -5,7 +5,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_ES",
         "PerPkg": "1",
         "UMask": "0x86",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and found line in I-state.",
@@ -13,7 +13,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_I",
         "PerPkg": "1",
         "UMask": "0x88",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and found line in M-state.",
@@ -21,7 +21,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_M",
         "PerPkg": "1",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and found line in MESI-state.",
@@ -29,7 +29,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_MESI",
         "PerPkg": "1",
         "UMask": "0x8f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access cache and found line in E or S-state.",
@@ -37,7 +37,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_ES",
         "PerPkg": "1",
         "UMask": "0x46",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access cache and found line in I-state.",
@@ -45,7 +45,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_I",
         "PerPkg": "1",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access cache and found line in M-state.",
@@ -53,7 +53,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_M",
         "PerPkg": "1",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup external snoop request that access cache and found line in MESI-state.",
@@ -61,7 +61,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.EXTSNP_MESI",
         "PerPkg": "1",
         "UMask": "0x4f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in E or S-state.",
@@ -69,7 +69,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_ES",
         "PerPkg": "1",
         "UMask": "0x16",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in I-state.",
@@ -77,7 +77,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_I",
         "PerPkg": "1",
         "UMask": "0x18",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in M-state.",
@@ -85,7 +85,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_M",
         "PerPkg": "1",
         "UMask": "0x11",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and found line in any MESI-state.",
@@ -93,7 +93,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.READ_MESI",
         "PerPkg": "1",
         "UMask": "0x1f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in E or S-state.",
@@ -101,7 +101,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_ES",
         "PerPkg": "1",
         "UMask": "0x26",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in I-state.",
@@ -109,7 +109,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_I",
         "PerPkg": "1",
         "UMask": "0x28",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in M-state.",
@@ -117,7 +117,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_M",
         "PerPkg": "1",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and found line in MESI-state.",
@@ -125,7 +125,7 @@
         "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_MESI",
         "PerPkg": "1",
         "UMask": "0x2f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction which hits a modified line in some processor core.",
@@ -133,7 +133,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_EVICTION",
         "PerPkg": "1",
         "UMask": "0x88",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "An external snoop hits a modified line in some processor core.",
@@ -141,7 +141,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_EXTERNAL",
         "PerPkg": "1",
         "UMask": "0x28",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due to processor core memory request which hits a modified line in some processor core.",
@@ -149,7 +149,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_XCORE",
         "PerPkg": "1",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction which hits a non-modified line in some processor core.",
@@ -157,7 +157,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_EVICTION",
         "PerPkg": "1",
         "UMask": "0x84",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "An external snoop hits a non-modified line in some processor core.",
@@ -165,7 +165,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_EXTERNAL",
         "PerPkg": "1",
         "UMask": "0x24",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due to processor core memory request which hits a non-modified line in some processor core.",
@@ -173,7 +173,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_XCORE",
         "PerPkg": "1",
         "UMask": "0x44",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
@@ -181,7 +181,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
         "PerPkg": "1",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "An external snoop misses in some processor core.",
@@ -189,7 +189,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EXTERNAL",
         "PerPkg": "1",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due to processor core memory request which misses in some processor core.",
@@ -197,6 +197,6 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE",
         "PerPkg": "1",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-interconnect.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
rename to tools/perf/pmu-events/arch/x86/sandybridge/uncore-interconnect.json
-- 
2.40.0.577.gac1e443424-goog

