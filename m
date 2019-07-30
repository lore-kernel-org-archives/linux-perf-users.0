From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 020/107] perf trace beauty: Beautify 'sendto's sockaddr arg
Date: Mon, 29 Jul 2019 23:54:43 -0300
Message-ID: <20190730025610.22603-21-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

By just writing the collector in the augmented_raw_syscalls.c BPF
program:

  # perf trace -e sendto
  <SNIP>
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  Socket Thread/3573 sendto(247, 0x7fb32d49c000, 120, NONE, { .family: PF_UNSPEC }, NULL) = 120
  DNS Res~er #18/11374 sendto(242, 0x7fb342cfe420, 20, NONE, { .family: PF_NETLINK }, 0xc) = 20
  DNS Res~er #18/11374 sendto(242, 0x7fb342cfcca0, 42, MSG_NOSIGNAL, { .family: PF_UNSPEC }, NULL) = 42
  DNS Res~er #18/11374 sendto(242, 0x7fb342cfcccc, 42, MSG_NOSIGNAL, { .family: PF_UNSPEC }, NULL) = 42
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  Socket Thread/3573 sendto(242, 0x7fb308bb1c08, 296, NONE, { .family: PF_UNSPEC }, NULL) = 296
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ^C
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p0l0rlvq19v5zf8qc2x2itow@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index d7a292d7ee2f..9c2228b01ee6 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -142,6 +142,27 @@ int sys_enter_connect(struct syscall_enter_args *args)
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len + socklen);
 }
 
+SEC("!syscalls:sys_enter_sendto")
+int sys_enter_sendto(struct syscall_enter_args *args)
+{
+	int key = 0;
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	const void *sockaddr_arg = (const void *)args->args[4];
+	unsigned int socklen = args->args[5];
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
