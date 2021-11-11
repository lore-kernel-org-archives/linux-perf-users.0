Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8738C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF06961502
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhKKAYi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhKKAY0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408FAC06120B
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so6759082ybj.5
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w9hyMELVK5RajRlcXxABefy1CjWCBZ8xUiCsBp5TLFg=;
        b=JontxKB2TOFbiUG+TGdXP7SsS4dJ8hBxMYkiTFUuUW8g98126ot7Lp23TVDK7XOTWa
         P42//RXgGhR6rWPSHbqOP12RndI5OxEdUZ9gX1ZDa3VhwRkaA04gyUQrNOCaIzLjB7Cv
         luKbL2pbIn1zx46fKYn/BBzqBWvtBTfV+3D/fbUoaJtB0ku6JhSDdi4utwB7oqiopgvE
         QvB/WqPNcTo7qAiddO22uWkXVCJKUi6e28GEJXsLIL3PJcntml3cscsK4mfXtrcEnGmH
         8Cd/9VImsX+rVcqG7QgH7yatP/4ysykidHS3a7WPoyguUaXUkl39lBLhy43d/CAla6qn
         OiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w9hyMELVK5RajRlcXxABefy1CjWCBZ8xUiCsBp5TLFg=;
        b=Ayi3jCR2KCkWtatBmjFv2V3RQN4QBfqtqsxRJ3Gg4c7j6ze4IdAcibPe8vbi4mANo0
         +RAfYTf7j0EMqQ1mjSqFOEKxLjUsVt84n8A9YUJUWxckyZjV1UZg0SAFHhocBqi3BBgu
         C3Y6E/aQDxG+0Z9Yel/YtG4hakbcrQmS4WL3TTjVMIUu8U7q7MXGrSFL5PrO0uGsJHrB
         /g4tf/c65ikXrxrRij+9f171xErW3KQxmyI5rDfYQXMp0bQ6PzbBhYfVW1eyHexeHyL4
         sUCVTvMvt9FwoNYRjcCfsLVjMtj0dzD1n8l6R67Cu4zpXEdHJngTZnhn0EzkFg55XdxI
         yrFA==
X-Gm-Message-State: AOAM532DJOvGwzfyoh0jTAoPojIWsvNhjeU9fLagmQ2PCzmyBFVLMhwl
        umM/l10koEG9Uzme9BcLOMtGEs7v2vom
X-Google-Smtp-Source: ABdhPJyRWNlcB5I5NgoHd/oqBAvfM+AnMXvrzetTEMclh1nrPe9pNyxTkSis+relvtDX0WgKCVirT56drYdk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a25:2c92:: with SMTP id
 s140mr3832807ybs.308.1636590089436; Wed, 10 Nov 2021 16:21:29 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:08 -0800
In-Reply-To: <20211111002109.194172-1-irogers@google.com>
Message-Id: <20211111002109.194172-8-irogers@google.com>
Mime-Version: 1.0
References: <20211111002109.194172-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 7/8] perf expr: Move ID handling to its own function
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This will facilitate sharing in a follow-on change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 60 ++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index ba6c6dbf30c8..d90addf9b937 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -3,6 +3,7 @@
 #define YYDEBUG 1
 #include <assert.h>
 #include <math.h>
+#include <stdlib.h>
 #include "util/debug.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
@@ -82,6 +83,38 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
 	return result;
 }
 
+static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
+			    bool compute_ids)
+{
+	struct ids result;
+	if (!compute_ids) {
+		/*
+		 * Compute the event's value from ID. If the ID isn't known then
+		 * it isn't used to compute the formula so set to NAN.
+		 */
+		struct expr_id_data *data;
+
+		result.val = NAN;
+		if (expr__resolve_id(ctx, id, &data) == 0)
+			result.val = expr_id_data__value(data);
+
+		result.ids = NULL;
+		free(id);
+	} else {
+		/*
+		 * Set the value to BOTTOM to show that any value is possible
+		 * when the event is computed. Create a set of just the ID.
+		 */
+		result.val = BOTTOM;
+		result.ids = ids__new();
+		if (!result.ids || ids__insert(result.ids, id)) {
+			pr_err("Error creating IDs for '%s'", id);
+			free(id);
+		}
+	}
+	return result;
+}
+
 /*
  * If we're not computing ids or $1 and $3 are constants, compute the new
  * constant value using OP. Its invariant that there are no ids.  If computing
@@ -167,32 +200,7 @@ expr: NUMBER
 	$$.val = $1;
 	$$.ids = NULL;
 }
-| ID
-{
-	if (!compute_ids) {
-		/*
-		 * Compute the event's value from ID. If the ID isn't known then
-		 * it isn't used to compute the formula so set to NAN.
-		 */
-		struct expr_id_data *data;
-
-		$$.val = NAN;
-		if (expr__resolve_id(ctx, $1, &data) == 0)
-			$$.val = expr_id_data__value(data);
-
-		$$.ids = NULL;
-		free($1);
-	} else {
-		/*
-		 * Set the value to BOTTOM to show that any value is possible
-		 * when the event is computed. Create a set of just the ID.
-		 */
-		$$.val = BOTTOM;
-		$$.ids = ids__new();
-		if (!$$.ids || ids__insert($$.ids, $1))
-			YYABORT;
-	}
-}
+| ID		{ $$ = handle_id(ctx, $1, compute_ids); }
 | expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
 | expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
 | expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
-- 
2.34.0.rc1.387.gb447b232ab-goog

