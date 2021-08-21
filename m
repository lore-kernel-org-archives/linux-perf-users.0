Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF940C432BE
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CC961186
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhHUJVQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbhHUJUs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47953C06129D;
        Sat, 21 Aug 2021 02:20:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r19so17598085eds.13;
        Sat, 21 Aug 2021 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KwlR07ut3cqVZEyAKALk9RBIbvWirqxmVWSTPfvdu3o=;
        b=QsLXNogpiol/dymbdXO361CG8GbHjA0WP8xm+E1uGPSU/GjZ/vgkJ2pV0bv6XAy4T4
         7QeXOlMUjeocaa3f42Q0WqBgERiWgVjzTiYgCfjPfhveSdgKuEoBluG0ienHIDXFOKrC
         TPeyoNKHs5skJ8tH/qG7Pm0XXGSFnxG5FQWnIbK6O1rz0Q2bNLopdrwkVZtlyNLbOaEY
         sQAJ1obJBGks6RaHuNMleqraIraSPRoSbW5c2xXmMHZxf4NcBVpi+lqBihCzwdMRAvwk
         pL5hMhzzHH/GLGglDrNA/jr3b/Lw9ZGGNiKQYrdc01K+AV8CARi+3ND+5O2fGgYNzYZ1
         UcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KwlR07ut3cqVZEyAKALk9RBIbvWirqxmVWSTPfvdu3o=;
        b=S04e1UQ9FzVh7ewqi3xbdng/9wBexg+i0hm+DSb/Vlj13MDeJ/ZsXSEjfiu7OchEaE
         /BGirC+oMnQU1utWFoVReuzh59NvK7KatZxJV+QFxeJ4owDhQZ8Wh8+scWMq7f9jKdYZ
         +3+0bG7d/wU83uIEY/VZmXWHUKnuDrSJFEuOhaS4xnU7t4gIn97fV5uxsNJHUqhfbP4w
         09fwtmkSm94TwRhp/akKP2ZEU+OCLioPmD4dukwW58bRoIlGN1lA7T73tl8JFMZHfcoi
         bQKU0Wo5Pd5hW12Fib/yzWLuJ/pKWPd7MXkZr49H3DtVhBxWW4IEa9adQzunwmS/Gyvb
         g3oA==
X-Gm-Message-State: AOAM530O3LxJ5L/oz31RcR0R//Z5l6seSayCzC2OONiYZFJNXXDecYXj
        D36QycWuBEiWhQpFjmq/06A=
X-Google-Smtp-Source: ABdhPJxrV3Ysw75iDG3KpLGT2qVE0SchiiZ1Q9MgRlbXXOR1V9j9M1AQI7VvO3Oy29GWH4teQQvEQg==
X-Received: by 2002:a05:6402:84e:: with SMTP id b14mr26513634edz.227.1629537601871;
        Sat, 21 Aug 2021 02:20:01 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:01 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 11/37] perf evlist: add multithreading to evlist__disable
Date:   Sat, 21 Aug 2021 11:19:17 +0200
Message-Id: <7dd234195436b7f6db850719292f6d9d63fdd6ff.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In this patch, evlist__for_each_evsel_cpu is used in evlist__disable to
allow it to run in parallel.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evlist.c | 57 +++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f9fdbd85a163ee97..5c82246813c51c51 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -486,41 +486,44 @@ int evlist__for_each_evsel_cpu(struct evlist *evlist, evsel__cpu_func func, void
 
 }
 
+struct evlist_disable_args {
+	char *evsel_name;
+	int imm;
+};
+
+static int __evlist__disable_evsel_cpu_func(struct evlist *evlist __maybe_unused,
+					struct evsel *pos, int cpu, void *_args)
+{
+	int ret = 0;
+	struct evlist_disable_args *args = _args;
+
+	if (evsel__strcmp(pos, args->evsel_name))
+		return 0;
+	if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
+		return 0;
+	if (pos->immediate)
+		ret = 1;
+	if (pos->immediate != args->imm)
+		return ret;
+	evsel__disable_cpu(pos, cpu);
+
+	return ret;
+}
+
+
 static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
-	struct affinity affinity;
-	int cpu, i, imm = 0, cpu_idx;
-	bool has_imm = false;
-
-	if (affinity__setup(&affinity) < 0)
-		return;
+	int ret;
+	struct evlist_disable_args args = { .evsel_name = evsel_name };
 
 	/* Disable 'immediate' events last */
-	for (imm = 0; imm <= 1; imm++) {
-		evlist__for_each_cpu(evlist, i, cpu) {
-			affinity__set(&affinity, cpu);
-
-			evlist__for_each_entry(evlist, pos) {
-				if (evsel__strcmp(pos, evsel_name))
-					continue;
-				cpu_idx = evsel__find_cpu(pos, cpu);
-				if (cpu_idx < 0)
-					continue;
-				if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
-					continue;
-				if (pos->immediate)
-					has_imm = true;
-				if (pos->immediate != imm)
-					continue;
-				evsel__disable_cpu(pos, cpu_idx);
-			}
-		}
-		if (!has_imm)
+	for (args.imm = 0; args.imm <= 1; args.imm++) {
+		ret = evlist__for_each_evsel_cpu(evlist, __evlist__disable_evsel_cpu_func, &args);
+		if (!ret)	// does not have immediate evsels
 			break;
 	}
 
-	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (evsel__strcmp(pos, evsel_name))
 			continue;
-- 
2.31.1

