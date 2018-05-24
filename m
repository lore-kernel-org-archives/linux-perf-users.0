From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test 39 (Session topology) dumps core on s390
Date: Thu, 24 May 2018 15:56:00 +0200
Message-ID: <20180524135600.77128-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

perf test 39 fails with core dump on s390. The root cause
is a NULL pointer reference in function check_cpu_topology()
line 76 (or line 82 without -v).
The session->header.env.cpu variable is NULL because on s390
function process_cpu_topology() returns with error:
    socket_id number is too big.
    You may need to upgrade the perf tool.
and releases the env.cpu variable via zfree() and sets it to NULL.

Here is the gdb output:
(gdb) n
76                      pr_debug("CPU %d, core %d, socket %d\n", i,
(gdb) n

Program received signal SIGSEGV, Segmentation fault.
0x00000000010f4d9e in check_cpu_topology (path=0x3ffffffd6c8
	"/tmp/perf-test-J6CHMa", map=0x14a1740) at tests/topology.c:76
76  pr_debug("CPU %d, core %d, socket %d\n", i,
(gdb)

Make sure the env.cpu variable is not used when its NULL.
Test for NULL pointer and return TEST_SKIP if so.

Output before:
[root@p23lp27 perf]# ./perf test -F 39
39: Session topology  :Segmentation fault (core dumped)
[root@p23lp27 perf]#

Output after:
[root@p23lp27 perf]# ./perf test -vF 39
39: Session topology                                      :
--- start ---
templ file: /tmp/perf-test-Ajx59D
socket_id number is too big.You may need to upgrade the perf tool.
---- end ----
Session topology: Skip
[root@p23lp27 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/tests/topology.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 17cb1bb3448c..5f366d650d2b 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -70,6 +70,9 @@ static int check_cpu_topology(char *path, struct cpu_map *map)
 	session = perf_session__new(&data, false, NULL);
 	TEST_ASSERT_VAL("can't get session", session);
 
+	if (!session->header.env.cpu)
+		return TEST_SKIP;
+
 	for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
 		if (!cpu_map__has(map, i))
 			continue;
@@ -95,7 +98,7 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
 {
 	char path[PATH_MAX];
 	struct cpu_map *map;
-	int ret = -1;
+	int ret;
 
 	TEST_ASSERT_VAL("can't get templ file", !get_temp(path));
 
@@ -110,12 +113,9 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
 		goto free_path;
 	}
 
-	if (check_cpu_topology(path, map))
-		goto free_map;
-	ret = 0;
-
-free_map:
+	ret = check_cpu_topology(path, map);
 	cpu_map__put(map);
+
 free_path:
 	unlink(path);
 	return ret;
-- 
2.14.3
