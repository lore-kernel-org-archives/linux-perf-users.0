Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E45C6FD18
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Mar 2023 23:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjC1XmC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Mar 2023 19:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC1XmC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Mar 2023 19:42:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E212724
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Mar 2023 16:41:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5419fb7d6c7so136252557b3.11
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Mar 2023 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680046916;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/SOJzwszuK4oXlHtoTT/8rLoX+FLi6BZsrzcBCEAsAI=;
        b=XsmKZlCFkNQsFlUwJu6hXd5IS6qS1B/ZMp6kn/1IDeJ7CZVUm1LwibD6gkVVl2F9fe
         Gc7Gdih33kyxSxvuw1SdMHS8knhZVJ6jx2rAS5qloJkHRa70HYTQ8yDACXj7J4mSE+B3
         WPFBSnNT2t8t3fY6QmIzYNQY6NjjXF4RZZa3WGoBQNAnL07e727AsjE3KVd8Q16SMXLq
         G+h80/Es90S+Wen7zqYABysuKe5A3uUpWyuOjeTX+M1RaTb1r4kmgHKjLK2Umv5Fycgi
         PD5KNVbfvkFejqGPxA832UlTr4zbDyRGPJn/Fukwsds52dl8XPvf/3w/I1GbTQkg5a+Q
         ztFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680046916;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SOJzwszuK4oXlHtoTT/8rLoX+FLi6BZsrzcBCEAsAI=;
        b=ocPbMFfVd7NOWVeLLlBFfPBGmOoC+6AEoJ1BnnVabDPOLftC7jCkT5b+g7cU0oByGQ
         CgRDusPdLRqxBra2zmB02I/JCRDGnEVUtNO0mgXCKAvNb7nrFwELAC0TUCcRFtVcjVOk
         IAnsDZf/3sLH1EoEJrAS/RkzOw3x5HK+9xyWyMIiHWUod+S7vEAF+f+Bf3wBWPyM7nl6
         WHnybMI6b9J/kKM056eKTeLxdv9Reb9Bt+ol0lGfAYSI8QOtVcFH5zIogDnotEiXgAYZ
         a0Z7E5D7MqMbn8hmMSBUDBgmla9Rqar4d9fUMmDkTHTs1IfEe1cpLXs8371zHMEqNktP
         Iwbg==
X-Gm-Message-State: AAQBX9dzzE5sGmcVGoCl1tqErXQz23ypTnWdyzIk2p5zuvCapgyn4QY4
        P5oAIYIyWtpDZyAB0GaKE9nZdqFpLmmv
X-Google-Smtp-Source: AKy350Y6rfpfUk90+x61rAFYwxjj4dzqwGEWuwh63ONPFHCeJrWJH8BFOkPPu5uiEBUywjbzS3P1aMBiH6FG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6519:f0d3:9540:5c31])
 (user=irogers job=sendgmr) by 2002:a05:6902:18cd:b0:b78:45fd:5f01 with SMTP
 id ck13-20020a05690218cd00b00b7845fd5f01mr10193380ybb.7.1680046915938; Tue,
 28 Mar 2023 16:41:55 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:41:42 -0700
Message-Id: <20230328234142.1080045-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1] perf vendor events intel: Update ivybridge and ivytown
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

Update to versions 24 and 23 respectively. Adds the event
BR_MISP_EXEC.INDIRECT.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json | 8 ++++++++
 tools/perf/pmu-events/arch/x86/ivytown/pipeline.json   | 8 ++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv             | 4 ++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
index d1e64e0d683e..30a3da9cd22b 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
@@ -215,6 +215,14 @@
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
         "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches",
         "EventCode": "0x89",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
index d1e64e0d683e..30a3da9cd22b 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
@@ -215,6 +215,14 @@
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
         "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches",
         "EventCode": "0x89",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 41d755d570e6..97b3ffc284a6 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -14,8 +14,8 @@ GenuineIntel-6-(3C|45|46),v33,haswell,core
 GenuineIntel-6-3F,v27,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
 GenuineIntel-6-6[AC],v1.19,icelakex,core
-GenuineIntel-6-3A,v23,ivybridge,core
-GenuineIntel-6-3E,v22,ivytown,core
+GenuineIntel-6-3A,v24,ivybridge,core
+GenuineIntel-6-3E,v23,ivytown,core
 GenuineIntel-6-2D,v23,jaketown,core
 GenuineIntel-6-(57|85),v10,knightslanding,core
 GenuineIntel-6-A[AC],v1.01,meteorlake,core
-- 
2.40.0.348.gf938b09366-goog

