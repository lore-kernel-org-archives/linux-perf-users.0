Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9779C04A68
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Jul 2022 22:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiG0WNP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Jul 2022 18:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiG0WMW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Jul 2022 18:12:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5651561712
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Jul 2022 15:10:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so1029507b3.12
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Jul 2022 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5e6HWfs1SkPqYIQUoHpxkfHvDU0TH9v/J1FBs30MsCg=;
        b=dmCKrRvLxDgfDOA7gJDXPRREKyRR+6V8Cpy3dG5OdYlMWRVWzh/iFO6AfDmGLvOW6o
         IhDhhYw1LqXbP22Cf0O1t2Do/clsrR+Iw1f0RyYKXSVwVEHN+fqvNv03wsjCpoq68RUg
         1XoA5MYMoLdfrw9ur7HY1Y17wIRRozzW4h44owbMJpfTcB0eK3ZUxFPNt5WDhyUCVL68
         f521ap9Y0ut3CyDcovudXoH38MTSeqaHtL8eoQOk3X5zSqVnwfXLg3Clx/vznCQo59aU
         kBzCJza6AuRIYPFEi1uso20e57KOsjNnjLU8e4Ocr9R15MVXEbim32t7qWFlxx/zQ/Co
         VCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5e6HWfs1SkPqYIQUoHpxkfHvDU0TH9v/J1FBs30MsCg=;
        b=OECEXFJj4B67n/mq/yLM83zcHFHoXlvgoqcbLlUQx9OXFyP9qb8R9MrvAVNo8SdwXM
         CzxYY0apoqRnkEqtqWecq72d/+i5xiJJ5j1UJcNawtdjT0dU3iboNGwWq/M4BfVqzuai
         6ktQRFpCqXSzcY6oZ3z0q1v7SS0ScjCPtf0U4zaLwj1/ZYMAWa+C8h2n9rnU9Zfk/k5m
         Tq/2dGEpU62fD2HGZTnBYmO41So1j/8az4XDwh2amtNMv2wkqlXbTW2jleQt0LT39Qz3
         tDMimFc1UaP1ZsYmTmnViSpiWqGplkn94s0JQptKGO9cltJaYniky7ZSZ7fwMkSb0CR7
         1LKQ==
X-Gm-Message-State: AJIora8Bq2DZXgelNh01H4JP9N4h+qIFDZGCBA5GVPgqV/K5TJWGb8QZ
        7n9H3Y1qNP8Yd6DEItGMfrdwcZ3ak/8D
X-Google-Smtp-Source: AGRyM1scfzyD/SGvx7bEmSdZVscFfZVfwFGGgNxe3iHhQd2TG/zjQpKe48mhRc1wxSgqYTeL6aurRyGAr1XX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a81:6e02:0:b0:321:cce0:b268 with SMTP id
 j2-20020a816e02000000b00321cce0b268mr1964112ywc.233.1658959785901; Wed, 27
 Jul 2022 15:09:45 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:25 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-24-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 23/30] perf vendor events: Update Intel silvermont
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

Update to v14, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually
copy the silvermont files into perf and update mapfile.csv. Other
than aligning whitespace this change just folds the mapfile.csv
entries for silvertmont onto one line.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                    | 4 +---
 tools/perf/pmu-events/arch/x86/silvermont/cache.json          | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/floating-point.json | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/frontend.json       | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/memory.json         | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/other.json          | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/pipeline.json       | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json | 2 +-
 8 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 317ae526e376..2dc86cf445f9 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,11 +21,9 @@ GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
 GenuineIntel-6-8F,v1.04,sapphirerapids,core
+GenuineIntel-6-(37|4C|4D),v14,silvermont,core
 GenuineIntel-6-[4589]E,v24,skylake,core
 GenuineIntel-6-A[56],v24,skylake,core
-GenuineIntel-6-37,v13,silvermont,core
-GenuineIntel-6-4D,v13,silvermont,core
-GenuineIntel-6-4C,v13,silvermont,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
index e16e1d910e4a..7959504dff29 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
@@ -807,4 +807,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json b/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
index 1d75b35694ac..aa4faf110512 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
@@ -8,4 +8,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
index a4c98e43f677..43e5e48f7212 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
@@ -71,4 +71,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/memory.json b/tools/perf/pmu-events/arch/x86/silvermont/memory.json
index 5e21fc3fd078..0f5fba43da4c 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/memory.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/memory.json
@@ -8,4 +8,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/other.json b/tools/perf/pmu-events/arch/x86/silvermont/other.json
index 16d16a1ce6de..4db59d84c144 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/other.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/other.json
@@ -17,4 +17,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 03a4c7f26698..e42a37eabc17 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -313,4 +313,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
index f4b8a1ef48f6..b50cee3a5e4c 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
@@ -66,4 +66,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x3"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

