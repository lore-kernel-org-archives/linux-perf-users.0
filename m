Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5FAC74A5B
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Mar 2023 22:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCVWiO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Mar 2023 18:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCVWiN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2023 18:38:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F058A54
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 15:38:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a250fd5000000b00b6d6655dc35so9497734ybp.6
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679524691;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rqcDRoMmYWeX5NDcnteKgJKe46jiDR0Hq2pE99Nt0ww=;
        b=WNdHqK2ezirDAb0xAE0C9JaLRQFlmz/0jo1AbIqlHcKU+QbXbN7iPnnewB1hCAgQQl
         YtqMFZHEYq9uNtHssT8nS7kIf7CboYGpQsYU7gDwFWhYUv4TCkg62g9yC20aotFbbGFq
         qcXrJqwS/ELMb31NkeYdKBBNMImoN4uipAnd/x/H+wYSpnOAzsTacGAXtHn/WvRcszCO
         Co9TlKo6S1Hm87ucMrK+YShgsULf1glVle8A7YVUzvwVlx9D7LV/0WiK9OradqC+BwZs
         ozQHi/m8jB1UYrA2DyaRB9DSc791dUcOsUlJi0J0q2r43au1bKDaCOu95L553/JBn8lu
         vPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679524691;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqcDRoMmYWeX5NDcnteKgJKe46jiDR0Hq2pE99Nt0ww=;
        b=5IUczNb1dOnOjpER0c7UlbuaDnA3O129DjjEDKpPrFxAHOp8E4HjBnx3LShenzbAbH
         mmoqE+SvgRrAFaE07cQZgWo29FM/SnMoPVgK3UjP14X5DLU6y0Dbs4b14/MjJKdfWEDk
         DGEojxmdY+CYBFdluk7IXFQ73R0rTGp5eQvpI/Cd8LSKIaZYRAG4uMYf+iqkPcoXvKGd
         WlsagW5yi8wPdvRfTy46hy8kT6aPuku4BowO0WnVQX7U1cVASX3XYG5IYDBD4WiCPCay
         T+3Q7zie+Kw7+KevFGbTg7wCuO6+sh3k3FwfcE6jcO2PI5hbQzTXVK0jqdlDW/6y+ozz
         naLA==
X-Gm-Message-State: AAQBX9dxOp6YjUhMxerJ6NHcfMKoxBDgeWXUZp3T7oRt0vJGLJ/A9x/h
        58uWLzGZ0bPbeRgB7QgPTFTobCMGJPYJ
X-Google-Smtp-Source: AKy350bqzs2DPjWTDSqVSMPj5xs0NJwaS3gGgcdCAB0OMu8A9/js0MRcvymsbOdNeWS3WezH3mn0FqpXIKn6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6fe2:153b:3323:a17])
 (user=irogers job=sendgmr) by 2002:a05:6902:70a:b0:b21:5fb4:c6e6 with SMTP id
 k10-20020a056902070a00b00b215fb4c6e6mr841255ybt.11.1679524691640; Wed, 22 Mar
 2023 15:38:11 -0700 (PDT)
Date:   Wed, 22 Mar 2023 15:38:01 -0700
Message-Id: <20230322223801.1451827-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH] perf vendor events: Sandybridge and version number minor updates
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
        Edward Baker <edward.baker@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add BR_MISP_EXEC.INDIRECT to Sandybridge. Update version numbers based on:
https://github.com/intel/perfmon/pull/62
which didn't modify the generated perf json.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv         | 14 +++++++-------
 .../pmu-events/arch/x86/sandybridge/pipeline.json  |  8 ++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 9abebe50ae0d..41d755d570e6 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -2,26 +2,26 @@ Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.19,alderlake,core
 GenuineIntel-6-BE,v1.19,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
-GenuineIntel-6-(3D|47),v26,broadwell,core
-GenuineIntel-6-56,v7,broadwellde,core
-GenuineIntel-6-4F,v19,broadwellx,core
+GenuineIntel-6-(3D|47),v27,broadwell,core
+GenuineIntel-6-56,v9,broadwellde,core
+GenuineIntel-6-4F,v20,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.17,cascadelakex,core
 GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
-GenuineIntel-6-(3C|45|46),v32,haswell,core
-GenuineIntel-6-3F,v26,haswellx,core
+GenuineIntel-6-(3C|45|46),v33,haswell,core
+GenuineIntel-6-3F,v27,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
 GenuineIntel-6-6[AC],v1.19,icelakex,core
 GenuineIntel-6-3A,v23,ivybridge,core
 GenuineIntel-6-3E,v22,ivytown,core
-GenuineIntel-6-2D,v22,jaketown,core
+GenuineIntel-6-2D,v23,jaketown,core
 GenuineIntel-6-(57|85),v10,knightslanding,core
 GenuineIntel-6-A[AC],v1.01,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
-GenuineIntel-6-2A,v18,sandybridge,core
+GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-(8F|CF),v1.11,sapphirerapids,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v55,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
index 54454e5e262c..ecaf94ccc9c7 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
@@ -210,6 +210,14 @@
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
-- 
2.40.0.rc1.284.g88254d51c5-goog

