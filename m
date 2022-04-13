Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A666C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 21:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiDMVHl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbiDMVHa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 17:07:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE794CD55
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e642be1a51so26213547b3.21
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4LdCm2LQ8QCCRGCZyoOA7ym+iNo+PUnyUQ+rUu7M50A=;
        b=YfoJJnbg1Nqy29ie3R1xerMB3Px4QxQ0zzwsUMdXr8xyeEAOzqBbtuRqi9KK61Ttfq
         WK7ZOpaL3k+GkRHN1Atov1hd008AutBXq+wzYpcGOS/p+q9w5+CA8w2gkFoUyQm0vlF7
         4kmJ24MlFOGqhmLOacLllLooikJHFrQiS8g1Pf7OEgYQkbqD6p43eRMZrmO2xFW1cIpD
         dqmel/GvrUWjNhL1KxwK4qXty2LJ9x5ucrqF67BNjGyHg424rUZ6FAs2W7Tynnjky5m8
         XLjRU8CD1iFmcZtOGegPskugaCEotq6OECfF7oQlRymN21yA9Q8eDJXQs+KSq5qeETbw
         5YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4LdCm2LQ8QCCRGCZyoOA7ym+iNo+PUnyUQ+rUu7M50A=;
        b=zA4K/tj/e5GmEEM1lLcHALUp50M86gN0uQmzWL68LG56PX0WCti9rlbTTfdEew9k77
         4spHMjtt9VDa7q5MS7XcENeBgRproDvyatA7TtvYlsH3pkyCePEK98QEOHhzcWSWY7b1
         Qm5KvfyUavk4EECiKJtWDx5NVyM0uZcvr0VqeY07vO4ooRPMQL0eSX/6P9ZU87gFOAxI
         BYkUW7qfpl3dJnBmpKFFiJLSPhzfYFNSExTj8dpkJq9BfvasjP9hcqLeFwp9VNSeMGoE
         1ehIGUdVWRLpKpKxWuGhMGf0ZcU722f4h1wcH32kf0egk+g9Swzj58Bvs6BfKAiizBaU
         q1TQ==
X-Gm-Message-State: AOAM5335M+KVFzstUC5YPwXpsHWQvVO5OqbuhWe8tu+S/Nktc3EGDive
        6FLefUQMIZ9tKrCBYxqH19cZOZULClkL
X-Google-Smtp-Source: ABdhPJy98j+Y9ioxho7SxE9VlvWgNuQDW180FjLRq0gjFKBOOy5Sqbq2mrtTxyotwobZ7xF91NafDV+VMPul
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a81:748a:0:b0:2eb:e6c0:981b with SMTP id
 p132-20020a81748a000000b002ebe6c0981bmr707127ywc.71.1649883906883; Wed, 13
 Apr 2022 14:05:06 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:50 -0700
Message-Id: <20220413210503.3256922-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 01/14] perf vendor events intel: Fix icelake cstate metrics
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

Apply cstate fix from:
https://github.com/intel/event-converter-for-linux-perf/
so that metrics for cstates that exist on the particular architecture
are generated. This corrects issues with metric testing.

Also correct topic of ASSISTS.ANY event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/icelake/icl-metrics.json         | 24 ++++++++++++++-----
 .../pmu-events/arch/x86/icelake/other.json    | 14 +----------
 .../pmu-events/arch/x86/icelake/pipeline.json | 14 ++++++++++-
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index 4af23c04dc18..ea73bc1889ba 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -408,12 +408,6 @@
         "MetricGroup": "Branches;OS",
         "MetricName": "IpFarBranch"
     },
-    {
-        "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
-        "MetricGroup": "Power",
-        "MetricName": "C3_Core_Residency"
-    },
     {
         "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
@@ -449,5 +443,23 @@
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C8 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c8\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C8_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C9 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c9\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C9_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C10 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c10\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C10_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/other.json b/tools/perf/pmu-events/arch/x86/icelake/other.json
index 08f6321025e8..2e177f95a9cb 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/other.json
@@ -1,16 +1,4 @@
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
-        "Speculative": "1",
-        "UMask": "0x7"
-    },
     {
         "BriefDescription": "Core cycles where the core was running in a manner where Turbo may be clipped to the Non-AVX turbo schedule.",
         "CollectPEBSRecord": "2",
@@ -407,4 +395,4 @@
         "Speculative": "1",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
index 573ac7ac8879..2b58cfaaaf39 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
@@ -12,6 +12,18 @@
         "Speculative": "1",
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
+        "Speculative": "1",
+        "UMask": "0x7"
+    },
     {
         "BriefDescription": "All branch instructions retired.",
         "CollectPEBSRecord": "2",
@@ -1102,4 +1114,4 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
-- 
2.36.0.rc0.470.gd361397f0d-goog

