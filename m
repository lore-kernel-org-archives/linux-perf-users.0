From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/14] perf test shell: Prevent temporary editor files from being considered test scripts
Date: Wed, 11 Jul 2018 16:43:01 -0400
Message-ID: <20180711204305.12924-11-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Allows a perf shell test developer to concurrently edit and run their
test scripts, avoiding perf test attempts to execute their editor
temporary files, such as seen here:

 $ sudo taskset -c 0 ./perf test -vvvvvvvv -F 63
 63: 0VIM 8.0                                              :
 --- start ---
 sh: 1: ./tests/shell/.record+probe_libc_inet_pton.sh.swp: Permission denied
 ---- end ----
 0VIM 8.0: FAILED!

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180629124658.15a506b41fc4539c08eb9426@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2bde505e2e7e..dd850a26d579 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -422,7 +422,7 @@ static const char *shell_test__description(char *description, size_t size,
 
 #define for_each_shell_test(dir, base, ent)	\
 	while ((ent = readdir(dir)) != NULL)	\
-		if (!is_directory(base, ent))
+		if (!is_directory(base, ent) && ent->d_name[0] != '.')
 
 static const char *shell_tests__dir(char *path, size_t size)
 {
-- 
2.14.4
