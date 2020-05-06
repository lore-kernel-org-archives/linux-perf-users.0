From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/91] perf test session topology: Fix data path
Date: Wed,  6 May 2020 12:21:10 -0300
Message-ID: <20200506152234.21977-8-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tommi Rantala <tommi.t.rantala@nokia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

Commit 2d4f27999b88 ("perf data: Add global path holder") missed path
conversion in tests/topology.c, causing the "Session topology" testcase
to "hang" (waits forever for input from stdin) when doing "ssh $VM perf
test".

Can be reproduced by running "cat | perf test topo", and crashed by
replacing cat with true:

  $ true | perf test -v topo
  40: Session topology                                      :
  --- start ---
  test child forked, pid 3638
  templ file: /tmp/perf-test-QPvAch
  incompatible file format
  incompatible file format (rerun with -v to learn more)
  free(): invalid pointer
  test child interrupted
  ---- end ----
  Session topology: FAILED!

Committer testing:

Reproduced the above result before the patch and after it is back
working:

  # true | perf test -v topo
  41: Session topology                                      :
  --- start ---
  test child forked, pid 19374
  templ file: /tmp/perf-test-YOTEQg
  CPU 0, core 0, socket 0
  CPU 1, core 1, socket 0
  CPU 2, core 2, socket 0
  CPU 3, core 3, socket 0
  CPU 4, core 0, socket 0
  CPU 5, core 1, socket 0
  CPU 6, core 2, socket 0
  CPU 7, core 3, socket 0
  test child finished with 0
  ---- end ----
  Session topology: Ok
  #

Fixes: 2d4f27999b88 ("perf data: Add global path holder")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200423115341.562782-1-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/topology.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 4a800499d7c3..22daf2bdf5fa 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -33,10 +33,8 @@ static int session_write_header(char *path)
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file      = {
-			.path = path,
-		},
-		.mode      = PERF_DATA_MODE_WRITE,
+		.path = path,
+		.mode = PERF_DATA_MODE_WRITE,
 	};
 
 	session = perf_session__new(&data, false, NULL);
@@ -63,10 +61,8 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file      = {
-			.path = path,
-		},
-		.mode      = PERF_DATA_MODE_READ,
+		.path = path,
+		.mode = PERF_DATA_MODE_READ,
 	};
 	int i;
 
-- 
2.21.1
