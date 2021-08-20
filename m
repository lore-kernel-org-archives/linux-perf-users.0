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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438DCC432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CD760FE7
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbhHTKyv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbhHTKyt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:54:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85CDC061575;
        Fri, 20 Aug 2021 03:54:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dj8so13417478edb.2;
        Fri, 20 Aug 2021 03:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+vyETyOBBOirwygtWsr2c7+loLCBKzcDDyNgccu3Nk=;
        b=GPo4JJ6J+TEFLQedg6pMSDTobHF49ATuead8pPuUxeBssmW2grsT/Ekoi/ErQkwSfQ
         EG0OqMa4hrFwatgoho5hdQhBbKL9T1Ji5MnOsz1K+dDF8dbH5dNtJYyRnOs/Ku6KBd+b
         WhoAG7U58SDGeq/dHZ7u3odMocMLKMbljaWUYFXb3PzNtkxp5XL1hKlMdU1LEQocro76
         GjX8kNS4TTNM1dyHWSd5u3y2XwwPcs19RO2k4nbb0XogHc+pwcj55123WFBF4WUK9/xE
         EEIbLb/ZmtXJX1X9udjVc4p13oix39omqVewCqgHj6WAJClAK6rK7IyMhBqpY9KUCPmK
         0a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+vyETyOBBOirwygtWsr2c7+loLCBKzcDDyNgccu3Nk=;
        b=nj9QvPF4rbZcvd/vufvdFNMsbBg+vHumzpiVKexxxWRSxtFY5DEI9L8K4yYodfLGRr
         Br3cDWcaDr8TjasHDPlHDArAbfgfXWcw8xGlAWsw/FhKl15YAdepCaR58+MVeCIor2Ro
         JPY6jVx654C7PCISPLchBg55YeELVdfQYKgt0pIhj+BjrJw1qVe3QG+ZNoa2Z13AR9KS
         fKfT96dsSVCB4l0cmHpfqYjsFJkHWQ2qJ0UuMTdNyYF/q+GDTsg1C0BGlWJzObqNS0cT
         QuoIjB8wurlUsp7smEUFxD2lzxgoqN68zC1/JVyadmBOYvJqvmFnQ/p0IfvKwg8784yy
         pqHg==
X-Gm-Message-State: AOAM531RnK0PMPel+MdLfxi2ksfiAV+xki7eqckiK3RNbBqtS5a+Ewap
        4pVfd7dzhizpWXPCjS+xHYj+H2NL9fjNJ0TpPzA=
X-Google-Smtp-Source: ABdhPJx2D8R4NDO84sJLDl0eAklyVK1iXtpMugfKXWguM8OjRgJAWSf0B9LgkIoc3xkCkLjpRnE69g==
X-Received: by 2002:a05:6402:31bc:: with SMTP id dj28mr21579866edb.143.1629456850259;
        Fri, 20 Aug 2021 03:54:10 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:09 -0700 (PDT)
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
Subject: [RFC PATCH v3 02/15] perf tests: add test for workqueue
Date:   Fri, 20 Aug 2021 12:53:48 +0200
Message-Id: <896ac80ddca8e47fd4c564f383ddc874c07aff81.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
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
 tools/perf/tests/workqueue.c    | 118 ++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 tools/perf/tests/workqueue.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 803ca426f8e65d86..0c8f89e8e3164d96 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -65,6 +65,7 @@ perf-y += pe-file-parsing.o
 perf-y += expand-cgroup.o
 perf-y += perf-time-to-tsc.o
 perf-y += dlfilter-test.o
+perf-y += workqueue.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index fb5846db02e17823..5902831344daa126 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -364,6 +364,15 @@ static struct test generic_tests[] = {
 		.desc = "dlfilter C API",
 		.func = test__dlfilter,
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
index fe1306f584958de1..ef9ffa7c62d74edc 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -128,6 +128,9 @@ int test__pe_file_parsing(struct test *test, int subtest);
 int test__expand_cgroup_events(struct test *test, int subtest);
 int test__perf_time_to_tsc(struct test *test, int subtest);
 int test__dlfilter(struct test *test, int subtest);
+int test__workqueue(struct test *test, int subtest);
+const char *test__workqueue_subtest_get_desc(int subtest);
+int test__workqueue_subtest_get_nr(void);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
new file mode 100644
index 0000000000000000..469b154d7522f132
--- /dev/null
+++ b/tools/perf/tests/workqueue.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
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
+static int __test__threadpool(void *_args)
+{
+	struct threadpool_test_args_t *args = _args;
+	struct threadpool *pool;
+	int pool_size = args->pool_size ?: sysconf(_SC_NPROCESSORS_ONLN);
+	int ret = __threadpool__prepare(&pool, pool_size);
+
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
+	},
+	{
+		.pool_size = 0	// sysconf(_SC_NPROCESSORS_ONLN)
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

