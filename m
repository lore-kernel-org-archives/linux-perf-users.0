From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 58/86] perf trace: Group per syscall arg formatter info into one struct
Date: Wed, 19 Jul 2017 11:29:22 -0300
Message-ID: <20170719142950.3747-59-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932219AbdGSOfc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2017 10:35:32 -0400
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of having syscall_fmt.{arg_scnprintf,arg_parm}, introduce
struct syscall_arg_fmt and have these two, paving the way for more
state to change the formatting algorithms.

For instance, in the 'fcntl' 'cmd' case it is better not to suppress
it when being zero, showing instead its name "DUPFD".

We had that in an ad-hoc way just for strarrays, but with more involved
cases like fcntl, that can't be done with just a strarray, we'll need
a ".show_zero" arg in the 'cmd' syscall_arg_fmt.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-ch06o2j72zbjx5xww4qp67au@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 256 +++++++++++++++++++++++----------------------
 1 file changed, 133 insertions(+), 123 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0dedce0ca0bb..32778a621a08 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -582,9 +582,9 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
 
-#define STRARRAY(arg, name, array) \
-	  .arg_scnprintf = { [arg] = SCA_STRARRAY, }, \
-	  .arg_parm	 = { [arg] = &strarray__##array, }
+#define STRARRAY(name, array) \
+	  { .scnprintf	= SCA_STRARRAY, \
+	    .parm	= &strarray__##array, }
 
 #include "trace/beauty/eventfd.c"
 #include "trace/beauty/flock.c"
@@ -601,54 +601,61 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #include "trace/beauty/socket_type.c"
 #include "trace/beauty/waitid_options.c"
 
+struct syscall_arg_fmt {
+	size_t	   (*scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
+	void	   *parm;
+};
+
 static struct syscall_fmt {
 	const char *name;
 	const char *alias;
-	size_t	   (*arg_scnprintf[6])(char *bf, size_t size, struct syscall_arg *arg);
-	void	   *arg_parm[6];
+	struct syscall_arg_fmt arg[6];
 	bool	   errmsg;
 	bool	   errpid;
 	bool	   timeout;
 	bool	   hexret;
 } syscall_fmts[] = {
 	{ .name	    = "access",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_ACCMODE,  /* mode */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
 	{ .name	    = "arch_prctl", .errmsg = true, .alias = "prctl", },
-	{ .name	    = "bpf",	    .errmsg = true, STRARRAY(0, cmd, bpf_cmd), },
+	{ .name	    = "bpf",	    .errmsg = true,
+	  .arg = { [0] = STRARRAY(cmd, bpf_cmd), }, },
 	{ .name	    = "brk",	    .hexret = true,
-	  .arg_scnprintf = { [0] = SCA_HEX, /* brk */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_HEX, /* brk */ }, }, },
 	{ .name	    = "chdir",	    .errmsg = true, },
 	{ .name	    = "chmod",	    .errmsg = true, },
 	{ .name	    = "chroot",	    .errmsg = true, },
-	{ .name     = "clock_gettime",  .errmsg = true, STRARRAY(0, clk_id, clockid), },
+	{ .name     = "clock_gettime", .errmsg = true,
+	  .arg = { [0] = STRARRAY(clk_id, clockid), }, },
 	{ .name	    = "clone",	    .errpid = true, },
 	{ .name	    = "close",	    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_CLOSE_FD, /* fd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_CLOSE_FD, /* fd */ }, }, },
 	{ .name	    = "connect",    .errmsg = true, },
 	{ .name	    = "creat",	    .errmsg = true, },
 	{ .name	    = "dup",	    .errmsg = true, },
 	{ .name	    = "dup2",	    .errmsg = true, },
 	{ .name	    = "dup3",	    .errmsg = true, },
-	{ .name	    = "epoll_ctl",  .errmsg = true, STRARRAY(1, op, epoll_ctl_ops), },
+	{ .name	    = "epoll_ctl",  .errmsg = true,
+	  .arg = { [1] = STRARRAY(op, epoll_ctl_ops), }, },
 	{ .name	    = "eventfd2",   .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_EFD_FLAGS, /* flags */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_EFD_FLAGS, /* flags */ }, }, },
 	{ .name	    = "faccessat",  .errmsg = true, },
 	{ .name	    = "fadvise64",  .errmsg = true, },
 	{ .name	    = "fallocate",  .errmsg = true, },
 	{ .name	    = "fchdir",	    .errmsg = true, },
 	{ .name	    = "fchmod",	    .errmsg = true, },
 	{ .name	    = "fchmodat",   .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* fd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "fchown",	    .errmsg = true, },
 	{ .name	    = "fchownat",   .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* fd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "fcntl",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_FCNTL_CMD, /* cmd */
-			     [2] = SCA_FCNTL_ARG, /* arg */ },
-	  .arg_parm	 = { [1] = &strarrays__fcntl_cmds_arrays, /* cmd */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_FCNTL_CMD, /* cmd */
+			   .parm      = &strarrays__fcntl_cmds_arrays, /* cmd */ },
+		   [2] = { .scnprintf =  SCA_FCNTL_ARG, /* arg */ }, }, },
 	{ .name	    = "fdatasync",  .errmsg = true, },
 	{ .name	    = "flock",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_FLOCK, /* cmd */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_FLOCK, /* cmd */ }, }, },
 	{ .name	    = "fsetxattr",  .errmsg = true, },
 	{ .name	    = "fstat",	    .errmsg = true, .alias = "newfstat", },
 	{ .name	    = "fstatat",    .errmsg = true, .alias = "newfstatat", },
@@ -656,186 +663,190 @@ static struct syscall_fmt {
 	{ .name	    = "fsync",    .errmsg = true, },
 	{ .name	    = "ftruncate", .errmsg = true, },
 	{ .name	    = "futex",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_FUTEX_OP, /* op */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_FUTEX_OP, /* op */ }, }, },
 	{ .name	    = "futimesat", .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* fd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "getdents",   .errmsg = true, },
 	{ .name	    = "getdents64", .errmsg = true, },
-	{ .name	    = "getitimer",  .errmsg = true, STRARRAY(0, which, itimers), },
+	{ .name	    = "getitimer",  .errmsg = true,
+	  .arg = { [0] = STRARRAY(which, itimers), }, },
 	{ .name	    = "getpid",	    .errpid = true, },
 	{ .name	    = "getpgid",    .errpid = true, },
 	{ .name	    = "getppid",    .errpid = true, },
 	{ .name	    = "getrandom",  .errmsg = true,
-	  .arg_scnprintf = { [2] = SCA_GETRANDOM_FLAGS, /* flags */ }, },
-	{ .name	    = "getrlimit",  .errmsg = true, STRARRAY(0, resource, rlimit_resources), },
+	  .arg = { [2] = { .scnprintf = SCA_GETRANDOM_FLAGS, /* flags */ }, }, },
+	{ .name	    = "getrlimit",  .errmsg = true,
+	  .arg = { [0] = STRARRAY(resource, rlimit_resources), }, },
 	{ .name	    = "getxattr",   .errmsg = true, },
-	{ .name	    = "inotify_add_watch",	    .errmsg = true, },
+	{ .name	    = "inotify_add_watch", .errmsg = true, },
 	{ .name	    = "ioctl",	    .errmsg = true,
-	  .arg_scnprintf = {
+	  .arg = {
 #if defined(__i386__) || defined(__x86_64__)
 /*
  * FIXME: Make this available to all arches.
  */
-			     [1] = SCA_STRHEXARRAY, /* cmd */
-			     [2] = SCA_HEX, /* arg */ },
-	  .arg_parm	 = { [1] = &strarray__tioctls, /* cmd */ }, },
+		   [1] = { .scnprintf = SCA_STRHEXARRAY, /* cmd */
+			   .parm      = &strarray__tioctls, },
+		   [2] = { .scnprintf = SCA_HEX, /* arg */ }, }, },
 #else
-			     [2] = SCA_HEX, /* arg */ }, },
+		   [2] = { .scnprintf = SCA_HEX, /* arg */ }, }, },
 #endif
-	{ .name	    = "keyctl",	    .errmsg = true, STRARRAY(0, option, keyctl_options), },
+	{ .name	    = "keyctl",	    .errmsg = true,
+	  .arg = { [0] = STRARRAY(option, keyctl_options), }, },
 	{ .name	    = "kill",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_SIGNUM, /* sig */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "lchown",    .errmsg = true, },
 	{ .name	    = "lgetxattr",  .errmsg = true, },
 	{ .name	    = "linkat",	    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* fd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "listxattr",  .errmsg = true, },
 	{ .name	    = "llistxattr", .errmsg = true, },
 	{ .name	    = "lremovexattr",  .errmsg = true, },
 	{ .name	    = "lseek",	    .errmsg = true,
-	  .arg_scnprintf = { [2] = SCA_STRARRAY, /* whence */ },
-	  .arg_parm	 = { [2] = &strarray__whences, /* whence */ }, },
+	  .arg = { [2] = STRARRAY(whence, whences), }, },
 	{ .name	    = "lsetxattr",  .errmsg = true, },
 	{ .name	    = "lstat",	    .errmsg = true, .alias = "newlstat", },
 	{ .name	    = "lsxattr",    .errmsg = true, },
 	{ .name     = "madvise",    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_HEX,	 /* start */
-			     [2] = SCA_MADV_BHV, /* behavior */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_HEX,      /* start */ },
+		   [2] = { .scnprintf = SCA_MADV_BHV, /* behavior */ }, }, },
 	{ .name	    = "mkdir",    .errmsg = true, },
 	{ .name	    = "mkdirat",    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* fd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "mknod",      .errmsg = true, },
 	{ .name	    = "mknodat",    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* fd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "mlock",	    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_HEX, /* addr */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
 	{ .name	    = "mlockall",   .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_HEX, /* addr */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
 	{ .name	    = "mmap",	    .hexret = true,
 /* The standard mmap maps to old_mmap on s390x */
 #if defined(__s390x__)
 	.alias = "old_mmap",
 #endif
-	  .arg_scnprintf = { [0] = SCA_HEX,	  /* addr */
-			     [2] = SCA_MMAP_PROT, /* prot */
-			     [3] = SCA_MMAP_FLAGS, /* flags */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* addr */ },
+		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
+		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
 	{ .name	    = "mprotect",   .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_HEX, /* start */
-			     [2] = SCA_MMAP_PROT, /* prot */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
+		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ }, }, },
 	{ .name	    = "mq_unlink", .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FILENAME, /* u_name */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* u_name */ }, }, },
 	{ .name	    = "mremap",	    .hexret = true,
-	  .arg_scnprintf = { [0] = SCA_HEX, /* addr */
-			     [3] = SCA_MREMAP_FLAGS, /* flags */
-			     [4] = SCA_HEX, /* new_addr */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_HEX,	  /* addr */ },
+		   [3] = { .scnprintf = SCA_MREMAP_FLAGS, /* flags */ },
+		   [4] = { .scnprintf = SCA_HEX,	  /* new_addr */ }, }, },
 	{ .name	    = "munlock",    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_HEX, /* addr */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
 	{ .name	    = "munmap",	    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_HEX, /* addr */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
 	{ .name	    = "name_to_handle_at", .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* dfd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "newfstatat", .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* dfd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "open",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_OPEN_FLAGS, /* flags */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "open_by_handle_at", .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* dfd */
-			     [2] = SCA_OPEN_FLAGS, /* flags */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
+		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "openat",	    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* dfd */
-			     [2] = SCA_OPEN_FLAGS, /* flags */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
+		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "perf_event_open", .errmsg = true,
-	  .arg_scnprintf = { [2] = SCA_INT, /* cpu */
-			     [3] = SCA_FD,  /* group_fd */
-			     [4] = SCA_PERF_FLAGS,  /* flags */ }, },
+	  .arg = { [2] = { .scnprintf = SCA_INT,	/* cpu */ },
+		   [3] = { .scnprintf = SCA_FD,		/* group_fd */ },
+		   [4] = { .scnprintf = SCA_PERF_FLAGS, /* flags */ }, }, },
 	{ .name	    = "pipe2",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_PIPE_FLAGS, /* flags */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_PIPE_FLAGS, /* flags */ }, }, },
 	{ .name	    = "poll",	    .errmsg = true, .timeout = true, },
 	{ .name	    = "ppoll",	    .errmsg = true, .timeout = true, },
 	{ .name	    = "pread",	    .errmsg = true, .alias = "pread64", },
 	{ .name	    = "preadv",	    .errmsg = true, .alias = "pread", },
-	{ .name	    = "prlimit64",  .errmsg = true, STRARRAY(1, resource, rlimit_resources), },
+	{ .name	    = "prlimit64",  .errmsg = true,
+	  .arg = { [1] = STRARRAY(resource, rlimit_resources), }, },
 	{ .name	    = "pwrite",	    .errmsg = true, .alias = "pwrite64", },
 	{ .name	    = "pwritev",    .errmsg = true, },
 	{ .name	    = "read",	    .errmsg = true, },
 	{ .name	    = "readlink",   .errmsg = true, },
 	{ .name	    = "readlinkat", .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* dfd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "readv",	    .errmsg = true, },
 	{ .name	    = "recvfrom",   .errmsg = true,
-	  .arg_scnprintf = { [3] = SCA_MSG_FLAGS, /* flags */ }, },
+	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "recvmmsg",   .errmsg = true,
-	  .arg_scnprintf = { [3] = SCA_MSG_FLAGS, /* flags */ }, },
+	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "recvmsg",    .errmsg = true,
-	  .arg_scnprintf = { [2] = SCA_MSG_FLAGS, /* flags */ }, },
+	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "removexattr", .errmsg = true, },
 	{ .name	    = "renameat",   .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* dfd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "rmdir",    .errmsg = true, },
 	{ .name	    = "rt_sigaction", .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_SIGNUM, /* sig */ }, },
-	{ .name	    = "rt_sigprocmask",  .errmsg = true, STRARRAY(0, how, sighow), },
+	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
+	{ .name	    = "rt_sigprocmask",  .errmsg = true,
+	  .arg = { [0] = STRARRAY(how, sighow), }, },
 	{ .name	    = "rt_sigqueueinfo", .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_SIGNUM, /* sig */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "rt_tgsigqueueinfo", .errmsg = true,
-	  .arg_scnprintf = { [2] = SCA_SIGNUM, /* sig */ }, },
+	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "sched_getattr",	      .errmsg = true, },
 	{ .name	    = "sched_setattr",	      .errmsg = true, },
 	{ .name	    = "sched_setscheduler",   .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_SCHED_POLICY, /* policy */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_SCHED_POLICY, /* policy */ }, }, },
 	{ .name	    = "seccomp", .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_SECCOMP_OP, /* op */
-			     [1] = SCA_SECCOMP_FLAGS, /* flags */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_SECCOMP_OP,	   /* op */ },
+		   [1] = { .scnprintf = SCA_SECCOMP_FLAGS, /* flags */ }, }, },
 	{ .name	    = "select",	    .errmsg = true, .timeout = true, },
 	{ .name	    = "sendmmsg",    .errmsg = true,
-	  .arg_scnprintf = { [3] = SCA_MSG_FLAGS, /* flags */ }, },
+	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "sendmsg",    .errmsg = true,
-	  .arg_scnprintf = { [2] = SCA_MSG_FLAGS, /* flags */ }, },
+	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "sendto",	    .errmsg = true,
-	  .arg_scnprintf = { [3] = SCA_MSG_FLAGS, /* flags */ }, },
+	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "set_tid_address", .errpid = true, },
-	{ .name	    = "setitimer",  .errmsg = true, STRARRAY(0, which, itimers), },
+	{ .name	    = "setitimer",  .errmsg = true,
+	  .arg = { [0] = STRARRAY(which, itimers), }, },
 	{ .name	    = "setpgid",    .errmsg = true, },
-	{ .name	    = "setrlimit",  .errmsg = true, STRARRAY(0, resource, rlimit_resources), },
+	{ .name	    = "setrlimit",  .errmsg = true,
+	  .arg = { [0] = STRARRAY(resource, rlimit_resources), }, },
 	{ .name	    = "setxattr",   .errmsg = true, },
 	{ .name	    = "shutdown",   .errmsg = true, },
 	{ .name	    = "socket",	    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_STRARRAY, /* family */
-			     [1] = SCA_SK_TYPE, /* type */ },
-	  .arg_parm	 = { [0] = &strarray__socket_families, /* family */ }, },
+	  .arg = { [0] = STRARRAY(family, socket_families),
+		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ }, }, },
 	{ .name	    = "socketpair", .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_STRARRAY, /* family */
-			     [1] = SCA_SK_TYPE, /* type */ },
-	  .arg_parm	 = { [0] = &strarray__socket_families, /* family */ }, },
+	  .arg = { [0] = STRARRAY(family, socket_families),
+		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ }, }, },
 	{ .name	    = "stat",	    .errmsg = true, .alias = "newstat", },
 	{ .name	    = "statfs",	    .errmsg = true, },
 	{ .name	    = "statx",	    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* flags */
-			     [2] = SCA_STATX_FLAGS, /* flags */
-			     [3] = SCA_STATX_MASK, /* mask */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT,	 /* fdat */ },
+		   [2] = { .scnprintf = SCA_STATX_FLAGS, /* flags */ } ,
+		   [3] = { .scnprintf = SCA_STATX_MASK,	 /* mask */ }, }, },
 	{ .name	    = "swapoff",    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FILENAME, /* specialfile */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* specialfile */ }, }, },
 	{ .name	    = "swapon",	    .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FILENAME, /* specialfile */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* specialfile */ }, }, },
 	{ .name	    = "symlinkat",  .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* dfd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "tgkill",	    .errmsg = true,
-	  .arg_scnprintf = { [2] = SCA_SIGNUM, /* sig */ }, },
+	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "tkill",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_SIGNUM, /* sig */ }, },
+	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "truncate",   .errmsg = true, },
 	{ .name	    = "uname",	    .errmsg = true, .alias = "newuname", },
 	{ .name	    = "unlinkat",   .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* dfd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "utime",  .errmsg = true, },
 	{ .name	    = "utimensat",  .errmsg = true,
-	  .arg_scnprintf = { [0] = SCA_FDAT, /* dirfd */ }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dirfd */ }, }, },
 	{ .name	    = "utimes",  .errmsg = true, },
 	{ .name	    = "vmsplice",  .errmsg = true, },
 	{ .name	    = "wait4",	    .errpid = true,
-	  .arg_scnprintf = { [2] = SCA_WAITID_OPTIONS, /* options */ }, },
+	  .arg = { [2] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
 	{ .name	    = "waitid",	    .errpid = true,
-	  .arg_scnprintf = { [3] = SCA_WAITID_OPTIONS, /* options */ }, },
+	  .arg = { [3] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
 	{ .name	    = "write",	    .errmsg = true, },
 	{ .name	    = "writev",	    .errmsg = true, },
 };
@@ -859,8 +870,7 @@ struct syscall {
 	const char	    *name;
 	bool		    is_exit;
 	struct syscall_fmt  *fmt;
-	size_t		    (**arg_scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
-	void		    **arg_parm;
+	struct syscall_arg_fmt *arg_fmt;
 };
 
 /*
@@ -1209,27 +1219,29 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 	struct format_field *field;
 	int idx = 0, len;
 
-	sc->arg_scnprintf = calloc(sc->nr_args, sizeof(void *));
-	if (sc->arg_scnprintf == NULL)
+	sc->arg_fmt = calloc(sc->nr_args, sizeof(*sc->arg_fmt));
+	if (sc->arg_fmt == NULL)
 		return -1;
 
-	if (sc->fmt)
-		sc->arg_parm = sc->fmt->arg_parm;
+	for (field = sc->args; field; field = field->next, ++idx) {
+		if (sc->fmt) {
+			sc->arg_fmt[idx] = sc->fmt->arg[idx];
+
+			if (sc->fmt->arg[idx].scnprintf)
+				continue;
+		}
 
-	for (field = sc->args; field; field = field->next) {
-		if (sc->fmt && sc->fmt->arg_scnprintf[idx])
-			sc->arg_scnprintf[idx] = sc->fmt->arg_scnprintf[idx];
-		else if (strcmp(field->type, "const char *") == 0 &&
+		if (strcmp(field->type, "const char *") == 0 &&
 			 (strcmp(field->name, "filename") == 0 ||
 			  strcmp(field->name, "path") == 0 ||
 			  strcmp(field->name, "pathname") == 0))
-			sc->arg_scnprintf[idx] = SCA_FILENAME;
+			sc->arg_fmt[idx].scnprintf = SCA_FILENAME;
 		else if (field->flags & FIELD_IS_POINTER)
-			sc->arg_scnprintf[idx] = syscall_arg__scnprintf_hex;
+			sc->arg_fmt[idx].scnprintf = syscall_arg__scnprintf_hex;
 		else if (strcmp(field->type, "pid_t") == 0)
-			sc->arg_scnprintf[idx] = SCA_PID;
+			sc->arg_fmt[idx].scnprintf = SCA_PID;
 		else if (strcmp(field->type, "umode_t") == 0)
-			sc->arg_scnprintf[idx] = SCA_MODE_T;
+			sc->arg_fmt[idx].scnprintf = SCA_MODE_T;
 		else if ((strcmp(field->type, "int") == 0 ||
 			  strcmp(field->type, "unsigned int") == 0 ||
 			  strcmp(field->type, "long") == 0) &&
@@ -1242,9 +1254,8 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 			 * 23 unsigned int
 			 * 7 unsigned long
 			 */
-			sc->arg_scnprintf[idx] = SCA_FD;
+			sc->arg_fmt[idx].scnprintf = SCA_FD;
 		}
-		++idx;
 	}
 
 	return 0;
@@ -1416,20 +1427,19 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
  			 * strarray for it.
  			 */
 			if (val == 0 &&
-			    !(sc->arg_scnprintf &&
-			      (sc->arg_scnprintf[arg.idx] == SCA_STRARRAY ||
-			       sc->arg_scnprintf[arg.idx] == SCA_STRARRAYS) &&
-			      sc->arg_parm[arg.idx]))
+			    !(sc->arg_fmt &&
+			      (sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
+			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAYS) &&
+			      sc->arg_fmt[arg.idx].parm))
 				continue;
 
 			printed += scnprintf(bf + printed, size - printed,
 					     "%s%s: ", printed ? ", " : "", field->name);
-			if (sc->arg_scnprintf && sc->arg_scnprintf[arg.idx]) {
+			if (sc->arg_fmt && sc->arg_fmt[arg.idx].scnprintf) {
 				arg.val = val;
-				if (sc->arg_parm)
-					arg.parm = sc->arg_parm[arg.idx];
-				printed += sc->arg_scnprintf[arg.idx](bf + printed,
-								      size - printed, &arg);
+				if (sc->arg_fmt[arg.idx].parm)
+					arg.parm = sc->arg_fmt[arg.idx].parm;
+				printed += sc->arg_fmt[arg.idx].scnprintf(bf + printed, size - printed, &arg);
 			} else {
 				printed += scnprintf(bf + printed, size - printed,
 						     "%ld", val);
-- 
2.9.4
