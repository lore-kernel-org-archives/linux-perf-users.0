From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/85] perf augmented_raw_syscalls: Change helper to consider just the augmented_filename part
Date: Tue, 11 Jun 2019 15:58:14 -0300
Message-ID: <20190611185911.11645-29-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can use it for multiple args, baby steps not to step into the
verifier toes.

In the process make sure we handle -EFAULT from bpf_prog_read_str(), as
this really is needed now that we'll handle more than one augmented
argument, i.e. if there is failure, then we have the argument that fails
have:

  (size = 0, err = -EFAULT, value = [] )

followed by the next, lets say that worked for a second pathname:

  (size = 4, err = 0, value = "/tmp" )

So we can skip the first while telling the user about the problem and
then process the second.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-deyvqi39um6gp6hux6jovos8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 46 +++++++++++++------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 356513e81ec1..5054b4bc9e55 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -47,7 +47,7 @@ struct syscall_exit_args {
 
 struct augmented_filename {
 	unsigned int	size;
-	int		reserved;
+	int		err;
 	char		value[PATH_MAX];
 };
 
@@ -61,16 +61,28 @@ struct augmented_args_filename {
 bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_filename, 1);
 
 static inline
-unsigned int augmented_args__read_filename(struct augmented_args_filename *augmented_args,
-					   const void *filename_arg, unsigned int filename_len)
+unsigned int augmented_filename__read(struct augmented_filename *augmented_filename,
+				      const void *filename_arg, unsigned int filename_len)
 {
-	unsigned int len = sizeof(*augmented_args);
+	unsigned int len = sizeof(*augmented_filename);
+	int size = probe_read_str(&augmented_filename->value, filename_len, filename_arg);
 
-	augmented_args->filename.reserved = 0;
-	augmented_args->filename.size = probe_read_str(&augmented_args->filename.value, filename_len, filename_arg);
-	if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
-		len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
-		len &= sizeof(augmented_args->filename.value) - 1;
+	augmented_filename->size = augmented_filename->err = 0;
+	/*
+	 * probe_read_str may return < 0, e.g. -EFAULT
+	 * So we leave that in the augmented_filename->size that userspace will
+	 */
+	if (size > 0) {
+		len -= sizeof(augmented_filename->value) - size;
+		len &= sizeof(augmented_filename->value) - 1;
+		augmented_filename->size = size;
+	} else {
+		/*
+		 * So that username notice the error while still being able
+		 * to skip this augmented arg record
+		 */
+		augmented_filename->err = size;
+		len = offsetof(struct augmented_filename, value);
 	}
 
 	return len;
@@ -80,7 +92,17 @@ SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
 	struct augmented_args_filename *augmented_args;
-	unsigned int len, filename_len;
+	/*
+	 * We start len, the amount of data that will be in the perf ring
+	 * buffer, if this is not filtered out by one of pid_filter__has(),
+	 * syscall->enabled, etc, with the non-augmented raw syscall payload,
+	 * i.e. sizeof(augmented_args->args).
+	 *
+	 * We'll add to this as we add augmented syscalls right after that
+	 * initial, non-augmented raw_syscalls:sys_enter payload.
+	 */
+	unsigned int len = sizeof(augmented_args->args);
+	unsigned int filename_len;
 	const void *filename_arg = NULL;
 	struct syscall *syscall;
 	int key = 0;
@@ -198,9 +220,7 @@ processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_st
 	loop_iter_last(5)
 
 	if (filename_arg != NULL && filename_len <= sizeof(augmented_args->filename.value)) {
-		len = augmented_args__read_filename(augmented_args, filename_arg, filename_len);
-	} else {
-		len = sizeof(augmented_args->args);
+		len += augmented_filename__read(&augmented_args->filename, filename_arg, filename_len);
 	}
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-- 
2.20.1
