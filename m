From: changbin.du@intel.com
Subject: [PATCH v2 1/3] tracing: detect the string termination character when parsing user input string
Date: Mon, 15 Jan 2018 19:41:12 +0800
Message-ID: <1516016474-5581-2-git-send-email-changbin.du@intel.com>
References: <1516016474-5581-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516016474-5581-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

The usersapce can give a '\0' terminated C string in the input buffer.
Before this change, trace_get_user() will return a parsed string "\0" in
below case which is not expected (expects it skip all inputs) and cause the
caller failed.

open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)

while parse can handle spaces, so below works.

$ echo "" > set_ftrace_pid
$ echo " " > set_ftrace_pid
$ echo -n " " > set_ftrace_pid

This patch try to make the parser '\0' aware to fix such issue. When parser
sees a '\0' it stops further parsing. With this change, write(3, " \0", 2)
will work.

Signed-off-by: Changbin Du <changbin.du@intel.com>

---
  v2: Stop parsing when '\0' found.
---
 kernel/trace/trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a8d8a2..144d08e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1237,7 +1237,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		}
 
 		/* only spaces were written */
-		if (isspace(ch)) {
+		if (isspace(ch) || !ch) {
 			*ppos += read;
 			ret = read;
 			goto out;
@@ -1247,7 +1247,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	}
 
 	/* read the non-space input */
-	while (cnt && !isspace(ch)) {
+	while (cnt && !isspace(ch) && ch) {
 		if (parser->idx < parser->size - 1)
 			parser->buffer[parser->idx++] = ch;
 		else {
@@ -1262,7 +1262,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	}
 
 	/* We either got finished input or we have to wait for another call. */
-	if (isspace(ch)) {
+	if (isspace(ch) || !ch) {
 		parser->buffer[parser->idx] = 0;
 		parser->cont = false;
 	} else if (parser->idx < parser->size - 1) {
-- 
2.7.4
