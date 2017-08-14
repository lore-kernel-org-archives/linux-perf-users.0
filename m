From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/19] perf test shell: Add test using vfs_getname + 'perf trace'
Date: Mon, 14 Aug 2017 13:27:36 -0300
Message-ID: <20170814162741.6101-15-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Uses the 'perf test shell' library to add probe:vfs_getname to the
system then use it with 'perf trace' using 'touch' to write to a temp
file, then checks that that was captured by the vfs_getname was used by
'perf trace', that already handles "probe:vfs_getname" if present, and
used in the "open" syscall "filename" argument beautifier.

Testing it:

  # perf test "trace + vfs_getname"
  61: Check open filename arg using perf trace + vfs_getname: Ok
  #

  # perf test -v "trace + vfs_getname"
  61: Check open filename arg using perf trace + vfs_getname:
  --- start ---
  test child forked, pid 30846
  Added new event:
    probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

  You can now use it in all perf tools, such as:

  	perf record -e probe:vfs_getname -aR sleep 1

       2.237 ( 0.012 ms): touch/30855 open(filename: /tmp/temporary_file.kmoWQ, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
  test child finished with 0
  ---- end ----
  Check open filename arg using perf trace + vfs_getname: Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-j02nobfvvn9c7yrphdsnbqx0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace+probe_vfs_getname.sh

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
new file mode 100755
index 000000000000..d0fba0c5e354
--- /dev/null
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -0,0 +1,31 @@
+# Check open filename arg using perf trace + vfs_getname
+
+# Uses the 'perf test shell' library to add probe:vfs_getname to the system
+# then use it with 'perf trace' using 'touch' to write to a temp file, then
+# checks that that was captured by the vfs_getname was used by 'perf trace',
+# that already handles "probe:vfs_getname" if present, and used in the
+# "open" syscall "filename" argument beautifier.
+
+# Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
+
+. $(dirname $0)/lib/probe_vfs_getname.sh
+
+file=$(mktemp /tmp/temporary_file.XXXXX)
+
+trace_open_vfs_getname() {
+	perf trace -e open touch $file 2>&1 | \
+	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open\(filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
+}
+
+
+add_probe_vfs_getname || skip_if_no_debuginfo
+err=$?
+if [ $err -ne 0 ] ; then
+	exit $err
+fi
+
+trace_open_vfs_getname
+err=$?
+rm -f ${file}
+cleanup_probe_vfs_getname
+exit $err
-- 
2.13.4
