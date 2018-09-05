From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/77] perf trace: Introduce augmented_filename_syscall_enter() declarator
Date: Wed,  5 Sep 2018 19:03:32 -0300
Message-ID: <20180905220440.20256-10-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Helping with tons of boilerplate for syscalls that only want to augment
a filename. Now supporting one such syscall is just a matter of
declaring its arguments struct + using:

  augmented_filename_syscall_enter(openat);

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ls7ojdseu8fxw7fvj77ejpao@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 78 ++++++++--------------------
 1 file changed, 23 insertions(+), 55 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 6ec327850a15..e8486e8597de 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -33,6 +33,25 @@ struct augmented_filename {
 	char	value[256];
 };
 
+#define augmented_filename_syscall_enter(syscall) 							\
+struct augmented_enter_##syscall##_args {			 				\
+	struct syscall_enter_##syscall##_args	args;				 		\
+	struct augmented_filename		filename;				 	\
+};												\
+int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
+{												\
+	struct augmented_enter_##syscall##_args augmented_args = { .filename.reserved = 0, }; 	\
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);			\
+	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value, 		\
+						      sizeof(augmented_args.filename.value), 	\
+						      args->filename_ptr); 			\
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 			\
+			  &augmented_args, 							\
+			  (sizeof(augmented_args) - sizeof(augmented_args.filename.value) +	\
+			   augmented_args.filename.size));					\
+	return 0;										\
+}
+
 struct syscall_enter_openat_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
@@ -42,24 +61,7 @@ struct syscall_enter_openat_args {
 	long		   mode;
 };
 
-struct augmented_enter_openat_args {
-	struct syscall_enter_openat_args args;
-	struct augmented_filename	 filename;
-};
-
-int syscall_enter(openat)(struct syscall_enter_openat_args *args)
-{
-	struct augmented_enter_openat_args augmented_args = { .filename.reserved = 0, };
-
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
-	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
-						      sizeof(augmented_args.filename.value),
-						      args->filename_ptr);
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
-			  &augmented_args,
-			  sizeof(augmented_args) - sizeof(augmented_args.filename.value) + augmented_args.filename.size);
-	return 0;
-}
+augmented_filename_syscall_enter(openat);
 
 struct syscall_enter_open_args {
 	unsigned long long common_tp_fields;
@@ -69,50 +71,16 @@ struct syscall_enter_open_args {
 	long		   mode;
 };
 
-struct augmented_enter_open_args {
-	struct syscall_enter_open_args args;
-	struct augmented_filename      filename;
-};
-
-int syscall_enter(open)(struct syscall_enter_open_args *args)
-{
-	struct augmented_enter_open_args augmented_args = { .filename.reserved = 0, };
-
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
-	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
-						      sizeof(augmented_args.filename.value),
-						      args->filename_ptr);
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
-			  &augmented_args,
-			  sizeof(augmented_args) - sizeof(augmented_args.filename.value) + augmented_args.filename.size);
-	return 0;
-}
+augmented_filename_syscall_enter(open);
 
 struct syscall_enter_inotify_add_watch_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
 	long		   fd;
-	char		   *pathname_ptr;
+	char		   *filename_ptr;
 	long		   mask;
 };
 
-struct augmented_enter_inotify_add_watch_args {
-	struct syscall_enter_inotify_add_watch_args args;
-	struct augmented_filename		    pathname;
-};
-
-int syscall_enter(inotify_add_watch)(struct syscall_enter_inotify_add_watch_args *args)
-{
-	struct augmented_enter_inotify_add_watch_args augmented_args = { .pathname.reserved = 0, };
-
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
-	augmented_args.pathname.size = probe_read_str(&augmented_args.pathname.value,
-						      sizeof(augmented_args.pathname.value),
-						      args->pathname_ptr);
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
-			  &augmented_args,
-			  sizeof(augmented_args) - sizeof(augmented_args.pathname.value) + augmented_args.pathname.size);
-	return 0;
-}
+augmented_filename_syscall_enter(inotify_add_watch);
 
 license(GPL);
-- 
2.14.4
