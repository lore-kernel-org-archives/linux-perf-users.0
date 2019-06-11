From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/85] perf augmented_raw_syscalls: Move the probe_read_str to a separate function
Date: Tue, 11 Jun 2019 15:58:13 -0300
Message-ID: <20190611185911.11645-28-acme@kernel.org>
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

One more step into copying multiple filenames to support syscalls like
rename*.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xdqtjexdyp81oomm1rkzeifl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index c9fd3b4d8e55..356513e81ec1 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -60,11 +60,27 @@ struct augmented_args_filename {
 
 bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_filename, 1);
 
+static inline
+unsigned int augmented_args__read_filename(struct augmented_args_filename *augmented_args,
+					   const void *filename_arg, unsigned int filename_len)
+{
+	unsigned int len = sizeof(*augmented_args);
+
+	augmented_args->filename.reserved = 0;
+	augmented_args->filename.size = probe_read_str(&augmented_args->filename.value, filename_len, filename_arg);
+	if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
+		len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
+		len &= sizeof(augmented_args->filename.value) - 1;
+	}
+
+	return len;
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
 	struct augmented_args_filename *augmented_args;
-	unsigned int len = sizeof(*augmented_args), filename_len;
+	unsigned int len, filename_len;
 	const void *filename_arg = NULL;
 	struct syscall *syscall;
 	int key = 0;
@@ -182,14 +198,7 @@ processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_st
 	loop_iter_last(5)
 
 	if (filename_arg != NULL && filename_len <= sizeof(augmented_args->filename.value)) {
-		augmented_args->filename.reserved = 0;
-		augmented_args->filename.size = probe_read_str(&augmented_args->filename.value,
-							      filename_len,
-							      filename_arg);
-		if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
-			len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
-			len &= sizeof(augmented_args->filename.value) - 1;
-		}
+		len = augmented_args__read_filename(augmented_args, filename_arg, filename_len);
 	} else {
 		len = sizeof(augmented_args->args);
 	}
-- 
2.20.1
