From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/63] perf trace: Allow suppressing the syscall argument names
Date: Tue, 18 Dec 2018 19:07:11 -0300
Message-ID: <20181218220733.15839-42-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To show just the values:

Default:

  # trace -e open*,close,*sleep sleep 1
  openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC           ) = 3
  close(fd: 3                                                           ) = 0
  openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 3
  close(fd: 3                                                           ) = 0
  openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
  close(fd: 3                                                           ) = 0
  nanosleep(rqtp: 0x7ffc0c4ea0d0, rmtp: 0                               ) = 0
  close(fd: 1                                                           ) = 0
  close(fd: 2                                                           ) = 0
  #

Remove it:

  # perf config trace.show_arg_names=no
  # trace -e open*,close,*sleep sleep 1
  openat(CWD, /etc/ld.so.cache, CLOEXEC                                 ) = 3
  close(3                                                               ) = 0
  openat(CWD, /lib64/libc.so.6, CLOEXEC                                 ) = 3
  close(3                                                               ) = 0
  openat(CWD, /usr/lib/locale/locale-archive, CLOEXEC                   ) = 3
  close(3                                                               ) = 0
  nanosleep(0x7ffced3a8c40, 0                                           ) = 0
  close(1                                                               ) = 0
  close(2                                                               ) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ta9tbdwgodpw719sr2bjm8eb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  4 ++++
 tools/perf/builtin-trace.c               | 22 ++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index ecd1e9514925..35108fd61fa6 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -532,6 +532,10 @@ trace.*::
 	trace.no_inherit::
 		Do not follow children threads.
 
+	trace.show_arg_names::
+		Should syscall argument names be printed? If not then trace.show_zeros
+		will be set.
+
 	trace.show_duration::
 		Show syscall duration.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e978ce034863..95dfcb851604 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -130,6 +130,7 @@ struct trace {
 	bool			show_tstamp;
 	bool			show_duration;
 	bool			show_zeros;
+	bool			show_arg_names;
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
@@ -1613,8 +1614,11 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			      sc->arg_fmt[arg.idx].parm))
 				continue;
 
-			printed += scnprintf(bf + printed, size - printed,
-					     "%s%s: ", printed ? ", " : "", field->name);
+			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
+
+			if (trace->show_arg_names)
+				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
+
 			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
 		}
 	} else if (IS_ERR(sc->tp_format)) {
@@ -3546,12 +3550,21 @@ static int trace__config(const char *var, const char *value, void *arg)
 		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
 		trace->show_duration = perf_config_bool(var, value);
+	} else if (!strcmp(var, "trace.show_arg_names")) {
+		trace->show_arg_names = perf_config_bool(var, value);
+		if (!trace->show_arg_names)
+			trace->show_zeros = true;
 	} else if (!strcmp(var, "trace.show_zeros")) {
-		trace->show_zeros = perf_config_bool(var, value);
+		bool new_show_zeros = perf_config_bool(var, value);
+		if (!trace->show_arg_names && !new_show_zeros) {
+			pr_warning("trace.show_zeros has to be set when trace.show_arg_names=no\n");
+			goto out;
+		}
+		trace->show_zeros = new_show_zeros;
 	} else if (!strcmp(var, "trace.no_inherit")) {
 		trace->opts.no_inherit = perf_config_bool(var, value);
 	}
-
+out:
 	return err;
 }
 
@@ -3582,6 +3595,7 @@ int cmd_trace(int argc, const char **argv)
 		.show_comm = true,
 		.show_tstamp = true,
 		.show_duration = true,
+		.show_arg_names = true,
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
-- 
2.19.2
