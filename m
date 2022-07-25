Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79551C43334
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jul 2022 22:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiGYWlZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbiGYWjn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jul 2022 18:39:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF526104
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 15:38:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31e65a848daso98357927b3.20
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vYop/36g/yykonb5z3RIa4/ddpNbZ9Brm5+6oNXMkfg=;
        b=opgmj/+9iLFe4hb76ppJ35cz4z30LsnCTNZOXTbzOf+9OSwyY17uRHgj5FgcYcHCpM
         X0Dq9M2a1xxxiA3+WY4pI9IBF5H5LIXGOLSCyM+GIDPEk5Th55zaLzN9xQflepdleM3A
         9YzHcJnZp185hZTtYYUYMdmM4+XKGv1stAshSiZAbkAGL4k8HkQNB0/T2nS4zprr+yJG
         /ua9FGXn5EgvXbGlqJorT0g3WrIl5ecp/Mn++G5lACbUX49o4LZdfm+MECTXPGn5A6zj
         gx+GdAcXk6vWvnZOX5KNZSlV96EWkqkpiQHSPr5xBJ2M1vzH8vhNoraA9w+1n+kbE08D
         5haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vYop/36g/yykonb5z3RIa4/ddpNbZ9Brm5+6oNXMkfg=;
        b=ws+oEyqY9+EHWPIF/6kTID54PFGSJY9a+Gv4wHyoY9Pr6HlpwVEB5qX8Dpxzv8t6Cz
         tre4yfI/fkAwrklPBOcSeAQSHE+8Dl90yZDiHel+b7lFoOS77iCSFWaoRNfmA2zqftgV
         fvDWla/M47Mue2yq/diVDQM+QWRtveFEb19Zmx+WVC5J2+Nr7dnRFw41OC4wY7QZVFWt
         blsgcxygTqz9kGnOp2p1U89rBx/1Hg3SppCyMVwBrIIWeJ5ctqzrHsECBb2yqI9iYfzA
         oJcgSQoXYNXH0ail3KF71Mfy7osL+zqd7n11s5kzV5ADjc6BkCATjtw+RAnfl5xDeCek
         JouA==
X-Gm-Message-State: AJIora9vpHfTAd1R0UZ4d1K2HLzlvUk+mrdjVfn9EO2MNiUux6usiRgR
        0DV0sSU8Y4YTm/CmqJpJ7XgOsNhCEvNi
X-Google-Smtp-Source: AGRyM1tkoAYwAco3zWEjJFQMMLL4oKIuWJZ6p/HNurz7GoPqEoiKPKntVF3pB7m2ocpG9YWmzx1zV+lCzKXS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a5b:ad0:0:b0:670:81c5:1b52 with SMTP id
 a16-20020a5b0ad0000000b0067081c51b52mr10490668ybr.20.1658788681556; Mon, 25
 Jul 2022 15:38:01 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:30 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-30-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 29/32] perf vendor events: Update Intel westmereep-sp
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
index ddb504a626d3..4c00b050ebc6 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
-GenuineIntel-6-25,v2,westmereep-sp,core
+GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-86,v1,tremontx,core
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

