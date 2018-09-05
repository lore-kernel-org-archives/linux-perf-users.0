From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/77] perf trace augmented_syscalls: Add augmented_sockaddr_syscall_enter()
Date: Wed,  5 Sep 2018 19:03:38 -0300
Message-ID: <20180905220440.20256-16-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

From the one for 'connect', so that we can use it with sendto and others
that receive a 'struct sockaddr'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8bdqv1q0ndcjl1nqns5r5je2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 46 ++++++++++++++++------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 6dfead0be74e..5f417e528419 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -95,6 +95,31 @@ struct syscall_enter_newstat_args {
 
 augmented_filename_syscall_enter(newstat);
 
+#ifndef _K_SS_MAXSIZE
+#define _K_SS_MAXSIZE 128
+#endif
+
+#define augmented_sockaddr_syscall_enter(syscall)						\
+struct augmented_enter_##syscall##_args {			 				\
+	struct syscall_enter_##syscall##_args	args;				 		\
+	struct sockaddr_storage			addr;						\
+};												\
+int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
+{												\
+	struct augmented_enter_##syscall##_args augmented_args;				 	\
+	unsigned long addrlen = sizeof(augmented_args.addr);					\
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);			\
+/* FIXME_CLANG_OPTIMIZATION_THAT_ACCESSES_USER_CONTROLLED_ADDRLEN_DESPITE_THIS_CHECK */		\
+/*	if (addrlen > augmented_args.args.addrlen)				     */		\
+/*		addrlen = augmented_args.args.addrlen;				     */		\
+/*										     */		\
+	probe_read(&augmented_args.addr, addrlen, args->addr_ptr); 				\
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 			\
+			  &augmented_args, 							\
+			  sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);	\
+	return 0;										\
+}
+
 struct sockaddr;
 
 struct syscall_enter_connect_args {
@@ -105,25 +130,6 @@ struct syscall_enter_connect_args {
 	unsigned long	   addrlen;
 };
 
-struct augmented_enter_connect_args {
-	struct syscall_enter_connect_args args;
-	struct sockaddr_storage		  addr;
-};
-
-int syscall_enter(connect)(struct syscall_enter_connect_args *args)
-{
-	struct augmented_enter_connect_args augmented_args;
-	unsigned long addrlen = sizeof(augmented_args.addr);
-
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
-#ifdef FIXME_CLANG_OPTIMIZATION_THAT_ACCESSES_USER_CONTROLLED_ADDRLEN_DESPITE_THIS_CHECK
-	if (addrlen > augmented_args.args.addrlen)
-		addrlen = augmented_args.args.addrlen;
-#endif
-	probe_read(&augmented_args.addr, addrlen, args->addr_ptr); 
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, &augmented_args, 
-			  sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);
-	return 0;
-}
+augmented_sockaddr_syscall_enter(connect);
 
 license(GPL);
-- 
2.14.4
