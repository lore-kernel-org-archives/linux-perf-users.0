From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/29] perf augmented_syscalls: Convert to bpf_map()
Date: Sat, 26 Jan 2019 00:18:43 +0100
Message-ID: <20190125231843.2895-30-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To make the code more compact, end result is the same:

  # perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_syscalls.c sleep 1
     0.000 ( 0.008 ms): sleep/9663 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
     0.022 ( 0.005 ms): sleep/9663 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
     0.226 ( 0.006 ms): sleep/9663 openat(dfd: CWD, filename: "/usr/lib/locale/locale-archive", flags: RDONLY|CLOEXEC) = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-23z08bgizqnbc3qdsyl7jyyg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index b7dba114e36c..524fdb8534b3 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -19,12 +19,8 @@
 #include <stdio.h>
 #include <linux/socket.h>
 
-struct bpf_map SEC("maps") __augmented_syscalls__ = {
-       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
-       .key_size = sizeof(int),
-       .value_size = sizeof(u32),
-       .max_entries = __NR_CPUS__,
-};
+/* bpf-output associated map */
+bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
 
 struct syscall_exit_args {
 	unsigned long long common_tp_fields;
-- 
2.20.1
