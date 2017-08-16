From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/10] perf test shell vfs_getname: Skip for tools built with NO_LIBDWARF=1
Date: Wed, 16 Aug 2017 17:20:43 -0300
Message-ID: <20170816202050.8865-4-acme@kernel.org>
References: <20170816202050.8865-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816202050.8865-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If that is the case, or if the required lib is not present, e.g.
elfutils-devel in Fedora systems, then just skip the tests requiring
DWARF analysis.

Before:

  # rpm -e elfutils-devel
  # perf test ping vfs_getname
  60: Use vfs_getname probe to get syscall args filenames   : FAILED!
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: FAILED!
  63: Add vfs_getname probe to get syscall args filenames   : FAILED!
  #

After:

  # perf test vfs_getname
  60: Use vfs_getname probe to get syscall args filenames   : Skip
  62: Check open filename arg using perf trace + vfs_getname: Skip
  63: Add vfs_getname probe to get syscall args filenames   : Skip
  #

Then, reinstalling elfutils-devel, rebuilding the tool and running
again:

  # perf test vfs_getname
  60: Use vfs_getname probe to get syscall args filenames   : Ok
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
Link: http://lkml.kernel.org/n/tip-d67tvn401fxrwr97pu5ihfb1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 46c1bb707600..f832395daad7 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -12,12 +12,12 @@ cleanup_probe_vfs_getname() {
 add_probe_vfs_getname() {
 	local verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
-               line=$(perf probe -L getname_flags | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
-               perf probe $verbose "vfs_getname=getname_flags:${line} pathname=result->name:string"
+		line=$(perf probe -L getname_flags |& egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
+		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=result->name:string"
 	fi
 }
 
 skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2>&1 | grep -q "^Failed to find the path for kernel" && return 2
+	add_probe_vfs_getname -v 2>&1 | egrep -q "^(Failed to find the path for kernel|Debuginfo-analysis is not supported)" && return 2
 	return 1
 }
-- 
2.13.5
