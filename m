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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96439C11F69
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D54610D1
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhGMMO2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbhGMMO0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:14:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5CC0613EE;
        Tue, 13 Jul 2021 05:11:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l6so5192718wmq.0;
        Tue, 13 Jul 2021 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/r9xbvtzQfz8z7JIGAltsdXiwLlLwykHrOPTkNqXTo=;
        b=RzWNG3VJoZi2fcRCUQlN4D5fFfp+42vxrRqIWKg/GNpVAifk+NOq0sfhSiia9iAM8+
         nZjAw8hYiyXgQyOt+f4dyXnF0g3wVLz3wskPm2cwsjAjmsaSg4jiARLWQeA8P5ORY76h
         ot6mjGMsia4qNmatR+XEbL8jverOcz6viELjqrJ44NS1fW6OqHVzarkvTZPkMOqIUjba
         NuL4C0Q2kIsnZOb9NgSqKxMtJnqONeuM0RDDsNJdCcufm3RZJQOLn4wKgdUmFVIJWuaT
         pZ/JZgZtBZHIXTBYucRulxShsWpLrFit9Hzu3Nt+pIvNEsxhKqHIU6acRXMmG/Lr0OwK
         Ueig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/r9xbvtzQfz8z7JIGAltsdXiwLlLwykHrOPTkNqXTo=;
        b=kdL0vsfyRkNoxqbeeDyZPmz/WfbGKLDFPzTbcuu5ykyNtxpe+J14JpBEF2wK93nToC
         IFdryu7fSNKJacPOjcdw+crZYbVD1AFl6WU6oUKY3MPMXcZaBNJt41RDUzwGRwJPyt31
         v2rjkdNarRibpKGDMf2brEjxWcDV7u2bL3gTvIevkA1W2ZOeIVm8SAHAKQKx/ve9PyNJ
         8HqqC7kgpCmroV/sD/qR3QtnOgbM4+Dt1q0ngTchVsIq+CXcRZawTkv3ZDwoeaNT/M/E
         iGXNZMDf3sKzyxNMOVFKhcVo194XxyptcNiNYqM9TFh7yfU1D42j4k+0tJQxrwN8wMr5
         2+DA==
X-Gm-Message-State: AOAM531VMpH/1PoPBqK+TulOY5pwuw2H3dKYMUfsWPMJ7mGT8wXfCpGV
        jpSvYQsXOsrfgly0NLFNK84=
X-Google-Smtp-Source: ABdhPJzLy58wlWB6R3xHHia8m27GHwWjYH+3zPDpxZlEXyCWOqa9JUkjbt+p3iizIAUInjuRkJ9NdA==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr19692347wme.35.1626178293332;
        Tue, 13 Jul 2021 05:11:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id o3sm17551425wrw.56.2021.07.13.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:11:32 -0700 (PDT)
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
Subject: [RFC PATCH 02/10] perf tests: add test for workqueue
Date:   Tue, 13 Jul 2021 14:11:13 +0200
Message-Id: <333e2e3986d32cf8894105f149abb543a84ec91c.1626177381.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626177381.git.rickyman7@gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
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
 tools/perf/tests/workqueue.c    | 113 ++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
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
index 0000000000000000..1bd4d78c13eb3b14
--- /dev/null
+++ b/tools/perf/tests/workqueue.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include "tests.h"
+#include "util/debug.h"
+#include "util/workqueue/threadpool.h"
+
+struct threadpool_test_args_t {
+	int pool_size;
+};
+
+static int __threadpool__prepare(struct threadpool_struct **pool, int pool_size)
+{
+	*pool = create_threadpool(pool_size);
+	TEST_ASSERT_VAL("threadpool creation failure", *pool != NULL);
+	TEST_ASSERT_VAL("threadpool size is wrong",
+			threadpool_size(*pool) == pool_size);
+
+	return 0;
+}
+
+static int __threadpool__teardown(struct threadpool_struct *pool)
+{
+	destroy_threadpool(pool);
+
+	return 0;
+}
+
+
+static int __test__threadpool(void *_args)
+{
+	struct threadpool_test_args_t *args = _args;
+	struct threadpool_struct *pool;
+	int ret;
+
+	ret = __threadpool__prepare(&pool, args->pool_size);
+	if (ret)
+		return ret;
+
+	ret = __threadpool__teardown(pool);
+	if (ret)
+		return ret;
+
+	return 0;
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
+	int j, ret = 0;
+	struct test_case *tc;
+
+	if (i < 0 || i >= (int)ARRAY_SIZE(workqueue_testcase_table))
+		return -1;
+
+	tc = &workqueue_testcase_table[i];
+
+	for (j = 0; j < tc->n_args; j++) {
+		ret = tc->func(tc->args + (j*tc->arg_size));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
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

