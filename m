Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9A6C7EE23
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jun 2023 23:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjFKXge (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jun 2023 19:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFKXgd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jun 2023 19:36:33 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEFDE40
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 16:36:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b0424c50b8so15329835ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686526591; x=1689118591;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WANpf+49bzF3fi1JQVnpe1Z3htf425reW9vyomwtVZQ=;
        b=RXGYM8eVM/uATq8am81E3Cix4a9oeYdn9M9Yuu96p5ej7mameQ8zKSPgkUa1ifzxNw
         Aa/7+j4X0E8no84CFwrdIjchQncGAHpS89BIJpDVWBTU/fbLg3xEcpRYLI8PDp6vZzTY
         yBjklgP5nBc/ANt9lrJU2RALrP+E+YA2RwMAqtuCvmelEUsaHq3/Rs+n5OUDcGBbyKlK
         4/S4UVhfdIE9G0q8v8KnDaLbTQS1RjQrPztr75ZBeyLRIBb5R8mQdEvnMHIJbKxrh93x
         06PrrzMokjdgEpL/PergNHmRVShKHdSTUAZJvRueMJn6ULiAfWgFqYoYjf5zrEmY08+2
         MAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686526591; x=1689118591;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WANpf+49bzF3fi1JQVnpe1Z3htf425reW9vyomwtVZQ=;
        b=WmW5GkjenT9oApImcAI1NnSejQI3Rh0KHLeI/PjziIuDl1Ir5WCnzBOWgO1D611Fe2
         30R9CaXKwd0MsdZyJ+3A3fdC+qTy26l7rHw7ZuyUgTYZToBlrRrY4U3hNmO9U2XNEbJI
         1QYgxNb0mC0xww0edJ+q+okVMueJSb91MSpSL73aMqg7Im2eQ1PJVQWIO6dOzlxH3gad
         AyvknLQKnn/a2WXML6p8AKj3IMD/ICAZn1T1X6KKwiaYgUvnqTpSF7a12Vo0pP5qQmy0
         DAX0Biz279jdne9DhvlZYQDycd1mDbDANq8nprUtUCjopKtFN+k9+mzlP4oenZkUW3A6
         50sA==
X-Gm-Message-State: AC+VfDzXj4FJKTTlE7pH5fhslpdGyxJjxEAHldHD0RM2SR3lVwBQbGWF
        vh7hZbEucTb52meurJ0rz+0BFS7QNIkM
X-Google-Smtp-Source: ACHHUZ7WL18NUHn2IWnKxn2bm9QJXjRaix+IJOq6J8L5q2jX25NXIAuu/9DiBm2I4yggqgcIsJZOsE631zZD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:aca9:d7c7:ed17:e760])
 (user=irogers job=sendgmr) by 2002:a17:902:b08f:b0:1ab:18eb:17c8 with SMTP id
 p15-20020a170902b08f00b001ab18eb17c8mr865642plr.2.1686526591062; Sun, 11 Jun
 2023 16:36:31 -0700 (PDT)
Date:   Sun, 11 Jun 2023 16:36:06 -0700
Message-Id: <20230611233610.953456-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 1/5] lib subcmd: Avoid memory leak in exclude_cmds
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

exclude_cmds will shorten the cmds names array, before doing so free
the removed entry.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/help.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index bf02d62a3b2b..a66fb1a1a312 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -66,6 +66,7 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	while (ci < cmds->cnt && ei < excludes->cnt) {
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
 		if (cmp < 0) {
+			zfree(&cmds->names[cj]);
 			cmds->names[cj++] = cmds->names[ci++];
 		} else if (cmp == 0) {
 			ci++;
@@ -75,9 +76,12 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 		}
 	}
 
-	while (ci < cmds->cnt)
+	while (ci < cmds->cnt) {
+		zfree(&cmds->names[cj]);
 		cmds->names[cj++] = cmds->names[ci++];
-
+	}
+	for (ci = cj; ci < cmds->cnt; ci++)
+		zfree(&cmds->names[ci]);
 	cmds->cnt = cj;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

