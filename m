From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/57] perf tests bp_account: Add dedicated checking helper is_supported()
Date: Mon, 21 Oct 2019 10:38:18 -0300
Message-ID: <20191021133834.25998-42-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brajeswar Ghosh <brajeswar.linux@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Souptick Joarder <jrdr.linux@gmail.com>, Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The arm architecture supports breakpoint accounting but it doesn't
support breakpoint overflow signal handling.  The current code uses the
same checking helper, thus it disables both testings (bp_account and
bp_signal) for arm platform.

For handling two testings separately, this patch adds a dedicated
checking helper is_supported() for breakpoint accounting testing, thus
it allows supporting breakpoint accounting testing on arm platform; the
old helper test__bp_signal_is_supported() is only used to checking for
breakpoint overflow signal testing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Will Deacon <will@kernel.org>
Link: http://lore.kernel.org/lkml/20191018085531.6348-2-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_account.c   | 16 ++++++++++++++++
 tools/perf/tests/builtin-test.c |  2 +-
 tools/perf/tests/tests.h        |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 52ff7a462670..d0b935356274 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -188,3 +188,19 @@ int test__bp_accounting(struct test *test __maybe_unused, int subtest __maybe_un
 
 	return bp_accounting(wp_cnt, share);
 }
+
+bool test__bp_account_is_supported(void)
+{
+	/*
+	 * PowerPC and S390 do not support creation of instruction
+	 * breakpoints using the perf_event interface.
+	 *
+	 * Just disable the test for these architectures until these
+	 * issues are resolved.
+	 */
+#if defined(__powerpc__) || defined(__s390x__)
+	return false;
+#else
+	return true;
+#endif
+}
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 55774baffc2a..8b286e9b7549 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -121,7 +121,7 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Breakpoint accounting",
 		.func = test__bp_accounting,
-		.is_supported = test__bp_signal_is_supported,
+		.is_supported = test__bp_account_is_supported,
 	},
 	{
 		.desc = "Watchpoint",
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 72912eb473cb..9837b6e93023 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -111,6 +111,7 @@ int test__map_groups__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
+bool test__bp_account_is_supported(void);
 bool test__wp_is_supported(void);
 
 #if defined(__arm__) || defined(__aarch64__)
-- 
2.21.0
