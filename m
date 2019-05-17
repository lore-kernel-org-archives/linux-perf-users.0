From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/73] tools lib traceevent: Man page for host endian APIs
Date: Fri, 17 May 2019 16:35:25 -0300
Message-ID: <20190517193611.4974-28-acme@kernel.org>
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

  tep_is_bigendian(),
  tep_is_local_bigendian(),
  tep_set_local_bigendian()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-8-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200107.063709363@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../libtraceevent-host_endian.txt             | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt b/tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
new file mode 100644
index 000000000000..d5d375eb8d1e
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
@@ -0,0 +1,104 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_is_bigendian, tep_is_local_bigendian, tep_set_local_bigendian - Get / set
+the endianness of the local machine.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+enum *tep_endian* {
+	TEP_LITTLE_ENDIAN = 0,
+	TEP_BIG_ENDIAN
+};
+
+int *tep_is_bigendian*(void);
+bool *tep_is_local_bigendian*(struct tep_handle pass:[*]_tep_);
+void *tep_set_local_bigendian*(struct tep_handle pass:[*]_tep_, enum tep_endian _endian_);
+--
+
+DESCRIPTION
+-----------
+
+The _tep_is_bigendian()_ gets the endianness of the machine, executing
+the function.
+
+The _tep_is_local_bigendian()_ function gets the endianness of the local
+machine, saved in the _tep_ handler. The _tep_ argument is the trace event
+parser context. This API is a bit faster than _tep_is_bigendian()_, as it
+returns cached endianness of the local machine instead of checking it each time.
+
+The _tep_set_local_bigendian()_ function sets the endianness of the local
+machine in the _tep_ handler. The _tep_ argument is trace event parser context.
+The _endian_ argument is the endianness:
+[verse]
+--
+	_TEP_LITTLE_ENDIAN_ - the machine is little endian,
+	_TEP_BIG_ENDIAN_ - the machine is big endian.
+--
+
+RETURN VALUE
+------------
+The _tep_is_bigendian()_ function returns non zero if the endianness of the
+machine, executing the code, is big endian and zero otherwise.
+
+The _tep_is_local_bigendian()_ function returns true, if the endianness of the
+local machine, saved in the _tep_ handler, is big endian, or false otherwise.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+	if (tep_is_bigendian())
+		tep_set_local_bigendian(tep, TEP_BIG_ENDIAN);
+	else
+		tep_set_local_bigendian(tep, TEP_LITTLE_ENDIAN);
+...
+	if (tep_is_local_bigendian(tep))
+		printf("This machine you are running on is bigendian\n");
+	else
+		printf("This machine you are running on is little endian\n");
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
