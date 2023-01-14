Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56B2C46467
	for <linux-perf-users@archiver.kernel.org>; Sat, 14 Jan 2023 21:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjANVxD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 14 Jan 2023 16:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjANVxD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 14 Jan 2023 16:53:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508F9EED
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Jan 2023 13:53:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r8-20020a252b08000000b007b989d5e105so23421551ybr.11
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Jan 2023 13:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7LjX5uGK3WCr57lUgDj8dp0DrlckrMoNfjwJB3vyfk=;
        b=kQY6SCnd86TNsyNs+WGDwOUPyNjEHdmF/oyqGflEr1YCVEUITODKWdmUUkAHBOwUza
         33TmnI0SN2oiIjuH1iCYPbGOhlZGBJqzxqU96kGktV0aTI04+beQV0FlyeUv5YBqjoXL
         KI8UWtDFbdLzcWdMNvqFZuViwArRdqsDsEK+Gc/iM968chXed7e44oDcuya6bdBAwkCr
         PHZwqBe5ymkO6JleO7dXaAwq+OUR/4QOf7Olgate0sinyx5L5wvsYJ5CM8j0PqWIb929
         zfnpaEb3ouKweZo7k8UT3YGdpdDI9uil3Iv+iUopgylQ9qMFOGDjlHUIfg/5tW4QlEaf
         rMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7LjX5uGK3WCr57lUgDj8dp0DrlckrMoNfjwJB3vyfk=;
        b=s+X+wRsqAJhHS2MqXt8ISlAsMP6jQs/bSh07+9JWSkeBRQubfo841hUtTXFauzgq4p
         ZY4OeSx60iWOiQ3mGyWIn37h41JkY4PcqsxTJWvVbV2gQNa48lg6xZLzRb+bsQh25eqT
         W6WnXa7GQu4/LCzWQ+KPsaRYp8QcaeCnmYRaUjGEDvPP/E3qzo3nJDHGESKvg31Vx0kU
         9lxT7V8K5atDg3LJy7nv6InY2blP1X0P00IkIYsi3Y9vXppWQjCi3RhJOl03ys3SZlj6
         4a2nbTujDJq+u4bRb9G7r0cj5ANVfIOf7WSPoTlsBrTwI5mGYXzXDdBkxIj7jsVMsHhE
         niwQ==
X-Gm-Message-State: AFqh2kq5puF8ZxxA2psA6cjPgOO1pPkqDZV2RMfF4iwoJP3Un7YXWi/y
        i50CvWVWp19j4tgTLT0kive7FeO+NMDM
X-Google-Smtp-Source: AMrXdXtv1un/Hw8VAb7/hPRFzAnhyGVA4c1ASbv+9wc6xkzoCUeqJ/hQ7n2ILI4AG2sNK0A+0HD6enSVjwSK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:4b8d:c5ae:877b:4ae6])
 (user=irogers job=sendgmr) by 2002:a0d:ea8b:0:b0:4d0:b28:e831 with SMTP id
 t133-20020a0dea8b000000b004d00b28e831mr2645369ywe.70.1673733181442; Sat, 14
 Jan 2023 13:53:01 -0800 (PST)
Date:   Sat, 14 Jan 2023 13:52:51 -0800
Message-Id: <20230114215251.271678-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1] perf test workload thloop: Make count increments atomic
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The count variable is incremented by multiple threads, doing so
without an atomic operation causes thread sanitizer warnings. Switch
to using relaxed atomics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/workloads/thloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
index 29193b75717e..af05269c2eb8 100644
--- a/tools/perf/tests/workloads/thloop.c
+++ b/tools/perf/tests/workloads/thloop.c
@@ -20,7 +20,7 @@ static void sighandler(int sig __maybe_unused)
 noinline void test_loop(void)
 {
 	while (!done)
-		count++;
+		__atomic_fetch_add(&count, 1, __ATOMIC_RELAXED);
 }
 
 static void *thfunc(void *arg)
-- 
2.39.0.314.g84b9a713c41-goog

