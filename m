From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/19] perf test shell: Move vfs_getname probe function to lib
Date: Mon, 14 Aug 2017 13:27:34 -0300
Message-ID: <20170814162741.6101-13-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Multiple tests will be able to reuse these functions, to test things
like perf report, 'trace', etc, using this probe.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-48xagvozhouhyi8fjota6o2d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                        |  4 +++-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 28 +++++++++++++++++++++++++
 tools/perf/tests/shell/probe_vfs_getname.sh     | 22 +------------------
 3 files changed, 32 insertions(+), 22 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/probe_vfs_getname.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index eb1356774c7d..70ddc65f898d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -762,7 +762,9 @@ install-tests: all install-gtk
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
 		$(INSTALL) tests/attr/* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
-		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'
+		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
+		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
 
 install-bin: install-tools install-tests install-traceevent-plugins
 
diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
new file mode 100644
index 000000000000..42308040f882
--- /dev/null
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -0,0 +1,28 @@
+# Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
+
+perf probe -l | grep -q probe:vfs_getname
+had_vfs_getname=$?
+
+cleanup_probe_vfs_getname() {
+	if [ $had_vfs_getname -eq 1 ] ; then
+		perf probe -q -d probe:vfs_getname
+	fi
+}
+
+add_probe_vfs_getname() {
+	local verbose=$1
+	if [ $had_vfs_getname -eq 1 ] ; then
+               line=$(perf probe -L getname_flags | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
+               perf probe $verbose "vfs_getname=getname_flags:${line} pathname=result->name:string"
+	fi
+}
+
+skip_if_no_debuginfo() {
+	add_probe_vfs_getname -v 2>&1 | grep -q "^Failed to find the path for kernel" && return 2
+	return 1
+}
+
+skip_if_no_debuginfo() {
+	add_probe_vfs_getname -v 2>&1 | grep -q "^Failed to find the path for kernel" && return 2
+	return 1
+}
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index d5f5248de927..c8380137beef 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -2,27 +2,7 @@
 #
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-perf probe -l | grep -q probe:vfs_getname
-had_vfs_getname=$?
-
-cleanup_probe_vfs_getname() {
-	if [ $had_vfs_getname -eq 1 ] ; then
-		perf probe -q -d probe:vfs_getname
-	fi
-}
-
-add_probe_vfs_getname() {
-	local verbose=$1
-	if [ $had_vfs_getname -eq 1 ] ; then
-               line=$(perf probe -L getname_flags | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
-               perf probe $verbose "vfs_getname=getname_flags:${line} pathname=result->name:string"
-	fi
-}
-
-skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2>&1 | grep -q "^Failed to find the path for kernel" && return 2
-	return 1
-}
+. $(dirname $0)/lib/probe_vfs_getname.sh
 
 add_probe_vfs_getname || skip_if_no_debuginfo
 err=$?
-- 
2.13.4
