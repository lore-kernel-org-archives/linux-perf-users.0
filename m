Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D99C6FD1C
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Mar 2023 07:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjCXHXu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Mar 2023 03:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCXHX2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Mar 2023 03:23:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB0F12BC9
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 00:23:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y144-20020a253296000000b00b69ce0e6f2dso1062776yby.18
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642588;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVcqhyYrDTRhmMXr68BgAEpfijkgy4ZxPrTLjnvUojY=;
        b=fI6DY7fftrK4CDjqOCOUf6LBkRkeP2fHbjPlyY1yvM4LAd+IbUp0hqliwc4bQZ2Nmt
         xxDWuLjKT1v64wNvaYIk7g3lLpNJgbRbkgMvNObD7G+4aSNo5chMQJkIkxPd4hTIoG9u
         /MM7LGS5cVSKputuP9VNpJwt8B0+YA3Uq3EVw7lrESI24Uese66JEUl2Oy1iAtESD0kE
         HUBmddSMnxSuXikNAvB2VicCBXoH8gcNOFQiHTPw43EESwPHNb9sjJO8xq5qzDEPFw3p
         ixOLoO8fcHxStEcdINhLEECO5NzVxGz6f4ljPK0i8a1T45i3y45BxRpkv/bjQawxJvOo
         kG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642588;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVcqhyYrDTRhmMXr68BgAEpfijkgy4ZxPrTLjnvUojY=;
        b=mI5YN0KbMsKgJnQlrvdqtGhnqura0opppseVwO+n/Bpwmk/++X6+yuJDk+/vvk2nJS
         JRyTMzqi3xvRe5SdFk5zZpJ9xHY+ybPh4cUJAUMUfsdV3E/yVTXl5WXiLRNrj/AC5ZLh
         iZvVqzPmgxN6/4AGKf0hXrEwEnjH923YlyQdNhuqHiGILbOzA9aZLMryUB0OjoXjor6i
         83B8Lihw3PM7OYdCNRweEQYEmUIeuUOFybAlTTCEPGuoaMv8oidC7hORTNq6w1A+o4oC
         KbL1p8Z5tUfrDr/gxofXh0CRtBFALAILkShoB+vaTNS3TosfxbTqgAreqqR3PlzXa1JJ
         JUpA==
X-Gm-Message-State: AAQBX9fU6InVeZbwvrG+yQr0V7K7WDi9fZs+hIgWmaQHqWDiLT78HGrD
        dU1W+//Au7hSNUrGLE01AczLXLp8bNA8
X-Google-Smtp-Source: AKy350aQdjgBBK3I6HLZdx7PxSsAFEo4PuAkDMF/1CGHoRcQVzkQZynrpaFyNvp+Ck00EbPpuNOUH9oN+ji4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a25:840a:0:b0:b26:884:c35e with SMTP id
 u10-20020a25840a000000b00b260884c35emr3215036ybk.4.1679642588800; Fri, 24 Mar
 2023 00:23:08 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:22:13 -0700
In-Reply-To: <20230324072218.181880-1-irogers@google.com>
Message-Id: <20230324072218.181880-5-irogers@google.com>
Mime-Version: 1.0
References: <20230324072218.181880-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 4/9] perf vendor events: Haswell v33 events
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
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Updates descriptions and encodings. Adds BR_MISP_EXEC.INDIRECT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/haswell/cache.json    | 38 +++++++++----------
 .../pmu-events/arch/x86/haswell/memory.json   | 38 +++++++++----------
 .../pmu-events/arch/x86/haswell/pipeline.json |  8 ++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswell/cache.json b/tools/perf/pmu-events/arch/x86/haswell/cache.json
index 5a1489e79859..0831f14b3cc6 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/cache.json
@@ -8,7 +8,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Cycles a demand request was blocked due to Fill Buffers inavailability.",
+        "BriefDescription": "Cycles a demand request was blocked due to Fill Buffers unavailability.",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
@@ -643,7 +643,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch code readshit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts all demand & prefetch code reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -652,7 +652,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch data readshit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "Counts all demand & prefetch data reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -661,7 +661,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch data readshit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts all demand & prefetch data reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -688,7 +688,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all requestshit in the L3",
+        "BriefDescription": "Counts all requests hit in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_REQUESTS.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -697,7 +697,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch RFOshit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "Counts all demand & prefetch RFOs hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -706,7 +706,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch RFOshit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts all demand & prefetch RFOs hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -715,7 +715,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code readshit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "Counts all demand code reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -724,7 +724,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code readshit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts all demand code reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -733,7 +733,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data readshit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "Counts demand data reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -742,7 +742,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data readshit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts demand data reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -751,7 +751,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "Counts all demand data writes (RFOs) hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -760,7 +760,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts all demand data writes (RFOs) hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -769,7 +769,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code readshit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads hit in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -778,7 +778,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data readshit in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads hit in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -787,7 +787,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOshit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs hit in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -796,7 +796,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) code readshit in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only) code reads hit in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -805,7 +805,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data readshit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads hit in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -814,7 +814,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOshit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs hit in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/perf/pmu-events/arch/x86/haswell/memory.json
index 9fb63e1dab08..2fc25e22a42a 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
@@ -179,7 +179,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch code readsmiss in the L3",
+        "BriefDescription": "Counts all demand & prefetch code reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -188,7 +188,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch code readsmiss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch code reads miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -197,7 +197,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch data readsmiss in the L3",
+        "BriefDescription": "Counts all demand & prefetch data reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -206,7 +206,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch data readsmiss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -233,7 +233,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all requestsmiss in the L3",
+        "BriefDescription": "Counts all requests miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_REQUESTS.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -242,7 +242,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch RFOsmiss in the L3",
+        "BriefDescription": "Counts all demand & prefetch RFOs miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -251,7 +251,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch RFOsmiss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch RFOs miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -260,7 +260,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code readsmiss in the L3",
+        "BriefDescription": "Counts all demand code reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -269,7 +269,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code readsmiss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand code reads miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -278,7 +278,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data readsmiss in the L3",
+        "BriefDescription": "Counts demand data reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -287,7 +287,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data readsmiss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts demand data reads miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -296,7 +296,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)miss in the L3",
+        "BriefDescription": "Counts all demand data writes (RFOs) miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -305,7 +305,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs)miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand data writes (RFOs) miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -314,7 +314,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code readsmiss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -323,7 +323,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data readsmiss in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -332,7 +332,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOsmiss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -341,7 +341,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) code readsmiss in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only) code reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -350,7 +350,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data readsmiss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -359,7 +359,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOsmiss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs miss in the L3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
index 9ac36c1c24b6..540f4372623c 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
@@ -194,6 +194,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xc4"
     },
+    {
+        "BriefDescription": "Speculative mispredicted indirect branches",
+        "EventCode": "0x89",
+        "EventName": "BR_MISP_EXEC.INDIRECT",
+        "PublicDescription": "Counts speculatively miss-predicted indirect branches at execution time. Counts for indirect near CALL or JMP instructions (RET excluded).",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
     {
         "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches.",
         "EventCode": "0x89",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index dfed265c95ab..927e60f3417d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -10,7 +10,7 @@ GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
-GenuineIntel-6-(3C|45|46),v32,haswell,core
+GenuineIntel-6-(3C|45|46),v33,haswell,core
 GenuineIntel-6-3F,v26,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
 GenuineIntel-6-6[AC],v1.19,icelakex,core
-- 
2.40.0.348.gf938b09366-goog

