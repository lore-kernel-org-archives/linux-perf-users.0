From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 61/86] perf trace beauty fcntl: Beautify the 'arg' for DUPFD
Date: Wed, 19 Jul 2017 11:29:25 -0300
Message-ID: <20170719142950.3747-62-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before:

 77059.513 ( 0.005 ms): bash/6649 fcntl(fd: 1</dev/pts/12>, cmd: DUPFD, arg: 10) = 10</dev/pts/12>

After:

 77059.513 ( 0.005 ms): bash/6649 fcntl(fd: 1</dev/pts/12>, cmd: DUPFD, arg: 10</dev/pts/12>) = 10</dev/pts/12>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-0k8iszng0slcuw0rc6xq1x5l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index b6987c468d18..9e8900c13cb1 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -71,6 +71,9 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 {
 	int cmd = syscall_arg__val(arg, 1);
 
+	if (cmd == F_DUPFD)
+		return syscall_arg__scnprintf_fd(bf, size, arg);
+
 	if (cmd == F_SETFD)
 		return fcntl__scnprintf_getfd(arg->val, bf, size);
 
-- 
2.9.4
