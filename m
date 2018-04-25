From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/12] perf record: Fix s390 undefined record__auxtrace_init() return value
Date: Wed, 25 Apr 2018 13:00:04 -0300
Message-ID: <20180425160008.3407-9-acme@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425160008.3407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Command 'perf record' calls:

  cmd_report()
    record__auxtrace_init()
       auxtrace_record__init()

On s390 function auxtrace_record__init() returns random return value due
to missing initialization.

This sometime causes 'perf record' to exit immediately without error
message and creating a perf.data file.

Fix this by setting error the return code to zero before returning from
platform specific functions which may not set the error code in call
cases.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180423142940.21143-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
