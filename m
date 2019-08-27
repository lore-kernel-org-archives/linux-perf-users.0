From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/33] perf augmented_raw_syscalls: Rename augmented_filename to augmented_arg
Date: Mon, 26 Aug 2019 22:36:10 -0300
Message-ID: <20190827013634.3173-10-acme@kernel.org>
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

Because it is not used only for strings, we already use it for sockaddr
structs and will use it for all other types.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w9nkt3tvmyn5i4qnwng3ap1k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 42 +++++++++----------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 79787cf4fce9..b85b177c6726 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -60,7 +60,7 @@ struct syscall_exit_args {
 	long		   ret;
 };
 
-struct augmented_filename {
+struct augmented_arg {
 	unsigned int	size;
 	int		err;
 	char		value[PATH_MAX];
@@ -72,8 +72,7 @@ struct augmented_args_payload {
        struct syscall_enter_args args;
        union {
 		struct {
-			struct augmented_filename filename,
-						  filename2;
+			struct augmented_arg arg, arg2;
 		};
 		struct sockaddr_storage saddr;
 	};
@@ -82,31 +81,30 @@ struct augmented_args_payload {
 bpf_map(augmented_args_tmp, PERCPU_ARRAY, int, struct augmented_args_payload, 1);
 
 static inline
-unsigned int augmented_filename__read(struct augmented_filename *augmented_filename,
-				      const void *filename_arg, unsigned int filename_len)
+unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
 {
-	unsigned int len = sizeof(*augmented_filename);
-	int size = probe_read_str(&augmented_filename->value, filename_len, filename_arg);
+	unsigned int augmented_len = sizeof(*augmented_arg);
+	int string_len = probe_read_str(&augmented_arg->value, arg_len, arg);
 
-	augmented_filename->size = augmented_filename->err = 0;
+	augmented_arg->size = augmented_arg->err = 0;
 	/*
 	 * probe_read_str may return < 0, e.g. -EFAULT
-	 * So we leave that in the augmented_filename->size that userspace will
+	 * So we leave that in the augmented_arg->size that userspace will
 	 */
-	if (size > 0) {
-		len -= sizeof(augmented_filename->value) - size;
-		len &= sizeof(augmented_filename->value) - 1;
-		augmented_filename->size = size;
+	if (string_len > 0) {
+		augmented_len -= sizeof(augmented_arg->value) - string_len;
+		augmented_len &= sizeof(augmented_arg->value) - 1;
+		augmented_arg->size = string_len;
 	} else {
 		/*
 		 * So that username notice the error while still being able
 		 * to skip this augmented arg record
 		 */
-		augmented_filename->err = size;
-		len = offsetof(struct augmented_filename, value);
+		augmented_arg->err = string_len;
+		augmented_len = offsetof(struct augmented_arg, value);
 	}
 
-	return len;
+	return augmented_len;
 }
 
 SEC("!raw_syscalls:unaugmented")
@@ -174,7 +172,7 @@ int sys_enter_open(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
-	len += augmented_filename__read(&augmented_args->filename, filename_arg, sizeof(augmented_args->filename.value));
+	len += augmented_arg__read_str(&augmented_args->arg, filename_arg, sizeof(augmented_args->arg.value));
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
@@ -191,7 +189,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
-	len += augmented_filename__read(&augmented_args->filename, filename_arg, sizeof(augmented_args->filename.value));
+	len += augmented_arg__read_str(&augmented_args->arg, filename_arg, sizeof(augmented_args->arg.value));
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
@@ -209,8 +207,8 @@ int sys_enter_rename(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
-	oldpath_len = augmented_filename__read(&augmented_args->filename, oldpath_arg, sizeof(augmented_args->filename.value));
-	len += oldpath_len + augmented_filename__read((void *)(&augmented_args->filename) + oldpath_len, newpath_arg, sizeof(augmented_args->filename.value));
+	oldpath_len = augmented_arg__read_str(&augmented_args->arg, oldpath_arg, sizeof(augmented_args->arg.value));
+	len += oldpath_len + augmented_arg__read_str((void *)(&augmented_args->arg) + oldpath_len, newpath_arg, sizeof(augmented_args->arg.value));
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
@@ -228,8 +226,8 @@ int sys_enter_renameat(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
-	oldpath_len = augmented_filename__read(&augmented_args->filename, oldpath_arg, sizeof(augmented_args->filename.value));
-	len += oldpath_len + augmented_filename__read((void *)(&augmented_args->filename) + oldpath_len, newpath_arg, sizeof(augmented_args->filename.value));
+	oldpath_len = augmented_arg__read_str(&augmented_args->arg, oldpath_arg, sizeof(augmented_args->arg.value));
+	len += oldpath_len + augmented_arg__read_str((void *)(&augmented_args->arg) + oldpath_len, newpath_arg, sizeof(augmented_args->arg.value));
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
-- 
2.21.0
