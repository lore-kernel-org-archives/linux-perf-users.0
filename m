From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/24] perf namespaces: Add more appropriate set of headers
Date: Mon, 23 Oct 2017 20:47:35 -0300
Message-ID: <20171023234736.5335-24-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We don't need perf.h, that is a kitchen sink, all we need is
perf_events.h for perf_ns_link_info, sys/types.h for pid_t and
linux/types.h for u64, list_head.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-f2uxyaj4s2hmntkrezpa6dqz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/namespaces.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 05d82601c9a6..760558dcfd18 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -9,9 +9,10 @@
 #ifndef __PERF_NAMESPACES_H
 #define __PERF_NAMESPACES_H
 
-#include "../perf.h"
-#include <linux/list.h>
+#include <sys/types.h>
+#include <linux/perf_event.h>
 #include <linux/refcount.h>
+#include <linux/types.h>
 
 struct namespaces_event;
 
-- 
2.13.6
