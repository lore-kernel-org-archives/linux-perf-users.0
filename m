From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/73] tools lib traceevent: Man page for page size APIs
Date: Fri, 17 May 2019 16:35:26 -0300
Message-ID: <20190517193611.4974-29-acme@kernel.org>
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

  tep_get_page_size()
  tep_set_page_size()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-9-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200107.218173559@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-page_size.txt | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-page_size.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt b/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
new file mode 100644
index 000000000000..452c0cfa1822
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
@@ -0,0 +1,82 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_get_page_size, tep_set_page_size - Get / set the size of a memory page on
+the machine, where the trace is generated
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+int *tep_get_page_size*(struct tep_handle pass:[*]_tep_);
+void *tep_set_page_size*(struct tep_handle pass:[*]_tep_, int _page_size_);
+--
+
+DESCRIPTION
+-----------
+The _tep_get_page_size()_ function returns the size of a memory page on
+the machine, where the trace is generated. The _tep_ argument is trace
+event parser context.
+
+The _tep_set_page_size()_ function stores in the _tep_ context the size of a
+memory page on the machine, where the trace is generated.
+The _tep_ argument is trace event parser context.
+The _page_size_ argument is the size of a memory page, in bytes.
+
+RETURN VALUE
+------------
+The _tep_get_page_size()_ function returns size of the memory page, in bytes.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <unistd.h>
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+	int page_size = getpagesize();
+
+	tep_set_page_size(tep, page_size);
+
+	printf("The page size for this machine is %d\n", tep_get_page_size(tep));
+
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
