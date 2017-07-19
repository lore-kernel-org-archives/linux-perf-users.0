From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/86] perf trace beauty fcntl: Beautify F_[GS]ETFD arg/return value
Date: Wed, 19 Jul 2017 11:28:46 -0300
Message-ID: <20170719142950.3747-23-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now it will show 0 or CLOEXEC, the only !0 value returned by the kernel
for fcntl(fd, F_GETFD).

And for F_SETFD:

  6870.267 ( 0.004 ms): make/29812 fcntl(fd: 7</home/acme/git/linux/tools/build/Build.include>, cmd: SETFD, arg: CLOEXEC) = 0
  6873.805 ( 0.002 ms): make/29816 fcntl(fd: 6</home/acme/git/linux/tools/build/Makefile.build>, cmd: SETFD, arg: CLOEXEC) = 0
<SNIP>
 77986.150 ( 0.006 ms): alsa-sink-ALC3/2042 fcntl(fd: 45</dev/snd/pcmC1D0p>, cmd: SETFD, arg: CLOEXEC) = 0
 77986.271 ( 0.006 ms): alsa-sink-ALC3/2042 fcntl(fd: 23</dev/snd/controlC1>, cmd: SETFD, arg: CLOEXEC) = 0

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-sz9dob7t4zd6m65femazpaah@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fcntl.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 3456bf4cdb48..384f177a4304 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -7,19 +7,28 @@
  */
 
 #include "trace/beauty/beauty.h"
+#include <linux/kernel.h>
 #include <uapi/linux/fcntl.h>
 
+static size_t fcntl__scnprintf_getfd(unsigned long val, char *bf, size_t size)
+{
+	return scnprintf(bf, size, "%s", val ? "CLOEXEC" : "0");
+}
+
 size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg)
 {
 	if (arg->val == F_GETFL) {
 		syscall_arg__set_ret_scnprintf(arg, open__scnprintf_flags);
 		goto mask_arg;
 	}
+	if (arg->val == F_GETFD) {
+		syscall_arg__set_ret_scnprintf(arg, fcntl__scnprintf_getfd);
+		goto mask_arg;
+	}
 	/*
 	 * Some commands ignore the third fcntl argument, "arg", so mask it
 	 */
-	if (arg->val == F_GETFD	   ||
-	    arg->val == F_GETOWN   || arg->val == F_GET_SEALS ||
+	if (arg->val == F_GETOWN   || arg->val == F_GET_SEALS ||
 	    arg->val == F_GETLEASE || arg->val == F_GETSIG) {
 mask_arg:
 		arg->mask |= (1 << 2);
@@ -32,6 +41,9 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 {
 	int cmd = syscall_arg__val(arg, 1);
 
+	if (cmd == F_SETFD)
+		return fcntl__scnprintf_getfd(arg->val, bf, size);
+
 	if (cmd == F_SETFL)
 		return open__scnprintf_flags(arg->val, bf, size);
 	/*
-- 
2.9.4
