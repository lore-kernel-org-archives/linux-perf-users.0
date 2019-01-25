From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/29] perf block-range: Add missing headers
Date: Sat, 26 Jan 2019 00:18:18 +0100
Message-ID: <20190125231843.2895-5-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Some are being obtained indirectly and as we prune unnecessary includes,
this stops working, fix it by adding the headers for things used in
these file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1p65lyeebc2ose0lbozvemda@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/block-range.c | 2 ++
 tools/perf/util/block-range.h | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
index f1451c987eec..1be432657501 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "block-range.h"
 #include "annotate.h"
+#include <assert.h>
+#include <stdlib.h>
 
 struct {
 	struct rb_root root;
diff --git a/tools/perf/util/block-range.h b/tools/perf/util/block-range.h
index a5ba719d69fb..ec0fb534bf56 100644
--- a/tools/perf/util/block-range.h
+++ b/tools/perf/util/block-range.h
@@ -2,7 +2,11 @@
 #ifndef __PERF_BLOCK_RANGE_H
 #define __PERF_BLOCK_RANGE_H
 
-#include "symbol.h"
+#include <stdbool.h>
+#include <linux/rbtree.h>
+#include <linux/types.h>
+
+struct symbol;
 
 /*
  * struct block_range - non-overlapping parts of basic blocks
-- 
2.20.1
