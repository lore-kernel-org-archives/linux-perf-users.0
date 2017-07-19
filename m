From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/86] perf trace beauty fcntl: Beautify F_GETOWN and F_SETOWN
Date: Wed, 19 Jul 2017 11:28:51 -0300
Message-ID: <20170719142950.3747-28-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

By attaching the pid beautifier to the args in the F_SETOWN case and to
the syscall return on the F_GETOWN one.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-ea1prtqvao87cdrishce7954@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fcntl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 254ae435780d..d082fd2e594f 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -34,10 +34,14 @@ size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_ar
 		syscall_arg__set_ret_scnprintf(arg, syscall_arg__scnprintf_fd);
 		goto out;
 	}
+	if (arg->val == F_GETOWN) {
+		syscall_arg__set_ret_scnprintf(arg, syscall_arg__scnprintf_pid);
+		goto mask_arg;
+	}
 	/*
 	 * Some commands ignore the third fcntl argument, "arg", so mask it
 	 */
-	if (arg->val == F_GETOWN   || arg->val == F_GET_SEALS ||
+	if (arg->val == F_GET_SEALS ||
 	    arg->val == F_GETLEASE || arg->val == F_GETSIG) {
 mask_arg:
 		arg->mask |= (1 << 2);
@@ -55,6 +59,9 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 
 	if (cmd == F_SETFL)
 		return open__scnprintf_flags(arg->val, bf, size);
+
+	if (cmd == F_SETOWN)
+		return syscall_arg__scnprintf_pid(bf, size, arg);
 	/*
 	 * We still don't grab the contents of pointers on entry or exit,
 	 * so just print them as hex numbers
-- 
2.9.4
