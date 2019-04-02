From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/44] perf trace: Add 'string' event alias to select syscalls with string args
Date: Tue,  2 Apr 2019 13:05:06 -0300
Message-ID: <20190402160549.13544-2-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used in conjunction with the change to augmented_raw_syscalls.c
in the next cset that adds all syscalls with a first or second arg
string.

With just what we have in the syscall tracepoints we get:

  # perf trace -e string ls > /dev/null
         ? (         ): ls/22382  ... [continued]: execve())                                           = 0
     0.043 ( 0.004 ms): ls/22382 access(filename: 0x51ad420, mode: R)                                  = -1 ENOENT (No such file or directory)
     0.051 ( 0.004 ms): ls/22382 openat(dfd: CWD, filename: 0x51aa8b3, flags: RDONLY|CLOEXEC)          = 3
     0.071 ( 0.004 ms): ls/22382 openat(dfd: CWD, filename: 0x51b4d00, flags: RDONLY|CLOEXEC)          = 3
     0.138 ( 0.009 ms): ls/22382 openat(dfd: CWD, filename: 0x51684d0, flags: RDONLY|CLOEXEC)          = 3
     0.192 ( 0.004 ms): ls/22382 openat(dfd: CWD, filename: 0x51689c0, flags: RDONLY|CLOEXEC)          = 3
     0.255 ( 0.004 ms): ls/22382 openat(dfd: CWD, filename: 0x5168eb0, flags: RDONLY|CLOEXEC)          = 3
     0.342 ( 0.003 ms): ls/22382 openat(dfd: CWD, filename: 0x51693a0, flags: RDONLY|CLOEXEC)          = 3
     0.380 ( 0.003 ms): ls/22382 openat(dfd: CWD, filename: 0x5169950, flags: RDONLY|CLOEXEC)          = 3
     0.670 ( 0.011 ms): ls/22382 statfs(pathname: 0x515c783, buf: 0x7fff54d75b70)                      = 0
     0.683 ( 0.005 ms): ls/22382 statfs(pathname: 0x515c783, buf: 0x7fff54d75a60)                      = 0
     0.725 ( 0.004 ms): ls/22382 access(filename: 0x515c7ab)                                           = 0
     0.744 ( 0.005 ms): ls/22382 openat(dfd: CWD, filename: 0x50fba20, flags: RDONLY|CLOEXEC)          = 3
     0.793 ( 0.004 ms): ls/22382 openat(dfd: CWD, filename: 0x9e3e8390, flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 3
     0.921 ( 0.006 ms): ls/22382 openat(dfd: CWD, filename: 0x50f7d90)                                 = 3
  #

If we put the vfs_getname probe point in place:

  # perf probe 'vfs_getname=getname_flags:73 pathname=result->name:string'
  Added new events:
    probe:vfs_getname    (on getname_flags:73 with pathname=result->name:string)
    probe:vfs_getname_1  (on getname_flags:73 with pathname=result->name:string)

  You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname_1 -aR sleep 1

  # perf trace -e string ls > /dev/null
         ? (         ): ls/22440  ... [continued]: execve())                                           = 0
     0.048 ( 0.008 ms): ls/22440 access(filename: /etc/ld.so.preload, mode: R)                         = -1 ENOENT (No such file or directory)
     0.061 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
     0.092 ( 0.008 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libselinux.so.1, flags: RDONLY|CLOEXEC) = 3
     0.165 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libcap.so.2, flags: RDONLY|CLOEXEC) = 3
     0.216 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDONLY|CLOEXEC)   = 3
     0.282 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libpcre2-8.so.0, flags: RDONLY|CLOEXEC) = 3
     0.340 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libdl.so.2, flags: RDONLY|CLOEXEC)  = 3
     0.383 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libpthread.so.0, flags: RDONLY|CLOEXEC) = 3
     0.697 ( 0.021 ms): ls/22440 statfs(pathname: /sys/fs/selinux, buf: 0x7ffee7dc9010)                = 0
     0.720 ( 0.007 ms): ls/22440 statfs(pathname: /sys/fs/selinux, buf: 0x7ffee7dc8f00)                = 0
     0.757 ( 0.007 ms): ls/22440 access(filename: /etc/selinux/config)                                 = 0
     0.779 ( 0.009 ms): ls/22440 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: RDONLY|CLOEXEC) = 3
     0.830 ( 0.006 ms): ls/22440 openat(dfd: CWD, filename: ., flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 3
     0.958 ( 0.010 ms): ls/22440 openat(dfd: CWD, filename: /usr/lib64/gconv/gconv-modules.cache)      = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6fh1myvn7ulf4xwq9iz3o776@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/strace/groups/string | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/perf/trace/strace/groups/string

diff --git a/tools/perf/trace/strace/groups/string b/tools/perf/trace/strace/groups/string
new file mode 100644
index 000000000000..c87129a3e3c4
--- /dev/null
+++ b/tools/perf/trace/strace/groups/string
@@ -0,0 +1,65 @@
+access
+acct
+add_key
+chdir
+chmod
+chown
+chroot
+creat
+delete_module
+execve
+execveat
+faccessat
+fchmodat
+fchownat
+fgetxattr
+finit_module
+fremovexattr
+fsetxattr
+futimesat
+getxattr
+inotify_add_watch
+lchown
+lgetxattr
+link
+linkat
+listxattr
+llistxattr
+lremovexattr
+lsetxattr
+lstat
+memfd_create
+mkdir
+mkdirat
+mknod
+mknodat
+mq_open
+mq_timedsend
+mq_unlink
+name_to_handle_at
+newfstatat
+open
+openat
+pivot_root
+pwrite64
+quotactl
+readlink
+readlinkat
+removexattr
+rename
+renameat
+renameat2
+request_key
+rmdir
+setxattr
+stat
+statfs
+statx
+swapoff
+swapon
+symlink
+symlinkat
+truncate
+unlink
+unlinkat
+utimensat
-- 
2.20.1
