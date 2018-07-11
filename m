From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/14] perf tools: Fix compilation errors on gcc8
Date: Wed, 11 Jul 2018 16:43:02 -0400
Message-ID: <20180711204305.12924-12-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We are getting following warnings on gcc8 that break compilation:

  $ make
    CC       jvmti/jvmti_agent.o
  jvmti/jvmti_agent.c: In function ‘jvmti_open’:
  jvmti/jvmti_agent.c:252:35: error: ‘/jit-’ directive output may be truncated \
    writing 5 bytes into a region of size between 1 and 4096 [-Werror=format-truncation=]
    snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());

There's no point in checking the result of snprintf call in
jvmti_open, the following open call will fail in case the
name is mangled or too long.

Using tools/lib/ function scnprintf that touches the return value from
the snprintf() calls and thus get rid of those warnings.

  $ make DEBUG=1
    CC       arch/x86/util/perf_regs.o
  arch/x86/util/perf_regs.c: In function ‘arch_sdt_arg_parse_op’:
  arch/x86/util/perf_regs.c:229:4: error: ‘strncpy’ output truncated before terminating nul
  copying 2 bytes from a string of the same length [-Werror=stringop-truncation]
    strncpy(prefix, "+0", 2);
    ^~~~~~~~~~~~~~~~~~~~~~~~

Using scnprintf instead of the strncpy (which we know is safe in here)
to get rid of that warning.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180702134202.17745-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/perf_regs.c | 2 +-
 tools/perf/jvmti/jvmti_agent.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 4b2caf6d48e7..fead6b3b4206 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -226,7 +226,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 		else if (rm[2].rm_so != rm[2].rm_eo)
 			prefix[0] = '+';
 		else
-			strncpy(prefix, "+0", 2);
+			scnprintf(prefix, sizeof(prefix), "+0");
 	}
 
 	/* Rename register */
diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 0c6d1002b524..ac1bcdc17dae 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -35,6 +35,7 @@
 #include <sys/mman.h>
 #include <syscall.h> /* for gettid() */
 #include <err.h>
+#include <linux/kernel.h>
 
 #include "jvmti_agent.h"
 #include "../util/jitdump.h"
@@ -249,7 +250,7 @@ void *jvmti_open(void)
 	/*
 	 * jitdump file name
 	 */
-	snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
+	scnprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
 
 	fd = open(dump_path, O_CREAT|O_TRUNC|O_RDWR, 0666);
 	if (fd == -1)
-- 
2.14.4
