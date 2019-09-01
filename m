From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/47] libtraceevent: Change users plugin directory
Date: Sun,  1 Sep 2019 09:23:00 -0300
Message-ID: <20190901122326.5793-22-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Patrick McLean <chutzpah@gentoo.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, linux-trace-devel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

To be compliant with XDG user directory layout, the user's plugin
directory is changed from ~/.traceevent/plugins to
~/.local/lib/traceevent/plugins/

Suggested-by: Patrick McLean <chutzpah@gentoo.org>
Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Patrick McLean <chutzpah@gentoo.org>
Cc: linux-trace-devel@vger.kernel.org
Link: https://lore.kernel.org/linux-trace-devel/20190313144206.41e75cf8@patrickm/
Link: http://lore.kernel.org/linux-trace-devel/20190801074959.22023-4-tz.stoyanov@gmail.com
Link: http://lore.kernel.org/lkml/20190805204355.344622683@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile       | 6 +++---
 tools/lib/traceevent/event-plugin.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 8352d53dcb5a..a39cdd0d890d 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -62,15 +62,15 @@ set_plugin_dir := 1
 
 # Set plugin_dir to preffered global plugin location
 # If we install under $HOME directory we go under
-# $(HOME)/.traceevent/plugins
+# $(HOME)/.local/lib/traceevent/plugins
 #
 # We dont set PLUGIN_DIR in case we install under $HOME
 # directory, because by default the code looks under:
-# $(HOME)/.traceevent/plugins by default.
+# $(HOME)/.local/lib/traceevent/plugins by default.
 #
 ifeq ($(plugin_dir),)
 ifeq ($(prefix),$(HOME))
-override plugin_dir = $(HOME)/.traceevent/plugins
+override plugin_dir = $(HOME)/.local/lib/traceevent/plugins
 set_plugin_dir := 0
 else
 override plugin_dir = $(libdir)/traceevent/plugins
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index 8ca28de9337a..e1f7ddd5a6cf 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -18,7 +18,7 @@
 #include "event-utils.h"
 #include "trace-seq.h"
 
-#define LOCAL_PLUGIN_DIR ".traceevent/plugins"
+#define LOCAL_PLUGIN_DIR ".local/lib/traceevent/plugins/"
 
 static struct registered_plugin_options {
 	struct registered_plugin_options	*next;
-- 
2.21.0
