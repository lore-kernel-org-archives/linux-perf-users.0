From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/53] perf hist: Remove the needless callchain.h include from hist.h
Date: Wed,  6 Feb 2019 15:48:24 -0300
Message-ID: <20190206184903.24054-15-acme@kernel.org>
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

Nothing that is provided by callchain.h is used there, just things that
should've be directly included in hist.h, such as rbtree.h and a
map_symbol forward declaration.

Remove it so that we reduce the headers dependency tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zivvqfx93w5zzur7hr7h0nlh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 38a72eb81427..6b872079ead5 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -2,9 +2,9 @@
 #ifndef __PERF_HIST_H
 #define __PERF_HIST_H
 
+#include <linux/rbtree.h>
 #include <linux/types.h>
 #include <pthread.h>
-#include "callchain.h"
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
@@ -13,6 +13,7 @@
 struct hist_entry;
 struct hist_entry_ops;
 struct addr_location;
+struct map_symbol;
 struct mem_info;
 struct branch_info;
 struct symbol;
-- 
2.20.1
