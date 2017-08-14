From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/19] perf tools: Add missing newline to expr parser error messages
Date: Mon, 14 Aug 2017 13:27:27 -0300
Message-ID: <20170814162741.6101-6-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170724234015.5165-6-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 954556bea36e..953e65ba2cc7 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -62,7 +62,7 @@ all_expr: expr			{ *final_val = $1; }
 
 expr:	  NUMBER
 	| ID			{ if (lookup_id(ctx, $1, &$$) < 0) {
-					pr_debug("%s not found", $1);
+					pr_debug("%s not found\n", $1);
 					YYABORT;
 				  }
 				}
-- 
2.13.4
