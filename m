From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/75] tools lib traceevent: Implement new API tep_get_ref()
Date: Thu,  6 Dec 2018 18:25:14 -0300
Message-ID: <20181206212602.20474-28-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch implements a new API of the tracevent library:

  int tep_get_ref(struct tep_handle *tep);

The API returns the reference counter "ref_count" of the tep handler.
As "struct tep_handle" is internal only, its members cannot be accessed
by the library users, the API is used to get the reference counter.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154646.890615385@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 7 +++++++
 tools/lib/traceevent/event-parse.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 2b5cb33046ce..d1e6ee3d43cf 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6730,6 +6730,13 @@ void tep_ref(struct tep_handle *pevent)
 	pevent->ref_count++;
 }
 
+int tep_get_ref(struct tep_handle *tep)
+{
+	if (tep)
+		return tep->ref_count;
+	return 0;
+}
+
 void tep_free_format_field(struct tep_format_field *field)
 {
 	free(field->type);
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 16bf4c890b6f..44ec26c72c2e 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -581,6 +581,7 @@ struct tep_handle *tep_alloc(void);
 void tep_free(struct tep_handle *pevent);
 void tep_ref(struct tep_handle *pevent);
 void tep_unref(struct tep_handle *pevent);
+int tep_get_ref(struct tep_handle *tep);
 
 /* access to the internal parser */
 void tep_buffer_init(const char *buf, unsigned long long size);
-- 
2.19.2
