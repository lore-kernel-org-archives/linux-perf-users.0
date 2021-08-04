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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C938C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 07:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B0560200
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 07:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhHDH0G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 03:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbhHDH0F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Aug 2021 03:26:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7F0C0613D5
        for <linux-perf-users@vger.kernel.org>; Wed,  4 Aug 2021 00:25:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso2027855ybg.11
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Aug 2021 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wFXVwjyWGfQgIMZomutoD6Q8NQazpuACEt5r5XuS4+I=;
        b=b312wk1fFJZLEdrNi874u+c7lDcfJUvC4oJ+TKN8DglbZG6mfoJZM3WYsauV9op8B/
         /8rWH56bqPH20YmZPd/08q+vIaFSToPfXrN9qok0Qzi7G+dCra5Xslj9dJ72tcf9/6Ol
         xVSQgqGkX9Ax9Wg9j1nqjQaEo8lk6cU2xhhARq6lFAx0S5NADZ/Em2h+Zu65n5fS5p8k
         BFY7p5Nhn4asT5oZT014x9M5TiivwaZ5RwCLqUiv+MyaK69ueL9yM9oVYsg3JOhV+Zcf
         91URytPMk2W/IIbHx+6jCxRIKUqnI1RM9La/isb+gS5Bp+9t8aUEfzhF8LuVA1tUBizv
         amsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wFXVwjyWGfQgIMZomutoD6Q8NQazpuACEt5r5XuS4+I=;
        b=kdCP4HSHhMd5vg0mmhcJOL8zLjwXJkpXma13uzaaT+fKLDV3uW2Q9pT79kPJ2PEFEz
         HBl++2UL0zp4n9jyZRmTWvlQnl0ixtZgj9eXqKUPJX5de1bb89q0g2FjDa8XHhGpuyQy
         YjjEb1puGjMnYXYJxNIlONeo4TeE/ELMznkv21pQog/JfFDaJoiKOVnUW5HSTUZzbfcT
         YJrtEmz11SoZS90bkiwiFVQoQPORfOJPmrtPbUsj//Gvy1CvQJo2s0cyKHFLl3HvQYng
         2bdNOVbIrG9WJg752j3qywJNXk7l9He/R1uGm7CFLOiLoRWqUm7+/JLJ4L6fC79U5LGn
         7AOQ==
X-Gm-Message-State: AOAM5324S/JxKKLZ4GXEytjsA2Q8po6VpfRabwezeskoZzaoti/p+Mk5
        UaKjnYXij3YWDCRFnd3x+4VWmECnnig8
X-Google-Smtp-Source: ABdhPJy9LNMega1xQeTpJyUFPV0eZ7pK2QxWD5u1+1i0pJg9MoEo7FIIVTQ/WApTZ2za6yx1d92FTFb4dUcn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:bfcb:f7e3:49a1:c031])
 (user=irogers job=sendgmr) by 2002:a5b:8cd:: with SMTP id w13mr25193445ybq.106.1628061952889;
 Wed, 04 Aug 2021 00:25:52 -0700 (PDT)
Date:   Wed,  4 Aug 2021 00:25:47 -0700
Message-Id: <20210804072547.1728924-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH] perf test: Make metric testing more robust.
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
to zero, and then cause divide by zero failures. A workaround for this
case is to try a second time with counter values going in the opposite
direction.

This case was seen in a metric like:
  event1 / max(event2 - event3, 0)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index b8aff8fb50d8..6c1cd58605c1 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -600,8 +600,18 @@ static int test_parsing(void)
 			}
 
 			if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
-				expr_failure("Parse failed", map, pe);
-				ret++;
+				/*
+				 * Parsing failed, make numbers go from large to
+				 * small which can resolve divide by zero
+				 * issues.
+				 */
+				k = 1024;
+				hashmap__for_each_entry((&ctx.ids), cur, bkt)
+					expr__add_id_val(&ctx, strdup(cur->key), k--);
+				if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
+					expr_failure("Parse failed", map, pe);
+					ret++;
+				}
 			}
 			expr__ctx_clear(&ctx);
 		}
@@ -656,10 +666,20 @@ static int metric_parse_fake(const char *str)
 		}
 	}
 
-	if (expr__parse(&result, &ctx, str, 0))
-		pr_err("expr__parse failed\n");
-	else
-		ret = 0;
+	ret = 0;
+	if (expr__parse(&result, &ctx, str, 0)) {
+		/*
+		 * Parsing failed, make numbers go from large to small which can
+		 * resolve divide by zero issues.
+		 */
+		i = 1024;
+		hashmap__for_each_entry((&ctx.ids), cur, bkt)
+			expr__add_id_val(&ctx, strdup(cur->key), i--);
+		if (expr__parse(&result, &ctx, str, 0)) {
+			pr_err("expr__parse failed\n");
+			ret = -1;
+		}
+	}
 
 out:
 	expr__ctx_clear(&ctx);
-- 
2.32.0.554.ge1b32706d8-goog

