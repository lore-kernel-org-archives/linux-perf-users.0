From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/25] perf probe: Generate event name with line number
Date: Tue, 19 Nov 2019 08:32:41 -0300
Message-ID: <20191119113245.19593-22-acme@kernel.org>
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

Generate event name from function name with line number as
<function>_L<line_number>. Note that this is only for the new event
which is defined by the line number of function (except for line 0).

If there is another event on same line, you have to use
"-f" option. In that case, the new event has "_1" suffix.

 e.g.
  # perf probe -a kernel_read:2
  Added new event:
    probe:kernel_read_L2 (on kernel_read:2)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read_L2 -aR sleep 1

But if we omit the line number or 0th line, it will
have no suffix.

  # perf probe -a kernel_read:0
  Added new event:
    probe:kernel_read (on kernel_read)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read -aR sleep 1

  probe:kernel_read    (on kernel_read@linux-5.0.0/fs/read_write.c)
  probe:kernel_read_L2 (on kernel_read:2@linux-5.0.0/fs/read_write.c)

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406474026.24476.2828897745502059569.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e29948b8fcab..5c86d2cf6338 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1679,6 +1679,14 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
 	if (ret < 0)
 		goto out;
 
+	/* Generate event name if needed */
+	if (!pev->event && pev->point.function && pev->point.line
+			&& !pev->point.lazy_line && !pev->point.offset) {
+		if (asprintf(&pev->event, "%s_L%d", pev->point.function,
+			pev->point.line) < 0)
+			return -ENOMEM;
+	}
+
 	/* Copy arguments and ensure return probe has no C argument */
 	pev->nargs = argc - 1;
 	pev->args = zalloc(sizeof(struct perf_probe_arg) * pev->nargs);
-- 
2.21.0
