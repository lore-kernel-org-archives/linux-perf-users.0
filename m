Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B367C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 11:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFADB61C4F
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 11:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhKOLb7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhKOLb4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 06:31:56 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCCEC061746
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Nov 2021 03:29:00 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso2651422wrw.7
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Nov 2021 03:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xf9u2CscKkkxKfWTXnB3UoCYnr7mB7Mfxpso9hhGJvU=;
        b=lCCgT0Pg/s0d5kWjOirDWetiOTfHhG/rOIc+xzoJMaGxpLGfVM815S16HQ7dw0go19
         sb7L0qY4qRM8Id5NXOfaPLPzRyFlgPrvtqti4swO7J5wfLURaRu0Q3WQCUEMa940SVal
         thwlHIAIUtbbSTqZEzhqzGRSKqNeLcMNyxjZ8QjWYQ9H+5y4JMcQB0Fwbd6cgGxBEjsh
         s/7exRMWG3X1Ccdr6e2sKTnMH/4c3DNlGE0UemYSnc+NBo5d/ng+9NlbqTDgxZEaSGdx
         ntq1CpHrMFbIXloxSiA5qr2CIo07yENP8hBvxp0HE9ZIBdrcWUca2+KmJl7AssUxKeuo
         OhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xf9u2CscKkkxKfWTXnB3UoCYnr7mB7Mfxpso9hhGJvU=;
        b=RX3cjl9bCDgVmT4TtSXYFa3mqNMSJWEwKhhW8bqW9eWmCnJOCG8IvNoZ5TgqVJbZda
         seW7CmwquYrocHiFm3XAdihBodlHCico6FyM5DhTbfO6LBXhh4YDIBI+T1VFm+lBBHUj
         MfpbGZmsa5xT9eZB+SIphFi7SEME6G6adlF0BOSVjokTZZQb32LjSItzbdUSb6ObY74v
         b9Qsd05oAzr9KbmJfhXq7xywuPTo0p/TLjdDlWUsBItFoc2UvGiTSc/oJNHyZM+gHCDA
         dycYD8IscjdVBnB5Ug2jRS7wGMj6zcA/S+xWn9HjMKqOjtvGL4XgmMxddp5IdncmMLlZ
         DgDw==
X-Gm-Message-State: AOAM531IIMCpdZzmInl7oDwFpfaXm1szyiiM6RFWw7lqqf17mFv0tHgp
        s8gKRRWKyokMwU9HyXf5tqvGIp/rgw==
X-Google-Smtp-Source: ABdhPJy44OmjsRfhXZqtGzrTHSHnR7sJeJ592+WMWmAMcYSNScvLc0qF4MOaa/uij/ycYan2ozVuYFPuAQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6385:6bd0:4ede:d8c6])
 (user=elver job=sendgmr) by 2002:a05:600c:104b:: with SMTP id
 11mr60511649wmx.54.1636975739083; Mon, 15 Nov 2021 03:28:59 -0800 (PST)
Date:   Mon, 15 Nov 2021 12:28:23 +0100
Message-Id: <20211115112822.4077224-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] perf test: Add basic stress test for sigtrap handling
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabian Hemmer <copy@copy.sh>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add basic stress test for sigtrap handling as a perf tool built-in test.
This allows sanity checking the basic sigtrap functionality from within
the perf tool.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/sigtrap.c      | 154 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 157 insertions(+)
 create mode 100644 tools/perf/tests/sigtrap.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 803ca426f8e6..af2b37ef7c70 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -65,6 +65,7 @@ perf-y += pe-file-parsing.o
 perf-y += expand-cgroup.o
 perf-y += perf-time-to-tsc.o
 perf-y += dlfilter-test.o
+perf-y += sigtrap.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8cb5a1c3489e..f1e6d2a3a578 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -107,6 +107,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__expand_cgroup_events,
 	&suite__perf_time_to_tsc,
 	&suite__dlfilter,
+	&suite__sigtrap,
 	NULL,
 };
 
diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
new file mode 100644
index 000000000000..febfa1609356
--- /dev/null
+++ b/tools/perf/tests/sigtrap.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Basic test for sigtrap support.
+ *
+ * Copyright (C) 2021, Google LLC.
+ */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <linux/hw_breakpoint.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "cloexec.h"
+#include "debug.h"
+#include "event.h"
+#include "tests.h"
+#include "../perf-sys.h"
+
+#define NUM_THREADS 5
+
+static struct {
+	int tids_want_signal;		/* Which threads still want a signal. */
+	int signal_count;		/* Sanity check number of signals received. */
+	volatile int iterate_on;	/* Variable to set breakpoint on. */
+	siginfo_t first_siginfo;	/* First observed siginfo_t. */
+} ctx;
+
+#define TEST_SIG_DATA (~(unsigned long)(&ctx.iterate_on))
+
+static struct perf_event_attr make_event_attr(void)
+{
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_BREAKPOINT,
+		.size		= sizeof(attr),
+		.sample_period	= 1,
+		.disabled	= 1,
+		.bp_addr	= (unsigned long)&ctx.iterate_on,
+		.bp_type	= HW_BREAKPOINT_RW,
+		.bp_len		= HW_BREAKPOINT_LEN_1,
+		.inherit	= 1, /* Children inherit events ... */
+		.inherit_thread = 1, /* ... but only cloned with CLONE_THREAD. */
+		.remove_on_exec = 1, /* Required by sigtrap. */
+		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
+		.sig_data	= TEST_SIG_DATA,
+	};
+	return attr;
+}
+
+static void
+sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
+{
+	if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
+		ctx.first_siginfo = *info;
+	__atomic_fetch_sub(&ctx.tids_want_signal, syscall(SYS_gettid), __ATOMIC_RELAXED);
+}
+
+static void *test_thread(void *arg)
+{
+	pthread_barrier_t *barrier = (pthread_barrier_t *)arg;
+	pid_t tid = syscall(SYS_gettid);
+	int i;
+
+	pthread_barrier_wait(barrier);
+
+	__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
+	for (i = 0; i < ctx.iterate_on - 1; i++)
+		__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
+
+	return NULL;
+}
+
+static int run_test_threads(pthread_t *threads, pthread_barrier_t *barrier)
+{
+	int i;
+
+	pthread_barrier_wait(barrier);
+	for (i = 0; i < NUM_THREADS; i++)
+		TEST_ASSERT_EQUAL("pthread_join() failed", pthread_join(threads[i], NULL), 0);
+
+	return TEST_OK;
+}
+
+static int run_stress_test(int fd, pthread_t *threads, pthread_barrier_t *barrier)
+{
+	int ret;
+
+	ctx.iterate_on = 3000;
+
+	TEST_ASSERT_EQUAL("misfired signal?", ctx.signal_count, 0);
+	TEST_ASSERT_EQUAL("enable failed", ioctl(fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	ret = run_test_threads(threads, barrier);
+	TEST_ASSERT_EQUAL("disable failed", ioctl(fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+
+	TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_THREADS * ctx.iterate_on);
+	TEST_ASSERT_EQUAL("missing signals or incorrectly delivered", ctx.tids_want_signal, 0);
+	TEST_ASSERT_VAL("unexpected si_addr", ctx.first_siginfo.si_addr == &ctx.iterate_on);
+#if 0 /* FIXME: enable when libc's signal.h has si_perf_{type,data} */
+	TEST_ASSERT_EQUAL("unexpected si_perf_type", ctx.first_siginfo.si_perf_type,
+			  PERF_TYPE_BREAKPOINT);
+	TEST_ASSERT_EQUAL("unexpected si_perf_data", ctx.first_siginfo.si_perf_data,
+			  TEST_SIG_DATA);
+#endif
+
+	return ret;
+}
+
+static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_event_attr attr = make_event_attr();
+	struct sigaction action = {};
+	struct sigaction oldact;
+	pthread_t threads[NUM_THREADS];
+	pthread_barrier_t barrier;
+	int i, fd, ret = TEST_FAIL;
+
+	pthread_barrier_init(&barrier, NULL, NUM_THREADS + 1);
+
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = sigtrap_handler;
+	sigemptyset(&action.sa_mask);
+	if (sigaction(SIGTRAP, &action, &oldact)) {
+		pr_debug("FAILED sigaction()\n");
+		goto out;
+	}
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
+	if (fd < 0) {
+		pr_debug("FAILED sys_perf_event_open()\n");
+		goto out_restore_sigaction;
+	}
+
+	for (i = 0; i < NUM_THREADS; i++) {
+		if (pthread_create(&threads[i], NULL, test_thread, &barrier)) {
+			pr_debug("FAILED pthread_create()");
+			goto out_close_perf_event;
+		}
+	}
+
+	ret = run_stress_test(fd, threads, &barrier);
+
+out_close_perf_event:
+	close(fd);
+out_restore_sigaction:
+	sigaction(SIGTRAP, &oldact, NULL);
+out:
+	pthread_barrier_destroy(&barrier);
+	return ret;
+}
+
+DEFINE_SUITE("Sigtrap", sigtrap);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 8f65098110fc..5bbb8f6a48fc 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -146,6 +146,7 @@ DECLARE_SUITE(pe_file_parsing);
 DECLARE_SUITE(expand_cgroup_events);
 DECLARE_SUITE(perf_time_to_tsc);
 DECLARE_SUITE(dlfilter);
+DECLARE_SUITE(sigtrap);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.34.0.rc1.387.gb447b232ab-goog

