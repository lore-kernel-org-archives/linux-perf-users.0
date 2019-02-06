From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/53] perf tests: Add missing headers so far obtained indirectly
Date: Wed,  6 Feb 2019 15:48:18 -0300
Message-ID: <20190206184903.24054-9-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We're going to remove symbol.h from some places and this breaks
some of the perf tests, fix it by adding the required includes.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wpa4b6x0btpnh2kjxzl9no4w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sample-parsing.c | 2 ++
 tools/perf/tests/sdt.c            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 0e2d00d69e6e..236ce0d6c826 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdbool.h>
 #include <inttypes.h>
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 
+#include "branch.h"
 #include "util.h"
 #include "event.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 5059452d27dd..8bfaa630389c 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <sys/epoll.h>
 #include <util/evlist.h>
+#include <util/symbol.h>
 #include <linux/filter.h>
 #include "tests.h"
 #include "debug.h"
-- 
2.20.1
