From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 013/107] perf augmented_raw_syscalls: Support copying two string syscall args
Date: Mon, 29 Jul 2019 23:54:36 -0300
Message-ID: <20190730025610.22603-14-acme@kernel.org>
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

Starting with the renameat and renameat2 syscall, that both receive as
second and fourth parameters a pathname:

  # perf trace -e rename* mv one ANOTHER
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  mv: cannot stat 'one': No such file or directory
  renameat2(AT_FDCWD, "one", AT_FDCWD, "ANOTHER", RENAME_NOREPLACE) = -1 ENOENT (No such file or directory)
  #

Since the per CPU scratch buffer map has space for two maximum sized
pathnames, the verifier is satisfied that there will be no overrun.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-x2uboyg5kx2wqeru288209b6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                    |  2 ++
 .../examples/bpf/augmented_raw_syscalls.c     | 20 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a681b8c2ee4e..c64f7c99db15 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -873,9 +873,11 @@ static struct syscall_fmt {
 	{ .name	    = "recvmsg",
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "renameat",
+	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_renameat", },
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
 	{ .name	    = "renameat2",
+	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_renameat", },
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ },
 		   [4] = { .scnprintf = SCA_RENAMEAT2_FLAGS, /* flags */ }, }, },
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index ce308b9a317c..df52d92e1c69 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -70,6 +70,7 @@ pid_filter(pids_filtered);
 struct augmented_args_filename {
        struct syscall_enter_args args;
        struct augmented_filename filename;
+       struct augmented_filename filename2;
 };
 
 bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_filename, 1);
@@ -148,6 +149,25 @@ int sys_enter_openat(struct syscall_enter_args *args)
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
 }
 
+SEC("!syscalls:sys_enter_renameat")
+int sys_enter_renameat(struct syscall_enter_args *args)
+{
+	int key = 0;
+	struct augmented_args_filename *augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+	const void *oldpath_arg = (const void *)args->args[1],
+		   *newpath_arg = (const void *)args->args[3];
+	unsigned int len = sizeof(augmented_args->args), oldpath_len;
+
+        if (augmented_args == NULL)
+                return 1; /* Failure: don't filter */
+
+	oldpath_len = augmented_filename__read(&augmented_args->filename, oldpath_arg, sizeof(augmented_args->filename.value));
+	len += oldpath_len + augmented_filename__read((void *)(&augmented_args->filename) + oldpath_len, newpath_arg, sizeof(augmented_args->filename.value));
+
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
-- 
2.21.0
