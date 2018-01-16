From: changbin.du@intel.com
Subject: [PATCH v3 1/3] tracing: detect the string termination character when parsing user input string
Date: Tue, 16 Jan 2018 17:02:28 +0800
Message-ID: <1516093350-12045-2-git-send-email-changbin.du@intel.com>
References: <1516093350-12045-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516093350-12045-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

User space can pass in a C nul character '\0' along with its input. The
function trace_get_user() will try to process it as a normal character,
and that will fail to parse.

open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)

while parse can handle spaces, so below works.

$ echo "" > set_ftrace_pid
$ echo " " > set_ftrace_pid
$ echo -n " " > set_ftrace_pid

Have the parser stop on '\0' and cease any further parsing. Only process
the characters up to the nul '\0' character and do not process it.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Changbin Du <changbin.du@intel.com>

---
  v3: Polish commit msg from Steven Rostedt.
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
