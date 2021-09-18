Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AC4C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Sep 2021 06:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D0C61212
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Sep 2021 06:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhIRGgz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 18 Sep 2021 02:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbhIRGgw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 18 Sep 2021 02:36:52 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5234BC061574
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 23:35:29 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r18-20020a056214069200b0037a291a6081so106899633qvz.18
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 23:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zW1Ams81Kjka2LWuco04HmyEdFth1+/D5Mj6r33SeYY=;
        b=du8INAehX/nOqsE7pu3XLmHunjsh9U/+3BbMjyP8raBArv8X+MbUAfZcovVJk/Ypqj
         qZR6K38B1WGbKgdoH8MDaHPCU3GWfGgUi2+Rm4KURfKy4+nBw1hIrlIPii0iBaNknOzB
         GcEhpiDtrZDr+aq2npjCg1o+xm9x0SJHEYZaXiWGEZ0O3pjXr7RJoSeS26gnHOG6clRr
         3RiWHxXZ0Uo3RaKvVo2IlAnPoOrvi36ieUB1L2ovFiDCAzDYtTX7Yv+mWYoAji57SoaK
         rluOHB6/9WyaIuh7SqV8ZTCOjyFElbusUwBowsgp9L96oN/4A2kk/iYqI+3IVYAcmoAx
         gb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zW1Ams81Kjka2LWuco04HmyEdFth1+/D5Mj6r33SeYY=;
        b=O9/ubeQ1vvsbwXyia2OXdUQh6arqinGcvRQPuKxPOlHzGfDJ/I6lYaA83qGqrtz2sB
         RMJGKASCCqtSRwz5rZYsbSmfbug7Ea6zUJxLLuoEMPf3AaiNI6QQsvABktcew1gXJjXu
         LcaX/euPWArXfIPeMMJKdQvR1h0bZ6/5wYp3GY7JZsh9K0KgVg4b9t+rSfm6HRVMNZK4
         AubXaz6Z1lXBAKPLZxy7c0xOnIyNvhlJpfG+t6BjRUQNWurjQVlnjgUHH76oWA9YMRjz
         dMu5lsEZnOu0Dol0XlblhrKvKAIiCzk3a+8c7xXSSWQDM59coJn1LTdCq7CUyNai18wP
         FIlg==
X-Gm-Message-State: AOAM532W4odFqDHPx2VFjdWjxoFQ4unXt5mQ9LYDvXo7hKqkStV3kQRf
        jC0He6ETykhkGdECEKo48DXGsRx0OwaD
X-Google-Smtp-Source: ABdhPJzjEy/dTIknYXk6tYa8ANhX1QZNZeDVSSYlV1hZdQ1Ox30Kk/RuMz3Q0TAVOqQzUKUJT5o9wt68CXKt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6399:5df3:21d3:3cca])
 (user=irogers job=sendgmr) by 2002:a05:6214:142c:: with SMTP id
 o12mr15055954qvx.26.1631946928407; Fri, 17 Sep 2021 23:35:28 -0700 (PDT)
Date:   Fri, 17 Sep 2021 23:35:07 -0700
In-Reply-To: <20210918063513.2356923-1-irogers@google.com>
Message-Id: <20210918063513.2356923-3-irogers@google.com>
Mime-Version: 1.0
References: <20210918063513.2356923-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v8 2/8] perf metric: Use NAN for missing event IDs.
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

