Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270AFC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 18:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhLWS4i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhLWS4h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 13:56:37 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B66C061756
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Dec 2021 10:56:37 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id bm33-20020a05620a19a100b0046f1b6f3526so4942352qkb.21
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Dec 2021 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=H4ACt7rfkBpsc74qNnBZfgqCqIdVNk193chJmQMr9+M=;
        b=DVxIespipHT5nxnHKamVFs59LDtjDPZp0k/DxdnqykLGJeLDkjVjpG6m2YD6ZhVbTj
         9uHkfIGBfJiyc9bEkfBkXUlD/m/51budPHkxdKVVcM0mj185wj7uQn632DWI20D1u7SS
         NpwcsJqW5HsXXGjJYZqjqZxTeCPu3FhwPdB/Xsiog01Fx/lZARLq1QbQ3mRtu2ne3mKs
         B8R31sN3L3OLZjDXGR5J/WEuZ/kYuuW+XOyIfr0r8OcNGyj323081dPCYECRFZYkQvG2
         kQqkgDB+6prHjacvZgDyn98Hx9BOiaYUUNrXA8eztFu+KWqxKrP0NuuOq0Pe9Ct9l1pm
         UMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=H4ACt7rfkBpsc74qNnBZfgqCqIdVNk193chJmQMr9+M=;
        b=cJmyF25X3qDCTeMi6q1ZON6ASg1PeG/fFZv5i0KKhOH27k58RIZIvzngwk7ZtM+kB2
         6XheTB9tr6ub6wftsKvaud5piVpm9RKaIiMUFPAYDRC6uDb+XObRJ7a76ibPaAuhIyEc
         j3qvjrCiRYUQFepKD/F8wpkSID2C4XPJ7GOe7ogxrU8cSqpn3uxOIu82PRMsCtU3eodk
         Z29IkDIUojl5NniH0SaQjmWvTqAEUFNwaMElH/GMxG7VFQ7YlK0kTnduw6xyhiR9s26X
         AUUQYxcXB1zHP7TOM4i7m/f3KoX4kzGI7i5hVDHznplNpffvmhmRXCwPOJiBcUHweBUk
         mCZw==
X-Gm-Message-State: AOAM530sGA1xUCyT2Y5Qo9MJdHe66A+o/XrdACk5ZgewaOR6GOk5Olss
        TWy5qpnZ/ZV2y3Rh7+sHaBg8cfcZeXXJ
X-Google-Smtp-Source: ABdhPJzO8WL9/8hPrqFSRQt/5bBdRkwvmL5i+9Ip+9gryLC2Cp+NABifKNe+Hfb5IPIt+7tamPCCHFeI4yNi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1c9d:afe4:ff2f:9382])
 (user=irogers job=sendgmr) by 2002:a05:622a:f:: with SMTP id
 x15mr2812171qtw.481.1640285796666; Thu, 23 Dec 2021 10:56:36 -0800 (PST)
Date:   Thu, 23 Dec 2021 10:56:22 -0800
Message-Id: <20211223185622.3435128-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v3] perf test: Make metric testing more robust.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When testing metric expressions we fake counter values from 1 going
upward. For some metrics this can yield negative values that are clipped
to zero, and then cause divide by zero failures. Such clipping is
questionable but may be a result of tools automatically generating
metrics. A workaround for this case is to try a second time with counter
values going in the opposite direction.

This case was seen in a metric like:
  event1 / max(event2 - event3, 0)
But it may also happen in more sensible metrics like:
  event1 / (event2 + event3 - 1 - event4)

v2. Rebase and more detail in commit message.
v3. Is a rebase.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index df1c9a3cc05b..b2ddf928d32a 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -962,8 +962,18 @@ static int test__parsing(struct test_suite *test __maybe_unused,
 			}
 
 			if (expr__parse(&result, ctx, pe->metric_expr)) {
-				expr_failure("Parse failed", map, pe);
-				ret++;
+				/*
+				 * Parsing failed, make numbers go from large to
+				 * small which can resolve divide by zero
+				 * issues.
+				 */
+				k = 1024;
+				hashmap__for_each_entry(ctx->ids, cur, bkt)
+					expr__add_id_val(ctx, strdup(cur->key), k--);
+				if (expr__parse(&result, ctx, pe->metric_expr)) {
+					expr_failure("Parse failed", map, pe);
+					ret++;
+				}
 			}
 		}
 	}
@@ -1022,10 +1032,20 @@ static int metric_parse_fake(const char *str)
 		}
 	}
 
-	if (expr__parse(&result, ctx, str))
-		pr_err("expr__parse failed\n");
-	else
-		ret = 0;
+	ret = 0;
+	if (expr__parse(&result, ctx, str)) {
+		/*
+		 * Parsing failed, make numbers go from large to small which can
+		 * resolve divide by zero issues.
+		 */
+		i = 1024;
+		hashmap__for_each_entry(ctx->ids, cur, bkt)
+			expr__add_id_val(ctx, strdup(cur->key), i--);
+		if (expr__parse(&result, ctx, str)) {
+			pr_err("expr__parse failed\n");
+			ret = -1;
+		}
+	}
 
 out:
 	expr__ctx_free(ctx);
-- 
2.34.1.307.g9b7440fafd-goog

