Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426BFC4320A
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273A460EBB
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhG3Pg5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhG3Per (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:34:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C218FC061799;
        Fri, 30 Jul 2021 08:34:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so6664075wms.0;
        Fri, 30 Jul 2021 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CIExtbThPbbcLfdxLxOkvlg0jD1RqcEaBy2kTbORSVw=;
        b=PNTp9ni1lbTwDOQ0vZkBR6HJANzy8ikqV7UUffFsNDg5UhuWqSjlWXMI60TtK9NfvN
         a9O97M2I3vzG44brA9whJP3TH6VUWteFalSWrFvBK648drKYzkyyjQfvfHXYZ7QmpT+N
         0PIJSYh6DcYAmFkN4hXXxgzHKAB3md8PZAbUa9bObma4cUYryA7lPapOKLfpFa0zz6wI
         6x+fqeOw5UGZHJGKyHUjeiR/xkprFKvNu1cJdd8u4MWn7rLVbBAj9XvTi2Hny/KVZwXp
         qhp3bnSjPMa9omikOizBuFTMHY0J4sDGdiK/mePcSUM7/WEqhtwOUQebbRDH54vCYNwT
         kdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIExtbThPbbcLfdxLxOkvlg0jD1RqcEaBy2kTbORSVw=;
        b=Jm2kQwFHpdav0aerkf7qulIukCLGLbcdYttehji86XK5tRP956CzvBPsctltP0QCn6
         h7F27We3ID0i8t+90ApXm+iuFqgtk/SVHgzI9gu+LvMk64qi2mlC8TWz4duZVzY3v8gi
         XObtC88hu1xsi1eULzV7QZXnuFm6OSXCp/wuUT5LgV/fYJtQkeCceJRGl2sFiBoESDel
         S5mnxadOhl+yexQCWxLEG9fJm8rLtPPaJ6O8hjyqqP+0ekeEQ5OZWee31aSF/WfPi3PM
         3iqhbmu42j12MPsQVefxnUo7RaQjUx0lRHp3g8wLgCRR0aXHpJ8BGXPaBI9eEtZSnhiD
         CGFw==
X-Gm-Message-State: AOAM533aUgbZAfOG5SHbDmivRhO15hq84lS9fWCTye5jGeYgc/2eia2A
        Sw49TwdrsouTNaFM1k8Id0I=
X-Google-Smtp-Source: ABdhPJznY1x6nIY9T6QXUtGpI9azbD4eyeh2Lghaupp5puusFMDstK1AlKVRQy5CtB4EHdhzGCVffw==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr3445557wmc.102.1627659264326;
        Fri, 30 Jul 2021 08:34:24 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:24 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v2 02/10] perf tests: add test for workqueue
Date:   Fri, 30 Jul 2021 17:34:09 +0200
Message-Id: <bb14af120874773568d0d5f4695118327191767c.1627657061.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627657061.git.rickyman7@gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It will have subtests testing threadpool and workqueue separately.
This patch only introduces the first subtest, checking that the
threadpool is correctly created and destructed.
This test will be expanded when new functions are added in next
patches.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   9 +++
 tools/perf/tests/tests.h        |   3 +
 tools/perf/tests/workqueue.c    | 115 ++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 tools/perf/tests/workqueue.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 650aec19d49052ca..eda6c78a37cfbc13 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -64,6 +64,7 @@ perf-y += parse-metric.o
 perf-y += pe-file-parsing.o
 perf-y += expand-cgroup.o
 perf-y += perf-time-to-tsc.o
+perf-y += workqueue.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 5e6242576236325c..2ff5d38ed83a723d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -360,6 +360,15 @@ static struct test generic_tests[] = {
 		.func = test__perf_time_to_tsc,
 		.is_supported = test__tsc_is_supported,
 	},
+	{
+		.desc = "Test workqueue lib",
+		.func = test__workqueue,
+		.subtest = {
+			.skip_if_fail	= false,
+			.get_nr		= test__workqueue_subtest_get_nr,
+			.get_desc	= test__workqueue_subtest_get_desc,
+		}
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 1100dd55b657b779..9ca67113a7402463 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -127,6 +127,9 @@ int test__parse_metric(struct test *test, int subtest);
 int test__pe_file_parsing(struct test *test, int subtest);
 int test__expand_cgroup_events(struct test *test, int subtest);
 int test__perf_time_to_tsc(struct test *test, int subtest);
+int test__workqueue(struct test *test, int subtest);
+const char *test__workqueue_subtest_get_desc(int subtest);
+int test__workqueue_subtest_get_nr(void);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
new file mode 100644
index 0000000000000000..fb0e86390d466677
--- /dev/null
+++ b/tools/perf/tests/workqueue.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include "tests.h"
+#include "util/debug.h"
+#include "util/workqueue/threadpool.h"
+
+struct threadpool_test_args_t {
+	int pool_size;
+};
+
+static int __threadpool__prepare(struct threadpool **pool, int pool_size)
+{
+	*pool = threadpool__new(pool_size);
+	TEST_ASSERT_VAL("threadpool creation failure", !IS_ERR(*pool));
+	TEST_ASSERT_VAL("threadpool size is wrong",
+			threadpool__size(*pool) == pool_size);
+
+	return TEST_OK;
+}
+
+static int __threadpool__teardown(struct threadpool *pool)
+{
+	threadpool__delete(pool);
+
+	return TEST_OK;
+}
+
+
+static int __test__threadpool(void *_args)
+{
+	struct threadpool_test_args_t *args = _args;
+	struct threadpool *pool;
+	int ret;
+
+	ret = __threadpool__prepare(&pool, args->pool_size);
+	if (ret)
+		goto out;
+
+	ret = __threadpool__teardown(pool);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
+static const struct threadpool_test_args_t threadpool_test_args[] = {
+	{
+		.pool_size = 1
+	},
+	{
+		.pool_size = 2
+	},
+	{
+		.pool_size = 4
+	},
+	{
+		.pool_size = 8
+	},
+	{
+		.pool_size = 16
+	}
+};
+
+struct test_case {
+	const char *desc;
+	int (*func)(void *args);
+	void *args;
+	int n_args;
+	int arg_size;
+};
+
+static struct test_case workqueue_testcase_table[] = {
+	{
+		.desc = "Threadpool",
+		.func = __test__threadpool,
+		.args = (void *) threadpool_test_args,
+		.n_args = (int)ARRAY_SIZE(threadpool_test_args),
+		.arg_size = sizeof(struct threadpool_test_args_t)
+	}
+};
+
+
+int test__workqueue(struct test *test __maybe_unused, int i)
+{
+	int j, ret;
+	struct test_case *tc;
+
+	if (i < 0 || i >= (int)ARRAY_SIZE(workqueue_testcase_table))
+		return TEST_FAIL;
+
+	tc = &workqueue_testcase_table[i];
+
+	for (j = 0; j < tc->n_args; j++) {
+		ret = tc->func((void *)((char *)tc->args + (j*tc->arg_size)));
+		if (ret)
+			return ret;
+	}
+
+	return TEST_OK;
+}
+
+
+int test__workqueue_subtest_get_nr(void)
+{
+	return (int)ARRAY_SIZE(workqueue_testcase_table);
+}
+
+const char *test__workqueue_subtest_get_desc(int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(workqueue_testcase_table))
+		return NULL;
+	return workqueue_testcase_table[i].desc;
+}
-- 
2.31.1

