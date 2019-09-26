From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 66/66] perf parser: Remove needless include directives
Date: Wed, 25 Sep 2019 21:32:44 -0300
Message-ID: <20190926003244.13962-67-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

They go on accumulating there like the debug.h one, that was introduced
here:

  f23610245c1a ("perf list: Add debug support for outputing alias string")

But then, when that need is removed via:

  2073ad3326b7 ("perf tools: Factor out PMU matching in parser")

The thing stays there, so continue the house cleaning spree...

list.h not needed, no macros from there are used, and 'struct
list_head' is in linux/types.h, ditto for util.h, no need for that as
well.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zkxr3mf6inun8m5mbnil4u0d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 65809ad67808..48126ae4cd13 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -11,12 +11,9 @@
 #include <fnmatch.h>
 #include <stdio.h>
 #include <linux/compiler.h>
-#include <linux/list.h>
 #include <linux/types.h>
-#include "util.h"
 #include "pmu.h"
 #include "evsel.h"
-#include "debug.h"
 #include "parse-events.h"
 #include "parse-events-bison.h"
 
-- 
2.21.0
