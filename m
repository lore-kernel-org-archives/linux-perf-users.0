From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/57] perf trace: Initialize evsel_trace->fmt for syscalls:sys_enter_* tracepoints
Date: Mon, 21 Oct 2019 10:38:10 -0300
Message-ID: <20191021133834.25998-34-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

From the syscall_fmts->arg entries for formatting strace-like syscalls.

This is when resolving the string "whence" on a filter expression for
the syscalls:sys_enter_lseek:

  Breakpoint 3, perf_evsel__syscall_arg_fmt (evsel=0xc91ed0, arg=0x7fffffff7cd0 "whence") at builtin-trace.c:3626
  3626	{
  (gdb) n
  3628		struct syscall_arg_fmt *fmt = __evsel__syscall_arg_fmt(evsel);
  (gdb) n
  3630		if (evsel->tp_format == NULL || fmt == NULL)
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) p field->name
  $3 = 0xc945e0 "__syscall_nr"
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) p *fmt
  $4 = {scnprintf = 0x0, strtoul = 0x0, mask_val = 0x0, parm = 0x0, name = 0x0, nr_entries = 0, show_zero = false}
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) p field->name
  $5 = 0xc94690 "fd"
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) p *fmt
  $9 = {scnprintf = 0x489be2 <syscall_arg__scnprintf_strarray>, strtoul = 0x0, mask_val = 0x0, parm = 0xa2da80 <strarray.whences>, name = 0x0,
    nr_entries = 0, show_zero = false}
  (gdb) p field->name
  $10 = 0xc947b0 "whence"
  (gdb) p fmt->parm
  $11 = (void *) 0xa2da80 <strarray.whences>
  (gdb) p *(struct strarray *)fmt->parm
  $12 = {offset = 0, nr_entries = 5, prefix = 0x724d37 "SEEK_", entries = 0xa2da40 <whences>}
  (gdb) p (struct strarray *)fmt->parm)->entries
  Junk after end of expression.
  (gdb) p ((struct strarray *)fmt->parm)->entries
  $13 = (const char **) 0xa2da40 <whences>
  (gdb) p ((struct strarray *)fmt->parm)->entries[0]
  $14 = 0x724d21 "SET"
  (gdb) p ((struct strarray *)fmt->parm)->entries[1]
  $15 = 0x724d25 "CUR"
  (gdb) p ((struct strarray *)fmt->parm)->entries[2]
  $16 = 0x724d29 "END"
  (gdb) p ((struct strarray *)fmt->parm)->entries[2]
  $17 = 0x724d29 "END"
  (gdb) p ((struct strarray *)fmt->parm)->entries[3]
  $18 = 0x724d2d "DATA"
  (gdb) p ((struct strarray *)fmt->parm)->entries[4]
  $19 = 0x724d32 "HOLE"
  (gdb)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lc8h9jgvbnboe0g7ic8tra1y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5792278065f6..3502417dc7f2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4366,6 +4366,25 @@ static void evlist__set_default_evsel_handler(struct evlist *evlist, void *handl
 	}
 }
 
+static void evsel__set_syscall_arg_fmt(struct evsel *evsel, const char *name)
+{
+	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
+
+	if (fmt) {
+		struct syscall_fmt *scfmt = syscall_fmt__find(name);
+
+		if (scfmt) {
+			int skip = 0;
+
+			if (strcmp(evsel->tp_format->format.fields->name, "__syscall_nr") == 0 ||
+			    strcmp(evsel->tp_format->format.fields->name, "nr") == 0)
+				++skip;
+
+			memcpy(fmt + skip, scfmt->arg, (evsel->tp_format->format.nr_fields - skip) * sizeof(*fmt));
+		}
+	}
+}
+
 static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -4387,11 +4406,15 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 
 			if (__tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64)))
 				return -1;
+
+			evsel__set_syscall_arg_fmt(evsel, evsel->tp_format->name + sizeof("sys_enter_") - 1);
 		} else if (!strncmp(evsel->tp_format->name, "sys_exit_", 9)) {
 			struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 			if (__tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap))
 				return -1;
+
+			evsel__set_syscall_arg_fmt(evsel, evsel->tp_format->name + sizeof("sys_exit_") - 1);
 		}
 	}
 
-- 
2.21.0
