From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/73] tools lib traceevent: Man pages for find field APIs
Date: Fri, 17 May 2019 16:35:35 -0300
Message-ID: <20190517193611.4974-38-acme@kernel.org>
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

  tep_find_common_field(),
  tep_find_field()
  tep_find_any_field()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-18-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200108.721589427@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../libtraceevent-field_find.txt              | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_find.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-field_find.txt b/tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
new file mode 100644
index 000000000000..0896af5b9eff
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
@@ -0,0 +1,118 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_find_common_field, tep_find_field, tep_find_any_field -
+Search for a field in an event.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+struct tep_format_field pass:[*]*tep_find_common_field*(struct tep_event pass:[*]_event_, const char pass:[*]_name_);
+struct tep_format_field pass:[*]*tep_find_field*(struct tep_event_ormat pass:[*]_event_, const char pass:[*]_name_);
+struct tep_format_field pass:[*]*tep_find_any_field*(struct tep_event pass:[*]_event_, const char pass:[*]_name_);
+--
+
+DESCRIPTION
+-----------
+These functions search for a field with given name in an event. The field
+returned can be used to find the field content from within a data record.
+
+The _tep_find_common_field()_ function searches for a common field with _name_
+in the _event_.
+
+The _tep_find_field()_ function searches for an event specific field with
+_name_ in the _event_.
+
+The _tep_find_any_field()_ function searches for any field with _name_ in the
+_event_.
+
+RETURN VALUE
+------------
+The _tep_find_common_field(), _tep_find_field()_ and _tep_find_any_field()_
+functions return a pointer to the found field, or NULL in case there is no field
+with the requested name.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+void get_htimer_info(struct tep_handle *tep, struct tep_record *record)
+{
+	struct tep_format_field *field;
+	struct tep_event *event;
+	long long softexpires;
+	int mode;
+	int pid;
+
+	event = tep_find_event_by_name(tep, "timer", "hrtimer_start");
+
+	field = tep_find_common_field(event, "common_pid");
+	if (field == NULL) {
+		/* Cannot find "common_pid" field in the event */
+	} else {
+		/* Get pid from the data record */
+		pid = tep_read_number(tep, record->data + field->offset,
+				      field->size);
+	}
+
+	field = tep_find_field(event, "softexpires");
+	if (field == NULL) {
+		/* Cannot find "softexpires" event specific field in the event */
+	} else {
+		/* Get softexpires parameter from the data record */
+		softexpires = tep_read_number(tep, record->data + field->offset,
+					      field->size);
+	}
+
+	field = tep_find_any_field(event, "mode");
+	if (field == NULL) {
+		/* Cannot find "mode" field in the event */
+	} else
+	{
+		/* Get mode parameter from the data record */
+		mode = tep_read_number(tep, record->data + field->offset,
+				       field->size);
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
