From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/44] perf trace: Allow setting up a syscall_tp struct without a format_field
Date: Thu,  9 Aug 2018 11:57:42 -0300
Message-ID: <20180809145822.21391-5-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To avoid having to ask libtraceevent to find a field by name when
handling each tracepoint event, we setup a struct syscall_tp with
a tp_field struct having an extractor function + the offset for the
"id", "args" and "ret" raw_syscalls:sys_{enter,exit} tracepoints.

Now that we want to do the same with syscalls:sys_{entry,exit}_NAME
individual syscall tracepoints, where we have "id" as "__syscall_nr" and
"args" as the actual series of per syscall parameters, we need more
flexibility from the routines that set up these pre-looked up syscall
tracepoint arg fields.

The next cset will use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-v59q5e0jrlzkpl9a1c7t81ni@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 039f94467968..7fca844ced0b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -156,13 +156,11 @@ TP_UINT_FIELD__SWAPPED(16);
 TP_UINT_FIELD__SWAPPED(32);
 TP_UINT_FIELD__SWAPPED(64);
 
-static int tp_field__init_uint(struct tp_field *field,
-			       struct format_field *format_field,
-			       bool needs_swap)
+static int __tp_field__init_uint(struct tp_field *field, int size, int offset, bool needs_swap)
 {
-	field->offset = format_field->offset;
+	field->offset = offset;
 
-	switch (format_field->size) {
+	switch (size) {
 	case 1:
 		field->integer = tp_field__u8;
 		break;
@@ -182,18 +180,28 @@ static int tp_field__init_uint(struct tp_field *field,
 	return 0;
 }
 
+static int tp_field__init_uint(struct tp_field *field, struct format_field *format_field, bool needs_swap)
+{
+	return __tp_field__init_uint(field, format_field->size, format_field->offset, needs_swap);
+}
+
 static void *tp_field__ptr(struct tp_field *field, struct perf_sample *sample)
 {
 	return sample->raw_data + field->offset;
 }
 
-static int tp_field__init_ptr(struct tp_field *field, struct format_field *format_field)
+static int __tp_field__init_ptr(struct tp_field *field, int offset)
 {
-	field->offset = format_field->offset;
+	field->offset = offset;
 	field->pointer = tp_field__ptr;
 	return 0;
 }
 
+static int tp_field__init_ptr(struct tp_field *field, struct format_field *format_field)
+{
+	return __tp_field__init_ptr(field, format_field->offset);
+}
+
 struct syscall_tp {
 	struct tp_field id;
 	union {
-- 
2.14.4
