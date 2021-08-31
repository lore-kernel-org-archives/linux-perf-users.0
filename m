Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7876C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 14:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BACC16103D
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 14:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbhHaO4I (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:56:08 -0400
Received: from foss.arm.com ([217.140.110.172]:55690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237512AbhHaO4H (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 10:56:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE6C4D6E;
        Tue, 31 Aug 2021 07:55:11 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.42.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 658583F5A1;
        Tue, 31 Aug 2021 07:55:10 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 2/3] perf tools: Fix LLVM test failure when running in verbose mode
Date:   Tue, 31 Aug 2021 15:55:00 +0100
Message-Id: <20210831145501.2135754-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210831145501.2135754-1-james.clark@arm.com>
References: <20210831145501.2135754-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A CI system might want to run all tests in verbose mode so that there is
enough information to diagnose issues. This LLVM test is the only test
that uses "-v" to signify to not skip the test if the preconditions
aren't met (LLVM isn't installed). This means that running the test in
verbose mode without LLVM installed causes a test failure.

For consistency with the other tests, remove this verbose/skip check. An
alternate solution would be to make _all_ tests not skip when run in
verbose mode, but I don't think that would be intuitive.

Also change the search_program() call to search_program_and_warn().
Previously the hint about installing LLVM was only printed by the actual
test because this check was skipped in verbose mode. To maintain the old
behaviour, the precondition check must also print the full warning.

Previous output:

  $ ./perf test llvm
  40: LLVM search and compile                                     :
  40.1: Basic BPF llvm compile                                    : Skip

  $ ./perf test -v llvm
  40: LLVM search and compile                                     :
  40.1: Basic BPF llvm compile                                    :
  --- start ---
  test child forked, pid 2085835
  ERROR:	unable to find clang.
  Hint:	Try to install latest clang/llvm to support BPF. Check your $PATH
  ...
  test child finished with -1
  ---- end ----
  LLVM search and compile subtest 1: FAILED!

New output (non verbose mode is identical, verbose changes from fail to
skip):

  $ ./perf test llvm
  40: LLVM search and compile                                     :
  40.1: Basic BPF llvm compile                                    : Skip

  $ ./perf test -v llvm
  40: LLVM search and compile                                     :
  40.1: Basic BPF llvm compile                                    :
  --- start ---
  test child forked, pid 2087680
  ERROR:	unable to find clang.
  Hint:	Try to install latest clang/llvm to support BPF. Check your $PATH
  ...
  No clang, skip this test
  test child finished with -2
  ---- end ----
  LLVM search and compile subtest 1: Skip

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/llvm.c      | 7 +++----
 tools/perf/util/llvm-utils.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index 98da8a8757ab..33e43cce9064 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -67,12 +67,11 @@ test_llvm__fetch_bpf_obj(void **p_obj_buf,
 
 	/*
 	 * Skip this test if user's .perfconfig doesn't set [llvm] section
-	 * and clang is not found in $PATH, and this is not perf test -v
+	 * and clang is not found in $PATH
 	 */
-	if (!force && (verbose <= 0 &&
-		       !llvm_param.user_set_param &&
+	if (!force && (!llvm_param.user_set_param &&
 		       llvm__search_clang())) {
-		pr_debug("No clang and no verbosive, skip this test\n");
+		pr_debug("No clang, skip this test\n");
 		return TEST_SKIP;
 	}
 
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index cec9c16efb17..d95c56d175bc 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -585,5 +585,5 @@ int llvm__search_clang(void)
 {
 	char clang_path[PATH_MAX];
 
-	return search_program(llvm_param.clang_path, "clang", clang_path);
+	return search_program_and_warn(llvm_param.clang_path, "clang", clang_path);
 }
-- 
2.28.0

