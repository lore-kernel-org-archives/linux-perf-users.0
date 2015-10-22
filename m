From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core  2/2] perf/runtests: Add testcases for perf probe
Date: Thu, 22 Oct 2015 21:16:19 +0900
Message-ID: <20151022121619.13192.80700.stgit@localhost.localdomain>
References: <20151022121615.13192.71967.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailx.hitachi.co.jp ([133.145.228.49]:60663 "EHLO
	mailx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298AbbJVNBF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 22 Oct 2015 09:01:05 -0400
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
	by mailx.hitachi.co.jp (Postfix) with ESMTP id 2E3F8177007F
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2015 21:23:20 +0900 (JST)
In-Reply-To: <20151022121615.13192.71967.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

Add testcases for perf probe command, including following
features;

 - Add probes on the kernel
 - Add probes on user binary
 - Delete probes
 - Add probes with --force
 - Check help message
 - Parse --list options
 - Skip blacklist functions
 - Skip out-of-text address
 - Ignore dot suffixes of function names
 - List up functions
 - Check invalid commands
 - Check --list shown in stdout (instead of stderr)
 - Check quiet option
 - Semantic error checking for --line
 - Check --vars command
 - Check wildcard support

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/runtests/test.d/functions               |   13 ++++++++++
 tools/perf/runtests/test.d/probe/addprobes.tc      |   15 +++++++++++
 tools/perf/runtests/test.d/probe/adduprobes.tc     |   13 ++++++++++
 tools/perf/runtests/test.d/probe/blacklist.tc      |   14 ++++++++++
 tools/perf/runtests/test.d/probe/delete.tc         |    8 ++++++
 tools/perf/runtests/test.d/probe/forceadd.tc       |    8 ++++++
 .../perf/runtests/test.d/probe/funcname-suffix.tc  |   17 +++++++++++++
 tools/perf/runtests/test.d/probe/funcs.tc          |    8 ++++++
 tools/perf/runtests/test.d/probe/help.tc           |    5 ++++
 .../perf/runtests/test.d/probe/invalid_command.tc  |   27 ++++++++++++++++++++
 tools/perf/runtests/test.d/probe/list-stdout.tc    |    7 +++++
 tools/perf/runtests/test.d/probe/list.tc           |   10 +++++++
 tools/perf/runtests/test.d/probe/out-of-text.tc    |   10 +++++++
 tools/perf/runtests/test.d/probe/quiet.tc          |    6 ++++
 tools/perf/runtests/test.d/probe/semantic-line.tc  |   20 +++++++++++++++
 tools/perf/runtests/test.d/probe/vars.tc           |    9 +++++++
 tools/perf/runtests/test.d/probe/wildcard.tc       |    6 ++++
 17 files changed, 196 insertions(+)
 create mode 100644 tools/perf/runtests/test.d/functions
 create mode 100644 tools/perf/runtests/test.d/probe/addprobes.tc
 create mode 100644 tools/perf/runtests/test.d/probe/adduprobes.tc
 create mode 100644 tools/perf/runtests/test.d/probe/blacklist.tc
 create mode 100644 tools/perf/runtests/test.d/probe/delete.tc
 create mode 100644 tools/perf/runtests/test.d/probe/forceadd.tc
 create mode 100644 tools/perf/runtests/test.d/probe/funcname-suffix.tc
 create mode 100644 tools/perf/runtests/test.d/probe/funcs.tc
 create mode 100644 tools/perf/runtests/test.d/probe/help.tc
 create mode 100644 tools/perf/runtests/test.d/probe/invalid_command.tc
 create mode 100644 tools/perf/runtests/test.d/probe/list-stdout.tc
 create mode 100644 tools/perf/runtests/test.d/probe/list.tc
 create mode 100644 tools/perf/runtests/test.d/probe/out-of-text.tc
 create mode 100644 tools/perf/runtests/test.d/probe/quiet.tc
 create mode 100644 tools/perf/runtests/test.d/probe/semantic-line.tc
 create mode 100644 tools/perf/runtests/test.d/probe/vars.tc
 create mode 100644 tools/perf/runtests/test.d/probe/wildcard.tc

diff --git a/tools/perf/runtests/test.d/functions b/tools/perf/runtests/test.d/functions
new file mode 100644
index 0000000..89ca293
--- /dev/null
+++ b/tools/perf/runtests/test.d/functions
@@ -0,0 +1,13 @@
+clear_all_probes() {
+	echo 0 > /sys/kernel/debug/tracing/events/enable
+	echo > /sys/kernel/debug/tracing/kprobe_events
+	echo > /sys/kernel/debug/tracing/uprobe_events
+}
+
+check_perf_probe_option() { #option
+	$PERF probe -h 2>&1 | egrep '[\t ]+'$1'[\t ]+' > /dev/null
+}
+
+check_kernel_debuginfo() {
+	eu-addr2line -k 0x`grep -m 1 vfs_read /proc/kallsyms | cut -f 1 -d" "` | grep vfs_read
+}
diff --git a/tools/perf/runtests/test.d/probe/addprobes.tc b/tools/perf/runtests/test.d/probe/addprobes.tc
new file mode 100644
index 0000000..69c2bc5
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/addprobes.tc
@@ -0,0 +1,15 @@
+#!/bin/sh
+#description: Basinc probe adding
+
+clear_all_probes
+$PERF probe --add vfs_read
+
+clear_all_probes
+$PERF probe -a vfs_read
+
+clear_all_probes
+$PERF probe vfs_read
+
+clear_all_probes
+
+! $PERF probe -d vfs_read vfs_read
diff --git a/tools/perf/runtests/test.d/probe/adduprobes.tc b/tools/perf/runtests/test.d/probe/adduprobes.tc
new file mode 100644
index 0000000..b0e748d
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/adduprobes.tc
@@ -0,0 +1,13 @@
+#!/bin/sh
+#description: Basic probe adding on user binary
+
+clear_all_probes
+$PERF probe -x /bin/bash --add array_create
+
+clear_all_probes
+$PERF probe -x /bin/bash --add 'array_*'
+
+clear_all_probes
+$PERF probe /bin/bash 'array_*'
+
+clear_all_probes
diff --git a/tools/perf/runtests/test.d/probe/blacklist.tc b/tools/perf/runtests/test.d/probe/blacklist.tc
new file mode 100644
index 0000000..d399439
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/blacklist.tc
@@ -0,0 +1,14 @@
+#!/bin/sh
+#description: Skip blacklist function
+
+echo "Check blacklisted function correctly skipped"
+BLACKFUNC=`head -n 1 /sys/kernel/debug/kprobes/blacklist | cut -f2`
+test "$BLACKFUNC" || exit_unsupported
+clear_all_probes
+
+echo "probing on blacklist must fail"
+(! $PERF probe $BLACKFUNC)
+
+echo "it should be skipped"
+$PERF probe $BLACKFUNC 2>&1 | grep "skip it"
+
diff --git a/tools/perf/runtests/test.d/probe/delete.tc b/tools/perf/runtests/test.d/probe/delete.tc
new file mode 100644
index 0000000..918d6e1
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/delete.tc
@@ -0,0 +1,8 @@
+#!/bin/sh
+# description: Basic probe deleting
+clear_all_probes
+
+$PERF probe --add vfs_read
+$PERF probe -x $PERF --add cmd_help
+
+$PERF probe -d \* 2>&1 | grep ^Removed | wc -l | grep '^2$'
diff --git a/tools/perf/runtests/test.d/probe/forceadd.tc b/tools/perf/runtests/test.d/probe/forceadd.tc
new file mode 100644
index 0000000..bcefabb
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/forceadd.tc
@@ -0,0 +1,8 @@
+#!/bin/sh
+#description: probe adding with --force
+clear_all_probes
+
+$PERF probe --add vfs_read
+! $PERF probe --add 'vfs_read'
+$PERF probe --force --add 'vfs_read'
+$PERF probe --del \*
diff --git a/tools/perf/runtests/test.d/probe/funcname-suffix.tc b/tools/perf/runtests/test.d/probe/funcname-suffix.tc
new file mode 100644
index 0000000..8c68ad0
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/funcname-suffix.tc
@@ -0,0 +1,17 @@
+#!/bin/sh
+#description: Cut off the function suffix from name
+
+clear_all_probes
+echo "get a symbol which has a suffix"
+CANDIDATE=`egrep -m 1 '\.(isra|part|constprep)' /proc/kallsyms | cut -f3 -d' '`
+if [ -z "$CANDIDATE" ]; then
+  echo "No suffixed function found. skip it"
+  exit_unsupported
+fi
+echo "add an event on it"
+$PERF probe $CANDIDATE
+
+echo "add the second event on it (with suffix number)"
+$PERF probe -f $CANDIDATE
+
+clear_all_probes
diff --git a/tools/perf/runtests/test.d/probe/funcs.tc b/tools/perf/runtests/test.d/probe/funcs.tc
new file mode 100644
index 0000000..98a412f
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/funcs.tc
@@ -0,0 +1,8 @@
+#!/bin/sh
+# description: Basic function listup command
+
+$PERF probe -F &> /dev/null
+$PERF probe -x $PERF -F &> /dev/null
+$PERF probe -x $PERF -F 'map_*' &> /dev/null
+
+
diff --git a/tools/perf/runtests/test.d/probe/help.tc b/tools/perf/runtests/test.d/probe/help.tc
new file mode 100644
index 0000000..67e2c0a
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/help.tc
@@ -0,0 +1,5 @@
+#!/bin/sh
+# description: help messages
+! $PERF probe -h
+$PERF probe 2>&1 | grep usage
+
diff --git a/tools/perf/runtests/test.d/probe/invalid_command.tc b/tools/perf/runtests/test.d/probe/invalid_command.tc
new file mode 100644
index 0000000..351ec99
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/invalid_command.tc
@@ -0,0 +1,27 @@
+#!/bin/sh
+# description: invalid commands
+echo "Some commands requires an argument"
+! $PERF probe -a
+! $PERF probe -d
+! $PERF probe -L
+! $PERF probe -V
+echo "Some commands can omit the argument"
+$PERF probe -F > /dev/null
+$PERF probe -l > /dev/null
+echo "Commands are mutually exclusive"
+! $PERF probe -a xxx -d xxx
+! $PERF probe -a xxx -L foo
+! $PERF probe -a xxx -V foo
+! $PERF probe -a xxx -l
+! $PERF probe -a xxx -F
+! $PERF probe -d xxx -L foo
+! $PERF probe -d xxx -V foo
+! $PERF probe -d xxx -l
+! $PERF probe -d xxx -F
+! $PERF probe -L foo -V bar
+! $PERF probe -L foo -l
+! $PERF probe -L foo -F
+! $PERF probe -V foo -l
+! $PERF probe -V foo -F
+! $PERF probe -l -F
+
diff --git a/tools/perf/runtests/test.d/probe/list-stdout.tc b/tools/perf/runtests/test.d/probe/list-stdout.tc
new file mode 100644
index 0000000..d797abf
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/list-stdout.tc
@@ -0,0 +1,7 @@
+#!/bin/sh
+# description: perf probe --list outputs in stdout
+
+clear_all_probes
+$PERF probe --add 'vfs_read'
+test `$PERF probe --list | wc -l` -ne 0
+clear_all_probes
diff --git a/tools/perf/runtests/test.d/probe/list.tc b/tools/perf/runtests/test.d/probe/list.tc
new file mode 100644
index 0000000..2cfab75
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/list.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# description: list command parsing
+$PERF probe -l
+$PERF probe -l \*
+$PERF probe -l 'probe:*'
+
+! $PERF probe -l \*\|
+! $PERF probe -l \*\&
+! $PERF probe -l \*\!
+
diff --git a/tools/perf/runtests/test.d/probe/out-of-text.tc b/tools/perf/runtests/test.d/probe/out-of-text.tc
new file mode 100644
index 0000000..34163a9
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/out-of-text.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+#description: Skip out-of-text functions
+
+echo "Check init text correctly skipped"
+INITTEXT=init_setup
+grep $INITTEXT /proc/kallsyms || exit_unsupported
+clear_all_probes
+! $PERF probe $INITTEXT
+$PERF probe $INITTEXT 2>&1 | grep "skip it"
+
diff --git a/tools/perf/runtests/test.d/probe/quiet.tc b/tools/perf/runtests/test.d/probe/quiet.tc
new file mode 100644
index 0000000..ac954aa
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/quiet.tc
@@ -0,0 +1,6 @@
+#!/bin/sh
+#description: Quiet option check
+
+test `$PERF probe --quiet --add vfs_read | wc -l` -eq 0
+test `$PERF probe --quiet --list | wc -l` -ne 0
+test `$PERF probe --quiet --del vfs_read | wc -l` -eq 0
diff --git a/tools/perf/runtests/test.d/probe/semantic-line.tc b/tools/perf/runtests/test.d/probe/semantic-line.tc
new file mode 100644
index 0000000..a6f5869
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/semantic-line.tc
@@ -0,0 +1,20 @@
+#!/bin/sh
+# description: --line semantic errors
+
+echo "Acceptable --line descriptions"
+! ($PERF probe --line 'func' 2>&1 | grep "Semantic error")
+! ($PERF probe --line 'func:10' 2>&1 | grep "Semantic error")
+! ($PERF probe --line 'func:0-10' 2>&1 | grep "Semantic error")
+! ($PERF probe --line 'func:2+10' 2>&1 | grep "Semantic error")
+! ($PERF probe --line 'func@source.c' 2>&1 | grep "Semantic error")
+! ($PERF probe --line 'func@source.c:1' 2>&1 | grep "Semantic error")
+! ($PERF probe --line 'source.c:1' 2>&1 | grep "Semantic error")
+! ($PERF probe --line 'source.c:1+1' 2>&1 | grep "Semantic error")
+! ($PERF probe --line 'source.c:1-10' 2>&1 | grep "Semantic error")
+
+echo "Unacceptable --line descriptions"
+$PERF probe --line 'func:foo' 2>&1 | grep "Semantic error"
+$PERF probe --line 'func:1-foo' 2>&1 | grep "Semantic error"
+$PERF probe --line 'func:1+foo' 2>&1 | grep "Semantic error"
+$PERF probe --line 'func;lazy*pattern' 2>&1 | grep "Semantic error"
+
diff --git a/tools/perf/runtests/test.d/probe/vars.tc b/tools/perf/runtests/test.d/probe/vars.tc
new file mode 100644
index 0000000..9711c91
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/vars.tc
@@ -0,0 +1,9 @@
+#!/bin/sh
+# description: readable vars command
+
+#check_kernel_debuginfo || exit_unsupported
+
+! $PERF probe -V
+
+$PERF probe -V vfs_read
+
diff --git a/tools/perf/runtests/test.d/probe/wildcard.tc b/tools/perf/runtests/test.d/probe/wildcard.tc
new file mode 100644
index 0000000..ec3e633
--- /dev/null
+++ b/tools/perf/runtests/test.d/probe/wildcard.tc
@@ -0,0 +1,6 @@
+#!/bin/sh
+#description: perf-probe wildcard support
+
+$PERF probe -nf -a 'vfs_* $params'
+$PERF probe -nf vfs_\* \$params
+
