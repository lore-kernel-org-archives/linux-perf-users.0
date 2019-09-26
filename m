From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/66] libtraceevent: Man pages for tep plugins APIs
Date: Wed, 25 Sep 2019 21:31:51 -0300
Message-ID: <20190926003244.13962-14-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, linux-trace-devel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

Create man pages for libtraceevent APIs:

  tep_load_plugins(),
  tep_unload_plugin()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190903133434.30417-1-tz.stoyanov@gmail.com
Link: http://lore.kernel.org/lkml/20190919212542.216189588@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-plugins.txt   | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-plugins.txt

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-plugins.txt b/tools/lib/traceevent/Documentation/libtraceevent-plugins.txt
new file mode 100644
index 000000000000..596032ade31f
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-plugins.txt
@@ -0,0 +1,99 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_load_plugins, tep_unload_plugins - Load / unload traceevent plugins.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+struct tep_plugin_list pass:[*]*tep_load_plugins*(struct tep_handle pass:[*]_tep_);
+void *tep_unload_plugins*(struct tep_plugin_list pass:[*]_plugin_list_, struct tep_handle pass:[*]_tep_);
+--
+
+DESCRIPTION
+-----------
+The _tep_load_plugins()_ function loads all plugins, located in the plugin
+directories. The _tep_ argument is trace event parser context.
+The plugin directories are :
+[verse]
+--
+	- System's plugin directory, defined at the library compile time. It
+	  depends on the library installation prefix and usually is
+	  _(install_preffix)/lib/traceevent/plugins_
+	- Directory, defined by the environment variable _TRACEEVENT_PLUGIN_DIR_
+	- User's plugin directory, located at _~/.local/lib/traceevent/plugins_
+--
+Loading of plugins can be controlled by the _tep_flags_, using the
+_tep_set_flag()_ API:
+[verse]
+--
+	_TEP_DISABLE_SYS_PLUGINS_	- do not load plugins, located in
+					the system's plugin directory.
+	_TEP_DISABLE_PLUGINS_		- do not load any plugins.
+--
+The _tep_set_flag()_ API needs to be called before _tep_load_plugins()_, if
+loading of all plugins is not the desired case.
+
+The _tep_unload_plugins()_ function unloads the plugins, previously loaded by
+_tep_load_plugins()_. The _tep_ argument is trace event parser context. The
+_plugin_list_ is the list of loaded plugins, returned by
+the _tep_load_plugins()_ function.
+
+RETURN VALUE
+------------
+The _tep_load_plugins()_ function returns a list of successfully loaded plugins,
+or NULL in case no plugins are loaded.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+struct tep_plugin_list *plugins = tep_load_plugins(tep);
+if (plugins == NULL) {
+	/* no plugins are loaded */
+}
+...
+tep_unload_plugins(plugins, tep);
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
+_libtraceevent(3)_, _trace-cmd(1)_, _tep_set_flag(3)_
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
2.21.0
