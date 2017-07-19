From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 57/86] perf trace beauty fcntl: Beautify F_GETLEASE and F_SETLEASE arg/return
Date: Wed, 19 Jul 2017 11:29:21 -0300
Message-ID: <20170719142950.3747-58-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more looking prettier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-ytr7idkese8sjtvn5g60130e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fcntl.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index d082fd2e594f..b6987c468d18 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -20,6 +20,19 @@ static size_t syscall_arg__scnprintf_fcntl_getfd(char *bf, size_t size, struct s
 	return fcntl__scnprintf_getfd(arg->val, bf, size);
 }
 
+static size_t fcntl__scnprintf_getlease(unsigned long val, char *bf, size_t size)
+{
+	static const char *fcntl_setlease[] = { "RDLCK", "WRLCK", "UNLCK", };
+	static DEFINE_STRARRAY(fcntl_setlease);
+
+	return strarray__scnprintf(&strarray__fcntl_setlease, bf, size, "%x", val);
+}
+
+static size_t syscall_arg__scnprintf_fcntl_getlease(char *bf, size_t size, struct syscall_arg *arg)
+{
+	return fcntl__scnprintf_getlease(arg->val, bf, size);
+}
+
 size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg)
 {
 	if (arg->val == F_GETFL) {
@@ -38,11 +51,15 @@ size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_ar
 		syscall_arg__set_ret_scnprintf(arg, syscall_arg__scnprintf_pid);
 		goto mask_arg;
 	}
+	if (arg->val == F_GETLEASE) {
+		syscall_arg__set_ret_scnprintf(arg, syscall_arg__scnprintf_fcntl_getlease);
+		goto mask_arg;
+	}
 	/*
 	 * Some commands ignore the third fcntl argument, "arg", so mask it
 	 */
 	if (arg->val == F_GET_SEALS ||
-	    arg->val == F_GETLEASE || arg->val == F_GETSIG) {
+	    arg->val == F_GETSIG) {
 mask_arg:
 		arg->mask |= (1 << 2);
 	}
@@ -62,6 +79,9 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 
 	if (cmd == F_SETOWN)
 		return syscall_arg__scnprintf_pid(bf, size, arg);
+
+	if (cmd == F_SETLEASE)
+		return fcntl__scnprintf_getlease(arg->val, bf, size);
 	/*
 	 * We still don't grab the contents of pointers on entry or exit,
 	 * so just print them as hex numbers
-- 
2.9.4
