From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/44] perf tests: Fix memory leak by expr__find_other() in test__expr()
Date: Thu, 21 Mar 2019 15:51:22 -0300
Message-ID: <20190321185142.11441-25-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

  =================================================================
  ==7506==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 13 byte(s) in 3 object(s) allocated from:
      #0 0x7f03339d6070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
      #1 0x5625e53aaef0 in expr__find_other util/expr.y:221
      #2 0x5625e51bcd3f in test__expr tests/expr.c:52
      #3 0x5625e51528e6 in run_test tests/builtin-test.c:358
      #4 0x5625e5152baf in test_and_print tests/builtin-test.c:388
      #5 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
      #6 0x5625e515572f in cmd_test tests/builtin-test.c:722
      #7 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #8 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #9 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #10 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
      #11 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 075167363f8b ("perf tools: Add a simple expression parser for JSON")
Link: http://lkml.kernel.org/r/20190316080556.3075-16-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/expr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 01f0706995a9..9acc1e80b936 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -19,7 +19,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	const char *p;
 	const char **other;
 	double val;
-	int ret;
+	int i, ret;
 	struct parse_ctx ctx;
 	int num_other;
 
@@ -56,6 +56,9 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find other", !strcmp(other[1], "BAZ"));
 	TEST_ASSERT_VAL("find other", !strcmp(other[2], "BOZO"));
 	TEST_ASSERT_VAL("find other", other[3] == NULL);
+
+	for (i = 0; i < num_other; i++)
+		free((void *)other[i]);
 	free((void *)other);
 
 	return 0;
-- 
2.20.1
