From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/32] tools lib traceevent: Show value of flags that have not been parsed
Date: Wed, 17 Jan 2018 13:11:59 -0300
Message-ID: <20180117161222.15611-10-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the value contains bits that are not defined by print_flags() helper,
then show the remaining bits. This aligns with the functionality of the
kernel.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/e60c889f-55e7-4ee8-0e50-151e435ffd8c@siemens.com
Link: http://lkml.kernel.org/r/20180112004821.976225232@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 0bc1a6df8a27..96c9c0b33423 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -3970,6 +3970,11 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 				val &= ~fval;
 			}
 		}
+		if (val) {
+			if (print && arg->flags.delim)
+				trace_seq_puts(s, arg->flags.delim);
+			trace_seq_printf(s, "0x%llx", val);
+		}
 		break;
 	case PRINT_SYMBOL:
 		val = eval_num_arg(data, size, event, arg->symbol.field);
-- 
2.14.3
