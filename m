From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/57] perf trace: Support tracepoint dynamic char arrays
Date: Mon, 21 Oct 2019 10:37:55 -0300
Message-ID: <20191021133834.25998-19-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Things like:

  # grep __data_loc /sys/kernel/debug/tracing/events/sched/sched_process_exec/format
	field:__data_loc char[] filename;	offset:8;	size:4;	signed:1;
  #

That, at that offset (8) and with that size(8) have an integer that
contains the real length and offset for the contents of that array.

Now this works:

  # perf trace --max-events 1 -e sched:*exec -a
     0.000 sed/19441 sched:sched_process_exec(filename: "/usr/bin/sync", pid: 19441 (sync), old_pid: 19441 (sync))
  #

As when using the libtraceevent based beautifier:

  # perf trace --libtraceevent --max-events 1 -e sched:*exec -a
     0.000 sync/19463 sched:sched_process_exec(filename=/usr/bin/sync pid=19463 old_pid=19463)
  #

I.e. that 'filename' is implemented as a dynamic char array.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-950p0m842fe6n7sxsdwqj5i2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 19 ++++++++++++++-----
 tools/perf/trace/beauty/beauty.h |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cdee22dac2b3..907eaf316f5b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -563,7 +563,7 @@ static size_t syscall_arg__scnprintf_char_array(char *bf, size_t size, struct sy
 	// XXX Hey, maybe for sched:sched_switch prev/next comm fields we can
 	//     fill missing comms using thread__set_comm()...
 	//     here or in a special syscall_arg__scnprintf_pid_sched_tp...
-	return scnprintf(bf, size, "\"%-.*s\"", arg->fmt->nr_entries, arg->val);
+	return scnprintf(bf, size, "\"%-.*s\"", arg->fmt->nr_entries ?: arg->len, arg->val);
 }
 
 #define SCA_CHAR_ARRAY syscall_arg__scnprintf_char_array
@@ -1559,7 +1559,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			arg->scnprintf = SCA_PID;
 		else if (strcmp(field->type, "umode_t") == 0)
 			arg->scnprintf = SCA_MODE_T;
-		else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstarts(field->type, "char")) {
+		else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstr(field->type, "char")) {
 			arg->scnprintf = SCA_CHAR_ARRAY;
 			arg->nr_entries = field->arraylen;
 		} else if ((strcmp(field->type, "int") == 0 ||
@@ -2523,10 +2523,19 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (syscall_arg.mask & bit)
 			continue;
 
+		syscall_arg.len = 0;
 		syscall_arg.fmt = arg;
-		if (field->flags & TEP_FIELD_IS_ARRAY)
-			val = (uintptr_t)(sample->raw_data + field->offset);
-		else
+		if (field->flags & TEP_FIELD_IS_ARRAY) {
+			int offset = field->offset;
+
+			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
+				offset = format_field__intval(field, sample, evsel->needs_swap);
+				syscall_arg.len = offset >> 16;
+				offset &= 0xffff;
+			}
+
+			val = (uintptr_t)(sample->raw_data + offset);
+		} else
 			val = format_field__intval(field, sample, evsel->needs_swap);
 		/*
 		 * Some syscall args need some mask, most don't and
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 77ad80a399fd..0dee0cf4fda8 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -87,6 +87,7 @@ struct syscall_arg_fmt;
 
 /**
  * @val: value of syscall argument being formatted
+ * @len: for tracepoint dynamic arrays, if fmt->nr_entries == 0, then its not a fixed array, look at arg->len
  * @args: All the args, use syscall_args__val(arg, nth) to access one
  * @augmented_args: Extra data that can be collected, for instance, with eBPF for expanding the pathname for open, etc
  * @augmented_args_size: augmented_args total payload size
@@ -109,6 +110,7 @@ struct syscall_arg {
 	struct thread *thread;
 	struct trace  *trace;
 	void	      *parm;
+	u16	      len;
 	u8	      idx;
 	u8	      mask;
 	bool	      show_string_prefix;
-- 
2.21.0
