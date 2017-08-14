From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/19] perf test shell: Add test using probe:vfs_getname and verifying results
Date: Mon, 14 Aug 2017 13:27:35 -0300
Message-ID: <20170814162741.6101-14-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This test uses the 'perf test shell' library to add probe:vfs_getname to the
system then use it with 'perf record' using 'touch' to write to a temp file,
then checks that that was captured by the vfs_getname probe in the generated
perf.data file, with the temp file name as the pathname argument.

Using it:

  # perf test "Use vfs_getname"
  60: Use vfs_getname probe to get syscall args filenames: Ok
  # perf test -v "Use vfs_getname"
  60: Use vfs_getname probe to get syscall args filenames:
  --- start ---
  test child forked, pid 16414
  Added new event:
    probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

  You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

  Recording open file:
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.022 MB /tmp/vaca.perf.data.QZsn7 (13 samples) ]
  Looking at perf.data file for vfs_getname records for the file we touched:
             touch 16421 [002] 1255152.879561: probe:vfs_getname: (ffffffffa626e608) pathname="/tmp/vaca.l10SL"
  test child finished with 0
  ---- end ----
  Use vfs_getname probe to get syscall args filenames: Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-t555fnhbcbxnukltk23dqxur@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../tests/shell/record+script_probe_vfs_getname.sh | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 tools/perf/tests/shell/record+script_probe_vfs_getname.sh

diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
new file mode 100755
index 000000000000..2725c5db699a
--- /dev/null
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -0,0 +1,37 @@
+# Use vfs_getname probe to get syscall args filenames
+
+# Uses the 'perf test shell' library to add probe:vfs_getname to the system
+# then use it with 'perf record' using 'touch' to write to a temp file, then
+# checks that that was captured by the vfs_getname probe in the generated
+# perf.data file, with the temp file name as the pathname argument.
+
+# Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
+
+. $(dirname $0)/lib/probe_vfs_getname.sh
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+file=$(mktemp /tmp/temporary_file.XXXXX)
+
+record_open_file() {
+	echo "Recording open file:"
+	perf record -o ${perfdata} -e probe:vfs_getname touch $file
+}
+
+perf_script_filenames() {
+	echo "Looking at perf.data file for vfs_getname records for the file we touched:"
+	perf script -i ${perfdata} | \
+	egrep " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname: +\([[:xdigit:]]+\) +pathname=\"${file}\""
+}
+
+add_probe_vfs_getname || skip_if_no_debuginfo
+err=$?
+if [ $err -ne 0 ] ; then
+	exit $err
+fi
+
+record_open_file && perf_script_filenames
+err=$?
+rm -f ${perfdata}
+rm -f ${file}
+cleanup_probe_vfs_getname
+exit $err
-- 
2.13.4
