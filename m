From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/29] perf comm: Remove needless headers from comm.h
Date: Sat, 26 Jan 2019 00:18:22 +0100
Message-ID: <20190125231843.2895-9-acme@kernel.org>
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

There we don't need rbtree, only in comm.c, also ditch perf.h, not
needed at all.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vr1jnwwujh99skrgldtimpmu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/comm.c | 1 +
 tools/perf/util/comm.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 31279a7bd919..1066de92af12 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <linux/refcount.h>
+#include <linux/rbtree.h>
 #include "rwsem.h"
 
 struct comm_str {
diff --git a/tools/perf/util/comm.h b/tools/perf/util/comm.h
index 3e5c438fe85e..f35d8fbfa2dd 100644
--- a/tools/perf/util/comm.h
+++ b/tools/perf/util/comm.h
@@ -2,9 +2,9 @@
 #ifndef __PERF_COMM_H
 #define __PERF_COMM_H
 
-#include "../perf.h"
-#include <linux/rbtree.h>
 #include <linux/list.h>
+#include <linux/types.h>
+#include <stdbool.h>
 
 struct comm_str;
 
-- 
2.20.1
