Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D71C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAA261019
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbhIWHsO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 03:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbhIWHsL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:11 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D2FC061756
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:40 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r11-20020ac86d2b000000b002a688ea1f4bso16345689qtu.5
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0X+bRUj0ZqyVq9AjBewJSvN4Dct/DQ49eGdrq3G0ots=;
        b=f64qiW4sLGFTJCjmROAwqLNrF8ScIgWzcEMjevIjuuIu0L7GU8xz39XOY86aami4T7
         OwliwH4aL8ysE9bG68d/2vjS//FBViqBN58jMpKte/RJK2Rhq5tk7mShuQP7OgFHIZXk
         Zfbvg/vPnlcyczJxyhrgJv9GE9PM+h8V7qZlsVRRIfSgAec3Rnj5J2qn67EdwRhQU2Xm
         B2FY0o5u4rR/vOt6Wy77QzFZ2OOreoVkiPPMBFYktSTl06AGrPAS9zXlwfJEocdQOfqj
         /EIAHBOmW0XS/0LO8/xE/1BVqsOyKi6PjQWbWUtzv+mw5miKH3fCZ631jnkvV3EXQAaC
         guRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0X+bRUj0ZqyVq9AjBewJSvN4Dct/DQ49eGdrq3G0ots=;
        b=pXGIL85xWu6HceegShEi61KcHkMSsSkaZX6E99PQUBD7m74Qolo286LaITeRwIaY/e
         otH4PmFK/oW20sXNPKSWGeJM8mZEoUj54yiZaA3VlAEKCcbRjDWg8KB5UeJDgmdilkFJ
         WIWFiRntU5nrJqTJv1GtpORHAlNGV6S+LAp9noe8G4ooKm7NWBzAbmRYTTc8HyRuZUlE
         wQ2oIAPNdmmcc5SVX1HgsgsChVAFCNGzk+czzSX0UyQDhgM6WhNhM2EUi+swWJIKO2iK
         IUN6iitQs9i7P9TGPTMQdQNjegVmNKHz39F0RNPJPQJHWTMpvV17sZiAntM34lFwWr4d
         zZwA==
X-Gm-Message-State: AOAM531GBQrjPkYi0/CoMZeiIgyzSQkZBDwZ4y18Yk5OcsDolq9DYetE
        vJWraVNK3LG8t+G+jKT5G68tUeSUiC8+
X-Google-Smtp-Source: ABdhPJxI0faKprRZhdAuhU/Eybqorf8n6chKR04LikVRp9QhpULPNW75ezb1U/IwYQxtU5amjbaVu55x8QSL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:9941:: with SMTP id
 n1mr3997064ybo.247.1632383199627; Thu, 23 Sep 2021 00:46:39 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:05 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-3-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 02/13] perf metric: Use NAN for missing event IDs.
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

If during computing a metric an event (id) is missing the parsing
aborts. A later patch will make it so that events that aren't used in
the output are deliberately omitted, in which case we don't want the
abort. Modify the missing ID case to report NAN for these cases.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index b2ada8f8309a..41c9cd4efadd 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,6 +1,7 @@
 /* Simple expression parser */
 %{
 #define YYDEBUG 1
+#include <math.h>
 #include <stdio.h>
 #include "util.h"
 #include "util/debug.h"
@@ -88,12 +89,10 @@ expr:	  NUMBER
 	| ID			{
 					struct expr_id_data *data;
 
-					if (expr__resolve_id(ctx, $1, &data)) {
-						free($1);
-						YYABORT;
-					}
+					$$ = NAN;
+					if (expr__resolve_id(ctx, $1, &data) == 0)
+						$$ = expr_id_data__value(data);
 
-					$$ = expr_id_data__value(data);
 					free($1);
 				}
 	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
-- 
2.33.0.464.g1972c5931b-goog

