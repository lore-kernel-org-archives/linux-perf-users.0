Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832652918F6;
	Thu, 24 Apr 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522657; cv=none; b=czeV8mIpHueatw0yQUgO0bYnvQ5YEcLbLdDcmRaQOzTinhLu5vAoUhvjD+/dM/O03iqpMpTEZ2489DuDzBcgnFlVjgDO7qBCkfHzmW1eDaHDQvx9m7UhzLTP4Si6Wt6Hd8hjlp9bDFoqCi4S5g8Nm9xNCSM9DyvzIpjXvTjL71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522657; c=relaxed/simple;
	bh=ajvnsllmRpQFIX6Qgf3TWPxF1BZqvJ/hp9YJ40O7mK8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Q2spTwjADK6K7Pn0kYyrHY+RIA57wbMuMcgJutEvpr+f/aGW+XzxkIDtMlMm8cvzNoQFL6sMZ8JzprTw+pfFQZe0TElQa9sLnvjTRxYbXEe95Q5mGCNApbpJ5qU0Ub0udmL5Vr1fcOwYdXJwpEYddErcYQWi0CgacZx+UYI77qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145B5C2BCB1;
	Thu, 24 Apr 2025 19:24:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u82D7-0000000H2Qg-1P4M;
	Thu, 24 Apr 2025 15:26:13 -0400
Message-ID: <20250424192613.183589150@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 15:25:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v5 5/9] tracing: Rename __dynamic_array() to __dynamic_field() for ftrace
 events
References: <20250424192456.851953422@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace events (like function, trace_print, etc) are created somewhat
manually and not via the TRACE_EVENT() or tracepoint magic macros. It has
its own macros.

The dynamic fields used __dynamic_array() to be created, but the output is
different than the __dynamic_array() used by TRACE_EVENT().

The TRACE_EVENT() __dynamic_array() creates the field like:

	field:__data_loc u8[] v_data;   offset:120;     size:4; signed:0;

Whereas the ftrace event is created as:

	field:char buf[];       offset:12;      size:0; signed:0;

The difference is that the ftrace field is defined as the rest of the size
of the event saved in the ring buffer. TRACE_EVENT() doesn't have such a
dynamic field, and its version saves a word that holds the offset into the
event that the field is stored, as well as the size.

For consistency rename the ftrace event macro to __dynamic_field(). This
way the ftrace event can also include a __dynamic_array() later that works
the same as the TRACE_EVENT() dynamic array.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h         |  4 ++--
 kernel/trace/trace_entries.h | 10 +++++-----
 kernel/trace/trace_export.c  | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 79be1995db44..3c733b9e7b32 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -92,8 +92,8 @@ enum trace_type {
 #undef __array_desc
 #define __array_desc(type, container, item, size)
 
-#undef __dynamic_array
-#define __dynamic_array(type, item)	type	item[];
+#undef __dynamic_field
+#define __dynamic_field(type, item)	type	item[];
 
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item)	type	item[];
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 4ef4df6623a8..7100d8f86011 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -63,7 +63,7 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
 	F_STRUCT(
 		__field_fn(	unsigned long,		ip		)
 		__field_fn(	unsigned long,		parent_ip	)
-		__dynamic_array( unsigned long,		args		)
+		__dynamic_field( unsigned long,		args		)
 	),
 
 	F_printk(" %ps <-- %ps",
@@ -81,7 +81,7 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
 		__field_packed(	unsigned long,	graph_ent,	func		)
 		__field_packed(	unsigned int,	graph_ent,	depth		)
-		__dynamic_array(unsigned long,	args				)
+		__dynamic_field(unsigned long,	args				)
 	),
 
 	F_printk("--> %ps (%u)", (void *)__entry->func, __entry->depth)
@@ -259,7 +259,7 @@ FTRACE_ENTRY(bprint, bprint_entry,
 	F_STRUCT(
 		__field(	unsigned long,	ip	)
 		__field(	const char *,	fmt	)
-		__dynamic_array(	u32,	buf	)
+		__dynamic_field(	u32,	buf	)
 	),
 
 	F_printk("%ps: %s",
@@ -272,7 +272,7 @@ FTRACE_ENTRY_REG(print, print_entry,
 
 	F_STRUCT(
 		__field(	unsigned long,	ip	)
-		__dynamic_array(	char,	buf	)
+		__dynamic_field(	char,	buf	)
 	),
 
 	F_printk("%ps: %s",
@@ -287,7 +287,7 @@ FTRACE_ENTRY(raw_data, raw_data_entry,
 
 	F_STRUCT(
 		__field(	unsigned int,	id	)
-		__dynamic_array(	char,	buf	)
+		__dynamic_field(	char,	buf	)
 	),
 
 	F_printk("id:%04x %08x",
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 1698fc22afa0..d9d41e3ba379 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -57,8 +57,8 @@ static int ftrace_event_register(struct trace_event_call *call,
 #undef __array_desc
 #define __array_desc(type, container, item, size)	type item[size];
 
-#undef __dynamic_array
-#define __dynamic_array(type, item)			type item[];
+#undef __dynamic_field
+#define __dynamic_field(type, item)			type item[];
 
 #undef F_STRUCT
 #define F_STRUCT(args...)				args
@@ -123,8 +123,8 @@ static void __always_unused ____ftrace_check_##name(void)		\
 #undef __array_desc
 #define __array_desc(_type, _container, _item, _len) __array(_type, _item, _len)
 
-#undef __dynamic_array
-#define __dynamic_array(_type, _item) {					\
+#undef __dynamic_field
+#define __dynamic_field(_type, _item) {					\
 	.type = #_type "[]", .name = #_item,				\
 	.size = 0, .align = __alignof__(_type),				\
 	is_signed_type(_type), .filter_type = FILTER_OTHER },
@@ -161,8 +161,8 @@ static struct trace_event_fields ftrace_event_fields_##name[] = {	\
 #undef __array_desc
 #define __array_desc(type, container, item, len)
 
-#undef __dynamic_array
-#define __dynamic_array(type, item)
+#undef __dynamic_field
+#define __dynamic_field(type, item)
 
 #undef F_printk
 #define F_printk(fmt, args...) __stringify(fmt) ", "  __stringify(args)
-- 
2.47.2


