Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6BCEB64D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbjFMS0n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFMS0l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 14:26:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725B310CB
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 11:26:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd5b8a9d82cso795884276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686680797; x=1689272797;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WvMVfl1WbDxqaWJUP4jTOe+ztVEZmNwWPMXr+gZbHUE=;
        b=G39YdJ8wOdM1C69yLTN8U8l+iNpDIl3Id0EXeBecT65zG5PZZ2mXqaDwneqDVxK9Wz
         BPAudXpNDQHC7Qbu4ydbg1xt83/Y0vc5zeyQXEfnt1jodtn3sviJu2FfiILRPIUV6KUy
         jlE57YbOGwV6Y82Lj1lpyuGmLmxvRxRt6Vs4JBcaS9f4McaJTqXJMy8g1xcFpHXR8sd8
         d73bkaYS3fbsopqvO98U2Xbq7WfvKTvoOTjjgK2tAKl2aGJcexX432QAHJqnC9+H2DJc
         rXuIftkkWxYxubgqbRraziqH7Z6jkAwZKHHOR6tXWuueo+G6q/E8e56RXk9n4rbp/JQS
         O/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680797; x=1689272797;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvMVfl1WbDxqaWJUP4jTOe+ztVEZmNwWPMXr+gZbHUE=;
        b=SkzBPyXLr9K5sm/cKE/WcvOEgvu6u3O4ELpTP9U/+RsdaZn8yLwTRxeBa82tbBDkMR
         7HrqRalp2EmkgUiixarYkzI3YfAE4bh9kPsbkMhQITzKql4tSOvO5jaMVuYS57Y4XeZk
         ZGUeN3islGarnTO6/OYo8b/TMBMFEQk1/4EdQlwQK2OjXu3OsNDQal4Qt9WTb21PVD+b
         AP9FP8atiex5FIra/o3w8xLN1zTviZIGASUf/LWI+D/ep6KceK4JaFm1pO+0GfDHbsxk
         ie7oZuYisW643s6UmlrOyFvayv3ee/J57ac1MiCXkoMP2BMrKWe6qLV3INmkEh75Aicm
         U1Hg==
X-Gm-Message-State: AC+VfDw0SNTNhSQRTU5QRYHR21BrMmoevNdpqZuGuocUfzSerMi6R/wz
        SMTj6ibpgjzq56vzkfWkYqNFqS/fHp7H
X-Google-Smtp-Source: ACHHUZ5i6ml3ujak5mKh6Gh2Grqy408xn/nvtw8YEQKjViFjGcQWC+CTovKVHYcktruzNX4apdMyjTjctLv+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a704:56d6:f79d:33e7])
 (user=irogers job=sendgmr) by 2002:a05:6902:160b:b0:bcc:bc25:7296 with SMTP
 id bw11-20020a056902160b00b00bccbc257296mr13317ybb.9.1686680797759; Tue, 13
 Jun 2023 11:26:37 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:26:29 -0700
Message-Id: <20230613182629.1500317-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1] perf parse-events: Avoid string for PE_BP_COLON, PE_BP_SLASH
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
        Rob Herring <robh@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There's no need to read the string ':' or '/' for PE_BP_COLON or
PE_BP_SLASH and doing so causes parse-events.y to leak memory.

The original patch has a committer note about not using these tokens
presumably as yacc spotted they were a memory leak because no
%destructor could be run. Remove the unused token workaround as there
is now no value associated with these tokens.

Fixes: f0617f526cb0 ("perf parse: Allow config terms with breakpoints")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.h | 4 ----
 tools/perf/util/parse-events.l | 4 ++--
 tools/perf/util/parse-events.y | 9 ---------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5fdc1f33f57e..b0eb95f93e9c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -228,10 +228,6 @@ void parse_events_error__handle(struct parse_events_error *err, int idx,
 void parse_events_error__print(struct parse_events_error *err,
 			       const char *event);
 
-static inline void parse_events_unused_value(const void *x __maybe_unused)
-{
-}
-
 #ifdef HAVE_LIBELF_SUPPORT
 /*
  * If the probe point starts with '%',
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7629af3d5c7c..99335ec586ae 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -315,13 +315,13 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 	 * are the same, so trailing context can be used disambiguate the two
 	 * cases.
 	 */
-":"/{modifier_bp}	{ return str(yyscanner, PE_BP_COLON); }
+":"/{modifier_bp}	{ return PE_BP_COLON; }
 	/*
 	 * The slash before memory length can get mixed up with the slash before
 	 * config terms. Fortunately config terms do not start with a numeric
 	 * digit, so trailing context can be used disambiguate the two cases.
 	 */
-"/"/{digit}		{ return str(yyscanner, PE_BP_SLASH); }
+"/"/{digit}		{ return PE_BP_SLASH; }
 "/"/{non_digit}		{ BEGIN(config); return '/'; }
 {num_dec}		{ return value(yyscanner, 10); }
 {num_hex}		{ return value(yyscanner, 16); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 0c3d086cc22a..9f28d4b5502f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -80,8 +80,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_LEGACY_CACHE
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
-%type <str> PE_BP_COLON
-%type <str> PE_BP_SLASH
 %type <str> PE_EVENT_NAME
 %type <str> PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %type <str> PE_DRV_CFG_TERM
@@ -510,9 +508,6 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
 	struct list_head *list;
 	int err;
 
-	parse_events_unused_value(&$3);
-	parse_events_unused_value(&$5);
-
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
@@ -531,8 +526,6 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
 	struct list_head *list;
 	int err;
 
-	parse_events_unused_value(&$3);
-
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
@@ -550,8 +543,6 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 	struct list_head *list;
 	int err;
 
-	parse_events_unused_value(&$3);
-
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
-- 
2.41.0.162.gfafddb0af9-goog

