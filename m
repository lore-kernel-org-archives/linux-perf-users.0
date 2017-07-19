From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/86] perf trace beauty fcntl: Beautify F_GETFL return value
Date: Wed, 19 Jul 2017 11:28:43 -0300
Message-ID: <20170719142950.3747-20-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The return for fcntl(fd, F_GETFL) is the fd file flags, so reuse the one
for the open syscall flags parameter:

  997.992 (0.002 ms): Chrome_IOThrea/19863 fcntl(fd: 144</dev/shm/.com.google.Chrome.OhA8YL>, cmd: GETFL) = RDWR|LARGEFILE

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-5nn3n4p4yfs6u0leoq880apc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fcntl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 8a5f58d9eb7c..8dcbc30427c9 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -11,13 +11,19 @@
 
 size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg)
 {
+	if (arg->val == F_GETFL) {
+		syscall_arg__set_ret_scnprintf(arg, open__scnprintf_flags);
+		goto mask_arg;
+	}
 	/*
 	 * Some commands ignore the third fcntl argument, "arg", so mask it
 	 */
-	if (arg->val == F_GETFD	   || arg->val == F_GETFL     ||
+	if (arg->val == F_GETFD	   ||
 	    arg->val == F_GETOWN   || arg->val == F_GET_SEALS ||
-	    arg->val == F_GETLEASE || arg->val == F_GETSIG)
+	    arg->val == F_GETLEASE || arg->val == F_GETSIG) {
+mask_arg:
 		arg->mask |= (1 << 2);
+	}
 
 	return syscall_arg__scnprintf_strarrays(bf, size, arg);
 }
-- 
2.9.4
