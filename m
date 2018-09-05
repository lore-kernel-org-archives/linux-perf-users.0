From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/77] perf trace augmented_syscalls: Augment bind's 'myaddr' sockaddr arg
Date: Wed,  5 Sep 2018 19:03:39 -0300
Message-ID: <20180905220440.20256-17-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more, to reuse the augmented_sockaddr_syscall_enter() macro
introduced from the augmentation of connect's sockaddr arg, also to get
a subset of the struct arg augmentations done using the manual method,
before switching to something automatic, using tracefs's format file or,
even better, BTF containing the syscall args structs.

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c
     0.000 sshd/11479 bind(fd: 3<socket:[170336]>, umyaddr: { .family: NETLINK }, addrlen: 12)
     1.752 sshd/11479 bind(fd: 3<socket:[170336]>, umyaddr: { .family: INET, port: 22, addr: 0.0.0.0 }, addrlen: 16)
     1.924 sshd/11479 bind(fd: 4<socket:[170338]>, umyaddr: { .family: INET6, port: 22, addr: :: }, addrlen: 28)
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-a2drqpahpmc7uwb3n3gj2plu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                   |  2 ++
 tools/perf/examples/bpf/augmented_syscalls.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ab2ed30b8dcc..537bb30895df 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -621,6 +621,8 @@ static struct syscall_fmt {
 } syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
+	{ .name	    = "bind",
+	  .arg = { [1] = { .scnprintf = SCA_SOCKADDR, /* umyaddr */ }, }, },
 	{ .name	    = "bpf",
 	  .arg = { [0] = STRARRAY(cmd, bpf_cmd), }, },
 	{ .name	    = "brk",	    .hexret = true,
diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 5f417e528419..71edb7ad8698 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -122,6 +122,16 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 
 struct sockaddr;
 
+struct syscall_enter_bind_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   fd;
+	struct sockaddr	   *addr_ptr;
+	unsigned long	   addrlen;
+};
+
+augmented_sockaddr_syscall_enter(bind);
+
 struct syscall_enter_connect_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
-- 
2.14.4
