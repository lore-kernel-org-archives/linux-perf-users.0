Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D8CC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72ADA60E98
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhKDGsC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhKDGqn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:46:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA1EC0797B6
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so7526826ybj.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=emwMJ+ASFthU6AcpBIBeoQ3faNbQS22qf/k+f/Ngn88=;
        b=sKa2ddxPie7Em8N2NULfqYSJdBFYeeg6fOjyFUEhOd5RL6/Xt9JBCeaI9+BRtnzEyY
         s6ElLJKFq9C8LpJpgWYJQUG6I7pXsA2P4k/XQgXNr2cqrgN6Xj8uaZtKnCi3zpyi1O36
         X4rDe/EJpwjFViXZ+03cU9JBalzEZvtNr5tYUZKy6E3CCNzDrnUT6JIAzVw+DnBqjqER
         6FNREV7x+m3i/cRJVAYsrM1PqEAdJgVmmMVvo5qOTrf+hW2Mtvy9JCHWI5kOWQDWqN4o
         mknU8MjACO9uVepcysvAhwBxDcrXXmmmDdsGDgGTYYzu9CroyL5bTcl4TP3vAGzN7EEm
         hhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=emwMJ+ASFthU6AcpBIBeoQ3faNbQS22qf/k+f/Ngn88=;
        b=S8N6vYiUvm4Rm5w4vPqgdCrT+MVVzyv2Vrdd4CAijG7JkIWqGOL5Y4ZECxzyKnWG53
         WGYsNl8JbY+D6C9hCL4hQa9ksA6UoVgDKVy/s3j+ePAGdtaxZ+Sld7NbyM12VEIxqJv1
         SzqhrMWBdx+Nzs7HyDhnA9bmsmXZhXA/kqH2CsJDaU7CKnoaVwNL8UYEWzS2CFfdROid
         DF2Hxh8VpHXfZf+1T3rUhXyv+4Me+FxQIL/AMQ6CV8gjxzrVtMgGVLeF02/7IlkcuWOw
         OJ1jnVgtbOjqMBMIQVreEz6L9AlFuxVPDso27G79HyK7KmWNhDZsYEe/Bty1a+Q20etv
         zQnA==
X-Gm-Message-State: AOAM53073GnTxRz7sMpGb4qo3xjO3JGMzZbslenHQXmjGxPBaFixAf+T
        PrrnfMn9HDzJpfLA7SWymwXsDB7p431P
X-Google-Smtp-Source: ABdhPJzfLBnF+cZ3nEk/kT8SPwJIO7M/uPP9c9+A0OwMO7WIZxnDrhIlqndd5HPE2ANjSHIB4MABOVj9hzA+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:cc15:: with SMTP id
 l21mr46916198ybf.399.1636008176677; Wed, 03 Nov 2021 23:42:56 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:03 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-18-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 17/22] perf test: Convert time to tsc test to test case.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Migration toward kunit style test cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index d23740f80c7d..594013e94ed0 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -198,8 +198,13 @@ static bool test__tsc_is_supported(void)
 #endif
 }
 
+static struct test_case perf_time_to_tsc_tests[] = {
+	TEST_CASE("Convert perf time to TSC", perf_time_to_tsc),
+	{ .name = NULL, }
+};
+
 struct test_suite suite__perf_time_to_tsc = {
 	.desc = "Convert perf time to TSC",
-	.func = test__perf_time_to_tsc,
+	.test_cases = perf_time_to_tsc_tests,
 	.is_supported = test__tsc_is_supported,
 };
-- 
2.33.1.1089.g2158813163f-goog

