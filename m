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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EAAC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Sep 2021 21:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606D060F70
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Sep 2021 21:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhIOVP5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Sep 2021 17:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhIOVP5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Sep 2021 17:15:57 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC60C061574
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Sep 2021 14:14:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 21-20020a370815000000b003d5a81a4d12so9468560qki.3
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Sep 2021 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=k/ci0x8Pob6HrJahPR/bxUPeBFawoqrCO14kks/Ud10=;
        b=bXn4abxHwa9qsWASljO8uildDNkGyRGViMNwGmCUfo4LpAut/q0yhENfjylj/aPthp
         Rbtg1Cijyunpu9V/WVFbWdeESv6BHYwk9JCiE17qqmaIjExPPhIpw8iR4Yy5W8T+1O5s
         pAQuzyYJhvsh5UXUh42IRK2fmYNNJbQyd0BBlIbwfD3Ace/NRm59W8TpRXaec1OSk8Bi
         dMzqtjRLKJMerskYkecd/ng4T13rEvkopFF3bMUTdtEm9KFnxsU8n+v+x3w0g7XPsr8K
         l83+Qicst5jwvh7FvqVGCFIW74FN9M/0cuy88tXREWXug9qtAspouaBvyGxpNeBw7b+w
         qTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=k/ci0x8Pob6HrJahPR/bxUPeBFawoqrCO14kks/Ud10=;
        b=yzChMU6NSjN9yGWSZQn9KZgYtnPhyhKaEu82rab9wvbGkHQ9RAoH+ntpNz8zKN5ytx
         LCVFlVI27Js+MyTaCyZHMxKSHt6EtkWWek/pRKnSJKufTXGZ577nuQQrZ/iEufHyH9W4
         nsz1D44q2K+mqJsPeTlcse9iYqx2OhN3czNN+kGBRLPlc/GvIv14WNxtipyhIJ9McLOv
         a+56O+s0a5Z0HRR997/+7lIVubMUHaa2SXOyT95auAxFV9pEIg1mlIxSYyHq6yNuf5CK
         aT/Jr2un2LBmYIvOenfubom6NzDSv/504vL8wb9KIHmUAekOlb5AELeY6aXoX1i1Uq86
         mHrA==
X-Gm-Message-State: AOAM532dgpvDmZqQEVESXLswaPR+VRnAkeOhkU+CArGXZrh7nZcDWkxj
        x2fZKm/Kz0VkBJiCMx9Tscfot3Ia6zRv
X-Google-Smtp-Source: ABdhPJze96Gku2BQ+17hp0+ZDvvc3Q21O0RePgKvPHGBY3bEGcU+SMN/8Z//ptjGYkgfPuEV3oHxwJxPI7KB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7b71:ab93:de5f:617b])
 (user=irogers job=sendgmr) by 2002:a0c:fb4f:: with SMTP id
 b15mr2058639qvq.44.1631740476965; Wed, 15 Sep 2021 14:14:36 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:14:28 -0700
Message-Id: <20210915211428.1773567-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] perf parse-events: Avoid enum forward declaration.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Enum forward declarations aren't allowed as the size can't be implied.
Switch to just using an int. This fixes a clang warning:

In file included from tools/perf/bench/evlist-open-close.c:13:
tools/perf/bench/../util/parse-events.h:185:6: error: redeclaration of already-defined enum 'perf_tool_event' is a GNU extension [-Werror,-Wgnu-redeclared-enum]
enum perf_tool_event;
     ^
tools/perf/bench/../util/evsel.h:28:6: note: previous definition is here
enum perf_tool_event {
     ^

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 +-
 tools/perf/util/parse-events.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 51a2219df601..5d1346aa0627 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1471,7 +1471,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
-			  enum perf_tool_event tool_event)
+			  int tool_event)
 {
 	return add_event_tool(list, &parse_state->idx, tool_event);
 }
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index bf6e41aa9b6a..b32ed3064c49 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -182,10 +182,9 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
 			     struct list_head *head_config);
-enum perf_tool_event;
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
-			  enum perf_tool_event tool_event);
+			  int tool_event);
 int parse_events_add_cache(struct list_head *list, int *idx,
 			   char *type, char *op_result1, char *op_result2,
 			   struct parse_events_error *error,
-- 
2.33.0.309.g3052b89438-goog

