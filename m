Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7180BC7EE23
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jun 2023 23:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjFKXgp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jun 2023 19:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjFKXgn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jun 2023 19:36:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819F6E40
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 16:36:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so5771967276.2
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686526601; x=1689118601;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Z9C7A2uDishKMMw/sFhTPP02NzD8EdhABrfP9S4G3I=;
        b=GXi7A6zSEEdDfCKvq5m+yuiPbPulTKYUzA3hwPCaqqPx+/lA504jRE7sbArf+B7QKJ
         qCz6Q8csVHxveqzm2L8lIxTkBCv6n6hHWiFLHBCINq1R0uRjR5gzUnxG/zSxIO0dWiW4
         0rrA5OSgg0x5aVvXZEmCgS8/7w/nMMx4TqkYj8OxxQ63Zxv4AgrDAmx83Xk/nSywB5qd
         9Q52H67hwVhXcAO6lUa2TLOV/P3933EwdDcnx6STtCyTrFhhwcn+MccxLo3TpSGY5+iu
         gIdM9aqwsTY0M8JmjqnBsdk8jv6wN4iYcDX28e9U6KW3wlTQSUse018ya+91Pz1kOFus
         /acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686526601; x=1689118601;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z9C7A2uDishKMMw/sFhTPP02NzD8EdhABrfP9S4G3I=;
        b=NiO3wSH4V9bSao/r/aM/6ZnA3wb+c/XxSex46A+d8y9QNw2ccd1ZW0o5/dJiVnjtl1
         2PILZlPqn8lHXYBABfXqpDJ7n/EJ6Fj7YgbS5/LzYL6aDFTGg2kzxuZB/RW5VuWOUnBx
         rugYiOOYiAyStNbNBL31u0XyX0PCWfuOma0KmIBvjOzM76OraCTxmhclgRzkzWuQ0Nmv
         VWcb6f+Zpoef2IxRRmjhzSJ3PoR2z7VOGsz88DIkmm29AgRWaPyylwLPhVmfwu/CWVJF
         gCnTGPFrRG1Uvxo435IX9KIQreX/JGVAUQqTTG4/0Nw4DO1cHmH6TqptfyACO65tatmg
         /CEQ==
X-Gm-Message-State: AC+VfDw6vCWdJ2E5IYDGODxmO6yFPATdf/7EDEr9umgDDxydOmBsZ/Y+
        86muOPb+PUr7uFmmZJLwgGBqnyNc4WP9
X-Google-Smtp-Source: ACHHUZ5a3X8la+HIw3wdrIZywEOnTnM7oPRPJgQKVER5jcwNbGQ878wTnSSgPBk0gdTY1WlJsmVg1LrIxYct
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:aca9:d7c7:ed17:e760])
 (user=irogers job=sendgmr) by 2002:a25:d215:0:b0:bc7:f6af:8cff with SMTP id
 j21-20020a25d215000000b00bc7f6af8cffmr1783363ybg.2.1686526601566; Sun, 11 Jun
 2023 16:36:41 -0700 (PDT)
Date:   Sun, 11 Jun 2023 16:36:10 -0700
In-Reply-To: <20230611233610.953456-1-irogers@google.com>
Message-Id: <20230611233610.953456-5-irogers@google.com>
Mime-Version: 1.0
References: <20230611233610.953456-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 5/5] perf bench sched messaging: Free contexts on exit
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

Place sender and receiver contexts onto lists so that they may be
freed on exit. Add missing pthread_attr_destroy. Fixes memory leaks
reported by leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/sched-messaging.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 488f6e6ba1a5..fa1f8f998814 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -27,6 +27,7 @@
 #include <poll.h>
 #include <limits.h>
 #include <err.h>
+#include <linux/list.h>
 #include <linux/time64.h>
 
 #define DATASIZE 100
@@ -35,8 +36,11 @@ static bool use_pipes = false;
 static unsigned int nr_loops = 100;
 static bool thread_mode = false;
 static unsigned int num_groups = 10;
+static struct list_head sender_contexts = LIST_HEAD_INIT(sender_contexts);
+static struct list_head receiver_contexts = LIST_HEAD_INIT(receiver_contexts);
 
 struct sender_context {
+	struct list_head list;
 	unsigned int num_fds;
 	int ready_out;
 	int wakefd;
@@ -44,6 +48,7 @@ struct sender_context {
 };
 
 struct receiver_context {
+	struct list_head list;
 	unsigned int num_packets;
 	int in_fds[2];
 	int ready_out;
@@ -170,6 +175,7 @@ static pthread_t create_worker(void *ctx, void *(*func)(void *))
 	if (ret != 0)
 		err(EXIT_FAILURE, "pthread_create failed");
 
+	pthread_attr_destroy(&attr);
 	return childid;
 }
 
@@ -201,6 +207,7 @@ static unsigned int group(pthread_t *pth,
 	if (!snd_ctx)
 		err(EXIT_FAILURE, "malloc()");
 
+	list_add(&snd_ctx->list, &sender_contexts);
 	for (i = 0; i < num_fds; i++) {
 		int fds[2];
 		struct receiver_context *ctx = malloc(sizeof(*ctx));
@@ -208,6 +215,7 @@ static unsigned int group(pthread_t *pth,
 		if (!ctx)
 			err(EXIT_FAILURE, "malloc()");
 
+		list_add(&ctx->list, &receiver_contexts);
 
 		/* Create the pipe between client and server */
 		fdpair(fds);
@@ -266,6 +274,7 @@ int bench_sched_messaging(int argc, const char **argv)
 	int readyfds[2], wakefds[2];
 	char dummy;
 	pthread_t *pth_tab;
+	struct sender_context *pos, *n;
 
 	argc = parse_options(argc, argv, options,
 			     bench_sched_message_usage, 0);
@@ -324,6 +333,13 @@ int bench_sched_messaging(int argc, const char **argv)
 	}
 
 	free(pth_tab);
-
+	list_for_each_entry_safe(pos, n, &sender_contexts, list) {
+		list_del_init(&pos->list);
+		free(pos);
+	}
+	list_for_each_entry_safe(pos, n, &receiver_contexts, list) {
+		list_del_init(&pos->list);
+		free(pos);
+	}
 	return 0;
 }
-- 
2.41.0.162.gfafddb0af9-goog

