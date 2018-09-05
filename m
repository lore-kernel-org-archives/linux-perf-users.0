From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/77] perf trace augmented_syscalls: Augment sendto's 'addr' arg
Date: Wed,  5 Sep 2018 19:03:40 -0300
Message-ID: <20180905220440.20256-18-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its a 'struct sockaddr' pointer, augment it with the same beautifier as
for 'connect' and 'bind', that all receive from userspace that pointer.

Doing it in the other direction remains to be done, hooking at the
syscalls:sys_exit_{accept4?,recvmsg} tracepoints somehow.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-k2eu68lsphnm2fthc32gq76c@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                   |  3 ++-
 tools/perf/examples/bpf/augmented_syscalls.c | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 537bb30895df..759d14e3fe6b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -795,7 +795,8 @@ static struct syscall_fmt {
 	{ .name	    = "sendmsg",
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "sendto",
-	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
+	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ },
+		   [4] = { .scnprintf = SCA_SOCKADDR, /* addr */ }, }, },
 	{ .name	    = "set_tid_address", .errpid = true, },
 	{ .name	    = "setitimer",
 	  .arg = { [0] = STRARRAY(which, itimers), }, },
diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 71edb7ad8698..be06d2c9e8c9 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -142,4 +142,17 @@ struct syscall_enter_connect_args {
 
 augmented_sockaddr_syscall_enter(connect);
 
+struct syscall_enter_sendto_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   fd;
+	void		   *buff;
+	long		   len;
+	unsigned long	   flags;
+	struct sockaddr	   *addr_ptr;
+	long		   addr_len;
+};
+
+augmented_sockaddr_syscall_enter(sendto);
+
 license(GPL);
-- 
2.14.4
