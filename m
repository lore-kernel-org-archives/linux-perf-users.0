From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/85] perf augmented_raw_syscalls: Move reading filename to the loop
Date: Tue, 11 Jun 2019 15:58:15 -0300
Message-ID: <20190611185911.11645-30-acme@kernel.org>
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

Almost there, next step is to copy more than one filename payload.

Probably to read syscall arg structs, etc we'll need just a variation of
this that will decide what to use, if probe_read_str() or plain
probe_read for structs, i.e. fixed size.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uf6u0pld6xe4xuo16f04owlz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 5054b4bc9e55..2f822bb51717 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -102,8 +102,6 @@ int sys_enter(struct syscall_enter_args *args)
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
 	unsigned int len = sizeof(augmented_args->args);
-	unsigned int filename_len;
-	const void *filename_arg = NULL;
 	struct syscall *syscall;
 	int key = 0;
 
@@ -206,8 +204,10 @@ processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_st
 
 #define __loop_iter(arg) \
 	if (syscall->string_args_len[arg] != 0) { \
-		filename_len = syscall->string_args_len[arg]; \
-		filename_arg = (const void *)args->args[arg];
+		unsigned int filename_len = syscall->string_args_len[arg]; \
+		const void *filename_arg = (const void *)args->args[arg]; \
+		if (filename_len <= sizeof(augmented_args->filename.value)) \
+			len += augmented_filename__read(&augmented_args->filename, filename_arg, filename_len);
 #define loop_iter_first() __loop_iter(0); }
 #define loop_iter(arg) else __loop_iter(arg); }
 #define loop_iter_last(arg) else __loop_iter(arg); __asm__ __volatile__("": : :"memory"); }
@@ -219,10 +219,6 @@ processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_st
 	loop_iter(4)
 	loop_iter_last(5)
 
-	if (filename_arg != NULL && filename_len <= sizeof(augmented_args->filename.value)) {
-		len += augmented_filename__read(&augmented_args->filename, filename_arg, filename_len);
-	}
-
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
 }
-- 
2.20.1
