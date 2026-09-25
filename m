Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88348D89A;
	Fri, 25 Sep 2026 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334835; cv=none; b=VQ5+IFu7K0mUWJIHBfdgid+j9ojJrXOznY53Ebi9/DMp8M8DCQ8KHyTw2lN3kp0wsJArz+0IeNP4LdNnzsUaQH0d1TIrB4dpVBDhHieIBn5pfPaMBXPodvizCGo+EMBfKIO3U4CgCQnlvygAOIWSx/T0kRSi8WUlpla9nc4bWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334835; c=relaxed/simple;
	bh=fskrN8wpHeBMg9wlFg565WjKwqm5GCMj6N23c+gwUTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYLZ37IOUG1fUMG03xxmtEQF9aArJaB1BndcDZqiMz6mbRxKu2NuNADUCqP8nFinOogWIqwNRAce0kQSA7/8d+vBKP3TxHyxnSt/MoVi5LWYFJ8TXjugbEa6mon1xY+EhBB9YOGecNHlsW4XQDNEqVMXkLIOAFyC8eoEY4sxwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MogTL6+X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MogTL6+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12C11F000FF;
	Fri, 25 Sep 2026 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334833;
	bh=9kdICNF36dlDcblK42B8LBZnE/ru2id1u0UxvE8DIyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MogTL6+X0kLdNJUaAy5JJlax0xECS8Y5BcgwEgDBwGBNfbyQINzmiQqxEdQHa6Pns
	 7P/wgRN8z0igUw2S10yFXuq7Y+tcsxczWbUHfomTk+Nv0SZ6yK1xszuldfu43GP/NX
	 EXnirK6cFbF1IDPPEIfqSycQhcKsiNcfKZIrNeueSu6mIH/f0Fq8clbKpKwLfZrums
	 C3RVhzuVhJTZX6e+akzLp62F7wWtPAeA+yZiMwoDNtrEauw1dB1neeocg2kH0eMysO
	 Z8+LFb2RqAnNBZslifQCe3//1WrEBQRzrYzBsoV1+Nuv7oJSysshGwyAlU91dN07yN
	 eJaVpggKknBmQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
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
	linux-perf-users@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v18 11/11] tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger
Date: Fri, 25 Sep 2026 20:13:42 +0900
Message-ID: <179033482254.136630.8855905927509420486.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179033464327.136630.864883694296882051.stgit@devnote2>
References: <179033464327.136630.864883694296882051.stgit@devnote2>
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

Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v18:
 - In get_offset_of_field(), rename mtype to container and document that
   it represents the containing structure/union type (handling anonymous
   structures/unions) rather than member's own type.
 - In get_offset_of_field(), verify bit offset is byte-aligned before
   returning byte offset.
 - Add "set_wprobe:<wprobe-event>":README to requires line in
   trigger-wprobe-btf-offset.tc so the test is skipped if
   CONFIG_WPROBE_TRIGGERS is disabled.
Changes in v15:
 - Duplicate field string to avoid modifying glob in place in
   wprobe_trigger_typecast_parse() so tracing_log_err() prints pristine
   command string.
 - Remove leftover offset and adjust debug print in wprobe_trigger_print().
 - Document BTF struct offset resolution syntax in wprobetrace.rst.
 - Add explicit failure checks with fail helper in
   trigger-wprobe-btf-offset.tc.
 - Declare fprobe README requirement in trigger-wprobe-btf-offset.tc.
Changes in v14:
 - Update dummy wprobe event definition to use '-1' instead of '0'.
 - Pass member_type to btf_find_struct_member() and check its kflag in
   get_offset_of_field().
Changes in v13:
 - Check for field token before calling wprobe_trigger_field_parse() in
   clear_wprobe to avoid spurious error log entries on numeric counts.
Changes in v12:
 - Refactor field parsing logic into wprobe_trigger_field_parse().
 - Remove unused variable count_str in wprobe_trigger_cmd_parse().
---
 Documentation/trace/wprobetrace.rst                |    7 
 kernel/trace/trace_wprobe.c                        |  304 +++++++++++++++-----
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   85 ++++++
 3 files changed, 318 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc

diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
index 20a11443c6db..1d9b32d02d53 100644
--- a/Documentation/trace/wprobetrace.rst
+++ b/Documentation/trace/wprobetrace.rst
@@ -90,10 +90,17 @@ Combination with trigger action
 The event trigger action can extend the utilization of this wprobe.
 
 - set_wprobe:WPEVENT:FIELD[+|-ADJUST][:COUNT]
+- set_wprobe:WPEVENT:(STRUCT[,ASGN])EVENT_FIELD->MEMBER[+|-ADJUST][:COUNT]
 - clear_wprobe:WPEVENT[:FIELD[+|-ADJUST][:COUNT]]
+- clear_wprobe:WPEVENT[:(STRUCT[,ASGN])EVENT_FIELD->MEMBER[+|-ADJUST][:COUNT]]
 
 Set these triggers to the target event, then the WPROBE event will be
 setup to trace the memory access at FIELD[+|-ADJUST] address.
+If BTF is supported, the target address can also be resolved using BTF
+struct offset resolution: `(STRUCT[,ASGN])EVENT_FIELD->MEMBER[+|-ADJUST]`.
+Here, EVENT_FIELD is an event field containing a pointer to STRUCT (or to
+the ASGN member if ASGN is specified), and MEMBER is the struct member whose
+offset is resolved automatically via BTF.
 When clear_wprobe is hit, if FIELD is NOT specified, the WPEVENT is
 forcibly cleared. If FIELD[+|-ADJUST] is set, it clears WPEVENT only
 if its watching address is the same as the FIELD[+|-ADJUST] value.
diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 31de7dd5bfd9..a79439cbfe6b 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -29,6 +29,7 @@
 #include <asm/ptrace.h>
 
 #include "trace.h"
+#include "trace_btf.h"
 #include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_kernel.h"
@@ -1194,6 +1195,223 @@ static void wprobe_trigger_free(struct event_trigger_data *data)
 	}
 }
 
+#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
+
+static int get_offset_of_field(struct btf *btf, const struct btf_type *type, char *field_name)
+{
+	const struct btf_member *field;
+	const struct btf_type *container;
+	int bitoffs = 0;
+	u32 anon_offs;
+	char *next;
+
+	do {
+		next = strchr(field_name, '.');
+		if (next)
+			*next++ = '\0';
+
+		anon_offs = 0;
+		/*
+		 * btf_find_struct_member() returns the actual containing
+		 * structure/union type in @container (which can be an
+		 * inner anonymous struct/union rather than @type).
+		 */
+		field = btf_find_struct_member(btf, type, field_name, &anon_offs, &container);
+		if (IS_ERR_OR_NULL(field))
+			return -ENOENT;
+
+		if (btf_type_kflag(container)) {
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
+
+	if (bitoffs % BITS_PER_BYTE)
+		return -EINVAL;
+
+	return bitoffs / BITS_PER_BYTE;
+}
+
+/* btf_put(NULL) is acceptable. */
+DEFINE_FREE(btf_put, struct btf *, btf_put(_T))
+
+/* parse typecast: (TYPE[,ASGN])EVENT_FIELD->FIELD[.SUBFIELD...][+-OFFS] and set adjust. */
+static int wprobe_trigger_typecast_parse(char *field_str,
+					 struct trace_event_file *file,
+					 struct wprobe_trigger_data *wprobe_data,
+					 const char *glob)
+{
+	struct btf *btf __free(btf_put) = NULL;
+	char *buf __free(kfree) = NULL;
+	struct ftrace_event_field *field;
+	const struct btf_type *type;
+	char *assign_field;
+	char *event_field;
+	char *type_field;
+	char *type_name;
+	char *offs;
+	long val = 0;
+	int base_offset = field_str - glob;
+	int event_field_offset;
+	int id, adjust;
+
+	buf = kstrdup(field_str, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	type_name = buf + 1;
+	event_field = strchr(type_name, ')');
+	if (!event_field) {
+		wprobe_trigger_log_err(file, glob,
+				       base_offset + (type_name - buf),
+				       DEREF_OPEN_BRACE);
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
+		wprobe_trigger_log_err(file, glob,
+				       base_offset + (event_field - buf),
+				       TYPECAST_REQ_FIELD);
+		return -EINVAL;
+	}
+	*type_field = '\0';
+	type_field += 2;
+
+	offs = strpbrk(type_field, "+-");
+	if (offs) {
+		if (kstrtol(offs, 0, &val) < 0) {
+			wprobe_trigger_log_err(file, glob,
+					       base_offset + (offs - buf),
+					       BAD_DEREF_OFFS);
+			return -EINVAL;
+		}
+		*offs = '\0';
+	}
+
+	/* find type from BTF */
+	id = bpf_find_btf_id(type_name, BTF_KIND_STRUCT, &btf);
+	if (id < 0) {
+		wprobe_trigger_log_err(file, glob,
+				       base_offset + (type_name - buf),
+				       BAD_BTF_TID);
+		return id;
+	}
+
+	type = btf_type_by_id(btf, id);
+	if (!type) {
+		wprobe_trigger_log_err(file, glob,
+				       base_offset + (type_name - buf),
+				       BAD_BTF_TID);
+		return -EINVAL;
+	}
+
+	adjust = get_offset_of_field(btf, type, type_field);
+	if (adjust < 0) {
+		wprobe_trigger_log_err(file, glob,
+				       base_offset + (type_field - buf),
+				       NO_BTF_FIELD);
+		return adjust;
+	}
+	wprobe_data->adjust = adjust + val;
+
+	if (assign_field) {
+		/* assign_field should be a struct field */
+		adjust = get_offset_of_field(btf, type, assign_field);
+		if (adjust < 0) {
+			wprobe_trigger_log_err(file, glob,
+					       base_offset + (assign_field - buf),
+					       NO_BTF_FIELD);
+			return adjust;
+		}
+		wprobe_data->adjust -= adjust;
+	}
+
+	event_field_offset = base_offset + (event_field - buf);
+	field = trace_find_event_field(file->event_call, event_field);
+	if (!field) {
+		wprobe_trigger_log_err(file, glob, event_field_offset, NO_EVENT_FIELD);
+		return -ENOENT;
+	}
+	if (field->size != sizeof(void *)) {
+		wprobe_trigger_log_err(file, glob, event_field_offset, WPROBE_BAD_FIELD);
+		return -ENOEXEC;
+	}
+	wprobe_data->offset = field->offset;
+	wprobe_data->field = kstrdup(event_field, GFP_KERNEL);
+	if (!wprobe_data->field)
+		return -ENOMEM;
+
+	return 0;
+}
+#else
+static int wprobe_trigger_typecast_parse(char *field_str,
+					 struct trace_event_file *file,
+					 struct wprobe_trigger_data *wprobe_data,
+					 const char *glob)
+{
+	wprobe_trigger_log_err(file, glob, field_str - glob, NOSUP_BTFARG);
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
+	if (field_str[0] == '(')
+		return wprobe_trigger_typecast_parse(field_str, file, wprobe_data, glob);
+
+	offs = strpbrk(field_str, "+-");
+	if (offs) {
+		long val;
+
+		if (kstrtol(offs, 0, &val) < 0) {
+			wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
+			return -EINVAL;
+		}
+		wprobe_data->adjust = val;
+		*offs = '\0';
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
@@ -1206,10 +1424,8 @@ static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 	struct wprobe_trigger_data *wprobe_data = NULL;
 	struct event_trigger_data *trigger_data = NULL;
 	struct trace_event_file *wprobe_file;
+	char *event_str, *comment;
 	struct trace_array *tr = file->tr;
-	char *event_str, *field_str, *comment;
-	struct ftrace_event_field *field;
-	struct trace_event_call *event;
 	bool remove, clear = false;
 	unsigned long orig_addr = 0;
 	struct trace_wprobe *tw;
@@ -1270,93 +1486,25 @@ static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 
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
+		ret = wprobe_trigger_field_parse(field_str, file, wprobe_data, glob);
+		if (ret < 0)
 			goto out_free;
-		}
-	} else if (param && (isalpha(param[0]) || param[0] == '_')) {
+	} else if (param && (isalpha(param[0]) || param[0] == '_' || param[0] == '(')) {
 		if (strncmp(param, "count=", 6) != 0 &&
 		    (strcmp(param, "unlimited") != 0 ||
 		     trace_find_event_field(file->event_call, "unlimited"))) {
-			char *offs;
-
-			field_str = strsep(&param, ":");
-			offs = strpbrk(field_str, "+-");
-			if (offs) {
-				long val;
-
-				if (kstrtol(offs, 0, &val) < 0) {
-					wprobe_trigger_log_err(file, glob,
-							       offs - glob,
-							       BAD_DEREF_OFFS);
-					ret = -EINVAL;
-					goto out_free;
-				}
-				wprobe_data->adjust = val;
-				*offs = '\0';
-			}
-
-			event = file->event_call;
-			field = trace_find_event_field(event, field_str);
-			if (!field) {
-				wprobe_trigger_log_err(file, glob,
-						       field_str - glob,
-						       NO_EVENT_FIELD);
-				ret = -ENOENT;
-				goto out_free;
-			}
+			char *field_str = strsep(&param, ":");
 
-			if (field->size != sizeof(void *)) {
-				wprobe_trigger_log_err(file, glob,
-						       field_str - glob,
-						       WPROBE_BAD_FIELD);
-				ret = -ENOEXEC;
+			ret = wprobe_trigger_field_parse(field_str, file, wprobe_data, glob);
+			if (ret < 0)
 				goto out_free;
-			}
-			wprobe_data->offset = field->offset;
-			wprobe_data->field = kstrdup(field_str, GFP_KERNEL);
-			if (!wprobe_data->field) {
-				ret = -ENOMEM;
-				goto out_free;
-			}
 		}
 	}
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc
new file mode 100644
index 000000000000..eda6584c286f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc
@@ -0,0 +1,85 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test set_wprobe trigger with BTF struct offset
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README events/sched/sched_process_fork/trigger "[(structname[,field])]<argname>[->field[->field|.field...]]":README "set_wprobe:<wprobe-event>":README
+
+fail() { #msg
+  echo "$1"
+  exit_fail
+}
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
+echo 'w:watch rw@-1:8 address=$addr value=$value' >> dynamic_events
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
+if ! grep -q ^set_wprobe events/fprobes/testevent/trigger; then
+  fail "Failed to set set_wprobe trigger"
+fi
+
+# Wait for sample_timer_cb to fire and set_wprobe trigger to activate
+sleep 3
+
+:;: "Check set_wprobe trigger activated the watchpoint" ;:
+if ! grep -q watch trace; then
+  fail "Failed to trigger watchpoint"
+fi
+
+:;: "Remove wprobe triggers" ;:
+# Since we don't know actual offset of timer->expires in foo_timer_data, we use reset_trigger_file
+reset_trigger_file events/fprobes/testevent/trigger
+if grep -q ^set_wprobe events/fprobes/testevent/trigger; then
+  fail "Failed to remove set_wprobe trigger"
+fi
+
+:;: "Disable events and remove dynamic events" ;:
+echo 0 > events/enable
+echo > dynamic_events
+clear_trace
+
+exit 0

