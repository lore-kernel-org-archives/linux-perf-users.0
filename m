From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/32] tools lib traceevent: Fix get_field_str() for dynamic strings
Date: Wed, 17 Jan 2018 13:12:07 -0300
Message-ID: <20180117161222.15611-18-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a field is a dynamic string, get_field_str() returned just the
offset/size value and not the string. Have it parse the offset/size
correctly to return the actual string. Otherwise filtering fails when
trying to filter fields that are dynamic strings.

Reported-by: Gopanapalli Pradeep <prap_hai@yahoo.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004823.146333275@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/parse-filter.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 2b9048f90bae..431e8b309f6e 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1877,17 +1877,25 @@ static const char *get_field_str(struct filter_arg *arg, struct pevent_record *r
 	struct pevent *pevent;
 	unsigned long long addr;
 	const char *val = NULL;
+	unsigned int size;
 	char hex[64];
 
 	/* If the field is not a string convert it */
 	if (arg->str.field->flags & FIELD_IS_STRING) {
 		val = record->data + arg->str.field->offset;
+		size = arg->str.field->size;
+
+		if (arg->str.field->flags & FIELD_IS_DYNAMIC) {
+			addr = *(unsigned int *)val;
+			val = record->data + (addr & 0xffff);
+			size = addr >> 16;
+		}
 
 		/*
 		 * We need to copy the data since we can't be sure the field
 		 * is null terminated.
 		 */
-		if (*(val + arg->str.field->size - 1)) {
+		if (*(val + size - 1)) {
 			/* copy it */
 			memcpy(arg->str.buffer, val, arg->str.field->size);
 			/* the buffer is already NULL terminated */
-- 
2.14.3
