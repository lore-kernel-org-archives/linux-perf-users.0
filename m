From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/25] perf probe: Support multiprobe event
Date: Tue, 19 Nov 2019 08:32:42 -0300
Message-ID: <20191119113245.19593-23-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <tom.zanussi@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Support multiprobe event if the event is based on function and lines and
kernel supports it. In this case, perf probe creates the first probe
with an event, and tries to append following probes on that event, since
those probes must be on the same source code line.

Before this patch;

  # perf probe -a vfs_read:18
  Added new events:
    probe:vfs_read_L18   (on vfs_read:18)
    probe:vfs_read_L18_1 (on vfs_read:18)

  You can now use it in all perf tools, such as:

  	perf record -e probe:vfs_read_L18_1 -aR sleep 1

  #

After this patch (on multiprobe supported kernel)
  # perf probe -a vfs_read:18
  Added new events:
    probe:vfs_read_L18   (on vfs_read:18)
    probe:vfs_read_L18   (on vfs_read:18)

  You can now use it in all perf tools, such as:

  	perf record -e probe:vfs_read_L18 -aR sleep 1

  #

Committer testing:

On a kernel that doesn't support multiprobe events, after this patch:

  # uname -a
  Linux quaco 5.3.8-200.fc30.x86_64 #1 SMP Tue Oct 29 14:46:22 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # grep append /sys/kernel/debug/tracing/README
  	    be modified by appending '.descending' or '.ascending' to a
  	    can be modified by appending any of the following modifiers
  #
  # perf probe -a vfs_read:18
  Added new events:
    probe:vfs_read_L18   (on vfs_read:18)
    probe:vfs_read_L18_1 (on vfs_read:18)

  You can now use it in all perf tools, such as:

  	perf record -e probe:vfs_read_L18_1 -aR sleep 1

  # perf probe -l
    probe:vfs_read_L18   (on vfs_read:18@fs/read_write.c)
    probe:vfs_read_L18_1 (on vfs_read:18@fs/read_write.c)
  #

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406475010.24476.586290752591512351.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 9 +++++++--
 tools/perf/util/probe-file.c  | 7 +++++++
 tools/perf/util/probe-file.h  | 1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 5c86d2cf6338..8f963a193a5d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2738,8 +2738,13 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 	if (tev->event == NULL || tev->group == NULL)
 		return -ENOMEM;
 
-	/* Add added event name to namelist */
-	strlist__add(namelist, event);
+	/*
+	 * Add new event name to namelist if multiprobe event is NOT
+	 * supported, since we have to use new event name for following
+	 * probes in that case.
+	 */
+	if (!multiprobe_event_is_supported())
+		strlist__add(namelist, event);
 	return 0;
 }
 
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index b659466ea498..a63f1a19b0e8 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -1007,6 +1007,7 @@ enum ftrace_readme {
 	FTRACE_README_KRETPROBE_OFFSET,
 	FTRACE_README_UPROBE_REF_CTR,
 	FTRACE_README_USER_ACCESS,
+	FTRACE_README_MULTIPROBE_EVENT,
 	FTRACE_README_END,
 };
 
@@ -1020,6 +1021,7 @@ static struct {
 	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
 	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
 	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
+	DEFINE_TYPE(FTRACE_README_MULTIPROBE_EVENT, "*Create/append/*"),
 };
 
 static bool scan_ftrace_readme(enum ftrace_readme type)
@@ -1085,3 +1087,8 @@ bool user_access_is_supported(void)
 {
 	return scan_ftrace_readme(FTRACE_README_USER_ACCESS);
 }
+
+bool multiprobe_event_is_supported(void)
+{
+	return scan_ftrace_readme(FTRACE_README_MULTIPROBE_EVENT);
+}
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index 986c1c94f64f..850d1b52d60a 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -71,6 +71,7 @@ bool probe_type_is_available(enum probe_type type);
 bool kretprobe_offset_is_supported(void);
 bool uprobe_ref_ctr_is_supported(void);
 bool user_access_is_supported(void);
+bool multiprobe_event_is_supported(void);
 #else	/* ! HAVE_LIBELF_SUPPORT */
 static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
 {
-- 
2.21.0
