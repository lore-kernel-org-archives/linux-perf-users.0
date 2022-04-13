Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C40C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiDMVIa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238857AbiDMVIS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 17:08:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93F85659
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a16-20020a056902057000b00641c83f82f5so2655970ybt.22
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LyKxohxYFWz+xkAFcBS7lS5LRzEYPlTQWXTfn7sqhYQ=;
        b=Nx7watmXyUrR4GYJ3PPJgGjbxfpPFfxk4xRwtM1yJbXh7/4nevOyjoEREH5PMLV3TC
         Gjyn9uLVONZnYTCGvoGwCoDZxZ2J4nWgjwgLa2BVmgYCXxR55TcMraYg7W3OSsyF6e5y
         pGDBEoZvqxSKFXW4XDREPeEqwKv3HKAQw1JQ1IiBqMwxzCn2B9VAYC4imNDRnr995EnD
         DyQe2XsqSkFTjGb1boEzNKTEUX5mLAXOoGHgV9lr14kk3Tfe4y6Xwkz7xELOO7tLqA2v
         1wU0P2Pzgs4u6pVPzM/HsSMNgAN5xVdSleuRIL7Inua9AzHGjlvGVuVyLRE8k5TOorJv
         0cDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LyKxohxYFWz+xkAFcBS7lS5LRzEYPlTQWXTfn7sqhYQ=;
        b=gWgXGQCNAlgOW6gpNj9HqTj13GKzXUugm/LUvFN+PQslLZZMrMeLzkK3mM+KwfVPna
         XRpZciqoyAHY50qZK3NbjGJ5dgeK0inp/7BemG1DbbJMh+wcYrFih1Y8w21x8ZAkCJcN
         8gh5v0R28s2ppnWBeYDIfbTdyFcX1S8GdqnLtxfWPtRcN7gMMWWEje7T/vFWwYRuFSTA
         C1OTupD0ooo27/f3IpSXIWZL8AXXBXzeupTRRFdMSGscTQMxsiK0QLIO7Wd41tRKhSA/
         Xa6eqqKcLq8Dcj+F4tHBN1uCkJ1bXcrsUpViImlb4anDI6f3nHSyeqcszKoZc+WPR2Mr
         bYlw==
X-Gm-Message-State: AOAM5337dD75DVBjzLBh9Va66Pjm5vg8GM3W4Y+JV0IpfZ6nhnF5+O4b
        b0zWf4IyBmCOAl5anLyAJPtv2EkuNJkD
X-Google-Smtp-Source: ABdhPJyK6Nh2wX2uXt+tJg5ODBuAK9xGSuEdTA8pwtmv0AaWfOjqxjeN6A9lEvHI77IsSxwKp7b69nVXgUWp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a0d:c903:0:b0:2ef:5484:2224 with SMTP id
 l3-20020a0dc903000000b002ef54842224mr728981ywd.365.1649883936638; Wed, 13 Apr
 2022 14:05:36 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:05:02 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-13-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 13/14] perf vendor events intel: Update goldmontplus event topics
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Apply topic updates from:
https://github.com/intel/event-converter-for-linux-perf/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/goldmontplus/other.json          | 37 +------------------
 .../arch/x86/goldmontplus/pipeline.json       | 37 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/other.json b/tools=
/perf/pmu-events/arch/x86/goldmontplus/other.json
index 3378f48cb818..92586fe4538a 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/other.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/other.json
@@ -57,40 +57,5 @@
         "PublicDescription": "Counts hardware interrupts received by the p=
rocessor.",
         "SampleAfterValue": "203",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Unfilled issue slots per cycle",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xCA",
-        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.ANY",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend due to either a full resource  in=
 the backend (RESOURCE_FULL) or due to the processor recovering from some e=
vent (RECOVERY).",
-        "SampleAfterValue": "200003"
-    },
-    {
-        "BriefDescription": "Unfilled issue slots per cycle to recover",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xCA",
-        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RECOVERY",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend because allocation is stalled wai=
ting for a mispredicted jump to retire or other branch-like conditions (e.g=
. the event is relevant during certain microcode flows).   Counts all issue=
 slots blocked while within this window including slots where uops were not=
 available in the Instruction Queue.",
-        "SampleAfterValue": "200003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Unfilled issue slots per cycle because of a f=
ull resource in the backend",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xCA",
-        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RESOURCE_FULL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed because of a full resource in the backend.  Incl=
uding but not limited to resources such as the Re-order Buffer (ROB), reser=
vation stations (RS), load/store buffers, physical registers, or any other =
needed machine resource that is currently unavailable.   Note that uops mus=
t be available for consumption in order for this event to fire.  If a uop i=
s not available (Instruction Queue is empty), this event will not count.",
-        "SampleAfterValue": "200003",
-        "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
index 8305e2ecf617..4d7e3129e5ac 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
@@ -290,6 +290,41 @@
         "PublicDescription": "Counts INST_RETIRED.ANY using the Reduced Sk=
id PEBS feature that reduces the shadow in which events aren't counted allo=
wing for a more unbiased distribution of samples across instructions retire=
d.",
         "SampleAfterValue": "2000003"
     },
+    {
+        "BriefDescription": "Unfilled issue slots per cycle",
+        "CollectPEBSRecord": "1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCA",
+        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.ANY",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend due to either a full resource  in=
 the backend (RESOURCE_FULL) or due to the processor recovering from some e=
vent (RECOVERY).",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Unfilled issue slots per cycle to recover",
+        "CollectPEBSRecord": "1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCA",
+        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RECOVERY",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend because allocation is stalled wai=
ting for a mispredicted jump to retire or other branch-like conditions (e.g=
. the event is relevant during certain microcode flows).   Counts all issue=
 slots blocked while within this window including slots where uops were not=
 available in the Instruction Queue.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Unfilled issue slots per cycle because of a f=
ull resource in the backend",
+        "CollectPEBSRecord": "1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCA",
+        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RESOURCE_FULL",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed because of a full resource in the backend.  Incl=
uding but not limited to resources such as the Re-order Buffer (ROB), reser=
vation stations (RS), load/store buffers, physical registers, or any other =
needed machine resource that is currently unavailable.   Note that uops mus=
t be available for consumption in order for this event to fire.  If a uop i=
s not available (Instruction Queue is empty), this event will not count.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Loads blocked because address has 4k partial =
address false dependence (Precise event capable)",
         "CollectPEBSRecord": "2",
@@ -456,4 +491,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
--=20
2.36.0.rc0.470.gd361397f0d-goog

