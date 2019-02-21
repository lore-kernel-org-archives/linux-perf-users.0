From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/17] perf tests shell: Skip trace+probe_vfs_getname.sh if built without trace support
Date: Wed, 20 Feb 2019 22:25:33 -0300
Message-ID: <20190221012549.4069-2-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tommi Rantala <tommi.t.rantala@nokia.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

If perf was built without trace support, the trace+probe_vfs_getname.sh
'perf test' entry fails:

  # perf trace -h
  perf: 'trace' is not a perf-command. See 'perf --help'

  # perf test 64
  64: Check open filename arg using perf trace + vfs_getname: FAILED!

Check trace support, so that we'll skip the test in that case:

  # perf test 64
  64: Check open filename arg using perf trace + vfs_getname: Skip

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190215134253.11454-1-tt.rantala@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe.sh               | 5 +++++
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/lib/probe.sh b/tools/perf/tests/shell/lib/probe.sh
index 6293cc660947..e37787be672b 100644
--- a/tools/perf/tests/shell/lib/probe.sh
+++ b/tools/perf/tests/shell/lib/probe.sh
@@ -4,3 +4,8 @@ skip_if_no_perf_probe() {
 	perf probe 2>&1 | grep -q 'is not a perf-command' && return 2
 	return 0
 }
+
+skip_if_no_perf_trace() {
+	perf trace -h 2>&1 | grep -q -e 'is not a perf-command' -e 'trace command not available' && return 2
+	return 0
+}
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 50109f27ca07..147efeb6b195 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -12,6 +12,7 @@
 . $(dirname $0)/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
+skip_if_no_perf_trace || exit 2
 
 . $(dirname $0)/lib/probe_vfs_getname.sh
 
-- 
2.19.1
