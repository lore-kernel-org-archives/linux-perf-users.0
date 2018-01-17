From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/32] tools lib traceevent: Show contents (in hex) of data of unrecognized type records
Date: Wed, 17 Jan 2018 13:12:03 -0300
Message-ID: <20180117161222.15611-14-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When a record has an unrecognized type, an error message is reported,
but it would also be helpful to see the contents of that record. At
least show what it is in hex, instead of just showing a blank line.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004822.542204577@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 344a034a8fbc..e5f2acbb70cc 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5566,8 +5566,14 @@ void pevent_print_event(struct pevent *pevent, struct trace_seq *s,
 
 	event = pevent_find_event_by_record(pevent, record);
 	if (!event) {
-		do_warning("ug! no event found for type %d",
-			   trace_parse_common_type(pevent, record->data));
+		int i;
+		int type = trace_parse_common_type(pevent, record->data);
+
+		do_warning("ug! no event found for type %d", type);
+		trace_seq_printf(s, "[UNKNOWN TYPE %d]", type);
+		for (i = 0; i < record->size; i++)
+			trace_seq_printf(s, " %02x",
+					 ((unsigned char *)record->data)[i]);
 		return;
 	}
 
-- 
2.14.3
