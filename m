Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED8C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004F260E98
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhKDGqo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhKDGpm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880D8C061205
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d9-20020a251d09000000b005c208092922so7475163ybd.20
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AF5vHpQI2c2Dq8nnplPMxcjTfbyxpd4dSxsdmi2d+As=;
        b=cEsZMNPLDp1wTLSl+gdXQ5IU/4Y3Pay1ufBsdvQTCGsFatC1SszW0r7zxksEOaIr1S
         WzFQwhfEPFJeLy2st3uxYZPBgN/hE/oFl2TEtKCj4TRLM41GhLhx8Ke+K0uSXnoLnZ7y
         vwRj0h9GYHIy4EVzmEr8hLGg7zisJ76nfnEPErT68UA9p2OBGtqFabb5nM1bvEjBxIZm
         ltj+LyAGbSdHKa6D8ZxiSHviebOjaxpAfH7vhgugqGLn9ahBc60W6wg2NZRm2Pv+4QKf
         wUmlu1rOIz/vmHsuUZGpa3cpEkAVQv/LDGZHvHuXIMpnaapapFxkUitKDddWfCsnFiA2
         OeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AF5vHpQI2c2Dq8nnplPMxcjTfbyxpd4dSxsdmi2d+As=;
        b=KFDWH+JLoPpERo+kC5Kd3cXdJ8O9rv0fpHX7wXQHOrQ3/L0nBT4H/Ib5XPCCvBWvZt
         w+eYsxX6rtqL5QSU3yw/v+U6qHODLMrDUGhv1NbWEw1/UOXzT9a5pObYjRqoQ/XUdnx2
         fttRpbz7RbRbXt3Rqj5NvnrS30wSEJjam2N71UqwNWFYldQ4Ocq9ekyox6t0TkachFZm
         VVnariuHU/wAZmjS+qL43BooVDhWmsXTQfWKDJZeHFbOhSRV7BED77dMS9va+Zo4966E
         5MGhg8ZP6b2Js1J/fJ0Byn/Y7QtQ/1upWw9z/lJb0JJo7XTJbTX0foN69IwS5MBJGXco
         5+Mg==
X-Gm-Message-State: AOAM531wl9JRL3va++MXGU6ujIkvKPIeItptGYIyc1wjwNtjLVDdnlAS
        7QRG1O8zezLiNIy1+UdX5u+KLG6x2aoa
X-Google-Smtp-Source: ABdhPJxBNmexOoSdVojXdLxzIFWksb1eU19/TUaB8IzrMEREP0kYzjB3YPMn9YKaqHA+9t/nv+sWsrduzsIq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:4f41:: with SMTP id
 d62mr51612259ybb.13.1636008161746; Wed, 03 Nov 2021 23:42:41 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:57 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-12-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 11/22] perf test: Convert watch point tests to test cases.
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

Use null terminated array of test cases rather than the previous sub
test functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/wp.c | 128 ++++++++++--------------------------------
 1 file changed, 30 insertions(+), 98 deletions(-)

diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 904bdf2dcf81..2c0513257b15 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -62,8 +62,12 @@ static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
 	return fd;
 }
 
-static int wp_ro_test(void)
+static int test__wp_ro(struct test_suite *test __maybe_unused,
+		       int subtest __maybe_unused)
 {
+#if defined(__s390x__) || defined(__x86_64__) || defined(__i386__)
+	return TEST_SKIP;
+#else
 	int fd;
 	unsigned long tmp, tmp1 = rand();
 
@@ -79,10 +83,15 @@ static int wp_ro_test(void)
 
 	close(fd);
 	return 0;
+#endif
 }
 
-static int wp_wo_test(void)
+static int test__wp_wo(struct test_suite *test __maybe_unused,
+		       int subtest __maybe_unused)
 {
+#if defined(__s390x__)
+	return TEST_SKIP;
+#else
 	int fd;
 	unsigned long tmp, tmp1 = rand();
 
@@ -98,10 +107,15 @@ static int wp_wo_test(void)
 
 	close(fd);
 	return 0;
+#endif
 }
 
-static int wp_rw_test(void)
+static int test__wp_rw(struct test_suite *test __maybe_unused,
+		       int subtest __maybe_unused)
 {
+#if defined(__s390x__)
+	return TEST_SKIP;
+#else
 	int fd;
 	unsigned long tmp, tmp1 = rand();
 
@@ -118,10 +132,15 @@ static int wp_rw_test(void)
 
 	close(fd);
 	return 0;
+#endif
 }
 
-static int wp_modify_test(void)
+static int test__wp_modify(struct test_suite *test __maybe_unused,
+			   int subtest __maybe_unused)
 {
+#if defined(__s390x__)
+	return TEST_SKIP;
+#else
 	int fd, ret;
 	unsigned long tmp = rand();
 	struct perf_event_attr new_attr;
@@ -163,105 +182,18 @@ static int wp_modify_test(void)
 
 	close(fd);
 	return 0;
-}
-
-static bool wp_ro_supported(void)
-{
-#if defined (__x86_64__) || defined (__i386__)
-	return false;
-#else
-	return true;
-#endif
-}
-
-static const char *wp_ro_skip_msg(void)
-{
-#if defined (__x86_64__) || defined (__i386__)
-	return "missing hardware support";
-#else
-	return NULL;
 #endif
 }
 
-static struct {
-	const char *desc;
-	int (*target_func)(void);
-	bool (*is_supported)(void);
-	const char *(*skip_msg)(void);
-} wp_testcase_table[] = {
-	{
-		.desc = "Read Only Watchpoint",
-		.target_func = &wp_ro_test,
-		.is_supported = &wp_ro_supported,
-		.skip_msg = &wp_ro_skip_msg,
-	},
-	{
-		.desc = "Write Only Watchpoint",
-		.target_func = &wp_wo_test,
-	},
-	{
-		.desc = "Read / Write Watchpoint",
-		.target_func = &wp_rw_test,
-	},
-	{
-		.desc = "Modify Watchpoint",
-		.target_func = &wp_modify_test,
-	},
+static struct test_case wp_tests[] = {
+	TEST_CASE_REASON("Read Only Watchpoint", wp_ro, "missing hardware support"),
+	TEST_CASE_REASON("Write Only Watchpoint", wp_wo, "missing hardware support"),
+	TEST_CASE_REASON("Read / Write Watchpoint", wp_rw, "missing hardware support"),
+	TEST_CASE_REASON("Modify Watchpoint", wp_modify, "missing hardware support"),
+	{ .name = NULL, }
 };
 
-static int test__wp_subtest_get_nr(void)
-{
-	return (int)ARRAY_SIZE(wp_testcase_table);
-}
-
-static const char *test__wp_subtest_get_desc(int i)
-{
-	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
-		return NULL;
-	return wp_testcase_table[i].desc;
-}
-
-static const char *test__wp_subtest_skip_reason(int i)
-{
-	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
-		return NULL;
-	if (!wp_testcase_table[i].skip_msg)
-		return NULL;
-	return wp_testcase_table[i].skip_msg();
-}
-
-static int test__wp(struct test_suite *test __maybe_unused, int i)
-{
-	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
-		return TEST_FAIL;
-
-	if (wp_testcase_table[i].is_supported &&
-	    !wp_testcase_table[i].is_supported())
-		return TEST_SKIP;
-
-	return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
-}
-
-/* The s390 so far does not have support for
- * instruction breakpoint using the perf_event_open() system call.
- */
-static bool test__wp_is_supported(void)
-{
-#if defined(__s390x__)
-	return false;
-#else
-	return true;
-#endif
-}
-
 struct test_suite suite__wp = {
 	.desc = "Watchpoint",
-	.func = test__wp,
-	.is_supported = test__wp_is_supported,
-	.subtest = {
-		.skip_if_fail	= false,
-		.get_nr		= test__wp_subtest_get_nr,
-		.get_desc	= test__wp_subtest_get_desc,
-		.skip_reason    = test__wp_subtest_skip_reason,
-	},
+	.test_cases = wp_tests,
 };
-- 
2.33.1.1089.g2158813163f-goog

