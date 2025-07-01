Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F368C283155;
	Tue,  1 Jul 2025 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400629; cv=none; b=f7Z6D0BWLzn6mke4Lq5xuuLDMUJQwBrZYNbr2H5uvok9mZ338CcbUt/kxqyOyuvsjDfCJCzfcjM/PLz6WAWOn1TDwD0CRjzF3n6spj70V8QvXR/UaR6DXl0syPemxCqZa7+HaTcuI8s8YAaMFmvaEGZb9R1lgJUrVYhqcTbKLN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400629; c=relaxed/simple;
	bh=crdtwwFG7ike40P9ep6yqS3lWhWMTdQQJL4K2yvgiO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeEVtyhnqiEX4hFblpgSijJTeXsfdQrb/rbXE165xQA3cxFof5C9EaSHQHHpgV6a3Mcz0BwPnA/Bgv8GRZR1r3qwC9ubAbk+gLL/v7es2ksWJoWpc8s42Y1ptMVdGhI1Dii7lmyTrNwB4b2CSJp/DsL3cEY1HUM6tmXw9syKnBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACKO/7z8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACKO/7z8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD49C4CEEE;
	Tue,  1 Jul 2025 20:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751400628;
	bh=crdtwwFG7ike40P9ep6yqS3lWhWMTdQQJL4K2yvgiO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACKO/7z8SC9A0EQ1gmBaQxJQJAMUPQTu/who84j7rcKBK4H6eZkAuUHHXS+0aSp2w
	 1BzAKCdve+88plXkHMTb1WOGb6G3vLpWL0nh5YJdD5bRp+ygyM4eZ/wVEvQaNd+cTH
	 g0vXUEqv1Q6ITeuLgeu5gG6StH8DMpUQHBA8ANyuScVqOe6qIzeT5xmxclo4H4NlK7
	 a+ykETgn3o0PnvVfclE9ptY4YyIRDYT8GlrYYI+PUNbFxxEK6kL5fMziHhSTwiq7Xn
	 TzEj0fXZO38PRj5cnWkg/KN6h0cO0u+0kC2T3V16M39oE7V/Epiq+EIZMz2Y3vmL6G
	 Ru7ZOciBYjC4w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/3] perf test: Add libsubcmd help tests
Date: Tue,  1 Jul 2025 13:10:26 -0700
Message-ID: <20250701201027.1171561-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250701201027.1171561-1-namhyung@kernel.org>
References: <20250701201027.1171561-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a set of tests for subcmd routines.  Currently it fails the last one
since there's a bug.  It'll be fixed by the next commit.

  $ perf test subcmd
   69: libsubcmd help tests                                            :
   69.1: Load subcmd names                                             : Ok
   69.2: Uniquify subcmd names                                         : Ok
   69.3: Exclude duplicate subcmd names                                : FAILED!

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/subcmd-help.c  | 108 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   2 +
 4 files changed, 112 insertions(+)
 create mode 100644 tools/perf/tests/subcmd-help.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index d6c35dd0de3bd6ce..3e8394be15aea4fb 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -69,6 +69,7 @@ perf-test-y += symbols.o
 perf-test-y += util.o
 perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
+perf-test-y += subcmd-help.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 846c9b3a732c9b3a..e242d56523cee171 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -139,6 +139,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__event_groups,
 	&suite__symbols,
 	&suite__util,
+	&suite__subcmd_help,
 	NULL,
 };
 
diff --git a/tools/perf/tests/subcmd-help.c b/tools/perf/tests/subcmd-help.c
new file mode 100644
index 0000000000000000..2280b4c0e5e7083b
--- /dev/null
+++ b/tools/perf/tests/subcmd-help.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tests.h"
+#include <linux/compiler.h>
+#include <subcmd/help.h>
+
+static int test__load_cmdnames(struct test_suite *test __maybe_unused,
+			       int subtest __maybe_unused)
+{
+	struct cmdnames cmds = {};
+
+	add_cmdname(&cmds, "aaa", 3);
+	add_cmdname(&cmds, "foo", 3);
+	add_cmdname(&cmds, "xyz", 3);
+
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds, "aaa") == 1);
+	TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds, "bar") == 0);
+	TEST_ASSERT_VAL("case sensitive", is_in_cmdlist(&cmds, "XYZ") == 0);
+
+	clean_cmdnames(&cmds);
+	return TEST_OK;
+}
+
+static int test__uniq_cmdnames(struct test_suite *test __maybe_unused,
+			       int subtest __maybe_unused)
+{
+	struct cmdnames cmds = {};
+
+	/* uniq() assumes it's sorted */
+	add_cmdname(&cmds, "aaa", 3);
+	add_cmdname(&cmds, "aaa", 3);
+	add_cmdname(&cmds, "bbb", 3);
+
+	TEST_ASSERT_VAL("invalid original size", cmds.cnt == 3);
+	/* uniquify command names (to remove second 'aaa') */
+	uniq(&cmds);
+	TEST_ASSERT_VAL("invalid final size", cmds.cnt == 2);
+
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds, "aaa") == 1);
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds, "bbb") == 1);
+	TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds, "ccc") == 0);
+
+	clean_cmdnames(&cmds);
+	return TEST_OK;
+}
+
+static int test__exclude_cmdnames(struct test_suite *test __maybe_unused,
+				  int subtest __maybe_unused)
+{
+	struct cmdnames cmds1 = {};
+	struct cmdnames cmds2 = {};
+
+	add_cmdname(&cmds1, "aaa", 3);
+	add_cmdname(&cmds1, "bbb", 3);
+	add_cmdname(&cmds1, "ccc", 3);
+	add_cmdname(&cmds1, "ddd", 3);
+	add_cmdname(&cmds1, "eee", 3);
+	add_cmdname(&cmds1, "fff", 3);
+	add_cmdname(&cmds1, "ggg", 3);
+	add_cmdname(&cmds1, "hhh", 3);
+	add_cmdname(&cmds1, "iii", 3);
+	add_cmdname(&cmds1, "jjj", 3);
+
+	add_cmdname(&cmds2, "bbb", 3);
+	add_cmdname(&cmds2, "eee", 3);
+	add_cmdname(&cmds2, "jjj", 3);
+
+	TEST_ASSERT_VAL("invalid original size", cmds1.cnt == 10);
+	TEST_ASSERT_VAL("invalid original size", cmds2.cnt == 3);
+
+	/* remove duplicate command names in cmds1 */
+	exclude_cmds(&cmds1, &cmds2);
+
+	TEST_ASSERT_VAL("invalid excluded size", cmds1.cnt == 7);
+	TEST_ASSERT_VAL("invalid excluded size", cmds2.cnt == 3);
+
+	/* excluded commands should not belong to cmds1 */
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "aaa") == 1);
+	TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "bbb") == 0);
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "ccc") == 1);
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "ddd") == 1);
+	TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "eee") == 0);
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "fff") == 1);
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "ggg") == 1);
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "hhh") == 1);
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "iii") == 1);
+	TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "jjj") == 0);
+
+	/* they should be only in cmds2 */
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds2, "bbb") == 1);
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds2, "eee") == 1);
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds2, "jjj") == 1);
+
+	clean_cmdnames(&cmds1);
+	clean_cmdnames(&cmds2);
+	return TEST_OK;
+}
+
+static struct test_case tests__subcmd_help[] = {
+	TEST_CASE("Load subcmd names", load_cmdnames),
+	TEST_CASE("Uniquify subcmd names", uniq_cmdnames),
+	TEST_CASE("Exclude duplicate subcmd names", exclude_cmdnames),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__subcmd_help = {
+	.desc = "libsubcmd help tests",
+	.test_cases = tests__subcmd_help,
+};
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 4c128a9594413b32..97e62db8764a0537 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -3,6 +3,7 @@
 #define TESTS_H
 
 #include <stdbool.h>
+#include "util/debug.h"
 
 enum {
 	TEST_OK   =  0,
@@ -177,6 +178,7 @@ DECLARE_SUITE(sigtrap);
 DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
 DECLARE_SUITE(util);
+DECLARE_SUITE(subcmd_help);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.50.0.727.gbf7dc18ff4-goog

