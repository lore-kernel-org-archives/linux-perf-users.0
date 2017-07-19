From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 62/86] perf trace beauty: Simplify syscall return formatting
Date: Wed, 19 Jul 2017 11:29:26 -0300
Message-ID: <20170719142950.3747-63-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Removing syscall_fmt::err_msg and instead always formatting negative
returns as errno values.

With this we can remove a lot of entries that have no special handling
besides the ones we can do by looking at the tracefs format files, i.e.
the types for the fields (e.g. pid_t), well known names (e.g. fd).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-rg9u7a3qqdnzo37d212vnz2o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 209 ++++++++++++++++++---------------------------
 1 file changed, 81 insertions(+), 128 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bab87f612a36..1e4c0657b712 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -611,77 +611,53 @@ static struct syscall_fmt {
 	const char *name;
 	const char *alias;
 	struct syscall_arg_fmt arg[6];
-	bool	   errmsg;
 	bool	   errpid;
 	bool	   timeout;
 	bool	   hexret;
 } syscall_fmts[] = {
-	{ .name	    = "access",	    .errmsg = true,
+	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
-	{ .name	    = "arch_prctl", .errmsg = true, .alias = "prctl", },
-	{ .name	    = "bpf",	    .errmsg = true,
+	{ .name	    = "arch_prctl", .alias = "prctl", },
+	{ .name	    = "bpf",
 	  .arg = { [0] = STRARRAY(cmd, bpf_cmd), }, },
 	{ .name	    = "brk",	    .hexret = true,
 	  .arg = { [0] = { .scnprintf = SCA_HEX, /* brk */ }, }, },
-	{ .name	    = "chdir",	    .errmsg = true, },
-	{ .name	    = "chmod",	    .errmsg = true, },
-	{ .name	    = "chroot",	    .errmsg = true, },
-	{ .name     = "clock_gettime", .errmsg = true,
+	{ .name     = "clock_gettime",
 	  .arg = { [0] = STRARRAY(clk_id, clockid), }, },
 	{ .name	    = "clone",	    .errpid = true, },
-	{ .name	    = "close",	    .errmsg = true,
+	{ .name	    = "close",
 	  .arg = { [0] = { .scnprintf = SCA_CLOSE_FD, /* fd */ }, }, },
-	{ .name	    = "connect",    .errmsg = true, },
-	{ .name	    = "creat",	    .errmsg = true, },
-	{ .name	    = "dup",	    .errmsg = true, },
-	{ .name	    = "dup2",	    .errmsg = true, },
-	{ .name	    = "dup3",	    .errmsg = true, },
-	{ .name	    = "epoll_ctl",  .errmsg = true,
+	{ .name	    = "epoll_ctl",
 	  .arg = { [1] = STRARRAY(op, epoll_ctl_ops), }, },
-	{ .name	    = "eventfd2",   .errmsg = true,
+	{ .name	    = "eventfd2",
 	  .arg = { [1] = { .scnprintf = SCA_EFD_FLAGS, /* flags */ }, }, },
-	{ .name	    = "faccessat",  .errmsg = true, },
-	{ .name	    = "fadvise64",  .errmsg = true, },
-	{ .name	    = "fallocate",  .errmsg = true, },
-	{ .name	    = "fchdir",	    .errmsg = true, },
-	{ .name	    = "fchmod",	    .errmsg = true, },
-	{ .name	    = "fchmodat",   .errmsg = true,
+	{ .name	    = "fchmodat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
-	{ .name	    = "fchown",	    .errmsg = true, },
-	{ .name	    = "fchownat",   .errmsg = true,
+	{ .name	    = "fchownat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
-	{ .name	    = "fcntl",	    .errmsg = true,
+	{ .name	    = "fcntl",
 	  .arg = { [1] = { .scnprintf = SCA_FCNTL_CMD, /* cmd */
 			   .parm      = &strarrays__fcntl_cmds_arrays,
 			   .show_zero = true, },
 		   [2] = { .scnprintf =  SCA_FCNTL_ARG, /* arg */ }, }, },
-	{ .name	    = "fdatasync",  .errmsg = true, },
-	{ .name	    = "flock",	    .errmsg = true,
+	{ .name	    = "flock",
 	  .arg = { [1] = { .scnprintf = SCA_FLOCK, /* cmd */ }, }, },
-	{ .name	    = "fsetxattr",  .errmsg = true, },
-	{ .name	    = "fstat",	    .errmsg = true, .alias = "newfstat", },
-	{ .name	    = "fstatat",    .errmsg = true, .alias = "newfstatat", },
-	{ .name	    = "fstatfs",    .errmsg = true, },
-	{ .name	    = "fsync",    .errmsg = true, },
-	{ .name	    = "ftruncate", .errmsg = true, },
-	{ .name	    = "futex",	    .errmsg = true,
+	{ .name	    = "fstat", .alias = "newfstat", },
+	{ .name	    = "fstatat", .alias = "newfstatat", },
+	{ .name	    = "futex",
 	  .arg = { [1] = { .scnprintf = SCA_FUTEX_OP, /* op */ }, }, },
-	{ .name	    = "futimesat", .errmsg = true,
+	{ .name	    = "futimesat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
-	{ .name	    = "getdents",   .errmsg = true, },
-	{ .name	    = "getdents64", .errmsg = true, },
-	{ .name	    = "getitimer",  .errmsg = true,
+	{ .name	    = "getitimer",
 	  .arg = { [0] = STRARRAY(which, itimers), }, },
 	{ .name	    = "getpid",	    .errpid = true, },
 	{ .name	    = "getpgid",    .errpid = true, },
 	{ .name	    = "getppid",    .errpid = true, },
-	{ .name	    = "getrandom",  .errmsg = true,
+	{ .name	    = "getrandom",
 	  .arg = { [2] = { .scnprintf = SCA_GETRANDOM_FLAGS, /* flags */ }, }, },
-	{ .name	    = "getrlimit",  .errmsg = true,
+	{ .name	    = "getrlimit",
 	  .arg = { [0] = STRARRAY(resource, rlimit_resources), }, },
-	{ .name	    = "getxattr",   .errmsg = true, },
-	{ .name	    = "inotify_add_watch", .errmsg = true, },
-	{ .name	    = "ioctl",	    .errmsg = true,
+	{ .name	    = "ioctl",
 	  .arg = {
 #if defined(__i386__) || defined(__x86_64__)
 /*
@@ -693,34 +669,25 @@ static struct syscall_fmt {
 #else
 		   [2] = { .scnprintf = SCA_HEX, /* arg */ }, }, },
 #endif
-	{ .name	    = "keyctl",	    .errmsg = true,
+	{ .name	    = "keyctl",
 	  .arg = { [0] = STRARRAY(option, keyctl_options), }, },
-	{ .name	    = "kill",	    .errmsg = true,
+	{ .name	    = "kill",
 	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
-	{ .name	    = "lchown",    .errmsg = true, },
-	{ .name	    = "lgetxattr",  .errmsg = true, },
-	{ .name	    = "linkat",	    .errmsg = true,
+	{ .name	    = "linkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
-	{ .name	    = "listxattr",  .errmsg = true, },
-	{ .name	    = "llistxattr", .errmsg = true, },
-	{ .name	    = "lremovexattr",  .errmsg = true, },
-	{ .name	    = "lseek",	    .errmsg = true,
+	{ .name	    = "lseek",
 	  .arg = { [2] = STRARRAY(whence, whences), }, },
-	{ .name	    = "lsetxattr",  .errmsg = true, },
-	{ .name	    = "lstat",	    .errmsg = true, .alias = "newlstat", },
-	{ .name	    = "lsxattr",    .errmsg = true, },
-	{ .name     = "madvise",    .errmsg = true,
+	{ .name	    = "lstat", .alias = "newlstat", },
+	{ .name     = "madvise",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,      /* start */ },
 		   [2] = { .scnprintf = SCA_MADV_BHV, /* behavior */ }, }, },
-	{ .name	    = "mkdir",    .errmsg = true, },
-	{ .name	    = "mkdirat",    .errmsg = true,
+	{ .name	    = "mkdirat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
-	{ .name	    = "mknod",      .errmsg = true, },
-	{ .name	    = "mknodat",    .errmsg = true,
+	{ .name	    = "mknodat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
-	{ .name	    = "mlock",	    .errmsg = true,
+	{ .name	    = "mlock",
 	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
-	{ .name	    = "mlockall",   .errmsg = true,
+	{ .name	    = "mlockall",
 	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
 	{ .name	    = "mmap",	    .hexret = true,
 /* The standard mmap maps to old_mmap on s390x */
@@ -730,127 +697,109 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* addr */ },
 		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
 		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
-	{ .name	    = "mprotect",   .errmsg = true,
+	{ .name	    = "mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
 		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ }, }, },
-	{ .name	    = "mq_unlink", .errmsg = true,
+	{ .name	    = "mq_unlink",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* u_name */ }, }, },
 	{ .name	    = "mremap",	    .hexret = true,
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	  /* addr */ },
 		   [3] = { .scnprintf = SCA_MREMAP_FLAGS, /* flags */ },
 		   [4] = { .scnprintf = SCA_HEX,	  /* new_addr */ }, }, },
-	{ .name	    = "munlock",    .errmsg = true,
+	{ .name	    = "munlock",
 	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
-	{ .name	    = "munmap",	    .errmsg = true,
+	{ .name	    = "munmap",
 	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
-	{ .name	    = "name_to_handle_at", .errmsg = true,
+	{ .name	    = "name_to_handle_at",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
-	{ .name	    = "newfstatat", .errmsg = true,
+	{ .name	    = "newfstatat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
-	{ .name	    = "open",	    .errmsg = true,
+	{ .name	    = "open",
 	  .arg = { [1] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
-	{ .name	    = "open_by_handle_at", .errmsg = true,
+	{ .name	    = "open_by_handle_at",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
 		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
-	{ .name	    = "openat",	    .errmsg = true,
+	{ .name	    = "openat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
 		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
-	{ .name	    = "perf_event_open", .errmsg = true,
+	{ .name	    = "perf_event_open",
 	  .arg = { [2] = { .scnprintf = SCA_INT,	/* cpu */ },
 		   [3] = { .scnprintf = SCA_FD,		/* group_fd */ },
 		   [4] = { .scnprintf = SCA_PERF_FLAGS, /* flags */ }, }, },
-	{ .name	    = "pipe2",	    .errmsg = true,
+	{ .name	    = "pipe2",
 	  .arg = { [1] = { .scnprintf = SCA_PIPE_FLAGS, /* flags */ }, }, },
-	{ .name	    = "poll",	    .errmsg = true, .timeout = true, },
-	{ .name	    = "ppoll",	    .errmsg = true, .timeout = true, },
-	{ .name	    = "pread",	    .errmsg = true, .alias = "pread64", },
-	{ .name	    = "preadv",	    .errmsg = true, .alias = "pread", },
-	{ .name	    = "prlimit64",  .errmsg = true,
+	{ .name	    = "poll", .timeout = true, },
+	{ .name	    = "ppoll", .timeout = true, },
+	{ .name	    = "pread", .alias = "pread64", },
+	{ .name	    = "preadv", .alias = "pread", },
+	{ .name	    = "prlimit64",
 	  .arg = { [1] = STRARRAY(resource, rlimit_resources), }, },
-	{ .name	    = "pwrite",	    .errmsg = true, .alias = "pwrite64", },
-	{ .name	    = "pwritev",    .errmsg = true, },
-	{ .name	    = "read",	    .errmsg = true, },
-	{ .name	    = "readlink",   .errmsg = true, },
-	{ .name	    = "readlinkat", .errmsg = true,
+	{ .name	    = "pwrite", .alias = "pwrite64", },
+	{ .name	    = "readlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
-	{ .name	    = "readv",	    .errmsg = true, },
-	{ .name	    = "recvfrom",   .errmsg = true,
+	{ .name	    = "recvfrom",
 	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
-	{ .name	    = "recvmmsg",   .errmsg = true,
+	{ .name	    = "recvmmsg",
 	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
-	{ .name	    = "recvmsg",    .errmsg = true,
+	{ .name	    = "recvmsg",
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
-	{ .name	    = "removexattr", .errmsg = true, },
-	{ .name	    = "renameat",   .errmsg = true,
+	{ .name	    = "renameat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
-	{ .name	    = "rmdir",    .errmsg = true, },
-	{ .name	    = "rt_sigaction", .errmsg = true,
+	{ .name	    = "rt_sigaction",
 	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
-	{ .name	    = "rt_sigprocmask",  .errmsg = true,
+	{ .name	    = "rt_sigprocmask",
 	  .arg = { [0] = STRARRAY(how, sighow), }, },
-	{ .name	    = "rt_sigqueueinfo", .errmsg = true,
+	{ .name	    = "rt_sigqueueinfo",
 	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
-	{ .name	    = "rt_tgsigqueueinfo", .errmsg = true,
+	{ .name	    = "rt_tgsigqueueinfo",
 	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
-	{ .name	    = "sched_getattr",	      .errmsg = true, },
-	{ .name	    = "sched_setattr",	      .errmsg = true, },
-	{ .name	    = "sched_setscheduler",   .errmsg = true,
+	{ .name	    = "sched_setscheduler",
 	  .arg = { [1] = { .scnprintf = SCA_SCHED_POLICY, /* policy */ }, }, },
-	{ .name	    = "seccomp", .errmsg = true,
+	{ .name	    = "seccomp",
 	  .arg = { [0] = { .scnprintf = SCA_SECCOMP_OP,	   /* op */ },
 		   [1] = { .scnprintf = SCA_SECCOMP_FLAGS, /* flags */ }, }, },
-	{ .name	    = "select",	    .errmsg = true, .timeout = true, },
-	{ .name	    = "sendmmsg",    .errmsg = true,
+	{ .name	    = "select", .timeout = true, },
+	{ .name	    = "sendmmsg",
 	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
-	{ .name	    = "sendmsg",    .errmsg = true,
+	{ .name	    = "sendmsg",
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
-	{ .name	    = "sendto",	    .errmsg = true,
+	{ .name	    = "sendto",
 	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "set_tid_address", .errpid = true, },
-	{ .name	    = "setitimer",  .errmsg = true,
+	{ .name	    = "setitimer",
 	  .arg = { [0] = STRARRAY(which, itimers), }, },
-	{ .name	    = "setpgid",    .errmsg = true, },
-	{ .name	    = "setrlimit",  .errmsg = true,
+	{ .name	    = "setrlimit",
 	  .arg = { [0] = STRARRAY(resource, rlimit_resources), }, },
-	{ .name	    = "setxattr",   .errmsg = true, },
-	{ .name	    = "shutdown",   .errmsg = true, },
-	{ .name	    = "socket",	    .errmsg = true,
+	{ .name	    = "socket",
 	  .arg = { [0] = STRARRAY(family, socket_families),
 		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ }, }, },
-	{ .name	    = "socketpair", .errmsg = true,
+	{ .name	    = "socketpair",
 	  .arg = { [0] = STRARRAY(family, socket_families),
 		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ }, }, },
-	{ .name	    = "stat",	    .errmsg = true, .alias = "newstat", },
-	{ .name	    = "statfs",	    .errmsg = true, },
-	{ .name	    = "statx",	    .errmsg = true,
+	{ .name	    = "stat", .alias = "newstat", },
+	{ .name	    = "statx",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	 /* fdat */ },
 		   [2] = { .scnprintf = SCA_STATX_FLAGS, /* flags */ } ,
 		   [3] = { .scnprintf = SCA_STATX_MASK,	 /* mask */ }, }, },
-	{ .name	    = "swapoff",    .errmsg = true,
+	{ .name	    = "swapoff",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* specialfile */ }, }, },
-	{ .name	    = "swapon",	    .errmsg = true,
+	{ .name	    = "swapon",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* specialfile */ }, }, },
-	{ .name	    = "symlinkat",  .errmsg = true,
+	{ .name	    = "symlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
-	{ .name	    = "tgkill",	    .errmsg = true,
+	{ .name	    = "tgkill",
 	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
-	{ .name	    = "tkill",	    .errmsg = true,
+	{ .name	    = "tkill",
 	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
-	{ .name	    = "truncate",   .errmsg = true, },
-	{ .name	    = "uname",	    .errmsg = true, .alias = "newuname", },
-	{ .name	    = "unlinkat",   .errmsg = true,
+	{ .name	    = "uname", .alias = "newuname", },
+	{ .name	    = "unlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
-	{ .name	    = "utime",  .errmsg = true, },
-	{ .name	    = "utimensat",  .errmsg = true,
+	{ .name	    = "utimensat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dirfd */ }, }, },
-	{ .name	    = "utimes",  .errmsg = true, },
-	{ .name	    = "vmsplice",  .errmsg = true, },
 	{ .name	    = "wait4",	    .errpid = true,
 	  .arg = { [2] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
 	{ .name	    = "waitid",	    .errpid = true,
 	  .arg = { [3] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
-	{ .name	    = "write",	    .errmsg = true, },
-	{ .name	    = "writev",	    .errmsg = true, },
 };
 
 static int syscall_fmt__cmp(const void *name, const void *fmtp)
@@ -1708,14 +1657,18 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 	}
 
 	if (sc->fmt == NULL) {
+		if (ret < 0)
+			goto errno_print;
 signed_print:
-		fprintf(trace->output, ") = %ld", ret);
-	} else if (ret < 0 && (sc->fmt->errmsg || sc->fmt->errpid)) {
+		fprintf(trace->output, ") %ld", ret);
+	} else if (ret < 0) {
+errno_print: {
 		char bf[STRERR_BUFSIZE];
 		const char *emsg = str_error_r(-ret, bf, sizeof(bf)),
 			   *e = audit_errno_to_name(-ret);
 
 		fprintf(trace->output, ") = -1 %s %s", e, emsg);
+	}
 	} else if (ret == 0 && sc->fmt->timeout)
 		fprintf(trace->output, ") = 0 Timeout");
 	else if (ttrace->ret_scnprintf) {
-- 
2.9.4
