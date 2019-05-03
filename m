From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/11] tools lib traceevent: Change tag string for error
Date: Thu,  2 May 2019 20:25:26 -0400
Message-ID: <20190503002533.29359-5-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The traceevent lib is used by the perf tool, and when executing

  perf test -v 6

it outputs error log on the ARM64 platform:

  running test 33 '*:*'trace-cmd: No such file or directory

  [...]

  trace-cmd: Invalid argument

The trace event parsing code originally came from trace-cmd so it keeps
the tag string "trace-cmd" for errors, this easily introduces the
impression that the perf tool launches trace-cmd command for trace event
parsing, but in fact the related parsing is accomplished by the
traceevent lib.

This patch changes the tag string to "libtraceevent" so that we can
avoid confusion and let users to more easily connect the error with
traceevent lib.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190424013802.27569-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/parse-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-utils.c b/tools/lib/traceevent/parse-utils.c
index 77e4ec6402dd..e99867111387 100644
--- a/tools/lib/traceevent/parse-utils.c
+++ b/tools/lib/traceevent/parse-utils.c
@@ -14,7 +14,7 @@
 void __vwarning(const char *fmt, va_list ap)
 {
 	if (errno)
-		perror("trace-cmd");
+		perror("libtraceevent");
 	errno = 0;
 
 	fprintf(stderr, "  ");
-- 
2.20.1
