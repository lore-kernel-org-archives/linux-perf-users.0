From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/53] perf bpf-loader: Remove unecessary includes from bpf-loader.h
Date: Wed,  6 Feb 2019 15:48:29 -0300
Message-ID: <20190206184903.24054-20-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To cut the header dep tree, to get unecessary object rebuilds to be
reduced when a change happens in headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ph72xhl9moqa0g1hxcyudwfn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 1 +
 tools/perf/util/bpf-loader.h | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 2f3eb6d293ee..6e68698aa0ad 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include "perf.h"
 #include "debug.h"
+#include "evlist.h"
 #include "bpf-loader.h"
 #include "bpf-prologue.h"
 #include "probe-event.h"
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 62d245a90e1d..3f46856e3330 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -8,11 +8,7 @@
 
 #include <linux/compiler.h>
 #include <linux/err.h>
-#include <string.h>
 #include <bpf/libbpf.h>
-#include "probe-event.h"
-#include "evlist.h"
-#include "debug.h"
 
 enum bpf_loader_errno {
 	__BPF_LOADER_ERRNO__START = __LIBBPF_ERRNO__START - 100,
@@ -44,6 +40,7 @@ enum bpf_loader_errno {
 };
 
 struct perf_evsel;
+struct perf_evlist;
 struct bpf_object;
 struct parse_events_term;
 #define PERF_BPF_PROBE_GROUP "perf_bpf_probe"
@@ -87,6 +84,8 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 int bpf__strerror_setup_output_event(struct perf_evlist *evlist, int err, char *buf, size_t size);
 #else
 #include <errno.h>
+#include <string.h>
+#include "debug.h"
 
 static inline struct bpf_object *
 bpf__prepare_load(const char *filename __maybe_unused,
-- 
2.20.1
