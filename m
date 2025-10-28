Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977F36C22D;
	Tue, 28 Oct 2025 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693070; cv=none; b=I8lVDG49X5WrOD1oiC0hbPxMbvVAE+Lg3jKASvZwNTrlYGv2oRkmMG72pvfl+VsFEkXfyL7HW2V+CeX5PB5NptA7AcfURxEyS/wEQkEydQCnlMam/U3CkqMuvqjFPgP9XuARq78/rVyKDu2KgXRHOPK8owQ5dT9xPZm6j95ObuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693070; c=relaxed/simple;
	bh=wMndS1zpOKjDai9i3vF4Mrgfka5EbpCT2G1NvoumHq4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TZtO+/eWUXZ+l8vEI7f+P2vUiurqMNdKvD2cRGKN/xeUfXQnA/p8nQpLBZfz7ueltEWJ8MGPhTzOYNU77jL9JovGoequhjkcGwTxk4DnQGp+lg8AddK02jlHyA6SeBtFQJ9pjirvgCZgsk6ch7ed3CrL3N5/tVluJdrpb/W9tNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evt3jJDT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evt3jJDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AFDC4CEE7;
	Tue, 28 Oct 2025 23:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761693069;
	bh=wMndS1zpOKjDai9i3vF4Mrgfka5EbpCT2G1NvoumHq4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=evt3jJDTSe2z/nQn0SpOdg3Zj6KB6RTSTaRRxh1/02ni5Ogg7fELX0g/QulSz4U8L
	 42WbN5xdHhqrSoW9ZcDnyPRfrKewFdEWQoEaX11WBCutXSCIJXw1PwsnICDiPMi0hw
	 InOejdvo8NnsI3KDAMWl2Bf4I6Ax6w8VN4pthmt/qzRsk3Xn1EX2cihwKpKaYLDzdi
	 3wHFfEoqNxG5BZOkqMpMCZ8zcr3HOqpZrhiIniMJthHwvyjvQBESiiiZP8FZtQeTox
	 RROwWvdiK39oLwQJijKHA9XCFdBgIPE8TXnd57dSDZxxENKvsRSOsw7IeJmuOLEBNx
	 NkWFrG4F0fmAA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDsqy-00000004qu9-3otn;
	Tue, 28 Oct 2025 19:11:48 -0400
Message-ID: <20251028231148.763161484@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 28 Oct 2025 19:11:25 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v5 11/13] tracing: Add parsing of flags to the sys_enter_openat trace event
References: <20251028231114.820213884@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add some logic to give the openat system call trace event a bit more human
readable information:

   syscalls:sys_enter_openat: dfd: 0xffffff9c, filename: 0x7f0053dc121c "/etc/ld.so.cache", flags: O_RDONLY|O_CLOEXEC, mode: 0000

The above is output from "perf script" and now shows the flags used by the
openat system call.

Since the output from tracing is in the kernel, it can also remove the
mode field when not used (when flags does not contain O_CREATE|O_TMPFILE)

   touch-1185    [002] ...1.  1291.690154: sys_openat(dfd: 4294967196, filename: 139785545139344 "/usr/lib/locale/locale-archive", flags: O_RDONLY|O_CLOEXEC)
   touch-1185    [002] ...1.  1291.690504: sys_openat(dfd: 18446744073709551516, filename: 140733603151330 "/tmp/x", flags: O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, mode: 0666)

As system calls have a fixed ABI, their trace events can be extended. This
currently only updates the openat system call, but others may be extended
in the future.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 192 ++++++++++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 2d1307f13e13..47d9771e8f7c 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -127,6 +127,116 @@ const char *get_syscall_name(int syscall)
 /* Added to user strings or arrays when max limit is reached */
 #define EXTRA "..."
 
+static void get_dynamic_len_ptr(struct syscall_trace_enter *trace,
+				struct syscall_metadata *entry,
+				int *offset_p, int *len_p, unsigned char **ptr_p)
+{
+	unsigned char *ptr;
+	int offset = *offset_p;
+	int val;
+
+	/* This arg points to a user space string */
+	ptr = (void *)trace->args + sizeof(long) * entry->nb_args + offset;
+	val = *(int *)ptr;
+
+	/* The value is a dynamic string (len << 16 | offset) */
+	ptr = (void *)trace + (val & 0xffff);
+	*len_p = val >> 16;
+	offset += 4;
+
+	*ptr_p = ptr;
+	*offset_p = offset;
+}
+
+static enum print_line_t
+sys_enter_openat_print(struct syscall_trace_enter *trace, struct syscall_metadata *entry,
+		       struct trace_seq *s, struct trace_event *event)
+{
+	unsigned char *ptr;
+	int offset = 0;
+	int bits, len;
+	bool done = false;
+	static const struct trace_print_flags __flags[] =
+		{
+			{ O_TMPFILE, "O_TMPFILE" },
+			{ O_WRONLY, "O_WRONLY" },
+			{ O_RDWR, "O_RDWR" },
+			{ O_CREAT, "O_CREAT" },
+			{ O_EXCL, "O_EXCL" },
+			{ O_NOCTTY, "O_NOCTTY" },
+			{ O_TRUNC, "O_TRUNC" },
+			{ O_APPEND, "O_APPEND" },
+			{ O_NONBLOCK, "O_NONBLOCK" },
+			{ O_DSYNC, "O_DSYNC" },
+			{ O_DIRECT, "O_DIRECT" },
+			{ O_LARGEFILE, "O_LARGEFILE" },
+			{ O_DIRECTORY, "O_DIRECTORY" },
+			{ O_NOFOLLOW, "O_NOFOLLOW" },
+			{ O_NOATIME, "O_NOATIME" },
+			{ O_CLOEXEC, "O_CLOEXEC" },
+			{ -1, NULL }
+		};
+
+	trace_seq_printf(s, "%s(", entry->name);
+
+	for (int i = 0; !done && i < entry->nb_args; i++) {
+
+		if (trace_seq_has_overflowed(s))
+			goto end;
+
+		if (i)
+			trace_seq_puts(s, ", ");
+
+		switch (i) {
+		case 2:
+			bits = trace->args[2];
+
+			trace_seq_puts(s, "flags: ");
+
+			/* No need to show mode when not creating the file */
+			if (!(bits & (O_CREAT|O_TMPFILE)))
+				done = true;
+
+			if (!(bits & O_ACCMODE)) {
+				if (!bits) {
+					trace_seq_puts(s, "O_RDONLY");
+					continue;
+				}
+				trace_seq_puts(s, "O_RDONLY|");
+			}
+
+			trace_print_flags_seq(s, "|", bits, __flags);
+			/*
+			 * trace_print_flags_seq() adds a '\0' to the
+			 * buffer, but this needs to append more to the seq.
+			 */
+			if (!trace_seq_has_overflowed(s))
+				trace_seq_pop(s);
+
+			continue;
+		case 3:
+			trace_seq_printf(s, "%s: 0%03o", entry->args[i],
+					 (unsigned int)trace->args[i]);
+			continue;
+		}
+
+		trace_seq_printf(s, "%s: %lu", entry->args[i],
+				 trace->args[i]);
+
+		if (!(BIT(i) & entry->user_mask))
+			continue;
+
+		get_dynamic_len_ptr(trace, entry, &offset, &len, &ptr);
+		trace_seq_printf(s, " \"%.*s\"", len, ptr);
+	}
+
+	trace_seq_putc(s, ')');
+end:
+	trace_seq_putc(s, '\n');
+
+	return trace_handle_return(s);
+}
+
 static enum print_line_t
 print_syscall_enter(struct trace_iterator *iter, int flags,
 		    struct trace_event *event)
@@ -152,6 +262,15 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		goto end;
 	}
 
+	switch (entry->syscall_nr) {
+	case __NR_openat:
+		if (!tr || !(tr->trace_flags & TRACE_ITER_VERBOSE))
+			return sys_enter_openat_print(trace, entry, s, event);
+		break;
+	default:
+		break;
+	}
+
 	trace_seq_printf(s, "%s(", entry->name);
 
 	for (i = 0; i < entry->nb_args; i++) {
@@ -179,14 +298,7 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		if (!(BIT(i) & entry->user_mask))
 			continue;
 
-		/* This arg points to a user space string */
-		ptr = (void *)trace->args + sizeof(long) * entry->nb_args + offset;
-		val = *(int *)ptr;
-
-		/* The value is a dynamic string (len << 16 | offset) */
-		ptr = (void *)ent + (val & 0xffff);
-		len = val >> 16;
-		offset += 4;
+		get_dynamic_len_ptr(trace, entry, &offset, &len, &ptr);
 
 		if (entry->user_arg_size < 0 || entry->user_arg_is_str) {
 			trace_seq_printf(s, " \"%.*s\"", len, ptr);
@@ -269,6 +381,62 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
 	.size = sizeof(_type), .align = __alignof__(_type),		\
 	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER }
 
+/* When len=0, we just calculate the needed length */
+#define LEN_OR_ZERO (len ? len - pos : 0)
+
+static int __init
+sys_enter_openat_print_fmt(struct syscall_metadata *entry, char *buf, int len)
+{
+	int pos = 0;
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"\"dfd: 0x%%08lx, filename: 0x%%08lx \\\"%%s\\\", flags: %%s%%s, mode: 0%%03o\",");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" ((unsigned long)(REC->dfd)),");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" ((unsigned long)(REC->filename)),");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" __get_str(__filename_val),");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" (REC->flags & ~3) && !(REC->flags & 3) ? \"O_RDONLY|\" : \"\", ");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" REC->flags ? __print_flags(REC->flags, \"|\", ");
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_WRONLY\" }, ", O_WRONLY);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_RDWR\" }, ", O_RDWR);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_CREAT\" }, ", O_CREAT);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_EXCL\" }, ", O_EXCL);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_NOCTTY\" }, ", O_NOCTTY);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_TRUNC\" }, ", O_TRUNC);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_APPEND\" }, ", O_APPEND);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_NONBLOCK\" }, ", O_NONBLOCK);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_DSYNC\" }, ", O_DSYNC);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_DIRECT\" }, ", O_DIRECT);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_LARGEFILE\" }, ", O_LARGEFILE);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_DIRECTORY\" }, ", O_DIRECTORY);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_NOFOLLOW\" }, ", O_NOFOLLOW);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_NOATIME\" }, ", O_NOATIME);
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			"{ 0x%x, \"O_CLOEXEC\" }) : \"O_RDONLY\", ", O_CLOEXEC);
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO,
+			" ((unsigned long)(REC->mode))");
+	return pos;
+}
+
 static int __init
 __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 {
@@ -276,8 +444,12 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 	int i;
 	int pos = 0;
 
-	/* When len=0, we just calculate the needed length */
-#define LEN_OR_ZERO (len ? len - pos : 0)
+	switch (entry->syscall_nr) {
+	case __NR_openat:
+		return sys_enter_openat_print_fmt(entry, buf, len);
+	default:
+		break;
+	}
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 	for (i = 0; i < entry->nb_args; i++) {
-- 
2.51.0


