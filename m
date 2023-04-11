Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3BFC7619A
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Apr 2023 23:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDKXpG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Apr 2023 19:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDKXpE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Apr 2023 19:45:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D644216
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Apr 2023 16:45:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54ee1fd7876so103956177b3.23
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Apr 2023 16:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681256703;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqBPoR7yC2WC9K+J9X1igm9CprBeNgj2/yZlay6QTRM=;
        b=QUCJXTqDyqtyFgj2kkmJ9kcW+s2Uoz4xNdnUfA6u7s+oyxdPie6RTyfyHRrQ/Vg2Uw
         Dy9G7mph/wMJ14t9dodSFYDAujvA4sSE8qqrkmRkmXl7LrISyFADkPpRsHeKAbrgbOeh
         5rpJ+C+1wl7WsSkNY5siuWvsYba6rQ1rVvZWoFRXfNn0RvoOMyDGmqC0DTiw1GrLN8kJ
         NB4AJaPu7vY3kgVDTobZFm00Lwyd4AjoicQwMb6ardOTtWP+Tn0JCbR6v+STSSTTr1vp
         VD4irqbKQLR3VhaOLYSchLLl4cW2210+kSPvgB2QkfXJifVzsvda5n41TEsPfUba39TI
         4fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681256703;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqBPoR7yC2WC9K+J9X1igm9CprBeNgj2/yZlay6QTRM=;
        b=uOqthY1lOnZOymVPW5zPg7UvWhXZtglaHv+9p8N23SOANWyCBPuPV6ynydRkLv8AGO
         sP9c63yP7Q6uoABck1TBq9WzvS4c38mKYv2cKrRdPfmQy6yE9hLI8O6qgcFY6DHBG6BR
         SdaTTj35NUkJRv/mxUxblAZxx2kl27ZRWUnmfRgUSCKx2LfF+Sp+mySxnz9x9oQzFee8
         K8QCyn2Ru9swD95SjxB+GWbollsrYrhvqiUhJ7trJ2NeSyC9sLVOE9k7D8Eu4VdIZujJ
         2IjMuRvNDubkFaWjuQ7A2X0kS2K4aOnIhzn6iveGjQrXIBSQCneiGs9PokjP/AOKL8UL
         m0uw==
X-Gm-Message-State: AAQBX9dzcTUHjh2R/BNF+ERnocwT+ux0k2LHtouAw+RFNQy/5eDhU5V9
        oh/IrXDxFhwzZziBvxJKPUt9EMzMleY5
X-Google-Smtp-Source: AKy350YT4i/gFFt4h/ZXmy6/dVVhSu6MaYU7giH4teNURs95UM/7QxkZ9FFdCTkNmneDFwVfq4Ftw+Jn0qof
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f663:83e0:f9b2:5a17])
 (user=irogers job=sendgmr) by 2002:a05:690c:730:b0:54f:899f:890f with SMTP id
 bt16-20020a05690c073000b0054f899f890fmr813697ywb.9.1681256703143; Tue, 11 Apr
 2023 16:45:03 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:44:38 -0700
In-Reply-To: <20230411234440.3313680-1-irogers@google.com>
Message-Id: <20230411234440.3313680-2-irogers@google.com>
Mime-Version: 1.0
References: <20230411234440.3313680-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1 1/3] perf vendor events: Update alderlake to v1.20
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update from v1.19 to v1.20 affecting the performance/goldencove
events. Adds cmask=1 for ARITH.IDIV_ACTIVE, and updates event
descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/alderlake/other.json    | 3 ++-
 tools/perf/pmu-events/arch/x86/alderlake/pipeline.json | 4 +++-
 tools/perf/pmu-events/arch/x86/mapfile.csv             | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/perf/pmu-events/arch/x86/alderlake/other.json
index 329c611d7cf7..1db73e020215 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -162,10 +162,11 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "XQ.FULL_CYCLES",
+        "BriefDescription": "Cycles the uncore cannot take further requests",
         "CounterMask": "1",
         "EventCode": "0x2d",
         "EventName": "XQ.FULL_CYCLES",
+        "PublicDescription": "number of cycles when the thread is active and the uncore cannot take any further requests (for example prefetches, loads or stores initiated by the Core that miss the L2 cache).",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
index f848530fbf07..cb5b8611064b 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -31,6 +31,7 @@
     },
     {
         "BriefDescription": "This event counts the cycles the integer divider is busy.",
+        "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
         "SampleAfterValue": "1000003",
@@ -1079,9 +1080,10 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "MISC2_RETIRED.LFENCE",
+        "BriefDescription": "LFENCE instructions retired",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
+        "PublicDescription": "number of LFENCE retired instructions",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 97b3ffc284a6..9e7545d09b23 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.19,alderlake,core
-GenuineIntel-6-BE,v1.19,alderlaken,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.20,alderlake,core
+GenuineIntel-6-BE,v1.20,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v27,broadwell,core
 GenuineIntel-6-56,v9,broadwellde,core
-- 
2.40.0.577.gac1e443424-goog

