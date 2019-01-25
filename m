From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/29] perf callchain: No need to include perf.h
Date: Sat, 26 Jan 2019 00:18:23 +0100
Message-ID: <20190125231843.2895-10-acme@kernel.org>
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

So ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bodhwdvcds9ahk26dy4w8m71@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 99d38ac019b8..8afe1622edf3 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -2,7 +2,6 @@
 #ifndef __PERF_CALLCHAIN_H
 #define __PERF_CALLCHAIN_H
 
-#include "../perf.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include "event.h"
-- 
2.20.1
