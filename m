From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/37] perf augmented_raw_syscalls: Augment sockaddr arg in 'connect'
Date: Mon, 22 Jul 2019 14:38:23 -0300
Message-ID: <20190722173839.22898-22-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We already had a beautifier for an augmented sockaddr payload, but that
was when we were hooking on each syscalls:sys_enter_foo tracepoints,
since now we're almost doing that by doing a tail call from
raw_syscalls:sys_enter, its almost the same, we can reuse it straight
away.

  # perf trace -e connec* ssh www.bla.com
  connect(3</var/lib/sss/mc/passwd>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(3</var/lib/sss/mc/passwd>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(4<socket:[16604782]>, { .family: PF_LOCAL, path: /var/lib/sss/pipes/nss }, 0x6e) = 0
  connect(7, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(7, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(5</etc/hosts>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(5</etc/hosts>, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 0x6e) = -1 ENOENT (No such file or directory)
  connect(5</etc/hosts>, { .family: PF_INET, port: 53, addr: 192.168.44.1 }, 0x10) = 0
  connect(5</etc/hosts>, { .family: PF_INET, port: 22, addr: 146.112.61.108 }, 0x10) = 0
  connect(5</etc/hosts>, { .family: PF_INET6, port: 22, addr: ::ffff:146.112.61.108 }, 0x1c) = 0
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5xkrbcpjsgnr3zt1aqdd7nvc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 35 ++++++++++++++++---
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 77bb6a0edce3..d7a292d7ee2f 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -16,6 +16,7 @@
 
 #include <unistd.h>
 #include <linux/limits.h>
+#include <linux/socket.h>
 #include <pid_filter.h>
 
 /* bpf-output associated map */
@@ -69,10 +70,13 @@ pid_filter(pids_filtered);
 
 struct augmented_args_payload {
        struct syscall_enter_args args;
-       struct {
-	       struct augmented_filename filename;
-	       struct augmented_filename filename2;
-       };
+       union {
+		struct {
+			struct augmented_filename filename,
+						  filename2;
+		};
+		struct sockaddr_storage saddr;
+	};
 };
 
 bpf_map(augmented_args_tmp, PERCPU_ARRAY, int, struct augmented_args_payload, 1);
@@ -112,11 +116,32 @@ int syscall_unaugmented(struct syscall_enter_args *args)
 }
 
 /*
- * This will be tail_called from SEC("raw_syscalls:sys_enter"), so will find in
+ * These will be tail_called from SEC("raw_syscalls:sys_enter"), so will find in
  * augmented_args_tmp what was read by that raw_syscalls:sys_enter and go
  * on from there, reading the first syscall arg as a string, i.e. open's
  * filename.
  */
+SEC("!syscalls:sys_enter_connect")
+int sys_enter_connect(struct syscall_enter_args *args)
+{
+	int key = 0;
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	const void *sockaddr_arg = (const void *)args->args[1];
+	unsigned int socklen = args->args[2];
+	unsigned int len = sizeof(augmented_args->args);
+
+        if (augmented_args == NULL)
+                return 1; /* Failure: don't filter */
+
+	if (socklen > sizeof(augmented_args->saddr))
+		socklen = sizeof(augmented_args->saddr);
+
+	probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
+
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len + socklen);
+}
+
 SEC("!syscalls:sys_enter_open")
 int sys_enter_open(struct syscall_enter_args *args)
 {
-- 
2.21.0
