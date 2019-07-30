From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 022/107] perf trace beauty: Add BPF augmenter for the 'rename' syscall
Date: Mon, 29 Jul 2019 23:54:45 -0300
Message-ID: <20190730025610.22603-23-acme@kernel.org>
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

I.e. two strings:

  # perf trace -e rename
  systemd/1 rename("/run/systemd/units/.#invocation:dnf-makecache.service970761b7f2840dcc", "/run/systemd/units/invocation:dnf-makecache.service") = 0
  systemd-journa/715 rename("/run/systemd/journal/streams/.#9:17539785BJDblc", "/run/systemd/journal/streams/9:17539785") = 0
  mv/1936 rename("/tmp/build/perf/fd/.array.o.tmp", "/tmp/build/perf/fd/.array.o.cmd") = 0
  sh/1949 rename("/tmp/build/perf/.cpu.o.tmp", "/tmp/build/perf/.cpu.o.cmd") = 0
  mv/1954 rename("/tmp/build/perf/fs/.tracing_path.o.tmp", "/tmp/build/perf/fs/.tracing_path.o.cmd") = 0
  mv/1963 rename("/tmp/build/perf/common-cmds.h+", "/tmp/build/perf/common-cmds.h") = 0
  :1975/1975 rename("/tmp/build/perf/.exec-cmd.o.tmp", "/tmp/build/perf/.exec-cmd.o.cmd") = 0
  mv/1979 rename("/tmp/build/perf/fs/.fs.o.tmp", "/tmp/build/perf/fs/.fs.o.cmd") = 0
  mv/2005 rename("/tmp/build/perf/.debug.o.tmp", "/tmp/build/perf/.debug.o.cmd") = 0
  mv/2012 rename("/tmp/build/perf/.str_error_r.o.tmp", "/tmp/build/perf/.str_error_r.o.cmd") = 0
  mv/2019 rename("/tmp/build/perf/.help.o.tmp", "/tmp/build/perf/.help.o.cmd") = 0
  mv/2031 rename("/tmp/build/perf/.trace-seq.o.tmp", "/tmp/build/perf/.trace-seq.o.cmd") = 0
  make/2038  ... [continued]: rename())             = 0
  :2038/2038 rename("/tmp/build/perf/.event-plugin.o.tmp", "/tmp/build/perf/.event-plugin.o.cmd") ...
  ar/2035 rename("/tmp/build/perf/stzwBX3a", "/tmp/build/perf/libapi.a") = 0
  mv/2051 rename("/tmp/build/perf/.parse-utils.o.tmp", "/tmp/build/perf/.parse-utils.o.cmd") = 0
  mv/2069 rename("/tmp/build/perf/.subcmd-config.o.tmp", "/tmp/build/perf/.subcmd-config.o.cmd") = 0
  make/2080 rename("/tmp/build/perf/.parse-filter.o.tmp", "/tmp/build/perf/.parse-filter.o.cmd") = 0
  mv/2099 rename("/tmp/build/perf/.pager.o.tmp", "/tmp/build/perf/.pager.o.cmd") = 0
  :2124/2124 rename("/tmp/build/perf/.sigchain.o.tmp", "/tmp/build/perf/.sigchain.o.cmd") = 0
  make/2140 rename("/tmp/build/perf/.event-parse.o.tmp", "/tmp/build/perf/.event-parse.o.cmd") = 0
  mv/2164 rename("/tmp/build/perf/.kbuffer-parse.o.tmp", "/tmp/build/perf/.kbuffer-parse.o.cmd") = 0
  sh/2174 rename("/tmp/build/perf/.run-command.o.tmp", "/tmp/build/perf/.run-command.o.cmd") = 0
  mv/2190 rename("/tmp/build/perf/.tep_strerror.o.tmp", "/tmp/build/perf/.tep_strerror.o.cmd") = 0
  :2261/2261 rename("/tmp/build/perf/.event-parse-api.o.tmp", "/tmp/build/perf/.event-parse-api.o.cmd") = 0
  :2480/2480 rename("/tmp/build/perf/stLv3kG2", "/tmp/build/perf/libtraceevent.a") = 0
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6hh2rl27uri6gsxhmk6q3hx5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 9c2228b01ee6..79787cf4fce9 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -197,6 +197,25 @@ int sys_enter_openat(struct syscall_enter_args *args)
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
 }
 
+SEC("!syscalls:sys_enter_rename")
+int sys_enter_rename(struct syscall_enter_args *args)
+{
+	int key = 0;
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	const void *oldpath_arg = (const void *)args->args[0],
+		   *newpath_arg = (const void *)args->args[1];
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
 SEC("!syscalls:sys_enter_renameat")
 int sys_enter_renameat(struct syscall_enter_args *args)
 {
-- 
2.21.0
