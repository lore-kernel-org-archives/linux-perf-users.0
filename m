From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/75] tools lib traceevent: Fix diverse typos in comments
Date: Thu,  6 Dec 2018 18:25:25 -0300
Message-ID: <20181206212602.20474-39-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease cherry
picking and/or backporting, split this into multiple patches.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 12 ++++++------
 tools/lib/traceevent/plugin_kvm.c  |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index ffa656b868a9..a5ed291b8a9f 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -1145,7 +1145,7 @@ static enum tep_event_type read_token(char **tok)
 }
 
 /**
- * tep_read_token - access to utilites to use the pevent parser
+ * tep_read_token - access to utilities to use the pevent parser
  * @tok: The token to return
  *
  * This will parse tokens from the string given by
@@ -3258,7 +3258,7 @@ static int event_read_print(struct tep_event *event)
  * @name: the name of the common field to return
  *
  * Returns a common field from the event by the given @name.
- * This only searchs the common fields and not all field.
+ * This only searches the common fields and not all field.
  */
 struct tep_format_field *
 tep_find_common_field(struct tep_event *event, const char *name)
@@ -3302,7 +3302,7 @@ tep_find_field(struct tep_event *event, const char *name)
  * @name: the name of the field
  *
  * Returns a field by the given @name.
- * This searchs the common field names first, then
+ * This searches the common field names first, then
  * the non-common ones if a common one was not found.
  */
 struct tep_format_field *
@@ -3841,7 +3841,7 @@ static void print_bitmask_to_seq(struct tep_handle *pevent,
 		/*
 		 * data points to a bit mask of size bytes.
 		 * In the kernel, this is an array of long words, thus
-		 * endianess is very important.
+		 * endianness is very important.
 		 */
 		if (pevent->file_bigendian)
 			index = size - (len + 1);
@@ -5316,9 +5316,9 @@ pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *ne
  * This returns the cmdline structure that holds a pid for a given
  * comm, or NULL if none found. As there may be more than one pid for
  * a given comm, the result of this call can be passed back into
- * a recurring call in the @next paramater, and then it will find the
+ * a recurring call in the @next parameter, and then it will find the
  * next pid.
- * Also, it does a linear seach, so it may be slow.
+ * Also, it does a linear search, so it may be slow.
  */
 struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
 				       struct cmdline *next)
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 637be7c18476..754050eea467 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -387,7 +387,7 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
 
 	/*
 	 * We can only use the structure if file is of the same
-	 * endianess.
+	 * endianness.
 	 */
 	if (tep_is_file_bigendian(event->pevent) ==
 	    tep_is_host_bigendian(event->pevent)) {
-- 
2.19.2
