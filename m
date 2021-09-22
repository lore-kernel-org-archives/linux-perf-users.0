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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20082C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 17:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF7F6112F
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 17:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbhIVR0H (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbhIVR0C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 13:26:02 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE1AC061574
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 10:24:32 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 61-20020aed2143000000b002a6a0f52ce7so11052172qtc.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eYmFyjQxJlLAih8817ANlmnPSTWsjS/u2nvqtL+z9+Y=;
        b=I17ESIifGUT777mMs0vxWBghGwJVlaVE20O69OixREeXEwLBOg/rXPqYptKmzC55eT
         8qK5gNqDhH98ueVCasOa8BXfMpZYlgy/dmZPWn0kxdyE8bfF9ZZdWqe3zBKL0Yuuf401
         B0rG96xc+06x8RyrkZBA/jW4+6/FHlkmAlqb6d7Ai/0fur8wrbUgSN3OaIYugLncJif9
         7cGMtNb2E17chaZ8gHuUO4aqD59MBJXNK4bLL5PM9uFbiqaWk7+dgk9NQC9QjuCIs42T
         nwaEKmjxBQxaxKRWmi7Wmdd6RF3iUeH0LpVLE+j7dnWcoztOL8CG8wz/HNyFoYt8WIbh
         L1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eYmFyjQxJlLAih8817ANlmnPSTWsjS/u2nvqtL+z9+Y=;
        b=3syvPQ1qskh9z/mZlK8JVAiOA0eEoj7ydplSTLXRYnYT9P7fiDh70wpgbe0xXB79ym
         +G/jkCR/u8av2Wbq5o2OuNeA/2HOEbBQ6QVDcyM1jYJSpS8WjqWT0Iq5JsVDFNW3D8oT
         0BhNNtlYRJXFjeT1PR0cl2vQyorXtmLmxKyc2DrU2U5VD06w5YZR/6VdUJpbXCIo8QIZ
         qbT6eY8ygalL7lxO9bMoOH3wCHVGFIPgI/aqU52HeeFFq/UdvGFA9TO+PV5T/Aai/r5d
         qMWe4CVBP3GYRn3JBisdibYGatqwGm372B8475wCS1gtFSiK9cMcnwMnYyoGfBcrEYTe
         CqWQ==
X-Gm-Message-State: AOAM531la2hQZm4xn65rCOR7Wh6vQmyvk0ogui4h4/Ia7WuUD4lbMDwQ
        np7sgoxCIRivrH0UOXPeUwz+uT51B+bp
X-Google-Smtp-Source: ABdhPJyTjx6VMtA6M/q+njx49v6Rp1/ItPKEMFUSCwQnP9Cak3Ek4KuWfJw311I8SZEYlyhCgCXw6impTb4K
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:c9c5:: with SMTP id
 z188mr321611ybf.223.1632331471582; Wed, 22 Sep 2021 10:24:31 -0700 (PDT)
Date:   Wed, 22 Sep 2021 10:24:27 -0700
Message-Id: <20210922172427.454376-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2] perf test: Make metric testing more robust.
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 43743cf719ef..0ed11764cfab 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -891,8 +891,18 @@ static int test_parsing(void)
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
@@ -947,10 +957,20 @@ static int metric_parse_fake(const char *str)
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
2.33.0.464.g1972c5931b-goog

