Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959D1C28E;
	Sun,  2 Aug 2026 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658839; cv=none; b=hsUbLwv6mXV//dn7ZWc/klnI9DHziW5GdZZjIAiw9aoUpbNxAn++WvT0mqJfnaWh1+YZGG9M8GwdZWiDig/aLqefiQUxtbCTjSVJndKqtG8zapHTPDc8emP3eyxomeVPzIdgPgDU/+KhWY35rwaPp4WRnlsLZBEjd7kFrWXt2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658839; c=relaxed/simple;
	bh=+yaRAa3iVwMuPsAwlnfT1/m5O40XZLIBty6vrotlxA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLfwy7+5cvEWC9MGDMmjIlMbpqHv40P4df3UBnsh5IAs92dmBro+ZpKsnrNWlxs/EdnYZFHPdXulhjZ+8fY5RVauA9HiJFggvOQvnQhX1uSC0XF1pKLDXcTzGilgM/cPRW/puWCUHPYWL3B2MaAsB7I8rI2P5hFEUEc/+Hc9D7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJtCC8ra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJtCC8ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774051F00AC4;
	Sun,  2 Aug 2026 08:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785658835;
	bh=+LqOBy2ngMM4xWHUH3tp7KNp5UNBH05WCZeBTt5E6SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TJtCC8ra2dHoT/r8PYW3UjwmWnOG6UycEWPqFsMWp5V/0EB+/XJSy/1CwGU+yMIP5
	 1rbediqXE+jvtY4ILhBLzoQPjA/PPBj0LNPXjG1cUlLJ6gwGRv8B4scqF4EGm6UpsO
	 jzRbA/6dvDRr/Xr2z446Ye269GTtbaFmUC3Eu1xUUkvrsMQYOP+bJq3Uv2LtmQgu7Z
	 eZunYL/v165zUXAGT0g/lOdSLEt6bJsPXuGDjA+k//ELUpfkd6nQoIitsG+QUrZkGR
	 AWFyXiyFGFl+mHlBdOcTRA69OjXflKFuYr4bF64p4cDKwtuWA3M0kCJNB5lK3eAgRk
	 mew455E4bERVQ==
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
Subject: [PATCH v11 11/11] tracing/wprobe: Support BTF typecast in wprobe trigger command
Date: Sun,  2 Aug 2026 17:20:29 +0900
Message-ID: <178565882911.714490.6743463801101196758.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178565870538.714490.11309825813968306287.stgit@devnote2>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
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

Extend the set_wprobe trigger syntax to support automatic BTF-based
offset calculation using the form:

  set_wprobe:WPEVENT:(TYPE[,ASGN])FIELD->MEMBER[.SUBMEMBER[...]]

Previously, the ADJUST value in FIELD[+/-ADJUST] had to be a numeric
literal, requiring the user to know the exact byte offset of the
target struct member.

With this change, if the FIELD portion starts with (STRUCTTYPE), the
offset of MEMBER within STRUCTTYPE is automatically resolved via BTF.
This allows symbolic, kernel-version-independent watchpoint placement
at specific struct fields.

For example, to watch when the d_inode pointer inside a dentry is
modified (not just when the dentry itself is accessed):

  echo 'w:watch rw@0:8 address=$addr value=$value' >> dynamic_events
  echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
  echo 'set_wprobe:watch:(dentry)dentry->d_inode' \
           >> events/fprobes/truncate/trigger

Here, "dentry" is a field in the fprobe event record. The BTF
lookup resolves offsetof(struct dentry, d_inode) at set_wprobe parse
time, so no manual numeric offset is needed.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v11:
 - Fix BTF member offset calculation and bitfield check in
   get_offset_of_field().
 - Update trigger-wprobe-btf-offset.tc to use trace-events-sample
   kernel module.
Changes in v10:
 - Newly added.
---
 kernel/trace/trace_wprobe.c                        |  201 +++++++++++++++++---
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   74 +++++++
 2 files changed, 245 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 5a034dce0845..add7eae03917 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -27,6 +27,7 @@
 #include <asm/ptrace.h>
 
 #include "trace.h"
+#include "trace_btf.h"
 #include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_kernel.h"
@@ -935,9 +936,10 @@ static int wprobe_trigger_print(struct seq_file *m,
 		seq_printf(m, ":count=%ld", wprobe_data->count);
 
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
@@ -976,6 +978,155 @@ static void wprobe_trigger_free(struct event_trigger_data *data)
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
+					 struct wprobe_trigger_data *wprobe_data)
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
+	if (!event_field)
+		return -EINVAL;
+	*event_field++ = '\0';
+
+	/* Check the optional assign field. */
+	assign_field = strchr(type_name, ',');
+	if (assign_field)
+		*assign_field++ = '\0';
+
+	/* Get the type field name. */
+	type_field = strstr(event_field, "->");
+	if (!type_field)
+		return -EINVAL;
+	*type_field = '\0';
+	type_field += 2;
+
+	offs = strpbrk(type_field, "+-");
+	if (offs) {
+		if (kstrtol(offs, 0, &val) < 0)
+			return -EINVAL;
+		*offs = '\0';
+	}
+
+	/* find type from BTF */
+	id = bpf_find_btf_id(type_name, BTF_KIND_STRUCT, &btf);
+	if (id < 0)
+		return id;
+
+	type = btf_type_by_id(btf, id);
+	if (!type)
+		return -EINVAL;
+
+	adjust = get_offset_of_field(btf, type, type_field);
+	if (adjust < 0)
+		return adjust;
+	wprobe_data->adjust = adjust + val;
+
+	if (assign_field) {
+		/* assign_field should be a struct field */
+		adjust = get_offset_of_field(btf, type, assign_field);
+		if (adjust < 0)
+			return adjust;
+		wprobe_data->adjust -= adjust;
+	}
+
+	*field_str_ptr = event_field;
+	return 0;
+}
+#else
+static int wprobe_trigger_typecast_parse(char **field_str_ptr,
+					 struct wprobe_trigger_data *wprobe_data)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_PROBE_EVENTS_BTF_ARGS */
+
+static int wprobe_trigger_field_parse(char *field_str, struct trace_event_file *file,
+					struct wprobe_trigger_data *wprobe_data)
+{
+	struct ftrace_event_field *field;
+	char *offs;
+
+	if (field_str[0] == '(') {
+		int ret = wprobe_trigger_typecast_parse(&field_str, wprobe_data);
+
+		if (ret < 0)
+			return ret;
+	} else {
+		offs = strpbrk(field_str, "+-");
+		if (offs) {
+			long val;
+
+			if (kstrtol(offs, 0, &val) < 0)
+				return -EINVAL;
+			wprobe_data->adjust = val;
+			*offs = '\0';
+		}
+	}
+
+	field = trace_find_event_field(file->event_call, field_str);
+	if (!field)
+		return -ENOENT;
+	if (field->size != sizeof(void *))
+		return -ENOEXEC;
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
@@ -987,11 +1138,9 @@ static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 	 */
 	struct wprobe_trigger_data *wprobe_data __free(free_wprobe_trigger_data) = NULL;
 	struct event_trigger_data *trigger_data __free(kfree) = NULL;
-	char *event_str, *field_str, *count_str;
-	struct ftrace_event_field *field = NULL;
+	char *event_str, *count_str, *comment;
 	struct trace_event_file *wprobe_file;
 	struct trace_array *tr = file->tr;
-	struct trace_event_call *event;
 	bool remove, clear = false;
 	struct trace_wprobe *tw;
 	char *param, *filter;
@@ -1002,6 +1151,10 @@ static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 	if (!strcmp(cmd, CLEAR_WPROBE_STR))
 		clear = true;
 
+	comment = strchr(param_and_filter, '#');
+	if (comment)
+		*comment = '\0';
+
 	if (event_trigger_empty_param(param_and_filter))
 		return -EINVAL;
 
@@ -1032,34 +1185,22 @@ static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 
 	/* clear_wprobe does not need field. */
 	if (!clear) {
-		char *offs;
+		char *field_str = strsep(&param, ":");
 
-		/* Find target field, which must be equivarent to "void *" */
-		field_str = strsep(&param, ":");
 		if (!field_str)
 			return -EINVAL;
-
-		offs = strpbrk(field_str, "+-");
-		if (offs) {
-			long val;
-
-			if (kstrtol(offs, 0, &val) < 0)
-				return -EINVAL;
-			wprobe_data->adjust = val;
-			*offs = '\0';
+		ret = wprobe_trigger_field_parse(field_str, file, wprobe_data);
+		if (ret < 0)
+			return ret;
+	} else if (param) {
+		char *orig_param = param;
+		char *field_str = strsep(&param, ":");
+
+		ret = wprobe_trigger_field_parse(field_str, file, wprobe_data);
+		if (ret < 0) {
+			/* field_str was not a field, so it must be count_str */
+			param = orig_param;
 		}
-
-		event = file->event_call;
-		field = trace_find_event_field(event, field_str);
-		if (!field)
-			return -ENOENT;
-
-		if (field->size != sizeof(void *))
-			return -ENOEXEC;
-		wprobe_data->offset = field->offset;
-		wprobe_data->field = kstrdup(field_str, GFP_KERNEL);
-		if (!wprobe_data->field)
-			return -ENOMEM;
 	}
 
 	/* count is optional, "unlimited" by default */
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

