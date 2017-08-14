From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/19] perf test shell: Add 'probe_vfs_getname' shell test
Date: Mon, 14 Aug 2017 13:27:32 -0300
Message-ID: <20170814162741.6101-11-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

First perf shell test:

  # perf test vfs_getname
  60: Add vfs_getname probe to get syscall args filenames: Ok
  #

In verbose mode:

  # perf test -v vfs_getname
  60: Add vfs_getname probe to get syscall args filenames:
  --- start ---
  test child forked, pid 19146
  Added new event:
    probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

  You can now use it in all perf tools, such as:

	  perf record -e probe:vfs_getname -aR sleep 1

  test child finished with 0
  ---- end ----
  Add vfs_getname probe to get syscall args filenames: Ok
  #

And if the vmlinux file is not found:

  # mv ../build/v4.12.0-rc6+/vmlinux ../build/v4.12.0-rc6+/vmlinux.hidden
  # perf test vfs_getname
  60: Add vfs_getname probe to get syscall args filenames: Skip
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-8f3n22c1yn516ev30s603ow2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/probe_vfs_getname.sh | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100755 tools/perf/tests/shell/probe_vfs_getname.sh

diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
new file mode 100755
index 000000000000..d5f5248de927
--- /dev/null
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -0,0 +1,30 @@
+# Add vfs_getname probe to get syscall args filenames
+#
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
+add_probe_vfs_getname || skip_if_no_debuginfo
+err=$?
+cleanup_probe_vfs_getname
+exit $err
-- 
2.13.4
