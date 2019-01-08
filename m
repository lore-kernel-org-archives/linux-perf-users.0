From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/16] tools lib traceevent: Introduce new libtracevent API: tep_override_comm()
Date: Tue,  8 Jan 2019 16:58:59 -0300
Message-ID: <20190108195910.17726-6-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch adds a new API of tracevent library: tep_override_comm() It
registers a pid / command mapping. If a mapping with the same pid
already exists, the entry is updated with the new command.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154648.038915912@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 69 +++++++++++++++++++++++-------
 tools/lib/traceevent/event-parse.h |  1 +
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 69a96e39f0ab..156e513074b2 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -232,11 +232,13 @@ int tep_pid_is_registered(struct tep_handle *pevent, int pid)
  * we must add this pid. This is much slower than when cmdlines
  * are added before the array is initialized.
  */
-static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
+static int add_new_comm(struct tep_handle *pevent,
+			const char *comm, int pid, bool override)
 {
 	struct cmdline *cmdlines = pevent->cmdlines;
-	const struct cmdline *cmdline;
+	struct cmdline *cmdline;
 	struct cmdline key;
+	char *new_comm;
 
 	if (!pid)
 		return 0;
@@ -247,8 +249,19 @@ static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
 	cmdline = bsearch(&key, pevent->cmdlines, pevent->cmdline_count,
 		       sizeof(*pevent->cmdlines), cmdline_cmp);
 	if (cmdline) {
-		errno = EEXIST;
-		return -1;
+		if (!override) {
+			errno = EEXIST;
+			return -1;
+		}
+		new_comm = strdup(comm);
+		if (!new_comm) {
+			errno = ENOMEM;
+			return -1;
+		}
+		free(cmdline->comm);
+		cmdline->comm = new_comm;
+
+		return 0;
 	}
 
 	cmdlines = realloc(cmdlines, sizeof(*cmdlines) * (pevent->cmdline_count + 1));
@@ -275,21 +288,13 @@ static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
 	return 0;
 }
 
-/**
- * tep_register_comm - register a pid / comm mapping
- * @pevent: handle for the pevent
- * @comm: the command line to register
- * @pid: the pid to map the command line to
- *
- * This adds a mapping to search for command line names with
- * a given pid. The comm is duplicated.
- */
-int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
+static int _tep_register_comm(struct tep_handle *pevent,
+			      const char *comm, int pid, bool override)
 {
 	struct cmdline_list *item;
 
 	if (pevent->cmdlines)
-		return add_new_comm(pevent, comm, pid);
+		return add_new_comm(pevent, comm, pid, override);
 
 	item = malloc(sizeof(*item));
 	if (!item)
@@ -312,6 +317,40 @@ int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
 	return 0;
 }
 
+/**
+ * tep_register_comm - register a pid / comm mapping
+ * @pevent: handle for the pevent
+ * @comm: the command line to register
+ * @pid: the pid to map the command line to
+ *
+ * This adds a mapping to search for command line names with
+ * a given pid. The comm is duplicated. If a command with the same pid
+ * already exist, -1 is returned and errno is set to EEXIST
+ */
+int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
+{
+	return _tep_register_comm(pevent, comm, pid, false);
+}
+
+/**
+ * tep_override_comm - register a pid / comm mapping
+ * @pevent: handle for the pevent
+ * @comm: the command line to register
+ * @pid: the pid to map the command line to
+ *
+ * This adds a mapping to search for command line names with
+ * a given pid. The comm is duplicated. If a command with the same pid
+ * already exist, the command string is udapted with the new one
+ */
+int tep_override_comm(struct tep_handle *pevent, const char *comm, int pid)
+{
+	if (!pevent->cmdlines && cmdline_init(pevent)) {
+		errno = ENOMEM;
+		return -1;
+	}
+	return _tep_register_comm(pevent, comm, pid, true);
+}
+
 int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock)
 {
 	pevent->trace_clock = strdup(trace_clock);
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 35d37087d3c5..e6f4249910e6 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -432,6 +432,7 @@ int tep_set_function_resolver(struct tep_handle *pevent,
 			      tep_func_resolver_t *func, void *priv);
 void tep_reset_function_resolver(struct tep_handle *pevent);
 int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid);
+int tep_override_comm(struct tep_handle *pevent, const char *comm, int pid);
 int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock);
 int tep_register_function(struct tep_handle *pevent, char *name,
 			  unsigned long long addr, char *mod);
-- 
2.20.1
