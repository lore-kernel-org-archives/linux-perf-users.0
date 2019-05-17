From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/73] tools lib traceevent: Man page for header_page APIs
Date: Fri, 17 May 2019 16:35:22 -0300
Message-ID: <20190517193611.4974-25-acme@kernel.org>
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

Create a man page for libtraceevent APIs:

  tep_get_header_page_size(),
  tep_get_header_timestamp_size(),
  tep_is_old_format()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-5-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200106.583928896@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../libtraceevent-header_page.txt             | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-header_page.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-header_page.txt b/tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
new file mode 100644
index 000000000000..615d117dc39f
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
@@ -0,0 +1,102 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_get_header_page_size, tep_get_header_timestamp_size, tep_is_old_format -
+Get the data stored in the header page, in kernel context.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+int *tep_get_header_page_size*(struct tep_handle pass:[*]_tep_);
+int *tep_get_header_timestamp_size*(struct tep_handle pass:[*]_tep_);
+bool *tep_is_old_format*(struct tep_handle pass:[*]_tep_);
+--
+DESCRIPTION
+-----------
+These functions retrieve information from kernel context, stored in tracefs
+events/header_page. Old kernels do not have header page info, so default values
+from user space context are used.
+
+The _tep_get_header_page_size()_ function returns the size of a long integer,
+in kernel context. The _tep_ argument is trace event parser context.
+This information is retrieved from tracefs events/header_page, "commit" field.
+
+The _tep_get_header_timestamp_size()_ function returns the size of timestamps,
+in kernel context. The _tep_ argument is trace event parser context. This
+information is retrieved from tracefs events/header_page, "timestamp" field.
+
+The _tep_is_old_format()_ function returns true if the kernel predates
+the addition of events/header_page, otherwise it returns false.
+
+RETURN VALUE
+------------
+The _tep_get_header_page_size()_ function returns the size of a long integer,
+in bytes.
+
+The _tep_get_header_timestamp_size()_ function returns the size of timestamps,
+in bytes.
+
+The _tep_is_old_format()_ function returns true, if an old kernel is used to
+generate the tracing data, which has no event/header_page. If the kernel is new,
+or _tep_ is NULL, false is returned.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+	int longsize;
+	int timesize;
+	bool old;
+
+	longsize = tep_get_header_page_size(tep);
+	timesize = tep_get_header_timestamp_size(tep);
+	old = tep_is_old_format(tep);
+
+	printf ("%s kernel is used to generate the tracing data.\n",
+		old?"Old":"New");
+	printf("The size of a long integer is %d bytes.\n", longsize);
+	printf("The timestamps size is %d bytes.\n", timesize);
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
