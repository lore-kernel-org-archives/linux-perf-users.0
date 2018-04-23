From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf record: Fix s390 random record__auxtrace_init return value
Date: Mon, 23 Apr 2018 16:29:40 +0200
Message-ID: <20180423142940.21143-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Command perf record calls
cmd_report
+---> record__auxtrace_init
      +---> auxtrace_record__init()

On s390 function auxtrace_record__init() returns random return
value due to missing initialization.
This sometime causes perf record to exit immediately without
error message and creating a perf.data file.

Fix this by setting error return code to zero before return
from platform specific function which does not set the
error code in call cases.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/arch/s390/util/auxtrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 6cb48e4cffd9..3afe8256eff2 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -87,6 +87,7 @@ struct auxtrace_record *auxtrace_record__init(struct perf_evlist *evlist,
 	struct perf_evsel *pos;
 	int diagnose = 0;
 
+	*err = 0;
 	if (evlist->nr_entries == 0)
 		return NULL;
 
-- 
2.14.3
