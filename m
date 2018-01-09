From: changbin.du@intel.com
Subject: [PATCH 3/3] tracing: don't set parser->cont if it has reached the end of input buffer
Date: Tue,  9 Jan 2018 17:55:48 +0800
Message-ID: <1515491748-25926-4-git-send-email-changbin.du@intel.com>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

We should not set parser->cont if it has reached the end of input buffer.
And since some callers (like ftrace_graph_write()) treat it as an error
condition if trace_parser_cont() returns true.

For example, if userspace set 'set_ftrace_filter' by writing:
write(3, "abcdefg", 7)

Then in the kernel function ftrace_regex_write(), ftrace_process_regex()
will not be executed. The result is that the given filter will not be
applied at all.

ftrace_regex_write() {
	...
	read = trace_get_user(parser, ubuf, cnt, ppos);
	if (read >= 0 && trace_parser_loaded(parser) &&
	    !trace_parser_cont(parser)) {
		ret = ftrace_process_regex(iter, parser->buffer,
					   parser->idx, enable);
		...
	}
	...
}

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e1baca0..79fdce2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1269,7 +1269,8 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		parser->buffer[parser->idx] = 0;
 		parser->cont = false;
 	} else if (parser->idx < parser->size - 2) {
-		parser->cont = true;
+		parser->cont = !!cnt;
+
 		parser->buffer[parser->idx++] = ch;
 		/* Make sure the parsed string always terminates with '\0'. */
 		parser->buffer[parser->idx] = 0;
-- 
2.7.4
