From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/73] tools lib traceevent: Man page for tep_strerror()
Date: Fri, 17 May 2019 16:35:27 -0300
Message-ID: <20190517193611.4974-30-acme@kernel.org>
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

Create man page for tep_strerror() libtraceevent API.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-10-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200107.371692630@goodmis.org
[ Added "always" to state it doesn't matter if it is POSIX or GNU ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-strerror.txt  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-strerror.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-strerror.txt b/tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
new file mode 100644
index 000000000000..ee4062a00c9f
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
@@ -0,0 +1,85 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_strerror - Returns a string describing regular errno and tep error number.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+int *tep_strerror*(struct tep_handle pass:[*]_tep_, enum tep_errno _errnum_, char pass:[*]_buf_, size_t _buflen_);
+
+--
+DESCRIPTION
+-----------
+The _tep_strerror()_ function converts tep error number into a human
+readable string.
+The _tep_ argument is trace event parser context. The _errnum_ is a regular
+errno, defined in errno.h, or a tep error number. The string, describing this
+error number is copied in the _buf_ argument. The _buflen_ argument is
+the size of the _buf_.
+
+It as a thread safe wrapper around strerror_r(). The library function has two
+different behaviors - POSIX and GNU specific. The _tep_strerror()_ API always
+behaves as the POSIX version - the error string is copied in the user supplied
+buffer.
+
+RETURN VALUE
+------------
+The _tep_strerror()_ function returns 0, if a valid _errnum_ is passed and the
+string is copied into _buf_. If _errnum_ is not a valid error number,
+-1 is returned and _buf_ is not modified.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+char buf[32];
+char *pool = calloc(1, 128);
+if (tep == NULL) {
+	tep_strerror(tep, TEP_ERRNO__MEM_ALLOC_FAILED, buf, 32);
+	printf ("The pool is not initialized, %s", buf);
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
