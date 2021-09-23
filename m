Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CE2C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C546103D
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbhIWHtD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbhIWHss (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:48 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F436C0613E0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:47:04 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id ay30-20020a05620a179e00b00433294fbf97so18355991qkb.3
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OeMpvyKl7P/ipTaCbZYqVisxKEPZKA1+DjWnnvb47oE=;
        b=FslGWlrcWp1MT9ERUlzFCQ5CfmGPR9i70efH1iWp7R0SsO6F9T1NHoh42CUayIjJUd
         AnTOSw4nmD6Z6VR9y+m684+TBOz8czSM23Hj8b8lp1Hfu9vfDFPCdK83Mef9gcGTDM8I
         B4UXVtmoz2VkmjfO5nUBJsNm/b4CRdyew84n6OrFoaOou0M4+iTxSiejPcDrJYXEy/lu
         iXP1GCXSt2V5K1mmwtXbJ5lx8SR0H0+dw9VJg8vtaPOE434lxzwGBPnEY24har83maR4
         5104h5bDstjKGOXZcf/HnJo2ffm6dSttBbQspM3T7gxY6Jgu9jmQyNN1pBo53/tbWIAd
         lJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OeMpvyKl7P/ipTaCbZYqVisxKEPZKA1+DjWnnvb47oE=;
        b=r7Z40WaGZHyTbSKcRVv0YGThK6MIdd/UMw3KWWpHF9NOU46YcQMooaMmgnS6ZS02v7
         LutcwvNY9VTpJkXhd94rm+mX6HenmLZhnvY8vl1/GmScKiTVhFV4oP5FCPC/pXUzaJrE
         PIViJDXreSSGJf3M6ejq2mtMS2OYic+YHkQifVec8cPlvDtmP1Hlvvv7sLDVg+XERQNA
         QVNwZjWOX0CWVNT9fqgH4JCk+hVv0JYKFU+I034wB1RHCJ4DdMTjAWFOcv3MRWiPK9+8
         3c8BY7lN7of5xTvJN3mSRZoAW6ovwLbGz+c4ogZaA7Ez1r7MM6uBc9DRFlFA4Klg0D4n
         CK3Q==
X-Gm-Message-State: AOAM532DFqFJPQzsisN7Of/RRVQIrdKmXvNOBjPJvpO9Nl+aJZriPipT
        rYEEnvjr9cHh6PTgHXxASE7D7pPB5P0w
X-Google-Smtp-Source: ABdhPJwgy0fKe6rRamC9LrEXa9yfbr9dD246r8dkCcXImMG/eVORZoDH4py7245oRHsAgaVGWOsnkeZ7OX7g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:2485:: with SMTP id
 k127mr4067726ybk.71.1632383223132; Thu, 23 Sep 2021 00:47:03 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:15 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-13-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 12/13] perf metric: Don't compute unused events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For a metric like:
  EVENT1 if #smt_on else EVENT2

currently EVENT1 and EVENT2 will be measured and then when the metric is
reported EVENT1 or EVENT2 will be printed depending on the value from
smt_on() during the expr parsing. Computing both events is unnecessary and
can lead to multiplexing as discussed in this thread:
https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/

If the input is constant to certain operators like:
 IDS1 if CONST else IDS2
then the result will be either IDS1 or IDS2 depending on CONST (which
may be evaluated from an entire expression), and so IDS1 or IDS2 may
be discarded avoiding events from being programmed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 11 +++++++++++
 tools/perf/util/expr.y  | 30 +++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 1c881bea7fca..287989321d2a 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
 #include "util/expr.h"
+#include "util/smt.h"
 #include "tests.h"
 #include <stdlib.h>
 #include <string.h>
@@ -132,6 +133,16 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3/",
 						    (void **)&val_ptr));
 
+	/* Only EVENT1 or EVENT2 need be measured depending on the value of smt_on. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 if #smt_on else EVENT2",
+				NULL, ctx, 0) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
+						  smt_on() ? "EVENT1" : "EVENT2",
+						  (void **)&val_ptr));
+
 	expr__ctx_free(ctx);
 
 	return 0;
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 5a295e385914..5b878f044f22 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -123,14 +123,30 @@ start: if_expr
 
 if_expr: expr IF expr ELSE expr
 {
-	if (!compute_ids) {
-		$$.ids = NULL;
-		if (fpclassify($3.val) == FP_ZERO) {
-			$$.val = $5.val;
-		} else {
-			$$.val = $1.val;
-		}
+	if (fpclassify($3.val) == FP_ZERO) {
+		/*
+		 * The IF expression evaluated to 0 so treat as false, take the
+		 * ELSE and discard everything else.
+		 */
+		$$.val = $5.val;
+		$$.ids = $5.ids;
+		ids__free($1.ids);
+		ids__free($3.ids);
+	} else if (!compute_ids || is_const($3.val)) {
+		/*
+		 * If ids aren't computed then treat the expression as true. If
+		 * ids are being computed and the IF expr is a non-zero
+		 * constant, then also evaluate the true case.
+		 */
+		$$.val = $1.val;
+		$$.ids = $1.ids;
+		ids__free($3.ids);
+		ids__free($5.ids);
 	} else {
+		/*
+		 * Value is either the LHS or RHS and we need the IF expression
+		 * to compute it.
+		 */
 		$$ = union_expr($1, union_expr($3, $5));
 	}
 }
-- 
2.33.0.464.g1972c5931b-goog

