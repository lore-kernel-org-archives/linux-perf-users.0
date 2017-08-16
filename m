From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/10] perf test shell: Check if 'perf probe' is available, skip tests if not
Date: Wed, 16 Aug 2017 17:20:42 -0300
Message-ID: <20170816202050.8865-3-acme@kernel.org>
References: <20170816202050.8865-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816202050.8865-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add a library function that checks if 'perf probe' is built into the
tool being tested, skipping tests that need it.

Testing it on a system after removing the library needed to build
'probe' as a perf subcommand:

  # perf test ping vfs_getname
  59: Use vfs_getname probe to get syscall args filenames   : Skip
  60: probe libc's inet_pton & backtrace it with ping       : Skip
  61: Check open filename arg using perf trace + vfs_getname: Skip
  62: Add vfs_getname probe to get syscall args filenames   : Skip
  # perf probe
  perf: 'probe' is not a perf-command. See 'perf --help'.
  #

Now reinstalling elfutils-libelf-devel on this Fedora 26 system to
rebuild perf and then retest this:

  # perf test ping vfs_getname
  60: Use vfs_getname probe to get syscall args filenames   : Ok
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: Add vfs_getname probe to get syscall args filenames   : Ok
  #

Reported-by: Kim Phillips <kim.phillips@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-ctdck2gzsskqhjzu3ebb62zm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe.sh                       | 6 ++++++
 tools/perf/tests/shell/lib/probe_vfs_getname.sh           | 2 +-
 tools/perf/tests/shell/probe_vfs_getname.sh               | 4 ++++
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 4 ++++
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh      | 3 +++
 tools/perf/tests/shell/trace+probe_vfs_getname.sh         | 4 ++++
 6 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/shell/lib/probe.sh

diff --git a/tools/perf/tests/shell/lib/probe.sh b/tools/perf/tests/shell/lib/probe.sh
new file mode 100644
index 000000000000..61da3b2c9bca
--- /dev/null
+++ b/tools/perf/tests/shell/lib/probe.sh
@@ -0,0 +1,6 @@
+# Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
+
+skip_if_no_perf_probe() {
+	perf probe |& grep -q 'is not a perf-command' && return 2
+	return 0
+}
diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 3eaddf190a30..46c1bb707600 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -1,6 +1,6 @@
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-perf probe -l | grep -q probe:vfs_getname
+perf probe -l |& grep -q probe:vfs_getname
 had_vfs_getname=$?
 
 cleanup_probe_vfs_getname() {
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index c8380137beef..9b7635184dc2 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -2,6 +2,10 @@
 #
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
+. $(dirname $0)/lib/probe.sh
+
+skip_if_no_perf_probe || exit 2
+
 . $(dirname $0)/lib/probe_vfs_getname.sh
 
 add_probe_vfs_getname || skip_if_no_debuginfo
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 2725c5db699a..ba29535b8580 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -7,6 +7,10 @@
 
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
+. $(dirname $0)/lib/probe.sh
+
+skip_if_no_perf_probe || exit 2
+
 . $(dirname $0)/lib/probe_vfs_getname.sh
 
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index 1b9a276e2ace..99dafad61954 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -8,6 +8,8 @@
 
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
+. $(dirname $0)/lib/probe.sh
+
 trace_libc_inet_pton_backtrace() {
 	idx=0
 	expected[0]="PING.*bytes"
@@ -32,6 +34,7 @@ trace_libc_inet_pton_backtrace() {
 	done
 }
 
+skip_if_no_perf_probe && \
 perf probe -q /lib64/libc-*.so inet_pton && \
 trace_libc_inet_pton_backtrace
 err=$?
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index d0fba0c5e354..2e68c5f120da 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -8,6 +8,10 @@
 
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
+. $(dirname $0)/lib/probe.sh
+
+skip_if_no_perf_probe || exit 2
+
 . $(dirname $0)/lib/probe_vfs_getname.sh
 
 file=$(mktemp /tmp/temporary_file.XXXXX)
-- 
2.13.5
