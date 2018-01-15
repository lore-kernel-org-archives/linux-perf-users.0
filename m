From: changbin.du@intel.com
Subject: [PATCH v2 3/3] tracing: make sure the parsed string always terminates with '\0'
Date: Mon, 15 Jan 2018 19:41:14 +0800
Message-ID: <1516016474-5581-4-git-send-email-changbin.du@intel.com>
References: <1516016474-5581-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516016474-5581-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

Always mark the parsed string with a terminated '\0' even parser expects
another input to be parsed. Thus the users needn't append '0' before
using parsed string if new input is not given.

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 kernel/trace/ftrace.c       | 2 --
 kernel/trace/trace.c        | 4 ++--
 kernel/trace/trace_events.c | 2 --
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ccdf366..3addb82 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5010,7 +5010,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 
 	parser = &iter->parser;
 	if (trace_parser_loaded(parser)) {
-		parser->buffer[parser->idx] = 0;
 		ftrace_match_records(iter->hash, parser->buffer, parser->idx);
 	}
 
@@ -5324,7 +5323,6 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 		parser = &fgd->parser;
 
 		if (trace_parser_loaded((parser))) {
-			parser->buffer[parser->idx] = 0;
 			ret = ftrace_graph_set_hash(fgd->new_hash,
 						    parser->buffer);
 		}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b44926e..8f7fea2 100644
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
@@ -1268,6 +1266,8 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	} else if (parser->idx < parser->size - 1) {
 		parser->cont = true;
 		parser->buffer[parser->idx++] = ch;
+		/* Make sure the parsed string always terminates with '\0'. */
+		parser->buffer[parser->idx] = 0;
 	} else {
 		ret = -EINVAL;
 		goto out;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ec0f9aa..7f8027c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -885,8 +885,6 @@ ftrace_event_write(struct file *file, const char __user *ubuf,
 		if (*parser.buffer == '!')
 			set = 0;
 
-		parser.buffer[parser.idx] = 0;
-
 		ret = ftrace_set_clr_event(tr, parser.buffer + !set, set);
 		if (ret)
 			goto out_put;
-- 
2.7.4
