From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/29] perf tools: Move branch structs to branch.h
Date: Sat, 26 Jan 2019 00:18:17 +0100
Message-ID: <20190125231843.2895-4-acme@kernel.org>
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

We already have it, move those there from events.h so that we untangle
the header dependencies a bit more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pnbkqo8jxbi49d4f3yd3b5w3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/branch.h | 27 ++++++++++++++++++++++++---
 tools/perf/util/event.h  | 21 +--------------------
 tools/perf/util/symbol.h |  1 +
 3 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 1e3c7c5cdc63..64f96b79f1d7 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -1,8 +1,31 @@
 #ifndef _PERF_BRANCH_H
 #define _PERF_BRANCH_H 1
 
+#include <stdio.h>
 #include <stdint.h>
-#include "../perf.h"
+#include <linux/perf_event.h>
+#include <linux/types.h>
+
+struct branch_flags {
+	u64 mispred:1;
+	u64 predicted:1;
+	u64 in_tx:1;
+	u64 abort:1;
+	u64 cycles:16;
+	u64 type:4;
+	u64 reserved:40;
+};
+
+struct branch_entry {
+	u64			from;
+	u64			to;
+	struct branch_flags	flags;
+};
+
+struct branch_stack {
+	u64			nr;
+	struct branch_entry	entries[0];
+};
 
 struct branch_type_stat {
 	bool	branch_to;
@@ -13,8 +36,6 @@ struct branch_type_stat {
 	u64	cross_2m;
 };
 
-struct branch_flags;
-
 void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
 		       u64 from, u64 to);
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index dad32b81fe71..feba1aa819b4 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -161,26 +161,7 @@ struct ip_callchain {
 	u64 ips[0];
 };
 
-struct branch_flags {
-	u64 mispred:1;
-	u64 predicted:1;
-	u64 in_tx:1;
-	u64 abort:1;
-	u64 cycles:16;
-	u64 type:4;
-	u64 reserved:40;
-};
-
-struct branch_entry {
-	u64			from;
-	u64			to;
-	struct branch_flags	flags;
-};
-
-struct branch_stack {
-	u64			nr;
-	struct branch_entry	entries[0];
-};
+struct branch_stack;
 
 enum {
 	PERF_IP_FLAG_BRANCH		= 1ULL << 0,
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 277841e3dbd1..956d9916e364 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <byteswap.h>
 #include <libgen.h>
+#include "branch.h"
 #include "build-id.h"
 #include "event.h"
 #include "path.h"
-- 
2.20.1
