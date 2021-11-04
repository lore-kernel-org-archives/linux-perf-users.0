Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448F4C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD1561056
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhKDGpM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhKDGpD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F70C06120B
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:25 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so4121331qkd.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/B5Czi/bf5GdLjmiEdHycju9WdKJCVrYdgkYD4sf94I=;
        b=JYrV9Ku2hVVi3gYjaRFoDBnKg2FNvG8ae4Jeiuvct/KUuq0VkoaNBf6/yYRdarZrr5
         dpx01+2jxlx6PY2o48zzckzhts8ZSn7//hsjRDbqF4xIL+/Y8xmecRQK9xUwQ1YnKICx
         zlNKjrFGm2j0cc4JnHv4J5QytjejUB+IInOz0uGig4o/Et1OeUlaxbCdX1BWiyqVT6Td
         dGxiZzGuQxHM/zGCCcYBwycUwGd8VmbmhF/Ea2KQeMuxpKFZnowXphz3dVRDs8xCpPEU
         AovldZ2vbGQu5GI+mFHL4mIg+g8tyWGwtObTJWzJv5OfX9QpMDWfjBopzeQIDdvfoQLQ
         KZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/B5Czi/bf5GdLjmiEdHycju9WdKJCVrYdgkYD4sf94I=;
        b=NrUrPmQig28XlsFlHRjWleF+OCV71N9RzJJDxN9jIUIRwTuKKrcL9GZycarsE2w0PO
         wiYl1sowgRaUR3s5fUf9JARVzjQ+y58H48FfDvqCtcUjNQ/LZotBvKy0hX6PYbegW0NU
         2+afbiVXfUiga9er9IhhrX8YECIyP6Le5hdslbtP7GdhO7vOSRTuI+BV1DLGVTmLV4fS
         ZpF3+tjVw4ZkGU/FVXADB8zn4NMuJq8vDlTwvBmxV7eF1/892JC5ulr8YxmtzoA785LP
         T9kk5Dh6nutkvEEeXyj4as8TV2G4jaR/wI1B3O1OlTZINHGaWL0e2e+ogf66Mcwt4Ksn
         PtSg==
X-Gm-Message-State: AOAM530+GKa4Un/sT6in1E+KFTZV6g4WY8bnM7c3p3AcyGfHO8xtkNz5
        6GO2KjyhpY4kJEGgHBVWQFZsihB9W3Pv
X-Google-Smtp-Source: ABdhPJyjE8+B78LMUNmYqd0E3QL6X2C7qNzTmdcYgopBbuG/3jfzQhZojVsIjuU241ch0rskvQcv0B8kPNZv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:ac8:5755:: with SMTP id
 21mr50224314qtx.353.1636008144438; Wed, 03 Nov 2021 23:42:24 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:50 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-5-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 04/22] perf test: Move each test suite struct to its test
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

Rather than export test functions, export the test struct. Rename with a
suite__ prefix to avoid name collisions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/tests/arch-tests.c      |   4 +-
 tools/perf/arch/arm64/tests/arch-tests.c    |   2 +-
 tools/perf/arch/powerpc/tests/arch-tests.c  |   2 +-
 tools/perf/arch/x86/tests/arch-tests.c      |  12 +-
 tools/perf/tests/api-io.c                   |   6 +-
 tools/perf/tests/attr.c                     |   4 +-
 tools/perf/tests/backward-ring-buffer.c     |   4 +-
 tools/perf/tests/bitmap.c                   |   4 +-
 tools/perf/tests/bp_account.c               |  10 +-
 tools/perf/tests/bp_signal.c                |   8 +-
 tools/perf/tests/bp_signal_overflow.c       |   8 +-
 tools/perf/tests/bpf.c                      |  22 +-
 tools/perf/tests/builtin-test.c             | 285 +++++---------------
 tools/perf/tests/clang.c                    |  18 +-
 tools/perf/tests/code-reading.c             |   4 +-
 tools/perf/tests/cpumap.c                   |  10 +-
 tools/perf/tests/demangle-java-test.c       |   4 +-
 tools/perf/tests/demangle-ocaml-test.c      |   4 +-
 tools/perf/tests/dlfilter-test.c            |   4 +-
 tools/perf/tests/dso-data.c                 |  10 +-
 tools/perf/tests/dwarf-unwind.c             |   5 +-
 tools/perf/tests/event-times.c              |   4 +-
 tools/perf/tests/event_update.c             |   4 +-
 tools/perf/tests/evsel-roundtrip-name.c     |   5 +-
 tools/perf/tests/evsel-tp-sched.c           |   5 +-
 tools/perf/tests/expand-cgroup.c            |   6 +-
 tools/perf/tests/expr.c                     |   4 +-
 tools/perf/tests/fdarray.c                  |   7 +-
 tools/perf/tests/genelf.c                   |   6 +-
 tools/perf/tests/hists_cumulate.c           |   4 +-
 tools/perf/tests/hists_filter.c             |   4 +-
 tools/perf/tests/hists_link.c               |   4 +-
 tools/perf/tests/hists_output.c             |   4 +-
 tools/perf/tests/is_printable_array.c       |   4 +-
 tools/perf/tests/keep-tracking.c            |   4 +-
 tools/perf/tests/kmod-path.c                |   4 +-
 tools/perf/tests/llvm.c                     |  22 +-
 tools/perf/tests/maps.c                     |   4 +-
 tools/perf/tests/mem.c                      |   4 +-
 tools/perf/tests/mem2node.c                 |   4 +-
 tools/perf/tests/mmap-basic.c               |   4 +-
 tools/perf/tests/mmap-thread-lookup.c       |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c  |   5 +-
 tools/perf/tests/openat-syscall-tp-fields.c |   5 +-
 tools/perf/tests/openat-syscall.c           |   5 +-
 tools/perf/tests/parse-events.c             |   4 +-
 tools/perf/tests/parse-metric.c             |   4 +-
 tools/perf/tests/parse-no-sample-id-all.c   |   5 +-
 tools/perf/tests/pe-file-parsing.c          |   6 +-
 tools/perf/tests/perf-hooks.c               |   4 +-
 tools/perf/tests/perf-record.c              |   4 +-
 tools/perf/tests/perf-time-to-tsc.c         |  10 +-
 tools/perf/tests/pfm.c                      |  16 +-
 tools/perf/tests/pmu-events.c               |  19 +-
 tools/perf/tests/pmu.c                      |   4 +-
 tools/perf/tests/python-use.c               |   4 +-
 tools/perf/tests/sample-parsing.c           |   4 +-
 tools/perf/tests/sdt.c                      |   6 +-
 tools/perf/tests/stat.c                     |  11 +-
 tools/perf/tests/sw-clock.c                 |   4 +-
 tools/perf/tests/switch-tracking.c          |   4 +-
 tools/perf/tests/task-exit.c                |   4 +-
 tools/perf/tests/tests.h                    |  23 +-
 tools/perf/tests/thread-map.c               |  10 +-
 tools/perf/tests/thread-maps-share.c        |   4 +-
 tools/perf/tests/time-utils-test.c          |   4 +-
 tools/perf/tests/topology.c                 |   4 +-
 tools/perf/tests/unit_number__scnprintf.c   |   4 +-
 tools/perf/tests/vmlinux-kallsyms.c         |   5 +-
 tools/perf/tests/wp.c                       |  22 +-
 70 files changed, 397 insertions(+), 348 deletions(-)

diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
index 5287729026ab..0ae591f6c372 100644
--- a/tools/perf/arch/arm/tests/arch-tests.c
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -7,8 +7,8 @@ DEFINE_SUITE("Vectors page", vectors_page);
 
 struct test *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-	&dwarf_unwind,
+	&suite__dwarf_unwind,
 #endif
-	&vectors_pages,
+	&suite__vectors_pages,
 	NULL,
 };
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index bc327048b807..6d137138a2de 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -5,7 +5,7 @@
 
 struct test *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-	&dwarf_unwind,
+	&suite__dwarf_unwind,
 #endif
 	NULL,
 };
diff --git a/tools/perf/arch/powerpc/tests/arch-tests.c b/tools/perf/arch/powerpc/tests/arch-tests.c
index bc327048b807..6d137138a2de 100644
--- a/tools/perf/arch/powerpc/tests/arch-tests.c
+++ b/tools/perf/arch/powerpc/tests/arch-tests.c
@@ -5,7 +5,7 @@
 
 struct test *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-	&dwarf_unwind,
+	&suite__dwarf_unwind,
 #endif
 	NULL,
 };
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index f5e3195768a4..20b1c0d8ca66 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -14,17 +14,17 @@ DEFINE_SUITE("x86 bp modify", bp_modify);
 DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
 
 struct test *arch_tests[] = {
-	&rdpmc,
+	&suite__rdpmc,
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-	&dwarf_unwind,
+	&suite__dwarf_unwind,
 #endif
 #ifdef HAVE_AUXTRACE_SUPPORT
-	&insn_x86,
-	&intel_pt_pkt_decoder,
+	&suite__insn_x86,
+	&suite__intel_pt_pkt_decoder,
 #endif
 #if defined(__x86_64__)
-	&bp_modify,
+	&suite__bp_modify,
 #endif
-	&x86_sample_parsing,
+	&suite__x86_sample_parsing,
 	NULL,
 };
diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
index 2ada86ad6084..af4913967514 100644
--- a/tools/perf/tests/api-io.c
+++ b/tools/perf/tests/api-io.c
@@ -289,8 +289,8 @@ static int test_get_dec(void)
 	return ret;
 }
 
-int test__api_io(struct test *test __maybe_unused,
-		int subtest __maybe_unused)
+static int test__api_io(struct test *test __maybe_unused,
+			int subtest __maybe_unused)
 {
 	int ret = 0;
 
@@ -302,3 +302,5 @@ int test__api_io(struct test *test __maybe_unused,
 		ret = TEST_FAIL;
 	return ret;
 }
+
+DEFINE_SUITE("Test api io", api_io);
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 9b40a25376ae..f1461051f579 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -178,7 +178,7 @@ static int run_dir(const char *d, const char *perf)
 	return system(cmd) ? TEST_FAIL : TEST_OK;
 }
 
-int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct stat st;
 	char path_perf[PATH_MAX];
@@ -207,3 +207,5 @@ int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
 
 	return TEST_SKIP;
 }
+
+DEFINE_SUITE("Setup struct perf_event_attr", attr);
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index b4b9a9488d51..180e16917658 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -82,7 +82,7 @@ static int do_test(struct evlist *evlist, int mmap_pages,
 }
 
 
-int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret = TEST_SKIP, err, sample_count = 0, comm_count = 0;
 	char pid[16], sbuf[STRERR_BUFSIZE];
@@ -166,3 +166,5 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
 	evlist__delete(evlist);
 	return ret;
 }
+
+DEFINE_SUITE("Read backward ring buffer", backward_ring_buffer);
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 12b805efdca0..13d1d1d6774f 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -40,7 +40,7 @@ static int test_bitmap(const char *str)
 	return ret;
 }
 
-int test__bitmap_print(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__bitmap_print(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1"));
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1,5"));
@@ -51,3 +51,5 @@ int test__bitmap_print(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1-10,12-20,22-30,32-40"));
 	return 0;
 }
+
+DEFINE_SUITE("Print bitmap", bitmap_print);
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 489b50604cf2..76cf356ba13f 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -173,7 +173,7 @@ static int detect_share(int wp_cnt, int bp_cnt)
  *     we create another watchpoint to ensure
  *     the slot accounting is correct
  */
-int test__bp_accounting(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__bp_accounting(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int has_ioctl = detect_ioctl();
 	int wp_cnt = detect_cnt(false);
@@ -189,7 +189,7 @@ int test__bp_accounting(struct test *test __maybe_unused, int subtest __maybe_un
 	return bp_accounting(wp_cnt, share);
 }
 
-bool test__bp_account_is_supported(void)
+static bool test__bp_account_is_supported(void)
 {
 	/*
 	 * PowerPC and S390 do not support creation of instruction
@@ -204,3 +204,9 @@ bool test__bp_account_is_supported(void)
 	return true;
 #endif
 }
+
+struct test suite__bp_accounting = {
+	.desc = "Breakpoint accounting",
+	.func = test__bp_accounting,
+	.is_supported = test__bp_account_is_supported,
+};
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index ef37353636d8..c19b05488cfb 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -161,7 +161,7 @@ static long long bp_count(int fd)
 	return count;
 }
 
-int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct sigaction sa;
 	long long count1, count2, count3;
@@ -311,3 +311,9 @@ bool test__bp_signal_is_supported(void)
 	return true;
 #endif
 }
+
+struct test suite__bp_signal = {
+	.desc = "Breakpoint overflow signal handler",
+	.func = test__bp_signal,
+	.is_supported = test__bp_signal_is_supported,
+};
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index eb4dbbddf4ff..99c30d028f5e 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -59,7 +59,7 @@ static long long bp_count(int fd)
 #define EXECUTIONS 10000
 #define THRESHOLD  100
 
-int test__bp_signal_overflow(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__bp_signal_overflow(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_event_attr pe;
 	struct sigaction sa;
@@ -133,3 +133,9 @@ int test__bp_signal_overflow(struct test *test __maybe_unused, int subtest __may
 
 	return fails ? TEST_FAIL : TEST_OK;
 }
+
+struct test suite__bp_signal_overflow = {
+	.desc = "Breakpoint overflow sampling",
+	.func = test__bp_signal_overflow,
+	.is_supported = test__bp_signal_is_supported,
+};
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index fa03ff0dc083..74496a0fc973 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -282,12 +282,12 @@ static int __test__bpf(int idx)
 	return ret;
 }
 
-int test__bpf_subtest_get_nr(void)
+static int test__bpf_subtest_get_nr(void)
 {
 	return (int)ARRAY_SIZE(bpf_testcase_table);
 }
 
-const char *test__bpf_subtest_get_desc(int i)
+static const char *test__bpf_subtest_get_desc(int i)
 {
 	if (i < 0 || i >= (int)ARRAY_SIZE(bpf_testcase_table))
 		return NULL;
@@ -324,7 +324,7 @@ static int check_env(void)
 	return 0;
 }
 
-int test__bpf(struct test *test __maybe_unused, int i)
+static int test__bpf(struct test *test __maybe_unused, int i)
 {
 	int err;
 
@@ -344,19 +344,29 @@ int test__bpf(struct test *test __maybe_unused, int i)
 }
 
 #else
-int test__bpf_subtest_get_nr(void)
+static int test__bpf_subtest_get_nr(void)
 {
 	return 0;
 }
 
-const char *test__bpf_subtest_get_desc(int i __maybe_unused)
+static const char *test__bpf_subtest_get_desc(int i __maybe_unused)
 {
 	return NULL;
 }
 
-int test__bpf(struct test *test __maybe_unused, int i __maybe_unused)
+static int test__bpf(struct test *test __maybe_unused, int i __maybe_unused)
 {
 	pr_debug("Skip BPF test because BPF support is not compiled\n");
 	return TEST_SKIP;
 }
 #endif
+
+struct test suite__bpf = {
+	.desc = "BPF filter",
+	.func = test__bpf,
+	.subtest = {
+		.skip_if_fail	= true,
+		.get_nr		= test__bpf_subtest_get_nr,
+		.get_desc	= test__bpf_subtest_get_desc,
+	},
+};
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b2cbc12a70a2..07467ec43100 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -34,220 +34,79 @@ struct test *__weak arch_tests[] = {
 	NULL,
 };
 
-DEFINE_SUITE("vmlinux symtab matches kallsyms", vmlinux_matches_kallsyms);
-DEFINE_SUITE("Detect openat syscall event", openat_syscall_event);
-DEFINE_SUITE("Detect openat syscall event on all cpus", openat_syscall_event_on_all_cpus);
-DEFINE_SUITE("Read samples using the mmap interface", basic_mmap);
-DEFINE_SUITE("Test data source output", mem);
-DEFINE_SUITE("Parse event definition strings", parse_events);
-DEFINE_SUITE("Simple expression parser", expr);
-DEFINE_SUITE("PERF_RECORD_* events & perf_sample fields", PERF_RECORD);
-DEFINE_SUITE("Parse perf pmu format", pmu);
-static struct test pmu_events = {
-	.desc = "PMU events",
-	.func = test__pmu_events,
-	.subtest = {
-		.skip_if_fail	= false,
-		.get_nr		= test__pmu_events_subtest_get_nr,
-		.get_desc	= test__pmu_events_subtest_get_desc,
-		.skip_reason	= test__pmu_events_subtest_skip_reason,
-	},
-};
-DEFINE_SUITE("DSO data read", dso_data);
-DEFINE_SUITE("DSO data cache", dso_data_cache);
-DEFINE_SUITE("DSO data reopen", dso_data_reopen);
-DEFINE_SUITE("Roundtrip evsel->name", perf_evsel__roundtrip_name_test);
-DEFINE_SUITE("Parse sched tracepoints fields", perf_evsel__tp_sched_test);
-DEFINE_SUITE("syscalls:sys_enter_openat event fields", syscall_openat_tp_fields);
-DEFINE_SUITE("Setup struct perf_event_attr", attr);
-DEFINE_SUITE("Match and link multiple hists", hists_link);
-DEFINE_SUITE("'import perf' in python", python_use);
-static struct test bp_signal = {
-	.desc = "Breakpoint overflow signal handler",
-	.func = test__bp_signal,
-	.is_supported = test__bp_signal_is_supported,
-};
-static struct test bp_signal_overflow = {
-	.desc = "Breakpoint overflow sampling",
-	.func = test__bp_signal_overflow,
-	.is_supported = test__bp_signal_is_supported,
-};
-static struct test bp_accounting = {
-	.desc = "Breakpoint accounting",
-	.func = test__bp_accounting,
-	.is_supported = test__bp_account_is_supported,
-};
-static struct test wp = {
-	.desc = "Watchpoint",
-	.func = test__wp,
-	.is_supported = test__wp_is_supported,
-	.subtest = {
-		.skip_if_fail	= false,
-		.get_nr		= test__wp_subtest_get_nr,
-		.get_desc	= test__wp_subtest_get_desc,
-		.skip_reason    = test__wp_subtest_skip_reason,
-	},
-};
-DEFINE_SUITE("Number of exit events of a simple workload", task_exit);
-DEFINE_SUITE("Software clock events period values", sw_clock_freq);
-DEFINE_SUITE("Object code reading", code_reading);
-DEFINE_SUITE("Sample parsing", sample_parsing);
-DEFINE_SUITE("Use a dummy software event to keep tracking", keep_tracking);
-DEFINE_SUITE("Parse with no sample_id_all bit set", parse_no_sample_id_all);
-DEFINE_SUITE("Filter hist entries", hists_filter);
-DEFINE_SUITE("Lookup mmap thread", mmap_thread_lookup);
-DEFINE_SUITE("Share thread maps", thread_maps_share);
-DEFINE_SUITE("Sort output of hist entries", hists_output);
-DEFINE_SUITE("Cumulate child hist entries", hists_cumulate);
-DEFINE_SUITE("Track with sched_switch", switch_tracking);
-DEFINE_SUITE("Filter fds with revents mask in a fdarray", fdarray__filter);
-DEFINE_SUITE("Add fd to a fdarray, making it autogrow", fdarray__add);
-DEFINE_SUITE("kmod_path__parse", kmod_path__parse);
-DEFINE_SUITE("Thread map", thread_map);
-static struct test llvm = {
-	.desc = "LLVM search and compile",
-	.func = test__llvm,
-	.subtest = {
-		.skip_if_fail	= true,
-		.get_nr		= test__llvm_subtest_get_nr,
-		.get_desc	= test__llvm_subtest_get_desc,
-	},
-};
-DEFINE_SUITE("Session topology", session_topology);
-static struct test bpf = {
-	.desc = "BPF filter",
-	.func = test__bpf,
-	.subtest = {
-		.skip_if_fail	= true,
-		.get_nr		= test__bpf_subtest_get_nr,
-		.get_desc	= test__bpf_subtest_get_desc,
-	},
-};
-DEFINE_SUITE("Synthesize thread map", thread_map_synthesize);
-DEFINE_SUITE("Remove thread map", thread_map_remove);
-DEFINE_SUITE("Synthesize cpu map", cpu_map_synthesize);
-DEFINE_SUITE("Synthesize stat config", synthesize_stat_config);
-DEFINE_SUITE("Synthesize stat", synthesize_stat);
-DEFINE_SUITE("Synthesize stat round", synthesize_stat_round);
-DEFINE_SUITE("Synthesize attr update", event_update);
-DEFINE_SUITE("Event times", event_times);
-DEFINE_SUITE("Read backward ring buffer", backward_ring_buffer);
-DEFINE_SUITE("Print cpu map", cpu_map_print);
-DEFINE_SUITE("Merge cpu map", cpu_map_merge);
-DEFINE_SUITE("Probe SDT events", sdt_event);
-DEFINE_SUITE("is_printable_array", is_printable_array);
-DEFINE_SUITE("Print bitmap", bitmap_print);
-DEFINE_SUITE("perf hooks", perf_hooks);
-static struct test clang = {
-	.desc = "builtin clang support",
-	.func = test__clang,
-	.subtest = {
-		.skip_if_fail	= true,
-		.get_nr		= test__clang_subtest_get_nr,
-		.get_desc	= test__clang_subtest_get_desc,
-	}
-};
-DEFINE_SUITE("unit_number__scnprintf", unit_number__scnprint);
-DEFINE_SUITE("mem2node", mem2node);
-DEFINE_SUITE("time utils", time_utils);
-DEFINE_SUITE("Test jit_write_elf", jit_write_elf);
-static struct test pfm = {
-	.desc = "Test libpfm4 support",
-	.func = test__pfm,
-	.subtest = {
-		.skip_if_fail	= true,
-		.get_nr		= test__pfm_subtest_get_nr,
-		.get_desc	= test__pfm_subtest_get_desc,
-	}
-};
-DEFINE_SUITE("Test api io", api_io);
-DEFINE_SUITE("maps__merge_in", maps__merge_in);
-DEFINE_SUITE("Demangle Java", demangle_java);
-DEFINE_SUITE("Demangle OCaml", demangle_ocaml);
-DEFINE_SUITE("Parse and process metrics", parse_metric);
-DEFINE_SUITE("PE file support", pe_file_parsing);
-DEFINE_SUITE("Event expansion for cgroups", expand_cgroup_events);
-static struct test perf_time_to_tsc = {
-	.desc = "Convert perf time to TSC",
-	.func = test__perf_time_to_tsc,
-	.is_supported = test__tsc_is_supported,
-};
-DEFINE_SUITE("dlfilter C API", dlfilter);
-
-
 static struct test *generic_tests[] = {
-	&vmlinux_matches_kallsyms,
-	&openat_syscall_event,
-	&openat_syscall_event_on_all_cpus,
-	&basic_mmap,
-	&mem,
-	&parse_events,
-	&expr,
-	&PERF_RECORD,
-	&pmu,
-	&pmu_events,
-	&dso_data,
-	&dso_data_cache,
-	&dso_data_reopen,
-	&perf_evsel__roundtrip_name_test,
-	&perf_evsel__tp_sched_test,
-	&syscall_openat_tp_fields,
-	&attr,
-	&hists_link,
-	&python_use,
-	&bp_signal,
-	&bp_signal_overflow,
-	&bp_accounting,
-	&wp,
-	&task_exit,
-	&sw_clock_freq,
-	&code_reading,
-	&sample_parsing,
-	&keep_tracking,
-	&parse_no_sample_id_all,
-	&hists_filter,
-	&mmap_thread_lookup,
-	&thread_maps_share,
-	&hists_output,
-	&hists_cumulate,
-	&switch_tracking,
-	&fdarray__filter,
-	&fdarray__add,
-	&kmod_path__parse,
-	&thread_map,
-	&llvm,
-	&session_topology,
-	&bpf,
-	&thread_map_synthesize,
-	&thread_map_remove,
-	&cpu_map_synthesize,
-	&synthesize_stat_config,
-	&synthesize_stat,
-	&synthesize_stat_round,
-	&event_update,
-	&event_times,
-	&backward_ring_buffer,
-	&cpu_map_print,
-	&cpu_map_merge,
-	&sdt_event,
-	&is_printable_array,
-	&bitmap_print,
-	&perf_hooks,
-	&clang,
-	&unit_number__scnprint,
-	&mem2node,
-	&time_utils,
-	&jit_write_elf,
-	&pfm,
-	&api_io,
-	&maps__merge_in,
-	&demangle_java,
-	&demangle_ocaml,
-	&parse_metric,
-	&pe_file_parsing,
-	&expand_cgroup_events,
-	&perf_time_to_tsc,
-	&dlfilter,
+	&suite__vmlinux_matches_kallsyms,
+	&suite__openat_syscall_event,
+	&suite__openat_syscall_event_on_all_cpus,
+	&suite__basic_mmap,
+	&suite__mem,
+	&suite__parse_events,
+	&suite__expr,
+	&suite__PERF_RECORD,
+	&suite__pmu,
+	&suite__pmu_events,
+	&suite__dso_data,
+	&suite__dso_data_cache,
+	&suite__dso_data_reopen,
+	&suite__perf_evsel__roundtrip_name_test,
+	&suite__perf_evsel__tp_sched_test,
+	&suite__syscall_openat_tp_fields,
+	&suite__attr,
+	&suite__hists_link,
+	&suite__python_use,
+	&suite__bp_signal,
+	&suite__bp_signal_overflow,
+	&suite__bp_accounting,
+	&suite__wp,
+	&suite__task_exit,
+	&suite__sw_clock_freq,
+	&suite__code_reading,
+	&suite__sample_parsing,
+	&suite__keep_tracking,
+	&suite__parse_no_sample_id_all,
+	&suite__hists_filter,
+	&suite__mmap_thread_lookup,
+	&suite__thread_maps_share,
+	&suite__hists_output,
+	&suite__hists_cumulate,
+	&suite__switch_tracking,
+	&suite__fdarray__filter,
+	&suite__fdarray__add,
+	&suite__kmod_path__parse,
+	&suite__thread_map,
+	&suite__llvm,
+	&suite__session_topology,
+	&suite__bpf,
+	&suite__thread_map_synthesize,
+	&suite__thread_map_remove,
+	&suite__cpu_map_synthesize,
+	&suite__synthesize_stat_config,
+	&suite__synthesize_stat,
+	&suite__synthesize_stat_round,
+	&suite__event_update,
+	&suite__event_times,
+	&suite__backward_ring_buffer,
+	&suite__cpu_map_print,
+	&suite__cpu_map_merge,
+	&suite__sdt_event,
+	&suite__is_printable_array,
+	&suite__bitmap_print,
+	&suite__perf_hooks,
+	&suite__clang,
+	&suite__unit_number__scnprint,
+	&suite__mem2node,
+	&suite__time_utils,
+	&suite__jit_write_elf,
+	&suite__pfm,
+	&suite__api_io,
+	&suite__maps__merge_in,
+	&suite__demangle_java,
+	&suite__demangle_ocaml,
+	&suite__parse_metric,
+	&suite__pe_file_parsing,
+	&suite__expand_cgroup_events,
+	&suite__perf_time_to_tsc,
+	&suite__dlfilter,
 	NULL,
 };
 
diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
index 2577d3ed1531..5052be1b5b20 100644
--- a/tools/perf/tests/clang.c
+++ b/tools/perf/tests/clang.c
@@ -19,12 +19,12 @@ static struct {
 #endif
 };
 
-int test__clang_subtest_get_nr(void)
+static int test__clang_subtest_get_nr(void)
 {
 	return (int)ARRAY_SIZE(clang_testcase_table);
 }
 
-const char *test__clang_subtest_get_desc(int i)
+static const char *test__clang_subtest_get_desc(int i)
 {
 	if (i < 0 || i >= (int)ARRAY_SIZE(clang_testcase_table))
 		return NULL;
@@ -32,15 +32,25 @@ const char *test__clang_subtest_get_desc(int i)
 }
 
 #ifndef HAVE_LIBCLANGLLVM_SUPPORT
-int test__clang(struct test *test __maybe_unused, int i __maybe_unused)
+static int test__clang(struct test *test __maybe_unused, int i __maybe_unused)
 {
 	return TEST_SKIP;
 }
 #else
-int test__clang(struct test *test __maybe_unused, int i)
+static int test__clang(struct test *test __maybe_unused, int i)
 {
 	if (i < 0 || i >= (int)ARRAY_SIZE(clang_testcase_table))
 		return TEST_FAIL;
 	return clang_testcase_table[i].func();
 }
 #endif
+
+struct test suite__clang = {
+	.desc = "builtin clang support",
+	.func = test__clang,
+	.subtest = {
+		.skip_if_fail	= true,
+		.get_nr		= test__clang_subtest_get_nr,
+		.get_desc	= test__clang_subtest_get_desc,
+	}
+};
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index f439bd49da19..e4199cb4d4bf 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -716,7 +716,7 @@ static int do_test_code_reading(bool try_kcore)
 	return err;
 }
 
-int test__code_reading(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__code_reading(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret;
 
@@ -743,3 +743,5 @@ int test__code_reading(struct test *test __maybe_unused, int subtest __maybe_unu
 		return -1;
 	};
 }
+
+DEFINE_SUITE("Object code reading", code_reading);
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 0472b110fe65..6f2525fb9fd7 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -75,7 +75,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 }
 
 
-int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_cpu_map *cpus;
 
@@ -111,7 +111,7 @@ static int cpu_map_print(const char *str)
 	return !strcmp(buf, str);
 }
 
-int test__cpu_map_print(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__cpu_map_print(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1"));
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,5"));
@@ -123,7 +123,7 @@ int test__cpu_map_print(struct test *test __maybe_unused, int subtest __maybe_un
 	return 0;
 }
 
-int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
 	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
@@ -137,3 +137,7 @@ int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_un
 	perf_cpu_map__put(c);
 	return 0;
 }
+
+DEFINE_SUITE("Synthesize cpu map", cpu_map_synthesize);
+DEFINE_SUITE("Print cpu map", cpu_map_print);
+DEFINE_SUITE("Merge cpu map", cpu_map_merge);
diff --git a/tools/perf/tests/demangle-java-test.c b/tools/perf/tests/demangle-java-test.c
index 8f3b90832fb0..37f488e5c36d 100644
--- a/tools/perf/tests/demangle-java-test.c
+++ b/tools/perf/tests/demangle-java-test.c
@@ -7,7 +7,7 @@
 #include "debug.h"
 #include "demangle-java.h"
 
-int test__demangle_java(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__demangle_java(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret = TEST_OK;
 	char *buf = NULL;
@@ -40,3 +40,5 @@ int test__demangle_java(struct test *test __maybe_unused, int subtest __maybe_un
 
 	return ret;
 }
+
+DEFINE_SUITE("Demangle Java", demangle_java);
diff --git a/tools/perf/tests/demangle-ocaml-test.c b/tools/perf/tests/demangle-ocaml-test.c
index 0043be812355..ee982cca7bbf 100644
--- a/tools/perf/tests/demangle-ocaml-test.c
+++ b/tools/perf/tests/demangle-ocaml-test.c
@@ -7,7 +7,7 @@
 #include "debug.h"
 #include "demangle-ocaml.h"
 
-int test__demangle_ocaml(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__demangle_ocaml(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret = TEST_OK;
 	char *buf = NULL;
@@ -41,3 +41,5 @@ int test__demangle_ocaml(struct test *test __maybe_unused, int subtest __maybe_u
 
 	return ret;
 }
+
+DEFINE_SUITE("Demangle OCaml", demangle_ocaml);
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index bc03b5df6828..378f5afc6032 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -398,7 +398,7 @@ static void test_data__free(struct test_data *td)
 	}
 }
 
-int test__dlfilter(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__dlfilter(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct test_data td = {.fd = -1};
 	int pid = getpid();
@@ -414,3 +414,5 @@ int test__dlfilter(struct test *test __maybe_unused, int subtest __maybe_unused)
 	test_data__free(&td);
 	return err;
 }
+
+DEFINE_SUITE("dlfilter C API", dlfilter);
diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 43e1b01e5afc..d9e060a7c1f6 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -113,7 +113,7 @@ static int dso__data_fd(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
-int test__dso_data(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__dso_data(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machine machine;
 	struct dso *dso;
@@ -248,7 +248,7 @@ static int set_fd_limit(int n)
 	return setrlimit(RLIMIT_NOFILE, &rlim);
 }
 
-int test__dso_data_cache(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__dso_data_cache(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machine machine;
 	long nr_end, nr = open_files_cnt();
@@ -318,7 +318,7 @@ static long new_limit(int count)
 	return ret;
 }
 
-int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machine machine;
 	long nr_end, nr = open_files_cnt(), lim = new_limit(3);
@@ -393,3 +393,7 @@ int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_
 	TEST_ASSERT_VAL("failed leaking files", nr == nr_end);
 	return 0;
 }
+
+DEFINE_SUITE("DSO data read", dso_data);
+DEFINE_SUITE("DSO data cache", dso_data_cache);
+DEFINE_SUITE("DSO data reopen", dso_data_reopen);
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 38f16a53613f..6e0429012ed6 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -238,7 +238,4 @@ static int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __ma
 	return err;
 }
 
-struct test dwarf_unwind = {
-	.desc = "Test dwarf unwind",
-	.func = test__dwarf_unwind,
-};
+DEFINE_SUITE("Test dwarf unwind", dwarf_unwind);
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 04ce4401f775..2ce8945931e7 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -216,7 +216,7 @@ static int test_times(int (attach)(struct evlist *),
  * and checks that enabled and running times
  * match.
  */
-int test__event_times(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__event_times(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err, ret = 0;
 
@@ -239,3 +239,5 @@ int test__event_times(struct test *test __maybe_unused, int subtest __maybe_unus
 #undef _T
 	return ret;
 }
+
+DEFINE_SUITE("Event times", event_times);
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 44a50527f9d9..9dfb665f8ac9 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -83,7 +83,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct evsel *evsel;
 	struct event_name tmp;
@@ -123,3 +123,5 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	evlist__delete(evlist);
 	return 0;
 }
+
+DEFINE_SUITE("Synthesize attr update", event_update);
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 4e09f0a312af..82ff3c04d0bd 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -99,7 +99,8 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names,
 #define perf_evsel__name_array_test(names, distance) \
 	__perf_evsel__name_array_test(names, ARRAY_SIZE(names), distance)
 
-int test__perf_evsel__roundtrip_name_test(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__perf_evsel__roundtrip_name_test(struct test *test __maybe_unused,
+						 int subtest __maybe_unused)
 {
 	int err = 0, ret = 0;
 
@@ -120,3 +121,5 @@ int test__perf_evsel__roundtrip_name_test(struct test *test __maybe_unused, int
 
 	return ret;
 }
+
+DEFINE_SUITE("Roundtrip evsel->name", perf_evsel__roundtrip_name_test);
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index f9e34bd26cf3..58f17d18e4d5 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -32,7 +32,8 @@ static int evsel__test_field(struct evsel *evsel, const char *name, int size, bo
 	return ret;
 }
 
-int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused,
+					   int subtest __maybe_unused)
 {
 	struct evsel *evsel = evsel__newtp("sched", "sched_switch");
 	int ret = 0;
@@ -87,3 +88,5 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 	evsel__delete(evsel);
 	return ret;
 }
+
+DEFINE_SUITE("Parse sched tracepoints fields", perf_evsel__tp_sched_test);
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index aaad51aba12f..17195aea9540 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -219,8 +219,8 @@ static int expand_metric_events(void)
 	return ret;
 }
 
-int test__expand_cgroup_events(struct test *test __maybe_unused,
-			       int subtest __maybe_unused)
+static int test__expand_cgroup_events(struct test *test __maybe_unused,
+				      int subtest __maybe_unused)
 {
 	int ret;
 
@@ -238,3 +238,5 @@ int test__expand_cgroup_events(struct test *test __maybe_unused,
 
 	return ret;
 }
+
+DEFINE_SUITE("Event expansion for cgroups", expand_cgroup_events);
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 077783223ce0..8c6397d0c381 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -62,7 +62,7 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 	return 0;
 }
 
-int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct expr_id_data *val_ptr;
 	const char *p;
@@ -155,3 +155,5 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	return 0;
 }
+
+DEFINE_SUITE("Simple expression parser", expr);
diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
index d9eca8e86a6b..7b2f6c2ad705 100644
--- a/tools/perf/tests/fdarray.c
+++ b/tools/perf/tests/fdarray.c
@@ -28,7 +28,7 @@ static int fdarray__fprintf_prefix(struct fdarray *fda, const char *prefix, FILE
 	return printed + fdarray__fprintf(fda, fp);
 }
 
-int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int nr_fds, err = TEST_FAIL;
 	struct fdarray *fda = fdarray__new(5, 5);
@@ -89,7 +89,7 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
 	return err;
 }
 
-int test__fdarray__add(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__fdarray__add(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
 	struct fdarray *fda = fdarray__new(2, 2);
@@ -158,3 +158,6 @@ int test__fdarray__add(struct test *test __maybe_unused, int subtest __maybe_unu
 out:
 	return err;
 }
+
+DEFINE_SUITE("Filter fds with revents mask in a fdarray", fdarray__filter);
+DEFINE_SUITE("Add fd to a fdarray, making it autogrow", fdarray__add);
diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
index f797f9823e89..3c5ced5d9588 100644
--- a/tools/perf/tests/genelf.c
+++ b/tools/perf/tests/genelf.c
@@ -16,8 +16,8 @@
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
 
-int test__jit_write_elf(struct test *test __maybe_unused,
-			int subtest __maybe_unused)
+static int test__jit_write_elf(struct test *test __maybe_unused,
+			       int subtest __maybe_unused)
 {
 #ifdef HAVE_JITDUMP
 	static unsigned char x86_code[] = {
@@ -49,3 +49,5 @@ int test__jit_write_elf(struct test *test __maybe_unused,
 	return TEST_SKIP;
 #endif
 }
+
+DEFINE_SUITE("Test jit_write_elf", jit_write_elf);
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 890cb1f5bf53..f7a8d3d78389 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -689,7 +689,7 @@ static int test4(struct evsel *evsel, struct machine *machine)
 	return err;
 }
 
-int test__hists_cumulate(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__hists_cumulate(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
 	struct machines machines;
@@ -736,3 +736,5 @@ int test__hists_cumulate(struct test *test __maybe_unused, int subtest __maybe_u
 
 	return err;
 }
+
+DEFINE_SUITE("Cumulate child hist entries", hists_cumulate);
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index ca6120cd1d90..09e140191e5f 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -101,7 +101,7 @@ static int add_hist_entries(struct evlist *evlist,
 	return TEST_FAIL;
 }
 
-int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
 	struct machines machines;
@@ -325,3 +325,5 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	return err;
 }
+
+DEFINE_SUITE("Filter hist entries", hists_filter);
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index a024d3f3a412..08571f788884 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -264,7 +264,7 @@ static int validate_link(struct hists *leader, struct hists *other)
 	return __validate_link(leader, 0) || __validate_link(other, 1);
 }
 
-int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1;
 	struct hists *hists, *first_hists;
@@ -339,3 +339,5 @@ int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unuse
 
 	return err;
 }
+
+DEFINE_SUITE("Match and link multiple hists", hists_link);
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 8973f35df604..b427df8ee94a 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -575,7 +575,7 @@ static int test5(struct evsel *evsel, struct machine *machine)
 	return err;
 }
 
-int test__hists_output(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__hists_output(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
 	struct machines machines;
@@ -623,3 +623,5 @@ int test__hists_output(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	return err;
 }
+
+DEFINE_SUITE("Sort output of hist entries", hists_output);
diff --git a/tools/perf/tests/is_printable_array.c b/tools/perf/tests/is_printable_array.c
index 9c7b3baca4fe..8891b10fac5c 100644
--- a/tools/perf/tests/is_printable_array.c
+++ b/tools/perf/tests/is_printable_array.c
@@ -5,7 +5,7 @@
 #include "debug.h"
 #include "print_binary.h"
 
-int test__is_printable_array(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__is_printable_array(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	char buf1[] = { 'k', 'r', 4, 'v', 'a', 0 };
 	char buf2[] = { 'k', 'r', 'a', 'v', 4, 0 };
@@ -36,3 +36,5 @@ int test__is_printable_array(struct test *test __maybe_unused, int subtest __may
 
 	return TEST_OK;
 }
+
+DEFINE_SUITE("is_printable_array", is_printable_array);
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index a0438b0f0805..e723c976dc81 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -61,7 +61,7 @@ static int find_comm(struct evlist *evlist, const char *comm)
  * when an event is disabled but a dummy software event is not disabled.  If the
  * test passes %0 is returned, otherwise %-1 is returned.
  */
-int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct record_opts opts = {
 		.mmap_pages	     = UINT_MAX,
@@ -160,3 +160,5 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 
 	return err;
 }
+
+DEFINE_SUITE("Use a dummy software event to keep tracking", keep_tracking);
diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index e483210b176b..4935dd3182ed 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -47,7 +47,7 @@ static int test_is_kernel_module(const char *path, int cpumode, bool expect)
 #define M(path, c, e) \
 	TEST_ASSERT_VAL("failed", !test_is_kernel_module(path, c, e))
 
-int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	/* path                alloc_name  kmod  comp   name   */
 	T("/xxxx/xxxx/x-x.ko", true      , true, 0    , "[x_x]");
@@ -159,3 +159,5 @@ int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_un
 
 	return 0;
 }
+
+DEFINE_SUITE("kmod_path__parse", kmod_path__parse);
diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index 33e43cce9064..b605a71ad8d5 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -124,7 +124,7 @@ test_llvm__fetch_bpf_obj(void **p_obj_buf,
 	return ret;
 }
 
-int test__llvm(struct test *test __maybe_unused, int subtest)
+static int test__llvm(struct test *test __maybe_unused, int subtest)
 {
 	int ret;
 	void *obj_buf = NULL;
@@ -149,12 +149,12 @@ int test__llvm(struct test *test __maybe_unused, int subtest)
 	return ret;
 }
 
-int test__llvm_subtest_get_nr(void)
+static int test__llvm_subtest_get_nr(void)
 {
 	return __LLVM_TESTCASE_MAX;
 }
 
-const char *test__llvm_subtest_get_desc(int subtest)
+static const char *test__llvm_subtest_get_desc(int subtest)
 {
 	if ((subtest < 0) || (subtest >= __LLVM_TESTCASE_MAX))
 		return NULL;
@@ -162,18 +162,28 @@ const char *test__llvm_subtest_get_desc(int subtest)
 	return bpf_source_table[subtest].desc;
 }
 #else //HAVE_LIBBPF_SUPPORT
-int test__llvm(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__llvm(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	return TEST_SKIP;
 }
 
-int test__llvm_subtest_get_nr(void)
+static int test__llvm_subtest_get_nr(void)
 {
 	return 0;
 }
 
-const char *test__llvm_subtest_get_desc(int subtest __maybe_unused)
+static const char *test__llvm_subtest_get_desc(int subtest __maybe_unused)
 {
 	return NULL;
 }
 #endif // HAVE_LIBBPF_SUPPORT
+
+struct test suite__llvm = {
+	.desc = "LLVM search and compile",
+	.func = test__llvm,
+	.subtest = {
+		.skip_if_fail	= true,
+		.get_nr		= test__llvm_subtest_get_nr,
+		.get_desc	= test__llvm_subtest_get_desc,
+	},
+};
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 1ac72919fa35..4a2e6f312015 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -33,7 +33,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 	return TEST_OK;
 }
 
-int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct maps maps;
 	unsigned int i;
@@ -120,3 +120,5 @@ int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unus
 	maps__exit(&maps);
 	return TEST_OK;
 }
+
+DEFINE_SUITE("maps__merge_in", maps__merge_in);
diff --git a/tools/perf/tests/mem.c b/tools/perf/tests/mem.c
index 673a11a6cd1b..3af082508653 100644
--- a/tools/perf/tests/mem.c
+++ b/tools/perf/tests/mem.c
@@ -23,7 +23,7 @@ static int check(union perf_mem_data_src data_src,
 	return 0;
 }
 
-int test__mem(struct test *text __maybe_unused, int subtest __maybe_unused)
+static int test__mem(struct test *text __maybe_unused, int subtest __maybe_unused)
 {
 	int ret = 0;
 	union perf_mem_data_src src;
@@ -56,3 +56,5 @@ int test__mem(struct test *text __maybe_unused, int subtest __maybe_unused)
 
 	return ret;
 }
+
+DEFINE_SUITE("Test data source output", mem);
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index e4d0d58b97f8..0a90e6084d81 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -43,7 +43,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	return bm && map ? bm : NULL;
 }
 
-int test__mem2node(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__mem2node(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct mem2node map;
 	struct memory_node nodes[3];
@@ -77,3 +77,5 @@ int test__mem2node(struct test *t __maybe_unused, int subtest __maybe_unused)
 	mem2node__exit(&map);
 	return 0;
 }
+
+DEFINE_SUITE("mem2node", mem2node);
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index d38757db2dc2..86f34631312d 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -29,7 +29,7 @@
  * Then it checks if the number of syscalls reported as perf events by
  * the kernel corresponds to the number of syscalls made.
  */
-int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1;
 	union perf_event *event;
@@ -164,3 +164,5 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 	perf_thread_map__put(threads);
 	return err;
 }
+
+DEFINE_SUITE("Read samples using the mmap interface", basic_mmap);
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 6f2da7a72f67..756a46c796f7 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -224,7 +224,7 @@ static int mmap_events(synth_cb synth)
  *
  * by using all thread objects.
  */
-int test__mmap_thread_lookup(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__mmap_thread_lookup(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	/* perf_event__synthesize_threads synthesize */
 	TEST_ASSERT_VAL("failed with sythesizing all",
@@ -236,3 +236,5 @@ int test__mmap_thread_lookup(struct test *test __maybe_unused, int subtest __may
 
 	return 0;
 }
+
+DEFINE_SUITE("Lookup mmap thread", mmap_thread_lookup);
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index f7dd6c463f04..28f3597ba531 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -19,7 +19,8 @@
 #include "stat.h"
 #include "util/counts.h"
 
-int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused,
+						  int subtest __maybe_unused)
 {
 	int err = -1, fd, cpu;
 	struct perf_cpu_map *cpus;
@@ -127,3 +128,5 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 	perf_thread_map__put(threads);
 	return err;
 }
+
+DEFINE_SUITE("Detect openat syscall event on all cpus", openat_syscall_event_on_all_cpus);
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 5e4af2f0f14a..cbb5c0fa40fe 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -22,7 +22,8 @@
 #define AT_FDCWD       -100
 #endif
 
-int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__syscall_openat_tp_fields(struct test *test __maybe_unused,
+					  int subtest __maybe_unused)
 {
 	struct record_opts opts = {
 		.target = {
@@ -142,3 +143,5 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 out:
 	return err;
 }
+
+DEFINE_SUITE("syscalls:sys_enter_openat event fields", syscall_openat_tp_fields);
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 85a8f0fe7aea..8f904fcebe6f 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -13,7 +13,8 @@
 #include "tests.h"
 #include "util/counts.h"
 
-int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__openat_syscall_event(struct test *test __maybe_unused,
+				      int subtest __maybe_unused)
 {
 	int err = -1, fd;
 	struct evsel *evsel;
@@ -66,3 +67,5 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 	perf_thread_map__put(threads);
 	return err;
 }
+
+DEFINE_SUITE("Detect openat syscall event", openat_syscall_event);
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 8875e388563e..b6232aa6975b 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2276,7 +2276,7 @@ static int test_pmu_events_alias(char *event, char *alias)
 	return test_event(&e);
 }
 
-int test__parse_events(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__parse_events(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret1, ret2 = 0;
 	char *event, *alias;
@@ -2319,3 +2319,5 @@ do {							\
 
 	return ret2;
 }
+
+DEFINE_SUITE("Parse event definition strings", parse_events);
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index dfc797ecc750..999d37fc58f2 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -369,7 +369,7 @@ static int test_metric_group(void)
 	return 0;
 }
 
-int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
 	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
@@ -383,3 +383,5 @@ int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unu
 	}
 	return 0;
 }
+
+DEFINE_SUITE("Parse and process metrics", parse_metric);
diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf/tests/parse-no-sample-id-all.c
index 471273676701..2a5eec424a43 100644
--- a/tools/perf/tests/parse-no-sample-id-all.c
+++ b/tools/perf/tests/parse-no-sample-id-all.c
@@ -67,7 +67,8 @@ struct test_attr_event {
  *
  * Return: %0 on success, %-1 if the test fails.
  */
-int test__parse_no_sample_id_all(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__parse_no_sample_id_all(struct test *test __maybe_unused,
+					int subtest __maybe_unused)
 {
 	int err;
 
@@ -103,3 +104,5 @@ int test__parse_no_sample_id_all(struct test *test __maybe_unused, int subtest _
 
 	return 0;
 }
+
+DEFINE_SUITE("Parse with no sample_id_all bit set", parse_no_sample_id_all);
diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 58b90c42eb38..8d4fec99459a 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -68,7 +68,7 @@ static int run_dir(const char *d)
 	return TEST_OK;
 }
 
-int test__pe_file_parsing(struct test *test __maybe_unused,
+static int test__pe_file_parsing(struct test *test __maybe_unused,
 			  int subtest __maybe_unused)
 {
 	struct stat st;
@@ -89,10 +89,12 @@ int test__pe_file_parsing(struct test *test __maybe_unused,
 
 #else
 
-int test__pe_file_parsing(struct test *test __maybe_unused,
+static int test__pe_file_parsing(struct test *test __maybe_unused,
 			  int subtest __maybe_unused)
 {
 	return TEST_SKIP;
 }
 
 #endif
+
+DEFINE_SUITE("PE file support", pe_file_parsing);
diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
index dd865e0bea12..61cb1d0a6eb9 100644
--- a/tools/perf/tests/perf-hooks.c
+++ b/tools/perf/tests/perf-hooks.c
@@ -26,7 +26,7 @@ static void the_hook(void *_hook_flags)
 	raise(SIGSEGV);
 }
 
-int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int hook_flags = 0;
 
@@ -45,3 +45,5 @@ int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unuse
 		return TEST_FAIL;
 	return TEST_OK;
 }
+
+DEFINE_SUITE("perf hooks", perf_hooks);
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 0df471bf1590..24faa8487d8c 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -41,7 +41,7 @@ static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
 	return cpu;
 }
 
-int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct record_opts opts = {
 		.target = {
@@ -332,3 +332,5 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 out:
 	return (err < 0 || errs > 0) ? -1 : 0;
 }
+
+DEFINE_SUITE("PERF_RECORD_* events & perf_sample fields", PERF_RECORD);
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 7c56bc1f4cff..dc2dcad7371f 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -45,7 +45,7 @@
  * %0 is returned, otherwise %-1 is returned.  If TSC conversion is not
  * supported then then the test passes but " (not supported)" is printed.
  */
-int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct record_opts opts = {
 		.mmap_pages	     = UINT_MAX,
@@ -185,7 +185,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	return err;
 }
 
-bool test__tsc_is_supported(void)
+static bool test__tsc_is_supported(void)
 {
 	/*
 	 * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.
@@ -197,3 +197,9 @@ bool test__tsc_is_supported(void)
 	return false;
 #endif
 }
+
+struct test suite__perf_time_to_tsc = {
+	.desc = "Convert perf time to TSC",
+	.func = test__perf_time_to_tsc,
+	.is_supported = test__tsc_is_supported,
+};
diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index e8fd0da0762b..83dc9742813a 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -189,19 +189,19 @@ static int test__pfm_group(void)
 }
 #endif
 
-const char *test__pfm_subtest_get_desc(int i)
+static const char *test__pfm_subtest_get_desc(int i)
 {
 	if (i < 0 || i >= (int)ARRAY_SIZE(pfm_testcase_table))
 		return NULL;
 	return pfm_testcase_table[i].desc;
 }
 
-int test__pfm_subtest_get_nr(void)
+static int test__pfm_subtest_get_nr(void)
 {
 	return (int)ARRAY_SIZE(pfm_testcase_table);
 }
 
-int test__pfm(struct test *test __maybe_unused, int i __maybe_unused)
+static int test__pfm(struct test *test __maybe_unused, int i __maybe_unused)
 {
 #ifdef HAVE_LIBPFM
 	if (i < 0 || i >= (int)ARRAY_SIZE(pfm_testcase_table))
@@ -211,3 +211,13 @@ int test__pfm(struct test *test __maybe_unused, int i __maybe_unused)
 	return TEST_SKIP;
 #endif
 }
+
+struct test suite__pfm = {
+	.desc = "Test libpfm4 support",
+	.func = test__pfm,
+	.subtest = {
+		.skip_if_fail	= true,
+		.get_nr		= test__pfm_subtest_get_nr,
+		.get_desc	= test__pfm_subtest_get_desc,
+	}
+};
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 50b1299fe643..3fde6109c9d2 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -1092,7 +1092,7 @@ static const struct {
 	},
 };
 
-const char *test__pmu_events_subtest_get_desc(int subtest)
+static const char *test__pmu_events_subtest_get_desc(int subtest)
 {
 	if (subtest < 0 ||
 	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
@@ -1100,7 +1100,7 @@ const char *test__pmu_events_subtest_get_desc(int subtest)
 	return pmu_events_testcase_table[subtest].desc;
 }
 
-const char *test__pmu_events_subtest_skip_reason(int subtest)
+static const char *test__pmu_events_subtest_skip_reason(int subtest)
 {
 	if (subtest < 0 ||
 	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
@@ -1110,15 +1110,26 @@ const char *test__pmu_events_subtest_skip_reason(int subtest)
 	return "some metrics failed";
 }
 
-int test__pmu_events_subtest_get_nr(void)
+static int test__pmu_events_subtest_get_nr(void)
 {
 	return (int)ARRAY_SIZE(pmu_events_testcase_table);
 }
 
-int test__pmu_events(struct test *test __maybe_unused, int subtest)
+static int test__pmu_events(struct test *test __maybe_unused, int subtest)
 {
 	if (subtest < 0 ||
 	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
 		return TEST_FAIL;
 	return pmu_events_testcase_table[subtest].func();
 }
+
+struct test suite__pmu_events = {
+	.desc = "PMU events",
+	.func = test__pmu_events,
+	.subtest = {
+		.skip_if_fail	= false,
+		.get_nr		= test__pmu_events_subtest_get_nr,
+		.get_desc	= test__pmu_events_subtest_get_desc,
+		.skip_reason	= test__pmu_events_subtest_skip_reason,
+	},
+};
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 714e6830a758..9a58dad67b27 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -137,7 +137,7 @@ static struct list_head *test_terms_list(void)
 	return &terms;
 }
 
-int test__pmu(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__pmu(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	char *format = test_format_dir_get();
 	LIST_HEAD(formats);
@@ -177,3 +177,5 @@ int test__pmu(struct test *test __maybe_unused, int subtest __maybe_unused)
 	test_format_dir_put(format);
 	return ret;
 }
+
+DEFINE_SUITE("Parse perf pmu format", pmu);
diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 98c6d474aa6f..b667140688be 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -9,7 +9,7 @@
 #include "tests.h"
 #include "util/debug.h"
 
-int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	char *cmd;
 	int ret;
@@ -23,3 +23,5 @@ int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unuse
 	free(cmd);
 	return ret;
 }
+
+DEFINE_SUITE("'import perf' in python", python_use);
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index c83a11514129..08453238c777 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -368,7 +368,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
  * checks sample format bits separately and together.  If the test passes %0 is
  * returned, otherwise %-1 is returned.
  */
-int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	const u64 rf[] = {4, 5, 6, 7, 12, 13, 14, 15};
 	u64 sample_type;
@@ -426,3 +426,5 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 
 	return 0;
 }
+
+DEFINE_SUITE("Sample parsing", sample_parsing);
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index ed76c693f65e..307615f1b6a7 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -76,7 +76,7 @@ static int search_cached_probe(const char *target,
 	return ret;
 }
 
-int test__sdt_event(struct test *test __maybe_unused, int subtests __maybe_unused)
+static int test__sdt_event(struct test *test __maybe_unused, int subtests __maybe_unused)
 {
 	int ret = TEST_FAIL;
 	char __tempdir[] = "./test-buildid-XXXXXX";
@@ -114,9 +114,11 @@ int test__sdt_event(struct test *test __maybe_unused, int subtests __maybe_unuse
 	return ret;
 }
 #else
-int test__sdt_event(struct test *test __maybe_unused, int subtests __maybe_unused)
+static int test__sdt_event(struct test *test __maybe_unused, int subtests __maybe_unused)
 {
 	pr_debug("Skip SDT event test because SDT support is not compiled\n");
 	return TEST_SKIP;
 }
 #endif
+
+DEFINE_SUITE("Probe SDT events", sdt_event);
diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
index c1911501c39c..2589f2f529ba 100644
--- a/tools/perf/tests/stat.c
+++ b/tools/perf/tests/stat.c
@@ -47,7 +47,8 @@ static int process_stat_config_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-int test__synthesize_stat_config(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__synthesize_stat_config(struct test *test __maybe_unused,
+					int subtest __maybe_unused)
 {
 	struct perf_stat_config stat_config = {
 		.aggr_mode	= AGGR_CORE,
@@ -77,7 +78,7 @@ static int process_stat_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-int test__synthesize_stat(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__synthesize_stat(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_counts_values count;
 
@@ -103,7 +104,7 @@ static int process_stat_round_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-int test__synthesize_stat_round(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__synthesize_stat_round(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("failed to synthesize stat_config",
 		!perf_event__synthesize_stat_round(NULL, 0xdeadbeef, PERF_STAT_ROUND_TYPE__INTERVAL,
@@ -111,3 +112,7 @@ int test__synthesize_stat_round(struct test *test __maybe_unused, int subtest __
 
 	return 0;
 }
+
+DEFINE_SUITE("Synthesize stat config", synthesize_stat_config);
+DEFINE_SUITE("Synthesize stat", synthesize_stat);
+DEFINE_SUITE("Synthesize stat round", synthesize_stat_round);
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 74988846be1d..db1e339a0fbe 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -133,7 +133,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	return err;
 }
 
-int test__sw_clock_freq(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__sw_clock_freq(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret;
 
@@ -143,3 +143,5 @@ int test__sw_clock_freq(struct test *test __maybe_unused, int subtest __maybe_un
 
 	return ret;
 }
+
+DEFINE_SUITE("Software clock events period values", sw_clock_freq);
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 62c0ec21aaa8..9b379aaddce4 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -321,7 +321,7 @@ static int process_events(struct evlist *evlist,
  * evsel->core.system_wide and evsel->tracking flags (respectively) with other events
  * sometimes enabled or disabled.
  */
-int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	const char *sched_switch = "sched:sched_switch";
 	struct switch_tracking switch_tracking = { .tids = NULL, };
@@ -588,3 +588,5 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	err = -1;
 	goto out;
 }
+
+DEFINE_SUITE("Track with sched_switch", switch_tracking);
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 4c2969db59b0..197574230493 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -39,7 +39,7 @@ static void workload_exec_failed_signal(int signo __maybe_unused,
  * if the number of exit event reported by the kernel is 1 or not
  * in order to check the kernel returns correct number of event.
  */
-int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1;
 	union perf_event *event;
@@ -151,3 +151,5 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	evlist__delete(evlist);
 	return err;
 }
+
+DEFINE_SUITE("Number of exit events of a simple workload", task_exit);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 8323a3c88284..f2efa331b32f 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -41,10 +41,10 @@ struct test {
 };
 
 #define DECLARE_SUITE(name) \
-	int test__##name(struct test *test, int subtest)
+	extern struct test suite__##name;
 
 #define DEFINE_SUITE(description, name)		\
-	static struct test name = {		\
+	struct test suite__##name = {		\
 		.desc = description,		\
 		.func = test__##name,		\
 	}
@@ -60,9 +60,6 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
 DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
-const char *test__pmu_events_subtest_get_desc(int subtest);
-const char *test__pmu_events_subtest_skip_reason(int subtest);
-int test__pmu_events_subtest_get_nr(void);
 DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
 DECLARE_SUITE(dso_data_cache);
@@ -74,9 +71,6 @@ DECLARE_SUITE(bp_signal);
 DECLARE_SUITE(bp_signal_overflow);
 DECLARE_SUITE(bp_accounting);
 DECLARE_SUITE(wp);
-const char *test__wp_subtest_get_desc(int subtest);
-const char *test__wp_subtest_skip_reason(int subtest);
-int test__wp_subtest_get_nr(void);
 DECLARE_SUITE(task_exit);
 DECLARE_SUITE(mem);
 DECLARE_SUITE(sw_clock_freq);
@@ -84,7 +78,7 @@ DECLARE_SUITE(code_reading);
 DECLARE_SUITE(sample_parsing);
 DECLARE_SUITE(keep_tracking);
 DECLARE_SUITE(parse_no_sample_id_all);
-extern struct test dwarf_unwind;
+DECLARE_SUITE(dwarf_unwind);
 DECLARE_SUITE(expr);
 DECLARE_SUITE(hists_filter);
 DECLARE_SUITE(mmap_thread_lookup);
@@ -97,11 +91,7 @@ DECLARE_SUITE(fdarray__add);
 DECLARE_SUITE(kmod_path__parse);
 DECLARE_SUITE(thread_map);
 DECLARE_SUITE(llvm);
-const char *test__llvm_subtest_get_desc(int subtest);
-int test__llvm_subtest_get_nr(void);
 DECLARE_SUITE(bpf);
-const char *test__bpf_subtest_get_desc(int subtest);
-int test__bpf_subtest_get_nr(void);
 DECLARE_SUITE(session_topology);
 DECLARE_SUITE(thread_map_synthesize);
 DECLARE_SUITE(thread_map_remove);
@@ -119,8 +109,6 @@ DECLARE_SUITE(is_printable_array);
 DECLARE_SUITE(bitmap_print);
 DECLARE_SUITE(perf_hooks);
 DECLARE_SUITE(clang);
-const char *test__clang_subtest_get_desc(int subtest);
-int test__clang_subtest_get_nr(void);
 DECLARE_SUITE(unit_number__scnprint);
 DECLARE_SUITE(mem2node);
 DECLARE_SUITE(maps__merge_in);
@@ -130,8 +118,6 @@ DECLARE_SUITE(api_io);
 DECLARE_SUITE(demangle_java);
 DECLARE_SUITE(demangle_ocaml);
 DECLARE_SUITE(pfm);
-const char *test__pfm_subtest_get_desc(int subtest);
-int test__pfm_subtest_get_nr(void);
 DECLARE_SUITE(parse_metric);
 DECLARE_SUITE(pe_file_parsing);
 DECLARE_SUITE(expand_cgroup_events);
@@ -139,9 +125,6 @@ DECLARE_SUITE(perf_time_to_tsc);
 DECLARE_SUITE(dlfilter);
 
 bool test__bp_signal_is_supported(void);
-bool test__bp_account_is_supported(void);
-bool test__wp_is_supported(void);
-bool test__tsc_is_supported(void);
 
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index d1e208b4a571..7e2e8a72fa78 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -19,7 +19,7 @@ struct machine;
 #define NAME	(const char *) "perf"
 #define NAMEUL	(unsigned long) NAME
 
-int test__thread_map(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__thread_map(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_thread_map *map;
 
@@ -86,7 +86,7 @@ static int process_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-int test__thread_map_synthesize(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__thread_map_synthesize(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_thread_map *threads;
 
@@ -106,7 +106,7 @@ int test__thread_map_synthesize(struct test *test __maybe_unused, int subtest __
 	return 0;
 }
 
-int test__thread_map_remove(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__thread_map_remove(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_thread_map *threads;
 	char *str;
@@ -145,3 +145,7 @@ int test__thread_map_remove(struct test *test __maybe_unused, int subtest __mayb
 	perf_thread_map__put(threads);
 	return 0;
 }
+
+DEFINE_SUITE("Thread map", thread_map);
+DEFINE_SUITE("Synthesize thread map", thread_map_synthesize);
+DEFINE_SUITE("Remove thread map", thread_map_remove);
diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
index 9371484973f2..2821be0a9a05 100644
--- a/tools/perf/tests/thread-maps-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -4,7 +4,7 @@
 #include "thread.h"
 #include "debug.h"
 
-int test__thread_maps_share(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__thread_maps_share(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machines machines;
 	struct machine *machine;
@@ -96,3 +96,5 @@ int test__thread_maps_share(struct test *test __maybe_unused, int subtest __mayb
 	machines__exit(&machines);
 	return 0;
 }
+
+DEFINE_SUITE("Share thread maps", thread_maps_share);
diff --git a/tools/perf/tests/time-utils-test.c b/tools/perf/tests/time-utils-test.c
index fe57ca3b6e54..538100cb7541 100644
--- a/tools/perf/tests/time-utils-test.c
+++ b/tools/perf/tests/time-utils-test.c
@@ -131,7 +131,7 @@ static bool test__perf_time__parse_for_ranges(struct test_data *d)
 	return pass;
 }
 
-int test__time_utils(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__time_utils(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	bool pass = true;
 
@@ -249,3 +249,5 @@ int test__time_utils(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	return pass ? 0 : TEST_FAIL;
 }
+
+DEFINE_SUITE("time utils", time_utils);
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index b9028e304ddd..05fda3955f95 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -173,7 +173,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	return 0;
 }
 
-int test__session_topology(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__session_topology(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	char path[PATH_MAX];
 	struct perf_cpu_map *map;
@@ -199,3 +199,5 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
 	unlink(path);
 	return ret;
 }
+
+DEFINE_SUITE("Session topology", session_topology);
diff --git a/tools/perf/tests/unit_number__scnprintf.c b/tools/perf/tests/unit_number__scnprintf.c
index 3721757435da..2ad78a9473d4 100644
--- a/tools/perf/tests/unit_number__scnprintf.c
+++ b/tools/perf/tests/unit_number__scnprintf.c
@@ -7,7 +7,7 @@
 #include "units.h"
 #include "debug.h"
 
-int test__unit_number__scnprint(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__unit_number__scnprint(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct {
 		u64		 n;
@@ -38,3 +38,5 @@ int test__unit_number__scnprint(struct test *t __maybe_unused, int subtest __may
 
 	return TEST_OK;
 }
+
+DEFINE_SUITE("unit_number__scnprintf", unit_number__scnprint);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 4f884aabc7f4..7f1b74bf4f13 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -111,7 +111,8 @@ static bool is_ignored_symbol(const char *name, char type)
 	return false;
 }
 
-int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused,
+					int subtest __maybe_unused)
 {
 	int err = -1;
 	struct rb_node *nd;
@@ -352,3 +353,5 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 	machine__exit(&vmlinux);
 	return err;
 }
+
+DEFINE_SUITE("vmlinux symtab matches kallsyms", vmlinux_matches_kallsyms);
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 9387fa76faa5..16ab733cabce 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -209,19 +209,19 @@ static struct {
 	},
 };
 
-int test__wp_subtest_get_nr(void)
+static int test__wp_subtest_get_nr(void)
 {
 	return (int)ARRAY_SIZE(wp_testcase_table);
 }
 
-const char *test__wp_subtest_get_desc(int i)
+static const char *test__wp_subtest_get_desc(int i)
 {
 	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
 		return NULL;
 	return wp_testcase_table[i].desc;
 }
 
-const char *test__wp_subtest_skip_reason(int i)
+static const char *test__wp_subtest_skip_reason(int i)
 {
 	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
 		return NULL;
@@ -230,7 +230,7 @@ const char *test__wp_subtest_skip_reason(int i)
 	return wp_testcase_table[i].skip_msg();
 }
 
-int test__wp(struct test *test __maybe_unused, int i)
+static int test__wp(struct test *test __maybe_unused, int i)
 {
 	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
 		return TEST_FAIL;
@@ -245,7 +245,7 @@ int test__wp(struct test *test __maybe_unused, int i)
 /* The s390 so far does not have support for
  * instruction breakpoint using the perf_event_open() system call.
  */
-bool test__wp_is_supported(void)
+static bool test__wp_is_supported(void)
 {
 #if defined(__s390x__)
 	return false;
@@ -253,3 +253,15 @@ bool test__wp_is_supported(void)
 	return true;
 #endif
 }
+
+struct test suite__wp = {
+	.desc = "Watchpoint",
+	.func = test__wp,
+	.is_supported = test__wp_is_supported,
+	.subtest = {
+		.skip_if_fail	= false,
+		.get_nr		= test__wp_subtest_get_nr,
+		.get_desc	= test__wp_subtest_get_desc,
+		.skip_reason    = test__wp_subtest_skip_reason,
+	},
+};
-- 
2.33.1.1089.g2158813163f-goog

