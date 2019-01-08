From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/16] tools lib traceevent: Changed return logic of trace_seq_printf() and trace_seq_vprintf() APIs
Date: Tue,  8 Jan 2019 16:59:02 -0300
Message-ID: <20190108195910.17726-9-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

In order to make libtraceevent into a proper library, its API should be
straightforward.

The trace_seq_printf() and trace_seq_vprintf() APIs have inconsistent
returned values with the other trace_seq_* APIs.

This path changes the return logic of trace_seq_printf() and
trace_seq_vprintf() to return the number of printed characters, as the
other trace_seq_* related APIs.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201040852.485792891@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/trace-seq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/lib/traceevent/trace-seq.c b/tools/lib/traceevent/trace-seq.c
index 8ff1d55954d1..8d5ecd2bf877 100644
--- a/tools/lib/traceevent/trace-seq.c
+++ b/tools/lib/traceevent/trace-seq.c
@@ -100,7 +100,8 @@ static void expand_buffer(struct trace_seq *s)
  * @fmt: printf format string
  *
  * It returns 0 if the trace oversizes the buffer's free
- * space, 1 otherwise.
+ * space, the number of characters printed, or a negative
+ * value in case of an error.
  *
  * The tracer may use either sequence operations or its own
  * copy to user routines. To simplify formating of a trace
@@ -129,9 +130,10 @@ trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 		goto try_again;
 	}
 
-	s->len += ret;
+	if (ret > 0)
+		s->len += ret;
 
-	return 1;
+	return ret;
 }
 
 /**
@@ -139,6 +141,10 @@ trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
  * @s: trace sequence descriptor
  * @fmt: printf format string
  *
+ * It returns 0 if the trace oversizes the buffer's free
+ * space, the number of characters printed, or a negative
+ * value in case of an error.
+ * *
  * The tracer may use either sequence operations or its own
  * copy to user routines. To simplify formating of a trace
  * trace_seq_printf is used to store strings into a special
@@ -163,9 +169,10 @@ trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
 		goto try_again;
 	}
 
-	s->len += ret;
+	if (ret > 0)
+		s->len += ret;
 
-	return len;
+	return ret;
 }
 
 /**
-- 
2.20.1
