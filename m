From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/32] tools lib traceevent: Handle new pointer processing of bprint strings
Date: Wed, 17 Jan 2018 13:12:02 -0300
Message-ID: <20180117161222.15611-13-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The Linux kernel printf() has some extended use cases that dereference
the pointer. This is dangerouse for tracing because the pointer that is
dereferenced can change or even be unmapped. It also causes issues when
the trace data is extracted, because user space does not have access to
the contents of the pointer even if it still exists.

To handle this, the kernel was updated to process these dereferenced
pointers at the time they are recorded, and not post processed. Now they
exist in the tracing buffer, and no dereference is needed at the time of
reading the trace.

The event parsing library needs to handle this new case.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004822.403349289@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 8757dd64e42c..344a034a8fbc 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4300,6 +4300,26 @@ static struct print_arg *make_bprint_args(char *fmt, void *data, int size, struc
 				goto process_again;
 			case 'p':
 				ls = 1;
+				if (isalnum(ptr[1])) {
+					ptr++;
+					/* Check for special pointers */
+					switch (*ptr) {
+					case 's':
+					case 'S':
+					case 'f':
+					case 'F':
+						break;
+					default:
+						/*
+						 * Older kernels do not process
+						 * dereferenced pointers.
+						 * Only process if the pointer
+						 * value is a printable.
+						 */
+						if (isprint(*(char *)bptr))
+							goto process_string;
+					}
+				}
 				/* fall through */
 			case 'd':
 			case 'u':
@@ -4352,6 +4372,7 @@ static struct print_arg *make_bprint_args(char *fmt, void *data, int size, struc
 
 				break;
 			case 's':
+ process_string:
 				arg = alloc_arg();
 				if (!arg) {
 					do_warning_event(event, "%s(%d): not enough memory!",
@@ -4959,6 +4980,11 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct event
 				if (isalnum(ptr[1]))
 					ptr++;
 
+				if (arg->type == PRINT_BSTRING) {
+					trace_seq_puts(s, arg->string.string);
+					break;
+				}
+
 				if (*ptr == 'F' || *ptr == 'f' ||
 				    *ptr == 'S' || *ptr == 's') {
 					show_func = *ptr;
-- 
2.14.3
