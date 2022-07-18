Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91386C43334
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 16:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiGRQnc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiGRQn1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 12:43:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A272B1B0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 09:43:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o85-20020a25d758000000b0067030a2d403so2748929ybg.5
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MeQFhDWhw6uJhVAf4SRwsMvd39/eawx4leroeGONoc8=;
        b=odOfFuywMBJ86ClpGLOJnyTs1vkUPpoBT8uT+btgbpCrf06texWEMIb+CtOWroV+0W
         jyVmCoiMbUMEmOEpds+6GymsbBdkAoIc7IzGTr/dQQRUSNppsMn47MIJFXEzYGV3KyAj
         l8eghn2P4ZbzTQKxBavlZnwAQtb1jf+09PnQ8HgLzETmk3+PwvrQGshHwopIbQJZh/Af
         1aV6H1eiwFxXulYwGJYQkcyO24NMMjsFQaTxgcCy70uCcQGLa1YFdb7TxEkRJeqiM/Pw
         xHq1F5Xd/KHxqxY5D+ywSeT/FVtNgJ39xHZjmMgsB8botISnbTGGfR8IwQJNMjIcB7wk
         veaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MeQFhDWhw6uJhVAf4SRwsMvd39/eawx4leroeGONoc8=;
        b=jlpMlNmA1F0EH4gvRnlqs8jEG6/Q9o4T9prxr/KeGNZdU7IprlO7uX7eVJGqWOb01d
         IJQCOHqjQXamKIL4iUO53XnGfsRYFGsMnHWviBE9vwYrPf/K3TZMpQcbtRIQHq/GpxR/
         7g+eSnUU21QLmJOKGePwtVLbja66BF69ot9BG1HX5q3NQ10DIGL/WHRKt+4y1cI084r4
         Si+MJFgI4cDRA4g1q+YLeTGMX0swpjscQ+YwzRMUOI1Wl1XcVcmOwjY259WwiF58o7t4
         JixzT+iGvjVPYT4Rsvzv+3nsS3avfcvdYCAijl9VD7y0u3WK5J1QQ/gwAKEIUeC52REL
         1/YQ==
X-Gm-Message-State: AJIora8FaGGGI4EX3zjGDDthU4/+Z+a7Iv8Cv87ziyorYDUuT0TokuA7
        VTmctLpGlZzSqXkTKcDtKWIguwReQYb8
X-Google-Smtp-Source: AGRyM1sCFaSaN+OYXwJis87SDXFstBd+j8/M7CzZr1dKfE5Bl/b3JDSsZHKBzslDVbqZbE4BRCTv1jxJVvaJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:922:90e9:167f:1ccd])
 (user=irogers job=sendgmr) by 2002:a25:d00b:0:b0:66e:e393:aa68 with SMTP id
 h11-20020a25d00b000000b0066ee393aa68mr27218620ybg.65.1658162604988; Mon, 18
 Jul 2022 09:43:24 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:43:12 -0700
In-Reply-To: <20220718164312.3994191-1-irogers@google.com>
Message-Id: <20220718164312.3994191-4-irogers@google.com>
Mime-Version: 1.0
References: <20220718164312.3994191-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 3/3] perf test: Add test for #system_tsc_freq in metrics
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The value should be non-zero on Intel while zero on everything else.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 5c0032fe93ae..2efe9e3a63b8 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
 #include "util/expr.h"
+#include "util/header.h"
 #include "util/smt.h"
 #include "tests.h"
+#include <math.h>
 #include <stdlib.h>
 #include <string.h>
 #include <linux/zalloc.h>
@@ -69,6 +71,11 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	double val, num_cpus, num_cores, num_dies, num_packages;
 	int ret;
 	struct expr_parse_ctx *ctx;
+	bool is_intel = false;
+	char buf[128];
+
+	if (!get_cpuid(buf, sizeof(buf)))
+		is_intel = strstr(buf, "Intel") != NULL;
 
 	TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
 
@@ -175,6 +182,12 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	if (num_dies) // Some platforms do not have CPU die support, for example s390
 		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
 
+	TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
+	if (is_intel)
+		TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
+	else
+		TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
+
 	/*
 	 * Source count returns the number of events aggregating in a leader
 	 * event including the leader. Check parsing yields an id.
-- 
2.37.0.170.g444d1eabd0-goog

