Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EBC44CF29;
	Wed, 22 Jul 2026 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761484; cv=none; b=C9ndv7DcC9cw0dEYHttoyPzpmheAWQwNVrOWOidvJkBmcAB4jNi5ImoY8mhExoAN/lKBysbHgIME12eo7fkfUdPAR91J3aTaRUsLQU/0tDfgzdmL202LgdRjl5VJWUYViPHFqgGE9fjAo/v5aNszdR3uEFXoU/NdV7bZ0tJ2pu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761484; c=relaxed/simple;
	bh=Pwp3DTbDWAHMZBKTIp3inueKr/FH671qpG5umKXf9NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5jCsw4KVsIbWisvl0MRHt+I79u3anm38WMWRO8U7hi9uSb19tgvCnj1mtYN+92w7bAhVylJT8xDEdRrrq/TwLgR35wG2Re2xwl9LynGB4+wjltb7GBVy7b01slwCtB6TwtZ3yuUEhyZZ5cMDKECpLQ6PEpBOEsMbUS+m9yxNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4i3DdXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4i3DdXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAB01F000E9;
	Wed, 22 Jul 2026 23:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761482;
	bh=OFfrTirb0RoZWwyLYN5/BFmnIozpd9sUJoG452yw/XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E4i3DdXALdGCRrfP/cWZ9lRk7zZD98n3LRzXjkb1XqVEJDIIBF5rtIQz/efksHvAg
	 i4gwoTKQAuqGXwOpFkGX+cx6M9ztvpJUfx+tMk4XOvHrNyypzwWQJlaEwScpKnCj9M
	 otJ747jAdFmsgB6azZEJQhsHaPHeik+JWQNO1wRg7fF2VWfXcW/kWCsEWZVlqg+h2U
	 jOkNS/eiI9PqxYv1alAbZw3EgSAnXJsRxlzf7fpIWpqJRq/3Ynue7Anu3nLyz3wV3L
	 1dQap0wX5yiWaKLsY7C+9njZLKhp5UAHvrDJe+OpjXuraXrmAbc6CsT0cftrYHhLF6
	 P0Omsi9y7bKOw==
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
Subject: [PATCH v10 11/11] tracing/wprobe: Support BTF typecast in wprobe trigger command
Date: Thu, 23 Jul 2026 08:04:36 +0900
Message-ID: <178476147632.26117.14371948325944867725.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178476134787.26117.10094977293012760490.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
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
 Changes in v10:
  - Newly added.
---
 kernel/trace/trace_wprobe.c                        |  166 +++++++++++++++++---
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   73 +++++++++
 2 files changed, 214 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 1edfdddf241d..2926eabfe3c1 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -27,6 +27,7 @@
 #include <asm/ptrace.h>
 
 #include "trace.h"
+#include "trace_btf.h"
 #include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_kernel.h"
@@ -925,6 +926,143 @@ static void wprobe_trigger_free(struct event_trigger_data *data)
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
+		type = btf_type_by_id(btf, field->type);
+
+		/* Reject bitfield member access */
+		if (btf_type_kflag(type))
+			return -EINVAL;
+
+		/* add offset for anonymous struct type */
+		bitoffs += anon_offs + field->offset;
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
+	wprobe_data->adjust = adjust;
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
+static int wprobe_trigger_typecast_parse(char **field_str_ptr, struct wprobe_trigger_data *wprobe_data)
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
@@ -936,10 +1074,8 @@ static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 	 */
 	struct wprobe_trigger_data *wprobe_data __free(free_wprobe_trigger_data) = NULL;
 	struct event_trigger_data *trigger_data __free(kfree) = NULL;
-	struct ftrace_event_field *field = NULL;
 	struct trace_event_file *wprobe_file;
 	struct trace_array *tr = file->tr;
-	struct trace_event_call *event;
 	char *event_str, *field_str;
 	bool remove, clear = false;
 	struct trace_wprobe *tw;
@@ -986,29 +1122,9 @@ static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 		return -EINVAL;
 
 	if (field_str) {
-		char *offs;
-
-		offs = strpbrk(field_str, "+-");
-		if (offs) {
-			long val;
-
-			if (kstrtol(offs, 0, &val) < 0)
-				return -EINVAL;
-			wprobe_data->adjust = val;
-			*offs = '\0';
-		}
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
+		ret = wprobe_trigger_field_parse(field_str, file, wprobe_data);
+		if (ret < 0)
+			return ret;
 	}
 
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, wprobe_data);
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc
new file mode 100644
index 000000000000..b79427caf974
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc
@@ -0,0 +1,73 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test set_wprobe trigger with BTF struct offset
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README events/sched/sched_process_fork/trigger "[(structname[,field])]<argname>[->field[->field|.field...]]":README
+
+echo 0 >> tracing_on
+
+rm -f $TMPDIR/hoge
+
+# we will skip this test if fprobe is not supported.
+if ! grep -Fq "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README; then
+    echo "UNRESOLVED: fprobe is not supported"
+    exit_unresolved
+fi
+
+# we will skip this test if the target function does not exist.
+if ! grep -wq "do_truncate" /proc/kallsyms; then
+    echo "UNRESOLVED: do_truncate not found"
+    exit_unresolved
+fi
+if ! grep -wq "dentry_kill" /proc/kallsyms; then
+    echo "UNRESOLVED: dentry_kill not found"
+    exit_unresolved
+fi
+
+:;: "Add a wprobe event watching 8 bytes" ;:
+echo 'w:watch rw@0:8 address=$addr value=$value' >> dynamic_events
+
+:;: "Add fprobe events for do_truncate and dentry_kill" ;:
+echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
+echo 'f:dentry_kill dentry_kill dentry=$arg1' >> dynamic_events
+
+:;: "Add set_wprobe trigger using BTF struct offset resolution" ;:
+# Syntax: set_wprobe:WPEVENT:(STRUCT)EVENT_FIELD->MEMBER
+# (dentry) is the BTF struct type (without 'struct' keyword, matching fetcharg syntax)
+# dentry   is the event record field name holding the pointer
+# d_inode  is the struct member whose offset is resolved automatically via BTF
+# This sets the watchpoint at the resolved d_inode pointer.
+echo 'set_wprobe:watch:(dentry)dentry->d_inode' >> events/fprobes/truncate/trigger
+echo 'clear_wprobe:watch:dentry' >> events/fprobes/dentry_kill/trigger
+
+:;: "Verify triggers are set" ;:
+cat events/fprobes/truncate/trigger | grep ^set_wprobe
+cat events/fprobes/dentry_kill/trigger | grep ^clear_wprobe
+
+:;: "Ensure wprobe is still disabled" ;:
+cat events/wprobes/watch/enable | grep 0
+
+:;: "Enable fprobe events" ;:
+echo 1 >> events/fprobes/truncate/enable
+echo 1 >> events/fprobes/dentry_kill/enable
+
+:;: "Start test workload" ;:
+echo 1 >> tracing_on
+
+echo aaa > $TMPDIR/hoge
+echo bbb > $TMPDIR/hoge
+echo ccc > $TMPDIR/hoge
+rm $TMPDIR/hoge
+
+:;: "Drop dentry caches (for dentry_kill)" ;:
+sync && echo 2 >> /proc/sys/vm/drop_caches
+
+:;: "Check trace results" ;:
+cat trace | grep watch
+
+:;: "Remove wprobe triggers" ;:
+echo '!set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
+echo '!clear_wprobe:watch' >> events/fprobes/dentry_kill/trigger
+! grep ^set_wprobe events/fprobes/truncate/trigger
+! grep ^clear_wprobe events/fprobes/dentry_kill/trigger
+
+exit 0

