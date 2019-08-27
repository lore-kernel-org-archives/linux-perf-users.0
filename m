From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/33] perf augmented_raw_syscalls: Reduce perf_event_output() boilerplate
Date: Mon, 26 Aug 2019 22:36:13 -0300
Message-ID: <20190827013634.3173-13-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add a augmented__output() helper to reduce the boilerplate of sending
the augmented tracepoint to the PERF_EVENT_ARRAY BPF map associated with
the bpf-output event used to communicate with the userspace perf trace
tool.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ln99gt0j4fv0kw0778h6vphm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 8fd5ea059903..b80437971d80 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -87,6 +87,12 @@ static inline struct augmented_args_payload *augmented_args_payload(void)
 	return bpf_map_lookup_elem(&augmented_args_tmp, &key);
 }
 
+static inline int augmented__output(void *ctx, struct augmented_args_payload *args, int len)
+{
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
+}
+
 static inline
 unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
 {
@@ -142,8 +148,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 
 	probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len + socklen);
+	return augmented__output(args, augmented_args, len + socklen);
 }
 
 SEC("!syscalls:sys_enter_sendto")
@@ -162,8 +167,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 
 	probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len + socklen);
+	return augmented__output(args, augmented_args, len + socklen);
 }
 
 SEC("!syscalls:sys_enter_open")
@@ -178,8 +182,7 @@ int sys_enter_open(struct syscall_enter_args *args)
 
 	len += augmented_arg__read_str(&augmented_args->arg, filename_arg, sizeof(augmented_args->arg.value));
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+	return augmented__output(args, augmented_args, len);
 }
 
 SEC("!syscalls:sys_enter_openat")
@@ -194,8 +197,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
 
 	len += augmented_arg__read_str(&augmented_args->arg, filename_arg, sizeof(augmented_args->arg.value));
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+	return augmented__output(args, augmented_args, len);
 }
 
 SEC("!syscalls:sys_enter_rename")
@@ -212,8 +214,7 @@ int sys_enter_rename(struct syscall_enter_args *args)
 	oldpath_len = augmented_arg__read_str(&augmented_args->arg, oldpath_arg, sizeof(augmented_args->arg.value));
 	len += oldpath_len + augmented_arg__read_str((void *)(&augmented_args->arg) + oldpath_len, newpath_arg, sizeof(augmented_args->arg.value));
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+	return augmented__output(args, augmented_args, len);
 }
 
 SEC("!syscalls:sys_enter_renameat")
@@ -230,8 +231,7 @@ int sys_enter_renameat(struct syscall_enter_args *args)
 	oldpath_len = augmented_arg__read_str(&augmented_args->arg, oldpath_arg, sizeof(augmented_args->arg.value));
 	len += oldpath_len + augmented_arg__read_str((void *)(&augmented_args->arg) + oldpath_len, newpath_arg, sizeof(augmented_args->arg.value));
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+	return augmented__output(args, augmented_args, len);
 }
 
 SEC("raw_syscalls:sys_enter")
-- 
2.21.0
