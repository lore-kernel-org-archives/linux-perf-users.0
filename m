Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A547DC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Jul 2022 22:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiGGWsf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Jul 2022 18:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbiGGWse (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Jul 2022 18:48:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AAF245
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Jul 2022 15:48:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cbe6ad44fso68231527b3.10
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Jul 2022 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eCmCH4ia+FpOlh6Qbg9jUQqKcntQY3qXlKfzy4/h0lc=;
        b=TN6tkuvWIZfPHJMHNfnojVmKgFrCGV9JCbnlcN1rKkt09Ajuq5uScFkFaRIaUSZ5K2
         fI+Ad47Yaci0VzXw3y8cTK61A5iogaE7BCGDiamC59iVLBrT/YDDJJ4lJZlZtO3SWTbK
         +X2DkVc7jFilCAshlOBA7rYLyOra8AC3Jkwx8xE8uYIZloIg4fyQ12p5WQez6UFbQ7Qp
         bo6Bwl9N3R1w1o+urMfEB/eliWmFTsX7xu0O8klNHk+exLpD45lmt9WDj5gzIGIMtzax
         FqpVTecJ7tvR4y+VZmtEQZZ5xvdJBKmkt7q6dT3rQgmVmORX2CA+5rbC3ExfrujoCb4o
         O86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eCmCH4ia+FpOlh6Qbg9jUQqKcntQY3qXlKfzy4/h0lc=;
        b=C0uVovLYMPA8/mv4TfRO+EfFmiNf/lXCvZJlFTmhvxF6aIPSS2U4ET/H0rCKheJA3U
         qM63KjCkyAlim1WsqpIWyq8p/9F4f9t52ygAsZUK4dzSas1h/9kZ5ih+2VUzRHGHXssv
         edz5YIC6THDseOXrJlD17faTSESttAQsOOOD22mRLtgeypKmElaTEK9e5qMzRWuR1QO4
         7tSov34Jq+nOQgoSmuqJ+GGaMe2dipiqMiYleJKJn5Bqei8zQkt2fyBlaMZme6Ym2AsV
         gyhOEeIZ45gv4Tgs8kQP9HRkMNyX+zEfqLSE9Mv0xqteJFZ01dEXq4vGjwyv5QO5SB+7
         5uww==
X-Gm-Message-State: AJIora/ePWjhQM0Tt4WoIZBCl4MKNrVRlEh+LTskrXMJgpAEO6x7Nm2O
        eIsnnV3wm2EnBvN7XDC8oHISh5Asrw/1
X-Google-Smtp-Source: AGRyM1uMnSSCPUo7n0DmTUbpm1FIc7kPw54Vssxv5GRxmjytG8QzV8DjfLn4ZN+KpK1ndM8pnmztVSn+Omx1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf75:f79:d509:a8d1])
 (user=irogers job=sendgmr) by 2002:a0d:cbd8:0:b0:31d:a46:a1ee with SMTP id
 n207-20020a0dcbd8000000b0031d0a46a1eemr602758ywd.201.1657234112381; Thu, 07
 Jul 2022 15:48:32 -0700 (PDT)
Date:   Thu,  7 Jul 2022 15:48:22 -0700
Message-Id: <20220707224822.420722-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] perf vendor events intel: Synchronize cpuids with 01.org
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reduce rows in mapfile.csv by folding the cpuid regular expressions.
Make the cpuids match mapfile.csv on 01.org:
  https://download.01.org/perfmon/mapfile.csv

Note, this reduces the number of cpuids for icelake while increasing the
number of cpuids for goldmont.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 37 ++++++----------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index f5a382421a60..66dad6947627 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,49 +1,32 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-56,v5,broadwellde,core
-GenuineIntel-6-3D,v17,broadwell,core
-GenuineIntel-6-47,v17,broadwell,core
+GenuineIntel-6-(3D|47),v17,broadwell,core
 GenuineIntel-6-4F,v10,broadwellx,core
-GenuineIntel-6-1C,v4,bonnell,core
-GenuineIntel-6-26,v4,bonnell,core
-GenuineIntel-6-27,v4,bonnell,core
-GenuineIntel-6-36,v4,bonnell,core
-GenuineIntel-6-35,v4,bonnell,core
-GenuineIntel-6-5C,v8,goldmont,core
+GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
+GenuineIntel-6-5[CF],v8,goldmont,core
 GenuineIntel-6-7A,v1,goldmontplus,core
-GenuineIntel-6-3C,v24,haswell,core
-GenuineIntel-6-45,v24,haswell,core
-GenuineIntel-6-46,v24,haswell,core
+GenuineIntel-6-(3C|45|46),v24,haswell,core
 GenuineIntel-6-3F,v17,haswellx,core
 GenuineIntel-6-3A,v18,ivybridge,core
 GenuineIntel-6-3E,v19,ivytown,core
 GenuineIntel-6-2D,v20,jaketown,core
-GenuineIntel-6-57,v9,knightslanding,core
-GenuineIntel-6-85,v9,knightslanding,core
-GenuineIntel-6-1E,v2,nehalemep,core
-GenuineIntel-6-1F,v2,nehalemep,core
-GenuineIntel-6-1A,v2,nehalemep,core
+GenuineIntel-6-(57|85),v9,knightslanding,core
+GenuineIntel-6-1[AEF],v2,nehalemep,core
 GenuineIntel-6-2E,v2,nehalemex,core
-GenuineIntel-6-[4589]E,v24,skylake,core
-GenuineIntel-6-A[56],v24,skylake,core
-GenuineIntel-6-37,v13,silvermont,core
-GenuineIntel-6-4D,v13,silvermont,core
-GenuineIntel-6-4C,v13,silvermont,core
+GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v24,skylake,core
+GenuineIntel-6-(37|4C|4D),v14,silvermont,core
 GenuineIntel-6-2A,v15,sandybridge,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55-[01234],v1,skylakex,core
 GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
-GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-8[CD],v1,tigerlake,core
-GenuineIntel-6-A7,v1,icelake,core
-GenuineIntel-6-6A,v1,icelakex,core
-GenuineIntel-6-6C,v1,icelakex,core
+GenuineIntel-6-6[AC],v1,icelakex,core
 GenuineIntel-6-86,v1,tremontx,core
 GenuineIntel-6-96,v1,elkhartlake,core
-GenuineIntel-6-97,v1,alderlake,core
-GenuineIntel-6-9A,v1,alderlake,core
+GenuineIntel-6-9[7A],v1,alderlake,core
 GenuineIntel-6-8F,v1,sapphirerapids,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-- 
2.37.0.rc0.161.g10f37bed90-goog

