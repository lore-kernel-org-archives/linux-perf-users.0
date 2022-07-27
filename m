Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BABC04A68
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Jul 2022 22:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiG0WNm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Jul 2022 18:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiG0WM6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Jul 2022 18:12:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1B1F631
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Jul 2022 15:10:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f99336d8dso884477b3.17
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Jul 2022 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yz1gy8EbEjVfbtq7r9wHKmA+xi2VRHnsF2WGncncbl0=;
        b=IGSWZe2RAvgAI1NC4mgkU2MZnvmxgJfXuEhmZ0AROTHGzGZa+vMfIgPsenQ9mWcAPr
         rpG0flmxraN6c/s3d/ce7E17SABsI08cCZ8UCEO3BqWEszlhyIUXkGtLOWojOJaQFQxR
         YnOhjGm6p/q7MFI6K4nu75A4bthC1JOviRdQ7oDGO6ixzsx60sJj8lL/RTXNUpxTtgIJ
         5RsqVX0fEiPrQ2u8RU4W6lgE3XFnL+indlOECLUEWBTA1o28Rv3vmEXWNVaPr1yZIRdJ
         uIG9RwYtzK5gO6KWicRZAxCb42SwiZj39RNwCGTLgjy23MclpmPF7d9XO1baESGPKjZs
         TsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yz1gy8EbEjVfbtq7r9wHKmA+xi2VRHnsF2WGncncbl0=;
        b=SG4ojD0ukkJRcYRxIH4NW4nkK/OLJsPncNwStWHgrP/qf+0/PolySSf/XHLGoZznPV
         DUgv9XwjMQinn0aI0u98UbVIm+Dc+JupNxmh/guWtk5yTrgtDmPPB1np0mitko1+6jTt
         s3K6ZvFhjyE1zzZgyTocLlb/zDzRo1Bd1m8sr7+M0jAdNcrEx93BnJ/6lkoKfvjYP5Qx
         MmKwPg656WJ90RzY+OVGseFoYka0w3llHYJ7VcoG/c0NzH3AEsx49ecadsDOASYpnga1
         ZNJolh/QZfAYQRwUjR3el0WmOV1bbdtVg1QSbCcR5RXG7Ddo3A0UPHFLVTiGQosfBgDX
         QREw==
X-Gm-Message-State: AJIora+5Ri+FYaD9mcFN6HB9UMTs2CJhOHei4DTnVsDWHq+SfMw8qL1Y
        JOKTu5oe+GS5SqAFHkzEEKQ6WnqkXH0R
X-Google-Smtp-Source: AGRyM1tZw3r+LoZ9vp1HMfOCeMc5Gz/u0tJkxA6KMogkSdr5j077uSGuWTPVPsWiXkeYvqcBfMyJ8h9SNUcf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a25:808c:0:b0:670:7d94:f2a with SMTP id
 n12-20020a25808c000000b006707d940f2amr20208758ybk.452.1658959798783; Wed, 27
 Jul 2022 15:09:58 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:30 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-29-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 28/30] perf vendor events: Update Intel westmereep-sp
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update to v3, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually
copy the westmereep-sp files into perf and update
mapfile.csv. This change just aligns whitespace and updates the
version number.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 .../perf/pmu-events/arch/x86/westmereep-sp/floating-point.json  | 2 +-
 tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json      | 2 +-
 .../perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index b660d3528b7d..d1cabfc62c39 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
-GenuineIntel-6-25,v2,westmereep-sp,core
+GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-86,v1,snowridgex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
index 39af1329224a..666e466d351c 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
@@ -226,4 +226,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
index 8ac5c24888c5..c561ac24d91d 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
@@ -23,4 +23,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
index 0252f77a844b..e7affdf7f41b 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
@@ -146,4 +146,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

