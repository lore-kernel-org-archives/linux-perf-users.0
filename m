From: changbin.du@intel.com
Subject: [PATCH] perf ftrace: Fix the buffer size in __write_tracing_file
Date: Tue, 26 Dec 2017 17:26:56 +0800
Message-ID: <1514280416-29659-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18222 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdLZJfA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Dec 2017 04:35:00 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>

From: Changbin Du <changbin.du@intel.com>

The terminal character '\0' should take into account as size of the string
buffer. Without this fix, the '--graph-funcs', '--nograph-funcs' and
'--trace-funcs' options didn't work as expected when the <func> doesn't
exist.

I didn't dive into kernel ftrace fops, but strace shows that if usersapce
writes a non-terminated string, the kernel side will return success but
no filter applied. After this fix in userspace, the kernel will return an
error.

$ sudo ./perf ftrace -a --graph-depth 1 --graph-funcs abcdefg
 0)   0.140 us    |  rcu_all_qs();
 3)   0.304 us    |  mutex_unlock();
 0)   0.153 us    |  find_vma();
 3)   0.088 us    |  __fsnotify_parent();
 0)   6.145 us    |  handle_mm_fault();
 3)   0.089 us    |  fsnotify();
 3)   0.161 us    |  __sb_end_write();
 3)   0.710 us    |  SyS_close();
 3)   7.848 us    |  exit_to_usermode_loop();

On above example, I specified function filter 'abcdefg' but all functions
are enabled.

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 tools/perf/builtin-ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 25a42ac..2604a64 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -69,7 +69,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
 {
 	char *file;
 	int fd, ret = -1;
-	ssize_t size = strlen(val);
+	ssize_t size = strlen(val) + 1;
 	int flags = O_WRONLY;
 	char errbuf[512];
 
-- 
2.7.4
