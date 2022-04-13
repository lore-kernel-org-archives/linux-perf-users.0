Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B498C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 21:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiDMVHq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbiDMVHo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 17:07:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B7E62BFB
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ebfdbe01f6so26563827b3.10
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BiA1gzDs+n6vDGSyDdWYoxAvlHWpcqRt9LMJt+dwRlo=;
        b=cT2sTaIMVLOPT74kFGHktC+icBAQMMitYlHTnse3U0c8GPNYtmaFOykm5+dUsmQk1o
         E7ByyhyM2T+vI7F5+EbwtBDfslNdd/O/14Pb6bFQKCHqim9WuB/w2GJyOMSnjEd2xmFn
         4z4Q4ivCrWe9efPlC4D91uOSeSKfetscyDVsxBddKBr2+EFLBa9o1/GxUsjYY+dXzb5s
         Qv1fV0+t4V2RVDV1AhoiVUP8IuCgSYsPqceefoAO1k6XFDp6yJAMjuPP64yXaNZiNRRL
         80/8Iv3K0wFx7DKw1Zg51uz2QpxX0zEAUnNHH0/Yqhe4DazToBI5KO6YdY/qEWpRL1Jq
         8F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BiA1gzDs+n6vDGSyDdWYoxAvlHWpcqRt9LMJt+dwRlo=;
        b=ZN54X8mhslk5fAzXtEHNHt06wNnwwUaxDvP5zVDAOTSqfma5afI7X5Cc5HO4QdXz83
         BGw+DBxXNX2ySNrtgg7oRvXIoqAvhXr9rL+3mchQuSKX4a9oOaTnwB1jEWjqhD7suT3k
         FRLCzRq07IAjBjFjzUfsIRskl1XKm6GCSzME2CtnV3gm1/2ivzZfYjRydFCyBKfxwTlm
         6Sso6+Qm3iVOJrwevX8JrkArZTi4SzgImZV4tv4XD1tlWGO7SGr0PJZO9WOdpGzYO0Ty
         Pka1uEWZECQXJyRicTJMEDPb5aMa6xpc3k0k/Zjb0LoDG5tWz4Xt8/XsqTxdz9enbUs2
         vFaQ==
X-Gm-Message-State: AOAM531LawDlpNhQ70bCG/AIMcNzaYr7b4cQG07GrYPlcu3pmd9fGYIp
        hKjrLVsyvPJqj9rvDQq1C/0Mx4ZQDXsD
X-Google-Smtp-Source: ABdhPJwFBPwtEJ8LO4FnVSBHwBt8py7IEeV5kyVlIQSaAejZD+dkyKK7myVE9f6n8ZG1QrPX7ZylSPzEvt/U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a5b:8c8:0:b0:641:e8de:a6f4 with SMTP id
 w8-20020a5b08c8000000b00641e8dea6f4mr667192ybq.533.1649883921739; Wed, 13 Apr
 2022 14:05:21 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:56 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-7-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 07/14] perf vendor events intel: Update tigerlake topic
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

Update the topic of ASSISTS.ANY as per:
https://github.com/intel/event-converter-for-linux-perf/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/tigerlake/other.json | 13 +------------
 .../pmu-events/arch/x86/tigerlake/pipeline.json     | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/other.json b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
index 304cd09fe159..65539490e18f 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
@@ -1,15 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xc1",
-        "EventName": "ASSISTS.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "Counts the number of occurrences where a microcode assist is invoked by hardware Examples include AD (page Access Dirty), FP and AVX related assists.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x7"
-    },
     {
         "BriefDescription": "Core cycles where the core was running in a manner where Turbo may be clipped to the Non-AVX turbo schedule.",
         "CollectPEBSRecord": "2",
@@ -57,4 +46,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
index d436775c80db..a8aa1b455c77 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
@@ -11,6 +11,17 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
+    {
+        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.ANY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of occurrences where a microcode assist is invoked by hardware Examples include AD (page Access Dirty), FP and AVX related assists.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x7"
+    },
     {
         "BriefDescription": "All branch instructions retired.",
         "CollectPEBSRecord": "2",
@@ -1055,4 +1066,4 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
-- 
2.36.0.rc0.470.gd361397f0d-goog

