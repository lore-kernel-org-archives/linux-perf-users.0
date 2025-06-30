Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC524679A;
	Mon, 30 Jun 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751326368; cv=none; b=hse6MfQ8lI0JA0UHLK9wsbPTTx9pxzH6weqKqp906a3yjOwpJgeA2nrHKQHaUdhtdBE5MMlwKpVkJZ26XNcne1XDhIbra38wG0TRz/ZF06SmHfxEX7Jn12Nfp2bmdl+E1xjD8AC1SmtRCU13nxVhHEpNmltCawgAluNF0Zlm6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751326368; c=relaxed/simple;
	bh=lgOTBc1LxhNRMQxAdr/9SkXdeqrLxAdshXpFVX/J6M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlifeIT0f8QkR1LzhM4GoFePWVWwXGviR32Xfd5wMzaFk3aYcNVujUY9u2sP+vOqsUYO7dYMXMog8uQ8WT8zLxN8lNqZdF2F20m9Hk9HjKd0PmsQ7WKaB2bMxc5eGR6acJLm3v9nlGM+A8MGJvmgzolND+hMybmuDA/mr6iYmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY0SmJ0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY0SmJ0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99C4C4CEEF;
	Mon, 30 Jun 2025 23:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751326368;
	bh=lgOTBc1LxhNRMQxAdr/9SkXdeqrLxAdshXpFVX/J6M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sY0SmJ0WFkV6pu2A3g4YoOfq7mqtwkXLCz7FSTFINDfxh0ow/Ow4PIvSrwZ0/jteX
	 F3gSAKbQYyFvZcxqs8PJrprFy01XjoCeg9KCZhv2XqrtJ4+LyhgOku91QwruP5G6i/
	 IIvsFMv5hi+z0kbx97EuPhKDlCPquuPpv1rg7uE5ulUjUzj5vYeatXhgDyDNLItF1f
	 SXSILP9HFRV0RGFfAPGVGQrbm5ILfnOZZQ0Xn1SO2KgQ4AgPDfRf3CslMGcgs4V2jP
	 DXcqLgCUu/gXpKANgkfc47nkHmlr7PNC5yJeM0csXfff0VWpJJGCKVBOwMKkqYKhEP
	 HEyCg42sbF+DA==
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
Subject: [PATCH 2/3] perf test: Add libsubcmd help tests
Date: Mon, 30 Jun 2025 16:32:45 -0700
Message-ID: <20250630233246.1063977-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250630233246.1063977-1-namhyung@kernel.org>
References: <20250630233246.1063977-1-namhyung@kernel.org>
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

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/subcmd-help.c  | 109 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 112 insertions(+)
 create mode 100644 tools/perf/tests/subcmd-help.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 2181f5a92148b0b9..13a81154ec1e4cd2 100644
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
index dfaff4185eb05a1a..2da9b69864da53c2 100644
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
index 0000000000000000..d31259340ae302af
--- /dev/null
+++ b/tools/perf/tests/subcmd-help.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tests.h"
+#include <stdio.h>
+#include <subcmd/help.h>
+#include "debug.h"
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
index 4c128a9594413b32..13cabf85185ed2d3 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -177,6 +177,7 @@ DECLARE_SUITE(sigtrap);
 DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
 DECLARE_SUITE(util);
+DECLARE_SUITE(subcmd_help);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.50.0.727.gbf7dc18ff4-goog

