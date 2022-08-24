Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CBAC00140
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Aug 2022 04:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiHXEii (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Aug 2022 00:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiHXEih (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Aug 2022 00:38:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D0E5FAC6
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 21:38:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-335ff2ef600so273938187b3.18
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 21:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=3opLk4Oz93lm77lsPTBWHBXIaH3afs5uHa/1mKNusGU=;
        b=PctrHBniebv3hCjyLQ/5fSwmIVjcOOdCc30ReMbNTAzpDzM8H6J4TyM5Q9Y+PLbJ6e
         JWUBxLGHfwoQIKNTvAEekL2u6Wx8QQAqvhHl2PwJbBPgJx1riqGt1ef66Vfznfnp+k2b
         Q7+yynShR+LtUQYVLK+PSQ6PxEyMqS86bMY7fO4fgibOgamEGhRP6/Eq6DHcb1IxCJKR
         iqTPUdlgWFwrY6qGykUmbKC7WigW2cba9zOwlmz0b//n9X63AIsBf7kaRm3V3iq/r5XZ
         RfBdtIpRzMxE7KBYL54weUCMdD3IqBBoJ9DhPLMfNYz3EGPotmSbwRIL2nMVY23wpkXw
         462Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=3opLk4Oz93lm77lsPTBWHBXIaH3afs5uHa/1mKNusGU=;
        b=vpBOo6S1UcBPczRiuJoU9EOuxiTYhrJJIZV65XgMqfPxMquAH/0ssZEML6s/ZW4Udx
         U8YUgqhIFltNIn3/ZAL/+H9v4e8q4CaPWZ0TLN62xZpLErR7HeMzObYRScNfwhuO5L7h
         I0kWJOf9Sw/djRIH24N05jfwhbn870C175bXJV1Mj+yLt6nAxcI3Ea2SjYLaNKIoF2dU
         Wh9Eo7U/hrDCwfnAWef4WE67NdCFoMDzX+MoxP3R8qnO7ZXmg0Rx2LRNbpTwFjQISbIY
         u+t7ZZi++EMY9mHFBtH2Gn8Ss9wWneApNEAluz/Z6YWWYj7/Bye0UXVBQZoKtWMnjqLk
         eKuQ==
X-Gm-Message-State: ACgBeo2qTm3WfTCvU5nSIQepBnbmmwVD7gcghh9iOldHm95hhajzcOjK
        jFYkwel00vPgRCSWnzw2PgHWH7jvLDTI
X-Google-Smtp-Source: AA6agR4uUgDd/+U54aisjGd42CsqA7eYed/AKyUrKuesNWvHwO2T7cy58ZG7JxjlpX2p90jcd0327ukTJqjp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a25:4a06:0:b0:695:c6a0:c8e1 with SMTP id
 x6-20020a254a06000000b00695c6a0c8e1mr10110095yba.181.1661315914190; Tue, 23
 Aug 2022 21:38:34 -0700 (PDT)
Date:   Tue, 23 Aug 2022 21:38:25 -0700
Message-Id: <20220824043825.322827-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH] perf sched: Fix memory leaks in __cmd_record
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

An array of strings is passed to cmd_record but not freed. As
cmd_record modifies the array, add another array as a copy that can be
mutated allowing the original array contents to all be freed.

Detected with -fsanitize=address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2f6cd1b8b662..59ba14d2321c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3355,7 +3355,8 @@ static bool schedstat_events_exposed(void)
 static int __cmd_record(int argc, const char **argv)
 {
 	unsigned int rec_argc, i, j;
-	const char **rec_argv;
+	char **rec_argv;
+	const char **rec_argv_copy;
 	const char * const record_args[] = {
 		"record",
 		"-a",
@@ -3384,6 +3385,7 @@ static int __cmd_record(int argc, const char **argv)
 		ARRAY_SIZE(schedstat_args) : 0;
 
 	struct tep_event *waking_event;
+	int ret;
 
 	/*
 	 * +2 for either "-e", "sched:sched_wakeup" or
@@ -3391,14 +3393,15 @@ static int __cmd_record(int argc, const char **argv)
 	 */
 	rec_argc = ARRAY_SIZE(record_args) + 2 + schedstat_argc + argc - 1;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
+	rec_argv_copy = calloc(rec_argc + 1, sizeof(char *));
 
-	if (rec_argv == NULL)
+	if (rec_argv == NULL || rec_argv_copy == NULL)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
 		rec_argv[i] = strdup(record_args[i]);
 
-	rec_argv[i++] = "-e";
+	rec_argv[i++] = strdup("-e");
 	waking_event = trace_event__tp_format("sched", "sched_waking");
 	if (!IS_ERR(waking_event))
 		rec_argv[i++] = strdup("sched:sched_waking");
@@ -3409,11 +3412,19 @@ static int __cmd_record(int argc, const char **argv)
 		rec_argv[i++] = strdup(schedstat_args[j]);
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = argv[j];
+		rec_argv[i] = strdup(argv[j]);
 
 	BUG_ON(i != rec_argc);
 
-	return cmd_record(i, rec_argv);
+	memcpy(rec_argv_copy, rec_argv, sizeof(char*) * rec_argc);
+	ret = cmd_record(rec_argc, rec_argv_copy);
+
+	for (i = 0; i < rec_argc; i++)
+		free(rec_argv[i]);
+	free(rec_argv);
+	free(rec_argv_copy);
+
+	return ret;
 }
 
 int cmd_sched(int argc, const char **argv)
-- 
2.37.2.609.g9ff673ca1a-goog

