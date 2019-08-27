From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/33] perf stat: Remove needless headers from stat.h
Date: Mon, 26 Aug 2019 22:36:03 -0300
Message-ID: <20190827013634.3173-3-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just a forward declaration for 'struct timespec' is needed, ditch the
rest.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6shdqw801oqe7ax6r307k27r@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index bcb376e1b3a7..9e425ecd82d9 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -5,13 +5,12 @@
 #include <linux/types.h>
 #include <stdio.h>
 #include <sys/types.h>
-#include <sys/time.h>
 #include <sys/resource.h>
-#include <sys/wait.h>
 #include "rblist.h"
-#include "perf.h"
 #include "event.h"
 
+struct timespec;
+
 struct stats {
 	double n, mean, M2;
 	u64 max, min;
-- 
2.21.0
