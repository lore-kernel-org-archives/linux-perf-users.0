From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/40] perf trace beauty clone: Suppress unused args according to 'flags' arg
Date: Wed, 26 Jul 2017 11:17:02 -0300
Message-ID: <20170726141730.30750-13-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'parent_tidptr', 'child_tidptr' and 'tls' arguments to the 'clone'
syscall are only used when certain flags are set in 'flags', suppress
them when those aren't there.

E.g:

   9886.919 (0.236 ms): fetchmail/19298 clone(flags: CHILD_CLEARTID|CHILD_SETTID|0x11, child_stack: 0, child_tidptr: 0x7fe43f468590) = 19608 (fetchmail)
  12876.052 (0.249 ms): qemu-system-x8/21238 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f48117fc770, parent_tidptr: 0x7f48117ff9d0, child_tidptr: 0x7f48117ff9d0, tls: 0x7f48117ff700) = 19611 (qemu-system-x86)
  12876.555 (0.048 ms): worker/19611 clone(flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, child_stack: 0x7f480f7f8770, parent_tidptr: 0x7f480f7fb9d0, child_tidptr: 0x7f480f7fb9d0, tls: 0x7f480f7fb700) = 19612 (worker)
  16575.240 (0.469 ms): fetchmail/19298 clone(flags: CHILD_CLEARTID|CHILD_SETTID|0x11, child_stack: 0, child_tidptr: 0x7fe43f468590) = 19613 (fetchmail)
  20797.270 (0.335 ms): fetchmail/19298 clone(flags: CHILD_CLEARTID|CHILD_SETTID|0x11, child_stack: 0, child_tidptr: 0x7fe43f468590) = 19614 (fetchmail)
  21228.585 (0.501 ms): vim/19519 clone(flags: CHILD_CLEARTID|CHILD_SETTID|0x11, child_stack: 0, child_tidptr: 0x7fbad6ac27d0) = 19615 (vim)
  21232.193 (0.137 ms): bash/19615 clone(flags: CHILD_CLEARTID|CHILD_SETTID|0x11, child_stack: 0, child_tidptr: 0x7fad8bff49d0) = 19616 (bash)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-0um93djul9knf239gwa5mpcb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/clone.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
index ab982a7c63bb..d64d049ab991 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -54,5 +54,22 @@ static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 
 size_t syscall_arg__scnprintf_clone_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
-	return clone__scnprintf_flags(arg->val, bf, size);
+	unsigned long flags = arg->val;
+	enum syscall_clone_args {
+		SCC_FLAGS	  = (1 << 0),
+		SCC_CHILD_STACK	  = (1 << 1),
+		SCC_PARENT_TIDPTR = (1 << 2),
+		SCC_CHILD_TIDPTR  = (1 << 3),
+		SCC_TLS		  = (1 << 4),
+	};
+	if (!(flags & CLONE_PARENT_SETTID))
+		arg->mask |= SCC_PARENT_TIDPTR;
+
+	if (!(flags & (CLONE_CHILD_SETTID | CLONE_CHILD_CLEARTID)))
+		arg->mask |= SCC_CHILD_TIDPTR;
+
+	if (!(flags & CLONE_SETTLS))
+		arg->mask |= SCC_TLS;
+
+	return clone__scnprintf_flags(flags, bf, size);
 }
-- 
2.9.4
