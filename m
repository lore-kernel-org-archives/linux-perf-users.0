Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B7AC636D7
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Feb 2023 05:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjBWFxh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjBWFxf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Feb 2023 00:53:35 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862024A1DD
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2023 21:53:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53700262a47so67786827b3.4
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2023 21:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHV2MWu6hcWn6rb2AA6nCC6xX1C2U+LxMx/784jLbgQ=;
        b=b+sJ4qcNYrXX3lgmlyz7ajioBwI7xUmqQ0p39YD+7sXChu2TyyNWFjBmX4K9fzz7oj
         PNjOx5RHw9LxYTy1kdkoxXh9G1GdybQd0eN0rT7Ip9f+fAYxuS6WrCk8KBq39VaUX5FP
         BTGHXBu1ycoSpDu+VfFY1ufcZBhnqTzbIZPfmnCvxNZfCYPyZcyYdBtj00+O84X+0J6I
         HMpNSyUTXrNp55LHRlJxd6UADKhnw3Gu+PP6cvKwdsHLiYLzpAouhUN+r1zheRBtX0c8
         7jkBk2cMopk4Wz030UDTRY8G788A3VR6AXZXyQOTfPF00rD8TgOwS6kWADDSfiLPDz0P
         XuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHV2MWu6hcWn6rb2AA6nCC6xX1C2U+LxMx/784jLbgQ=;
        b=G+/YCHUmZ3fUAugAFo+7p3hKTbDK7MurAVUi/7X0FGVculEE8DABoZCOH8aLEeuCw6
         UMrde4XKTY2miRC6M2t1gLZi0XgBfHNeI8SDwlQD5qWG5mZA42Tx1ll+dNokPERDeMj4
         SiHkKp1Bsxt4enfnPay4NP9L31Z8TC/hgKUkP2Fu+Pf9CpZ9+MXPtfRC7fSJpVGsuCpN
         i6m8wCBDqZ2qL/u6l6gfqHxLZ5tUE3l6w3laOilEbw5R69v5nhvO7gSqUiBmtXCIBkOz
         PANmnaDW12nySfFgvHIMBQvDGZUqnMlAzTe8fo2ORvoQ37S43GGZmo7WXcoJbzz+blnb
         Bg6w==
X-Gm-Message-State: AO0yUKVB9zLzhcmD7zfCTjGC0XgWDEt1fV1/Esr5jpkl2M+WiwsiNljB
        hPQ06vuUkgJdI9WKU2L4mEFertvZDtNF
X-Google-Smtp-Source: AK7set8sCVMO2ZfpFgOc4CNK1UZmo85h06F0hzI1Lmu31q+Jq7r6ZZvo4+WZAgMEX8QjLocqm6C7ISGbSfC0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9002:67cd:9e6b:7083])
 (user=irogers job=sendgmr) by 2002:a81:ae57:0:b0:52e:b235:cd22 with SMTP id
 g23-20020a81ae57000000b0052eb235cd22mr1696413ywk.8.1677131611611; Wed, 22 Feb
 2023 21:53:31 -0800 (PST)
Date:   Wed, 22 Feb 2023 21:53:04 -0800
In-Reply-To: <20230223055306.296179-1-irogers@google.com>
Message-Id: <20230223055306.296179-2-irogers@google.com>
Mime-Version: 1.0
References: <20230223055306.296179-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 1/3] perf vendor events intel: Update alderlake to v1.19
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update alderlake perf json from v1.18 to v1.19.

Based on:
https://github.com/intel/perfmon/pull/58
perf json files created using:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/alderlake/memory.json   |  8 ++++++++
 tools/perf/pmu-events/arch/x86/alderlake/pipeline.json | 10 ++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv             |  2 +-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
index 37f3d062a788..55827b276e6e 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -24,6 +24,14 @@
         "UMask": "0xf4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a DL1 miss.",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to other block cases.",
         "EventCode": "0x05",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
index 2dba3a115f97..f848530fbf07 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -361,6 +361,16 @@
         "UMask": "0xeb",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Miss-predicted near indirect branch instructions retired (excluding returns)",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PublicDescription": "Counts miss-predicted near indirect branch instructions retired excluding returns. TSX abort is an indirect branch.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of mispredicted near indirect CALL branch instructions retired.",
         "EventCode": "0xc5",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 1c6eef118e61..e69b29123327 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,5 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.18,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.19,alderlake,core
 GenuineIntel-6-BE,v1.18,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
-- 
2.39.2.637.g21b0678d19-goog

