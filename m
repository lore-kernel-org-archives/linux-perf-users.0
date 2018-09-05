From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/77] perf trace: Augment inotify_add_watch pathname syscall arg
Date: Wed,  5 Sep 2018 19:03:31 -0300
Message-ID: <20180905220440.20256-9-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Again, just changing tools/perf/examples/bpf/augmented_syscalls.c, that
is starting to have too much boilerplate, some macro will come to the
rescue.

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c
     0.000 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /var/cache/app-info/yaml, mask: 16789454)
     0.023 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /var/lib/app-info/xmls, mask: 16789454)
     0.028 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /var/lib/app-info/yaml, mask: 16789454)
     0.032 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /usr/share/app-info/yaml, mask: 16789454)
     0.039 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /usr/local/share/app-info/xmls, mask: 16789454)
     0.045 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /usr/local/share/app-info/yaml, mask: 16789454)
     0.049 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /home/acme/.local/share/app-info/yaml, mask: 16789454)
     0.056 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: , mask: 16789454)
     0.010 gmain/2245 inotify_add_watch(fd: 7<anon_inode:inotify>, pathname: /home/acme/~, mask: 16789454)
     0.087 perf/20116 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_inotify_add)
     0.436 perf/20116 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/form)
    56.042 gmain/2791 inotify_add_watch(fd: 4<anon_inode:inotify>, pathname: /var/lib/fwupd/remotes.d/lvfs-testing, mask: 16789454)
   113.986 gmain/1721 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /var/lib/gdm/~, mask: 16789454)
  3777.265 gsd-color/2408 openat(dfd: CWD, filename: /etc/localtime)
  3777.550 gsd-color/2408 openat(dfd: CWD, filename: /etc/localtime)
^C[root@jouet perf]#

Still not combining raw_syscalls:sys_enter + raw_syscalls:sys_exit, to
get it strace-like, but that probably will come very naturally with some
more wiring up...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ol83juin2cht9vzquynec5hz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 154379463c95..6ec327850a15 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -88,4 +88,31 @@ int syscall_enter(open)(struct syscall_enter_open_args *args)
 	return 0;
 }
 
+struct syscall_enter_inotify_add_watch_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   fd;
+	char		   *pathname_ptr;
+	long		   mask;
+};
+
+struct augmented_enter_inotify_add_watch_args {
+	struct syscall_enter_inotify_add_watch_args args;
+	struct augmented_filename		    pathname;
+};
+
+int syscall_enter(inotify_add_watch)(struct syscall_enter_inotify_add_watch_args *args)
+{
+	struct augmented_enter_inotify_add_watch_args augmented_args = { .pathname.reserved = 0, };
+
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+	augmented_args.pathname.size = probe_read_str(&augmented_args.pathname.value,
+						      sizeof(augmented_args.pathname.value),
+						      args->pathname_ptr);
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
+			  &augmented_args,
+			  sizeof(augmented_args) - sizeof(augmented_args.pathname.value) + augmented_args.pathname.size);
+	return 0;
+}
+
 license(GPL);
-- 
2.14.4
