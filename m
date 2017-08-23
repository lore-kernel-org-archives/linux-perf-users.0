From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/15] perf tools: Increase maximum number of events in expressions
Date: Wed, 23 Aug 2017 16:36:05 -0300
Message-ID: <20170823193614.20394-7-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Some of the upcoming metrics need more than 8 events. Increase the maximum
number the parser supports.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170811232634.30465-9-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 9c2760a1a96e..400ef9eab00a 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -1,7 +1,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-#define EXPR_MAX_OTHER 8
+#define EXPR_MAX_OTHER 15
 #define MAX_PARSE_ID EXPR_MAX_OTHER
 
 struct parse_id {
-- 
2.13.5
