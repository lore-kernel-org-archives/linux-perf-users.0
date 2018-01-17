From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/32] tools lib traceevent: Simplify pointer print logic and fix %pF
Date: Wed, 17 Jan 2018 13:12:01 -0300
Message-ID: <20180117161222.15611-12-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When processing %pX in pretty_print(), simplify the logic slightly by
incrementing the ptr to the format string if isalnum(ptr[1]) is true.
This follows the logic a bit more closely to what is in the kernel.

Also, this fixes a small bug where %pF was not giving the offset of the
function.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004822.260262257@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 87757eabbb08..8757dd64e42c 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4956,21 +4956,22 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct event
 				else
 					ls = 2;
 
-				if (*(ptr+1) == 'F' || *(ptr+1) == 'f' ||
-				    *(ptr+1) == 'S' || *(ptr+1) == 's') {
+				if (isalnum(ptr[1]))
 					ptr++;
+
+				if (*ptr == 'F' || *ptr == 'f' ||
+				    *ptr == 'S' || *ptr == 's') {
 					show_func = *ptr;
-				} else if (*(ptr+1) == 'M' || *(ptr+1) == 'm') {
-					print_mac_arg(s, *(ptr+1), data, size, event, arg);
-					ptr++;
+				} else if (*ptr == 'M' || *ptr == 'm') {
+					print_mac_arg(s, *ptr, data, size, event, arg);
 					arg = arg->next;
 					break;
-				} else if (*(ptr+1) == 'I' || *(ptr+1) == 'i') {
+				} else if (*ptr == 'I' || *ptr == 'i') {
 					int n;
 
-					n = print_ip_arg(s, ptr+1, data, size, event, arg);
+					n = print_ip_arg(s, ptr, data, size, event, arg);
 					if (n > 0) {
-						ptr += n;
+						ptr += n - 1;
 						arg = arg->next;
 						break;
 					}
-- 
2.14.3
