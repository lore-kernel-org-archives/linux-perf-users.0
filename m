From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/77] perf trace: Augment 'newstat' (aka 'stat') filename ptr
Date: Wed,  5 Sep 2018 19:03:33 -0300
Message-ID: <20180905220440.20256-11-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This one will need some more work, that 'statbuf' pointer requires a
beautifier in 'perf trace'.

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c
     0.000 weechat/3596 stat(filename: /etc/localtime, statbuf: 0x7ffd87d11f60)
     0.186 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_stat/format)
     0.279 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_newstat/for)
     0.670 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/form)
    60.805 DNS Res~er #20/21308 stat(filename: /etc/resolv.conf, statbuf: 0x7ffa733fe4a0)
    60.836 DNS Res~er #20/21308 open(filename: /etc/hosts, flags: CLOEXEC)
    60.931 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_open/format)
   607.070 DNS Res~er #21/29812 stat(filename: /etc/resolv.conf, statbuf: 0x7ffa5e1fe3f0)
   607.098 DNS Res~er #21/29812 open(filename: /etc/hosts, flags: CLOEXEC)
   999.336 weechat/3596 stat(filename: /etc/localtime, statbuf: 0x7ffd87d11f60)
^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4lhabe7m4uzo76lnqpyfmnvk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index e8486e8597de..a9695c7f7aab 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -83,4 +83,15 @@ struct syscall_enter_inotify_add_watch_args {
 
 augmented_filename_syscall_enter(inotify_add_watch);
 
+struct statbuf;
+
+struct syscall_enter_newstat_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	char		   *filename_ptr;
+	struct stat	   *statbuf;
+};
+
+augmented_filename_syscall_enter(newstat);
+
 license(GPL);
-- 
2.14.4
