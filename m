From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2] perf test: Fix test 39 Session topology for s390
Date: Mon, 11 Jun 2018 09:31:53 +0200
Message-ID: <20180611073153.15592-2-tmricht@linux.ibm.com>
References: <20180611073153.15592-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611073153.15592-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On s390 this test case fails because the socket identifiction numbers
assigned to the CPU are higher than the CPU identification numbers.

Fix this by adding the platform architecture into the perf data header
flag information. This helps identifiing the test platform and handles
s390 specifics in process_cpu_topology().

Output before:
[root@p23lp27 perf]# ./perf test -vvvvv -F 39
39: Session topology                                      :
--- start ---
templ file: /tmp/perf-test-iUv755
socket_id number is too big.You may need to upgrade the perf tool.
---- end ----
Session topology: Skip
[root@p23lp27 perf]#

Output after:
[root@p23lp27 perf]# ./perf test -vvvvv -F 39
39: Session topology                                      :
--- start ---
templ file: /tmp/perf-test-8X8VTs
CPU 0, core 0, socket 6
CPU 1, core 1, socket 3
---- end ----
Session topology: Ok
[root@p23lp27 perf]#

Fixes: c84974ed9fb6 ("perf test: Add entry to test cpu topology")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/tests/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 40e30a26b23c..9497d02f69e6 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -45,6 +45,7 @@ static int session_write_header(char *path)
 
 	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
 	perf_header__set_feat(&session->header, HEADER_NRCPUS);
+	perf_header__set_feat(&session->header, HEADER_ARCH);
 
 	session->header.data_size += DATA_SIZE;
 
-- 
2.14.3
