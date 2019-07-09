From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/25] perf script: Assume native_arch for pipe mode
Date: Tue,  9 Jul 2019 15:31:24 -0300
Message-ID: <20190709183126.30257-24-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, David Carrillo Cisneros <davidca@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: Song Liu <songliubraving@fb.com>

In pipe mode, session->header.env.arch is not populated until the events
are processed. Therefore, the following command crashes:

   perf record -o - | perf script

(gdb) bt

It fails when we try to compare env.arch against uts.machine:

        if (!strcmp(uts.machine, session->header.env.arch) ||
            (!strcmp(uts.machine, "x86_64") &&
             !strcmp(session->header.env.arch, "i386")))
                native_arch = true;

In pipe mode, it is tricky to find env.arch at this stage. To keep it
simple, let's just assume native_arch is always true for pipe mode.

Reported-by: David Carrillo Cisneros <davidca@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: kernel-team@fb.com
Cc: stable@vger.kernel.org #v5.1+
Fixes: 3ab481a1cfe1 ("perf script: Support insn output for normal samples")
Link: http://lkml.kernel.org/r/20190621014438.810342-1-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b3536820f9a8..79367087bd18 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3752,7 +3752,8 @@ int cmd_script(int argc, const char **argv)
 		goto out_delete;
 
 	uname(&uts);
-	if (!strcmp(uts.machine, session->header.env.arch) ||
+	if (data.is_pipe ||  /* assume pipe_mode indicates native_arch */
+	    !strcmp(uts.machine, session->header.env.arch) ||
 	    (!strcmp(uts.machine, "x86_64") &&
 	     !strcmp(session->header.env.arch, "i386")))
 		native_arch = true;
-- 
2.21.0
