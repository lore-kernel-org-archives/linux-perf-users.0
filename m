From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/86] perf trace beauty fcntl flags: Beautify F_SETFL arg
Date: Wed, 19 Jul 2017 11:28:45 -0300
Message-ID: <20170719142950.3747-22-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Result:

  0.011 (0.001 ms): Chrome_IOThrea/19863 fcntl(fd: 130</dev/shm/.com.google.Chrome.w5UBtZ (deleted)>, cmd: SETFL, arg: RDWR|APPEND|LARGEFILE) = 0

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-qgf8ggsq9chnjblxlq954deu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fcntl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 8dcbc30427c9..3456bf4cdb48 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -32,6 +32,8 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 {
 	int cmd = syscall_arg__val(arg, 1);
 
+	if (cmd == F_SETFL)
+		return open__scnprintf_flags(arg->val, bf, size);
 	/*
 	 * We still don't grab the contents of pointers on entry or exit,
 	 * so just print them as hex numbers
-- 
2.9.4
