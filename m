From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/24] perf vendor events s390: Use s390 machine name instead of type 8561
Date: Tue,  1 Oct 2019 08:12:03 -0300
Message-ID: <20191001111216.7208-12-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

In the pmu-events directory for JSON file definitions use the
official machine name IBM z15 instead of machine type number
8561. This is consistent with previous machines.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20190927081147.18345-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/basic.json | 0
 .../perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto.json  | 0
 .../perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto6.json | 0
 .../pmu-events/arch/s390/{cf_m8561 => cf_z15}/extended.json     | 0
 .../pmu-events/arch/s390/{cf_m8561 => cf_z15}/transaction.json  | 0
 tools/perf/pmu-events/arch/s390/mapfile.csv                     | 2 +-
 6 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/basic.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto6.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/extended.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/transaction.json (100%)

diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/basic.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/extended.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index bd3fc577139c..61641a3480e0 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -4,4 +4,4 @@ Family-model,Version,Filename,EventType
 ^IBM.282[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_zec12,core
 ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
 ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
-^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_m8561,core
+^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
-- 
2.21.0
