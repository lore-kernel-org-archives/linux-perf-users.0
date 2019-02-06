From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/53] perf thread: Don't include symbol.h, symbol_conf.h is enough
Date: Wed,  6 Feb 2019 15:48:22 -0300
Message-ID: <20190206184903.24054-13-acme@kernel.org>
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

Also add stdio.h to get the FILE definition.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8vx5396phynuxhdsxxfbdhsk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 856cf1a9040a..8276ffeec556 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -5,14 +5,17 @@
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
 #include <linux/list.h>
+#include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
 #include "srccode.h"
-#include "symbol.h"
+#include "symbol_conf.h"
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
 
+struct addr_location;
+struct map;
 struct namespaces_event;
 struct thread_stack;
 struct unwind_libunwind_ops;
-- 
2.20.1
