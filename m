Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437D9C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2671760EB4
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhKDGpP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhKDGpF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75FC06127A
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so7504154ybt.15
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ijD9L9vs+Oj1snjB/N/3EEWAc+DxXGuINxr01nPKums=;
        b=bDG1Os3VwkYMS9dWrrV4Pjf/oOib/QzZJji2MLXiZJQFi4bk/pfsh0udKXet4/s0I1
         vMrZpTwAw6GsNC+3xPAqwCoNPRsqqb4vVXyxIMlrENbtdZNwnbzGNFVTN3t9qRXPPdjm
         svwbYRzsBbLB+JnhugJbDAHJ2bF3AvJtTVOD0D6GOuNEW1nypW5JyjopQuxY0/KVEFk1
         s4fDCJXuyX+xGPtNj056N9NoUYO6KaVnAJqprfeJ7MwSmwnxj7zIElss75vnMB5QozYg
         oCDP+DeOx3/zEx0FRdQhcjHWnNTGXo+ZAqz+iIDPFmWew8jOWe/Y5LoD/3y5O4uqOPpF
         lAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ijD9L9vs+Oj1snjB/N/3EEWAc+DxXGuINxr01nPKums=;
        b=bXkHmmqHUUx6gKvQltJX72RFAwEajdV3b0M2Xu/cGZLxSPMgsRYrj1TqOEznOkHVf2
         5wpOVg2Q8UoJUDK0JhfigZLBPdqZ3XsBeOze8NM2wmA1vTAx4UJ/sAePa7PcGg6HDimN
         C+3RgGoPSc5isqnxOMy+gNNCg8ltcuZ2Z1KXW0yriH64np3wnV5LHwT/DITrnJCHN/qp
         uK3MRMBb6X2DjApumJyUTQIux76b5I2NSf8XnLyk1TZ//uVnZ4z6oADqfOOqe52A+W5P
         F7FHvC+wi7U6q8sY+I8RBKZUCb4yH8GG5IGB8WdvaHfPVqmrbSrNqhYtLppsBT/ICx9X
         2qnQ==
X-Gm-Message-State: AOAM5338Qr/8tsNvOxUFSv0DwxxBEhwd+601KnCZ6Q1bRVQQvcwlsQ+F
        o9GL0Y7cwt8xFCZdO14mv3VoxdEPTJGp
X-Google-Smtp-Source: ABdhPJwKtkOwhTVDg1b7hjEl/3Hej+FQIdSJsIRwuIIzucw/gpSZgF3BdbvDfMhbq6rjm2ArD46um3K8yPGd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:2649:: with SMTP id
 m70mr46581809ybm.21.1636008146929; Wed, 03 Nov 2021 23:42:26 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:51 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-6-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 05/22] perf test: Rename struct test to test_suite
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

This is to align with kunit's terminology.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/include/arch-tests.h      |  2 +-
 tools/perf/arch/arm/tests/arch-tests.c        |  2 +-
 tools/perf/arch/arm/tests/vectors-page.c      |  2 +-
 tools/perf/arch/arm64/include/arch-tests.h    |  2 +-
 tools/perf/arch/arm64/tests/arch-tests.c      |  2 +-
 tools/perf/arch/powerpc/include/arch-tests.h  |  2 +-
 tools/perf/arch/powerpc/tests/arch-tests.c    |  3 ++-
 tools/perf/arch/x86/include/arch-tests.h      | 14 ++++++-------
 tools/perf/arch/x86/tests/arch-tests.c        |  2 +-
 tools/perf/arch/x86/tests/bp-modify.c         |  2 +-
 tools/perf/arch/x86/tests/insn-x86.c          |  2 +-
 tools/perf/arch/x86/tests/intel-cqm.c         |  2 +-
 .../x86/tests/intel-pt-pkt-decoder-test.c     |  2 +-
 tools/perf/arch/x86/tests/rdpmc.c             |  2 +-
 tools/perf/arch/x86/tests/sample-parsing.c    |  2 +-
 tools/perf/tests/api-io.c                     |  2 +-
 tools/perf/tests/attr.c                       |  2 +-
 tools/perf/tests/backward-ring-buffer.c       |  2 +-
 tools/perf/tests/bitmap.c                     |  2 +-
 tools/perf/tests/bp_account.c                 |  4 ++--
 tools/perf/tests/bp_signal.c                  |  4 ++--
 tools/perf/tests/bp_signal_overflow.c         |  4 ++--
 tools/perf/tests/bpf.c                        |  6 +++---
 tools/perf/tests/builtin-test.c               | 20 +++++++++----------
 tools/perf/tests/clang.c                      |  6 +++---
 tools/perf/tests/code-reading.c               |  2 +-
 tools/perf/tests/cpumap.c                     |  6 +++---
 tools/perf/tests/demangle-java-test.c         |  2 +-
 tools/perf/tests/demangle-ocaml-test.c        |  2 +-
 tools/perf/tests/dlfilter-test.c              |  2 +-
 tools/perf/tests/dso-data.c                   |  6 +++---
 tools/perf/tests/dwarf-unwind.c               |  3 ++-
 tools/perf/tests/event-times.c                |  2 +-
 tools/perf/tests/event_update.c               |  2 +-
 tools/perf/tests/evsel-roundtrip-name.c       |  2 +-
 tools/perf/tests/evsel-tp-sched.c             |  2 +-
 tools/perf/tests/expand-cgroup.c              |  2 +-
 tools/perf/tests/expr.c                       |  2 +-
 tools/perf/tests/fdarray.c                    |  4 ++--
 tools/perf/tests/genelf.c                     |  2 +-
 tools/perf/tests/hists_cumulate.c             |  2 +-
 tools/perf/tests/hists_filter.c               |  2 +-
 tools/perf/tests/hists_link.c                 |  2 +-
 tools/perf/tests/hists_output.c               |  2 +-
 tools/perf/tests/is_printable_array.c         |  2 +-
 tools/perf/tests/keep-tracking.c              |  2 +-
 tools/perf/tests/kmod-path.c                  |  2 +-
 tools/perf/tests/llvm.c                       |  6 +++---
 tools/perf/tests/maps.c                       |  2 +-
 tools/perf/tests/mem.c                        |  2 +-
 tools/perf/tests/mem2node.c                   |  2 +-
 tools/perf/tests/mmap-basic.c                 |  2 +-
 tools/perf/tests/mmap-thread-lookup.c         |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |  2 +-
 tools/perf/tests/openat-syscall.c             |  2 +-
 tools/perf/tests/parse-events.c               |  2 +-
 tools/perf/tests/parse-metric.c               |  2 +-
 tools/perf/tests/parse-no-sample-id-all.c     |  2 +-
 tools/perf/tests/pe-file-parsing.c            |  4 ++--
 tools/perf/tests/perf-hooks.c                 |  2 +-
 tools/perf/tests/perf-record.c                |  2 +-
 tools/perf/tests/perf-time-to-tsc.c           |  4 ++--
 tools/perf/tests/pfm.c                        |  4 ++--
 tools/perf/tests/pmu-events.c                 |  4 ++--
 tools/perf/tests/pmu.c                        |  2 +-
 tools/perf/tests/python-use.c                 |  2 +-
 tools/perf/tests/sample-parsing.c             |  2 +-
 tools/perf/tests/sdt.c                        |  4 ++--
 tools/perf/tests/stat.c                       |  6 +++---
 tools/perf/tests/sw-clock.c                   |  2 +-
 tools/perf/tests/switch-tracking.c            |  2 +-
 tools/perf/tests/task-exit.c                  |  2 +-
 tools/perf/tests/tests.h                      |  8 ++++----
 tools/perf/tests/thread-map.c                 |  6 +++---
 tools/perf/tests/thread-maps-share.c          |  2 +-
 tools/perf/tests/time-utils-test.c            |  2 +-
 tools/perf/tests/topology.c                   |  2 +-
 tools/perf/tests/unit_number__scnprintf.c     |  2 +-
 tools/perf/tests/vmlinux-kallsyms.c           |  2 +-
 tools/perf/tests/wp.c                         |  4 ++--
 81 files changed, 125 insertions(+), 123 deletions(-)

diff --git a/tools/perf/arch/arm/include/arch-tests.h b/tools/perf/arch/arm/include/arch-tests.h
index 37039e80f18b..452b3d904521 100644
--- a/tools/perf/arch/arm/include/arch-tests.h
+++ b/tools/perf/arch/arm/include/arch-tests.h
@@ -2,6 +2,6 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-extern struct test *arch_tests[];
+extern struct test_suite *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
index 0ae591f6c372..2e8c90f34325 100644
--- a/tools/perf/arch/arm/tests/arch-tests.c
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -5,7 +5,7 @@
 
 DEFINE_SUITE("Vectors page", vectors_page);
 
-struct test *arch_tests[] = {
+struct test_suite *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	&suite__dwarf_unwind,
 #endif
diff --git a/tools/perf/arch/arm/tests/vectors-page.c b/tools/perf/arch/arm/tests/vectors-page.c
index 7ffdd79971c8..f339835558ca 100644
--- a/tools/perf/arch/arm/tests/vectors-page.c
+++ b/tools/perf/arch/arm/tests/vectors-page.c
@@ -9,7 +9,7 @@
 
 #define VECTORS__MAP_NAME "[vectors]"
 
-int test__vectors_page(struct test *test __maybe_unused,
+int test__vectors_page(struct test_suite *test __maybe_unused,
 		       int subtest __maybe_unused)
 {
 	void *start, *end;
diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index 37039e80f18b..452b3d904521 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -2,6 +2,6 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-extern struct test *arch_tests[];
+extern struct test_suite *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index 6d137138a2de..ad16b4f8f63e 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -3,7 +3,7 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-struct test *arch_tests[] = {
+struct test_suite *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	&suite__dwarf_unwind,
 #endif
diff --git a/tools/perf/arch/powerpc/include/arch-tests.h b/tools/perf/arch/powerpc/include/arch-tests.h
index 37039e80f18b..452b3d904521 100644
--- a/tools/perf/arch/powerpc/include/arch-tests.h
+++ b/tools/perf/arch/powerpc/include/arch-tests.h
@@ -2,6 +2,6 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-extern struct test *arch_tests[];
+extern struct test_suite *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/powerpc/tests/arch-tests.c b/tools/perf/arch/powerpc/tests/arch-tests.c
index 6d137138a2de..eb98c57b5aeb 100644
--- a/tools/perf/arch/powerpc/tests/arch-tests.c
+++ b/tools/perf/arch/powerpc/tests/arch-tests.c
@@ -3,7 +3,8 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-struct test *arch_tests[] = {
+
+struct test_suite *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	&suite__dwarf_unwind,
 #endif
diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index d6db9f72b6af..6a1a1b3c0827 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -2,15 +2,15 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-struct test;
+struct test_suite;
 
 /* Tests */
-int test__rdpmc(struct test *test, int subtest);
-int test__insn_x86(struct test *test, int subtest);
-int test__intel_pt_pkt_decoder(struct test *test, int subtest);
-int test__bp_modify(struct test *test, int subtest);
-int test__x86_sample_parsing(struct test *test, int subtest);
+int test__rdpmc(struct test_suite *test, int subtest);
+int test__insn_x86(struct test_suite *test, int subtest);
+int test__intel_pt_pkt_decoder(struct test_suite *test, int subtest);
+int test__bp_modify(struct test_suite *test, int subtest);
+int test__x86_sample_parsing(struct test_suite *test, int subtest);
 
-extern struct test *arch_tests[];
+extern struct test_suite *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index 20b1c0d8ca66..64fb73d14d2f 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -13,7 +13,7 @@ DEFINE_SUITE("x86 bp modify", bp_modify);
 #endif
 DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
 
-struct test *arch_tests[] = {
+struct test_suite *arch_tests[] = {
 	&suite__rdpmc,
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	&suite__dwarf_unwind,
diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
index dffcf9b52153..0924ccd9e36d 100644
--- a/tools/perf/arch/x86/tests/bp-modify.c
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -204,7 +204,7 @@ static int bp_modify2(void)
 	return rip == (unsigned long) bp_1 ? TEST_OK : TEST_FAIL;
 }
 
-int test__bp_modify(struct test *test __maybe_unused,
+int test__bp_modify(struct test_suite *test __maybe_unused,
 		    int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("modify test 1 failed\n", !bp_modify1());
diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index 0262b0d8ccf5..94b490c434d0 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -173,7 +173,7 @@ static int test_data_set(struct test_data *dat_set, int x86_64)
  * verbose (-v) option to see all the instructions and whether or not they
  * decoded successfully.
  */
-int test__insn_x86(struct test *test __maybe_unused, int subtest __maybe_unused)
+int test__insn_x86(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret = 0;
 
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 27dd8cf9e060..cb5b2c6c3b3b 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -37,7 +37,7 @@ static pid_t spawn(void)
  * the last read counter value to avoid triggering a WARN_ON_ONCE() in
  * smp_call_function_many() caused by sending IPIs from NMI context.
  */
-int test__intel_cqm_count_nmi_context(struct test *test __maybe_unused, int subtest __maybe_unused)
+int test__intel_cqm_count_nmi_context(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct evlist *evlist = NULL;
 	struct evsel *evsel = NULL;
diff --git a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
index c933e3dcd0a8..2fc882ab24c1 100644
--- a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
+++ b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
@@ -289,7 +289,7 @@ static int test_one(struct test_data *d)
  * This test feeds byte sequences to the Intel PT packet decoder and checks the
  * results. Changes to the packet context are also checked.
  */
-int test__intel_pt_pkt_decoder(struct test *test __maybe_unused, int subtest __maybe_unused)
+int test__intel_pt_pkt_decoder(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct test_data *d = data;
 	int ret;
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index 1ea916656a2d..498413ad9c97 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -157,7 +157,7 @@ static int __test__rdpmc(void)
 	return 0;
 }
 
-int test__rdpmc(struct test *test __maybe_unused, int subtest __maybe_unused)
+int test__rdpmc(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int status = 0;
 	int wret = 0;
diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
index c92db87e4479..bfbd3662b69e 100644
--- a/tools/perf/arch/x86/tests/sample-parsing.c
+++ b/tools/perf/arch/x86/tests/sample-parsing.c
@@ -115,7 +115,7 @@ static int do_test(u64 sample_type)
  * For now, the PERF_SAMPLE_WEIGHT_STRUCT is the only X86 specific sample type.
  * The test only checks the PERF_SAMPLE_WEIGHT_STRUCT type.
  */
-int test__x86_sample_parsing(struct test *test __maybe_unused, int subtest __maybe_unused)
+int test__x86_sample_parsing(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	return do_test(PERF_SAMPLE_WEIGHT_STRUCT);
 }
diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
index af4913967514..e91cf2c127f1 100644
--- a/tools/perf/tests/api-io.c
+++ b/tools/perf/tests/api-io.c
@@ -289,7 +289,7 @@ static int test_get_dec(void)
 	return ret;
 }
 
-static int test__api_io(struct test *test __maybe_unused,
+static int test__api_io(struct test_suite *test __maybe_unused,
 			int subtest __maybe_unused)
 {
 	int ret = 0;
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index f1461051f579..0f73e300f207 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -178,7 +178,7 @@ static int run_dir(const char *d, const char *perf)
 	return system(cmd) ? TEST_FAIL : TEST_OK;
 }
 
-static int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__attr(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct stat st;
 	char path_perf[PATH_MAX];
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 180e16917658..79e51a260b15 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -82,7 +82,7 @@ static int do_test(struct evlist *evlist, int mmap_pages,
 }
 
 
-static int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__backward_ring_buffer(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret = TEST_SKIP, err, sample_count = 0, comm_count = 0;
 	char pid[16], sbuf[STRERR_BUFSIZE];
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 13d1d1d6774f..384856347236 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -40,7 +40,7 @@ static int test_bitmap(const char *str)
 	return ret;
 }
 
-static int test__bitmap_print(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__bitmap_print(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1"));
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1,5"));
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 76cf356ba13f..365120146d17 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -173,7 +173,7 @@ static int detect_share(int wp_cnt, int bp_cnt)
  *     we create another watchpoint to ensure
  *     the slot accounting is correct
  */
-static int test__bp_accounting(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__bp_accounting(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int has_ioctl = detect_ioctl();
 	int wp_cnt = detect_cnt(false);
@@ -205,7 +205,7 @@ static bool test__bp_account_is_supported(void)
 #endif
 }
 
-struct test suite__bp_accounting = {
+struct test_suite suite__bp_accounting = {
 	.desc = "Breakpoint accounting",
 	.func = test__bp_accounting,
 	.is_supported = test__bp_account_is_supported,
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index c19b05488cfb..3c269f81818a 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -161,7 +161,7 @@ static long long bp_count(int fd)
 	return count;
 }
 
-static int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__bp_signal(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct sigaction sa;
 	long long count1, count2, count3;
@@ -312,7 +312,7 @@ bool test__bp_signal_is_supported(void)
 #endif
 }
 
-struct test suite__bp_signal = {
+struct test_suite suite__bp_signal = {
 	.desc = "Breakpoint overflow signal handler",
 	.func = test__bp_signal,
 	.is_supported = test__bp_signal_is_supported,
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index 99c30d028f5e..5ac6e1393cf4 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -59,7 +59,7 @@ static long long bp_count(int fd)
 #define EXECUTIONS 10000
 #define THRESHOLD  100
 
-static int test__bp_signal_overflow(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__bp_signal_overflow(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_event_attr pe;
 	struct sigaction sa;
@@ -134,7 +134,7 @@ static int test__bp_signal_overflow(struct test *test __maybe_unused, int subtes
 	return fails ? TEST_FAIL : TEST_OK;
 }
 
-struct test suite__bp_signal_overflow = {
+struct test_suite suite__bp_signal_overflow = {
 	.desc = "Breakpoint overflow sampling",
 	.func = test__bp_signal_overflow,
 	.is_supported = test__bp_signal_is_supported,
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 74496a0fc973..274fdd5318a5 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -324,7 +324,7 @@ static int check_env(void)
 	return 0;
 }
 
-static int test__bpf(struct test *test __maybe_unused, int i)
+static int test__bpf(struct test_suite *test __maybe_unused, int i)
 {
 	int err;
 
@@ -354,14 +354,14 @@ static const char *test__bpf_subtest_get_desc(int i __maybe_unused)
 	return NULL;
 }
 
-static int test__bpf(struct test *test __maybe_unused, int i __maybe_unused)
+static int test__bpf(struct test_suite *test __maybe_unused, int i __maybe_unused)
 {
 	pr_debug("Skip BPF test because BPF support is not compiled\n");
 	return TEST_SKIP;
 }
 #endif
 
-struct test suite__bpf = {
+struct test_suite suite__bpf = {
 	.desc = "BPF filter",
 	.func = test__bpf,
 	.subtest = {
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 07467ec43100..7d52e2eb8147 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -30,11 +30,11 @@
 
 static bool dont_fork;
 
-struct test *__weak arch_tests[] = {
+struct test_suite *__weak arch_tests[] = {
 	NULL,
 };
 
-static struct test *generic_tests[] = {
+static struct test_suite *generic_tests[] = {
 	&suite__vmlinux_matches_kallsyms,
 	&suite__openat_syscall_event,
 	&suite__openat_syscall_event_on_all_cpus,
@@ -110,7 +110,7 @@ static struct test *generic_tests[] = {
 	NULL,
 };
 
-static struct test **tests[] = {
+static struct test_suite **tests[] = {
 	generic_tests,
 	arch_tests,
 };
@@ -139,7 +139,7 @@ static bool perf_test__matches(const char *desc, int curr, int argc, const char
 	return false;
 }
 
-static int run_test(struct test *test, int subtest)
+static int run_test(struct test_suite *test, int subtest)
 {
 	int status, err = -1, child = dont_fork ? 0 : fork();
 	char sbuf[STRERR_BUFSIZE];
@@ -195,7 +195,7 @@ static int run_test(struct test *test, int subtest)
 	for (j = 0; j < ARRAY_SIZE(tests); j++)	\
 		for (k = 0, t = tests[j][k]; tests[j][k]; k++, t = tests[j][k])
 
-static int test_and_print(struct test *t, bool force_skip, int subtest)
+static int test_and_print(struct test_suite *t, bool force_skip, int subtest)
 {
 	int err;
 
@@ -321,7 +321,7 @@ struct shell_test {
 	const char *file;
 };
 
-static int shell_test__run(struct test *test, int subdir __maybe_unused)
+static int shell_test__run(struct test_suite *test, int subdir __maybe_unused)
 {
 	int err;
 	char script[PATH_MAX];
@@ -363,7 +363,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 	for_each_shell_test(entlist, n_dirs, st.dir, ent) {
 		int curr = i++;
 		char desc[256];
-		struct test test = {
+		struct test_suite test = {
 			.desc = shell_test__description(desc, sizeof(desc), st.dir, ent->d_name),
 			.func = shell_test__run,
 			.priv = &st,
@@ -391,7 +391,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
-	struct test *t;
+	struct test_suite *t;
 	unsigned int j, k;
 	int i = 0;
 	int width = shell_tests__max_desc_width();
@@ -500,7 +500,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 	for_each_shell_test(entlist, n_dirs, path, ent) {
 		int curr = i++;
 		char bf[256];
-		struct test t = {
+		struct test_suite t = {
 			.desc = shell_test__description(bf, sizeof(bf), path, ent->d_name),
 		};
 
@@ -520,7 +520,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 static int perf_test__list(int argc, const char **argv)
 {
 	unsigned int j, k;
-	struct test *t;
+	struct test_suite *t;
 	int i = 0;
 
 	for_each_test(j, k, t) {
diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
index 5052be1b5b20..a499fcf37bf9 100644
--- a/tools/perf/tests/clang.c
+++ b/tools/perf/tests/clang.c
@@ -32,12 +32,12 @@ static const char *test__clang_subtest_get_desc(int i)
 }
 
 #ifndef HAVE_LIBCLANGLLVM_SUPPORT
-static int test__clang(struct test *test __maybe_unused, int i __maybe_unused)
+static int test__clang(struct test_suite *test __maybe_unused, int i __maybe_unused)
 {
 	return TEST_SKIP;
 }
 #else
-static int test__clang(struct test *test __maybe_unused, int i)
+static int test__clang(struct test_suite *test __maybe_unused, int i)
 {
 	if (i < 0 || i >= (int)ARRAY_SIZE(clang_testcase_table))
 		return TEST_FAIL;
@@ -45,7 +45,7 @@ static int test__clang(struct test *test __maybe_unused, int i)
 }
 #endif
 
-struct test suite__clang = {
+struct test_suite suite__clang = {
 	.desc = "builtin clang support",
 	.func = test__clang,
 	.subtest = {
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index e4199cb4d4bf..5610767b407f 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -716,7 +716,7 @@ static int do_test_code_reading(bool try_kcore)
 	return err;
 }
 
-static int test__code_reading(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__code_reading(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret;
 
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 6f2525fb9fd7..89a155092f85 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -75,7 +75,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 }
 
 
-static int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__cpu_map_synthesize(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_cpu_map *cpus;
 
@@ -111,7 +111,7 @@ static int cpu_map_print(const char *str)
 	return !strcmp(buf, str);
 }
 
-static int test__cpu_map_print(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__cpu_map_print(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1"));
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,5"));
@@ -123,7 +123,7 @@ static int test__cpu_map_print(struct test *test __maybe_unused, int subtest __m
 	return 0;
 }
 
-static int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
 	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
diff --git a/tools/perf/tests/demangle-java-test.c b/tools/perf/tests/demangle-java-test.c
index 37f488e5c36d..44d1be303b67 100644
--- a/tools/perf/tests/demangle-java-test.c
+++ b/tools/perf/tests/demangle-java-test.c
@@ -7,7 +7,7 @@
 #include "debug.h"
 #include "demangle-java.h"
 
-static int test__demangle_java(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__demangle_java(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret = TEST_OK;
 	char *buf = NULL;
diff --git a/tools/perf/tests/demangle-ocaml-test.c b/tools/perf/tests/demangle-ocaml-test.c
index ee982cca7bbf..90a4285e2ad5 100644
--- a/tools/perf/tests/demangle-ocaml-test.c
+++ b/tools/perf/tests/demangle-ocaml-test.c
@@ -7,7 +7,7 @@
 #include "debug.h"
 #include "demangle-ocaml.h"
 
-static int test__demangle_ocaml(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__demangle_ocaml(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret = TEST_OK;
 	char *buf = NULL;
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 378f5afc6032..84352d55347d 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -398,7 +398,7 @@ static void test_data__free(struct test_data *td)
 	}
 }
 
-static int test__dlfilter(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__dlfilter(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct test_data td = {.fd = -1};
 	int pid = getpid();
diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index d9e060a7c1f6..3419a4ab5590 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -113,7 +113,7 @@ static int dso__data_fd(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
-static int test__dso_data(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machine machine;
 	struct dso *dso;
@@ -248,7 +248,7 @@ static int set_fd_limit(int n)
 	return setrlimit(RLIMIT_NOFILE, &rlim);
 }
 
-static int test__dso_data_cache(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machine machine;
 	long nr_end, nr = open_files_cnt();
@@ -318,7 +318,7 @@ static long new_limit(int count)
 	return ret;
 }
 
-static int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machine machine;
 	long nr_end, nr = open_files_cnt(), lim = new_limit(3);
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 6e0429012ed6..2dab2d262060 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -195,7 +195,8 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *th
 	return ret;
 }
 
-static int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__dwarf_unwind(struct test_suite *test __maybe_unused,
+			      int subtest __maybe_unused)
 {
 	struct machine *machine;
 	struct thread *thread;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 2ce8945931e7..7606eb3df92f 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -216,7 +216,7 @@ static int test_times(int (attach)(struct evlist *),
  * and checks that enabled and running times
  * match.
  */
-static int test__event_times(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__event_times(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err, ret = 0;
 
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 9dfb665f8ac9..fbb68deba59f 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -83,7 +83,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__event_update(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct evsel *evsel;
 	struct event_name tmp;
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 82ff3c04d0bd..fdbf17642e45 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -99,7 +99,7 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names,
 #define perf_evsel__name_array_test(names, distance) \
 	__perf_evsel__name_array_test(names, ARRAY_SIZE(names), distance)
 
-static int test__perf_evsel__roundtrip_name_test(struct test *test __maybe_unused,
+static int test__perf_evsel__roundtrip_name_test(struct test_suite *test __maybe_unused,
 						 int subtest __maybe_unused)
 {
 	int err = 0, ret = 0;
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 58f17d18e4d5..cf4da3d748c2 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -32,7 +32,7 @@ static int evsel__test_field(struct evsel *evsel, const char *name, int size, bo
 	return ret;
 }
 
-static int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused,
+static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unused,
 					   int subtest __maybe_unused)
 {
 	struct evsel *evsel = evsel__newtp("sched", "sched_switch");
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index 17195aea9540..3f157ad3c8fa 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -219,7 +219,7 @@ static int expand_metric_events(void)
 	return ret;
 }
 
-static int test__expand_cgroup_events(struct test *test __maybe_unused,
+static int test__expand_cgroup_events(struct test_suite *test __maybe_unused,
 				      int subtest __maybe_unused)
 {
 	int ret;
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 8c6397d0c381..0c041ac707e6 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -62,7 +62,7 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 	return 0;
 }
 
-static int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct expr_id_data *val_ptr;
 	const char *p;
diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
index 7b2f6c2ad705..40983c3574b1 100644
--- a/tools/perf/tests/fdarray.c
+++ b/tools/perf/tests/fdarray.c
@@ -28,7 +28,7 @@ static int fdarray__fprintf_prefix(struct fdarray *fda, const char *prefix, FILE
 	return printed + fdarray__fprintf(fda, fp);
 }
 
-static int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__fdarray__filter(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int nr_fds, err = TEST_FAIL;
 	struct fdarray *fda = fdarray__new(5, 5);
@@ -89,7 +89,7 @@ static int test__fdarray__filter(struct test *test __maybe_unused, int subtest _
 	return err;
 }
 
-static int test__fdarray__add(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__fdarray__add(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
 	struct fdarray *fda = fdarray__new(2, 2);
diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
index 3c5ced5d9588..95f3be1b683a 100644
--- a/tools/perf/tests/genelf.c
+++ b/tools/perf/tests/genelf.c
@@ -16,7 +16,7 @@
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
 
-static int test__jit_write_elf(struct test *test __maybe_unused,
+static int test__jit_write_elf(struct test_suite *test __maybe_unused,
 			       int subtest __maybe_unused)
 {
 #ifdef HAVE_JITDUMP
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index f7a8d3d78389..17f4fcd6bdce 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -689,7 +689,7 @@ static int test4(struct evsel *evsel, struct machine *machine)
 	return err;
 }
 
-static int test__hists_cumulate(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__hists_cumulate(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
 	struct machines machines;
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 09e140191e5f..08cbeb9e39ae 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -101,7 +101,7 @@ static int add_hist_entries(struct evlist *evlist,
 	return TEST_FAIL;
 }
 
-static int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__hists_filter(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
 	struct machines machines;
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 08571f788884..c575e13a850d 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -264,7 +264,7 @@ static int validate_link(struct hists *leader, struct hists *other)
 	return __validate_link(leader, 0) || __validate_link(other, 1);
 }
 
-static int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__hists_link(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1;
 	struct hists *hists, *first_hists;
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index b427df8ee94a..0bde4a768c15 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -575,7 +575,7 @@ static int test5(struct evsel *evsel, struct machine *machine)
 	return err;
 }
 
-static int test__hists_output(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__hists_output(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
 	struct machines machines;
diff --git a/tools/perf/tests/is_printable_array.c b/tools/perf/tests/is_printable_array.c
index 8891b10fac5c..f72de2457ff1 100644
--- a/tools/perf/tests/is_printable_array.c
+++ b/tools/perf/tests/is_printable_array.c
@@ -5,7 +5,7 @@
 #include "debug.h"
 #include "print_binary.h"
 
-static int test__is_printable_array(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__is_printable_array(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	char buf1[] = { 'k', 'r', 4, 'v', 'a', 0 };
 	char buf2[] = { 'k', 'r', 'a', 'v', 4, 0 };
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index e723c976dc81..dd2067312452 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -61,7 +61,7 @@ static int find_comm(struct evlist *evlist, const char *comm)
  * when an event is disabled but a dummy software event is not disabled.  If the
  * test passes %0 is returned, otherwise %-1 is returned.
  */
-static int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__keep_tracking(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct record_opts opts = {
 		.mmap_pages	     = UINT_MAX,
diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index 4935dd3182ed..dfe1bd5dabaa 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -47,7 +47,7 @@ static int test_is_kernel_module(const char *path, int cpumode, bool expect)
 #define M(path, c, e) \
 	TEST_ASSERT_VAL("failed", !test_is_kernel_module(path, c, e))
 
-static int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__kmod_path__parse(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
 	/* path                alloc_name  kmod  comp   name   */
 	T("/xxxx/xxxx/x-x.ko", true      , true, 0    , "[x_x]");
diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index b605a71ad8d5..057d6a59a8ea 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -124,7 +124,7 @@ test_llvm__fetch_bpf_obj(void **p_obj_buf,
 	return ret;
 }
 
-static int test__llvm(struct test *test __maybe_unused, int subtest)
+static int test__llvm(struct test_suite *test __maybe_unused, int subtest)
 {
 	int ret;
 	void *obj_buf = NULL;
@@ -162,7 +162,7 @@ static const char *test__llvm_subtest_get_desc(int subtest)
 	return bpf_source_table[subtest].desc;
 }
 #else //HAVE_LIBBPF_SUPPORT
-static int test__llvm(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__llvm(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	return TEST_SKIP;
 }
@@ -178,7 +178,7 @@ static const char *test__llvm_subtest_get_desc(int subtest __maybe_unused)
 }
 #endif // HAVE_LIBBPF_SUPPORT
 
-struct test suite__llvm = {
+struct test_suite suite__llvm = {
 	.desc = "LLVM search and compile",
 	.func = test__llvm,
 	.subtest = {
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 4a2e6f312015..e308a3296cef 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -33,7 +33,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 	return TEST_OK;
 }
 
-static int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct maps maps;
 	unsigned int i;
diff --git a/tools/perf/tests/mem.c b/tools/perf/tests/mem.c
index 3af082508653..56014ec7d49d 100644
--- a/tools/perf/tests/mem.c
+++ b/tools/perf/tests/mem.c
@@ -23,7 +23,7 @@ static int check(union perf_mem_data_src data_src,
 	return 0;
 }
 
-static int test__mem(struct test *text __maybe_unused, int subtest __maybe_unused)
+static int test__mem(struct test_suite *text __maybe_unused, int subtest __maybe_unused)
 {
 	int ret = 0;
 	union perf_mem_data_src src;
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 0a90e6084d81..b17b86391383 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -43,7 +43,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	return bm && map ? bm : NULL;
 }
 
-static int test__mem2node(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__mem2node(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct mem2node map;
 	struct memory_node nodes[3];
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 86f34631312d..90b2feda31ac 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -29,7 +29,7 @@
  * Then it checks if the number of syscalls reported as perf events by
  * the kernel corresponds to the number of syscalls made.
  */
-static int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1;
 	union perf_event *event;
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 756a46c796f7..a4301fc7b770 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -224,7 +224,7 @@ static int mmap_events(synth_cb synth)
  *
  * by using all thread objects.
  */
-static int test__mmap_thread_lookup(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__mmap_thread_lookup(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	/* perf_event__synthesize_threads synthesize */
 	TEST_ASSERT_VAL("failed with sythesizing all",
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 28f3597ba531..cd3dd463783f 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -19,7 +19,7 @@
 #include "stat.h"
 #include "util/counts.h"
 
-static int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused,
+static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __maybe_unused,
 						  int subtest __maybe_unused)
 {
 	int err = -1, fd, cpu;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index cbb5c0fa40fe..a7b2800652e4 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -22,7 +22,7 @@
 #define AT_FDCWD       -100
 #endif
 
-static int test__syscall_openat_tp_fields(struct test *test __maybe_unused,
+static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused,
 					  int subtest __maybe_unused)
 {
 	struct record_opts opts = {
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 8f904fcebe6f..7f4c13c4b14d 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -13,7 +13,7 @@
 #include "tests.h"
 #include "util/counts.h"
 
-static int test__openat_syscall_event(struct test *test __maybe_unused,
+static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
 				      int subtest __maybe_unused)
 {
 	int err = -1, fd;
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index b6232aa6975b..3a3d39d7a5f7 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2276,7 +2276,7 @@ static int test_pmu_events_alias(char *event, char *alias)
 	return test_event(&e);
 }
 
-static int test__parse_events(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__parse_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret1, ret2 = 0;
 	char *event, *alias;
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 999d37fc58f2..574b7e4efd3a 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -369,7 +369,7 @@ static int test_metric_group(void)
 	return 0;
 }
 
-static int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__parse_metric(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
 	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf/tests/parse-no-sample-id-all.c
index 2a5eec424a43..d62e31595ab2 100644
--- a/tools/perf/tests/parse-no-sample-id-all.c
+++ b/tools/perf/tests/parse-no-sample-id-all.c
@@ -67,7 +67,7 @@ struct test_attr_event {
  *
  * Return: %0 on success, %-1 if the test fails.
  */
-static int test__parse_no_sample_id_all(struct test *test __maybe_unused,
+static int test__parse_no_sample_id_all(struct test_suite *test __maybe_unused,
 					int subtest __maybe_unused)
 {
 	int err;
diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index 8d4fec99459a..c09a9fae1689 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -68,7 +68,7 @@ static int run_dir(const char *d)
 	return TEST_OK;
 }
 
-static int test__pe_file_parsing(struct test *test __maybe_unused,
+static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
 			  int subtest __maybe_unused)
 {
 	struct stat st;
@@ -89,7 +89,7 @@ static int test__pe_file_parsing(struct test *test __maybe_unused,
 
 #else
 
-static int test__pe_file_parsing(struct test *test __maybe_unused,
+static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
 			  int subtest __maybe_unused)
 {
 	return TEST_SKIP;
diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
index 61cb1d0a6eb9..78cdeb89645e 100644
--- a/tools/perf/tests/perf-hooks.c
+++ b/tools/perf/tests/perf-hooks.c
@@ -26,7 +26,7 @@ static void the_hook(void *_hook_flags)
 	raise(SIGSEGV);
 }
 
-static int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__perf_hooks(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int hook_flags = 0;
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 24faa8487d8c..6354465067b8 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -41,7 +41,7 @@ static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
 	return cpu;
 }
 
-static int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct record_opts opts = {
 		.target = {
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index dc2dcad7371f..d23740f80c7d 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -45,7 +45,7 @@
  * %0 is returned, otherwise %-1 is returned.  If TSC conversion is not
  * supported then then the test passes but " (not supported)" is printed.
  */
-static int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct record_opts opts = {
 		.mmap_pages	     = UINT_MAX,
@@ -198,7 +198,7 @@ static bool test__tsc_is_supported(void)
 #endif
 }
 
-struct test suite__perf_time_to_tsc = {
+struct test_suite suite__perf_time_to_tsc = {
 	.desc = "Convert perf time to TSC",
 	.func = test__perf_time_to_tsc,
 	.is_supported = test__tsc_is_supported,
diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index 83dc9742813a..f55e4ecdda71 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -201,7 +201,7 @@ static int test__pfm_subtest_get_nr(void)
 	return (int)ARRAY_SIZE(pfm_testcase_table);
 }
 
-static int test__pfm(struct test *test __maybe_unused, int i __maybe_unused)
+static int test__pfm(struct test_suite *test __maybe_unused, int i __maybe_unused)
 {
 #ifdef HAVE_LIBPFM
 	if (i < 0 || i >= (int)ARRAY_SIZE(pfm_testcase_table))
@@ -212,7 +212,7 @@ static int test__pfm(struct test *test __maybe_unused, int i __maybe_unused)
 #endif
 }
 
-struct test suite__pfm = {
+struct test_suite suite__pfm = {
 	.desc = "Test libpfm4 support",
 	.func = test__pfm,
 	.subtest = {
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 3fde6109c9d2..669eea831793 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -1115,7 +1115,7 @@ static int test__pmu_events_subtest_get_nr(void)
 	return (int)ARRAY_SIZE(pmu_events_testcase_table);
 }
 
-static int test__pmu_events(struct test *test __maybe_unused, int subtest)
+static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest)
 {
 	if (subtest < 0 ||
 	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
@@ -1123,7 +1123,7 @@ static int test__pmu_events(struct test *test __maybe_unused, int subtest)
 	return pmu_events_testcase_table[subtest].func();
 }
 
-struct test suite__pmu_events = {
+struct test_suite suite__pmu_events = {
 	.desc = "PMU events",
 	.func = test__pmu_events,
 	.subtest = {
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 9a58dad67b27..8507bd615e97 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -137,7 +137,7 @@ static struct list_head *test_terms_list(void)
 	return &terms;
 }
 
-static int test__pmu(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__pmu(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	char *format = test_format_dir_get();
 	LIST_HEAD(formats);
diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index b667140688be..6b990ee38575 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -9,7 +9,7 @@
 #include "tests.h"
 #include "util/debug.h"
 
-static int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__python_use(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	char *cmd;
 	int ret;
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 08453238c777..b669d22f2b13 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -368,7 +368,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
  * checks sample format bits separately and together.  If the test passes %0 is
  * returned, otherwise %-1 is returned.
  */
-static int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__sample_parsing(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	const u64 rf[] = {4, 5, 6, 7, 12, 13, 14, 15};
 	u64 sample_type;
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 307615f1b6a7..919712899251 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -76,7 +76,7 @@ static int search_cached_probe(const char *target,
 	return ret;
 }
 
-static int test__sdt_event(struct test *test __maybe_unused, int subtests __maybe_unused)
+static int test__sdt_event(struct test_suite *test __maybe_unused, int subtests __maybe_unused)
 {
 	int ret = TEST_FAIL;
 	char __tempdir[] = "./test-buildid-XXXXXX";
@@ -114,7 +114,7 @@ static int test__sdt_event(struct test *test __maybe_unused, int subtests __mayb
 	return ret;
 }
 #else
-static int test__sdt_event(struct test *test __maybe_unused, int subtests __maybe_unused)
+static int test__sdt_event(struct test_suite *test __maybe_unused, int subtests __maybe_unused)
 {
 	pr_debug("Skip SDT event test because SDT support is not compiled\n");
 	return TEST_SKIP;
diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
index 2589f2f529ba..2eb096b5e6da 100644
--- a/tools/perf/tests/stat.c
+++ b/tools/perf/tests/stat.c
@@ -47,7 +47,7 @@ static int process_stat_config_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int test__synthesize_stat_config(struct test *test __maybe_unused,
+static int test__synthesize_stat_config(struct test_suite *test __maybe_unused,
 					int subtest __maybe_unused)
 {
 	struct perf_stat_config stat_config = {
@@ -78,7 +78,7 @@ static int process_stat_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int test__synthesize_stat(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__synthesize_stat(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_counts_values count;
 
@@ -104,7 +104,7 @@ static int process_stat_round_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int test__synthesize_stat_round(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__synthesize_stat_round(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("failed to synthesize stat_config",
 		!perf_event__synthesize_stat_round(NULL, 0xdeadbeef, PERF_STAT_ROUND_TYPE__INTERVAL,
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index db1e339a0fbe..9cd6fec375ee 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -133,7 +133,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	return err;
 }
 
-static int test__sw_clock_freq(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__sw_clock_freq(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret;
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 9b379aaddce4..0c0c2328bf4e 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -321,7 +321,7 @@ static int process_events(struct evlist *evlist,
  * evsel->core.system_wide and evsel->tracking flags (respectively) with other events
  * sometimes enabled or disabled.
  */
-static int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__switch_tracking(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	const char *sched_switch = "sched:sched_switch";
 	struct switch_tracking switch_tracking = { .tids = NULL, };
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 197574230493..25f075fa9125 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -39,7 +39,7 @@ static void workload_exec_failed_signal(int signo __maybe_unused,
  * if the number of exit event reported by the kernel is 1 or not
  * in order to check the kernel returns correct number of event.
  */
-static int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__task_exit(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1;
 	union perf_event *event;
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f2efa331b32f..c95b0de9f822 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -27,9 +27,9 @@ enum {
 	TEST_SKIP = -2,
 };
 
-struct test {
+struct test_suite {
 	const char *desc;
-	int (*func)(struct test *test, int subtest);
+	int (*func)(struct test_suite *test, int subtest);
 	struct {
 		bool skip_if_fail;
 		int (*get_nr)(void);
@@ -41,10 +41,10 @@ struct test {
 };
 
 #define DECLARE_SUITE(name) \
-	extern struct test suite__##name;
+	extern struct test_suite suite__##name;
 
 #define DEFINE_SUITE(description, name)		\
-	struct test suite__##name = {		\
+	struct test_suite suite__##name = {		\
 		.desc = description,		\
 		.func = test__##name,		\
 	}
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 7e2e8a72fa78..e413c1387fcb 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -19,7 +19,7 @@ struct machine;
 #define NAME	(const char *) "perf"
 #define NAMEUL	(unsigned long) NAME
 
-static int test__thread_map(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__thread_map(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_thread_map *map;
 
@@ -86,7 +86,7 @@ static int process_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int test__thread_map_synthesize(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__thread_map_synthesize(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_thread_map *threads;
 
@@ -106,7 +106,7 @@ static int test__thread_map_synthesize(struct test *test __maybe_unused, int sub
 	return 0;
 }
 
-static int test__thread_map_remove(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__thread_map_remove(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_thread_map *threads;
 	char *str;
diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
index 2821be0a9a05..84edd82c519e 100644
--- a/tools/perf/tests/thread-maps-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -4,7 +4,7 @@
 #include "thread.h"
 #include "debug.h"
 
-static int test__thread_maps_share(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__thread_maps_share(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machines machines;
 	struct machine *machine;
diff --git a/tools/perf/tests/time-utils-test.c b/tools/perf/tests/time-utils-test.c
index 538100cb7541..38df10373c1e 100644
--- a/tools/perf/tests/time-utils-test.c
+++ b/tools/perf/tests/time-utils-test.c
@@ -131,7 +131,7 @@ static bool test__perf_time__parse_for_ranges(struct test_data *d)
 	return pass;
 }
 
-static int test__time_utils(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__time_utils(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
 	bool pass = true;
 
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 05fda3955f95..f998c10ca124 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -173,7 +173,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	return 0;
 }
 
-static int test__session_topology(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__session_topology(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	char path[PATH_MAX];
 	struct perf_cpu_map *map;
diff --git a/tools/perf/tests/unit_number__scnprintf.c b/tools/perf/tests/unit_number__scnprintf.c
index 2ad78a9473d4..88bcada1c78f 100644
--- a/tools/perf/tests/unit_number__scnprintf.c
+++ b/tools/perf/tests/unit_number__scnprintf.c
@@ -7,7 +7,7 @@
 #include "units.h"
 #include "debug.h"
 
-static int test__unit_number__scnprint(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int test__unit_number__scnprint(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct {
 		u64		 n;
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 7f1b74bf4f13..e80df13c0420 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -111,7 +111,7 @@ static bool is_ignored_symbol(const char *name, char type)
 	return false;
 }
 
-static int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused,
+static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused,
 					int subtest __maybe_unused)
 {
 	int err = -1;
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 16ab733cabce..904bdf2dcf81 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -230,7 +230,7 @@ static const char *test__wp_subtest_skip_reason(int i)
 	return wp_testcase_table[i].skip_msg();
 }
 
-static int test__wp(struct test *test __maybe_unused, int i)
+static int test__wp(struct test_suite *test __maybe_unused, int i)
 {
 	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
 		return TEST_FAIL;
@@ -254,7 +254,7 @@ static bool test__wp_is_supported(void)
 #endif
 }
 
-struct test suite__wp = {
+struct test_suite suite__wp = {
 	.desc = "Watchpoint",
 	.func = test__wp,
 	.is_supported = test__wp_is_supported,
-- 
2.33.1.1089.g2158813163f-goog

