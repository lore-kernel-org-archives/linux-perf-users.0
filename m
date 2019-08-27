From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/33] perf augmented_raw_syscalls: Introduce helper to get the scratch space
Date: Mon, 26 Aug 2019 22:36:12 -0300
Message-ID: <20190827013634.3173-12-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need more than the BPF stack can give us to format the
raw_syscalls:sys_enter augmented tracepoint, so we use a PERCPU_ARRAY
map for that, use a helper to shorten the sequence to access that area.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 0a8d217d65c7..8fd5ea059903 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -78,8 +78,15 @@ struct augmented_args_payload {
 	};
 };
 
+// We need more tmp space than the BPF stack can give us
 bpf_map(augmented_args_tmp, PERCPU_ARRAY, int, struct augmented_args_payload, 1);
 
+static inline struct augmented_args_payload *augmented_args_payload(void)
+{
+	int key = 0;
+	return bpf_map_lookup_elem(&augmented_args_tmp, &key);
+}
+
 static inline
 unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
 {
@@ -122,8 +129,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_connect")
 int sys_enter_connect(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *sockaddr_arg = (const void *)args->args[1];
 	unsigned int socklen = args->args[2];
 	unsigned int len = sizeof(augmented_args->args);
@@ -143,8 +149,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_sendto")
 int sys_enter_sendto(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *sockaddr_arg = (const void *)args->args[4];
 	unsigned int socklen = args->args[5];
 	unsigned int len = sizeof(augmented_args->args);
@@ -164,8 +169,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_open")
 int sys_enter_open(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *filename_arg = (const void *)args->args[0];
 	unsigned int len = sizeof(augmented_args->args);
 
@@ -181,8 +185,7 @@ int sys_enter_open(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_openat")
 int sys_enter_openat(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *filename_arg = (const void *)args->args[1];
 	unsigned int len = sizeof(augmented_args->args);
 
@@ -198,8 +201,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_rename")
 int sys_enter_rename(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[0],
 		   *newpath_arg = (const void *)args->args[1];
 	unsigned int len = sizeof(augmented_args->args), oldpath_len;
@@ -217,8 +219,7 @@ int sys_enter_rename(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_renameat")
 int sys_enter_renameat(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[1],
 		   *newpath_arg = (const void *)args->args[3];
 	unsigned int len = sizeof(augmented_args->args), oldpath_len;
@@ -248,14 +249,13 @@ int sys_enter(struct syscall_enter_args *args)
 	 */
 	unsigned int len = sizeof(augmented_args->args);
 	struct syscall *syscall;
-	int key = 0;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
-        augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
-        if (augmented_args == NULL)
-                return 1;
+	augmented_args = augmented_args_payload();
+	if (augmented_args == NULL)
+		return 1;
 
 	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
 
-- 
2.21.0
