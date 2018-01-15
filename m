From: changbin.du@intel.com
Subject: [PATCH v2 2/3] tracing: clear parser->idx if parser gets nothing
Date: Mon, 15 Jan 2018 19:41:13 +0800
Message-ID: <1516016474-5581-3-git-send-email-changbin.du@intel.com>
References: <1516016474-5581-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516016474-5581-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

If only spaces was got in that cycle, we should clear parser->idx to make
trace_parser_loaded() return false.

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 144d08e..b44926e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1236,14 +1236,14 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 			cnt--;
 		}
 
+		parser->idx = 0;
+
 		/* only spaces were written */
 		if (isspace(ch) || !ch) {
 			*ppos += read;
 			ret = read;
 			goto out;
 		}
-
-		parser->idx = 0;
 	}
 
 	/* read the non-space input */
-- 
2.7.4
