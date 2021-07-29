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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA432C4320A
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 06:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7897961053
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 06:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhG2GZM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 02:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhG2GZK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 02:25:10 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66890C0613D5
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jul 2021 23:25:05 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q9-20020a05620a0c89b02903ba3e0f08d7so3221730qki.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jul 2021 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uw0Gyu6bCp2Vq2aFz2fF747PX7qZeAKd0jeoM6fTkx0=;
        b=qb7+T/uhk++iHTj1i+I9e2GiPJF0Zu3+AL7KiD5ddW4gNR3ZyBpnWTn9/3TDUUlAC9
         Idxt2AlAVf3vDFYkB8cHdrGxd8Arbxgw0w4w1aJCZpy4ujaD7Wb6NV+DlohGrSSR5Jw8
         TPsn8pCB+0G9GQvjed/Zq9eV3Y/yGKjPQ5DU/8+yEvR1YQqSLB3abubDg9Ssa8lZlVMV
         SD1j5fFNnmDa8x+vR0WHbvjJCXDhQTmOdWkbYO6X4B4B+OddBvxGEGxnBmviDnmZI+pm
         OomU6f7I+SlO9WzrEyjrZh++aQd6XwmsjYFvtYbgC5DTnu8/qfLSjmo4Um5zM+UKC8kG
         xWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uw0Gyu6bCp2Vq2aFz2fF747PX7qZeAKd0jeoM6fTkx0=;
        b=AXtEwXYrudUP6BeduW9t8WlEWbMXOrZj/P5v2tEyHZA0xKQ18IK7ULTZ0HG2/1XyvM
         A9Pj/vE24lry97vZ1Jzi9bvvtk/8cM0Ym7Fz0m14D3SBXEQD6GbHs4oHa6rfeL7KMP30
         XGqZqqG94PHqMo6Duo07P3xgfZPc7K4l7Y0TwTNKAFJyCWmoZzoOErbXxnPW6wDJdzRx
         SoPnF5B9pvTllNWXAFacglSiJyqolrB95TtdulRUhJidLhyEl1A1xZDw3k1cumAPHqJZ
         xvVENXAh+0hEFQd2G2GpclPXM49yJj7egIl7UEa9qJ29Jn4Cb7nzwK7FYafdegrlJOak
         L7Dw==
X-Gm-Message-State: AOAM530tv4uUgwaAbxudpsal55B9gqkHs0fymRzG6/4M6SZ0XjIETPL3
        WdiMWdd9f+9vz1kO4YLeLHHNEByRd2SE
X-Google-Smtp-Source: ABdhPJy1yf/XFKLYeAA/3ASSBwQ/WCGgiSbFbap7ZUKvGgXD9hr4NV00XcC6NXItDnOOVIx6qFdNZqmi8VAi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8f98:bc28:73a6:e8c9])
 (user=irogers job=sendgmr) by 2002:a05:6214:29c7:: with SMTP id
 gh7mr3776665qvb.36.1627539904518; Wed, 28 Jul 2021 23:25:04 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:24:51 -0700
In-Reply-To: <20210729062451.1349566-1-irogers@google.com>
Message-Id: <20210729062451.1349566-4-irogers@google.com>
Mime-Version: 1.0
References: <20210729062451.1349566-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 3/3] perf test: Be more consistent in use of TEST_*
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The TEST_OK, TEST_FAIL and TEST_SKIP enum values are used
inconsistently. Try to reduce this by swapping constants for enum values
to try to be more intention revealing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/rdpmc.c           |   8 +-
 tools/perf/tests/attr.c                     |   2 +-
 tools/perf/tests/bitmap.c                   |   2 +-
 tools/perf/tests/bp_account.c               |   4 +-
 tools/perf/tests/bp_signal.c                |  51 +++++++--
 tools/perf/tests/code-reading.c             |  12 +-
 tools/perf/tests/cpumap.c                   |  10 +-
 tools/perf/tests/dso-data.c                 |   8 +-
 tools/perf/tests/dwarf-unwind.c             |  14 ++-
 tools/perf/tests/event-times.c              |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c     |  14 +--
 tools/perf/tests/evsel-tp-sched.c           |  28 ++---
 tools/perf/tests/expr.c                     |   4 +-
 tools/perf/tests/fdarray.c                  |   4 +-
 tools/perf/tests/genelf.c                   |   2 +-
 tools/perf/tests/hists_cumulate.c           |   2 +-
 tools/perf/tests/hists_filter.c             |  12 +-
 tools/perf/tests/hists_link.c               |  33 +++---
 tools/perf/tests/keep-tracking.c            |   4 +-
 tools/perf/tests/kmod-path.c                |   6 +-
 tools/perf/tests/mem.c                      |   4 +-
 tools/perf/tests/mem2node.c                 |   2 +-
 tools/perf/tests/mmap-basic.c               |  10 +-
 tools/perf/tests/mmap-thread-lookup.c       |   2 +-
 tools/perf/tests/openat-syscall-all-cpus.c  |   4 +-
 tools/perf/tests/openat-syscall-tp-fields.c |   4 +-
 tools/perf/tests/openat-syscall.c           |   6 +-
 tools/perf/tests/parse-events.c             | 118 ++++++++++----------
 tools/perf/tests/parse-metric.c             |  16 +--
 tools/perf/tests/parse-no-sample-id-all.c   |   4 +-
 tools/perf/tests/perf-hooks.c               |   2 +-
 tools/perf/tests/perf-record.c              |   2 +-
 tools/perf/tests/perf-time-to-tsc.c         |   4 +-
 tools/perf/tests/pfm.c                      |   4 +-
 tools/perf/tests/pmu-events.c               |  36 +++---
 tools/perf/tests/pmu.c                      |  16 +--
 tools/perf/tests/python-use.c               |   2 +-
 tools/perf/tests/sample-parsing.c           |  10 +-
 tools/perf/tests/stat.c                     |  12 +-
 tools/perf/tests/sw-clock.c                 |   8 +-
 tools/perf/tests/switch-tracking.c          |   9 +-
 tools/perf/tests/task-exit.c                |  12 +-
 tools/perf/tests/tests.h                    |   4 +-
 tools/perf/tests/thread-map.c               |   8 +-
 tools/perf/tests/thread-maps-share.c        |   2 +-
 tools/perf/tests/time-utils-test.c          |   2 +-
 tools/perf/tests/topology.c                 |   2 +-
 tools/perf/tests/vmlinux-kallsyms.c         |   6 +-
 tools/perf/tests/wp.c                       |  10 +-
 49 files changed, 292 insertions(+), 251 deletions(-)

diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index 1ea916656a2d..2632275fc181 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -89,7 +89,7 @@ static void segfault_handler(int sig __maybe_unused,
 			     siginfo_t *info __maybe_unused,
 			     void *uc __maybe_unused)
 {
-	exit(-1);
+	exit(TEST_FAIL);
 }
 
 static int __test__rdpmc(void)
@@ -119,7 +119,7 @@ static int __test__rdpmc(void)
 		pr_err("Error: sys_perf_event_open() syscall returned "
 		       "with %d (%s)\n", fd,
 		       str_error_r(errno, sbuf, sizeof(sbuf)));
-		return -1;
+		return TEST_FAIL;
 	}
 
 	addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
@@ -152,9 +152,9 @@ static int __test__rdpmc(void)
 	close(fd);
 
 	if (!delta_sum)
-		return -1;
+		return TEST_FAIL;
 
-	return 0;
+	return TEST_OK;
 }
 
 int test__rdpmc(struct test *test __maybe_unused, int subtest __maybe_unused)
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 9b40a25376ae..6457c4dbe411 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -194,7 +194,7 @@ int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
 
 	exec_path = get_argv_exec_path();
 	if (exec_path == NULL)
-		return -1;
+		return TEST_FAIL;
 
 	/* Then installed path. */
 	snprintf(path_dir,  PATH_MAX, "%s/tests", exec_path);
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 96c137360918..ff1c77e86cdc 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -49,5 +49,5 @@ int test__bitmap_print(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1,3-6,8-10,24,35-37"));
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1,3-6,8-10,24,35-37"));
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1-10,12-20,22-30,32-40"));
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 489b50604cf2..a946da39b9e0 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -49,7 +49,7 @@ static int __event(bool is_x, void *addr, struct perf_event_attr *attr)
 				 perf_event_open_cloexec_flag());
 	if (fd < 0) {
 		pr_debug("failed opening event %llx\n", attr->config);
-		return TEST_FAIL;
+		return -1;
 	}
 
 	return fd;
@@ -94,7 +94,7 @@ static int bp_accounting(int wp_cnt, int share)
 	for (i = 0; i < wp_cnt; i++)
 		close(fd[i]);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int detect_cnt(bool is_x)
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index ef37353636d8..9ae4b26d3ad9 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -125,7 +125,7 @@ static int __event(bool is_x, void *addr, int sig)
 				 perf_event_open_cloexec_flag());
 	if (fd < 0) {
 		pr_debug("failed opening event %llx\n", pe.config);
-		return TEST_FAIL;
+		return -1;
 	}
 
 	fcntl(fd, F_SETFL, O_RDWR|O_NONBLOCK|O_ASYNC);
@@ -165,6 +165,7 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 {
 	struct sigaction sa;
 	long long count1, count2, count3;
+	int ret;
 
 	/* setup SIGIO signal handler */
 	memset(&sa, 0, sizeof(struct sigaction));
@@ -234,8 +235,24 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 	 */
 
 	fd1 = bp_event(__test_function, SIGIO);
+	fd2 = -1;
+	fd3 = -1;
+	if (fd1 == -1)
+		return TEST_FAIL;
+
 	fd2 = bp_event(sig_handler, SIGUSR1);
+	if (fd2 == -1) {
+		ret = TEST_FAIL;
+		goto err_out;
+	}
+
 	fd3 = wp_event((void *)&the_var, SIGIO);
+	if (fd3 == -1) {
+		ret = TEST_FAIL;
+		goto err_out;
+	}
+
+	ret = TEST_OK;
 
 	ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0);
 	ioctl(fd2, PERF_EVENT_IOC_ENABLE, 0);
@@ -255,34 +272,46 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 	count2 = bp_count(fd2);
 	count3 = bp_count(fd3);
 
-	close(fd1);
-	close(fd2);
-	close(fd3);
-
 	pr_debug("count1 %lld, count2 %lld, count3 %lld, overflow %d, overflows_2 %d\n",
 		 count1, count2, count3, overflows, overflows_2);
 
 	if (count1 != 1) {
+		ret = TEST_FAIL;
 		if (count1 == 11)
 			pr_debug("failed: RF EFLAG recursion issue detected\n");
 		else
 			pr_debug("failed: wrong count for bp1: %lld, expected 1\n", count1);
 	}
 
-	if (overflows != 3)
+	if (overflows != 3) {
+		ret = TEST_FAIL;
 		pr_debug("failed: wrong overflow (%d) hit, expected 3\n", overflows);
+	}
 
-	if (overflows_2 != 3)
+	if (overflows_2 != 3) {
+		ret = TEST_FAIL;
 		pr_debug("failed: wrong overflow_2 (%d) hit, expected 3\n", overflows_2);
+	}
 
-	if (count2 != 3)
+	if (count2 != 3) {
+		ret = TEST_FAIL;
 		pr_debug("failed: wrong count for bp2 (%lld), expected 3\n", count2);
+	}
 
-	if (count3 != 2)
+	if (count3 != 2) {
+		ret = TEST_FAIL;
 		pr_debug("failed: wrong count for bp3 (%lld), expected 2\n", count3);
+	}
+
+err_out:
+	if (fd1 != -1)
+		close(fd1);
+	if (fd2 != -1)
+		close(fd2);
+	if (fd3 != -1)
+		close(fd3);
 
-	return count1 == 1 && overflows == 3 && count2 == 3 && overflows_2 == 3 && count3 == 2 ?
-		TEST_OK : TEST_FAIL;
+	return ret;
 }
 
 bool test__bp_signal_is_supported(void)
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 9866cddebf23..70e92e074dba 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -725,20 +725,20 @@ int test__code_reading(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	switch (ret) {
 	case TEST_CODE_READING_OK:
-		return 0;
+		return TEST_OK;
 	case TEST_CODE_READING_NO_VMLINUX:
 		pr_debug("no vmlinux\n");
-		return 0;
+		return TEST_SKIP;
 	case TEST_CODE_READING_NO_KCORE:
 		pr_debug("no kcore\n");
-		return 0;
+		return TEST_SKIP;
 	case TEST_CODE_READING_NO_ACCESS:
 		pr_debug("no access\n");
-		return 0;
+		return TEST_SKIP;
 	case TEST_CODE_READING_NO_KERNEL_OBJ:
 		pr_debug("no kernel obj\n");
-		return 0;
+		return TEST_SKIP;
 	default:
-		return -1;
+		return TEST_FAIL;
 	};
 }
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 0472b110fe65..bfcb85a965bb 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -42,7 +42,7 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
 	}
 
 	perf_cpu_map__put(map);
-	return 0;
+	return TEST_OK;
 }
 
 static int process_event_cpus(struct perf_tool *tool __maybe_unused,
@@ -71,7 +71,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong cpu", map->map[1] == 256);
 	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
 	perf_cpu_map__put(map);
-	return 0;
+	return TEST_OK;
 }
 
 
@@ -94,7 +94,7 @@ int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __may
 		!perf_event__synthesize_cpu_map(NULL, cpus, process_event_cpus, NULL));
 
 	perf_cpu_map__put(cpus);
-	return 0;
+	return TEST_OK;
 }
 
 static int cpu_map_print(const char *str)
@@ -120,7 +120,7 @@ int test__cpu_map_print(struct test *test __maybe_unused, int subtest __maybe_un
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,3-6,8-10,24,35-37"));
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,3-6,8-10,24,35-37"));
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1-10,12-20,22-30,32-40"));
-	return 0;
+	return TEST_OK;
 }
 
 int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_unused)
@@ -135,5 +135,5 @@ int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_un
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
 	perf_cpu_map__put(b);
 	perf_cpu_map__put(c);
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 627c1aaf1c9e..09b3c8a5eecb 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -171,7 +171,7 @@ int test__dso_data(struct test *test __maybe_unused, int subtest __maybe_unused)
 
 	dso__put(dso);
 	unlink(file);
-	return 0;
+	return TEST_OK;
 }
 
 static long open_files_cnt(void)
@@ -218,7 +218,7 @@ static int dsos__create(int cnt, int size)
 		TEST_ASSERT_VAL("failed to get dso", dsos[i]);
 	}
 
-	return 0;
+	return TEST_OK;
 }
 
 static void dsos__delete(int cnt)
@@ -305,7 +305,7 @@ int test__dso_data_cache(struct test *test __maybe_unused, int subtest __maybe_u
 	nr_end = open_files_cnt();
 	pr_debug("nr start %ld, nr stop %ld\n", nr, nr_end);
 	TEST_ASSERT_VAL("failed leaking files", nr == nr_end);
-	return 0;
+	return TEST_OK;
 }
 
 int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_unused)
@@ -381,5 +381,5 @@ int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_
 	nr_end = open_files_cnt();
 	pr_debug("nr start %ld, nr stop %ld\n", nr, nr_end);
 	TEST_ASSERT_VAL("failed leaking files", nr == nr_end);
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index a288035eb362..98093c3afe86 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -95,7 +95,7 @@ noinline int test_dwarf_unwind__thread(struct thread *thread)
 {
 	struct perf_sample sample;
 	unsigned long cnt = 0;
-	int err = -1;
+	int err = TEST_FAIL;
 
 	memset(&sample, 0, sizeof(sample));
 
@@ -108,10 +108,12 @@ noinline int test_dwarf_unwind__thread(struct thread *thread)
 				  &sample, MAX_STACK);
 	if (err)
 		pr_debug("unwind failed\n");
-	else if (cnt != MAX_STACK) {
+
+	err = err ? TEST_FAIL : TEST_OK;
+	if (cnt != MAX_STACK) {
 		pr_debug("got wrong number of stack entries %lu != %d\n",
 			 cnt, MAX_STACK);
-		err = -1;
+		err = TEST_FAIL;
 	}
 
  out:
@@ -174,17 +176,17 @@ int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unu
 {
 	struct machine *machine;
 	struct thread *thread;
-	int err = -1;
+	int err = TEST_FAIL;
 
 	machine = machine__new_host();
 	if (!machine) {
 		pr_err("Could not get machine\n");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	if (machine__create_kernel_maps(machine)) {
 		pr_err("Failed to create kernel maps\n");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	callchain_param.record_mode = CALLCHAIN_DWARF;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 04ce4401f775..b88154557499 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -218,7 +218,7 @@ static int test_times(int (attach)(struct evlist *),
  */
 int test__event_times(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err, ret = 0;
+	int err, ret = TEST_OK;
 
 #define _T(attach, detach)			\
 	err = test_times(attach, detach);	\
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 5ebf56331904..f32b00f7543b 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -11,12 +11,12 @@
 static int perf_evsel__roundtrip_cache_name_test(void)
 {
 	char name[128];
-	int type, op, err = 0, ret = 0, i, idx;
+	int type, op, err, ret = TEST_OK, i, idx;
 	struct evsel *evsel;
 	struct evlist *evlist = evlist__new();
 
         if (evlist == NULL)
-                return -ENOMEM;
+		return TEST_FAIL;
 
 	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
 		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
@@ -28,7 +28,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
 				err = parse_events(evlist, name, NULL);
 				if (err)
-					ret = err;
+					ret = TEST_FAIL;
 			}
 		}
 	}
@@ -51,7 +51,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 
 				if (strcmp(evsel__name(evsel), name)) {
 					pr_debug("%s != %s\n", evsel__name(evsel), name);
-					ret = -1;
+					ret = TEST_FAIL;
 				}
 
 				evsel = evsel__next(evsel);
@@ -71,7 +71,7 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names,
 	struct evlist *evlist = evlist__new();
 
         if (evlist == NULL)
-                return -ENOMEM;
+		return TEST_FAIL;
 
 	for (i = 0; i < nr_names; ++i) {
 		err = parse_events(evlist, names[i], NULL);
@@ -82,7 +82,7 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names,
 		}
 	}
 
-	err = 0;
+	err = TEST_OK;
 	evlist__for_each_entry(evlist, evsel) {
 		if (strcmp(evsel__name(evsel), names[evsel->core.idx / distance])) {
 			--err;
@@ -100,7 +100,7 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names,
 
 int test__perf_evsel__roundtrip_name_test(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err = 0, ret = 0;
+	int err, ret = TEST_OK;
 
 	if (perf_pmu__has_hybrid())
 		return perf_evsel__name_array_test(evsel__hw_names, 2);
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index f9e34bd26cf3..480e68df593a 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -35,33 +35,33 @@ static int evsel__test_field(struct evsel *evsel, const char *name, int size, bo
 int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct evsel *evsel = evsel__newtp("sched", "sched_switch");
-	int ret = 0;
+	int ret = TEST_OK;
 
 	if (IS_ERR(evsel)) {
 		pr_debug("evsel__newtp failed with %ld\n", PTR_ERR(evsel));
-		return -1;
+		return TEST_FAIL;
 	}
 
 	if (evsel__test_field(evsel, "prev_comm", 16, false))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prev_pid", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prev_prio", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "next_comm", 16, false))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "next_pid", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "next_prio", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	evsel__delete(evsel);
 
@@ -69,20 +69,20 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 
 	if (IS_ERR(evsel)) {
 		pr_debug("evsel__newtp failed with %ld\n", PTR_ERR(evsel));
-		return -1;
+		return TEST_FAIL;
 	}
 
 	if (evsel__test_field(evsel, "comm", 16, false))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "pid", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "prio", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	if (evsel__test_field(evsel, "target_cpu", 4, true))
-		ret = -1;
+		ret = TEST_FAIL;
 
 	evsel__delete(evsel);
 	return ret;
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 4d01051951cd..377d9a678781 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -13,7 +13,7 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 	if (expr__parse(&val, ctx, e, 1))
 		TEST_ASSERT_VAL("parse test failed", 0);
 	TEST_ASSERT_VAL("unexpected value", val == val2);
-	return 0;
+	return TEST_OK;
 }
 
 int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
@@ -84,5 +84,5 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	expr__ctx_clear(&ctx);
 
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
index d9eca8e86a6b..6f457f1d4971 100644
--- a/tools/perf/tests/fdarray.c
+++ b/tools/perf/tests/fdarray.c
@@ -82,7 +82,7 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
 
 	pr_debug("\n");
 
-	err = 0;
+	err = TEST_OK;
 out_delete:
 	fdarray__delete(fda);
 out:
@@ -152,7 +152,7 @@ int test__fdarray__add(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	pr_debug("\n");
 
-	err = 0;
+	err = TEST_OK;
 out_delete:
 	fdarray__delete(fda);
 out:
diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
index f797f9823e89..597f2bc10b82 100644
--- a/tools/perf/tests/genelf.c
+++ b/tools/perf/tests/genelf.c
@@ -44,7 +44,7 @@ int test__jit_write_elf(struct test *test __maybe_unused,
 
 	unlink(path);
 
-	return ret ? TEST_FAIL : 0;
+	return ret ? TEST_FAIL : TEST_OK;
 #else
 	return TEST_SKIP;
 #endif
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 890cb1f5bf53..727ca48118ad 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -243,7 +243,7 @@ static int do_test(struct hists *hists, struct result *expected, size_t nr_expec
 			i == nr_expected);
 	TEST_ASSERT_VAL("Incorrect number of callchain entry",
 			!symbol_conf.use_callchain || nr_expected == nr_callchain);
-	return 0;
+	return TEST_OK;
 }
 
 /* NO callchain + NO children */
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index ca6120cd1d90..a06c6bb752c6 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -94,7 +94,7 @@ static int add_hist_entries(struct evlist *evlist,
 		}
 	}
 
-	return 0;
+	return TEST_OK;
 
 out:
 	pr_debug("Not enough memory for adding a hist entry\n");
@@ -103,7 +103,7 @@ static int add_hist_entries(struct evlist *evlist,
 
 int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err = TEST_FAIL;
+	int err;
 	struct machines machines;
 	struct machine *machine;
 	struct evsel *evsel;
@@ -112,11 +112,15 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("No memory", evlist);
 
 	err = parse_events(evlist, "cpu-clock", NULL);
-	if (err)
+	if (err) {
+		err = TEST_FAIL;
 		goto out;
+	}
 	err = parse_events(evlist, "task-clock", NULL);
-	if (err)
+	if (err) {
+		err = TEST_FAIL;
 		goto out;
+	}
 	err = TEST_FAIL;
 
 	/* default sort order (comm,dso,sym) will be used */
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index a024d3f3a412..8fe892899b4a 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -119,11 +119,11 @@ static int add_hist_entries(struct evlist *evlist, struct machine *machine)
 		i++;
 	}
 
-	return 0;
+	return TEST_OK;
 
 out:
 	pr_debug("Not enough memory for adding a hist entry\n");
-	return -1;
+	return TEST_FAIL;
 }
 
 static int find_sample(struct sample *samples, size_t nr_samples,
@@ -222,7 +222,7 @@ static int __validate_link(struct hists *hists, int idx)
 			count_pair++;
 		} else if (idx) {
 			pr_debug("A entry from the other hists should have pair\n");
-			return -1;
+			return TEST_FAIL;
 		}
 
 		count++;
@@ -236,27 +236,27 @@ static int __validate_link(struct hists *hists, int idx)
 		if (count_dummy != ARRAY_SIZE(fake_samples[1]) - 1) {
 			pr_debug("Invalid count of dummy entries: %zd of %zd\n",
 				 count_dummy, ARRAY_SIZE(fake_samples[1]) - 1);
-			return -1;
+			return TEST_FAIL;
 		}
 		if (count != count_pair + ARRAY_SIZE(fake_samples[0])) {
 			pr_debug("Invalid count of total leader entries: %zd of %zd\n",
 				 count, count_pair + ARRAY_SIZE(fake_samples[0]));
-			return -1;
+			return TEST_FAIL;
 		}
 	} else {
 		if (count != count_pair) {
 			pr_debug("Invalid count of total other entries: %zd of %zd\n",
 				 count, count_pair);
-			return -1;
+			return TEST_FAIL;
 		}
 		if (count_dummy > 0) {
 			pr_debug("Other hists should not have dummy entries: %zd\n",
 				 count_dummy);
-			return -1;
+			return TEST_FAIL;
 		}
 	}
 
-	return 0;
+	return TEST_OK;
 }
 
 static int validate_link(struct hists *leader, struct hists *other)
@@ -266,7 +266,7 @@ static int validate_link(struct hists *leader, struct hists *other)
 
 int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err = -1;
+	int err = TEST_FAIL;
 	struct hists *hists, *first_hists;
 	struct machines machines;
 	struct machine *machine = NULL;
@@ -274,15 +274,18 @@ int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unuse
 	struct evlist *evlist = evlist__new();
 
 	if (evlist == NULL)
-                return -ENOMEM;
+		return TEST_FAIL;
 
 	err = parse_events(evlist, "cpu-clock", NULL);
-	if (err)
+	if (err) {
+		err = TEST_FAIL;
 		goto out;
+	}
 	err = parse_events(evlist, "task-clock", NULL);
-	if (err)
+	if (err) {
+		err = TEST_FAIL;
 		goto out;
-
+	}
 	err = TEST_FAIL;
 	/* default sort order (comm,dso,sym) will be used */
 	if (setup_sorting(NULL) < 0)
@@ -300,7 +303,7 @@ int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unuse
 
 	/* process sample events */
 	err = add_hist_entries(evlist, machine);
-	if (err < 0)
+	if (err != TEST_OK)
 		goto out;
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -329,7 +332,7 @@ int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unuse
 	if (err)
 		goto out;
 
-	err = 0;
+	err = TEST_OK;
 
 out:
 	/* tear down everything */
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index a0438b0f0805..8a8115ffd39b 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -75,7 +75,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	struct perf_cpu_map *cpus = NULL;
 	struct evlist *evlist = NULL;
 	struct evsel *evsel = NULL;
-	int found, err = -1;
+	int found, err = TEST_FAIL;
 	const char *comm;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
@@ -148,7 +148,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 		goto out_err;
 	}
 
-	err = 0;
+	err = TEST_OK;
 
 out_err:
 	if (evlist) {
diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index e483210b176b..3550a78c508e 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -29,7 +29,7 @@ static int test(const char *path, bool alloc_name, bool kmod,
 		TEST_ASSERT_VAL("wrong name", !m.name);
 
 	free(m.name);
-	return 0;
+	return TEST_OK;
 }
 
 static int test_is_kernel_module(const char *path, int cpumode, bool expect)
@@ -38,7 +38,7 @@ static int test_is_kernel_module(const char *path, int cpumode, bool expect)
 			(!!is_kernel_module(path, cpumode)) == (!!expect));
 	pr_debug("%s (cpumode: %d) - is_kernel_module: %s\n",
 			path, cpumode, expect ? "true" : "false");
-	return 0;
+	return TEST_OK;
 }
 
 #define T(path, an, k, c, n) \
@@ -157,5 +157,5 @@ int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_un
 	M("[kernel.kallsyms]", PERF_RECORD_MISC_KERNEL, false);
 	M("[kernel.kallsyms]", PERF_RECORD_MISC_USER, false);
 
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/mem.c b/tools/perf/tests/mem.c
index 673a11a6cd1b..52e6279f056e 100644
--- a/tools/perf/tests/mem.c
+++ b/tools/perf/tests/mem.c
@@ -20,12 +20,12 @@ static int check(union perf_mem_data_src data_src,
 	n += perf_mem__lvl_scnprintf(out + n, sizeof out - n, &mi);
 	scnprintf(failure, sizeof failure, "unexpected %s", out);
 	TEST_ASSERT_VAL(failure, !strcmp(string, out));
-	return 0;
+	return TEST_OK;
 }
 
 int test__mem(struct test *text __maybe_unused, int subtest __maybe_unused)
 {
-	int ret = 0;
+	int ret = TEST_OK;
 	union perf_mem_data_src src;
 
 	memset(&src, 0, sizeof(src));
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index a258bd51f1a4..4fa103229f2b 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -75,5 +75,5 @@ int test__mem2node(struct test *t __maybe_unused, int subtest __maybe_unused)
 		zfree(&nodes[i].set);
 
 	mem2node__exit(&map);
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index d38757db2dc2..e59cc8eea430 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -31,7 +31,7 @@
  */
 int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err = -1;
+	int err = TEST_FAIL;
 	union perf_event *event;
 	struct perf_thread_map *threads;
 	struct perf_cpu_map *cpus;
@@ -49,7 +49,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	if (threads == NULL) {
 		pr_debug("thread_map__new\n");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	cpus = perf_cpu_map__new(NULL);
@@ -132,7 +132,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 			goto out_delete_evlist;
 		}
 
-		err = -1;
+		err = TEST_FAIL;
 		evsel = evlist__id2evsel(evlist, sample.id);
 		if (evsel == NULL) {
 			pr_debug("event with id %" PRIu64
@@ -145,13 +145,13 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 	perf_mmap__read_done(&md->core);
 
 out_init:
-	err = 0;
+	err = TEST_OK;
 	evlist__for_each_entry(evlist, evsel) {
 		if (nr_events[evsel->core.idx] != expected_nr_events[evsel->core.idx]) {
 			pr_debug("expected %d %s events, got %d\n",
 				 expected_nr_events[evsel->core.idx],
 				 evsel__name(evsel), nr_events[evsel->core.idx]);
-			err = -1;
+			err = TEST_FAIL;
 			goto out_delete_evlist;
 		}
 	}
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 8d9d4cbff76d..65e383d4d601 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -234,5 +234,5 @@ int test__mmap_thread_lookup(struct test *test __maybe_unused, int subtest __may
 	TEST_ASSERT_VAL("failed with sythesizing process",
 			!mmap_events(synth_process));
 
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index f7dd6c463f04..4c176a648102 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -21,7 +21,7 @@
 
 int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err = -1, fd, cpu;
+	int err = TEST_FAIL, fd, cpu;
 	struct perf_cpu_map *cpus;
 	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
@@ -94,7 +94,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 		goto out_close_fd;
 	}
 
-	err = 0;
+	err = TEST_OK;
 
 	for (cpu = 0; cpu < cpus->nr; ++cpu) {
 		unsigned int expected;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 5e4af2f0f14a..31f3d967db9b 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -38,7 +38,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 	int flags = O_RDONLY | O_DIRECTORY;
 	struct evlist *evlist = evlist__new();
 	struct evsel *evsel;
-	int err = -1, i, nr_events = 0, nr_polls = 0;
+	int err = TEST_FAIL, i, nr_events = 0, nr_polls = 0;
 	char sbuf[STRERR_BUFSIZE];
 
 	if (evlist == NULL) {
@@ -136,7 +136,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		}
 	}
 out_ok:
-	err = 0;
+	err = TEST_OK;
 out_delete_evlist:
 	evlist__delete(evlist);
 out:
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 85a8f0fe7aea..b083203c0cc5 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -15,7 +15,7 @@
 
 int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err = -1, fd;
+	int err = TEST_FAIL, fd;
 	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
 	struct perf_thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
@@ -24,7 +24,7 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 
 	if (threads == NULL) {
 		pr_debug("thread_map__new\n");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	evsel = evsel__newtp("syscalls", "sys_enter_openat");
@@ -57,7 +57,7 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 		goto out_close_fd;
 	}
 
-	err = 0;
+	err = TEST_OK;
 out_close_fd:
 	perf_evsel__close_fd(&evsel->core);
 out_evsel_delete:
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 56a7b6a14195..c6994e838775 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -54,7 +54,7 @@ static int test__checkevent_tracepoint(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_type",
 		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
 	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->core.attr.sample_period);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_tracepoint_multi(struct evlist *evlist)
@@ -72,7 +72,7 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong sample_period",
 			1 == evsel->core.attr.sample_period);
 	}
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_raw(struct evlist *evlist)
@@ -82,7 +82,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_numeric(struct evlist *evlist)
@@ -92,7 +92,7 @@ static int test__checkevent_numeric(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_symbolic_name(struct evlist *evlist)
@@ -103,7 +103,7 @@ static int test__checkevent_symbolic_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_symbolic_name_config(struct evlist *evlist)
@@ -124,7 +124,7 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 			0 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2",
 			1 == evsel->core.attr.config2);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_symbolic_alias(struct evlist *evlist)
@@ -135,7 +135,7 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_SW_PAGE_FAULTS == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_genhw(struct evlist *evlist)
@@ -145,7 +145,7 @@ static int test__checkevent_genhw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", (1 << 16) == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint(struct evlist *evlist)
@@ -159,7 +159,7 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_4 ==
 					evsel->core.attr.bp_len);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint_x(struct evlist *evlist)
@@ -172,7 +172,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_X == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", sizeof(long) == evsel->core.attr.bp_len);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint_r(struct evlist *evlist)
@@ -187,7 +187,7 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
 			HW_BREAKPOINT_R == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
 			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint_w(struct evlist *evlist)
@@ -202,7 +202,7 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
 			HW_BREAKPOINT_W == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
 			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint_rw(struct evlist *evlist)
@@ -217,7 +217,7 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 		(HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
 			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
@@ -448,7 +448,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 	 */
 	TEST_ASSERT_VAL("wrong period",     0 == evsel->core.attr.sample_period);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_list(struct evlist *evlist)
@@ -487,7 +487,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_pmu_name(struct evlist *evlist)
@@ -508,7 +508,7 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong name",
 			!strcmp(evsel__name(evsel), "cpu/config=2/u"));
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
@@ -539,7 +539,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
 	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type));
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_pmu_events(struct evlist *evlist)
@@ -557,7 +557,7 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
-	return 0;
+	return TEST_OK;
 }
 
 
@@ -589,7 +589,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.pinned);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkterms_simple(struct list_head *terms)
@@ -660,7 +660,7 @@ static int test__checkterms_simple(struct list_head *terms)
 			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 	TEST_ASSERT_VAL("wrong val", term->val.num == 0xead);
 	TEST_ASSERT_VAL("wrong config", !term->config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group1(struct evlist *evlist)
@@ -702,7 +702,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group2(struct evlist *evlist)
@@ -757,7 +757,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group3(struct evlist *evlist __maybe_unused)
@@ -849,7 +849,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group4(struct evlist *evlist __maybe_unused)
@@ -893,7 +893,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group5(struct evlist *evlist __maybe_unused)
@@ -979,7 +979,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group_gh1(struct evlist *evlist)
@@ -1019,7 +1019,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group_gh2(struct evlist *evlist)
@@ -1059,7 +1059,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group_gh3(struct evlist *evlist)
@@ -1099,7 +1099,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group_gh4(struct evlist *evlist)
@@ -1139,7 +1139,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__leader_sample1(struct evlist *evlist)
@@ -1192,7 +1192,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__leader_sample2(struct evlist *evlist __maybe_unused)
@@ -1231,7 +1231,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_pinned_modifier(struct evlist *evlist)
@@ -1275,7 +1275,7 @@ static int test__pinned_group(struct evlist *evlist)
 			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_exclusive_modifier(struct evlist *evlist)
@@ -1319,7 +1319,7 @@ static int test__exclusive_group(struct evlist *evlist)
 			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
-	return 0;
+	return TEST_OK;
 }
 static int test__checkevent_breakpoint_len(struct evlist *evlist)
 {
@@ -1333,7 +1333,7 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_1 ==
 					evsel->core.attr.bp_len);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
@@ -1348,7 +1348,7 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_2 ==
 					evsel->core.attr.bp_len);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int
@@ -1372,7 +1372,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_SW_TASK_CLOCK == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_config_symbol(struct evlist *evlist)
@@ -1380,7 +1380,7 @@ static int test__checkevent_config_symbol(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "insn") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_config_raw(struct evlist *evlist)
@@ -1388,7 +1388,7 @@ static int test__checkevent_config_raw(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "rawpmu") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_config_num(struct evlist *evlist)
@@ -1396,7 +1396,7 @@ static int test__checkevent_config_num(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "numpmu") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_config_cache(struct evlist *evlist)
@@ -1404,7 +1404,7 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "cachepmu") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static bool test__intel_pt_valid(void)
@@ -1417,7 +1417,7 @@ static int test__intel_pt(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "intel_pt//u") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_complex_name(struct evlist *evlist)
@@ -1425,7 +1425,7 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong complex name parsing", strcmp(evsel->name, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_raw_pmu(struct evlist *evlist)
@@ -1435,7 +1435,7 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__sym_event_slash(struct evlist *evlist)
@@ -1445,7 +1445,7 @@ static int test__sym_event_slash(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
 	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__sym_event_dc(struct evlist *evlist)
@@ -1455,7 +1455,7 @@ static int test__sym_event_dc(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
 	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	return 0;
+	return TEST_OK;
 }
 
 static int count_tracepoints(void)
@@ -1519,7 +1519,7 @@ static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_hw_group_event(struct evlist *evlist)
@@ -1536,7 +1536,7 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0xc0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
@@ -1552,7 +1552,7 @@ static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
@@ -1568,7 +1568,7 @@ static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_group_modifier1(struct evlist *evlist)
@@ -1589,7 +1589,7 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_raw1(struct evlist *evlist)
@@ -1603,7 +1603,7 @@ static int test__hybrid_raw1(struct evlist *evlist)
 	/* The type of second event is randome value */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_raw2(struct evlist *evlist)
@@ -1613,7 +1613,7 @@ static int test__hybrid_raw2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_cache_event(struct evlist *evlist)
@@ -1627,7 +1627,7 @@ static int test__hybrid_cache_event(struct evlist *evlist)
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x10002 == (evsel->core.attr.config & 0xffffffff));
-	return 0;
+	return TEST_OK;
 }
 
 struct evlist_test {
@@ -2043,12 +2043,12 @@ static int test_event(struct evlist_test *e)
 	bzero(&err, sizeof(err));
 	if (e->valid && !e->valid()) {
 		pr_debug("... SKIP");
-		return 0;
+		return TEST_OK;
 	}
 
 	evlist = evlist__new();
 	if (evlist == NULL)
-		return -ENOMEM;
+		return TEST_FAIL;
 
 	ret = parse_events(evlist, e->name, &err);
 	if (ret) {
@@ -2111,7 +2111,7 @@ static int test_term(struct terms_test *t)
 
 static int test_terms(struct terms_test *terms, unsigned cnt)
 {
-	int ret = 0;
+	int ret = TEST_OK;
 	unsigned i;
 
 	for (i = 0; i < cnt; i++) {
@@ -2138,7 +2138,7 @@ static int test_pmu(void)
 	ret = stat(path, &st);
 	if (ret)
 		pr_debug("omitting PMU cpu tests\n");
-	return !ret;
+	return ret ? TEST_OK : TEST_FAIL;
 }
 
 static int test_pmu_events(void)
@@ -2155,13 +2155,13 @@ static int test_pmu_events(void)
 	ret = stat(path, &st);
 	if (ret) {
 		pr_debug("omitting PMU cpu events tests\n");
-		return 0;
+		return TEST_OK;
 	}
 
 	dir = opendir(path);
 	if (!dir) {
 		pr_debug("can't open pmu event dir");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	while (!ret && (ent = readdir(dir))) {
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 4f6f4904e852..586dc31a8fac 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -222,7 +222,7 @@ static int test_ipc(void)
 
 	TEST_ASSERT_VAL("IPC failed, wrong ratio",
 			ratio == 1.5);
-	return 0;
+	return TEST_OK;
 }
 
 static int test_frontend(void)
@@ -241,7 +241,7 @@ static int test_frontend(void)
 
 	TEST_ASSERT_VAL("Frontend_Bound_SMT failed, wrong ratio",
 			ratio == 0.45);
-	return 0;
+	return TEST_OK;
 }
 
 static int test_cache_miss_cycles(void)
@@ -259,7 +259,7 @@ static int test_cache_miss_cycles(void)
 
 	TEST_ASSERT_VAL("cache_miss_cycles failed, wrong ratio",
 			ratio == 1.25);
-	return 0;
+	return TEST_OK;
 }
 
 
@@ -308,7 +308,7 @@ static int test_dcache_l2(void)
 
 	TEST_ASSERT_VAL("DCache_L2_Misses failed, wrong ratio",
 			ratio == 0.7);
-	return 0;
+	return TEST_OK;
 }
 
 static int test_recursion_fail(void)
@@ -325,7 +325,7 @@ static int test_recursion_fail(void)
 
 	TEST_ASSERT_VAL("failed to find recursion",
 			compute_metric("M3", vals, &ratio) == -1);
-	return 0;
+	return TEST_OK;
 }
 
 static int test_memory_bandwidth(void)
@@ -342,7 +342,7 @@ static int test_memory_bandwidth(void)
 	TEST_ASSERT_VAL("L1D_Cache_Fill_BW, wrong ratio",
 			1.28 == ratio);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test_metric_group(void)
@@ -366,7 +366,7 @@ static int test_metric_group(void)
 
 	TEST_ASSERT_VAL("group cache_miss_cycles failed, wrong ratio",
 			ratio2 == 1.25);
-	return 0;
+	return TEST_OK;
 }
 
 int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
@@ -381,5 +381,5 @@ int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unu
 		TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
 		TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
 	}
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf/tests/parse-no-sample-id-all.c
index 471273676701..bcc2dffec873 100644
--- a/tools/perf/tests/parse-no-sample-id-all.c
+++ b/tools/perf/tests/parse-no-sample-id-all.c
@@ -99,7 +99,7 @@ int test__parse_no_sample_id_all(struct test *test __maybe_unused, int subtest _
 
 	err = process_events(events, ARRAY_SIZE(events));
 	if (err)
-		return -1;
+		return TEST_FAIL;
 
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
index dd865e0bea12..8021c7d5890c 100644
--- a/tools/perf/tests/perf-hooks.c
+++ b/tools/perf/tests/perf-hooks.c
@@ -12,7 +12,7 @@ static void sigsegv_handler(int sig __maybe_unused)
 	perf_hooks__recover();
 	signal(SIGSEGV, SIG_DFL);
 	raise(SIGSEGV);
-	exit(-1);
+	exit(TEST_FAIL);
 }
 
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 0df471bf1590..7e15c8f2e862 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -330,5 +330,5 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 out_delete_evlist:
 	evlist__delete(evlist);
 out:
-	return (err < 0 || errs > 0) ? -1 : 0;
+	return (err < 0 || errs > 0) ? TEST_FAIL : TEST_OK;
 }
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 85d75b9b25a1..602e251dad95 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -59,7 +59,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	struct perf_cpu_map *cpus = NULL;
 	struct evlist *evlist = NULL;
 	struct evsel *evsel = NULL;
-	int err = -1, ret, i;
+	int err = TEST_FAIL, ret, i;
 	const char *comm1, *comm2;
 	struct perf_tsc_conversion tc;
 	struct perf_event_mmap_page *pc;
@@ -175,7 +175,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	    test_tsc >= comm2_tsc)
 		goto out_err;
 
-	err = 0;
+	err = TEST_OK;
 
 out_err:
 	evlist__delete(evlist);
diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index e8fd0da0762b..cce120b06545 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -101,7 +101,7 @@ static int test__pfm_events(void)
 
 		evlist__delete(evlist);
 	}
-	return 0;
+	return TEST_OK;
 }
 
 static int test__pfm_group(void)
@@ -185,7 +185,7 @@ static int test__pfm_group(void)
 
 		evlist__delete(evlist);
 	}
-	return 0;
+	return TEST_OK;
 }
 #endif
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index b8aff8fb50d8..54e48e263fbd 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -173,7 +173,7 @@ static int test_pmu_event_table(void)
 			  ARRAY_SIZE(test_uncore_events) - 2;
 
 	if (!map)
-		return -1;
+		return TEST_FAIL;
 
 	for (table = map->table; table->name; table++) {
 		struct perf_pmu_test_event *test;
@@ -196,56 +196,56 @@ static int test_pmu_event_table(void)
 			if (!is_same(table->desc, te->desc)) {
 				pr_debug2("testing event table %s: mismatched desc, %s vs %s\n",
 					  table->name, table->desc, te->desc);
-				return -1;
+				return TEST_FAIL;
 			}
 
 			if (!is_same(table->topic, te->topic)) {
 				pr_debug2("testing event table %s: mismatched topic, %s vs %s\n",
 					  table->name, table->topic,
 					  te->topic);
-				return -1;
+				return TEST_FAIL;
 			}
 
 			if (!is_same(table->long_desc, te->long_desc)) {
 				pr_debug2("testing event table %s: mismatched long_desc, %s vs %s\n",
 					  table->name, table->long_desc,
 					  te->long_desc);
-				return -1;
+				return TEST_FAIL;
 			}
 
 			if (!is_same(table->unit, te->unit)) {
 				pr_debug2("testing event table %s: mismatched unit, %s vs %s\n",
 					  table->name, table->unit,
 					  te->unit);
-				return -1;
+				return TEST_FAIL;
 			}
 
 			if (!is_same(table->perpkg, te->perpkg)) {
 				pr_debug2("testing event table %s: mismatched perpkg, %s vs %s\n",
 					  table->name, table->perpkg,
 					  te->perpkg);
-				return -1;
+				return TEST_FAIL;
 			}
 
 			if (!is_same(table->metric_expr, te->metric_expr)) {
 				pr_debug2("testing event table %s: mismatched metric_expr, %s vs %s\n",
 					  table->name, table->metric_expr,
 					  te->metric_expr);
-				return -1;
+				return TEST_FAIL;
 			}
 
 			if (!is_same(table->metric_name, te->metric_name)) {
 				pr_debug2("testing event table %s: mismatched metric_name, %s vs %s\n",
 					  table->name,  table->metric_name,
 					  te->metric_name);
-				return -1;
+				return TEST_FAIL;
 			}
 
 			if (!is_same(table->deprecated, te->deprecated)) {
 				pr_debug2("testing event table %s: mismatched deprecated, %s vs %s\n",
 					  table->name, table->deprecated,
 					  te->deprecated);
-				return -1;
+				return TEST_FAIL;
 			}
 
 			pr_debug("testing event table %s: pass\n", table->name);
@@ -254,17 +254,17 @@ static int test_pmu_event_table(void)
 		if (!found) {
 			pr_err("testing event table: could not find event %s\n",
 			       table->name);
-			return -1;
+			return TEST_FAIL;
 		}
 	}
 
 	if (map_events != expected_events) {
 		pr_err("testing event table: found %d, but expected %d\n",
 		       map_events, expected_events);
-		return -1;
+		return TEST_FAIL;
 	}
 
-	return 0;
+	return TEST_OK;
 }
 
 static struct perf_pmu_alias *find_alias(const char *test_event, struct list_head *aliases)
@@ -386,7 +386,7 @@ static int test_aliases(void)
 
 		if (__test__pmu_event_aliases(pmu->name, &count)) {
 			pr_debug("testing PMU %s aliases: failed\n", pmu->name);
-			return -1;
+			return TEST_FAIL;
 		}
 
 		if (count == 0)
@@ -396,7 +396,7 @@ static int test_aliases(void)
 			pr_debug("testing PMU %s aliases: pass\n", pmu->name);
 	}
 
-	return 0;
+	return TEST_OK;
 }
 
 static bool is_number(const char *str)
@@ -628,7 +628,7 @@ static int metric_parse_fake(const char *str)
 	struct expr_parse_ctx ctx;
 	struct hashmap_entry *cur;
 	double result;
-	int ret = -1;
+	int ret = TEST_FAIL;
 	size_t bkt;
 	int i;
 
@@ -637,7 +637,7 @@ static int metric_parse_fake(const char *str)
 	expr__ctx_init(&ctx);
 	if (expr__find_other(str, NULL, &ctx, 0) < 0) {
 		pr_err("expr__find_other failed\n");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	/*
@@ -659,7 +659,7 @@ static int metric_parse_fake(const char *str)
 	if (expr__parse(&result, &ctx, str, 0))
 		pr_err("expr__parse failed\n");
 	else
-		ret = 0;
+		ret = TEST_OK;
 
 out:
 	expr__ctx_clear(&ctx);
@@ -702,7 +702,7 @@ static int test_parsing_fake(void)
 		}
 	}
 
-	return 0;
+	return TEST_OK;
 }
 
 static const struct {
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 714e6830a758..61edfb871ae9 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -145,7 +145,7 @@ int test__pmu(struct test *test __maybe_unused, int subtest __maybe_unused)
 	int ret;
 
 	if (!format)
-		return -EINVAL;
+		return TEST_FAIL;
 
 	do {
 		struct perf_event_attr attr;
@@ -153,15 +153,17 @@ int test__pmu(struct test *test __maybe_unused, int subtest __maybe_unused)
 		memset(&attr, 0, sizeof(attr));
 
 		ret = perf_pmu__format_parse(format, &formats);
-		if (ret)
+		if (ret) {
+			ret = TEST_FAIL;
 			break;
-
+		}
 		ret = perf_pmu__config_terms("perf-pmu-test", &formats, &attr,
 					     terms, false, NULL);
-		if (ret)
+		if (ret) {
+			ret = TEST_FAIL;
 			break;
-
-		ret = -EINVAL;
+		}
+		ret = TEST_FAIL;
 
 		if (attr.config  != 0xc00000000002a823)
 			break;
@@ -170,7 +172,7 @@ int test__pmu(struct test *test __maybe_unused, int subtest __maybe_unused)
 		if (attr.config2 != 0x0400000020041d07)
 			break;
 
-		ret = 0;
+		ret = TEST_OK;
 	} while (0);
 
 	perf_pmu__del_formats(&formats);
diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 98c6d474aa6f..dee060528db1 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -19,7 +19,7 @@ int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unuse
 		return -1;
 
 	pr_debug("python usage test: \"%s\"\n", cmd);
-	ret = system(cmd) ? -1 : 0;
+	ret = system(cmd) ? TEST_FAIL : TEST_OK;
 	free(cmd);
 	return ret;
 }
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 8fd8a4ef97da..0ad5aa7fd901 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -250,7 +250,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	struct sample_read_value values[] = {{1, 5}, {9, 3}, {2, 7}, {6, 4},};
 	struct perf_sample sample_out;
 	size_t i, sz, bufsz;
-	int err, ret = -1;
+	int err, ret = TEST_FAIL;
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
 		evsel.core.attr.sample_regs_user = sample_regs;
@@ -277,7 +277,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	event = malloc(bufsz);
 	if (!event) {
 		pr_debug("malloc failed\n");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	memset(event, 0xff, bufsz);
@@ -319,7 +319,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		goto out_free;
 	}
 
-	ret = 0;
+	ret = TEST_OK;
 out_free:
 	free(event);
 	if (ret && read_format)
@@ -350,7 +350,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 */
 	if (PERF_SAMPLE_MAX > PERF_SAMPLE_WEIGHT_STRUCT << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	/* Test each sample format bit separately */
@@ -391,5 +391,5 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 			return err;
 	}
 
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
index c1911501c39c..dce23f894335 100644
--- a/tools/perf/tests/stat.c
+++ b/tools/perf/tests/stat.c
@@ -44,7 +44,7 @@ static int process_stat_config_event(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong aggr_mode", stat_config.aggr_mode == AGGR_CORE);
 	TEST_ASSERT_VAL("wrong scale",     stat_config.scale == 1);
 	TEST_ASSERT_VAL("wrong interval",  stat_config.interval == 1);
-	return 0;
+	return TEST_OK;
 }
 
 int test__synthesize_stat_config(struct test *test __maybe_unused, int subtest __maybe_unused)
@@ -58,7 +58,7 @@ int test__synthesize_stat_config(struct test *test __maybe_unused, int subtest _
 	TEST_ASSERT_VAL("failed to synthesize stat_config",
 		!perf_event__synthesize_stat_config(NULL, &stat_config, process_stat_config_event, NULL));
 
-	return 0;
+	return TEST_OK;
 }
 
 static int process_stat_event(struct perf_tool *tool __maybe_unused,
@@ -74,7 +74,7 @@ static int process_stat_event(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong val",    st->val    == 100);
 	TEST_ASSERT_VAL("wrong run",    st->ena    == 200);
 	TEST_ASSERT_VAL("wrong ena",    st->run    == 300);
-	return 0;
+	return TEST_OK;
 }
 
 int test__synthesize_stat(struct test *test __maybe_unused, int subtest __maybe_unused)
@@ -88,7 +88,7 @@ int test__synthesize_stat(struct test *test __maybe_unused, int subtest __maybe_
 	TEST_ASSERT_VAL("failed to synthesize stat_config",
 		!perf_event__synthesize_stat(NULL, 1, 2, 3, &count, process_stat_event, NULL));
 
-	return 0;
+	return TEST_OK;
 }
 
 static int process_stat_round_event(struct perf_tool *tool __maybe_unused,
@@ -100,7 +100,7 @@ static int process_stat_round_event(struct perf_tool *tool __maybe_unused,
 
 	TEST_ASSERT_VAL("wrong time", stat_round->time == 0xdeadbeef);
 	TEST_ASSERT_VAL("wrong type", stat_round->type == PERF_STAT_ROUND_TYPE__INTERVAL);
-	return 0;
+	return TEST_OK;
 }
 
 int test__synthesize_stat_round(struct test *test __maybe_unused, int subtest __maybe_unused)
@@ -109,5 +109,5 @@ int test__synthesize_stat_round(struct test *test __maybe_unused, int subtest __
 		!perf_event__synthesize_stat_round(NULL, 0xdeadbeef, PERF_STAT_ROUND_TYPE__INTERVAL,
 						   process_stat_round_event, NULL));
 
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 74988846be1d..121b1c521269 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -26,7 +26,7 @@
  */
 static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 {
-	int i, err = -1;
+	int i, err = TEST_FAIL;
 	volatile int tmp = 0;
 	u64 total_periods = 0;
 	int nr_samples = 0;
@@ -51,7 +51,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	evlist = evlist__new();
 	if (evlist == NULL) {
 		pr_debug("evlist__new\n");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	evsel = evsel__new(&attr);
@@ -64,7 +64,6 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	cpus = perf_cpu_map__dummy_new();
 	threads = thread_map__new_by_tid(getpid());
 	if (!cpus || !threads) {
-		err = -ENOMEM;
 		pr_debug("Not enough memory to create thread/cpu maps\n");
 		goto out_delete_evlist;
 	}
@@ -74,7 +73,6 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	if (evlist__open(evlist)) {
 		const char *knob = "/proc/sys/kernel/perf_event_max_sample_rate";
 
-		err = -errno;
 		pr_debug("Couldn't open evlist: %s\nHint: check %s, using %" PRIu64 " in this test.\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)),
 			 knob, (u64)attr.sample_freq);
@@ -83,6 +81,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 
 	err = evlist__mmap(evlist, 128);
 	if (err < 0) {
+		err = TEST_FAIL;
 		pr_debug("failed to mmap event: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_delete_evlist;
@@ -108,6 +107,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 
 		err = evlist__parse_sample(evlist, event, &sample);
 		if (err < 0) {
+			err = TEST_FAIL;
 			pr_debug("Error during parse sample\n");
 			goto out_delete_evlist;
 		}
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 62c0ec21aaa8..21ba8fb1867b 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -340,7 +340,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	struct evsel *evsel, *cpu_clocks_evsel, *cycles_evsel;
 	struct evsel *switch_evsel, *tracking_evsel;
 	const char *comm;
-	int err = -1;
+	int err = TEST_FAIL;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	if (!threads) {
@@ -386,7 +386,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	/* Third event */
 	if (!evlist__can_select_event(evlist, sched_switch)) {
 		pr_debug("No sched_switch\n");
-		err = 0;
+		err = TEST_OK;
 		goto out;
 	}
 
@@ -462,7 +462,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 
 	if (evlist__open(evlist) < 0) {
 		pr_debug("Not supported\n");
-		err = 0;
+		err = TEST_OK;
 		goto out;
 	}
 
@@ -553,6 +553,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	/* Check all 4 comm events were seen i.e. that evsel->tracking works */
 	if (!switch_tracking.comm_seen[0] || !switch_tracking.comm_seen[1] ||
 	    !switch_tracking.comm_seen[2] || !switch_tracking.comm_seen[3]) {
+		err = TEST_FAIL;
 		pr_debug("Missing comm events\n");
 		goto out_err;
 	}
@@ -585,6 +586,6 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	return err;
 
 out_err:
-	err = -1;
+	err = TEST_FAIL;
 	goto out;
 }
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 4c2969db59b0..4f6c593ba98c 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -41,7 +41,7 @@ static void workload_exec_failed_signal(int signo __maybe_unused,
  */
 int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err = -1;
+	int err = TEST_FAIL;
 	union perf_event *event;
 	struct evsel *evsel;
 	struct evlist *evlist;
@@ -61,7 +61,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	evlist = evlist__new_default();
 	if (evlist == NULL) {
 		pr_debug("evlist__new_default\n");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	/*
@@ -73,7 +73,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	cpus = perf_cpu_map__dummy_new();
 	threads = thread_map__new_by_tid(-1);
 	if (!cpus || !threads) {
-		err = -ENOMEM;
+		err = TEST_FAIL;
 		pr_debug("Not enough memory to create thread/cpu maps\n");
 		goto out_delete_evlist;
 	}
@@ -108,7 +108,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	if (evlist__mmap(evlist, 128) < 0) {
 		pr_debug("failed to mmap events: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
-		err = -1;
+		err = TEST_FAIL;
 		goto out_delete_evlist;
 	}
 
@@ -133,7 +133,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 		if (retry_count++ > 1000) {
 			pr_debug("Failed after retrying 1000 times\n");
-			err = -1;
+			err = TEST_FAIL;
 			goto out_delete_evlist;
 		}
 
@@ -142,7 +142,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 	if (nr_exit != 1) {
 		pr_debug("received %d EXIT records\n", nr_exit);
-		err = -1;
+		err = TEST_FAIL;
 	}
 
 out_delete_evlist:
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 1100dd55b657..9a8cb786311a 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -8,7 +8,7 @@
 do {									 \
 	if (!(cond)) {							 \
 		pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); \
-		return -1;						 \
+		return TEST_FAIL;					 \
 	}								 \
 } while (0)
 
@@ -17,7 +17,7 @@ do {									 \
 	if (val != expected) {						 \
 		pr_debug("FAILED %s:%d %s (%d != %d)\n",		 \
 			 __FILE__, __LINE__, text, val, expected);	 \
-		return -1;						 \
+		return TEST_FAIL;					 \
 	}								 \
 } while (0)
 
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index d1e208b4a571..450f13436464 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -56,7 +56,7 @@ int test__thread_map(struct test *test __maybe_unused, int subtest __maybe_unuse
 	TEST_ASSERT_VAL("wrong refcnt",
 			refcount_read(&map->refcnt) == 1);
 	perf_thread_map__put(map);
-	return 0;
+	return TEST_OK;
 }
 
 static int process_event(struct perf_tool *tool __maybe_unused,
@@ -83,7 +83,7 @@ static int process_event(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong refcnt",
 			refcount_read(&threads->refcnt) == 1);
 	perf_thread_map__put(threads);
-	return 0;
+	return TEST_OK;
 }
 
 int test__thread_map_synthesize(struct test *test __maybe_unused, int subtest __maybe_unused)
@@ -103,7 +103,7 @@ int test__thread_map_synthesize(struct test *test __maybe_unused, int subtest __
 		!perf_event__synthesize_thread_map2(NULL, threads, process_event, NULL));
 
 	perf_thread_map__put(threads);
-	return 0;
+	return TEST_OK;
 }
 
 int test__thread_map_remove(struct test *test __maybe_unused, int subtest __maybe_unused)
@@ -143,5 +143,5 @@ int test__thread_map_remove(struct test *test __maybe_unused, int subtest __mayb
 			thread_map__remove(threads, 0));
 
 	perf_thread_map__put(threads);
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
index 9371484973f2..919cd54a0fa6 100644
--- a/tools/perf/tests/thread-maps-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -94,5 +94,5 @@ int test__thread_maps_share(struct test *test __maybe_unused, int subtest __mayb
 	thread__put(other);
 
 	machines__exit(&machines);
-	return 0;
+	return TEST_OK;
 }
diff --git a/tools/perf/tests/time-utils-test.c b/tools/perf/tests/time-utils-test.c
index fe57ca3b6e54..c8db5fdfbf95 100644
--- a/tools/perf/tests/time-utils-test.c
+++ b/tools/perf/tests/time-utils-test.c
@@ -247,5 +247,5 @@ int test__time_utils(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	pr_debug("\n");
 
-	return pass ? 0 : TEST_FAIL;
+	return pass ? TEST_OK : TEST_FAIL;
 }
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index ec4e3b21b831..5bf80fe02237 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -169,7 +169,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	}
 	perf_session__delete(session);
 
-	return 0;
+	return TEST_OK;
 }
 
 int test__session_topology(struct test *test __maybe_unused, int subtest __maybe_unused)
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 193b7c91b4e2..aa9b9e11ba89 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -16,7 +16,7 @@
 
 int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err = -1;
+	int err = TEST_FAIL;
 	struct rb_node *nd;
 	struct symbol *sym;
 	struct map *kallsyms_map, *vmlinux_map, *map;
@@ -101,7 +101,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 		goto out;
 	}
 
-	err = 0;
+	err = TEST_OK;
 	/*
 	 * Step 7:
 	 *
@@ -174,7 +174,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 				 mem_start, sym->name);
 		}
 
-		err = -1;
+		err = TEST_FAIL;
 	}
 
 	if (verbose <= 0)
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 9387fa76faa5..a487935419fc 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -78,7 +78,7 @@ static int wp_ro_test(void)
 	WP_TEST_ASSERT_VAL(fd, "RO watchpoint", 1);
 
 	close(fd);
-	return 0;
+	return TEST_OK;
 }
 
 static int wp_wo_test(void)
@@ -88,7 +88,7 @@ static int wp_wo_test(void)
 
 	fd = __event(HW_BREAKPOINT_W, (void *)&data1, sizeof(data1));
 	if (fd < 0)
-		return -1;
+		return TEST_FAIL;
 
 	tmp = data1;
 	WP_TEST_ASSERT_VAL(fd, "WO watchpoint", 0);
@@ -97,7 +97,7 @@ static int wp_wo_test(void)
 	WP_TEST_ASSERT_VAL(fd, "WO watchpoint", 1);
 
 	close(fd);
-	return 0;
+	return TEST_OK;
 }
 
 static int wp_rw_test(void)
@@ -117,7 +117,7 @@ static int wp_rw_test(void)
 	WP_TEST_ASSERT_VAL(fd, "RW watchpoint", 2);
 
 	close(fd);
-	return 0;
+	return TEST_OK;
 }
 
 static int wp_modify_test(void)
@@ -162,7 +162,7 @@ static int wp_modify_test(void)
 	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 2);
 
 	close(fd);
-	return 0;
+	return TEST_OK;
 }
 
 static bool wp_ro_supported(void)
-- 
2.32.0.432.gabb21c7263-goog

