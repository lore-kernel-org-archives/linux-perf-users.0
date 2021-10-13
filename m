Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C31C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD946113D
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbhJMRuu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbhJMRu0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:50:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B0C061793
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:47:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso3982602ybc.6
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mqKxshEsOnyYk4hukttG/9GkyZAG+p+e1JYzvnh59Io=;
        b=duvX/G1eI7HiYKUO/9muTZifA5El+o+9obtH2euekZ+5ZqOn4CyVMIDJxHFF7pVLga
         4HiIh9gZ4i0shmTK5wlE3rUe88Ue7XMMkNp+iu6MSSmH6WVG8DQJejLdRzDdiYzWNvAF
         pADLLBOX+HjVNm5VCyArWyBm/1z2V6g7buqDp+mo/+0s6YDjxLe6KeXSijoar74dCj+c
         25p0QTqy+N90ONHNnVkoznUBArpF9bgO02Lbnr2osvDWiqsNpCaxNwvDFGtvNXoLDKwR
         bDB0HYDUFeoRsPUJD1eD84wDDuUKPljT9nkhHONKF5ymazOvU+ygm9rOUCcZJ7wyqUvC
         hFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mqKxshEsOnyYk4hukttG/9GkyZAG+p+e1JYzvnh59Io=;
        b=2Mm5ItJHP85qGm4K8k8fEBYsrlim8GIUIIFa9RYhbTrXp3oChMpVxuGPijt7oqyAdq
         0LLMSzYuQcJ7sAw8yRxGHJUhQqkHuWfp2h0VCpk8AyCEYufqf4VlFhiEA0BzGN1sw5X5
         4NXl/Z1G2kcP8SSZoJ9P/gy+pinfu3Brfka4lQhPp/+0XyrhMxFBR24ZLtH4nfnWJKO3
         RMzlqzh55PqnfJbpblaulIb56tJG6OdiEG4rMPDerf0jUv3rlwfvNmzmGoKYg28cwIfY
         SwEz326bXlyD2Opm7xHnvmBglsDAF7PYBxY93KXpZnF0dpklY0DsNb68TokN/0sGJUHE
         lzdg==
X-Gm-Message-State: AOAM531XzGXDI1zsy6ENhfjt3gtUzIeoFrSW6t1sOEYzbKoY+lnSk4PR
        +QlZ7FLfbhNujVhm4NOKHMyTZDDm6w/V
X-Google-Smtp-Source: ABdhPJzh3FMjm0Ohpi+2KWB96pi4nD+d3l8EOm2pyPL7CsJhNE6XnpZCpgiOKZQLBAKDpul3WzFWJuEsieOl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:24c1:: with SMTP id
 k184mr878792ybk.2.1634147234697; Wed, 13 Oct 2021 10:47:14 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:46:04 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-23-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 22/22] perf test: Remove skip_if_fail
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
        David Gow <davidgow@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Remove optionality, always run tests in a suite even if one fails. This
brings perf's test more inline with kunit that lacks this notion.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/bpf.c          |  1 -
 tools/perf/tests/builtin-test.c | 24 ++++++++----------------
 tools/perf/tests/clang.c        |  1 -
 tools/perf/tests/llvm.c         |  1 -
 tools/perf/tests/pfm.c          |  1 -
 tools/perf/tests/tests.h        |  3 ---
 6 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index e86a77ce93ef..c3d6eda8601e 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -382,5 +382,4 @@ static struct test_case bpf_tests[] = {
 struct test_suite suite__bpf = {
 	.desc = "BPF filter",
 	.test_cases = bpf_tests,
-	.subtest = { .skip_if_fail = true, },
 };
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 086641f60015..14e49f51be10 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -238,18 +238,13 @@ static int run_test(struct test_suite *test, int subtest)
 	for (j = 0; j < ARRAY_SIZE(tests); j++)	\
 		for (k = 0, t = tests[j][k]; tests[j][k]; k++, t = tests[j][k])
 
-static int test_and_print(struct test_suite *t, bool force_skip, int subtest)
+static int test_and_print(struct test_suite *t, int subtest)
 {
 	int err;
 
-	if (!force_skip) {
-		pr_debug("\n--- start ---\n");
-		err = run_test(t, subtest);
-		pr_debug("---- end ----\n");
-	} else {
-		pr_debug("\n--- force skipped ---\n");
-		err = TEST_SKIP;
-	}
+	pr_debug("\n--- start ---\n");
+	err = run_test(t, subtest);
+	pr_debug("---- end ----\n");
 
 	if (!has_subtests(t))
 		pr_debug("%s:", t->desc);
@@ -432,7 +427,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 			continue;
 		}
 
-		test_and_print(&test_suite, false, 0);
+		test_and_print(&test_suite, 0);
 	}
 
 	for (e = 0; e < n_dirs; e++)
@@ -456,7 +451,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	}
 
 	for_each_test(j, k, t) {
-		int curr = i++, err;
+		int curr = i++;
 		int subi;
 
 		if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
@@ -483,7 +478,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		}
 
 		if (!has_subtests(t)) {
-			test_and_print(t, false, -1);
+			test_and_print(t, -1);
 		} else {
 			int subn = num_subtests(t);
 			/*
@@ -495,7 +490,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			 * 35.1: Basic BPF llvm compiling test                          : Ok
 			 */
 			int subw = width > 2 ? width - 2 : width;
-			bool skip = false;
 
 			if (subn <= 0) {
 				color_fprintf(stderr, PERF_COLOR_YELLOW,
@@ -518,9 +512,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 
 				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
 					test_description(t, subi));
-				err = test_and_print(t, skip, subi);
-				if (err != TEST_OK && t->subtest.skip_if_fail)
-					skip = true;
+				test_and_print(t, subi);
 			}
 		}
 	}
diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
index ba06a2257574..a7111005d5b9 100644
--- a/tools/perf/tests/clang.c
+++ b/tools/perf/tests/clang.c
@@ -29,5 +29,4 @@ static struct test_case clang_tests[] = {
 struct test_suite suite__clang = {
 	.desc = "builtin clang support",
 	.test_cases = clang_tests,
-	.subtest = { .skip_if_fail = true, },
 };
diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index f27ef00d65e9..8ac0a3a457ef 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -216,5 +216,4 @@ static struct test_case llvm_tests[] = {
 struct test_suite suite__llvm = {
 	.desc = "LLVM search and compile",
 	.test_cases = llvm_tests,
-	.subtest = { .skip_if_fail = true, },
 };
diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index 651fee4ef819..71b76deb1f92 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -191,5 +191,4 @@ static struct test_case pfm_tests[] = {
 struct test_suite suite__pfm = {
 	.desc = "Test libpfm4 support",
 	.test_cases = pfm_tests,
-	.subtest = { .skip_if_fail   = true }
 };
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 15051801c790..8f65098110fc 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -40,9 +40,6 @@ struct test_case {
 
 struct test_suite {
 	const char *desc;
-	struct {
-		bool skip_if_fail;
-	} subtest;
 	struct test_case *test_cases;
 	void *priv;
 };
-- 
2.33.0.882.g93a45727a2-goog

