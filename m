Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F402C38A2D
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiJXT7s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiJXT6k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:40 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FD227EACB
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:21:10 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n1-20020a170902f60100b00179c0a5c51fso6773579plg.7
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=anPThKUkfGYO4MityDcRpU1q0+xCNjbPUERJ4hXkoEA=;
        b=YzERVhg9gMWf4MLdxZBUxgsORWHJ5IiRDR6VYxzIXnasnGV8Hosww149KRKfuABEov
         w96snZWOzfeu47BuK3oYRu/RxOuk/MmwEX6+gdq2c2tFXoJckpjyu/AYbr9k86Hyybhz
         1cIJLP8elnxBXNZRdVBOzhciaHBJrl2gmRzcgX67Vzg/0hUuIQUvqlGWD0k+Wd/SCM9z
         bItak9BMMARaNggK/JovGwRgGw/c+aSgGXbw2BnzMbBi5b1h2WKcSON2uSlPhA0U+DzQ
         d1HpCEVzzJeHvL37Oy8rcaQ+Q7l6sPxekv4KAY6W5Mz0MZH5Cg1EG8Loc3XJBjL9lJnm
         FEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anPThKUkfGYO4MityDcRpU1q0+xCNjbPUERJ4hXkoEA=;
        b=br33Oyhed3IlwGh09NdwFYE0aLAEH/d/FLsyVdJ8jD6/zaZURUX1/ZtVxaR+gJ7Arn
         ciIuSQU+bNfxlocyagR+QpIJ7ILebHlMa6GYIVJYkcYtGxRbBP8n6aaxRwjsoDDTdJdA
         lpViu8laruTlrSioBfKqr53zBsJCuxNORv1mcGkf51p1GZtVEu9wPyYMjqdWlCxlDUd5
         VhORxbNLUrK1F15H4/PhJAYSA9D2wBE6TuWt5Zj0kmr6RRnEQlYqyuu5WHEqNckCKfNZ
         0nN5p6RdYKu+AYAVNT1vQn24o4AYIHu6ibKTxCIYYTShb2Z1KRQhvJM46QNbhfps7n56
         QYZQ==
X-Gm-Message-State: ACrzQf2sOkFx/Qq+sXWvXFKlhXvLgdZ3hNjXBFHrrhemf2nLgTVEEwvs
        bMDpQ5XvUm0ZTLAQ0ycH33ny5bwX7Ewp
X-Google-Smtp-Source: AMsMyM53n+U8wMZYq2kZ48d4ptOI6JPZcIJhCvjLHnk8btpgGx6iLrT5rSk9jQcpAm0su0GzCh+QTnPUTe1t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90b:394:b0:212:19d7:9072 with SMTP id
 ga20-20020a17090b039400b0021219d79072mr27097168pjb.69.1666635608577; Mon, 24
 Oct 2022 11:20:08 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:09 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-5-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 4/8] perf ftrace: Use sig_atomic_t to avoid UB
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use sig_atomic_t for a variable written to in a signal handler and
read elsewhere. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7de07bb16d23..d7fe00f66b83 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -36,8 +36,8 @@
 
 #define DEFAULT_TRACER  "function_graph"
 
-static volatile int workload_exec_errno;
-static bool done;
+static volatile sig_atomic_t workload_exec_errno;
+static volatile sig_atomic_t done;
 
 static void sig_handler(int sig __maybe_unused)
 {
-- 
2.38.0.135.g90850a2211-goog

