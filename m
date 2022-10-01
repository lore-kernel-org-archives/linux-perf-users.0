Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC2C4332F
	for <linux-perf-users@archiver.kernel.org>; Sat,  1 Oct 2022 06:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJAGGs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 1 Oct 2022 02:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJAGGr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 1 Oct 2022 02:06:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BBD1251AE
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Sep 2022 23:06:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3579d28ffd6so9930857b3.18
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Sep 2022 23:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=bSlDDvy7umSAu0bpLEGU6tsn1qiN6maFAz0/dtGy1S0=;
        b=fnDIvUZczAr7Z1Y6TG2yiOr31o50H89ISpQgh/uEsxlmVS5wnUwCgm6Vn0/ExOjuED
         7e/f7AYZJbCg7G6Cb2hfyMe33lqqa3cCGiKDG+IOaukFEuW2RFIgY3Xo//JIgstYagu2
         SNDTzU1alwWRMJd/rBU6z0CKF3lCadMpm/RqRqu4Qif2iSMTycx8JKaFAYFmsLgcNPGT
         g/IQpgyz4DxY7APOtY7p9SQhXDNuB48NzfNQ8CcZKBBEBZ/UYN5KpCcGbdqpRAxGUUzT
         ejU2Gt3B9d7Hq9wglQG5ET35WlC7PzCaSQZANaI6EisukqTb8Gfz4Y/7fStzus6qc5tl
         X/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=bSlDDvy7umSAu0bpLEGU6tsn1qiN6maFAz0/dtGy1S0=;
        b=fqx/TmJjT7UnTnpuKcUUV/YE+9zdW+NWs+Hw8qmKTrDEAHVDiTgHarYPzHnGAGUijH
         cuxeyIusHPuO4Osst+5dpMP6gC0kOpw7rqqHJKsWHsuFvr1DMl8dX/Ivw4dcWviCMywl
         TuvL61JMV5w8UKR2IT/5dzFvjtIxI5dfYPuJrr7/D7OP7Lcyad7ZgMQf+JZGiKcTsdsQ
         TOBam5HVj79o5wuGliKc2s2MvlYMr9KuEKakyTcT2xEILs81waXNnm7JrzWibLVRZFpc
         L4p1gmDzaGV1pug9cCw7Kg3xNkf5NmRv3IlG3sqb4dq0N/wZOn2B7PHx4YTzAe7Wr5cQ
         G71Q==
X-Gm-Message-State: ACrzQf14CVHjhKVxKD2yQdbyuNi4SJE79adlf4W1NOXuGFQdZpRGknWK
        h1NdPwkq3IviUKR7kORxRB7aNoVn520T
X-Google-Smtp-Source: AMsMyM7b0i9jRQi1uSKXZQNpVu8mtF3OIb9XV6eL68bps4RFs7fn3CU67eA1uCxMoJoDaTRWAXfxp/MvxIjo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:de60:c6ac:8491:ce1e])
 (user=irogers job=sendgmr) by 2002:a81:4654:0:b0:353:980:67ad with SMTP id
 t81-20020a814654000000b00353098067admr11207235ywa.204.1664604405297; Fri, 30
 Sep 2022 23:06:45 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:06:15 -0700
In-Reply-To: <20221001060636.2661983-1-irogers@google.com>
Message-Id: <20221001060636.2661983-2-irogers@google.com>
Mime-Version: 1.0
References: <20221001060636.2661983-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v2 01/22] perf expr: Allow a double if expression
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Some TMA metrics have double if expressions like:
( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ) if #core_wide < 1 else ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD
This currently fails to parse as the left hand side if expression needs
to be in parentheses. By allowing the if expression to have a right hand
side that is an if expression we can parse the expression above, with
left to right evaluation order that matches languages like Python.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 4 ++++
 tools/perf/util/expr.y  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 8bd719766814..6512f5e22045 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -95,6 +95,10 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	ret |= test(ctx, "min(1,2) + 1", 2);
 	ret |= test(ctx, "max(1,2) + 1", 3);
 	ret |= test(ctx, "1+1 if 3*4 else 0", 2);
+	ret |= test(ctx, "100 if 1 else 200 if 1 else 300", 100);
+	ret |= test(ctx, "100 if 0 else 200 if 1 else 300", 200);
+	ret |= test(ctx, "100 if 1 else 200 if 0 else 300", 100);
+	ret |= test(ctx, "100 if 0 else 200 if 0 else 300", 300);
 	ret |= test(ctx, "1.1 + 2.1", 3.2);
 	ret |= test(ctx, ".1 + 2.", 2.1);
 	ret |= test(ctx, "d_ratio(1, 2)", 0.5);
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index a30b825adb7b..635e562350c5 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -156,7 +156,7 @@ start: if_expr
 }
 ;
 
-if_expr: expr IF expr ELSE expr
+if_expr: expr IF expr ELSE if_expr
 {
 	if (fpclassify($3.val) == FP_ZERO) {
 		/*
-- 
2.38.0.rc1.362.ged0d419d3c-goog

