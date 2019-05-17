From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 45/73] tools lib traceevent: Man pages for APIs used to extract common fields from a record
Date: Fri, 17 May 2019 16:35:43 -0300
Message-ID: <20190517193611.4974-46-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, linux-trace-devel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

Create man pages for libtraceevent APIs:

 tep_data_type(),
 tep_data_pid(),
 tep_data_preempt_count(),
 tep_data_flags()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-26-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200110.284281830@goodmis.org
[ Fixed missing T in description of NOSUPPORT flag ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../libtraceevent-record_parse.txt            | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt b/tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
new file mode 100644
index 000000000000..e9a69116c78b
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
@@ -0,0 +1,137 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_data_type, tep_data_pid,tep_data_preempt_count, tep_data_flags -
+Extract common fields from a record.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+enum *trace_flag_type* {
+	_TRACE_FLAG_IRQS_OFF_,
+	_TRACE_FLAG_IRQS_NOSUPPORT_,
+	_TRACE_FLAG_NEED_RESCHED_,
+	_TRACE_FLAG_HARDIRQ_,
+	_TRACE_FLAG_SOFTIRQ_,
+};
+
+int *tep_data_type*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
+int *tep_data_pid*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
+int *tep_data_preempt_count*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
+int *tep_data_flags*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
+--
+
+DESCRIPTION
+-----------
+This set of functions can be used to extract common fields from a record.
+
+The _tep_data_type()_ function gets the event id from the record _rec_.
+It reads the "common_type" field. The _tep_ argument is the trace event parser
+context.
+
+The _tep_data_pid()_ function gets the process id from the record _rec_.
+It reads the "common_pid" field. The _tep_ argument is the trace event parser
+context.
+
+The _tep_data_preempt_count()_ function gets the preemption count from the
+record _rec_. It reads the "common_preempt_count" field. The _tep_ argument is
+the trace event parser context.
+
+The _tep_data_flags()_ function gets the latency flags from the record _rec_.
+It reads the "common_flags" field. The _tep_ argument is the trace event parser
+context. Supported latency flags are:
+[verse]
+--
+	_TRACE_FLAG_IRQS_OFF_,		Interrupts are disabled.
+	_TRACE_FLAG_IRQS_NOSUPPORT_,	Reading IRQ flag is not supported by the architecture.
+	_TRACE_FLAG_NEED_RESCHED_,	Task needs rescheduling.
+	_TRACE_FLAG_HARDIRQ_,		Hard IRQ is running.
+	_TRACE_FLAG_SOFTIRQ_,		Soft IRQ is running.
+--
+
+RETURN VALUE
+------------
+The _tep_data_type()_ function returns an integer, representing the event id.
+
+The _tep_data_pid()_ function returns an integer, representing the process id
+
+The _tep_data_preempt_count()_ function returns an integer, representing the
+preemption count.
+
+The _tep_data_flags()_ function returns an integer, representing the latency
+flags. Look at the _trace_flag_type_ enum for supported flags.
+
+All these functions in case of an error return a negative integer.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+void process_record(struct tep_record *record)
+{
+	int data;
+
+	data = tep_data_type(tep, record);
+	if (data >= 0) {
+		/* Got the ID of the event */
+	}
+
+	data = tep_data_pid(tep, record);
+	if (data >= 0) {
+		/* Got the process ID */
+	}
+
+	data = tep_data_preempt_count(tep, record);
+	if (data >= 0) {
+		/* Got the preemption count */
+	}
+
+	data = tep_data_flags(tep, record);
+	if (data >= 0) {
+		/* Got the latency flags */
+	}
+}
+...
+--
+
+FILES
+-----
+[verse]
+--
+*event-parse.h*
+	Header file to include in order to have access to the library APIs.
+*-ltraceevent*
+	Linker switch to add when building a program that uses the library.
+--
+
+SEE ALSO
+--------
+_libtraceevent(3)_, _trace-cmd(1)_
+
+AUTHOR
+------
+[verse]
+--
+*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
+*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
+--
+REPORTING BUGS
+--------------
+Report bugs to  <linux-trace-devel@vger.kernel.org>
+
+LICENSE
+-------
+libtraceevent is Free Software licensed under the GNU LGPL 2.1
+
+RESOURCES
+---------
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-- 
2.20.1
