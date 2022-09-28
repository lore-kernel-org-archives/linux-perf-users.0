Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C694AC6FA82
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Sep 2022 07:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiI1HW2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Sep 2022 03:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiI1HWO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Sep 2022 03:22:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831AAD4DC1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 00:22:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t6-20020a25b706000000b006b38040b6f7so10589787ybj.6
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=81iZD/KjBhpoeGQ+S/uNTxM+rkrd0csqvOOXWQp9mO4=;
        b=K3aj25mQeCEr67uzUal1vZWSNL6qtA3SQhrPK8U5dF7hwoHRLqnvYRv6mkJz7sptW9
         wYP53BLVqDd5BDYrkADheENe4FDfqyL6Em4XbZ6Jn47U2LekEALv8y73woLiDkf2S5Cn
         H/3TrP4uYNREs6b70Y4XRVrt0O8ld3nOK7QbSI7p3w90Q/vOVEwAUBa7/sPtMXqrfypj
         fcT1vRKaMJunHNFEaClbrljCxMKvZE9qhV4pELO6sazMfNTKkdTdzX3uZ8UQ6yglfcLk
         hBoM2nM5t9gezq8RLq2OkuZK9vXZ3CeCuEDUHunkmL+j1nm+mjZIA+KN5m7hKFAM7Jwj
         hiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=81iZD/KjBhpoeGQ+S/uNTxM+rkrd0csqvOOXWQp9mO4=;
        b=v59Dz6WcJxWysGeVFPRk5NroQS6ephYLK00ONPy5kpqDnoD9X50/awJzkz+WTFeFLn
         AekbySCGIzeMn7mwP6KP89SGzmCtlq1rYP4isjS+fl7zZsfpxNOpcyJaUFoFNlUOxb9d
         1CI2oHicKD64esXUiSM7aUWhR4CB1ienu7jeolb/j7O7AHIly3pfcHNBgWCY4Y6ST9ZN
         eoAm9HAQFg5a7SRWeMeLC3zrXaaclK6e5RtNNhPvF1HwS79av4x/BzYgYN0iBr0tASCb
         KN0jyKdBTiD8VQ6zuaqXTYMUpNBTeJndGFqr7h71YE+hubMbg/ZfRLGBvk4bcok59xbC
         E8lQ==
X-Gm-Message-State: ACrzQf22XveBf679r/R+qlBDolu7uk3PO4pRW3O57QpoEFrJy7qFQe8X
        aUUuoVm9Q8bTrVGfV9kqIo8D1xb8eaX9
X-Google-Smtp-Source: AMsMyM4pWVB4K24YlTjfeGCB3I8vBwx5hoxpcRGrFbJzi+ituvNUwmpKc0ywXnoo/vg6CS0JLNeJ9vPHFilX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7099:1ccb:612a:5ad6])
 (user=irogers job=sendgmr) by 2002:a81:8606:0:b0:349:17ad:6998 with SMTP id
 w6-20020a818606000000b0034917ad6998mr29184875ywf.409.1664349731475; Wed, 28
 Sep 2022 00:22:11 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:21:43 -0700
In-Reply-To: <20220928072204.1613330-1-irogers@google.com>
Message-Id: <20220928072204.1613330-2-irogers@google.com>
Mime-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH v1 01/22] perf expr: Allow a double if expression
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
2.37.3.998.g577e59143f-goog

