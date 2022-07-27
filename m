Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C437C19F29
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Jul 2022 22:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiG0WNQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Jul 2022 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiG0WMW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Jul 2022 18:12:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6AD5B79A
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Jul 2022 15:10:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f4450c963so846057b3.19
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Jul 2022 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=87sPwrNgU9fIYpw51R27PyjDlhyY+6EtKzuI5rnAQnw=;
        b=Yg5w/9Lf2bKsNEn6dR+itn8JolDGGgtzkV78Ai4+nZFuDW+GsT4u2H1QhLuroVKI9S
         w2pT8d2grJpfXHIok8oLRqeWQRumFiKrvV9YZvZ2+g7sBU3S9AXYu7XzVLP4GxFUw5MQ
         1TBsBVQtU9SvQ3tJQp4Nx8oRERIsIss3U8Spo74pRAqjddukXQkTFdgiVZAo0Ht6wdNh
         Xl2j+mBgxA80nKt4CqlQfT1NZQqw8jSPj28v15aiZ+14bHG3uvvC5bSYibz2Ny/0Kbr0
         ebQQHhiotpJc9H7/fBXIy2su5bQuGLC4H3VTmL4W5aKNtzTqATY5fWv5GEeeg1vv1X2A
         BlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=87sPwrNgU9fIYpw51R27PyjDlhyY+6EtKzuI5rnAQnw=;
        b=s94R/lseUnU911bkh7yIwclId1pszXv6tmym35jTd881ZwnygodhtaCUM0cB9cXK0M
         5wK29PQ/EGE/xkz+uNtlXfkVI74nZPpdbsNb/gU87rA1p6Cu/C7BIP0JIFt0jlYaxO/T
         f/KFFTXivkI2hLeyyzneZHipHNNorXGB7GuNx3qRSIejV2J6n/OI78hHR7W3lJf0761g
         wkkHgpI/qG5PQuSZv2MPMbCrqgCmGRhZB6pNmPwAlUPEBf8oBaUTVl0RvoMUcq3Rt2yo
         QKFeV/904R2IWv8yD89Q2yi4e3Uba/ltB8LfuIBT1RWxwvnwn8eemWe0DSaDzD/hRBkz
         ninA==
X-Gm-Message-State: AJIora+2uacj3PUCXPHPk7/DLTWLR0Ozy1JudwuLyc1iLVNTCuS2pu8r
        j/4bLSl6+wXeMnFbT2iNQG28oAjBbxJj
X-Google-Smtp-Source: AGRyM1sKDjiKi3VKXopuglig5IOdzdgxi2pcpxKfvIMJfPtofBN2ta/UhQBZ6aiJFi4j1s57winwuHxk7EWc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a25:504c:0:b0:671:794d:5171 with SMTP id
 e73-20020a25504c000000b00671794d5171mr6934452ybb.231.1658959800966; Wed, 27
 Jul 2022 15:10:00 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:31 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-30-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 29/30] perf vendor events: Update Intel westmereex
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
copy the westmereex files into perf and update mapfile.csv. This
change just aligns whitespace and updates the version number.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                    | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/floating-point.json | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/frontend.json       | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index d1cabfc62c39..c607f4155556 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -27,7 +27,7 @@ GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
-GenuineIntel-6-2F,v2,westmereex,core
+GenuineIntel-6-2F,v3,westmereex,core
 GenuineIntel-6-86,v1,snowridgex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
index 39af1329224a..666e466d351c 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
@@ -226,4 +226,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/frontend.json b/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
index 8ac5c24888c5..c561ac24d91d 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
@@ -23,4 +23,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
index 5d1e017d1261..0c3501e6e5a3 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
@@ -170,4 +170,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

