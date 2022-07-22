Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FE2C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jul 2022 22:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiGVWhd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Jul 2022 18:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbiGVWgN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Jul 2022 18:36:13 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C0BDA37
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jul 2022 15:34:24 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id q11-20020a170902dacb00b0016d4c2dd526so421114plx.5
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jul 2022 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=niYjR10/BhMIcv0gsSNj+DgvyhJEOfnS4U+KARHTSeI=;
        b=Oqac9WHPfYz4h7eLQ4kOuvSc61LihUKNbtqjdLirXFp6Ky6uuS1jjIj4mq3MmTgjZ+
         WFHHUlOfGckc5DSYiRncT+6SE34VevxBJJXBru+vwNsirvDK60XTOxCq+vdoY2nqxNyW
         xuMWsPVplD3C36pS3MKGDatjYXEZ+geE9lwlOkAU6ZfPFDacKx9h4qCFqoM8YA/c6hK0
         pk5cJerd0DDXjCFN9vH9vzmhiaQHJ3mnQMAYF1+XNWp9PZthdO6KNEWxYsu59Qqr7vXx
         BZnyWb0PLiGuhKLM00xCRlXABZdK2q1V9ZSJEsxrs9WYFeBh6/qK7qvlA1HuBEsXbbYE
         zWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=niYjR10/BhMIcv0gsSNj+DgvyhJEOfnS4U+KARHTSeI=;
        b=ZVZpyQKGkehWW9jhC+gvmccPoSVNO/vxzdoYF5dMp7zyFzwP8HSIY8bjPzkBkoLuCm
         4BIgoHUKuT+3m2uYrQLgFUPIZ9db8kaXEvLW3udvTKJkSV3BDWt1w2fxFDLuH7pmBXLW
         0uBg+B3Qok0Z45FQf5d02bv2bfGPVKH/7v1LGuLIfw7rkDO6R+AP61Z6D4bAamGxrfJI
         e6nfvkwOIi2xHYp0hGZ4mm3wQp7kf9adX8i8ZdXBKTsk5x0K0k3kYdFhpiUsxgj35ipR
         J/FPmP4R6kU/H4FxoyIZdVg9yoMsegJy7S6j8Dw3XWgDLvP41mE3KDyIx8Kb2J7jAPSe
         Mkjg==
X-Gm-Message-State: AJIora+pB589ci2QJ6zFeCXj2hVJYkFzEUzcZ8n0mef50Y2jqwj8dnwO
        3DxBXEGt3Bi0g8bBeFr1sOLejq293cXz
X-Google-Smtp-Source: AGRyM1tTZenrS04PABlR1rt9udJd2TiTHrSsUVwxGPtq5SqjmBVXCx3kXnzSPeJFj4IeSoHelO5DeTJeMOQ6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a17:90b:38cd:b0:1ef:b4c2:3624 with SMTP id
 nn13-20020a17090b38cd00b001efb4c23624mr19991792pjb.168.1658529250823; Fri, 22
 Jul 2022 15:34:10 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:39 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-31-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 30/31] perf vendor events: Update Intel westmereep-sp
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
index f63e97c57dd8..f0155639c22d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -27,7 +27,7 @@ GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-86,v1.20,snowridgex,core
 GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
-GenuineIntel-6-25,v2,westmereep-sp,core
+GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
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

