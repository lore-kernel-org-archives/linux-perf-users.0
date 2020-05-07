From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: [PATCH 1/2] perf: Fix POWER9 metric 'lsu_other_stall_cpi'
Date: Thu,  7 May 2020 11:28:57 -0500
Message-ID: <1588868938-21933-2-git-send-email-pc@us.ibm.com>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, mpe@ellerman.id.au, irogers@google.com
List-Id: linux-perf-users.vger.kernel.org

From: "Paul A. Clarke" <pc@us.ibm.com>

The metric definition is too long for the current value of EXPR_MAX_OTHER.
Increase the value EXPR_MAX_OTHER sufficiently to allow
'lsu_other_stall_cpi' to build properly.

Before:
--
$ perf list | grep lsu_other
  lsu_other_stall_cpi
# perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
Cannot find metric or group `lsu_other_stall_cpi'

 Usage: perf stat [<options>] [<command>]

    -M, --metrics <metric/metric group list>
                          monitor specified metrics or metric groups (separated by ,)
--

After:
--
# perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1

 Performance counter stats for 'system wide':

       438,086,889      pm_cmplu_stall_lsu        #     1.74 lsu_other_stall_cpi
[...]
--

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 tools/perf/util/expr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 87d627bb699b..a0991959cca4 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,7 +2,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-#define EXPR_MAX_OTHER 20
+#define EXPR_MAX_OTHER 28
 #define MAX_PARSE_ID EXPR_MAX_OTHER
 
 struct expr_parse_id {
-- 
2.18.2
