From: changbin.du@intel.com
Subject: [PATCH 2/3] tracing: make sure the parsed string always terminates with '\0'
Date: Tue,  9 Jan 2018 17:55:47 +0800
Message-ID: <1515491748-25926-3-git-send-email-changbin.du@intel.com>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

The parser parse every string into parser.buffer. And some of the callers
assume that parser.buffer contains a C string. So it is dangerous that the
parser returns a unterminated string. The userspace can leverage this to
attack the kernel.

Signed-off-by: Changbin Du <changbin.du@intel.com>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 18526a1..e1baca0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -530,8 +530,6 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		ubuf += ret;
 		cnt -= ret;
 
-		parser.buffer[parser.idx] = 0;
-
 		ret = -EINVAL;
 		if (kstrtoul(parser.buffer, 0, &val))
 			break;
@@ -1253,7 +1251,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	/* read the non-space input */
 	while (cnt && !is_space_or_zero(ch)) {
-		if (parser->idx < parser->size - 1)
+		if (parser->idx < parser->size - 2)
 			parser->buffer[parser->idx++] = ch;
 		else {
 			ret = -EINVAL;
@@ -1270,9 +1268,11 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	if (is_space_or_zero(ch)) {
 		parser->buffer[parser->idx] = 0;
 		parser->cont = false;
-	} else if (parser->idx < parser->size - 1) {
+	} else if (parser->idx < parser->size - 2) {
 		parser->cont = true;
 		parser->buffer[parser->idx++] = ch;
+		/* Make sure the parsed string always terminates with '\0'. */
+		parser->buffer[parser->idx] = 0;
 	} else {
 		ret = -EINVAL;
 		goto out;
-- 
2.7.4
