From: changbin.du@intel.com
Subject: [PATCH 1/3] tracing: detect the string termination character when parsing user input string
Date: Tue,  9 Jan 2018 17:55:46 +0800
Message-ID: <1515491748-25926-2-git-send-email-changbin.du@intel.com>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

The usersapce can give a '\0' terminated C string or even has '\0' at the
middle of input buffer. We need handle both these two cases correctly.

Before this change, trace_get_user() will return a parsed string "\0" in
below case. It is not expected (expects it skip all inputs) and cause the
caller failed.

open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)

This patch try to make the parser '\0' aware to fix such issue.

Since the caller expects trace_get_user() to parse whole input buffer, so
this patch treat '\0' as a separator as whitespace.

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 kernel/trace/trace.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a8d8a2..18526a1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1194,9 +1194,14 @@ void trace_parser_put(struct trace_parser *parser)
 	parser->buffer = NULL;
 }
 
+static inline bool is_space_or_zero(char ch)
+{
+	return isspace(ch) || !ch;
+}
+
 /*
- * trace_get_user - reads the user input string separated by  space
- * (matched by isspace(ch))
+ * trace_get_user - reads the user input string separated by space or '\0'
+ * (matched by is_space_or_zero(ch))
  *
  * For each string found the 'struct trace_parser' is updated,
  * and the function returns.
@@ -1228,7 +1233,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	 */
 	if (!parser->cont) {
 		/* skip white space */
-		while (cnt && isspace(ch)) {
+		while (cnt && is_space_or_zero(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
 				goto out;
@@ -1237,7 +1242,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		}
 
 		/* only spaces were written */
-		if (isspace(ch)) {
+		if (is_space_or_zero(ch)) {
 			*ppos += read;
 			ret = read;
 			goto out;
@@ -1247,7 +1252,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	}
 
 	/* read the non-space input */
-	while (cnt && !isspace(ch)) {
+	while (cnt && !is_space_or_zero(ch)) {
 		if (parser->idx < parser->size - 1)
 			parser->buffer[parser->idx++] = ch;
 		else {
@@ -1262,7 +1267,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	}
 
 	/* We either got finished input or we have to wait for another call. */
-	if (isspace(ch)) {
+	if (is_space_or_zero(ch)) {
 		parser->buffer[parser->idx] = 0;
 		parser->cont = false;
 	} else if (parser->idx < parser->size - 1) {
-- 
2.7.4
