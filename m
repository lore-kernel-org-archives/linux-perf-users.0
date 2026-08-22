Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B48395AF2;
	Sat, 22 Aug 2026 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390738; cv=none; b=VGll85h0HCufGMN4DubQNN0UgmZyNh0ifcJKWdnVot5DkKggdAk4xqOyf1bFoOfuUBq0T00E3BYAfjBl2PvHVQeU1/Fy2JGETysu6pMo0H9nzXWn7yZNK81C/gaAE4GonQ/KGlr5nBCNCT8uhGu/H9LbzpKwudlVElo15jN/u0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390738; c=relaxed/simple;
	bh=4dWserjLRznRYdafBG7Bs+nM3kP/SEcEmFgJJLqKS/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiUZsWtv4V7bGeZTVmXYGpuDbGprMOPCupHoQOb9kkou3TfhAwhKqVQG9XhFA27Yc8IoYw8jPwlqhdXfYVXTLZTO+P5xP7wDImM7poar8WhgrHR0k+iBBoVQTgxzFobMbpbcwAX2PWBQ3Titibijx/ez91SQROocjH7X/IItM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAnYqlsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAnYqlsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4036C1F000E9;
	Sat, 22 Aug 2026 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787390732;
	bh=RfjpzBdrhgca9nK09lhtrF2UYq2Wq0acwdF1hfKlCx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KAnYqlslyM81FPEqrSwORNMAwtRhcaNOFavdAVCBGUK7rS+uYsrG5k2K+GmpHGlj6
	 5U4pXlQMcjFMbDNcJkhhhHROn2Gr3h3X12Q6jFiTtuSBXC53AGn8vzoTcreYwFwx0G
	 IHNGEfxtBBN3gCDKfVypzzr5qG3Kkd9iulbqVp1COwNpb6qOgtP5IpgwLQ0GGcf4aw
	 WnrsjV1jS1wdMygR4tV3rdVeR/udNZ38nwTcqWnq95qeA8g7ytntuIFhVdkD2BfHHf
	 9Xn5C6l2beg6MlMDWM6xV8eflUr04aOuQbc6Ghamgm5kPuFa9Mm/IHP41Siz80C1bP
	 yYHscURs9bBhQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v13 12/12] tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger
Date: Sat, 22 Aug 2026 18:25:27 +0900
Message-ID: <178739072694.1520941.18132159339101776117.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178739053919.1520941.17662338993878200834.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Allow set_wprobe trigger to use BTF struct offset resolution to specify
the target address field.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v13:
 - Check for field token before calling wprobe_trigger_field_parse() in
   clear_wprobe to avoid spurious error log entries on numeric counts.
Changes in v12:
 - Refactor field parsing logic into wprobe_trigger_field_parse().
 - Remove unused variable count_str in wprobe_trigger_cmd_parse().
---
 kernel/trace/trace_wprobe.c                        |  263 ++++++++++++++------
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   74 ++++++
 2 files changed, 262 insertions(+), 75 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index acb15fd018e8..b513561005dc 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -27,6 +27,7 @@
 #include <asm/ptrace.h>
 
 #include "trace.h"
+#include "trace_btf.h"
 #include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_kernel.h"
@@ -950,9 +951,10 @@ static int wprobe_trigger_print(struct seq_file *m,
 		seq_printf(m, ":count=%ld", data->count);
 
 	if (data->filter_str)
-		seq_printf(m, " if %s\n", data->filter_str);
-	else
-		seq_putc(m, '\n');
+		seq_printf(m, " if %s", data->filter_str);
+
+	seq_printf(m, " # offset:%d adjust:%ld\n",
+		   wprobe_data->offset, wprobe_data->adjust);
 
 	return 0;
 }
@@ -990,6 +992,181 @@ static void wprobe_trigger_free(struct event_trigger_data *data)
 	}
 }
 
+#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
+
+static int get_offset_of_field(struct btf *btf, const struct btf_type *type, char *field_name)
+{
+	const struct btf_member *field;
+	int bitoffs = 0;
+	u32 anon_offs;
+	char *next;
+
+	do {
+		next = strchr(field_name, '.');
+		if (next)
+			*next++ = '\0';
+
+		field = btf_find_struct_member(btf, type, field_name, &anon_offs);
+		if (IS_ERR_OR_NULL(field))
+			return -ENOENT;
+
+		if (btf_type_kflag(type)) {
+			/* Reject bitfield member access */
+			if (BTF_MEMBER_BITFIELD_SIZE(field->offset))
+				return -EINVAL;
+			bitoffs += anon_offs + BTF_MEMBER_BIT_OFFSET(field->offset);
+		} else {
+			bitoffs += anon_offs + field->offset;
+		}
+
+		field_name = next;
+		if (next) {
+			type = btf_type_skip_modifiers(btf, field->type, NULL);
+			if (!type)
+				return -ENOENT;
+		}
+	} while (next);
+	return bitoffs / BITS_PER_BYTE;
+}
+
+/* btf_put(NULL) is acceptable. */
+DEFINE_FREE(btf_put, struct btf *, btf_put(_T))
+
+/* parse typecast: (TYPE[,ASGN])EVENT_FIELD->FIELD[.SUBFIELD...] and set adjust. */
+static int wprobe_trigger_typecast_parse(char **field_str_ptr,
+					 struct trace_event_file *file,
+					 struct wprobe_trigger_data *wprobe_data,
+					 const char *glob)
+{
+	struct btf *btf __free(btf_put) = NULL;
+	const struct btf_type *type;
+	char *assign_field;
+	char *event_field;
+	char *type_field;
+	char *type_name;
+	char *offs;
+	long val = 0;
+	int id;
+	int adjust;
+
+	type_name = *field_str_ptr + 1;
+	event_field = strchr(type_name, ')');
+	if (!event_field) {
+		wprobe_trigger_log_err(file, glob, type_name - glob, DEREF_OPEN_BRACE);
+		return -EINVAL;
+	}
+	*event_field++ = '\0';
+
+	/* Check the optional assign field. */
+	assign_field = strchr(type_name, ',');
+	if (assign_field)
+		*assign_field++ = '\0';
+
+	/* Get the type field name. */
+	type_field = strstr(event_field, "->");
+	if (!type_field) {
+		wprobe_trigger_log_err(file, glob, event_field - glob, TYPECAST_REQ_FIELD);
+		return -EINVAL;
+	}
+	*type_field = '\0';
+	type_field += 2;
+
+	offs = strpbrk(type_field, "+-");
+	if (offs) {
+		if (kstrtol(offs, 0, &val) < 0) {
+			wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
+			return -EINVAL;
+		}
+		*offs = '\0';
+	}
+
+	/* find type from BTF */
+	id = bpf_find_btf_id(type_name, BTF_KIND_STRUCT, &btf);
+	if (id < 0) {
+		wprobe_trigger_log_err(file, glob, type_name - glob, BAD_BTF_TID);
+		return id;
+	}
+
+	type = btf_type_by_id(btf, id);
+	if (!type) {
+		wprobe_trigger_log_err(file, glob, type_name - glob, BAD_BTF_TID);
+		return -EINVAL;
+	}
+
+	adjust = get_offset_of_field(btf, type, type_field);
+	if (adjust < 0) {
+		wprobe_trigger_log_err(file, glob, type_field - glob, NO_BTF_FIELD);
+		return adjust;
+	}
+	wprobe_data->adjust = adjust + val;
+
+	if (assign_field) {
+		/* assign_field should be a struct field */
+		adjust = get_offset_of_field(btf, type, assign_field);
+		if (adjust < 0) {
+			wprobe_trigger_log_err(file, glob, assign_field - glob, NO_BTF_FIELD);
+			return adjust;
+		}
+		wprobe_data->adjust -= adjust;
+	}
+
+	*field_str_ptr = event_field;
+	return 0;
+}
+#else
+static int wprobe_trigger_typecast_parse(char **field_str_ptr,
+					 struct trace_event_file *file,
+					 struct wprobe_trigger_data *wprobe_data,
+					 const char *glob)
+{
+	wprobe_trigger_log_err(file, glob, *field_str_ptr - glob, NOSUP_BTFARG);
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_PROBE_EVENTS_BTF_ARGS */
+
+static int wprobe_trigger_field_parse(char *field_str, struct trace_event_file *file,
+					struct wprobe_trigger_data *wprobe_data,
+					const char *glob)
+{
+	struct ftrace_event_field *field;
+	char *offs;
+
+	if (field_str[0] == '(') {
+		int ret = wprobe_trigger_typecast_parse(&field_str, file, wprobe_data, glob);
+
+		if (ret < 0)
+			return ret;
+	} else {
+		offs = strpbrk(field_str, "+-");
+		if (offs) {
+			long val;
+
+			if (kstrtol(offs, 0, &val) < 0) {
+				wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
+				return -EINVAL;
+			}
+			wprobe_data->adjust = val;
+			*offs = '\0';
+		}
+	}
+
+	field = trace_find_event_field(file->event_call, field_str);
+	if (!field) {
+		wprobe_trigger_log_err(file, glob, field_str - glob, NO_EVENT_FIELD);
+		return -ENOENT;
+	}
+	if (field->size != sizeof(void *)) {
+		wprobe_trigger_log_err(file, glob, field_str - glob, WPROBE_BAD_FIELD);
+		return -ENOEXEC;
+	}
+	wprobe_data->offset = field->offset;
+	wprobe_data->field = kstrdup(field_str, GFP_KERNEL);
+	if (!wprobe_data->field)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 				    struct trace_event_file *file,
 				    char *glob, char *cmd,
@@ -1001,11 +1178,9 @@ static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 	 */
 	struct wprobe_trigger_data *wprobe_data = NULL;
 	struct event_trigger_data *trigger_data = NULL;
+	char *event_str, *comment;
 	struct trace_event_file *wprobe_file;
 	struct trace_array *tr = file->tr;
-	char *event_str, *field_str, *comment;
-	struct ftrace_event_field *field;
-	struct trace_event_call *event;
 	bool remove, clear = false;
 	struct trace_wprobe *tw;
 	char *param, *filter;
@@ -1064,84 +1239,22 @@ static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 
 	/* clear_wprobe does not need field, but can have optional field. */
 	if (!clear) {
-		char *offs;
+		char *field_str = strsep(&param, ":");
 
-		/* Find target field, which must be equivalent to "void *" */
-		field_str = strsep(&param, ":");
 		if (!field_str) {
 			wprobe_trigger_log_err(file, glob, strlen(glob), WPROBE_NEED_FIELD);
 			ret = -EINVAL;
 			goto out_free;
 		}
-
-		offs = strpbrk(field_str, "+-");
-		if (offs) {
-			long val;
-
-			if (kstrtol(offs, 0, &val) < 0) {
-				wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
-				ret = -EINVAL;
-				goto out_free;
-			}
-			wprobe_data->adjust = val;
-			*offs = '\0';
-		}
-
-		event = file->event_call;
-		field = trace_find_event_field(event, field_str);
-		if (!field) {
-			wprobe_trigger_log_err(file, glob, field_str - glob, NO_EVENT_FIELD);
-			ret = -ENOENT;
-			goto out_free;
-		}
-
-		if (field->size != sizeof(void *)) {
-			wprobe_trigger_log_err(file, glob, field_str - glob, WPROBE_BAD_FIELD);
-			ret = -ENOEXEC;
-			goto out_free;
-		}
-		wprobe_data->offset = field->offset;
-		wprobe_data->field = kstrdup(field_str, GFP_KERNEL);
-		if (!wprobe_data->field) {
-			ret = -ENOMEM;
-			goto out_free;
-		}
-	} else if (param && (isalpha(param[0]) || param[0] == '_')) {
-		char *offs;
-
-		field_str = strsep(&param, ":");
-		offs = strpbrk(field_str, "+-");
-		if (offs) {
-			long val;
-
-			if (kstrtol(offs, 0, &val) < 0) {
-				wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
-				ret = -EINVAL;
-				goto out_free;
-			}
-			wprobe_data->adjust = val;
-			*offs = '\0';
-		}
-
-		event = file->event_call;
-		field = trace_find_event_field(event, field_str);
-		if (!field) {
-			wprobe_trigger_log_err(file, glob, field_str - glob, NO_EVENT_FIELD);
-			ret = -ENOENT;
+		ret = wprobe_trigger_field_parse(field_str, file, wprobe_data, glob);
+		if (ret < 0)
 			goto out_free;
-		}
+	} else if (param && (isalpha(param[0]) || param[0] == '_' || param[0] == '(')) {
+		char *field_str = strsep(&param, ":");
 
-		if (field->size != sizeof(void *)) {
-			wprobe_trigger_log_err(file, glob, field_str - glob, WPROBE_BAD_FIELD);
-			ret = -ENOEXEC;
-			goto out_free;
-		}
-		wprobe_data->offset = field->offset;
-		wprobe_data->field = kstrdup(field_str, GFP_KERNEL);
-		if (!wprobe_data->field) {
-			ret = -ENOMEM;
+		ret = wprobe_trigger_field_parse(field_str, file, wprobe_data, glob);
+		if (ret < 0)
 			goto out_free;
-		}
 	}
 
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, wprobe_data);
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc
new file mode 100644
index 000000000000..dda179a23282
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc
@@ -0,0 +1,74 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test set_wprobe trigger with BTF struct offset
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README events/sched/sched_process_fork/trigger "[(structname[,field])]<argname>[->field[->field|.field...]]":README
+
+rmmod trace-events-sample ||:
+if ! modprobe trace-events-sample ; then
+  echo "No trace-events sample module - please make CONFIG_SAMPLE_TRACE_EVENTS=m"
+  exit_unresolved
+fi
+
+cleanup_wprobe_triggers() {
+  if [ -f events/fprobes/testevent/trigger ]; then
+    reset_trigger_file events/fprobes/testevent/trigger || true
+  fi
+  echo 0 > events/enable 2>/dev/null || true
+  echo > dynamic_events 2>/dev/null || true
+  sleep 1
+  rmmod trace-events-sample 2>/dev/null || true
+  return 0
+}
+
+trap cleanup_wprobe_triggers EXIT
+
+echo 0 > tracing_on
+
+# we will skip this test if fprobe is not supported.
+if ! grep -Fq "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README; then
+    echo "UNRESOLVED: fprobe is not supported"
+    exit_unresolved
+fi
+
+# we will skip this test if the target function does not exist.
+if ! grep -wq "sample_timer_cb" /proc/kallsyms; then
+    echo "UNRESOLVED: sample_timer_cb not found"
+    exit_unresolved
+fi
+
+:;: "Add a wprobe event watching 8 bytes" ;:
+echo 'w:watch rw@0:8 address=$addr value=$value' >> dynamic_events
+
+:;: "Add fprobe event for sample_timer_cb" ;:
+# sample_timer_cb(struct timer_list *t)
+# container_of(t, struct foo_timer_data, timer)
+echo 'f:fprobes/testevent sample_timer_cb timer=t' >> dynamic_events
+
+:;: "Enable all events before setting triggers" ;:
+echo 1 > tracing_on
+echo 1 >> events/fprobes/testevent/enable
+
+:;: "Set set_wprobe trigger using BTF struct offset resolution" ;:
+# Syntax: set_wprobe:WPEVENT:(STRUCT,FIELD)EVENT_FIELD->MEMBER
+# (foo_timer_data,timer) is the BTF struct type and field name
+# timer->expires is the struct member whose offset is resolved automatically via BTF
+echo 'set_wprobe:watch:(foo_timer_data,timer)timer->timer.expires' >> events/fprobes/testevent/trigger
+cat events/fprobes/testevent/trigger | grep ^set_wprobe
+
+# Wait for sample_timer_cb to fire and set_wprobe trigger to activate
+sleep 3
+
+:;: "Check set_wprobe trigger activated the watchpoint" ;:
+cat trace | grep watch
+
+:;: "Remove wprobe triggers" ;:
+# Since we don't know actual offset of timer->expires in foo_timer_data, we use reset_trigger_file
+reset_trigger_file events/fprobes/testevent/trigger
+! grep ^set_wprobe events/fprobes/testevent/trigger
+
+:;: "Disable events and remove dynamic events" ;:
+echo 0 > events/enable
+echo > dynamic_events
+clear_trace
+
+exit 0

